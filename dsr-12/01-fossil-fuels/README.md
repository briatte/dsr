# README

An example of how to plot survey-weighted statistics onto a map, using inverse distance weighted interpolation to show subnational variation.

## Sources

The survey data come from Round 8 of the [European Social Survey][ess].

[ess]: https://www.europeansocialsurvey.org/

The full survey question for the example follows:

> To what extent are you in favour or against the following policies in [country] to reduce climate change? __Increasing taxes on fossil fuels, such as oil, gas and coal.__  
> 1 -- Strongly in favour  
> 2 -- Somewhat in favour  
> 3 -- Neither in favour nor against  
> 4 -- Somewhat against  
> 5 -- Strongly against

The shapefiles used were produced by [EuroGeographics][egs] and were fetched [from Eurostat][shp].

[egs]: https://eurogeographics.org/
[shp]: https://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units

The code is freely adapted from Edzer Pebesma and Roger Bivand's _[Spatial Data Science][rspatial]_ (2023), ch. 12 (["Spatial Interpolation"][rspatial12]), and from Anthony Damico's ["How to map the European Social Survey"][damico15] (2015), who goes further than we do by using a more complex interpolation method and by correcting small area statistics.

[rspatial]: https://r-spatial.org/book/
[rspatial12]: https://r-spatial.org/book/12-Interpolation.html
[damico15]: https://github.com/davidbrae/swmap/blob/master/how%20to%20map%20the%20european%20social%20survey.R

### R code to generate the `ESS8e02_2_extract` dataset

```r
# nothing fancy here
haven::read_dta("ESS8e02_2.dta/ESS8e02_2.dta") %>%
    select(cntry, region, regunit, idno, pspwght, inctxff) %>%
    readr::write_tsv("data/ESS8e02_2_extract.tsv")
```

## End result

![](fossil-fuels.png)
