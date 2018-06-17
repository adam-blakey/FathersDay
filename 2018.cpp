// INFORMATION
// As you can probably tell, I am now a well-versed C++ programmer. However I am very keen, so if you have any comments on how to better approach this, then please email me!
// Email: adam@blakey.family.

// LIBRARY INCLUSIONS.
	#include <ctime>
	#include <iostream>
	#include <math.h>
	#include <string>

// FUNCTION DELCARATIONS
	// Returns true if year is a leap year.
	bool leapYear(int year);
	// Returns the minimum of the array given.
	int minimum(int array[]);
	// Returns the number of Fathers' Days as a father.
	int numberOfFathersDays(string childrenNames[], int childrenDOBs[]);
	// Returns the timestamp at midnight on the third Sunday of June in the given year.
	time_t thirdSundayOfJune(int year);
	// Returns the timestamp on 1st January at 00:00:00 for that year.
	int yearToTimestamp(int year);

// FUNCTION DEFINITIONS
	bool leapYear(int year)
	{
		// This just so happens to be how a leap year is defined.
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
		string names[] = {"Adam", "Ben", "Lauren"}; // This doesn't actually get used, but I've traditionally put it in (and I'm going to continue doing that).
		int DOBs[] = {880243200, 993686400, 1122854400};

		// Outputs the number of Fathers' Days celebrated for those children.
		std::cout << "You have celebrated " << numberOfFathersDays(names, DOBs) << " Fathers' Days as a father." << endl;
	}

	int minimum(int array[])
	{
		// Stores the currently assumed smallest element,
		int minElement = array[0];

		// Does a linear search on all elements to find the smallest elements.
		for (int i=0; i<=sizeof(array)/sizeof(*array); ++i) // Starts from zero (not necessary) just because I can't be bothered to deal with degenerate arrays.
		{
			if (array[i] < minElement)
			{
				// If this element is smaller than the previously found smallest, then set it as the new smallest.
				minElement = array[i];
			}
		}

		return minElement;
	}

	int numberOfFathersDays(string childrenNames[], int childrenDOBs[])
	{
		// Sets up some constants to help later calculations.
		const time_t now = std::time(0);
		const int thisYear = localtime(&now)->tm_year + 1900; // tm_year returns years since 1900.
		const int lastYear = thisYear - 1;

		// Stores the timestamp of the most recent Fathers' Day.
		time_t mostRecentFathersDay;

		// Finds if the most recent Fathers' Day was this year or last year.
		if (now < thirdSundayOfJune(thisYear))
		{
			mostRecentFathersDay = thirdSundayOfJune(lastYear);
		}
		else
		{
			mostRecentFathersDay = thirdSundayOfJune(thisYear);
		}

		// Finds the year associated with the most recent Fathers' Day.
		int mostRecentFathersDayYear = localtime(&mostRecentFathersDay)->tm_year;

		// Finds the year associated with the oldest child.
		time_t oldestChild = minimum(childrenDOBs);
		int oldestChildYear = localtime(&oldestChild)->tm_year;

		// Loops through all of the years that the father would've celebrated Fathers' Day, excluding possibly the first.
		int yearsSpent = 0;
		for (int year = oldestChildYear + 1; year <= mostRecentFathersDayYear; year++)
		{
			yearsSpent += 1;
		}

		// Adds an additional year if the oldest child's birthday fell before Fathers' Day that year.
		if (oldestChild < thirdSundayOfJune(oldestChildYear))
		{
			yearsSpent += 1;
		}

		return yearsSpent;
	}

	time_t thirdSundayOfJune(int year)
	{
		// A parameter to make my life slightly easier.
		const int daysBeforeJune = 31 + 28 + 31 + 30 + 31; // Days before June on a non-leap year.

		// Goes through calculating the third Sunday of June that year.
		time_t timestamp = yearToTimestamp(year);
		time_t JuneTimestamp = timestamp + (daysBeforeJune + leapYear(year))*60*60*24; // The timestamp for 1st June this year.
		int JuneDay = localtime(&JuneTimestamp)->tm_wday; // The day of the week for 1st June on this year.
		if (JuneDay == 0) { JuneDay = 7; } // This sets Sundays to 7, not 0, making the next line easier.
		time_t firstSundayTimestamp = JuneTimestamp + (7 - JuneDay)*60*60*24; // Adds on the number of seconds until the first Sunday.
		time_t thirdSundayTimestamp = firstSundayTimestamp + 2*7*24*60*60; // Adds on a further two week's of seconds.

		return thirdSundayTimestamp;
	}

	int yearToTimestamp(int year)
	{
		int timestamp = 0;

		// Loops through each year adding on the number of seconds to 1st January that year.
		for (int i = 1970; i < year; i++)
		{
			timestamp += (365 + leapYear(i)) * 60*60*24; // (days) * seconds*minutes*hours.

		}

		return timestamp;
	}