# DSR: Exercise 10 (graded)

This exercise focuses on fitting and interpreting _multiple_ linear regression models.

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

You are working for a think tank interested in testing the contemporary relevance of the results published in Tim Immerzeel and Frank van Tubergen, "[Religion as Reassurance? Testing the Insecurity Theory in 26 European Countries][doi]", _European Sociological Review_ 29(2): 359–372, 2013.

[doi]: https://doi.org/10.1093/esr/jcr072

## Instructions

### 1. Access a dataset

Download a copy of the [European Social Survey][ess] (ESS), Round 9, Edition 3.1, in SPSS format (`.sav`), and place it in the `data` folder.

[ess]: http://www.europeansocialsurvey.org/

__Import the dataset in R__, writing your code in Section 1 of the answers script.

### 2. Recode some variables

Find the variables below in the ESS documentation, and recode them as instructed below, writing your code in Section 2.2 of the answers script:

- __Age__ should not be modified, and should thus measure age in years.
- __Sex__ should be coded as a 'dummy' coding `1` for females.
- __Employment relationship__ should not be modified, and should thus code `1` for employees, `2` for self-employed, and `3` for working for own family business.
- __Marital status__ should be recoded into three groups, as follows:
  - legally married or in a civil union
  - separated, divorced or widowed
  - none of those (never married or else)
- __Subjective income__ ("Feeling about household's income nowadays") should not be modified, and should thus contain 4 ordered response items.

Last, recode __religious attendance__ (variable `rlgatnd`) in order for the variable to measure religious attendance from `0` for 'never' to `6` for 'every day.'

### 3. Write a linear model

Using the variables created in the previous section, predict religious attendance from age, sex, employment relationship, marital status and subjective income, for the entire ESS data sample.

In that model, include an interaction between sex and marital status, in order for your model to include coefficients for those predictors _as well as for their product_.

### 4. Interpret regression results

__Answer Questions 4.1, 4.2 and 4.3__ at the end of that section. The answers should go at the top of the script, in the header section, on the lines starting with `[ANSWER 4.1]`, `[ANSWER 4.2]` and `[ANSWER 4.3]`. The same logic applies to all questions below.

### 5. Diagnose a linear regression model

Write up the combination of regression diagnostics that you think will provide the best assessment of whether the model performed well.

__Answer Question 5__ at the end of that section.

### 6. Start thinking beyond 'flat' models

Re-estimate the same model as before, but include the country of residence of the respondent.

__Answer Questions 6.1 and 6.2__ at the end of that section. Note that Question 6.2 is a hard question, which you should skip if you find it too difficult.

## Submission instructions

Please [email me](mailto:francois.briatte@sciencespo.fr) your group's answers as a single R script called `exercise-10-Group-01.r`, where `01` is your group number, as stated in the groups spreadsheet on Google Drive.

Please send me that email __at most 10 days after the class during which you received this exercise__.

You do _not_ need to also attach the data and/or the rest of the `exercise-10` folder -- the answers will be enough.

Use the email subject __"DSR: Answers to Exercise 10, Group 01"__, where `01` once again designates your group number. That information should also appear at the top of your script, in the code header.

Make sure to complete the rest of the code header with your feedback.

---

Thanks a lot for your work!
