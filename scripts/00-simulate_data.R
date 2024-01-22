#### Preamble ####
# Purpose: Simulates Toronto Renewable Energy Systems dataset
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(lubridate)
library(testthat)

#### Simulate data ####
set.seed(456)

num_rows <- 50

ids <- 1:num_rows

start_date <- as.Date("2010-01-01")
end_date <- as.Date("2023-12-31")

# Use sample on a sequence of integers and then convert to dates
random_days <- sample(as.integer(seq(start_date, end_date, by = "days")), num_rows)

# Convert the sampled integers back to dates
dates <- as.Date(random_days, origin = "1970-01-01")

min_size <- 50
max_size <- 200
size <- sample(round(runif(num_rows, min = min_size, max = max_size), 2))



simulated_data <-
  data.frame(
    ID = ids,
    installation_date = dates,
    size = size
  )

# Some Tests

simulated_data$ID %>% unique() == c(1:num_rows)
simulated_data$ID %>% unique() %>% length() == num_rows

simulated_data$size %>% min() >= min_size
simulated_data$size %>% max() <= max_size

test_that("All installation dates are after the start date", {
  expect_true(all(simulated_data$installation_date >= start_date))
})
test_that("All installation dates are before the end date", {
  expect_true(all(simulated_data$installation_date <= end_date))
})




