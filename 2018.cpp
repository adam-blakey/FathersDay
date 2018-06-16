// LIBRARY INCLUSIONS.
	#include <ctime>
	#include <iostream>
	#include <string>

// FUNCTION DELCARATIONS
	// Returns the number of Fathers' Days as a father.
	int numberOfFathersDays(string childrenNames[], int childrenDOBs[]);

	// Returns the timestamp at midnight on the third Sunday of June in the given year.
	time_t thirdSundayOfJune(int year);

// FUNCTION DEFINITIONS
	void main()
	{
		// Chilrens' names and date-of-births.
		string names[] = {"Adam", "Ben", "Lauren"};
		int DOBs[] = {880243200, 993686400, 1122854400};

		// Outputs the number of Fathers' Days celebrated for those children.
		std::cout << "You have celebrated " << numberOfFathersDays(names, DOBs) << " Fathers' Days as a father." << endl;
	}

	int numberOfFathersDays(string childrenNames[], int childrenDOBs[])
	{
		time_t now = std::time(0);

		return 1;
	}

	time_t thirdSundayOfJune(int year)
	{
		// Some parameters to make my life slightly easier.
		int June = 5; // Month number (0,11).
		int day = 6; // Day number (0,6).


	}