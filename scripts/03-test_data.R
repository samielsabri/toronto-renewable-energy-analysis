#### Preamble ####
# Purpose: Tests the cleaned Toronto Renewable Energ Systems dataset
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca 
# License: MIT
# Pre-Requisites: 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(testthat)

#### Read in data ####
cleaned_data <- read_csv("outputs/data/analysis_data.csv")

#### Test data ####

test_that("All expected columns are present", {
  expect_true("ID" %in% colnames(cleaned_data))
  expect_true("DATE_INSTALL" %in% colnames(cleaned_data))
  expect_true("SIZE_INSTALL" %in% colnames(cleaned_data))
  expect_true("TYPE_INSTALL" %in% colnames(cleaned_data))
  expect_true("YEAR_INSTALL" %in% colnames(cleaned_data))
  expect_true("WARD" %in% colnames(cleaned_data))
})


test_that("No missing values in crucial columns", {
  expect_equal(sum(is.na(cleaned_data$DATE_INSTALL)), 0)
  expect_equal(sum(is.na(cleaned_data$SIZE_INSTALL)), 0)
  expect_equal(sum(is.na(cleaned_data$TYPE_INSTALL)), 0)
})

test_that("Date format is YYYY-MM-DD", {
  expected_dates <- format(cleaned_data$DATE_INSTALL, "%Y-%m-%d")
  
  cleaned_data$DATE_INSTALL <- format(cleaned_data$DATE_INSTALL, "%Y-%m-%d")
  
  expect_equal(cleaned_data$DATE_INSTALL, expected_dates)
})

test_that("YEAR_INSTALL is equal to the year in DATE_INSTALL", {
  expected_year <- substr(cleaned_data$DATE_INSTALL, 1, 4)

  expect_equal(cleaned_data$YEAR_INSTALL, expected_year)
})




