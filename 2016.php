<?php
	// My Dad taught me just about everything that I know about programming. Around this time last year, my Dad set me a challenge to write a program that would tell him how many Father's Days he's had. After I wrote the program in a procedural-style, he then set me a further challenge to write it in an object-oriented style for the next Father's day: So, here it is. And as it turns out, he would've celebrated his nineteenth Father's Day as a father today.
	class fathersDays
	{
		// Holds all children names tied with a date of birth (DOB)
		private $childrenNamesWithDOB;

		// Helps when the class is instanciated with parameters
		public function __CONSTRUCT($childrenNamesWithDOB)
		{
			$this->childrenNamesWithDOB = $childrenNamesWithDOB;
		}

		// Returns the number of Father's Days with a specific child
		private function returnFathersDaysWithChild($childDOB)
		{
			// Calculates the timestamp of this year's Father's Day
			$fathersDayThisYear = strtotime("third Sunday of June");
			$fathersDayLastYear = strtotime("third Sunday of June last year");

			// Checks to see if Father's Day has passed for this year
			$fathersDayPassed = false;
			if (time() > $fathersDayThisYear)
				$fathersDayPassed = true;

			// Calculates when the last Father's Day was
			if ($fathersDayPassed)
				$lastFathersDay = $fathersDayThisYear;
			else
				$lastFathersDay = $fathersDayLastYear;

			// Calculates the difference between the child's DOB and the last Father's Day, and then converts the timestamp to the next whole number of years, then returns
			$numberOfFathersDays = ceil(($lastFathersDay - $childDOB)/(365*24*60*60));
			return $numberOfFathersDays;
		}

		// Outputs — in a formatted fashion — the number of Father's Days spent with each child
		public function outputFathersDaysWithAllChildren()
		{
			$numberOfChildren = count($this->childrenNamesWithDOB);

			// Preliminary string to the output
			$output = "Father's Days spent with: ";
			// Used for formatting the semi-colon within the foreach loop
			$isFirst = true;
			// Loops through each child
			foreach($this->childrenNamesWithDOB as $name => $DOB)
			{
				if($isFirst)
					$isFirst = false;
				else
					$output .= "; ";

				// Adds the name and the number of Father's Days to the output string
				$output .= $name.": ".$this->returnFathersDaysWithChild($DOB);
			}

			// Returns the string to be outputted
			return $output;
		}

		// Calculates the total number of Father's Days spent by the father
		public function totalNumberOfFathersDays()
		{
			// Sets highest initially to zero, then loops through each child
			$highestNumber = 0;
			foreach($this->childrenNamesWithDOB as $name => $DOB)
			{
				// Checks the current child with their DOB
				$toCheck = $this->returnFathersDaysWithChild($DOB);
				if($toCheck > $highestNumber)
					$highestNumber = $toCheck;
			}

			// Returns the highest number of Father's Days spent with any one child
			return $highestNumber;
		}
	}

	// Instantiate the class
	$fathersDays = new fathersDays(array("Adam" => 880243200, "Ben" => 993686400, "Lauren" => 1122854400));

	// Outputs the desired data
	echo $fathersDays->outputFathersDaysWithAllChildren()."<br />";
	echo "Also, you&#39;ve spent ".$fathersDays->totalNumberOfFathersDays()." Father&#39;s Days as a father.";
?>