# This is code to download the data directly from Google
# Author: Karl Melgarejo Castillo.
# Date: December 18, 2021.

        #Note: This code could go into the Server code, but the Shiny server wont upload it due to memory limitations, 
                #thus, use this only when it is run locally.

## 1. Downloading data to a temporary file

# Temporary file
DS <- tempfile()

# Downloading the data set (it takes about 1 minute)
url1 <- "https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv"
download.file(url = url1, destfile = DS)

## 2. Reading data (it takes about 1 minute)

# Filter data only for Peru 
gm <- filter(read.csv(file = DS), country_region == "Peru" & sub_region_1=="") 
unlink(DS)

## Alt. 2. Reading data from my PC to improve the speed of the "reading" function

#file <- "C:/Users/KARL/Dropbox/Cursos online/Johns Hopkins - Coursera/9 Developing Data Products/Week4Assignment/GoogleData/Global_Mobility_Report.csv"

# Filter data only for Peru 
#gm <- filter(read.csv(file = file), country_region == "Peru" & sub_region_1=="") 
#write.csv(x=gm, file)

## 3. Pre-processing data
# Changing format
gm$date <- as.Date(gm$date)

# Selecting only weekdays
gm$week <- wday(gm$date)
gm_w <- gm[gm$week>1 & gm$week<7,]
