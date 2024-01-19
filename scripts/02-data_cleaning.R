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

#### Clean data ####
raw_data <- read_csv("inputs/data/raw_data.csv")

cleaned_data <- raw_data %>% select(Asset.ID, 
                                    Asset.Name, 
                                    Pad.Length..ft.., 
                                    Pad.Width..ft..,
                                    Boards..Ice.Rink.) 


cleaned_data <- cleaned_data %>% 
  rename(
    id = Asset.ID,
    name = Asset.Name,
    length = Pad.Length..ft..,
    width = Pad.Width..ft..,
    has_boards = Boards..Ice.Rink.
  )

cleaned_data <- cleaned_data %>% 
  filter(!str_detect(name, "Trail"))

# impute zero length/width value
mean_width <- round(mean(cleaned_data$width[cleaned_data$width != 0 &
                                        !is.na(cleaned_data$width)]))

cleaned_data <- cleaned_data %>% 
  mutate(width =ifelse(width == 0, mean_width, width))

cleaned_data <- cleaned_data %>% 
  mutate(size = ifelse(is.na(length), NA, length * width) )

#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
