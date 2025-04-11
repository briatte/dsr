# DSR: Exercise 5 (graded)

This exercise focuses on

- making use of code that was distributed to you earlier
- exploring a survey dataset (and reading its documentation)
- recoding variables and producing summary statistics
- finding help online when required

__This is a _graded_ exercise__, to be completed within your group, and within your group _only_ --- do not communicate between groups. All other school regulations regarding student ethics and plagiarism obviously apply.

You will need to do two things to answer this exercise:

1. __Go to the groups spreadsheet on Google Drive, and look at the 'Exercise 5' tab.__ Your group has been assigned a specific country to work with: make a note of it. Then, use that sheet to report the answers to the questions below.

2. In parallel, you will also need to __email me an R script that produces the answers that you reported in the document above.__ Some important coding requirements to consider follow:

    - Your code must run (execute) properly, without any adjustment.
    - Your code should be __as simple and legible__ as possible.
    - Consequently, your code should use __as few packages__ as possible.
    - Concision (coding/writing that is __short__ and __clear__) is _very much_ valued.
    - Comment lines should _not_ go over 80 characters per line.
    - Include the code to load packages, but _not_ the code to install them.

    There will be grades assigned to all requirements above.

    Further instructions on how to submit your R script by email appear at the end of this document, along with an __important note__ about what help you are allowed to use in order to complete the exercise.

## Scenario

You are interning at _The Economist_ data science team, and have been asked to reexamine the data that supported their 2019 article [‘Arabs are losing faith in religious parties and leaders’][economist].

[economist]: https://www.economist.com/graphic-detail/2019/12/05/arabs-are-losing-faith-in-religious-parties-and-leaders

For more context on why it might be interesting to look at that data right now, see e.g. [‘To what extent do Gazans support Hamas?’][afonso23] and the literature that it cites.

[afonso23]: https://alexandreafonso.substack.com/p/5-to-what-extent-do-gazans-support

## Instructions

### 1. Access a dataset

Download the ___Stata___ versions of the [Arab Barometer][ab] dataset for __survey years 2012-14 and 2021-22__. Move them to the `data` folder of the exercise, and do not rename them. After doing so, __import the datasets__, writing your code in Section 1 of the answers script.

[ab]: https://www.arabbarometer.org/

The datasets are well-documented on the [Arab Barometer][ab] website. Download any relevant documentation, and use it to identify the variables and other information that you will need to answer the rest of the exercise.

### 2. Subset and count observations

Now, restrict each dataset to the country listed next to your group in the 'answers' spreadsheet on Google Drive. Write your code in Section 2 of the answers script.

In that same section, also write some code to __determine the size of each of your two samples__ (one for each survey wave). Report both sample sizes as __Answer 1__ in the aforementioned spreadsheet.

At that stage, note that all further questions, except for the very last one, will focus on the _2021-22 sample_.

### 3. Create a dummy variable

In Section 3 of the script, recode the variable for sex as a new dummy variable called `female`, where `TRUE` means that the respondent is female and `FALSE` that the respondent is male.

In that same section, write some code to __determine whether there are more females than males__ in your sample. Report your answer as __Answer 2__, which should be either `TRUE` or `FALSE`.

### 4. Recode missing values

In Section 4 of the script, recode the variable for age as a new variable called `age`. The variable should be equal to `NA` if the respondent's age is missing.

In that same section, write some code to __count the missing values__ of that new variable in your sample. Report that quantity as __Answer 3__.

### 5. Plot a distribution

In Section 5 of the script, write some code to produce a _single_ plot that allows to compare the distribution of age among males and females.

_Save the plot_ as a PDF, and send it along _with your answers script_ when you submit it by email.

### 6. Describe a continuous variable

In Section 6 of the script, write some code to produce the average, median and 80th percentile of `age`.

Report that last statistic as __Answer 4__.

### 7. Recode variables

In Section 7 of the script:

1. Recode `age` into the following age groups: __16-24, 25-34, 35-44, 45-54, 55-64, 65+__.

2. Then, recode variable __Q201b item 12__ as a new dummy variable called `trust`, making it equal to `1` if the respondent stated having 'a great deal' or 'quite a lot' of trust in Islamist parties, and `0` if he or she declared having 'not a lot' of trust or 'no trust at all.'

3. Now, compute percentages of `trust` in Islamist parties by age group, and find a way to determine which group reported the highest level (percentage) of trust in those parties.

    In your sample, is the highest age group the one that reports the highest level of trust in Islamist parties? Write down your answer as __Answer 5__, which should be either `TRUE` or `FALSE`.

4. Last, find a way to compare the level of trust in Islamist parties of males and females, using the same definition of that level as above, and compute the __difference between females and males__, in _percentage points_.

    Report that quantity as __Answer 6__.

### 8. Test a relationship

In Section 8, find a way to submit the last relationship that you explored above through a __statistical hypothesis test__ that compares the average level of trust in Islamist parties of females to that of males.

That test should lead you to answer the following question:

> In your sample, do females statistically differ from males in their level of trust in Islamist parties?

Report your answer as __Answer 7__, which should be either `TRUE` or `FALSE`.

### 9. Report percentages

In Section 9, compute the percentage of respondents for which trust in Islamist parties is missing.

Report that quantity as __Answer 8__.

Then, in that same section, compute the percentage of respondents who trust Islamist parties for both the 2021-22 sample, which you have been working on for most of the exercise, and for the 2012-14 sample, which you loaded at the beginning of the exercise. This step will involve doing some data preparation on that data sample.

Report both quantities as __Answer 9__. This answer will tell you whether the trend observed in the [original _Economist_ article][economist] has persisted since 2019 in the country that you studied.

_Bonus step (ignore if everything else above has been too challenging)_ --- To produce nationally representative results with maximum accuracy, you will need to adjust (and thus recompute) the percentages that you obtained above by using an additional variable. See if you can find out what that variable might be, and what to do with it, by exploring the Arab Barometer data and technical documentation.

## Submission instructions

Please [email me](mailto:francois.briatte@sciencespo.fr) your group's R script as a single file named `exercise-05-Group-X.r`, where `X` is your group number, as stated in the groups spreadsheet on Google Drive. Also attach the plot that you produced to answer Section 5 of the exercise, after naming it in the same way.

You do _not_ need to also attach the data and/or the rest of the `exercise-05` folder -- your code and plot will be enough.

Use the email subject __"DSR: Answers to Exercise 5, Group X"__, where `X` once again designates your group number. That information should also appear at the top of your script, in the code header.

Make sure to complete the rest of the code header with your feedback. I'm interested in what you feel you have and have _not_ understood so far in the course, and what you find most difficult with it. Feedback on the exercise is also naturally welcome.

Please turn to the next page for final instructions.

## Important note on helpers

For this exercise, you are allowed to use any help that you might find online, at the exception of the following:

- You are _not_ allowed to submit the exercise to anyone outside of your group, which means that you are not allowed to submit it to an online forum such as StackOverflow, although you are very much welcome to read answers to R-related questions on that website and any other.

- You are _not_ allowed to submit the exercise to a generative artificial intelligence (AI), which means that the code that you will submit should _not_ come from ChatGPT or equivalent technology. You are welcome to use generative AI on ungraded work, as a learning tool, but not for graded coursework.

Please be reminded that I will assess your code partly on its legibility and clarity: answers that show a poor understanding of what the code does, or what its results mean, will be graded accordingly.

## Deadline

Please fill in your answers and email me your code __before our next class__.

---

Thanks a lot for your work!
