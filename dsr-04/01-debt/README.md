# README

__Data source:__ Thomas Herndon, Michael Ash and Robert Pollin, "[Does High Public Debt Consistently Stifle Economic Growth? A Critique of Reinhart and Rogoff][hap14]," _Cambridge Journal of Economics_ 38(2): 257–79, 2014. 

[hap14]: https://doi.org/10.1093/cje/bet075

The data come from the [Zenodo repository][hap-repl] of the study.

You can read the backstory of this example [on Andrew Gelman's blog][gelman13]. There is also an interesting reexamination of what went wrong in the original study [on Steven Miller's blog][miller20].

For yet another interesting take on the same study, see [Cosma Shalizi's class exercise][shalizi13-hw11], which will force you to work with more advanced concepts and methods than what we used if you try to complete the exercise. See the [Web page of the corresponding course][shalizi13-uada], and [this lecture/book chapter][shalizi13-ch23] in particular. The CSV data for the exercise can be found at [this address][shalizi13-data].

[hap-repl]: https://zenodo.org/record/4017423
[gelman13]: https://statmodeling.stat.columbia.edu/2013/04/16/memo-to-reinhart-and-rogoff-i-think-its-best-to-admit-your-errors-and-go-on-from-there/
[miller20]: https://svmiller.com/blog/2020/04/reinhart-rogoff-ten-years-later-replication/
[shalizi13-hw11]: https://www.stat.cmu.edu/~cshalizi/uADA/13/hw/11/hw-11.pdf
[shalizi13-uada]: https://www.stat.cmu.edu/~cshalizi/uADA/13/
[shalizi13-ch23]: https://www.stat.cmu.edu/~cshalizi/uADA/13/lectures/ch23.pdf
[shalizi13-data]: https://www.stat.cmu.edu/~cshalizi/uADA/13/hw/11/debt.csv

## R code to generate the `debt` and `growth` datasets

Using the previously mentioned [replication package][hap-repl] by Herndon _et al._:

```r
library(tidyverse)

fs::dir_create("data")

rr <- "WP322HAP-RR-GITD-code-2013-05-17/RR-processed.dta" %>% 
  haven::read_dta() %>% 
  select(country = Country, year = Year, growth = dRGDP, ratio = debtgdp) %>% 
  mutate(country = as.character(haven::as_factor(country)))

readr::write_csv(select(rr, -growth), "data/debt.csv")
readr::write_csv(select(rr, -ratio), "data/growth.csv")
```

## R code to generate the `eu-membership` dataset

Using Wikipedia, for lack of a better source, since the EU Commission does not seem to have it anywhere on its website:

```r
library(countrycode)
library(rvest)
library(tidyverse)

h <- "https://en.wikipedia.org/wiki/Enlargement_of_the_European_Union" %>% 
  rvest::read_html()

rvest::html_table(h) %>% 
  pluck(3) %>% 
  select(country = Applicant, accession = `Accession / failure rationale`) %>% 
  filter(!str_detect(accession, "Frozen|Negotiating|Rejected|Withdrawn")) %>% 
  filter(!str_detect(accession, "Applicant|Candidate|Vetoed")) %>% 
  mutate(
    country = countrycode::countrycode(country, "country.name", "country.name"),
    accession = as.integer(str_extract(accession, "\\d{4}"))
  ) %>% 
  readr::write_tsv("data/eu-membership.tsv")
```
