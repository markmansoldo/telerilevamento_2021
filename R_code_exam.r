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
list2020 <- list.files(pattern="cod_2020")
list2020

# To have each file as a raster brick, with each image containing three layers:
import2020 <- lapply(list2020,brick)
import2020

# To stack the bands of interest for basic colour analysis and NDWI analysis: (Band 1: Blue, Band 2: Green, Band 3: Red, Band 4: NIR, Band 5: SWIR-1)
cod_2020 <- stack(import2020)
cod_2020

# This process was done for all four years to be analyzed: 2014, 2016, 2018, 2020

# __________2018______________________________________________________________________________________________________________________________________________________________
list2018 <- list.files(pattern="cod_2018")
list2018
import2018 <- lapply(list2018,brick)
import2018
cod_2018 <- stack(import2018)
cod_2018

# __________2016______________________________________________________________________________________________________________________________________________________________
list2016 <- list.files(pattern="cod_2016")
list2016
import2016 <- lapply(list2016,brick)
import2016
cod_2016 <- stack(import2016)
cod_2016

# __________2014______________________________________________________________________________________________________________________________________________________________
list2014 <- list.files(pattern="cod_2014")
list2014
import2014 <- lapply(list2014,brick)
import2014
cod_2014 <- stack(import2014)
cod_2014

# __________Selecting study area using drawExtent to crop the images__________________________________________________________________________________________________________

# Upload one image to understand the dimensions to be cropped:
cropbackground <- raster("cod_2020_B5.tif")
plot(cropbackground)

# Use the drawExtent function to select the area to crop on the image:
cod_drawextent <- drawExtent(show=TRUE, col="red")

# New crop template acquired:
cropcodtemplate <- crop(x = cropbackground, y = cod_drawextent)

# Plot the template to check that the dimensions are correct:
plot(cropcodtemplate)

# To set the x and y values for the cropped area to be used with any of the rasters:
new_extent <- extent(415065, 424545, 4602375, 4615485)
class(new_extent)

# To check that the "extent" works and create a new cropped area for another image:
cropcod_2018 <- crop(x = cod_2018, y = new_extent)

# __________All images were cropped using this extent_________________________________________________________________________________________________________________________

cropcod_2020 <- crop(x = cod_2020, y = new_extent)
plot(cropcod_2020)

cropcod_2018 <- crop(x = cod_2018, y = new_extent)
plot(cropcod_2018)

cropcod_2016 <- crop(x = cod_2016, y = new_extent)
plot(cropcod_2016)

cropcod_2014 <- crop(x = cod_2014, y = new_extent)
plot(cropcod_2014)

# __________Colour palettes___________________________________________________________________________________________________________________________________________________

# Colour palettes I created:
mono <- colorRampPalette(c("black","light grey","white"))(100)
greek <- colorRampPalette(c("dark blue","blue","white"))(100)
blbl <- colorRampPalette(c("black","blue","white"))(100)
changer <- colorRampPalette(c("steelblue3","black","yellow"))(100)
tropical <- colorRampPalette(c("aquamarine","navy","yellow"))(100)
candy <- colorRampPalette(c("blueviolet","pink","white"))(100)
fire <- colorRampPalette(c("white","orange3","purple"))(100)

# __________Experimenting with RGB plots______________________________________________________________________________________________________________________________________

# Landsat 8 spectral bands:
# Band 1 = Coastal / Aerosol
# Band 2 = Blue
# Band 3 = Green
# Band 4 = Red
# Band 5 = NIR
# Band 6 = SWIR-1
# Band 7 = SWIR-2
# Band 9 = Cirrus

# To plot all of them together:
par(mfrow=c(2,2))
plotRGB(cropcod_2014, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2018, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2016, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2020, 4, 3, 2, stretch="Lin")

# Emphasises coastal sands with bright white sand:
par(mfrow=c(2,2))
plotRGB(cropcod_2014, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2018, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2016, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2020, 1, 2, 3, stretch="Lin")

# Emphasises vegetation and terrain:
par(mfrow=c(2,2))
plotRGB(cropcod_2014, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2018, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2016, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2020, 5, 6, 7, stretch="Lin")

# Emphasises movement of submerged sediment:
par(mfrow=c(2,2))
plotRGB(cropcod_2014, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2018, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2016, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2020, 5, 6, 1, stretch="Lin")

# Histogram stretch is too blurry and hinders visualization of geomorphology:
par(mfrow=c(2,2))
plotRGB(cropcod_2014, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2018, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2016, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2020, 5, 6, 1, stretch="hist")

# __________Experimenting with different bands within the bricks to visualize geomorphology___________________________________________________________________________________

# Coastal geomorphology with first band (Coastal/Ultra-blue) of first and last year

# Band 1 (Coastal/ultra-blue) Highlights sediment movement:
par(mfrow=c(1,2))
plot(cropcod_2014$cod_2014_B1, col=changer)
plot(cropcod_2020$cod_2020_B1, col=changer)

# Band 5 (Near Infra Red) Clearly shows all exposed land:
par(mfrow=c(1,2))
plot(cropcod_2014$cod_2014_B5, col=changer)
plot(cropcod_2020$cod_2020_B5, col=changer)

# Band 6 (SWIR-1) Illustrates ocean-facing sandbar change:
par(mfrow=c(1,2))
plot(cropcod_2014$cod_2014_B6, col=changer)
plot(cropcod_2020$cod_2020_B6, col=changer)

# __________Calculating the degree of change in geomorphology between 2014 and 2020___________________________________________________________________________________________

# Subtracting the first year from the last year to find the difference:
codchange <- cropcod_2020 - cropcod_2014
plot(codchange, col=changer)
# Bands 4-7 show very high contrast and illustrate well the degree of change

# Band 5 (Near Infra Red) often used to distinguish land from water:
codchange5 <- cropcod_2020$cod_2020_B5 - cropcod_2014$cod_2014_B5

levelplot(codchangeB7, col.regions=tropical)

# Band 7 (SWIR-2) shows good contrast in active sediment zones:
codchangeB7 <- cropcod_2020$cod_2020_B7 - cropcod_2014$cod_2014_B7

levelplot(codchangeB7, col.regions=changer)

# __________Principal Components Analysis (PCA)_______________________________________________________________________________________________________________________________

# Aggregate the raster cells and look at the dimensions to see how many pixels there are per band:
# Resampling by a factor of 10:

# To conduct a PCA:

# __________Unsupervised classification_______________________________________________________________________________________________________________________________________

# 2 classes:
class2014_2 <- unsuperClass(cropcod_2014, nClasses=2)
class2020_2 <- unsuperClass(cropcod_2020, nClasses=2)

# 2 classes identified are water and land:
par(mfrow=c(1,2))
plot(class2014_2$map)
plot(class2020_2$map)

# 3 classes:
class2014_3 <- unsuperClass(cropcod_2014, nClasses=3)
class2020_3 <- unsuperClass(cropcod_2020, nClasses=3)

# 3 classes identified are water, land and sand:
par(mfrow=c(1,2))
plot(class2014_3$map)
plot(class2020_3$map)

# 4 classes:
class2014_4 <- unsuperClass(cropcod_2014, nClasses=4)
class2020_4 <- unsuperClass(cropcod_2020, nClasses=4)

# 4 classes identified are water, land, sand and urban areas:
par(mfrow=c(1,2))
plot(class2014_4$map)
plot(class2020_4$map)

# __________Normalized Difference Water Index (NDWI)__________________________________________________________________________________________________________________________

# NDWI = (Green-NIR)/(Green+NIR)

NDWI2014 <- (cropcod_2014$cod_2014_B3 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B3 + cropcod_2014$cod_2014_B5)
NDWI2020 <- (cropcod_2020$cod_2020_B3 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B3 + cropcod_2020$cod_2020_B5)

NDWIdiff <- NDWI2020-NDWI2014

plot(NDWIdiff, col=changer)

# __________Normalized Difference Water Index (NDWI)__________(Wolf, 2012; WorldView 2 equation adapted for Landsat 8)________________________________________________________

# NDWI = (Coastal-NIR)/(Coastal+NIR)

NDWIa2014 <- (cropcod_2014$cod_2014_B1 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B1 + cropcod_2014$cod_2014_B5)
NDWIa2020 <- (cropcod_2020$cod_2020_B1 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B1 + cropcod_2020$cod_2020_B5)

NDWIadiff <- NDWIa2020-NDWIa2014

plot(NDWIadiff, col=changer)

# __________Normalized Difference Water Index (NDWI)__________________________________________________________________________________________________________________________

# NDWI = (NIR-SWIR1)/(NIR+SWIR1)

NDWIb2014 <- (cropcod_2014$cod_2014_B5 - cropcod_2014$cod_2014_B6)/(cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B6)
NDWIb2020 <- (cropcod_2020$cod_2020_B5 - cropcod_2020$cod_2020_B6)/(cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B6)

par(mfrow=c(1,2))
plot(NDWIb2014, col=mono)
plot(NDWIb2020, col=mono)

NDWIbdiff <- NDWIb2020-NDWIb2014

plot(NDWIbdiff, col=changer)

# __________Urban Index (UI)___________________________________________________________________________________________________________________________________________________

# UI = (SWIR2-NIR)/(SWIR2+NIR)

UI2014 <- (cropcod_2014$cod_2014_B7 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B7 + cropcod_2014$cod_2014_B5)
UI2020 <- (cropcod_2020$cod_2020_B7 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B7 + cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(UI2014, col=mono)
plot(UI2020, col=mono)

UIdiff <- UI2020-UI2014

plot(UIdiff, col=changer)

# __________New Built-Up Index (BUI)__________(Kaimaris & Patias, 2016)_______________________________________________________________________________________________________

# BUI = (Red*SWIR1)/(NIR)

# This index considers newly emerged sands and sediment with values very similar to those of urbanized areas

BUI2014 <- (cropcod_2014$cod_2014_B4 * cropcod_2014$cod_2014_B6)/(cropcod_2014$cod_2014_B5)
BUI2020 <- (cropcod_2020$cod_2020_B4 * cropcod_2020$cod_2020_B6)/(cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(BUI2014, col=mono)
plot(BUI2020, col=mono)

BUIdiff <- BUI2020-BUI2014

plot(BUIdiff, col=changer)

# __________Normalized Difference Vegetation Index (NDVI) to explore areas of bare sand_______________________________________________________________________________________

# NDVI = (NIR-RED)/(NIR+RED)

# The negative value is useful indicating underwater sand and sediment

NDVI2014 <- (cropcod_2014$cod_2014_B5 - cropcod_2014$cod_2014_B4)/(cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B4)
NDVI2020 <- (cropcod_2020$cod_2020_B5 - cropcod_2020$cod_2020_B4)/(cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B4)

par(mfrow=c(1,2))
plot(NDVI2014, col=mono)
plot(NDVI2020, col=mono)

NDVIdiff <- NDVI2020-NDVI2014

plot(NDVIdiff, col=changer)

# ____________________________________________________________________________________________________________________________________________________________________________

