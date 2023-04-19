# DSR: Exercise 5 (graded)

This exercise focuses on

- making use of code that was distributed to you earlier
- exploring a survey dataset (and reading its documentation)
- recoding variables and producing summary statistics
- finding help online when required

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

You are interning at _The Economist_ data science team, and have been asked to reexamine the data that supported their 2019 article [‘Arabs are losing faith in religious parties and leaders’][economist].

[economist]: https://www.economist.com/graphic-detail/2019/12/05/arabs-are-losing-faith-in-religious-parties-and-leaders

## Instructions

### 1. Access a dataset

Download the _Stata_ version of the [Arab Barometer, Wave V (2018-2019)][ab5] dataset. Move it to the `data` folder. After doing so, __import the dataset__, writing your code in Section 1 of the answers script.

[ab5]: https://www.arabbarometer.org/surveys/arab-barometer-wave-v/

The dataset is well-documented on the Arab Barometer website. Download any relevant documentation, and use it to identify the variables and other information that you will need to answer the rest of the exercise.

__Answer Questions 1.1 and 1.2__ at the end of that section. The answers should go at the top of the script, in the header section, on the lines starting with `[ANSWER 1.1]` and `[ANSWER 1.2]`. The same logic applies to all questions below.

### 2. Subset and count observations

Restrict your dataset to the country listed next to your group in the groups spreadsheet on Google Drive. Write your code in Section 2 of the answers script.

In that same section, write some code to __determine the size of your sample__.

__Answer Question 2__ at the end of the section.

### 3. Create a dummy variable

Recode the variable for sex as a new dummy variable called `female`, where `TRUE` means that the respondent is female and `FALSE` that the respondent is male.

In that same section, write some code to __determine whether there are more females than males__ in your sample.

__Answer Question 3__ at the end of the section.

### 4. Recode missing values

Recode the variable for age as a new variable called `age`. The variable should be equal to `NA` if the respondent's age is missing.

In that same section, write some code to __count the missing values__ of that new variable in your sample.

__Answer Question 4__ at the end of the section.

### 5. Plot a distribution

Make a _single_ plot that shows _both_ the distribution of `age` for males and females respectively.

This question only requires writing code.

### 6. Describe a continuous variable

Write some code to produce the average, median and 80th percentile of `age`.

__Answer Questions 6.1 and 6.2__ at the end of the section.

### 7. Recode variables

1. Recode `age` into the following age groups: __16-24, 25-34, 35-44, 45-54, 55-64, 65+__.
2. Recode variable __Q201b item 12__ as a new dummy variable called `trust`, making it equal to `1` if the respondent stated having 'a great deal' or 'quite a lot' of trust in Islamist parties, and `0` if he or she declared having 'not a lot' of trust or 'no trust at all.'
3. Compute percentages of `trust` in Islamist parties by age group, and find a way to determine which group reported the highest level (percentage) of trust in those parties.
4. Find a way to compare the level of trust in Islamist parties of males and females, using the same definition of that level as above, and compute the __difference between females and males__, in _percentage points_.

The code for all steps above should show in your answer, in the same order as the steps themselves.

__Answer Questions 7.1 and 7.2__ at the end of the section.

### 8. Test a relationship

Find a way to submit the last relationship that you explored above through a __statistical hypothesis test__ that compares the level of trust in Islamist parties of females to that of males.

__Answer Question 8__ at the end of the section. This is possibly the hardest question of the exercise, so feel free to call it quits if you have no idea of how to answer it: I will _not_ be assigning too many grades to that question.

## Submission instructions

Please [email me](mailto:francois.briatte@sciencespo.fr) your group's answers as a single R script called `exercise-05-Group-01.r`, where `01` is your group number, as stated in the groups spreadsheet on Google Drive.

Please send me that email __at most 10 days after the class during which you received this exercise__.

You do _not_ need to also attach the data and/or the rest of the `exercise-05` folder -- the answers will be enough.

Use the email subject __"DSR: Answers to Exercise 5, Group 01"__, where `01` once again designates your group number. That information should also appear at the top of your script, in the code header.

Make sure to complete the rest of the code header with your feedback.

---

Thanks a lot for your work!
