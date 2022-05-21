import csv
import re

if __name__=='__main__':
	saveHistory = {}
	try:
		with open('save_history.txt', mode='r') as saveHistoryFile:
			saveHistory = set(line for line in saveHistoryFile.readlines())
	except FileNotFoundError:
		pass
	with open('export-saved.csv', mode='r') as exportFile:
		csvIter = csv.reader(exportFile)
		next(csvIter)
		libreddit = lambda y: re.sub('www.reddit.com', 'libredd.it', y, count=1)
		eligibleSaves = [libreddit(x[0])+'?context=9999' for x in csvIter if len(x) > 0 and not libreddit(x[0]) in saveHistory]
		with open('save_history.txt', mode='a') as saveHistoryFile:
			if any(eligibleSaves):
				for y in eligibleSaves:
					print(y)
					saveHistoryFile.write('\n'+y)