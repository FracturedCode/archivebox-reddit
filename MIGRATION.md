# Migrating reddit frontends
Sometime in the last few months [libredd.it](https://libredd.it) seems to have broken. The problem with that is that I hardcoded some strings and made some general assumptions that relied on that domain. I have made the reddit frontend url configurable in the .env file.

But it causes a major problem if you ever change that value. The script (and independently archivebox) decide not to scrape any urls that have already been scraped. The problem is the list of urls that have been scraped start with the old domain. Therefore, it will try to scrape all the urls returned by Reddit's API (~2000), because it sees these urls as "new." This will likely scrape thousands of posts that have already been downloaded.

As of now I have not created an official or easy way to migrate frontends, but I can show you how to manually migrate. I can also show you how to reverse the damage if you ran into this unfortunate problem like I did.


## Prevention
### 1: Backup your archive volume
Nuf said

### 2: Run the new image
There was a bug that caused the save history file not to be written to, so we need to populate it by running the new image.

`./build.sh && ./run.sh` in `docker/`

Wait for the cron job to kick off or invoke it yourself. This is important; you could cause the "damage" that I was referencing earlier if you don't do it.

### 3: Update your .env file
Change the REDDIT_FRONTEND variable to your liking. Note that `reddit.com` might throttle you or age gate certain posts. To prevent this you would have to provide your own custom cookies file with the necessary auth tokens.

### 4: Update the archivebox-reddit save history
The save history is located in your data volume as `archivebox_reddit_save_history.txt`.

You must do a string replace on the urls from the old domain to the new domain. Any decent text editor can perform this. Here's the regex to save you a few seconds: 

`^https:\/\/<oldDomain>/` Substitution: `https://<newDomain>/`

With recommended domains:
`^https:\/\/libredd.it/` Substitution: `https://libreddit.spike.codes/`


## Damage control
### 1: Backup your archive volume
Nuf said

### 2: Find the duplicates
Run this query against your archivebox database. You can use the `sqlite3` binary to do this, but I prefer [SqliteBrowser](https://sqlitebrowser.org/). Your database file is named `index.sqlite3` in your data volume (configured in `docker/.env`).

``` SQL
SELECT url FROM core_snapshot WHERE url IN (
	SELECT REPLACE(url, '<oldDomain>', '<newDomain>') FROM core_snapshot WHERE url LIKE '<oldDomain>%'
)
```

Try to be as specific as possible with the domains to account for the unlikely edge case that the domain is in another part of a url. Example:

``` SQL
SELECT url FROM core_snapshot WHERE url IN (
	SELECT REPLACE(url, 'https://libredd.it/', 'https://libreddit.spike.codes/') FROM core_snapshot WHERE url LIKE 'https://libredd.it/%'
)
```

Emit these urls to a temporary file via copy/paste, piping, etc.

### 3: Delete the duplicates
You *could* select `timestamp` instead of `url` in the above query. Then, use a script to delete the folders in `archive/` in your archive volume. Finally, delete the relevant rows from the database.

The "safe", archivebox-supported way to do it would be to take the list of urls and run `archivebox remove --yes --delete --filter-type exact <url>` against each url with a for loop in a bash script.

``` Bash
for post in $(cat duplicateUrls.txt)
do
	archivebox remove --yes --delete --filter-type exact $post
done
```