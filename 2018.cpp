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
		time_t thisYearTimestamp = yearToTimestamp(thisYear);
		time_t thisYearJuneTimestamp = thisYearTimestamp + (daysBeforeJune + leapYear(thisYear))*60*60*24; // The timestamp for 1st June this year.
		int thisYearJuneDay = localtime(&thisYearJuneTimestamp)->tm_wday; // The day of the week for 1st June on this year.
		if (thisYearJuneDay == 0) { thisYearJuneDay = 7; } // This sets Sundays to 7, not 0, making the next line easier.
		time_t thisYearFirstSundayTimestamp = thisYearJuneTimestamp + (7 - thisYearJuneDay)*60*60*24; // Adds on the number of seconds until the first Sunday.
		time_t thisYearThirdSundayTimestamp = thisYearFirstSundayTimestamp + 2*7*24*60*60; // Adds on a further two week's of seconds.

		int lastYear = thisYear - 1;
		time_t lastYearTimestamp = yearToTimestamp(lastYear); 
		time_t lastYearJuneTimestamp = lastYearTimestamp + (daysBeforeJune + leapYear(lastYear))*60*60*24; // The timestamp for 1st June last year.
		int lastYearJuneDay = localtime(&lastYearJuneTimestamp)->tm_wday; // The day of the week for 1st June on this year.
		if (lastYearJuneDay == 0) { lastYearJuneDay = 7; } // This sets Sundays to 7, not 0, making the next line easier.
		time_t lastYearFirstSundayTimestamp = lastYearJuneTimestamp + (7 - lastYearJuneDay)*60*60*24; // Adds on the number of seconds until the first Sunday.
		time_t lastYearThirdSundayTimestamp = lastYearFirstSundayTimestamp + 2*7*24*60*60; // Adds on a further two week's of seconds.

		// Variables we'll use to hold the
		time_t mostRecentFathersDayTimestamp;

		if (now < thisYearThirdSundayTimestamp)
		{
			mostRecentFathersDayTimestamp = lastYearThirdSundayTimestamp;
		}
		else
		{
			mostRecentFathersDayTimestamp = thisYearThirdSundayTimestamp;
		}

		return mostRecentFathersDayTimestamp;
	}

	int yearToTimestamp(int year)
	{
		int timestamp = 0;

		for (int i = 1970; i < year; i++)
		{
			timestamp += (365 + leapYear(i)) * 60*60*24; // (days) * seconds*minutes*hours.

		}

		return timestamp;
	}