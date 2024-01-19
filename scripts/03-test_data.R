#### Preamble ####
# Purpose: Tests the cleaned Toronto Outdoor Ice Rink dataset
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca 
# License: MIT
# Pre-Requisites: 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Test data ####

test_that("All expected columns are present", {
  expect_true("id" %in% colnames(cleaned_data))
  expect_true("name" %in% colnames(cleaned_data))
  expect_true("length" %in% colnames(cleaned_data))
  expect_true("width" %in% colnames(cleaned_data))
  expect_true("has_boards" %in% colnames(cleaned_data))
  expect_true("size" %in% colnames(cleaned_data))
})

test_that("No rows with 'Trail' in the name column", {
  expect_equal(sum(str_detect(cleaned_data$name, "Trail")), 0)
})

test_that("No zero width values after imputation", {
  expect_true(all(cleaned_data$width != 0 | is.na(cleaned_data$width)))
})


test_that("No zero length values after imputation", {
  expect_true(all(cleaned_data$length != 0 | is.na(cleaned_data$length)))
})


test_that("Size calculation is accurate", {
  expect_equal(cleaned_data$size, cleaned_data$length * cleaned_data$width, tolerance = 1e-6)
})

test_that("No missing values in crucial columns", {
  expect_equal(sum(is.na(cleaned_data$id)), 0)
  expect_equal(sum(is.na(cleaned_data$name)), 0)
})



