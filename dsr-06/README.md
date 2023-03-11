# README

__Data source:__ Teorell, Jan, Aksel Sundström, Sören Holmberg, Bo Rothstein, Natalia Alvarado Pachon, Cem Mert Dalli & Yente Meijers. 2023. [The Quality of Government Standard Dataset][qog], version Jan23. University of Gothenburg: The Quality of Government Institute, `doi:10.18157/qogstdjan23`.

[qog]: https://www.gu.se/en/quality-government

## Documentation

The [codebook][codebook] of the dataset is available online. Make sure to read it to gain a firm understanding of how the data were assembled and measured.

[codebook]: https://www.qogdata.pol.gu.se/data/std_codebook_jan23.pdf

## R code to generate the `qog2023-extract` dataset

The data are extracted from the cross-sectional [QOG Standard dataset][qog], using the R code below:

```r
library(tidyverse)
library(countrycode)

haven::read_dta("qog_std_cs_jan23_stata14.dta") %>% 
  mutate(region = countrycode::countrycode(ccodecow, "cown", "region")) %>% 
  select(ccode, ccodealp, cname_qog, region,
         ht_colonial, br_dem, wdi_lifexp, wdi_gdpcappppcur) %>% 
  readr::write_tsv("qog2023-extract.tsv")
```

The original dataset appears in the material for the previous session.
