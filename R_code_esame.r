# Remote Sensing Exam

# __________Libraries and working directory___________________________________________________________________________________________________________________________________

library(RStoolbox)
library(raster)
library(rasterdiv)
library(rasterVis)
library(ggplot2)
library(viridis)
library(imagefx)
library(rgdal)
library(Rcpp)
setwd("C:/exam/")

# __________Importing images__________________________________________________________________________________________________________________________________________________

# To list all the files together, with the common pattern "cod" in the file name:
list2021 <- list.files(pattern="cod_2021")
list2021

# To have each file as a raster brick, with each image containing three layers:
import2021 <- lapply(list2021,brick)
import2021

# To stack the bands of interest for basic colour analysis and NDWI analysis: (Band 1: Blue, Band 2: Green, Band 3: Red, Band 4: NIR, Band 5: SWIR-1)
cod_2021 <- stack(import2021)
cod_2021

# This process was done for all four years to be analyzed: 2006, 2011, 2016, 2021

# __________2016______________________________________________________________________________________________________________________________________________________________
list2016 <- list.files(pattern="cod_2016")
list2016
import2016 <- lapply(list2016,brick)
import2016
cod_2016 <- stack(import2016)
cod_2016

# __________2011______________________________________________________________________________________________________________________________________________________________
list2011 <- list.files(pattern="cod_2011")
list2011
import2011 <- lapply(list2011,brick)
import2011
cod_2011 <- stack(import2011)
cod_2011

# __________2006______________________________________________________________________________________________________________________________________________________________
list2006 <- list.files(pattern="cod_2006")
list2006
import2006 <- lapply(list2006,brick)
import2006
cod_2006 <- stack(import2006)
cod_2006

# __________Selecting study area using drawExtent to crop the images__________________________________________________________________________________________________________

# Upload one image to understand the dimensions to be cropped:
cropbackground <- raster("cod_2006_B1.tif")
plot(cropbackground)

# Use the drawExtent function to select the area to crop on the image:
cod_drawextent <- drawExtent(show=TRUE, col="red")

# New crop template acquired:
cropcodtemplate <- crop(x = cropbackground, y = cod_drawextent)

# Plot the template to check that the dimensions are correct:
plot(cropcodtemplate)

# To set the x and y values for the cropped area to be used with any of the rasters:
new_extent <- extent(412065, 425655, 4596555, 4614825)
class(new_extent)

# To check that the "extent" works and create a new cropped area for another image:
cropcod_2006 <- crop(x = cod_2006, y = new_extent)

# __________A new crop extent is required for each year due to slight variations in satellite flight path_____________________________________________________________________

# __________drawExtent 2016___________________________________________________________________________________________________________________________________________________
