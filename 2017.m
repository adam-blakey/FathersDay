function numberOfFathersDaysAsAFather = calculateOfFathersDaysAsAFather(childrenDOB)
%calculateNumberOfFathersDaysAsAFather Number of Fathers' Days as a father
%	Calculates the number of Fathers' Days as a father to date given the
%	datetime of the dates of birth of each child of the father.

	%% Calculates variables some reference variables.
		% Today as a datetime.
		today = datetime('today');

		% Finds the oldest child by finding the lowest (or earliest) date.
		oldestChild = min(childrenDOB);

	%% Calculates this year's, last year's, and the birth year of the oldest Child's Father's Day dates.
		% *A Fathers' Day is calculated as the third Sunday in June.*
		% Fathers' Day this year:
		fathersDayThisYear = datestr(nweekdate(3,1,year(today),6));

		% Fathers' Day last year:
		fathersDayLastYear = datestr(nweekdate(3,1,year(today)-1,6));

		% Fathers' Day in the year of the oldest child's birth:
		fathersDayInBirthYear = datestr(nweekdate(3,1,year(oldestChild),6));

		% If Fathers' Day has passed this year, then use that date as the
		% comparison; otherwise use last year's date.
		if (today >= fathersDayThisYear)
			fathersDayToCompare = fathersDayThisYear;
		else
			fathersDayToCompare = fathersDayLastYear;
		end

		% We calculate the number of Fathers' Days by finding the
		% difference between the years of the first and final celebrated
		% Fathers' Days.
		numberOfFathersDaysAsAFather = year(fathersDayToCompare) - year(fathersDayInBirthYear);
end