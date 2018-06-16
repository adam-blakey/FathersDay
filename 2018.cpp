#include <ctime>
#include <iostream>
#include <string>

int numberOfFathersDays(string childrenNames[], int childrenDOBs[]);

int numberOfFathersDays(string childrenNames[], int childrenDOBs[])
{
	int time = std::time(0);

	return time;
}

int main()
{
	time_t now = std::time(0);

	string names[] = {"Adam", "Ben", "Lauren"};
	int ages[] = {2345, 2345, 1234};

	int n = numberOfFathersDays(names, ages);

	// {"Adam", "Ben", "Lauren"}, {880243200, 993686400, 1122854400}
	

	std::cout << "You have celebrated " << n << " years as a father." << endl;
	return 0;
}