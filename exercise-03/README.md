# DSR: Exercise 3

This exercise focuses on

- using RStudio to set up a project (code and data)
- code essentials: creating a script, loading required packages
- data essentials: creating data frames from external data sources
- data cleaning and preparation

This is _not_ an easy exercise: work with your group, and get ready to spend a couple of hours on it.

## Prerequisites

- Prior to completing the following exercise, open RStudio and set the `exercise-03` folder as the working directory.

- Also check that you have installed the packages used in previous classes, as they will probably come in handy.

- Do not forget to load them at the beginning of your script if you use their functions.

- Do not forget to comment your code appropriately.

## Scenario

You are interning at the Brussels office of [Human Rights Watch][hrw], and have been asked to verify whether some form of disaffection with democracy shows up in Eurobarometer survey data for Poland and Hungary.

[hrw]: https://www.hrw.org/

## Instructions

Note -- the hints below cite some R help pages, but you can also browse those pages online, by going, for instance, to the [`dplyr` website](https://dplyr.tidyverse.org/). You should also feel free to find solutions online: use your best search skills.

1. Download the [Eurobarometer trend line for 'satisfaction with democracy in your country'][eb] to the `data` folder. Feel free to open it in a spreadsheet editor to take a first look at it.

[eb]: https://europa.eu/eurobarometer/about/other

2. The data you just downloaded comes as an Excel spreadsheet. Create a new script in the working directory, and write the required code to load the 'EU', 'HU' and 'PL' sheets of the spreadsheet into three data frames.

    _Hint_ -- You will need to skip a few rows in order for the columns to receive the right column names: `?readxl::read_excel`.

3. Add a `country` column to each data frame to identify the 'country' as either `"EU"`, `"PL"` or `"HU"`, and then assemble all three data frames into a single one.

    _Hint_ -- There are multiple ways to do this, but an efficient way to achieve the second step is to use `dplyr::bind_rows`.

4. Adapt the following code to your own in order to restrict the dataset to specific columns while renaming them at the same time:

    ```
    select(
      your_dataset,
      country,
      year = `...1`,
      not_satisfied = `Total 'Not satisfied'`
      )
    ```

    _Hint_ -- I'm giving the code here, because it is not that obvious, but you will have to find a way to make it work with your own code.

5. Rename the first column as `"year"`, and 'clean it' in order for it to contain only the year in which each row was measured.

    _Hint_ -- This is harder, because you have to use a [regular expression][regex]. Here's the hardest part: `\\d{4}` will match any 4-digit number. Now, find the right function(s) to make use of that hint…

[regex]: https://stringr.tidyverse.org/articles/regular-expressions.html

6. The `year` column sometimes contains mutiple measures for the same country-year pair/dyad. Group the dataset by country and year, and compute the averages of the two 'satisfaction' variables.

    _Hint_ -- `?dplyr::group_by` and `?dplyr::summarise`.
  
7. Sort the data by year and country, and check that you are looking at something that matches this:

    ```
     country year  not_satisfied
     <chr>   <chr>         <dbl>
   1 EU      2007           0.39
   2 HU      2007           0.73
   3 PL      2007           0.47
   4 EU      2010           0.44
   5 HU      2010           0.64 ...
    ```

8. You can now plot the data:

    ```r
    ggplot(your_dataset) +
    aes(x = as.integer(year), y = not_satisfied, color = country)) +
      geom_point() +
      geom_line(aes(group = country)) +
      scale_color_manual(
        values = c(
          "EU" = "steelblue",
          "PL" = "darkred",
          "HU" = "orange"
        )
      )
    ```

    _Hint_ -- I'm once again giving the code here, but you will have to find a way to make it work with your own code.

If you got there: well done! If not: try harder, and do not get discouraged -- data preparation is the hardest part :)
