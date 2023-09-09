# `>` Introduction to Data Science with R

> [François Briatte](https://f.briatte.org/)  
> Spring 2023. __Work in progress.__

An introduction to data science with [R][r], [RStudio][rstudio], and the [`{tidyverse}`][tidyverse] packages, aimed at social scientists with little to no training in statistical computing and related topics.

[r]: https://www.r-project.org/
[rstudio]: https://posit.co/products/open-source/rstudio/
[tidyverse]: https://www.tidyverse.org/

`>` __[Syllabus][syllabus]__  
`>` __[Readings][readings]__ (handbooks, videos, tutorials and more)

[syllabus]: https://f.briatte.org/teaching/syllabus-dsr.pdf
[readings]: https://github.com/briatte/dsr/wiki/readings

This folder contains the code, data and documentation of the examples used either during the practice sessions in class, or distributed as homework exercises. __Slides and exercise solutions are not included.__

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

Bonus sections:

- [Dependencies](#dependencies)
- [Credits](#credits)
- [Elsewhere](#elsewhere)

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
`>` __[Readings][r1]__  
`>` Exercise 1: __[Generative art][ex01]__

[s1]: https://f.briatte.org/teaching/slides-dsr-01-software.pdf
[r1]: https://github.com/briatte/dsr/wiki/readings#1-software
[ex01]: https://github.com/briatte/dsr/tree/master/exercise-01

## 2. Workflow

- More on the RStudio interface
  - Setting the working directory
  - Doing so by using RStudio project files: `.Rproj`
  - The Files and Plots panes
- More R syntax essentials
  - Code spanning multiple lines, and pipes: `%>%`, `|>`
  - Data frames, variables and values
  - R has many packages and sub-syntaxes: base, `{tidyverse}`, `{ggplot2}`, etc.
  - Executing code down to a given line: `Ctrl-Alt-B`

<!-- `>` __[Slides][s2]__   -->
`>` __[Readings][r2]__  
`>` Demo 1: __[Cholera deaths in London, 1854][s2-1]__ (John Snow)  
`>` Demo 2: __[Industrial disputes and left-wing seat shares][s2-2]__ (CWS 2020)  
`>` Exercise 2: __[Weird R syntax][ex02]__

[s2]: https://f.briatte.org/teaching/slides-dsr-02-workflow.pdf
[r2]: https://github.com/briatte/dsr/wiki/readings#2-workflow
[s2-1]: https://github.com/briatte/dsr/tree/master/dsr-02/01-cholera-1854
[s2-2]: https://github.com/briatte/dsr/tree/master/dsr-02/02-industrial-disputes
[ex02]: https://github.com/briatte/dsr/tree/master/exercise-02

## 3. Data

Data wrangling, mostly with the `{dplyr}` package.

- Data I/O
  - reading/writing datasets with `{readr}`, `{haven}` and `{readxl}`
  - inspecting datasets: `head`, `str`, `View`, `glimpse`
  - passing mentions -- strings, factors, dates and special formats
  - passing mentions -- [SQL and databases][db], and data engineering
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
  - handling missing values: `is.na`, `na_if`, `drop_na`
  - handling text with `{stringr}` and regular expressions, a.k.a. regex

<!-- `>` __[Slides][s3]__   -->
`>` __[Readings][r3]__  
`>` Demo 1: __[Covid-19 and global income inequality][s3-2]__ (Deaton)  
`>` Demo 2: __[Visualizing the 'EU mood'][s3-1]__ (Guinaudeau and Schnatterer)  
`>` Exercise 3: __[Satisfaction with democracy in Hungary and Poland][ex03]__ (Eurobarometer)

[s3]: https://f.briatte.org/teaching/slides-dsr-03-data.pdf
[r3]: https://github.com/briatte/dsr/wiki/readings#3-data
[s3-1]: https://github.com/briatte/dsr/tree/master/dsr-03/01-covid-income
[s3-2]: https://github.com/briatte/dsr/tree/master/dsr-03/02-eu-mood
[ex03]: https://github.com/briatte/dsr/tree/master/exercise-03

[db]: https://solutions.posit.co/connections/db/

## 4. Visualization

Plots, mostly with the `{ggplot2}` package.

- Principles of data abstraction
- Plotting engines
- The ‘grammar of graphics’ approach

<!-- `>` __[Slides][s4]__   -->
`>` __[Readings][r4]__  
`>` Demo: __[Economic growth and public debt][s4-1]__ (Reinhart and Rogoff)  
`>` Bonus 1: __[Mapping life expectancy worldwide][s4-2]__  
`>` Bonus 2: __[Anscombe's quartet][s4-3]__  
`>` Exercise 4: __[Life expectancy and GDP per capita][ex04]__ (Preston curve)

[s4]: https://f.briatte.org/teaching/slides-dsr-04-visualization.pdf
[r4]: https://github.com/briatte/dsr/wiki/readings#4-visualization
[s4-1]: https://github.com/briatte/dsr/tree/master/dsr-04/01-debt
[s4-2]: https://github.com/briatte/dsr/tree/master/dsr-04/02-life-expectancy
[s4-3]: https://github.com/briatte/dsr/tree/master/dsr-04/03-anscombe
[ex04]: https://github.com/briatte/dsr/tree/master/exercise-04

# Part 2. Essentials

Descriptive and inferential statistics, the frequentist way (no time for Bayesian ones, I'm afraid). This section will briefly mention some more advanced topics related to regression models, statisical estimation and machine learning.

## 5. Description

Summary statistics and distributions. Also covering sampling, and possibly bootstrap resampling if time permits (which of course won't happen).

- Describing a distribution
  - Central tendency
  - Dispersion
  - Quantiles
  - Proportions
- Inference
  - The ‘normal’ distribution
  - The Central Limit Theorem (CLT) and the Law of Large Numbers (LLN)
  - Standard errors
  - Confidence intervals

<!-- `>` __[Slides][s5]__   -->
`>` __[Readings][r5]__  
`>` Demo: __[Colonialism, democracy, life expectancy and wealth, Part 1][s5-1]__  
`>` Exercise 5: __[Trust in Islamist parties][ex05]__ (graded homework)

[s5]: https://f.briatte.org/teaching/slides-dsr-05-description.pdf
[r5]: https://github.com/briatte/dsr/wiki/readings#5-description
[s5-1]: https://github.com/briatte/dsr/tree/master/dsr-05
[ex05]: https://github.com/briatte/dsr/tree/master/exercise-05

## 6. Association

Statistical tests to compare means and proportions.

- Association tests
- Statistical significance
- Comparisons of means
- Comparisons of proportions

<!-- `>` __[Slides][s6]__   -->
`>` __[Readings][r6]__  
`>` Demo: __[Colonialism, democracy, life expectancy and wealth, Part 2][s6-1]__  
`>` No exercise this week -- catch up on all previously distributed material

[s6]: https://f.briatte.org/teaching/slides-dsr-06-association.pdf
[r6]: https://github.com/briatte/dsr/wiki/readings#6-association
[s6-1]: https://github.com/briatte/dsr/tree/master/dsr-06

## 7. Correlation

Linear and nonlinear, as an introduction to linear and nonlinear models, with some basic philosophy of ~~data~~ ~~quantitative~~ ~~social~~ ~~statistical~~ science.

- Correlation, the actual thing
- Linearity and nonlinearity
- Data-generating processes and [stylized facts][hirschman16]
- Fitting functions to joint distributions

[hirschman16]: https://doi.org/10.15195/v3.a26

<!-- `>` __[Slides][s7]__   -->
`>` __[Readings][r7]__  
`>` Demo: __[Social democratic capitalism][s7-1]__ (Kenworthy)  
`>` Exercise 7: __[US Republican vote shares and life expectancy][ex07]__ (Case and Deaton)

[s7]: https://f.briatte.org/teaching/slides-dsr-07-correlation.pdf
[r7]: https://github.com/briatte/dsr/wiki/readings#7-correlation
[s7-1]: https://github.com/briatte/dsr/tree/master/dsr-07
[ex07]: https://github.com/briatte/dsr/tree/master/exercise-07

## 8. Regression

Linear regression, the full package: least squares, dummies, interactions, diagnostics, marginal effects. All in one session, if things go well, but this usually takes half of any introductory statistics course.

- Estimation: fitting linear models via Ordinary Least Squares (OLS)
  - Modelling your ‘response’ (dependent variable)
  - Interpreting your coefficients
  - Categorical predictors (independent variables): handling ‘dummies’
  - Interaction terms: ‘multiplying’ your predictors
- Postestimation: what to do after fitting a linear model
  - Goodness-of-fit
  - Diagnostics: residuals, multicollinearity and heteroscedasticity
  - Additional diagnostics: outliers and ‘influential observations’
  - Marginal effects
- Model manipulation with the `{broom}` package

<!-- `>` __[Slides][s8]__   -->
`>` __[Readings][r8]__  
`>` Demo: __[U.S. presidential election outcomes and income growth][s8-1]__ (Bartels)  
`>` Exercise 8: __[Growth forecasts and fiscal consolidation][ex08]__ (IMF/Giles)

[s8]: https://f.briatte.org/teaching/slides-dsr-08-regression.pdf
[r8]: https://github.com/briatte/dsr/wiki/readings#8-regression
[s8-1]: https://github.com/briatte/dsr/tree/master/dsr-08
[ex08]: https://github.com/briatte/dsr/tree/master/exercise-08

## 9. Nonlinearity

Focusing ~~mostly~~ exclusively on logistic regression, ~~but hoping to also introduce more fun stuff~~ with no time to say more about other generalized models.

- Generalized liner models
- The logit ‘link’ function
- Log-odds and odds ratios

<!-- `>` __[Slides][s9]__   -->
`>` __[Readings][r9]__  
`>` Demo: __[Opposition to abortion in Canada][s9-1]__ (CES 2021)  
`>` Exercise 9: __[Predicting Covid-19 lockdowns][ex09]__ (graded homework)

[s9]: https://f.briatte.org/teaching/slides-dsr-09-nonlinearity.pdf
[r9]: https://github.com/briatte/dsr/wiki/readings#9-nonlinearity
[s9-1]: https://github.com/briatte/dsr/tree/master/dsr-09
[ex09]: https://github.com/briatte/dsr/tree/master/exercise-09

## 10. Surveys

Surveys, and how to handle survey weights, with the `{survey}` and `{srvyr}` packages. __Not yet online, work in progress.__

<!-- `>` __[Slides][s10]__   -->
`>` __[Readings][r10]__  
`>` Demo: __[..][s10-1]__  
`>` Exercise 10: __[Economic insecurity and religious reassurance][ex10]__ (ESS)

[s10]: https://f.briatte.org/teaching/slides-dsr-10-surveys.pdf
[r10]: https://github.com/briatte/dsr/wiki/readings#10-surveys
[s10-1]: /
[ex10]: https://github.com/briatte/dsr/tree/master/exercise-10

# Part 3. Extras

[Statistical learning][csl] and [machine learning][ml] could go here, as well as APIs and Web scraping, networks, big data and more things like JavaScript visualization libraries, but there are only two extra sessions.

[csl]: https://allmodelsarewrong.github.io/
[ml]: https://conf20-intro-ml.netlify.app/

## 11. Classification

Dimensionality reduction, principal components, clustering and partitioning, using `{factoextra}` and related packages to visualise the results.

<!-- `>` __[Slides][s11]__   -->
`>` __[Readings][r11]__  
`>` Demo 1: __[Protein consumption in European countries, 1973][s11-1]__  
`>` Demo 2: __[Feelings towards politicians in France][s11-2]__ (CNEP 2017)  
`>` No exercise this week -- catch up on all previously distributed material

[s11]: https://f.briatte.org/teaching/slides-dsr-10-classification.pdf
[r11]: https://github.com/briatte/dsr/wiki/readings#11-classification
[s11-1]: https://github.com/briatte/dsr/tree/master/dsr-11/01-protein-consumption
[s11-2]: https://github.com/briatte/dsr/tree/master/dsr-11/02-political-thermometer

## 12. Extensions

Students manifested an interest in maps and text, so let's cover this, plus mentions of other things like [version control][git-r] with Git/GitHub, Web scraping, and dynamic documents with [R Markdown][rmarkdown] or [Quarto][quarto].

- Maps with `{sf}`
  - Going further: `{sfdep}`
- Text analysis with `{tidytext}`
  - Going further: `{quanteda}`, `{topicmodels}`, `{stm}`
- Going further with R
- Passing mentions of [Git/GitHub][git-r], [R Markdown][rmarkdown] and [Quarto][quarto]
- Passing mentions of Web scraping, Python and machine learning
- Passing mention of Bayesian models

[git-r]: https://happygitwithr.com/
[rmarkdown]: https://rmarkdown.rstudio.com/
[quarto]: https://quarto.org/

<!-- `>` __[Slides][s12]__   -->
`>` __[Readings][r12]__  
`>` Demo 1: __[Mapping support for fossil fuel taxation][s12-1]__ (ESS)  
`>` Demo 2: __[Mining into Greta Thunberg's speeches][s12-2]__  
`>` Exercise 12: __[data science skills][ex12]__

[s12]: https://f.briatte.org/teaching/slides-dsr-12-extensions.pdf
[r12]: https://github.com/briatte/dsr/wiki/readings#12-extensions
[s12-1]: https://github.com/briatte/dsr/tree/master/dsr-12/01-fossil-fuels
[s12-2]: https://github.com/briatte/dsr/tree/master/dsr-12/02-greta-thunberg
[ex12]: https://github.com/briatte/dsr/tree/master/exercise-12

* * *

# Dependencies

The course runs on R 4.x and depends on the following packages:

```r
install.packages("remotes")

# required for multiple sessions
pkgs <- c("broom", "countrycode", "e1071", "ggmosaic", "ggeffects", "ggrepel", 
          "moments", "performance", "sf", "texreg", "tidyverse", "WDI")
remotes::install_cran(pkgs)

# required for Session 11 only
s11 <- c("car", "corrr", "factoextra", "ggcorrplot", "ggfortify", "plotly")
remotes::install_cran(s11)

# required for Session 12 only
s12_maps <- c("gstat", "stars")
s12_text <- c("igraph", "ggraph", "pdftools", "tidytext")
remotes::install_cran(c(s12_maps, s12_text))

# optional (used to prepare the course datasets)
xtra <- c("rvest")
remotes::install_cran(xtra)
```

# Credits

The last time I had a chance to build such a course was [ten years ago](https://f.briatte.org/teaching/ida/), with [Ivaylo D. Petev](https://www.ipetev.org/). Some of the inspiration for this course dates back to that time.

In the meantime, I have taught [a few other quantitative methods courses](https://f.briatte.org/teaching/#quanti), including some tutorials and guest lectures for [Jan Rovny's own courses](https://jan-rovny.squarespace.com/teaching). Some of the material for this course comes from those other ones.

Some thanks go to [Kim Antunez](https://antuki.github.io/apropos/), who will be soon teaching [her own version of this course](https://github.com/antuki/dsr), and who suggested some of the readings that made it to my own list.

Some thanks also go to [Joël Gombin](https://github.com/joelgombin) and [Timothée Gidoin](https://github.com/gidoin), who inspired and helped with a first draft of this course, six years before it actually ran for the first time.

Last, this course and all the other ones mentioned above took place at [Sciences Po in Paris, France](https://www.sciencespo.fr/), where some more inspiration has come from [Emiliano Grossman](https://www.emilianogrossman.eu/) and many others.

The ASCII art in some scripts is [by Patrick Gillespie](https://patorjk.com/software/taag/).

# Elsewhere

Most of this course is available [on GitHub](https://github.com/briatte/dsr), where a wiki page lists [other similar courses](https://github.com/briatte/dsr/wiki/elsewhere). I would love it if the present course were as good as those listed there, but cannot guarantee it.
