# DSR: Exercise 9 (graded)

This exercise focuses on fitting and interpreting linear regression models.

Make sure to read extensively on the topic prior to completing the exercise, especially if you have not worked with linear models for a while.

__This is a _graded_ exercise__, to be completed within your group, and within your group _only_ --- do not communicate between groups. All other school regulations regarding student ethics and plagiarism obviously apply.

All answers are to be provided directly in the 'answers' script. The code should produce the results reported in the 'Answers' section at the top of the script.

Some further important coding requirements:

- It must run (execute) properly.
- It should be __as simple and legible__ as possible.
- Consequently, it should use __as few packages__ as possible.
- Concision (coding/writing that is __short__ and __clear__) is _very much_ valued.
- Comment lines should _not_ go over 80 characters per line.
- Include the code to load packages, but _not_ the code to install them.
- There will be grades assigned to all requirements above.

## Scenario

You are a student at the University of Chicago during the Covid-19 pandemic, and have been assigned to [predict the occurrence of country-wide lockdowns][harris].

[harris]: https://harris.uchicago.edu/news-events/news/harris-students-analyze-government-response-pandemic

## Instructions

The `data` subfolder contains a copy of Table A1 in Dimiter Toshkov, Kutsal Yesilkagit and Brendan Carroll, "[Government Capacity, Societal Trust or Party Preferences? What Accounts for the Variety of National Policy Responses to the COVID-19 Pandemic in Europe?][toshkov]" (_Journal of European Public Policy_, 2022).

[toshkov]: https://doi.org/10.1080/13501763.2021.1928270

Take a look at the paper to understand what is measured in the table.

### 1. Access a dataset

Import the dataset, writing your code in Section 1 of the answers script.

### 2. Create new variables

Find a way to create two variables, `till_schools` and `till_lockdown`, measuring the number of days between the first case of Covid-19 in the country and the occurrence of school closures (`till_schools`) and national lockdowns (`till_lockdown`).

__Answer Questions 2.1 and 2.2__ at the end of that section. The answers should go at the top of the script, in the header section, on the lines starting with `[ANSWER 2.1]` and `[ANSWER 2.2]`. The same logic applies to all questions below.

### 3. Describe the data

__Answer Questions 3.1 and 3.2__ at the end of that section, with code to show how you obtained your results. Round non-integer numbers to 2 digits max.

### 4. Model a linear relationship

Predict the number of days from the first case of Covid-19 to a national lockdown, using (i) the number of Covid-19 cases that had been reported when lockdown was adopted, and (ii) the population size of the country.

Use the distribution of both predictors to determine whether they might benefit from a logarithmic transformation, and if relevant, estimate several models, and select the one that performs best.

Write your code in Section 4 of the answers script, and __answer Questions 4.1 to 4.4__ in that section, writing your answers at the top of the script as short paragraphs of maximum 3 lines. Round any non-integer numbers to 2 digits max.

### 5. Diagnose a linear regression model

Run further diagnostics on the best linear model that you identified at Step 4, and __answer Questions 5.1 and 5.2__ at the end of that section, with code to show how you obtained your results. Round non-integer numbers to 2 digits max.

## Submission instructions

Please [email me](mailto:francois.briatte@sciencespo.fr) your group's answers as a single R script called `exercise-09-Group-X.r`, where `X` is your group number, as stated in the groups spreadsheet on Google Drive.

You do _not_ need to also attach the data and/or the rest of the `exercise-09` folder -- your code will be enough.

Use the email subject __"DSR: Answers to Exercise 9, Group X"__, where `X` once again designates your group number. That information should also appear at the top of your script, in the code header.

Make sure to complete the rest of the code header with your feedback. I'm interested in what you feel you have and have _not_ understood so far in the course, and what you find most difficult with it. Feedback on the exercise is also naturally welcome.

## Deadline

Please fill in your answers and email me your code __before our next class__.

---

Thanks a lot for your work!
