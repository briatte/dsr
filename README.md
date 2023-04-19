# `>` Introduction to Data Science with R

> [François Briatte](https://f.briatte.org/)  
> Spring ~~2017~~ 2023. __Work in progress.__

An introduction to data science with [R][r], [RStudio][rstudio], and the [`tidyverse`][tidyverse] packages, aimed at social scientists with little to no training in statistical computing and related topics.

[r]: https://www.r-project.org/
[rstudio]: https://posit.co/products/open-source/rstudio/
[tidyverse]: https://www.tidyverse.org/

`>` __[Syllabus][syllabus]__ (very rough first draft)

[syllabus]: https://f.briatte.org/teaching/syllabus-dsr.pdf

This repo contains files from an old course project that took 5 years to actually get taught. I'm giving it a go this semester, so all old content is gone, and will be replaced, if everything goes well, by some new sessions.

A provisional outline follows -- not the full syllabus, only a recap of the main topics covered in each session, plus short descriptions of what happens during those.

This folder contains the code, data and documentation of the examples used either during the practice sessions in class, or distributed as homework exercises. __Slides are hosted elsewhere, and most links are not yet active.__

__Exercise solutions__ are not included either, but are distributed in class and are available on request by email.

# Handbooks

Early in the course, we will rely on R-focused handbooks, all of which are readable online:

- Irizarry, _[Introduction to Data Science][irizarry]_, 2022
- Rodrigues, _[Modern R with the tidyverse][rodrigues]_, 2022
- Wickham and Grolemund, _[R for Data Science][r4ds]_, 2nd ed., 2023

[irizarry]: http://rafalab.dfci.harvard.edu/dsbook/
[rodrigues]: https://modern-rstats.eu/
[r4ds]: https://r4ds.hadley.nz/

I will also recommend downloading and using [R cheatsheets](https://github.com/rstudio/cheatsheets), as well as reading from a few additional, more focused handbooks:

- Elff, _[Data Management in R][elff]_, 2020
- Healy, _[Data Visualization. A Practical Introduction][socviz]_, 2019

[elff]: https://www.elff.eu/book/data-management-r/
[socviz]: https://socviz.co/

Later in the course, we will continue with some of those handbooks, but will also refer to even more reseach-focused ones for their statistical parts:

- Hanck _et al._, _[Introduction to Econometrics with R][hanck]_, 2023
- Llaudet and Imai, _[Data Analysis for Social Science][llaudet-imai]_, 2022

[hanck]: https://www.econometrics-with-r.org/
[llaudet-imai]: https://press.princeton.edu/books/hardcover/9780691199429/data-analysis-for-social-science

… plus a few additional references for good measure.

All readings, and what to read at which stage of the course, appear in the [course syllabus][syllabus].

# Outline

1. [Software](#1-software)
2. [Workflow](#2-workflow)
3. [Data](#3-data)
4. [Visualization](#4-visualization)
5. [Description](#5-description)
6. [Association](#6-association)
7. [Correlation](#7-correlation)
8. [Regression](#8-regression)
9. [Nonlinearity](#9-nonlinearity)
10. [Surveys](#10-surveys)
11. [Classification](#11-classification)
12. [Extensions](#12-extensions)

# Part 1. Basics

Software setup, first steps with coding, handling data, and plotting things.

## 1. Software

- RStudio interface
  - The panes layout
  - Executing code from the Console
  - Executing code from a script: `Ctrl-Enter`
  - Setting preferences
- R syntax
  - Comments (`#`) and code
  - Functions and arguments
  - Objects and assignment: `<-`
  - Package installation

<!-- `>` __[Slides][s1]__   -->
`>` Exercise 1: __[Generative art][ex01]__

[s1]: https://f.briatte.org/teaching/slides-dsr-01-software.pdf
[ex01]: https://github.com/briatte/dsr/tree/master/exercise-01

## 2. Workflow

- More on the RStudio interface
  - Setting the working directory
  - Doing so by using RStudio project files: `.Rproj`
  - The Files and Plots panes
- More R syntax essentials
  - Code spanning multiple lines, and pipes: `%>%`, `|>`
  - Data frames, variables and values
  - R has many packages and sub-syntaxes: base, `tidyverse`, `ggplot2`, etc.
  - Executing code down to a given line: `Ctrl-Alt-B`

<!-- `>` __[Slides][s2]__   -->
`>` Demo 1: __[Cholera deaths in London, 1854][s2-1]__ (John Snow)  
`>` Demo 2: __[Industrial disputes and left-wing seat shares][s2-2]__ (CWS 2020)  
`>` Exercise 2: __[Weird R syntax][ex02]__

[s2]: https://f.briatte.org/teaching/slides-dsr-02-workflow.pdf
[s2-1]: https://github.com/briatte/dsr/tree/master/dsr-02/01-cholera-1854
[s2-2]: https://github.com/briatte/dsr/tree/master/dsr-02/02-industrial-disputes
[ex02]: https://github.com/briatte/dsr/tree/master/exercise-02

## 3. Data

Data wrangling, mostly with the `dplyr` package.

- Data I/O
  - reading/writing datasets with `readr`, `haven` and `readxl`
  - inspecting datasets: `head`, `str`, `View`, `glimpse`
  - passing mentions -- strings, factors, dates and special formats
  - passing mentions -- SQL databases, data engineering
- Data manipulation on a single dataset
  - selecting variables: `$`, `select` and `` $`special cases` ``
  - sorting (ordering): `arrange`
  - subsetting: `filter`
  - aggregating and summarising values: `group_by` + `summarise`
  - reshaping: `pivot_longer`, `pivot_wider`
- Data manipulation on multiple datasets
  - joining (merging) two datasets: `full_join` and the like
  - binding multiple datasets: `bind_rows`
- Recoding and transforming values: `mutate`
  - 'if/else' recodes: `if_else`
  - type coercion/conversion: `as.numeric`, `as.integer` etc.
  - missing values: `is.na`, `na_if`, `drop_na`
  - manipulating text with the `stringr` package (brief intro)

<!-- `>` __[Slides][s3]__   -->
`>` Demo 1: __[Covid-19 and global income inequality][s3-2]__ (Deaton)  
`>` Demo 2: __[Visualizing the 'EU mood'][s3-1]__ (Guinaudeau and Schnatterer)  
`>` Exercise 3: __[Satisfaction with democracy in Hungary and Poland][ex03]__ (EB)

[s3]: https://f.briatte.org/teaching/slides-dsr-03-data.pdf
[s3-1]: https://github.com/briatte/dsr/tree/master/dsr-03/01-covid-income
[s3-2]: https://github.com/briatte/dsr/tree/master/dsr-03/02-eu-mood
[ex03]: https://github.com/briatte/dsr/tree/master/exercise-03

## 4. Visualization

Plots, mostly with the `ggplot2` package.

<!-- `>` __[Slides][s4]__   -->
`>` Demo 1: __[Economic growth and public debt][s4-1]__ (Reinhart and Rogoff)  
`>` Demo 2: __[Anscombe's quartet][s4-2]__  
`>` Exercise 4: __[Life expectancy and GDP per capita][ex04]__ (Preston curve)

[s4]: https://f.briatte.org/teaching/slides-dsr-04-visualization.pdf
[s4-1]: https://github.com/briatte/dsr/tree/master/dsr-04/01-debt
[s4-2]: https://github.com/briatte/dsr/tree/master/dsr-04/02-anscombe
[ex04]: https://github.com/briatte/dsr/tree/master/exercise-04

# Part 2. Essentials

Descriptive and inferential statistics, the frequentist way (no time for Bayesian ones, I'm afraid), plus a session on dimensionality reduction.

Ideally, this section would also include a session on panel data (fixed and random effects, standard error clustering) and hierarchical data (mixed/multilevel models).

## 5. Description

Also covering sampling, and possibly bootstrap resampling if time permits (which of course won't happen).

<!-- `>` __[Slides][s5]__   -->
`>` Demo: __[Colonialism, democracy, life expectancy and wealth, Part 1][s5-1]__  
`>` Exercise 5: __[Trust in Islamist parties][ex05]__ (graded homework)

[s5]: https://f.briatte.org/teaching/slides-dsr-05-description.pdf
[s5-1]: https://github.com/briatte/dsr/tree/master/dsr-05
[ex05]: https://github.com/briatte/dsr/tree/master/exercise-05

## 6. Association

Association tests to compare means and proportions. ~~Also covering, as an aside, surveys, and how to handle survey weights.~~

<!-- `>` __[Slides][s6]__   -->
`>` Demo: __[Colonialism, democracy, life expectancy and wealth, Part 2][s6-1]__  
`>` No exercise this week -- catch up on all previously distributed material

[s6]: https://f.briatte.org/teaching/slides-dsr-06-association.pdf
[s6-1]: https://github.com/briatte/dsr/tree/master/dsr-06

## 7. Correlation

Linear and nonlinear, with mentions of linear models and LOESS curve smoothing.

<!-- `>` ~~__Slides__~~ (no slides this week)   -->
`>` Demo: __[Social democratic capitalism][s7-1]__ (Kenworthy)  
`>` Exercise 7: __[US Republican vote shares and life expectancy][ex07]__ (Case and Deaton)

[s7]: https://f.briatte.org/teaching/slides-dsr-07-correlation.pdf
[s7-1]: https://github.com/briatte/dsr/tree/master/dsr-07
[ex07]: https://github.com/briatte/dsr/tree/master/exercise-07

## 8. Regression

Linear regression, the full package: least squares, dummies, interactions, diagnostics, marginal effects. All in one session, if things go well, but this usually takes half of any introductory statistics course.

<!-- `>` __[Slides][s8]__   -->
`>` Demo: __[U.S. presidential election outcomes and income growth][s8-1]__ (Bartels)  
`>` Exercise 8: __[Growth forecasts and fiscal consolidation][ex08]__ (IMF/Giles)

[s8]: https://f.briatte.org/teaching/slides-dsr-08-regression.pdf
[s8-1]: https://github.com/briatte/dsr/tree/master/dsr-08
[ex08]: https://github.com/briatte/dsr/tree/master/exercise-08

## 9. Nonlinearity

Focusing mostly on logistic regression, but hoping to also introduce splines and more fun stuff.

<!-- `>` __[Slides][s9]__   -->
`>` Demo: __[Opposition to abortion in Canada][s9-1]__ (CES 2021)  
`>` Exercise 9: __[Predicting Covid-19 lockdowns][ex09]__ (graded homework)

[s9]: https://f.briatte.org/teaching/slides-dsr-09-nonlinearity.pdf
[s9-1]: https://github.com/briatte/dsr/tree/master/dsr-09
[ex09]: https://github.com/briatte/dsr/tree/master/exercise-09

## 10. Surveys

Work in progress.

(Due to Sessions 8 and 9 taking too much time to cover in only 4 hours, we took an extra session here to correct Exercise 8 and revise linear regression, but ideally, this session would also cover survey weighting.)

<!-- `>` __[Slides][s10]__   -->
`>` Demo 1: __[..][s10-1]__  
`>` Demo 2: __[..][s10-2]__  
`>` Exercise 10: __[Economic insecurity and religious reassurance][ex10]__ (ESS)

[s10]: https://f.briatte.org/teaching/slides-dsr-10-surveys.pdf
[s10-1]: /
[s10-2]: /
[ex10]: https://github.com/briatte/dsr/tree/master/exercise-11

(Exercise 10 is currently listed as Exercise 11, but will become Exercise 10 in future iterations.)

# Part 3. Extras

Statistical learning and [machine learning][ml] could go there, as well as APIs and Web scraping, networks, big data and more things, but there are only two extra sessions.

[ml]: https://conf20-intro-ml.netlify.app/

Ideally, we'd still also find time for an extra last session to wrap up and to introduce tools that are not covered here. By order of priority: SQL, Git/GitHub, R Markdown, and possibly some JavaScript visualization libraries.

## 11. Classification

Dimensionality reduction, principal components, clustering, etc.

<!-- `>` __[Slides][s11]__   -->
`>` Demo 1: __[Protein consumption in European countries, 1973][s11-1]__  
`>` Demo 2: __[Feelings towards politicians in France][s11-2]__ (CNEP 2017)  
`>` No exercise this week -- catch up on all previously distributed material

[s11]: https://f.briatte.org/teaching/slides-dsr-10-classification.pdf
[s11-1]: https://github.com/briatte/dsr/tree/master/dsr-11/01-protein-consumption
[s11-2]: https://github.com/briatte/dsr/tree/master/dsr-11/02-political-thermometer

## 12. Extensions

Students manifested an interest in text and maps, so let's cover this, plus mentions to other things like databases, version control and dynamic documents.

<!-- `>` __[Slides][s12]__   -->
`>` Demo 1: __[Mapping life expectancy worldwide][s12-1]__  
`>` Demo 2: __[Mining into Greta Thunberg's speeches][s12-2]__  
`>` Exercise 12: __[data science skills][ex12]__

[s12]: https://f.briatte.org/teaching/slides-dsr-12-extensions.pdf
[s12-1]: https://github.com/briatte/dsr/tree/master/dsr-12/01-life-expectancy
[s12-2]: https://github.com/briatte/dsr/tree/master/dsr-12/02-greta-thunberg
[ex12]: https://github.com/briatte/dsr/tree/master/exercise-12

* * *

# Credits

The last time I had a chance to build such a course was [ten years ago, with Ivaylo Petev](https://f.briatte.org/teaching/ida/). Some of the inspiration for this course dates back to that time.

In the meantime, I have taught [a few other quantitative methods courses](https://f.briatte.org/teaching/#quanti), including some tutorials and guest lectures for [Jan Rovny's own courses](https://jan-rovny.squarespace.com/teaching). Some of the material for this course comes from those other ones.

Some thanks also go to [Joël Gombin](https://github.com/joelgombin) and [Timothée Gidoin](https://github.com/gidoin), who inspired and helped with a first draft of this course, several years before it actually ran for the first time.

Last, this course and all the other ones mentioned above took place at [Sciences Po in Paris, France](https://www.sciencespo.fr/), where some more inspiration has come from [Emiliano Grossman](https://www.emilianogrossman.eu/) and many others.

## Dependencies

```r
install.packages("remotes")

# required
pkgs <- c("broom", "countrycode", "ggmosaic", "ggrepel", "moments", 
          "performance", "texreg", "tidyverse")
remotes::install_cran(pkgs)

# required for Session 11 only
s11 <- c("car", "corrr", "factoextra", "ggcorrplot", "ggfortify", "plotly")
remotes::install_cran(s11)

# required for Session 12 only
s12 <- c("sf", "igraph", "ggraph", "pdftools", "tidytext")
remotes::install_cran(s12)

# optional (used to prepare the course datasets)
xtra <- c("e1071", "rvest", "WDI")
remotes::install_cran(xtra)
```

## Elsewhere

I would love it if the present course were as good as those listed below, but cannot guarantee it.

- Chris Adolph, [Visualizing Data and Models](https://faculty.washington.edu/cadolph/index.php?page=22) (University of Washington, 2023)
- Jenny Bryan, [Data Wrangling, Exploration, and Analysis with R](https://stat545.com/) (fml. University of British Columbia, c. 2019)
- Mine Çetinkaya-Rundel, [Intro to Data Science](http://www2.stat.duke.edu/courses/Spring18/Sta199/) (Duke University, 2018)
- Friedrich Geiecke, [Data for Data Scientists](https://lse-my472.github.io/) (London School of Economics and Political Science, 2022)
- Kieran Healy, [Data Wrangling](https://github.com/kjhealy/data_wrangling) (Statistical Horizons, 2022)
- Andrew Heiss, [Data Visualization](https://datavizs22.classes.andrewheiss.com/) (Georgia State University, 2022)
- Grant McDermott, [Data Science for Economists](https://github.com/uo-ec607/) (University of Oregon, 2021)
- Gaston Sanchez [Data Visualization](https://www.gastonsanchez.com/#tutorials) (University of California, Berkeley, n.d.)
- Cosma Shalizi, [Undergraduate Advanced Data Analysis](https://www.stat.cmu.edu/~cshalizi/uADA/19/) (Carnegie Mellon University, 2019)
- Cosma Shalizi, [Statistical Computing](https://www.stat.cmu.edu/~cshalizi/statcomp/14/) (Carnegie Mellon University, 2014)
- Cosma Shalizi, [Modern Regression](https://www.stat.cmu.edu/~cshalizi/mreg/15/) (Carnegie Mellon University, 2015)
- Omar Wasow, [Applied Quantitative Analysis](http://pol346.com/) (Princeton University, 2021)
- Ista Zahn _et al._, [Data Science Workshops](https://iqss.github.io/dss-workshops/) (Harvard University, 2021)
