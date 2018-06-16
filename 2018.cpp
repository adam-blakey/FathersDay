// LIBRARY INCLUSIONS.
	#include <ctime>
	#include <iostream>
	#include <string>

// FUNCTION DELCARATIONS
	// Returns true if year is a leap year.
	bool leapYear(int year);
	// Returns the number of Fathers' Days as a father.
	int numberOfFathersDays(string childrenNames[], int childrenDOBs[]);
	// Returns the timestamp at midnight on the third Sunday of June in the given year.
	time_t thirdSundayOfJune(int year);
	// Returns the timestamp on 1st January at 00:00:00 for that year.
	int yearToTimestamp(int year);

// FUNCTION DEFINITIONS
	bool leapYear(int year)
	{
		if (year % 4 == 0)
		{
			if (year % 100 == 0)
			{
				if (year % 400 == 0)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return true;
			}
		}
		else
		{
			return false;
		}
	}

	void main()
	{
		// Chilrens' names and date-of-births.
		string names[] = {"Adam", "Ben", "Lauren"};
		int DOBs[] = {880243200, 993686400, 1122854400};

		// Outputs the number of Fathers' Days celebrated for those children.
		std::cout << "You have celebrated " << numberOfFathersDays(names, DOBs) << " Fathers' Days as a father." << endl;

		thirdSundayOfJune(2018);

		int test[] = {3, 5, 7, 9};

		
	}

	int minimum(int array[])
	{
		for (int i=0; i<=sizeof(array); ++i)
		{

		}
	}

	int numberOfFathersDays(string childrenNames[], int childrenDOBs[])
	{
		time_t now = std::time(0);

		

		return now;
	}

	time_t thirdSundayOfJune(int year)
	{
		// Some parameters to make my life slightly easier.
		const int June = 5; // Month number (0,11).
		const int day = 6; // Day number (0,6).
		const int daysBeforeJune = 31 + 28 + 31 + 30 + 31; // Days before June on a non-leap year.

		time_t now = std::time(0);
		struct tm* nowInfo = localtime(&now);

		int thisYear = nowInfo->tm_year + 1900; // tm_year returns years from 1900.
		int thisYearTimestamp = yearToTimestamp(thisYear);
		int thisFathersDay = thisYearTimestamp + (daysBeforeJune + leapYear(thisYear))*60*60*24; //WRONG

		int lastYear = thisYear - 1;
		int lastYearTimestamp = yearToTimestamp(lastYear); 
		int lastFathersDay = lastYearTimestamp + (daysBeforeJune + leapYear(lastYear))*60*60*24; //WRONG

		int mostRecentFathersDay = 0;

		if (now < thisFathersDay)
		{
			mostRecentFathersDay = lastFathersDay;
		}
		else
		{
			mostRecentFathersDay = thisFathersDay;
		}

		return mostRecentFathersDay;
	}

	int yearToTimestamp(int year)
	{
		int timestamp = 0;

		for (int i = 1970; i <= year; i++)
		{
			timestamp += (365 + leapYear(i)) * 60*60*24; // (days) * seconds*minutes*hours.

		}

		return timestamp;
	}