import csv
import re

if __name__=='__main__':
	with open('export-saved.csv', mode='r') as exportFile, open('save_history.txt', mode='ra') as saveHistoryFile:
		saveHistory = set(line for line in saveHistoryFile.readlines())
		csvIter = csv.reader(exportFile)
		next(csvIter)
		libreddit = lambda y: re.sub('www.reddit.com', 'libredd.it', y, count=1)
		eligibleSaves = [libreddit(x[0])+'?context=9999' for x in csvIter if len(x) > 0 and not libreddit(x[0]) in saveHistory]
		if any(eligibleSaves):
			[print(y) for y in eligibleSaves]
			lastSave.write(eligibleSaves)