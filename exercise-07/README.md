# DSR: Exercise 7

The main goal of this (relatively easy) exercise is to replicate a small part of a recent paper by Anne Case and Angus Deaton. The paper is accessible at the following address:

<https://www.nber.org/papers/w29241>

The paper was later published in the following journal:

> Anne Case and Angus Deaton, "[The Great Divide: Education, Despair, and Death][case-deaton2022]," _Annual Review of Economics_, vol 14(1), 2022.

[case-deaton2022]: https://doi.org/10.1146/annurev-economics-051520-015607

Read enough of it to understand the argument behind Figure 2, and to understand the data sources.

## Scenario

You are a reviewer for the _Annual Review of Economics_, and are interested in replicating the authors' figures in order to check whether they contain any errors.

## Instructions

The `data` folder contains an extract from the [U.S. Mortality Database](https://usa.mortality.org/) (HMD). The variables are:

- `state_po` --- U.S. state (postal code)
- `year` --- year of measurement
- `lexp25` --- life expectancy at 25

As in Case and Deaton's paper, the 2020 estimate for life expectancy in that dataset is the (most recent) 2018 estimate. Read more on the HMD [on its website][hmd] if needed.

[hmd]: https://usa.mortality.org/notes.php

I literally did all the work for you above by locating the life expectancy data used by Case and Deaton, and by extracting the exact variable required to replicate Figure 2 of their paper.

Now, your turn:

- Find which dataset you need to download from the [MIT Election Lab](https://electionlab.mit.edu/data) to replicate Figure 2, and download it to the `data` folder.
- Subset the data to the rows required to reproduce Figure 2 of the paper.
- Compute the vote shares of each candidate.
- Load and merge the life expectancy and vote shares datasets.
- Replicate Figure 2 to the best of your abilities.

Hints:

- `?dplyr::filter` (or `subset`)
- `?dplyr::inner_join` (or `merge`)

Last, assess the following statement, from the authors' paper:

> The interstate correlation goes from +0.42 when Gerald Ford was the Republican candidate—the healthier states voted for Ford and against Carter—to –0.69 in 2016 and –0.64 in 2020 (using 2018 estimates of adult life expectancy). The least healthy states voted for Trump and against Biden.

## R code to generate the `1976-2020-life-expectancy-at-25` dataset

The code below is provided for reference. You do not need it to complete the exercise.

```r
library(tidyverse)

fs::dir_ls("ushmd-2021-01-07/", glob = "*.csv") %>%
  map_dfr(readr::read_csv, col_types = cols()) %>%
  # get LE for both sexes at 25 for presidential election years + 2018
  filter(Age %in% "25", Year %in% c(seq(1976, 2020, by = 4), 2018)) %>%
  # use 2018 as estimate for LE at 25 in election year 2020
  mutate(year = if_else(Year == 2018, 2020, Year)) %>%
  # keep only useful columns (ex = exact LE at year x = 25)
  select(state_po = PopName, year, lexp25 = ex) %>%
  readr::write_csv("1976-2020-life-expectancy-at-25.csv")
```
