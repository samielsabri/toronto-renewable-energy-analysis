#### Preamble ####
# Purpose: Simulates Toronto Outdoor Ice Rinks dataset
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(dplyr)

#### Simulate data ####
set.seed(456)

num_rows <- 50
outdoor_rink_ids <- 1:num_rows

min_length <- 75
min_width <- 75

max_length <- 200
max_width <- 200

lengths <- round(runif(num_rows, min = min_length, max = max_length), 2)
widths <- round(runif(num_rows, min = min_width, max = max_width), 2)

has_boards <- sample(c(TRUE, FALSE), size = num_rows, replace = TRUE)

area_size <- round(lengths * widths, 2)

simulated_rink_size_data <-
  data.frame(
    Outdoor_Rink_ID = outdoor_rink_ids,
    Pad_Length = lengths,
    Pad_Width = widths,
    Pad_Size = area_size,
    has_Boards = has_boards
  )

# Some Tests

simulated_rink_size_data$Outdoor_Rink_ID %>% unique() == c(1:num_rows)
simulated_rink_size_data$Outdoor_Rink_ID %>% unique() %>% length() == num_rows

simulated_rink_size_data$Pad_Length %>% min() >= min_length
simulated_rink_size_data$Pad_Length %>% max() <= max_length

simulated_rink_size_data$Pad_Width %>% min() >= min_width
simulated_rink_size_data$Pad_Width %>% max() <= max_width

simulated_rink_size_data$Pad_Size == 
  round(simulated_rink_size_data$Pad_Length *
      simulated_rink_size_data$Pad_Width, 2)




