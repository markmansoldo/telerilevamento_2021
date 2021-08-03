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

# ____________________________________________________________________________________________________________________________________________________________________________

