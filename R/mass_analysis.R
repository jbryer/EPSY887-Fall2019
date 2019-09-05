##### Load packages

library(tidyverse)
library(psych)
library(readxl)
library(likert)

##### Read in the data files (note there are four sheets in the Excel file)

mass1 <-  # Summer 2014
mass2 <-  # Fall 2014
mass3 <-  # Summer 2015
mass4 <-  # Fall 2019

items <- c('I find math interesting.',
		   'I get uptight during math tests.',
		   'I think that I will use math in the future.',
		   'Mind goes blank and I am unable to think clearly when doing my math test.',
		   'Math relates to my life.',
		   'I worry about my ability to solve math problems.',
		   'I get a sinking feeling when I try to do math problems.',
		   'I find math challenging.',
		   'Mathematics makes me feel nervous.',
		   'I would like to take more math classes.',
		   'Mathematics makes me feel uneasy.',
		   'Math is one of my favorite subjects.',
		   'I enjoy learning with mathematics.',
		   'Mathematics makes me feel confused.')

##### Create a new variable called Term for each of the data frames


##### Merge the four data.frames into one data.frame

mass <- 

##### Explore the data

# View the first 6 rows of the data.frame

	
# View the last 4 rows of the data.frame


# How many rows are in the data.frame?


# How many columns are in the data.frame?


# What are the names of the variables/columns?


# How many males and females completed the survey?


# Display the rows that have at least one missing value.


# Calculate a total score for each student
total <- 

# Calculate mean, median, and standard deviation of the total score





# Calculate descriptive statistics by gender


##### Analyze using the likert package

# Recode the responses to factors


# Verify the recoding working by looking at the structure of the data.frame


# Rename the columns using the items vector above



# Call the likert function and print the summary results



# Plot the results


# Call the likert function but now add the Term as a grouping variable





# Plot the results


