# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl) # I think glimpse is correct; it comes from dplyr within tidyverse
wide_tbl <- separate(import_tbl, col = qs, into = paste0("q", 1:5))