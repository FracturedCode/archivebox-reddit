# archivebox-reddit
archivebox-reddit is a tool to automatically backup your reddit comments, posts, upvotes and/or saved posts/comments to [ArchiveBox](https://github.com/ArchiveBox/ArchiveBox).

## Why?
- Reddit only keeps your last ~1000 saved posts. Imagine all those dank memes you have been losing without realizing until just now
- Reddit posts often get removed or deleted for various reasons
- Your account could be removed or you could lose access
- Reddit could shut down
- Reddit may in the future decide to start deleting old posts to save storage

Anything anyone puts onto the internet lasts forever, but only if people are actually putting in the work to archive that data.

## How?
This works by executing a daily cron job which:
1. Fetches your posts/saved posts from reddit with [export-saved-reddit](https://github.com/csu/export-saved-reddit)
2. Converts the fetched URL list to [libreddit](https://github.com/spikecodes/libreddit) URLs to avoid rate limiting
3. Prunes the list to those it has not scraped before
4. Stuffs the list into `archivebox add`, and tags it the type of save ("reddit-saved", "reddit-comments", "reddit-submissions", "reddit-upvoted") (more tagging configurations available)

## Installation
Currently, only deploying via docker (+docker on WSL) is supported, but more configurations and use-cases are being worked on.

First, configure your install:
``` Bash
git clone https://github.com/FracturedCode/archivebox-reddit.git
cd archivebox-reddit
cp .env.example .env
"${EDITOR:-nano}" .env
cd docker
cp .env.example .env
"${EDITOR:-nano}" .env
```

You must [acquire an api key](https://github.com/csu/export-saved-reddit#usage) from reddit, and enter your credentials in the `.env` file. Be sure to set good permissions on this file; it contains your reddit info! If you need, you can edit how this file is mounted in `run.sh` Additionally, you will have to disable two factor. I am working on changing this.

Build and run the docker image. It may take a while to download. (This project is tiny, but ArchiveBox is a 1.7GB image.):
``` Bash
./build.sh
./run.sh
```

## Update
``` Bash
./update.sh # in docker/
```

## Loose Roadmap
- Add support for more use-cases, ie non-docker installation, different archive directories, and other parameters
- Enable media playback in SingleFile (saves you a click + allows comment reading while playback)
- Fix some edge cases where media doesn't get saved (ie removed images still present in libreddit or gifs)
- Make disabling 2FA unnecessary, probably will have to fork `export-saved-reddit`
- Pipe dream: a mobile-friendly web UI in ArchiveBox that allows you to swipe between scrapes
- Fix media download hanging randomly
- Multi account support

## Donate
Did I save you some time or give you some piece of mind?

XMR: 833jERVqZJBbVs1FS5f7R5Z4ufhsQXUcb6rHqfKoMuDG8HsxKrsKdEsdaf7aih9AeGfS7XRT7xEoPAFP2LNoYZMFLs3TJ4b
![XMR QR Code](https://fracturedcode.net/assets/contact/xmrQr.png)

More options [here](https://fracturedcode.net/contact)
Or you could donate your time by submitting PRs or Issues.

## License
[GPLv3](https://github.com/FracturedCode/archivebox-reddit/blob/master/LICENSE)

ArchiveBox is MIT licensed.

Unless stated otherwise in the respective files and with explicit exception of the git submodules, the scripts in this repository are GPLv3 licensed. Therefore, if you modify these files or derive new works, and subsequently distribute them, please make the source code readily available under GPLv3.