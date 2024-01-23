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
library(sf)


#### Download data ####

library(opendatatoronto)
library(dplyr)
library(sf)

# get package
package <- show_package("6db96adf-d8a8-465b-a7e8-29be98907cc9")
package

# get all resources for this package
resources <- list_package_resources("6db96adf-d8a8-465b-a7e8-29be98907cc9")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data

#### Download map data ####

# get package
package <- show_package("5e7a8234-f805-43ac-820f-03d7c360b588")
package

# get all resources for this package
resources <- list_package_resources("5e7a8234-f805-43ac-820f-03d7c360b588")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
map_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
map_data <- map_data %>% select(geometry)
map_data


#### Save data ####
write_csv(data, "inputs/data/raw_data.csv") 
st_write(map_data, "inputs/data/map_data.gpkg", driver = "GPKG")

         
