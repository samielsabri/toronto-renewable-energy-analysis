#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Sami El Sabri
# Date: 19 January 2024
# Contact: sami.elsabri@mail.utoronto.ca 
# License: MIT



#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)


#### Download data ####

# get package
package <- show_package("e51b5d31-a53c-4fc5-a204-36c43243dd3b")
package

# get all resources for this package
resources <- list_package_resources("e51b5d31-a53c-4fc5-a204-36c43243dd3b")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
icerink_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
icerink_data



#### Save data ####
write_csv(icerink_data, "inputs/data/icerink_data.csv") 

         
