# ==============================================================================
#  ____  _____ _____
# |    \|   __| __  |  Data Science with R
# |  |  |__   |    -|  Fall 2024
# |____/|_____|__|__|
#
# Weird R syntax
#
# Instructions:
#
# 1. Do the homework/readings first (seriously, you will need it)
#
# 2. Then go through the code below and try answering the questions
#    (Feel free to skip questions marked as harder.)
#
# ============================= See README file for data sources and details ===


# packages ----------------------------------------------------------------

# install a package (required only once); uncomment the line below to run it
# install.packages("remotes")

# once a package is installed, load it (required once per work session)
library(remotes)

# this makes all functions of the package available, such as this one:
remotes::install_cran("tidyverse", force = FALSE)

# the syntax above includes the package name, which enables the function to
# operate even if the package has not been loaded; I sometimes use that syntax
# to show which package provides which function, but most code won't show it

# note that the code above will produce some messages -- results printed in
# colour to let you know what happened (or what did not happen) as a result
# of you running the code

# some code will generate warnings
remotes::install_cran("imaginary_package")

# some code will generate errors
remotes::imaginary_function("whatever")

# all messages are printed in the same colour, but only errors will stop your
# code from running properly

# one of the most common errors is forgetting to set the working directory to
# the folder that actually contains the files that you are trying to use


# packages, functions, arguments ------------------------------------------

# - when you executed line 18 above, the `install_cran` function, which comes
#   from the {remotes} package, installed the {tidyverse} package; that is
#   because you passed the "tidyverse" argument to it
#
# - the `force = FALSE` argument is an optional argument that allows you to
#   force the installation of the package even if it already exists in your
#   "library" (folder) of packages; set the argument to TRUE to do that

# another example of the package::function(argument) syntax
dplyr::nth(LETTERS, 5)

# when you executed line 18, the {dplyr} package was installed alongside the
# {tidyverse} package; there are thousands of packages, and they form a vast
# network, with some packages depending on others to work

# [QUESTION]: what do you need to do in order for the following line of code to
# work, and what does that line of code actually do?
nth(LETTERS, 6)


# math and logic ----------------------------------------------------------

TRUE == 1
FALSE == 0

2^3 >= 2 * 2 * 2
2^3 != 8 # note: `!` means `not` in computer languages

# [QUESTION]: compute my Body Mass Index (height 1.76, weight 67.5), and find
# out whether I am clinically overweight (BMI >= 25)


# other special values ----------------------------------------------------

# two functions, one nested in the other
log(exp(1))

# special value: (negative) Infinity
log(0)

# special value: Not a Number
log(-1)

# special value: Missing (Not Available)
log(0) > log(-1)

# in practice, you will encounter a lot of NA's, some TRUE and FALSE values,
# and hopefully not so much of the rest

# one last special value, rarely encountered, and which stands for absolute
# nothingness (not zero, not missing)
NULL


# screen messages ---------------------------------------------------------

# innocuous
message("this is fine")

# possibly problematic
sqrt(-1)

# definitely problematic
sqrt("Nicolas Cage")

# adjust your reaction accordingly: read messages, ask yourself if everything
# is fine when you see warnings, and stop when you see errors, which are the
# only type of message that will stop your code from executing


# objects -----------------------------------------------------------------

# create a vector (sequence) of values
x <- 3:1
x

# the length of object `x` is its number of values
length(x)

# the object `x` holds numeric values (specifically, integer values)
class(x)

# text ('strings' of characters), recognizable by the "double quotes"
class("Nicolas Cage")

# non-integer numbers (classes and types are not exactly the same thing)
typeof(9/2)

# [QUESTION]: explain the results of the following lines (harder exercise)
as.character(x)
as.integer(9/2)
as.numeric("Nicolas Cage")

# the only thing worth remembering here is the `<-` operator for assignment;
# the rest is just to show you some internals of the R programming language,
# which we will dive into only occasionally


# vector operations -------------------------------------------------------

x_squared <- x^2
x_squared

# vectorized logical test
x_squared < 5

# vector element extraction
x_squared[ 1 ]
x_squared[ 2 ]
x_squared[ 3 ]

# [QUESTION]: explain the results of the following lines
x_squared[ c(1, 3) ]
which(x_squared < 5)

# [QUESTION]: explain the results of the following lines (harder exercise)
x_squared[ -1 ]
x_squared[ c(1, 5, NA) ]


# last notes --------------------------------------------------------------

# that last exercise again brought you deeper in the internals of the language
# than we will go most of the time; accept right now that those internals
# exist, and that some of them will remain obscure as you learn the language

# also accept that, as with any language like mathematics or English, there are
# multiple ways to express (to do) the same thing in R
3^2 == 3 * 3
9^(1/2) == sqrt(9)

# [QUESTION]: explain the results of the following lines
logical_test <- c(1, 2, 3) == 3:1
all(logical_test)
any(logical_test)

# [QUESTION]: explain the results of the following lines (much harder exercise)
c(1, 2, 3) >= 1:4 # hint: vector recycling
c(1, 2, 3, "Nicolas Cage") * 2 # hint: type coercion
paste(month.abb[ 1:5 ], strtrim(today(), 4)) # hint: stop smoking weed

# some final takeaways:
#
# - R is a language; treat it as such
# - learning it will involve a lot of trial and error
# - understanding the whole language is not a requirement to use it
# - do your readings and homework, and you will be fine

# what's deliberately missing from this script:
#
# - project management (e.g. setting the working directory)
# - data frames (covered at length in several other sessions)
# - piping with either `|>` or `%>%` (also part of other sessions)
# - more keyboard shortcuts (those will come with practice)

# this is the way
# kthxbye
