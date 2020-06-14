#~#~#~#~#~#~#~#~#~#~#~#~#
### Fathers' Day 2020 ###
#~#~#~#~#~#~#~#~#~#~#~#~#

#############
## Modules ##
#############
import calendar
from datetime import datetime, date

######################
## Global variables ##
######################
global now
now = datetime.now()

#############
## Classes ##
#############
class Child:
	def __init__(self, dob, name):
		self.dob  = dob
		self.name = name

	def get_name(self):
		return self.name

	def get_dob(self):
		return self.dob

class FathersDayCalculatororor:
	def __init__(self, *children):
		self.children = children

	def get_oldest(self):
		oldest = self.children[0]
		for c in self.children:
			if c.get_dob() < oldest.get_dob():
				oldest = c
		return oldest

	def get_FathersDays(self):
		oldestChild = self.get_oldest()
		FathersDayThisYear = self.get_FathersDayThisYear()
		FathersDayThatYear = self.get_FathersDayThatYear(oldestChild.get_dob().year)

		FathersDaysTotal = now.year - oldestChild.get_dob().year
		if FathersDayThatYear >= oldestChild.get_dob():
			FathersDaysTotal += 1
		if FathersDayThisYear >= now.date():
			FathersDaysTotal -= 1
		return FathersDaysTotal

	def get_FathersDayThisYear(self):
		return self.get_FathersDayThatYear(now.year)

	def get_FathersDayThatYear(self, year):
		return date(year, 6, 3*7 - calendar.monthrange(year, 6)[0])

############
## Driver ##
############
child1 = Child(date(1997, 11, 23), "Adam")
child2 = Child(date(2001, 6,  28), "Ben")
child3 = Child(date(2005, 8,  1 ), "Lauren")

calculator = FathersDayCalculatororor(child1, child2, child3)
print("You have had", calculator.get_FathersDays(), "Fathers Days as a father.")