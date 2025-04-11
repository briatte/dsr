# README

__Inspiration:__ Angus Deaton, "[COVID-19 and Global Income Inequality][deaton21]", working paper, January 2021. Later published on that same year as [NBER Working Paper No. 28392][deaton21-nber], and then as an article in the [_LSE Public Policy Review_ 1(4): 1-10][deaton21-article].

[deaton21]: https://web.archive.org/web/20210303234133/https://scholar.princeton.edu/sites/default/files/international_income_inequality_and_the_covid_v2_assembled_0.pdf
[deaton21-nber]: https://www.nber.org/papers/w28392
[deaton21-article]: https://ppr.lse.ac.uk/articles/10.31389/lseppr.26/

__Data source for Covid-19 deaths:__ "Daily vs. Total confirmed COVID-19 deaths per million," [Our World in Data][owid], as provided in [early 2021][owid-old-link].

[owid]: https://ourworldindata.org/
[owid-old-link]: https://web.archive.org/web/20220305145213/https://ourworldindata.org/grapher/covid-deaths-daily-vs-total-per-million

At the time of download, _Our World in Data_ was sourcing its raw data from the [COVID-19 Data Repository][jhu] by the Center for Systems Science and Engineering (CSSE) at Johns Hopkins University.

[jhu]: https://github.com/CSSEGISandData/COVID-19

See the _Our World in Data_ website for an [updated Covid-19 dataset][owid-new].

[owid-new]: https://ourworldindata.org/coronavirus

__Data source for income and population:__ World Bank [World Development Indicators][wdi]. The indicators were downloaded manually in February 2021; more recent data can be downloaded through the [`WDI` package][wdi-package].

[wdi]: https://databank.worldbank.org/source/world-development-indicators
[wdi-package]: https://cran.r-project.org/package=WDI

__Data source for OECD member states:__ C.J. Yetman, _`memberstates`: List of member states of various international organizations_, [R package version 0.0.0.9000][memberstates].

[memberstates]: http://github.com/cjyetman/memberstates

The code to extract and prepare the country code follows:

```r
library(countrycode)
library(memberstates) # remotes::install_github("cjyetman/memberstates")

memberstates::memberstates$oecd$iso3c %>%
  countrycode::countrycode("iso3c", "wb") %>% 
  dput()
```
