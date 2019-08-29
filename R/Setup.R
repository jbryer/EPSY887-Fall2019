# Setup R environment for EPSY 887. See https://epsy887.bryer.org for more information.

# Install R packages
install.packages(c('devtools', 'tidyverse', 'psych', 'reshape2',
				   'blogdown', 'bookdown', 'shiny', 'markdown', 'knitr',
				   'foreign',
				   'openintro', 'OIdata', 'fivethirdyeight'))
devtools::install_github('jbryer/likert')
devtools::install_github("jbryer/DATA606")
# Getting started with Lab 1
library(DATA606)
getwd() # This is your current working directory. The startLab function will
        # create a Lab1 directory there with all the required files.
DATA606::startLab('Lab1')
