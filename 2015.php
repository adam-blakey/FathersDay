<?php
	function calculateNumberOfFathersDays($childrenNames, $childrenAge)
	{
		$oldestAge = time();
		foreach($childrenNames as $child)
			if ($childrenAge[$child] < $oldestAge)
				$oldestAge = $childrenAge[$child];

		$oldestYear = date("Y", $oldestAge);
		if ($oldestAge > strtotime("third Sunday of June {$oldestYear}"))
			$firstFathersDay = date("Y", strtotime("{$oldestYear} + 1 year"));
		else
			$firstFathersDay = $oldestYear;

		$thisYear = date('Y', time());
		if (time() > (strtotime("third Sunday of June {$thisYear}") + 86399))
			$nextFathersDay = strtotime("{$oldestYear} + 1 year");
		else
			$nextFathersDay = date("Y", time());
		
		$totalFathersDays = $nextFathersDay - $firstFathersDay + 1;
		
		return "You've celebrated {$totalFathersDays} Father's Days as a father."; // Don't be worried if this is a large number.
	}

	echo calculateNumberOfFathersDays(array("Adam", "Ben", "Lauren"), array("Adam" => 880243200, "Ben" => 993686400, "Lauren" => 1122854400));
?>