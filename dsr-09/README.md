# README

__Data source:__ Stephenson, Laura B; Harell, Allison; Rubenson, Daniel; Loewen, Peter John, 2022, “2021 Canadian Election Study (CES)”, [`doi:10.7910/DVN/XBZHKC`][doi], Harvard Dataverse, V1.

[doi]: https://doi.org/10.7910/DVN/XBZHKC

More details on the data can be obtained from the [Canadian Election Study][ces] website.

[ces]: http://www.ces-eec.ca/

The example used in the code comes from Andi Fugard's _[Using R for Social Research][af22]_, ch. 9 (["Complex Surveys"][af22-ch9]), which references Fox and Weinberg as its own data source:

> Fox, J. & Weisberg, S. (2019). _An R Companion to Applied Regression_, 3rd ed., Sage.

[af22]: https://inductivestep.github.io/R-notes/
[af22-ch9]: https://inductivestep.github.io/R-notes/complex-surveys.html#fitting-a-glm

### R code to generate the `ces21-extract` dataset

The extract was exported from a Stata session:

```stata
use "2021 Canadian Election Study v1.0.dta", clear
gen respid = cps21_ResponseId
gen ban_abortion = (pes21_abort2 < 3) if !mi(pes21_abort2)
gen age = cps21_age
gen female = (cps21_genderid == 2) if cps21_genderid < 3
gen urban = (pes21_rural_urban > 3) if pes21_rural_urban < 6
clonevar religion = cps21_rel_imp if cps21_rel_imp < 5
recode cps21_education ///
	(1/4 = 1 "Less than HS") (5 = 2 "HS") (6 8 = 3 "Some PS") ///
	(7 = 4 "College") (9 = 5 "BA") (10 11 = 6 "MA+") ///
    (else = .), gen(education)

outsheet respid cps21_province cps21_weight_general_restricted ///
	ban_abortion age female urban religion education ///
	if !mi(cps21_weight_general_restricted) ///
	using data/ces21-extract.tsv, replace
```
