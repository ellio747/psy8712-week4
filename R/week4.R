# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl) 
wide_tbl <- separate(import_tbl, col = qs, into = paste0("q", 1:5))
wide_tbl[, paste0("q", 1:5)] <- sapply(wide_tbl[, paste0("q", 1:5)], as.integer)
wide_tbl <- mutate(wide_tbl, datadate = mdy_hms(datadate))
wide_tbl <- mutate(wide_tbl, across(q1:q5, ~ na_if(., 0)))
wide_tbl <- drop_na(wide_tbl, q2)
long_tbl <- pivot_longer(wide_tbl, cols = q1:q5, names_to = "question", values_to = "response")