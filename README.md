# `>` Introduction to Data Science with R

> [François Briatte](https://f.briatte.org/)  
> Spring ~~2017~~ 2023. __Work in progress.__

`>` __[Syllabus][syllabus]__

[syllabus]: https://f.briatte.org/teaching/syllabus-dsr.pdf

This repo contains files from an old course project that took 5 years to actually get taught. I'm giving it a go this semester, so all old content is gone, and will be replaced, if everything goes well, by some new sessions.

A provisional outline follows -- not the full syllabus, only a recap of the main topics covered in each session, plus short descriptions of what happens during those.

This folder contains the code, data and documentation of the examples used either during the practice sessions in class, or distributed as homework exercises. __Slides are hosted elsewhere, and the links are not currently active.__

# Handbooks

Early in the course, we will rely on R-focused handbooks, all of which are readable online:

- Irizarry, _[Introduction to Data Science](http://rafalab.dfci.harvard.edu/dsbook/)_, 2022
- Rodrigues, _[Modern R with the tidyverse](https://modern-rstats.eu/)_, 2022
- Wickham and Grolemund, _[R for Data Science](https://r4ds.hadley.nz/)_, 2nd ed., 2023
- Healy, _[Data Visualization. A Practical Introduction](https://socviz.co/)_, 2019

I will also recommend downloading and using [R cheatsheets](https://github.com/rstudio/cheatsheets).

Later in the course, we will continue with some of those handbooks, but also refer to more reseach-focused ones, plus a few additional references for good measure. Those additional readings, and what to read at which stage of the course, appear in the [course syllabus][syllabus].

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

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-01-software.pdf)__  
`>` Exercise 1: __[Generative art][ex01]__

[ex01]: https://github.com/briatte/dsr/tree/master/dsr-01-exercise

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

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-02-workflow.pdf)__  
`>` Class example 1: __[Cholera deaths in London, 1854][s2-1]__ (John Snow)  
`>` Class example 2: __[Industrial disputes and left-wing seat shares][s2-2]__ (CWS)  
`>` Exercise 2: __[Weird R syntax][ex02]__

[s2-1]: https://github.com/briatte/dsr/tree/master/dsr-02/01-cholera-1854
[s2-2]: https://github.com/briatte/dsr/tree/master/dsr-02/02-industrial-disputes
[ex02]: https://github.com/briatte/dsr/tree/master/dsr-02-exercise

## 3. Data

Data wrangling, mostly with `dplyr`.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-03-data.pdf)__  
`>` Class example 1: __[Attitudes towards the EU][s3-1]__ ('EU mood')  
`>` Class example 2: __[Voting in the 2019 European elections][s3-2]__ (EES 2019)  
`>` Exercise 3: __[Satisfaction with democracy in Hungary and Poland][ex03]__ (EB)

[s3-1]: https://github.com/briatte/dsr/tree/master/dsr-03/01-eu-mood
[s3-2]: https://github.com/briatte/dsr/tree/master/dsr-03/02-ees2019
[ex03]: https://github.com/briatte/dsr/tree/master/dsr-03-exercise

## 4. Visualization

Plots, mostly with `ggplot2`.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-04-visualization.pdf)__  
`>` Class example 1: __[Economic growth and public debt][s4-1]__ ('Reinhart and Rogoff')  
`>` Class example 2: __[Life expectancy and GDP per capita][s4-2]__ (Preston curve)  
`>` Exercise 4: __[Covid-19 and income inequality][ex04]__ (Deaton)

[s4-1]: https://github.com/briatte/dsr/tree/master/dsr-04/01-debt
[s4-2]: https://github.com/briatte/dsr/tree/master/dsr-04/02-preston-curve
[ex04]: https://github.com/briatte/dsr/tree/master/dsr-04-exercise

# Part 2. Essentials

Descriptive and inferential statistics, the frequentist way (no time for Bayesian ones, I'm afraid), plus a session on dimensionality reduction.

## 5. Description

Also covering sampling, and possibly bootstrapping if time permits.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-05-description.pdf)__  
`>` Class example 1: __[...][s5-1]__  
`>` Class example 2: __[...][s5-2]__  
`>` Exercise 5: __[...][ex05]__

[s5-1]: /
[s5-2]: /
[ex05]: /

## 6. Association

Also covering surveys, and (if time permits) how to handle survey weights.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-06-association.pdf)__  
`>` Class example 1: __[...][s6-1]__  
`>` Class example 2: __[...][s6-2]__  
`>` Exercise 6: __[...][ex06]__

[s6-1]: /
[s6-2]: /
[ex06]: /

## 7. Correlation

Also introducing least squares, and possibly LO(W)ESS.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-07-correlation.pdf)__  
`>` Class example 1: __[...][s7-1]__  
`>` Class example 2: __[...][s7-2]__  
`>` Exercise 7: __[...][ex07]__

[s7-1]: /
[s7-2]: /
[ex07]: /

## 8. Regression

Linear regression, the full package: dummies, interactions, diagnostics, marginal effects. All in one session, if things go well.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-08-regression.pdf)__  
`>` Class example 1: __[...][s8-1]__  
`>` Class example 2: __[...][s8-2]__  
`>` Exercise 8: __[...][ex08]__

[s8-1]: /
[s8-2]: /
[ex08]: /

## 9. Nonlinearity

Focusing mostly on logistic regression, but hoping to also introduce splines and more fun stuff.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-09-nonlinearity.pdf)__  
`>` Class example 1: __[...][s9-1]__  
`>` Class example 2: __[...][s9-2]__  
`>` Exercise 9: __[...][ex09]__

[s9-1]: /
[s9-2]: /
[ex09]: /

## 10. Classification

Dimensionality reduction, clustering, etc.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-10-classification.pdf)__  
`>` Class example 1: __[...][s10-1]__  
`>` Class example 2: __[...][s10-2]__  
`>` Exercise 10: __[...][ex10]__

[s10-1]: /
[s10-2]: /
[ex10]: /

# Part 3. Extras

Statistical and machine learning could go there, as well as APIs and Web scraping, networks, big data and more things, but there are only two extra sessions.

Ideally, we'd still also find time for an extra last session to wrap up and to introduce tools that are not covered here. By order of priority: SQL, Git/GitHub, R Markdown, and possibly some JavaScript visualization libraries.

## 11. Text

Students manifested an interest in that.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-11-text.pdf)__  
`>` Class example 1: __[...][s11-1]__  
`>` Class example 2: __[...][s11-2]__  
`>` Exercise 11: __[...][ex11]__

[s11-1]: /
[s11-2]: /
[ex11]: /

## 12. Maps

Students manifested an interest in that.

`>` __[Slides](https://f.briatte.org/teaching/slides-dsr-12-maps.pdf)__  
`>` Class example 1: __[...][s12-1]__  
`>` Class example 2: __[...][s12-2]__  
`>` Exercise 12: __[...][ex12]__

[s12-1]: /
[s12-2]: /
[ex12]: /

* * *

# Credits

The last time I had a chance to build such a course was [ten years ago, with Ivaylo Petev](https://f.briatte.org/teaching/ida/). Some of the inspiration for this course dates back to that time.

In the meantime, I have taught [a few other quantitative methods courses](https://f.briatte.org/teaching/#quanti), including some tutorials and guest lectures for [Jan Rovny's own courses](https://jan-rovny.squarespace.com/teaching). Some of the material for this course comes from those other ones.

Some thanks also go to [Joël Gombin](https://github.com/joelgombin) and [Timothée Gidoin](https://github.com/gidoin), who inspired and helped with a first draft of this course, several years before it actually ran for the first time.

Last, this course and all the other ones mentioned above took place at [Sciences Po in Paris, France](https://www.sciencespo.fr/), where some more inspiration has come from [Emiliano Grossman](https://www.emilianogrossman.eu/) and many others.

## Elsewhere

- Chris Adolph, [Visualizing Data and Models](https://faculty.washington.edu/cadolph/index.php?page=22) (University of Washington, 2023)
- Mine Çetinkaya-Rundel, [Intro to Data Science](http://www2.stat.duke.edu/courses/Spring18/Sta199/) (Duke University, 2018)
- Friedrich Geiecke, [Data for Data Scientists](https://lse-my472.github.io/) (London School of Economics and Political Science, 2022)
- Kieran Healy, [Data Wrangling](https://github.com/kjhealy/data_wrangling) (Statistical Horizons, 2022)
- Grant McDermott, [Data Science for Economists](https://github.com/uo-ec607/) (University of Oregon, 2021)
- Cosma Shalizi, [Undergraduate Advanced Data Analysis](https://www.stat.cmu.edu/~cshalizi/uADA/19/) (Carnegie Mellon University, 2019)
- Cosma Shalizi, [Statistical Computing](https://www.stat.cmu.edu/~cshalizi/statcomp/14/) (Carnegie Mellon University, 2014)
- Cosma Shalizi, [Modern Regression](https://www.stat.cmu.edu/~cshalizi/mreg/15/) (Carnegie Mellon University, 2015)
