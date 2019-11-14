library(tidyverse)
library(foreign)
library(readxl)

if(!file.exists('datasets/pisa/2015/PISA_Student.rds')) {
	pisa2015.student <- foreign::read.spss('datasets/pisa/2015/PUF_SPSS_COMBINED_CMB_STU_QQQ/CY6_MS_CMB_STU_QQQ.sav',
								 use.value.labels = TRUE, to.data.frame = TRUE)
	saveRDS(pisa2015.student, file = 'datasets/pisa/2015/PISA_Student.rds')
}

if(!file.exists('datasets/pisa/2015/PISA_Cognitive.rds')) {
	pisa2015.cognitive <- foreign::read.spss('datasets/pisa/2015/CY6_MS_CMB_STU_COG.sav')
	saveRDS(pisa2015.cognitive, file = 'datasets/pisa/2015/PISA_Cognitive.rds')
}

codebook2015 <- read_xlsx('datasets/pisa/2015/Codebook_CMB.xlsx')

codebook2015 %>% filter(!is.na(NAME)) %>% View(title = 'PISA_Vars')

pisa2015.student <- readRDS('datasets/pisa/2015/PISA_Student.rds')
pisa2015.cognitive <- readRDS('datasets/pisa/2015/PISA_Cognitive.rds')

korea <- pisa2015.student %>% filter(CNT == 'Korea')
