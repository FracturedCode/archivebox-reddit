import csv
import re

if __name__=='__main__':
	with open('export-saved.csv', mode='r') as file:
		contents = csv.reader(file)
		next(contents)
		for line in contents:
			try:
				print(re.sub('www.reddit.com', 'libredd.it', line[0], count=1))
			except:
				pass