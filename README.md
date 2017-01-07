# `>` Introduction to Data Science with R

> [François Briatte](http://f.briatte.org/)  
> Spring 2017

`>` __[Syllabus](https://frama.link/dsr16sy)__

## Participate

* [Create a GitHub account](https://github.com/join) (free).
* To ask a question, use the [issues](https://github.com/briatte/dsr/issues).
* To share your notes, use the [wiki](https://github.com/briatte/dsr/wiki).

> For strictly personal questions, [email me](mailto:francois.briatte@sciencespo.fr).

## 1. Setup

### Code

> The scripts below are short demos that will give you an idea of what you can accomplish from the command line or from R, using a selection of packages designed for data import/export, manipulation and visualization.

- [__Download a full course__ with `wget`](https://github.com/briatte/dsr/blob/master/s1/wget.sh)
- [__Plot macroeconomic data__ with `ggplot2`](https://github.com/briatte/dsr/blob/master/s1/debt.r)

### Read

- [Peng 2016b][peng-2016b], ch. 3 (optional)
- [Urdan 2010][urdan-2010], ch. 1
- [Zumel and Mount 2014][zumel-mount-2014], ch. 1

### See also

- Briatte, F. [R as a Data Science Language](http://f.briatte.org/r/r-as-a-data-science-language)
- Bryan, J. _et al._ [Happy Git and GitHub for the useR](http://happygitwithr.com/)
- Center for Government Excellence. [Data-Science Cheatsheet](https://github.com/govex/Data-Science)
- DataCamp. [DataChats](https://www.youtube.com/playlist?list=PLjgj6kdf_snYAqMEWOlql_DVMPbh8dtP1)
- Deleneuville, M. [Les stratégies open data des 20 plus grandes villes françaises](http://www.journaldunet.com/economie/services/1189782-les-strategies-open-data-des-20-plus-grandes-villes-francaises/)
- Free Software Foundation. [What is Free Software?](https://www.gnu.org/philosophy/free-sw.html)
- Gillespie, C. and Lovelace, R. [Efficient Learning](https://bookdown.org/csgillespie/efficientR/learning.html)
- McNeill, M. [Base R - Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf)
- Schrodt, P. [7 Reasons Political Science “Math Camp” is a Complete Waste of Your Time](https://asecondmouse.wordpress.com/2016/03/14/7-reasons-political-science-math-camp-is-a-complete-waste-of-your-time/)
- Ushey, K. [What is a Function?](https://kevinushey.github.io/blog/2015/11/22/what-is-a-function/) (difficult)
- Wickham, H. [Data Science: How is it Different to Statistics ?](http://bulletin.imstat.org/2014/09/data-science-how-is-it-different-to-statistics%E2%80%89/)

## 2. Data I/O

### Code

> The scripts below all show how to use `dplyr` for data manipulation, `readr` or `readxl` for data import, and `ggplot2` for plotting. They also show how to use a few more packages that you might find useful.

- __[_New York Times_ Brexit Coverage](https://github.com/briatte/dsr/blob/master/s2/nyt-brexit.r)__
  - Demo: data reshaping  with `tidyr` (switching between 'long' and 'wide' formats).
  - Background: Dolšak, N. 2016. [Manufacturing Dissent: How _The New York Times_ Covered the Brexit Vote](http://duckofminerva.com/2016/09/manufacturing-dissent-how-the-new-york-times-covered-the-brexit-vote.html).
  - Source: Dolšak, N. and Prakash, A. 2016. [_The New York Times_’ Coverage of the Brexit Vote](http://faculty.washington.edu/nives/replication_data.html).
- __[Journalists Killed Since 1992](https://github.com/briatte/dsr/blob/master/s2/cpj-journalists.r)__
  - Demos: date manipulation with `lubridate`; country name manipulation with `countrycode`.
  - Background: Committee to Protect Journalists. 2016. [Journalists Killed: Methodology](https://www.cpj.org/killed/methodology.php).
  - Source: Committee to Protect Journalists. 2016. [Journalists Killed since 1992](https://www.cpj.org/killed/).

### Read

- [Grolemund 2014][grolemund-2014], App. A-B, ch. 1-2
- [Grolemund and Wickham 2016][grolemund-wickham-2016], ch. 11
- [Peng 2016a][peng-2016a], ch. 3
- [Peng 2016b][peng-2016b], ch. 6-7, 8 (optional), 9, 12 (optional)
- [Zumel and Mount 2014][zumel-mount-2014], ch. 2

### See also

- Bryan, J. [Sanesheets: A Rant About Spreadsheets](https://github.com/jennybc/sanesheets) (related: [video presentation](https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/jailbreakr-Get-out-of-Excel-free), [slides](https://speakerdeck.com/jennybc/spreadsheets), [sources](https://github.com/jennybc/2016-06_spreadsheets))
- Chen, X. _et al._ [Awesome Public Datasets](https://github.com/caesar0301/awesome-public-datasets)
- Damico, A.J. [MonetDBLite Because Fast](http://www.asdfree.com/2016/06/monetdblite-because-fast.html)
- Gillespie, C. and Lovelace, R. [Efficient Input/Output](https://bookdown.org/csgillespie/efficientR/input-output.html)
- Hester, J. [Database Best Practices. `DBI`, `odbc` and `pool`](https://github.com/jimhester/presentations/blob/master/2016_12_15-CRUG-Database_Best_Practices/CRUG-2016_12_14.Rmd)
- Leek, J. [The Four Eras of Data](http://simplystatistics.org/2016/12/16/the-four-eras-of-data/)
- Luraschi, J. [Importing Modern Data into R](https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/Importing-modern-data-into-R)
- MonetDB. [MonetDB.R Tutorial](https://www.monetdb.org/Documentation/UserGuide/MonetDB-R)
- Onuoha, M. [On Missing Data Sets](https://github.com/MimiOnuoha/missing-datasets)
- Shafranovich, Y. [IETF RFC 4180: Common Format and MIME Type for Comma-Separated Values (CSV) Files](https://tools.ietf.org/html/rfc4180)
- Tennison, J., Kellogg, G. and Herman, I. [W3C: Model for Tabular Data and Metadata on the Web](https://www.w3.org/TR/tabular-data-model/)

## 3. Manipulation

### Code

### Read

- [Grolemund 2014][grolemund-2014], ch. 3-5
- [Peng 2016a][peng-2016a], ch. 4-5
- [Peng 2016b][peng-2016b], ch. 13
- [Urdan 2010][urdan-2010], ch. 2-3, 6-7, 8-9 (optional), 13-14 (optional)
- [Wickham 2014a][wickham-2014a], ch. 2-3 (optional)
- [Wickham 2014b][wickham-2014b] (optional)
- [Zumel and Mount 2014][zumel-mount-2014], ch. 3-4, 5-9 (optional)

### See also

- Bryan, J. [Data Rectangling](https://speakerdeck.com/jennybc/data-rectangling) ([video presentation](https://youtu.be/4MfUCX_KpdE))
- Bryan, J. [Tidy Data Lesson using _Lord of the Rings_ Data](https://github.com/jennybc/lotr-tidy)
- Gillespie, C. and Lovelace, R. [Efficient Data Carpentry](https://bookdown.org/csgillespie/efficientR/data-carpentry.html)
- Kopacka, J. [Basic Regular Expressions in R - Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf)
- Mount, J. [The Case for Index-Free Data](http://www.win-vector.com/blog/2016/12/the-case-for-index-free-data-manipulation/)
- Myles White, J. [Modes, Medians and Means: A Unifying Perspective](http://www.johnmyleswhite.com/notebook/2013/03/22/modes-medians-and-means-an-unifying-perspective/)
- Robinson, D.G. [`broom`: Converting Statistical Models to Tidy Data Frames](https://channel9.msdn.com/Events/useR-international-R-User-conference/useR2016/broom-Converting-statistical-models-to-tidy-data-frames)
- RStudio. [Data Wrangling with `dplyr` and `tidyr` - Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
- Silge, J. and Robinson, D. [Tidy Text Mining](http://tidytextmining.com/)
- Wickham, H. [The Split-Apply-Combine Strategy for Data Analysis](http://vita.had.co.nz/papers/plyr.html)
- Wickham, H. [Tidyverse](http://tidyverse.org/)

## 4. Visualization

### Code

### Read

- [Grolemund and Wickham 2016][grolemund-wickham-2016], ch. 28
- [Peng 2016a][peng-2016a], ch. 6-7, 15-16
- [Wickham 2010][wickham-2010] (optional)
- [Wickham, Cook and Hofmann 2015][wickham-cook-hofmann-2015] (optional)

### See also

- Emaasit, D. [`ggplot2` Extensions](http://www.ggplot2-exts.org/gallery/)
- Healy, K. and Moody, J. [Data Visualization in Sociology](https://kieranhealy.org/files/papers/data-visualization.pdf)
- Hijmans, R. _et al._ [GADM: Global Administrative Areas](http://gadm.org/)
- Nenadic, A. [Generating Google Maps out of Google Spreadsheets](https://www.software.ac.uk/generating-google-maps-out-google-spreadsheets)
- Ognyanova, K. [Network Visualization with R](http://kateto.net/network-visualization)
- RStudio. [Data Visualization with `ggplot2` - Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf)
- Tufte, E. [Edward Tufte Notebooks](https://www.edwardtufte.com/tufte/)
- Tufte, E. [The Future of Data Analysis](https://youtu.be/rHUDJ8RyseQ)
- Unwin, A. [Graphical Data Analysis with R](http://www.gradaanwr.net/)
- Wickham, H. [`ggplot2` Documentation](http://docs.ggplot2.org/current/)

## References

- Grolemund, G. 2014. [Hands-On Programming with R][grolemund-2014]
- Grolemund, G. and Wickham, H. 2016. [R for Data Science][grolemund-wickham-2016]
- Peng, R.D. 2016a. [Exploratory Data Analysis with R][peng-2016a]
- Peng, R.D. 2016b. [R Programming for Data Science][peng-2016b]
- Urdan, T.C. 2010. [Statistics in Plain English][urdan-2010]
- Wickham, H. 2010. [A Layered Grammar of Graphics][wickham-2010]
- Wickham, H. 2014a. [Advanced R][wickham-2014a]
- Wickham, H. 2014b. [Tidy Data][wickham-2014b]
- Wickham, H., Cook, D. and Hofmann, H. [Visualizing Statistical Models][wickham-cook-hofmann-2015]
- Zumel, N. and Mount, J. 2014. [Practical Data Science with R][zumel-mount-2014]

[grolemund-2014]: http://shop.oreilly.com/product/0636920028574.do "'Hands-On Programming with R'"
[grolemund-wickham-2016]: http://r4ds.had.co.nz/ "'R for Data Science'"
[peng-2016a]: https://leanpub.com/exdata "'Exploratory Data Analysis with R'"
[peng-2016b]: https://leanpub.com/rprogramming "'R Programming for Data Science'"
[urdan-2010]: http://www.routledge.com/books/details/9780415872911/ "'Statistics in Plain English'"
[wickham-2010]: http://vita.had.co.nz/papers/layered-grammar.html "'A Layered Grammar of Graphics'"
[wickham-2014a]: http://adv-r.had.co.nz/ "'Advanced R'"
[wickham-2014b]: http://vita.had.co.nz/papers/tidy-data.html "'Tidy Data'"
[wickham-cook-hofmann-2015]: http://vita.had.co.nz/papers/model-vis.html "'Visualizing Statistical Models'"
[zumel-mount-2014]: http://www.win-vector.com/blog/2013/06/what-is-practical-data-science-with-r/ "'Practical Data Science with R'"
