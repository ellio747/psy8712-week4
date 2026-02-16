# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl) 
wide_tbl <- separate(import_tbl, col = qs, into = c("q1", "q2","q3","q4", "q5"))
wide_tbl[, c("q1", "q2","q3","q4", "q5")] <- sapply(wide_tbl[, c("q1", "q2","q3","q4", "q5")], as.integer) # one response to q4 was a 6. Maybe a response issue.
wide_tbl <- mutate(wide_tbl, datadate = mdy_hms(datadate)) # converts to POSIXct format; verified in class(wide_tbl$datadate)
wide_tbl <- mutate(wide_tbl, across(q1:q5, ~ na_if(., 0))) # 18 NA in place of 0; sum(is.na(wide_tbl[, 5:9]))
wide_tbl <- drop_na(wide_tbl, q2) # will remove 9 subjects with NA for q2
long_tbl <- pivot_longer(wide_tbl, cols = q1:q5, names_to = "question", values_to = "response")