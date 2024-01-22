#### Preamble ####
# Purpose: Cleans the raw plane data recorded by opendatatoronto
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca 
# License: MIT
# Pre-Requisites: 01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(stringr)
library(lubridate)

#### Clean data ####
raw_data <- read_csv("inputs/data/raw_data.csv")

cleaned_data <- raw_data %>% select(ID,
                                    TYPE_INSTALL,
                                    YEAR_INSTALL,
                                    SIZE_INSTALL) 

# clean type of installation column
cleaned_data <- cleaned_data %>% 
  mutate(
    TYPE_INSTALL = ifelse(grepl("MircoFIT", TYPE_INSTALL), 
                               gsub("MircoFIT", "MicroFIT", TYPE_INSTALL), 
                               TYPE_INSTALL)
  )

cleaned_data <- cleaned_data %>%
  mutate(
    TYPE_INSTALL = case_when(
      grepl("MicroFIT", TYPE_INSTALL) ~ "MicroFIT",
      grepl("FIT", TYPE_INSTALL) ~ "FIT",
      TRUE ~ TYPE_INSTALL
    )
  )

# clean date of installation column
cleaned_data <- cleaned_data %>%
  mutate(
    YEAR_INSTALL = case_when(
      nchar(YEAR_INSTALL) == 4 ~ paste0("January 01, ", YEAR_INSTALL),  # Add January 01 if only year
      !str_detect(YEAR_INSTALL, ",") ~ sub("^(\\w+)( \\d{4})$", "\\1 01,\\2", YEAR_INSTALL),
      TRUE ~ YEAR_INSTALL
    ),
    YEAR_INSTALL = gsub(",", "", YEAR_INSTALL),  # Remove commas from all observations
    YEAR_INSTALL = lubridate::mdy(YEAR_INSTALL))

# rename date of installation variable appropriately
cleaned_data <- cleaned_data %>% rename(DATE_INSTALL = YEAR_INSTALL)

# create new variable based on data of installation, which only shows the year
cleaned_data$YEAR_INSTALL <- format(as.Date(cleaned_data$DATE_INSTALL), "%Y")


#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
