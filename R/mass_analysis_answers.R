##### Load packages

library(tidyverse)
library(psych)
library(readxl)
library(likert)

##### Read in the data files (note there are four sheets in the Excel file)

mass1 <- read_xlsx('datasets/MathAnxiety.xlsx') # Summer 2014
mass2 <- read_xlsx('datasets/MathAnxiety.xlsx', sheet = 2) # Fall 2014
mass3 <- read_xlsx('datasets/MathAnxiety.xlsx', sheet = 3) # Summer 2015
mass4 <- read_xlsx('datasets/MathAnxiety.xlsx', sheet = 4) # Fall 2019

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
mass1$Term <- 'Summer 2014'
mass2$Term <- 'Fall 2014'
mass3$Term <- 'Summer 2015'
mass4$Term <- 'Fall 2019'

##### Merge the four data.frames into one data.frame

test1 <- mass1
test2 <- mass2
names(test1)[1] <- 'Sex'
rbind(test1, test2)

mass <- rbind(mass1, mass2, mass3, mass4)

##### Explore the data

# View the first 6 rows of the data.frame
head(mass)
mass[1:6,]
mass[c(1,2,3,4,5,6),]
test <- c(rep(TRUE, 6), rep(FALSE, nrow(mass) - 6))
length(test)
mass[test,]

# View the last 4 rows of the data.frame
tail(mass, n = 4)

# How many rows are in the data.frame?
nrow(mass)
dim(mass)[1]

# How many columns are in the data.frame?
ncol(mass)
dim(mass)[2]

# What are the names of the variables/columns?
names(mass)

# How many males and females completed the survey?
table(mass$Gender, useNA = 'ifany')
table(mass$Gender, useNA = 'always')

# Display the rows that have at least one missing value.
complete.cases(mass)
!complete.cases(mass)
mass[!complete.cases(mass),]

# Calculate a total score for each student
View(mass[,2:15])
mass$q1 + mass$q2 + mass$q3 # etc.
sum(mass[,2:15], na.rm = TRUE)
mass$Total <- apply(mass[,2:15], 1, sum, na.rm = TRUE)

# Calculate the average score for each student
mass$Average <- apply(mass[,2:15], 1, mean, na.rm = TRUE)


# Calculate mean, median, and standard deviation of the average score
mean(mass$Average)
median(mass$Average)
sd(mass$Average)

describe(mass$Average)

# Calculate descriptive statistics by gender
describeBy(mass$Average, group = mass$Gender, mat = TRUE)

# Calculate descriptive statistics by gender and term
desc <- describeBy(mass$Average, 
		   group = list(mass$Gender, mass$Term), 
		   mat = TRUE)


##### Analyze using the likert package

# Recode the responses to factors
unique(mass$q1)
f1 <- factor(mass$q1,
			 levels = c(1, 2, 3, 4, 5))

f1

f1.6 <- factor(mass$q1,
			 levels = c(1, 2, 3, 4, 5, 6))

f1.6

table(f1)
table(f1.6)

f1 <- factor(mass$q1,
			 levels = c(1, 2, 3, 4, 5),
			 labels = c('Strongly Disagree',
			 		   'Disagree',
			 		   'Neutral',
			 		   'Agree',
			 		   'Strongly Agree'), 
			 ordered = TRUE)
f1

table(f1)

for(i in 2:15) {
	mass[,i] <- factor(mass[,i,drop=TRUE],
					  levels = c(1, 2, 3, 4, 5),
					  labels = c('Strongly Disagree',
					  		   'Disagree',
					  		   'Neutral',
					  		   'Agree',
					  		   'Strongly Agree'),
					  ordered = TRUE)
	
}

# Verify the recoding working by looking at the structure of the data.frame
str(mass)

# Rename the columns using the items vector above
names(mass)[2:15] <- items
names(mass)

# Call the likert function and print the summary results
l <- likert(mass[,2:15])
View(summary(l))

# Plot the results
plot(l)

# Current term only
l2 <- likert(mass[mass$Term == 'Fall 2019' ,2:15])
plot(l2)

# Call the likert function but now add the Term as a grouping variable
lg1 <- likert(mass[,2:8], grouping = mass$Term)
plot(lg1)

lg2 <- likert(mass[,9:15], grouping = mass$Term)
plot(lg2)

