##### Load R Packages
library(tidyverse)
library(readxl)
library(reshape2)

##### Read in data files

# See for an overview https://www.gapminder.org/fw/world-health-chart/whc2017/
# Source: https://www.gapminder.org/data/geo/
countries <- read_xlsx('datasets/gapminder/Data Geographies - v1 - by Gapminder.xlsx', 
					    sheet = 2)
# Source: https://www.gapminder.org/data/documentation/gd004/
life_expectancy <- read_xlsx('datasets/gapminder/lex-by-gapminder.xlsx', 
						sheet = 2)
# Source: https://www.gapminder.org/data/documentation/gd003/
population <- read_xlsx('datasets/gapminder/Data Population - v5 - 1800 to 2100 World Regions and Countries by Gapminder.xlsx',	
						sheet = 'data-countries-etc-by-year-colu')
# Source: https://www.gapminder.org/data/documentation/gd001/
income <- read_xlsx('datasets/gapminder/gdppc_cppp-by-gapminder.xlsx',
					    sheet = 2)

##### Data exploration

names(countries)
names(life_expectancy)
names(income)
names(population)

##### Data preparation

# Because life_expectancy and income have overlapping column names, we need
# to rename them so we can identify the columns in the merged dataset
names(life_expectancy)[5:ncol(life_expectancy)] <- paste0('le_', 
							names(life_expectancy)[5:ncol(life_expectancy)])
names(income)[5:ncol(income)] <- paste0('income_', names(income)[5:ncol(income)])
names(population)[4:ncol(population)] <- as.character(as.integer(names(population)[4:ncol(population)]))
names(population)[4:ncol(population)] <- paste0('pop_', 
							names(population)[4:ncol(population)])

gapminder <- merge(countries, 
				   life_expectancy, 
				   by = 'geo', 
				   all.x = TRUE)
gapminder <- merge(gapminder,
				   income,
				   by = 'geo', 
				   all.x = TRUE)
gapminder <- merge(gapminder,
				   population,
				   by = 'geo',
				   all.x = TRUE)
names(gapminder)

# We'll create a variable for the year we want to look at. As we will
# see later, we can change this variable and create the figure for a different
# year quickly.
year <- '2017' 

# Subset the gapminder data.frame to include only the columns we are interested in
gapminder2 <- gapminder %>%
	rename(name = name.x) %>%
	select(geo, name, four_regions,
		   paste0('income_', year),
		   paste0('pop_', year),
		   paste0('le_', year)) %>%
	rename(income = paste0('income_', year),
		   population = paste0('pop_', year),
		   life_expectancy = paste0('le_', year))

# https://www.gapminder.org/topics/four-income-levels/
income_levels <- c(2 * 356,
				   8 * 356,
				   32 * 356)
income_levels_df <- data.frame(
	position = c(0, income_levels),
	label = c('Level 1', 'Level 2', 'Level 3', 'Level 4')
)

##### Build the graphic

ggplot(gapminder2, aes(x = income, y = life_expectancy, 
					   size = population, color = four_regions)) +
	geom_vline(xintercept = income_levels, alpha = 0.5) +
	geom_text(data = income_levels_df, aes(x = position, label = label), 
			   color = 'black', size = 3, y = 50, hjust = -0.1) +
	geom_point() +
	scale_x_log10(labels = function(x) { prettyNum(x, big.mark=',', scientific=F) }) +
	scale_color_brewer('Region', type = 'qual', palette = 6) +
	xlab('Income (GDP per capita, log transformed)') +
	ylab('Life Expectancy (in years)') +
	ggtitle('World Health Chart 2017', subtitle = 'Data Source: Gapminder') +
	theme_minimal()

