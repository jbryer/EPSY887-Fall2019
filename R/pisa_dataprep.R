library(tidyverse)
library(foreign)
library(readxl)

pisa2015 <- foreign::read.spss('datasets/pisa/2015/PUF_SPSS_COMBINED_CMB_STU_QQQ/CY6_MS_CMB_STU_QQQ.sav',
							 use.value.labels = TRUE, to.data.frame = TRUE)

saveRDS(pisa15, file = 'datasets/pisa/2015/PISA_Student.rds')

codebook2015 <- read_xlsx('datasets/pisa/2015/Codebook_CMB.xlsx')

codebook2015 %>% filter(!is.na(NAME)) %>% View(title = 'PISA_Vars')

pisa2015 <- readRDS('datasets/pisa/2015/PISA_Student.rds')

korea <- pisa2015 %>% filter(CNT == 'Korea')
