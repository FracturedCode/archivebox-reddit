import csv
import re
import sys

if __name__=='__main__':
	saveHistory = {}
	saveHistoryPath = '/data/archivebox_reddit_save_history.txt'
	stripDomain = lambda y: re.sub("^https:\/\/.*\/", "", y)
	try:
		with open(saveHistoryPath, mode='r') as saveHistoryFile:
			saveHistory = set(stripDomain(line) for line in saveHistoryFile.readlines())
	except FileNotFoundError:
		pass
	with open(sys.argv[1], mode='r') as exportFile:
		csvIter = csv.reader(exportFile)
		next(csvIter)
		contextParam = '?context=9999'
		libreddit = lambda y: re.sub('^https://www.reddit.com/', 'https://libreddit.spike.codes/', y, count=1) + contextParam
		eligibleSaves = [libreddit(x[0]) for x in csvIter if len(x) > 0 and not stripDomain(x[0] + contextParam) in saveHistory]
		with open(saveHistoryPath, mode='a') as saveHistoryFile:
			if any(eligibleSaves):
				for y in eligibleSaves:
					print(y)
					saveHistoryFile.write('\n'+y)