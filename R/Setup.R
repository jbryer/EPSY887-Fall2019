# Setup R environment for EPSY 887. See https://epsy887.bryer.org for more information.

# Install R packages
install.packages(c('devtools', 'tidyverse', 'psych', 'reshape2',
				   'blogdown', 'bookdown', 'shiny', 'markdown', 'knitr',
				   'foreign',
				   'openintro', 'OIdata', 'fivethirdyeight'))
devtools::install_github('jbryer/likert')
devtools::install_github("jbryer/DATA606")
