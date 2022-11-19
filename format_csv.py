import csv
import re
import sys

if __name__=='__main__':
	saveHistory = {}
	saveHistoryPath = '/data/archivebox_reddit_save_history.txt'
	try:
		with open(saveHistoryPath, mode='r') as saveHistoryFile:
			saveHistory = set(line for line in saveHistoryFile.readlines())
	except FileNotFoundError:
		pass
	with open(sys.argv[1], mode='r') as exportFile:
		csvIter = csv.reader(exportFile)
		next(csvIter)
		libreddit = lambda y: re.sub('www.reddit.com', 'libreddit.spike.codes', y, count=1)
		eligibleSaves = [libreddit(x[0])+'?context=9999' for x in csvIter if len(x) > 0 and not libreddit(x[0]) in saveHistory]
		with open(saveHistoryPath, mode='a') as saveHistoryFile:
			if any(eligibleSaves):
				for y in eligibleSaves:
					print(y)
					saveHistoryFile.write('\n'+y)