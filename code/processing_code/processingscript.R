###############################
# processing script
#
#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#load needed packages. make sure they are installed.
install.packages("tidyverse")
library(readxl) #for loading Excel files
library(dplyr) #for data processing
library(here) #to set paths
library(tidyverse)

#path to data
#note the use of the here() package and not absolute paths
data_location <- here::here("data","raw_data","SympAct_Any_Pos.Rda")

#load data. 
#note that for functions that come from specific packages (instead of base R)
# I often specify both package and function like so
#package::function() that's not required one could just call the function
#specifying the package makes it clearer where the function "lives",
#but it adds typing. You can do it either way.
rawdata <- readRDS(data_location)

#take a look at the data
dplyr::glimpse(rawdata)

#Remove all variables that have Score or Total or FluA or FluB or 
#Dxname or Activity in their name. Also remove the variable Unique.Visit
newdata <- rawdata %>% select(!contains("Score") & !contains("Total") &
                             !contains("FluA") & !contains("FluB") &
                             !contains("Dxname") & !contains("Unique.Visit")& 
                             !contains("Activity")) 
#Remove NA values
newdata = newdata %>% drop_na() 
glimpse(newdata)

# location to save file
save_data_location <- here::here("data","processed_data","newdata.rds")

saveRDS(newdata, file = save_data_location)


