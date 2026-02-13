# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl) 
wide_tbl <- import_tbl %>% separate(., col = qs, into = paste0("q", 1:5))
wide_tbl[, paste0("q", 1:5)] <- sapply(wide_tbl[, paste0("q", 1:5)], as.integer)
wide_tbl <- wide_tbl %>% mutate(datadate = mdy_hms(datadate))
wide_tbl <- wide_tbl %>% mutate(across(paste0("q", 1:5), ~ ifelse(. == 0, NA, .)))
wide_tbl <- wide_tbl %>% drop_na(q2)
long_tbl <- wide_tbl %>% pivot_longer(-c(casenum, parnum, stimver, datadate), names_to = "question", values_to = "response")