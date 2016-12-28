cd "F:\Dropbox\Forskning\Software tests\Multilevel"
*cd "C:\Users\adria\Dropbox\Forskning\Software tests\Multilevel"

set more off

* Set number of tests
local n = 10

tempfile small medium large

foreach f in small medium large {
	use data_`f', clear

	* Create matrix for storing times
	matrix define times = J(`n', 4, .)
	
	matrix colnames times = reml_2 ml_2 reml_3 ml_3
	
	* 2-level reml
	*-------------
	
	timer clear
	forvalues i = 1/`n' {
		timer on `i'
		mixed y i.by i.gender || id2:, reml
		timer off `i'
	}

	timer list

	* Get times
	forvalues i = 1/`n' {
		matrix times[`i', 1] = r(t`i')
	}
	
	
	* 2-level ml
	*-------------
	
	timer clear
	forvalues i = 1/`n' {
		timer on `i'
		mixed y i.by i.gender || id2:, mle
		timer off `i'
	}

	timer list

	* Get times
	forvalues i = 1/`n' {
		matrix times[`i', 2] = r(t`i')
	}


	* 3-level reml
	*-------------
	
	timer clear
	forvalues i = 1/`n' {
		timer on `i'
		mixed y i.by i.gender || id2: || id3:, reml matlog
		timer off `i'
	}

	timer list

	* Get times
	forvalues i = 1/`n' {
		matrix times[`i', 3] = r(t`i')
	}
	
	
	* 3-level ml
	*-------------
	
	timer clear
	forvalues i = 1/`n' {
		timer on `i'
		mixed y i.by i.gender || id2: || id3:, mle matlog
		timer off `i'
	}

	timer list

	* Get times
	forvalues i = 1/`n' {
		matrix times[`i', 4] = r(t`i')
	}	
	
	
	svmat times, names(col)

	keep reml* ml*

	drop if reml_2 == .

	gen format = "Stata"

	gen data = "`f'"
	
	save Stata_test_`f'.dta, replace
}

append using `medium'
append using `small'

save "Stata_test_data.dta, replace"
