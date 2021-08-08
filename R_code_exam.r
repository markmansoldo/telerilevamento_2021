# Remote Sensing Exam

# __________Libraries and working directory___________________________________________________________________________________________________________________________________

library(RStoolbox)
library(raster)
library(rasterdiv)
library(rasterVis)
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(imagefx)
library(rgdal)
library(Rcpp)
library(stats)
library(ggpubr)
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
changer <- colorRampPalette(c("aquamarine","steelblue3","black","yellow","pink","purple"))(100)
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
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2016, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2018, 4, 3, 2, stretch="Lin")
plotRGB(cropcod_2020, 4, 3, 2, stretch="Lin")

# Very useful for bathymetric studies:
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 4, 3, 1, stretch="Lin")
plotRGB(cropcod_2016, 4, 3, 1, stretch="Lin")
plotRGB(cropcod_2018, 4, 3, 1, stretch="Lin")
plotRGB(cropcod_2020, 4, 3, 1, stretch="Lin")

# Emphasises coastal sands with bright white sand:
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2016, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2018, 1, 2, 3, stretch="Lin")
plotRGB(cropcod_2020, 1, 2, 3, stretch="Lin")

# Emphasises vegetation and terrain:
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2016, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2018, 5, 6, 7, stretch="Lin")
plotRGB(cropcod_2020, 5, 6, 7, stretch="Lin")

# Emphasises movement of submerged sediment:
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2016, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2018, 5, 6, 1, stretch="Lin")
plotRGB(cropcod_2020, 5, 6, 1, stretch="Lin")

# Histogram stretch is too blurry and hinders visualization of geomorphology:
par(mfrow=c(1,4))
plotRGB(cropcod_2014, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2016, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2018, 5, 6, 1, stretch="hist")
plotRGB(cropcod_2020, 5, 6, 1, stretch="hist")

# __________ggRGB function to apply grid base_________________________________________________________________________________________________________________________________

# Emphasises movement of submerged sediment:
gg2014 <- ggRGB(cropcod_2014, 5, 6, 1, stretch="lin")
gg2016 <- ggRGB(cropcod_2016, 5, 6, 1, stretch="lin")
gg2018 <- ggRGB(cropcod_2018, 5, 6, 1, stretch="Lin")
gg2020 <- ggRGB(cropcod_2020, 5, 6, 1, stretch="Lin")

# To plot the ggRGB objects:
grid.arrange(gg2014, gg2016, gg2018, gg2020, nrow = 1)


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
codchangeB5 <- cropcod_2020$cod_2020_B5 - cropcod_2014$cod_2014_B5

levelplot(codchangeB5, col.regions=tropical)

# Band 7 (SWIR-2) shows good contrast in active sediment zones:
codchangeB7 <- cropcod_2020$cod_2020_B7 - cropcod_2014$cod_2014_B7

levelplot(codchangeB7, col.regions=changer)

# __________Click function will be useful for the image analyses that follow__________________________________________________________________________________________________

# Click on the image and you will see the information for that particular pixel:
#                            id(identity), xy(spatial data), cell(pixel), type(point)
# click(name of file goes here, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# __________Unsupervised classification_______________________________________________________________________________________________________________________________________

# 2 classes with all four years:
class2014_2 <- unsuperClass(cropcod_2014, nClasses=2)
class2016_2 <- unsuperClass(cropcod_2016, nClasses=2)
class2018_2 <- unsuperClass(cropcod_2018, nClasses=2)
class2020_2 <- unsuperClass(cropcod_2020, nClasses=2)

par(mfrow=c(1,4))
plot(class2014_2$map)
plot(class2016_2$map)
plot(class2018_2$map)
plot(class2020_2$map)

# Using the frequencies function to count the pixels for 2 classes in 2014:
freq(class2014_2$map)

#      value  count (2014)
# [1,]     1 116482 (water)
# [2,]     2  21610 (land)

# Using the frequencies function to count the pixels for 2 classes in 2016:
freq(class2016_2$map)

#      value  count (2016)
# [1,]     1 112807 (water)
# [2,]     2  25285 (land)

# Using the frequencies function to count the pixels for 2 classes in 2018:
freq(class2018_2$map)

#      value  count (2018)
# [1,]     1 114223 (water)
# [2,]     2  23869 (land)

# Using the frequencies function to count the pixels for 2 classes in 2020:
freq(class2020_2$map)

#      value  count (2020)
# [1,]     1 118286 (water)
# [2,]     2  19806 (land)

# __________________________________________________________________________

# 3 classes:
class2014_3 <- unsuperClass(cropcod_2014, nClasses=3)
class2020_3 <- unsuperClass(cropcod_2020, nClasses=3)

par(mfrow=c(1,2))
plot(class2014_3$map)
plot(class2020_3$map)

# Using the frequencies function to count the pixels for 3 classes in 2014:
freq(class2014_3$map)

#      value  count (2014)
# [1,]     1  19116 (land)
# [2,]     2 114193 (water)
# [3,]     3   4783 (sand)

# Using the frequencies function to count the pixels for 3 classes in 2020:
freq(class2020_3$map)

#      value  count (2020)
# [1,]     1  16437 (land)
# [2,]     2 117867 (water)
# [3,]     3   3788 (sand)

# ___________________________________________________________________________

# 4 classes:
class2014_4 <- unsuperClass(cropcod_2014, nClasses=4)
class2020_4 <- unsuperClass(cropcod_2020, nClasses=4)

par(mfrow=c(1,2))
plot(class2014_4$map)
plot(class2020_4$map)

# Using the frequencies function to count the pixels for 4 classes in 2014:
freq(class2014_4$map)

#      value  count (2014)
# [1,]     1   9786 (submerged sand and salt marsh)
# [2,]     2  15727 (mainland)
# [3,]     3   4631 (coastal habitat)
# [4,]     4 107948 (water)

# Using the frequencies function to count the pixels for 4 classes in 2020:
freq(class2020_4$map)

#      value  count (2020)
# [1,]     1   4327 (submerged sand and salt marsh)
# [2,]     2  13050 (mainland)
# [3,]     3 116914 (water)
# [4,]     4   3801 (coastal habitat)

# ___________________________________________________________________________

# 8 classes:
class2014_8 <- unsuperClass(cropcod_2014, nClasses=8)
class2020_8 <- unsuperClass(cropcod_2020, nClasses=8)

par(mfrow=c(1,2))
plot(class2014_8$map, col=changer)
plot(class2020_8$map, col=changer)


# Using the frequencies function to count the pixels for 8 classes in 2014:
freq(class2014_8$map)

#      value count (2014)
# [1,]     1  9751 (shallow sand)
# [2,]     2  6881 (dense vegetation)
# [3,]     3  8090 (salt marsh)
# [4,]     4  7364 (sparse vegetation/urban)
# [5,]     5 19965 (deep sand)
# [6,]     6 79272 (water)
# [7,]     7  3122 (sandy beach)
# [8,]     8  3647 (sand dunes)

# Using the frequencies function to count the pixels for 8 classes in 2020:
freq(class2020_8$map)

#      value count (2020)
# [1,]     1  4114 (dense vegetation)
# [2,]     2 17326 (deep sand)
# [3,]     3 99297 (water)
# [4,]     4   432 (shallow sand)
# [5,]     5  2909 (sandy beach)
# [6,]     6  7421 (sparse vegetation/urban)
# [7,]     7  3946 (sand dunes)
# [8,]     8  2647 (salt marsh)

# __________Calculating proportions of terrain types for the 8 classes in 2014 and 2020_______________________________________________________________________________________

# Total number of pixels:
total <- 9751+6881+8090+7364+19965+79272+3122+3647
total
# [1] 138092

# Proportions of each class for 2014:
prop2014 <- freq(class2014_8$map)/total
prop2014

#       count (2014)
# 0.070612345 (shallow sand)
# 0.049829099 (dense vegetation)
# 0.058584132 (salt marsh)
# 0.053326768 (sparse vegetation/urban)
# 0.144577528 (deep sand)
# 0.574052081 (water)
# 0.022608116 (sandy beach)
# 0.026409930 (sand dunes)

# Proportions of each class for 2020:
prop2020 <- freq(class2020_8$map)/total
prop2020

#       count (2020)
# 0.029791733 (dense vegetation)
# 0.125467080 (deep sand)
# 0.719064102 (water)
# 0.003128349 (shallow sand)
# 0.021065666 (sandy beach)
# 0.053739536 (sparse vegetation/urban)
# 0.028575153 (sand dunes)
# 0.019168380 (salt marsh)

# __________Building a dataframe with relative terrain types__________________________________________________________________________________________________________________

# Creation of the data frame with headings and values for 2014 and 2020
cover <- c("Acqua","Sabbie sommerse profonde","Sabbie sommerse superficiali","Paludi salmastre","Spiagge sabbiose","Dune","Vegetazione densa e zone urbane")
percent_2014 <- c(57.41, 14.46, 7.06, 5.86, 2.26, 2.64, 10.31)
percent_2020 <- c(71.91, 12.55, 0.31, 1.92, 2.11, 2.86, 8.35)

# To assign the name to the dataframe:
percentagecover <- data.frame(cover, percent_2014, percent_2020)
percentagecover

# __________Creating bar charts of the various terrain types__________________________________________________________________________________________________________________

cover2014 <- ggplot(percentagecover, aes(x=cover, y=percent_2014, fill=cover)) + geom_bar(stat="identity") + scale_fill_brewer(palette="Blues") +
scale_x_discrete(limits=c("Acqua","Sabbie sommerse profonde","Sabbie sommerse superficiali","Paludi salmastre","Spiagge sabbiose","Dune","Vegetazione densa e zone urbane")) + theme_bw() +
labs(y= "Copertura (%)", x = "Tipologia di terreno") + ggtitle("Tipologie di terreni e copertura nel 2014") +
theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position = "none") +
coord_flip(ylim = c(0, 75))

cover2020 <- ggplot(percentagecover, aes(x=cover, y=percent_2020, fill=cover)) + geom_bar(stat="identity") + scale_fill_brewer(palette="Blues") +
scale_x_discrete(limits=c("Acqua","Sabbie sommerse profonde","Sabbie sommerse superficiali","Paludi salmastre","Spiagge sabbiose","Dune","Vegetazione densa e zone urbane")) + theme_bw() +
labs(y= "Copertura (%)", x = "Tipologia di terreno")  + ggtitle("Tipologie di terreni e copertura nel 2020") +
theme(plot.title = element_text(hjust = 0.5)) + theme(legend.position = "none") +
coord_flip(ylim = c(0, 75))

grid.arrange(cover2014, cover2020, nrow=1)


# __________Normalized Difference Water Index (NDWI)__________________________________________________________________________________________________________________________

# NDWI = (Green-NIR)/(Green+NIR)

# Good indication of exposed land above water level and sediment in shallow water, urbanized areas and vegetation shown at one extremity and water at the other extremity.

NDWI2014 <- (cropcod_2014$cod_2014_B3 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B3 + cropcod_2014$cod_2014_B5)
NDWI2020 <- (cropcod_2020$cod_2020_B3 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B3 + cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(NDWI2014, col=mono)
plot(NDWI2020, col=mono)

NDWIdiff <- NDWI2020-NDWI2014

plot(NDWIdiff, col=changer)

# __________Normalized Difference Water Index (NDWI)__________(Wolf, 2012; WorldView 2 equation adapted for Landsat 8)________________________________________________________

# NDWI = (Coastal-NIR)/(Coastal+NIR)

# Very similar to the other NDWI but shows only exposed sand, with greater contrast between land and water.

NDWIa2014 <- (cropcod_2014$cod_2014_B1 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B1 + cropcod_2014$cod_2014_B5)
NDWIa2020 <- (cropcod_2020$cod_2020_B1 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B1 + cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(NDWIa2014, col=mono)
plot(NDWIa2020, col=mono)

NDWIadiff <- NDWIa2020-NDWIa2014

plot(NDWIadiff, col=changer)

# __________Normalized Difference Water Index (NDWI)__________________________________________________________________________________________________________________________

# NDWI = (NIR-SWIR1)/(NIR+SWIR1)

# Very clear distinction between land and water in some areas, but sand in shallow waters appears blurry.

NDWIb2014 <- (cropcod_2014$cod_2014_B5 - cropcod_2014$cod_2014_B6)/(cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B6)
NDWIb2020 <- (cropcod_2020$cod_2020_B5 - cropcod_2020$cod_2020_B6)/(cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B6)

par(mfrow=c(1,2))
plot(NDWIb2014, col=mono)
plot(NDWIb2020, col=mono)

NDWIbdiff <- NDWIb2020-NDWIb2014

plot(NDWIbdiff, col=changer)

# __________Urban Index (UI)___________________________________________________________________________________________________________________________________________________

# UI = (SWIR2-NIR)/(SWIR2+NIR)

# Urbanized areas occupy one extremity of the scale, exposed sand and water at the other extreme with vegetated areas having an intermediate value.

UI2014 <- (cropcod_2014$cod_2014_B7 - cropcod_2014$cod_2014_B5)/(cropcod_2014$cod_2014_B7 + cropcod_2014$cod_2014_B5)
UI2020 <- (cropcod_2020$cod_2020_B7 - cropcod_2020$cod_2020_B5)/(cropcod_2020$cod_2020_B7 + cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(UI2014, col=mono)
plot(UI2020, col=mono)

UIdiff <- UI2020-UI2014

plot(UIdiff, col=changer)

# __________New Built-Up Index (BUI)__________(Kaimaris & Patias, 2016)_______________________________________________________________________________________________________

# BUI = (Red*SWIR1)/(NIR)

# Very useful in showing exposed and submerged sand formations but urban areas and vegetated areas have very similar values.

BUI2014 <- (cropcod_2014$cod_2014_B4 * cropcod_2014$cod_2014_B6)/(cropcod_2014$cod_2014_B5)
BUI2020 <- (cropcod_2020$cod_2020_B4 * cropcod_2020$cod_2020_B6)/(cropcod_2020$cod_2020_B5)

par(mfrow=c(1,2))
plot(BUI2014, col=mono)
plot(BUI2020, col=mono)

BUIdiff <- BUI2020-BUI2014

plot(BUIdiff, col=changer)

# __________Normalized Difference Vegetation Index (NDVI) to explore areas of bare sand_______________________________________________________________________________________

# NDVI = (NIR-RED)/(NIR+RED)

# The negative value is extremely useful for illustrating underwater sand and sediment.
# The positive value shows all exposed land very clearly.

NDVI2014 <- (cropcod_2014$cod_2014_B5 - cropcod_2014$cod_2014_B4)/(cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B4)
NDVI2020 <- (cropcod_2020$cod_2020_B5 - cropcod_2020$cod_2020_B4)/(cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B4)

par(mfrow=c(1,2))
plot(NDVI2014, col=mono)
plot(NDVI2020, col=mono)

# Difference with water and underwater sediment still present:
NDVIdiff <- NDVI2020-NDVI2014
plot(NDVIdiff, col=changer)

# __________NDVI but with all water values removed___________________________________________________

# Remove all values lower than 0 (remove water):
NDVI2014land <- reclassify(NDVI2014, cbind(-Inf, 0, NA), right=FALSE)
NDVI2020land <- reclassify(NDVI2020, cbind(-Inf, 0, NA), right=FALSE)

par(mfrow=c(1,2))
plot(NDVI2014land, col=mono)
plot(NDVI2020land, col=mono)

class2014land_4 <- unsuperClass(NDVI2014land, nClasses=4)
class2020land_4 <- unsuperClass(NDVI2020land, nClasses=4)

par(mfrow=c(1,2))
plot(class2014land_4$map, col=tropical)
plot(class2020land_4$map, col=tropical)


# __________Bare Soil Index (BSI)_____________________________________________________________________________________________________________________________________________

# BSI = (SWIR1+Red)-(NIR+Blue)/(SWIR1+Red)+(NIR+Blue)

# Bare sandy beaches without any vegetation are shown at one extremity and urbanized areas are at the other extremity.
# Urban areas have a slightly more extreme value compared to vegetation.

BSI2014 <- ((cropcod_2014$cod_2014_B6 + cropcod_2014$cod_2014_B4) - (cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B2))/((cropcod_2014$cod_2014_B6 + cropcod_2014$cod_2014_B4) + (cropcod_2014$cod_2014_B5 + cropcod_2014$cod_2014_B2))
BSI2020 <- ((cropcod_2020$cod_2020_B6 + cropcod_2020$cod_2020_B4) - (cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B2))/((cropcod_2020$cod_2020_B6 + cropcod_2020$cod_2020_B4) + (cropcod_2020$cod_2020_B5 + cropcod_2020$cod_2020_B2))

par(mfrow=c(1,2))
plot(BSI2014, col=mono)
plot(BSI2020, col=mono)

BSIdiff <- BSI2020-BSI2014

plot(BSIdiff, col=changer)

#____________________________________________________________________________________________________________________________________________________________________________
# __________Secondary crop for Monomoy National Wildlife Refuge______________________________________________________________________________________________________________

# __________2019______________________________________________________________________________________________________________________________________________________________
list2019 <- list.files(pattern="cod_2019")
list2019
import2019 <- lapply(list2019,brick)
import2019
cod_2019 <- stack(import2019)
cod_2019

# __________2017______________________________________________________________________________________________________________________________________________________________
list2017 <- list.files(pattern="cod_2017")
list2017
import2017 <- lapply(list2017,brick)
import2017
cod_2017 <- stack(import2017)
cod_2017

# __________2015______________________________________________________________________________________________________________________________________________________________
list2015 <- list.files(pattern="cod_2015")
list2015
import2015 <- lapply(list2015,brick)
import2015
cod_2015 <- stack(import2015)
cod_2015

# __________2013______________________________________________________________________________________________________________________________________________________________
list2013 <- list.files(pattern="cod_2013")
list2013
import2013 <- lapply(list2013,brick)
import2013
cod_2013 <- stack(import2013)
cod_2013

# ____________________________________________________________________________________________________________________________________________________________________________

# Upload one image to understand the dimensions to be cropped:
cropbackgroundmonomoy <- raster("cod_2020_B5.tif")
plot(cropbackgroundmonomoy)

# Use the drawExtent function to select the area to crop on the image:
monomoy_drawextent <- drawExtent(show=TRUE, col="red")

# New crop template acquired:
monomoy_template <- crop(x = cropbackgroundmonomoy, y = monomoy_drawextent)

# Plot the template to check that the dimensions are correct:
plot(monomoy_template)

# To set the x and y values for the cropped area to be used with any of the rasters:
monomoy_extent <- extent(414635, 422385, 4596525, 4611825)
class(monomoy_extent)

# To crop all bricks to this extent:
monomoy_2020 <- crop(x = cod_2020, y = monomoy_extent)
plot(monomoy_2020)

monomoy_2019 <- crop(x = cod_2019, y = monomoy_extent)
plot(monomoy_2019)

monomoy_2018 <- crop(x = cod_2018, y = monomoy_extent)
plot(monomoy_2018)

monomoy_2017 <- crop(x = cod_2017, y = monomoy_extent)
plot(monomoy_2017)

monomoy_2016 <- crop(x = cod_2016, y = monomoy_extent)
plot(monomoy_2016)

monomoy_2015 <- crop(x = cod_2015, y = monomoy_extent)
plot(monomoy_2015)

monomoy_2014 <- crop(x = cod_2014, y = monomoy_extent)
plot(monomoy_2014)

monomoy_2013 <- crop(x = cod_2013, y = monomoy_extent)
plot(monomoy_2013)

# __________Analyze distribution of sandy beaches within the nature reserve___________________________________________________________________________________________________

# Emphasises coastal sands with bright white sand:
par(mfrow=c(2,4))
plotRGB(monomoy_2013, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2014, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2015, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2016, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2017, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2018, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2019, 1, 2, 3, stretch="Lin")
plotRGB(monomoy_2020, 1, 2, 3, stretch="Lin")

# Band 6 (Short Wave Infra Red 1) Clearly shows all exposed land and also includes sands very close to the surface, but with values close to those of the water:
par(mfrow=c(2,4))
plot(monomoy_2013$cod_2013_B6, col=mono)
plot(monomoy_2014$cod_2014_B6, col=mono)
plot(monomoy_2015$cod_2015_B6, col=mono)
plot(monomoy_2016$cod_2016_B6, col=mono)
plot(monomoy_2017$cod_2017_B6, col=mono)
plot(monomoy_2018$cod_2018_B6, col=mono)
plot(monomoy_2019$cod_2019_B6, col=mono)
plot(monomoy_2020$cod_2020_B6, col=mono)

# __________NDWI = (Coastal-NIR)/(Coastal+NIR)________________________________________________________________________________________________________________________________

# Very similar to the other NDWI but shows only exposed sand, with greater contrast between land and water:

NDWIa_monomoy_2013 <- (monomoy_2013$cod_2013_B1 - monomoy_2013$cod_2013_B5)/(monomoy_2013$cod_2013_B1 + monomoy_2013$cod_2013_B5)
NDWIa_monomoy_2014 <- (monomoy_2014$cod_2014_B1 - monomoy_2014$cod_2014_B5)/(monomoy_2014$cod_2014_B1 + monomoy_2014$cod_2014_B5)
NDWIa_monomoy_2015 <- (monomoy_2015$cod_2015_B1 - monomoy_2015$cod_2015_B5)/(monomoy_2015$cod_2015_B1 + monomoy_2015$cod_2015_B5)
NDWIa_monomoy_2016 <- (monomoy_2016$cod_2016_B1 - monomoy_2016$cod_2016_B5)/(monomoy_2016$cod_2016_B1 + monomoy_2016$cod_2016_B5)
NDWIa_monomoy_2017 <- (monomoy_2017$cod_2017_B1 - monomoy_2017$cod_2017_B5)/(monomoy_2017$cod_2017_B1 + monomoy_2017$cod_2017_B5)
NDWIa_monomoy_2018 <- (monomoy_2018$cod_2018_B1 - monomoy_2018$cod_2018_B5)/(monomoy_2018$cod_2018_B1 + monomoy_2018$cod_2018_B5)
NDWIa_monomoy_2019 <- (monomoy_2019$cod_2019_B1 - monomoy_2019$cod_2019_B5)/(monomoy_2019$cod_2019_B1 + monomoy_2019$cod_2019_B5)
NDWIa_monomoy_2020 <- (monomoy_2020$cod_2020_B1 - monomoy_2020$cod_2020_B5)/(monomoy_2020$cod_2020_B1 + monomoy_2020$cod_2020_B5)

par(mfrow=c(2,4))
plot(NDWIa_monomoy_2013, col=mono)
plot(NDWIa_monomoy_2014, col=mono)
plot(NDWIa_monomoy_2015, col=mono)
plot(NDWIa_monomoy_2016, col=mono)
plot(NDWIa_monomoy_2017, col=mono)
plot(NDWIa_monomoy_2018, col=mono)
plot(NDWIa_monomoy_2019, col=mono)
plot(NDWIa_monomoy_2020, col=mono)

# Remove all values between -0.1 and 1  to remove water and any tidal sands:
NDWIa_monomoy_2013land <- reclassify(NDWIa_monomoy_2013, cbind(-0.1, 1, NA))
NDWIa_monomoy_2014land <- reclassify(NDWIa_monomoy_2014, cbind(-0.1, 1, NA))
NDWIa_monomoy_2015land <- reclassify(NDWIa_monomoy_2015, cbind(-0.1, 1, NA))
NDWIa_monomoy_2016land <- reclassify(NDWIa_monomoy_2016, cbind(-0.1, 1, NA))
NDWIa_monomoy_2017land <- reclassify(NDWIa_monomoy_2017, cbind(-0.1, 1, NA))
NDWIa_monomoy_2018land <- reclassify(NDWIa_monomoy_2018, cbind(-0.1, 1, NA))
NDWIa_monomoy_2019land <- reclassify(NDWIa_monomoy_2019, cbind(-0.1, 1, NA))
NDWIa_monomoy_2020land <- reclassify(NDWIa_monomoy_2020, cbind(-0.1, 1, NA))

# Showing only exposed land:
# Brightest colour indicates bare sand
# Darkest colour indicates relatively dense vegetation
par(mfrow=c(2,4))
plot(NDWIa_monomoy_2013land, col=mono)
plot(NDWIa_monomoy_2014land, col=mono)
plot(NDWIa_monomoy_2015land, col=mono)
plot(NDWIa_monomoy_2016land, col=mono)
plot(NDWIa_monomoy_2017land, col=mono)
plot(NDWIa_monomoy_2018land, col=mono)
plot(NDWIa_monomoy_2019land, col=mono)
plot(NDWIa_monomoy_2020land, col=mono)

# __________Unsupervised classification of Monomoy Nature Reserve_____________________________________________________________________________________________________________

# 2 classes:
# Bare sand and vegetation (dunes and salt marsh)
classmonomoy_2013_2 <- unsuperClass(NDWIa_monomoy_2013land, nClasses=2)
classmonomoy_2014_2 <- unsuperClass(NDWIa_monomoy_2014land, nClasses=2)
classmonomoy_2015_2 <- unsuperClass(NDWIa_monomoy_2015land, nClasses=2)
classmonomoy_2016_2 <- unsuperClass(NDWIa_monomoy_2016land, nClasses=2)
classmonomoy_2017_2 <- unsuperClass(NDWIa_monomoy_2017land, nClasses=2)
classmonomoy_2018_2 <- unsuperClass(NDWIa_monomoy_2018land, nClasses=2)
classmonomoy_2019_2 <- unsuperClass(NDWIa_monomoy_2019land, nClasses=2)
classmonomoy_2020_2 <- unsuperClass(NDWIa_monomoy_2020land, nClasses=2)

par(mfrow=c(2,4))
plot(classmonomoy_2013_2$map, col=changer)
plot(classmonomoy_2014_2$map, col=changer)
plot(classmonomoy_2015_2$map, col=changer)
plot(classmonomoy_2016_2$map, col=changer)
plot(classmonomoy_2017_2$map, col=changer)
plot(classmonomoy_2018_2$map, col=changer)
plot(classmonomoy_2019_2$map, col=changer)
plot(classmonomoy_2020_2$map, col=changer)

total_monomoy <- 1946+3764+4977+120893
total_monomoy
# [1] 131580

freq(classmonomoy_2013_2$map)
#  count (2013)
#   7859 (bare sand)
#   3656 (vegetation)

freq(classmonomoy_2014_2$map)
#  count (2014)
#   3765 (vegetation)
#   6922 (bare sand)

freq(classmonomoy_2015_2$map)
#  count (2015)
#   7081 (bare sand)
#   3575 (vegetation)

freq(classmonomoy_2016_2$map)
#  count (2016)
#   3692 (vegetation)
#   7828 (bare sand)

freq(classmonomoy_2017_2$map)
#  count (2017)
#   3636 (vegetation)
#   6675 (bare sand)

freq(classmonomoy_2018_2$map)
#  count (2018)
#   4118 (vegetation)
#   6483 (bare sand)

freq(classmonomoy_2019_2$map)
#  count (2019)
#   6385 (bare sand))
#   3115 (vegetation)

freq(classmonomoy_2020_2$map)
#  count (2020)
#   2553 (vegetation)
#   6381 (bare sand)

# __________Calculating land area in hectares using frequencies_______________________________________________________________________________________________________________

# To calculate the area in hectares, considering that each pixel is 30 x 30 metres:
area_monomoy_2013 <- (freq(classmonomoy_2013_2$map)*30*30)/10000
area_monomoy_2013
# 707.31 (bare sand)
# 329.04 (vegetation)

area_monomoy_2014 <- (freq(classmonomoy_2014_2$map)*30*30)/10000
area_monomoy_2014
# 338.85 (vegetation)
# 622.98 (bare sand)

area_monomoy_2015 <- (freq(classmonomoy_2015_2$map)*30*30)/10000
area_monomoy_2015
# 321.75 (vegetation)
# 637.29 (bare sand)

area_monomoy_2016 <- (freq(classmonomoy_2016_2$map)*30*30)/10000
area_monomoy_2016
# 332.28 (vegetation)
# 704.52 (bare sand)

area_monomoy_2017 <- (freq(classmonomoy_2017_2$map)*30*30)/10000
area_monomoy_2017
# 327.24 (vegetation)
# 600.75 (bare sand)

area_monomoy_2018 <- (freq(classmonomoy_2018_2$map)*30*30)/10000
area_monomoy_2018
# 370.62 (vegetation)
# 583.47 (bare sand)

area_monomoy_2019 <- (freq(classmonomoy_2019_2$map)*30*30)/10000
area_monomoy_2019
# 574.65 (bare sand)
# 280.35 (vegetation)

area_monomoy_2020 <- (freq(classmonomoy_2020_2$map)*30*30)/10000
area_monomoy_2020
# 229.77 (vegetation)
# 574.29 (bare sand)

# __________Monomoy data frame and graph for ecosystem cover__________________________________________________________________________________________________________________

# To create the data frame:
monomoy_groundcover <- data.frame(monomoycover=c('Sabbia nuda','Vegetazione'), monomoy2013=c(707,329), monomoy2014=c(623,339), monomoy2015=c(637,322), monomoy2016=c(705,332), monomoy2017=c(601,327), monomoy2018=c(583,371), monomoy2019=c(575,280), monomoy2020=c(574,230))
years <- c('monomoy2013'="2013",'monomoy2014'="2014",'monomoy2015'="2015",'monomoy2016'="2016",'monomoy2017'="2017",'monomoy2018'="2018",'monomoy2019'="2019",'monomoy2020'="2020")
melt_groundcover <- melt(monomoy_groundcover, id.vars='monomoycover')

# To create the graph:
ggplot(melt_groundcover, aes(x=monomoycover, y=value, fill=monomoycover)) + scale_fill_brewer(palette="Blues") + geom_bar(stat='identity') +
facet_grid(.~ variable, labeller = as_labeller(years)) + labs(y= "Area (ha)", x = "Tipologia di terreno")  + ggtitle("Tipologie di terreno e rispettive estensioni nella Riserva Statale di Monomoy dall'anno 2013 al 2020") +
theme_bw() + scale_x_discrete(limits=c("Sabbia nuda","Vegetazione")) + theme(axis.text.x=element_blank()) + guides(fill=guide_legend("Tipologia di terreno")) +
theme(plot.title = element_text(hjust = 0.5))

# __________Monomoy data frame for bare sand and plover_______________________________________________________________________________________________________________________

sand_year <- c(2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020)
sand_area <- c(707, 623, 637, 705, 601, 583, 575, 574)
sand_pairs <- c(52, 44, 45, 52, 48, 36, 31, 29)

# To assign the name to the dataframe:
monomoy_sand_plover <- data.frame(sand_year, sand_area, sand_pairs)
monomoy_sand_plover

plover_graph_sand <- ggplot(monomoy_sand_plover, aes(x =factor(sand_year))) + theme_bw() +
labs(x = "Anno") + ggtitle("Numero di coppie nidificanti del corriere canoro ed estensione della sabbia nuda nella Riserva Statale di Monomoy")  +
theme(plot.title = element_text(hjust = 0.5)) +
  geom_col(aes(y = sand_area), size = 1, color = "darkblue", fill = "white") + 
  geom_line(aes(y = 12*sand_pairs), size = 1.5, color="red", group = 1) +
  scale_y_continuous(name = "Area di sabbia nuda (ha)", limits = c(0,750), breaks = seq(0,750, by = 100), sec.axis = sec_axis(~./12, name = "Numero di coppie nidificanti")) 


grid.arrange(plover_graph_sand, nrow=1)

# __________Monomoy data frame for vegetation and plover_________________________________________________________________________________________________________________

veg_year <- c(2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020)
veg_area <- c(329, 339, 322, 332, 327, 371, 280, 230)
veg_pairs <- c(52, 44, 45, 52, 48, 36, 31, 29)

# To assign the name to the dataframe:
monomoy_veg_plover <- data.frame(veg_year, veg_area, veg_pairs)
monomoy_veg_plover

plover_graph_veg <- ggplot(monomoy_veg_plover, aes(x =factor(veg_year))) + theme_bw() +
labs(x = "Anno") + ggtitle("Numero di coppie nidificanti del corriere canoro ed estensione della vegetazione costiera nella Riserva Statale di Monomoy")  +
theme(plot.title = element_text(hjust = 0.5)) +
  geom_col(aes(y = veg_area), size = 1, color = "darkblue", fill = "white") + 
  geom_line(aes(y = 12*veg_pairs), size = 1.5, color="red", group = 1) +
  scale_y_continuous(name = "Area di vegetazione costiera (ha)", limits = c(0,750), breaks = seq(0,750, by = 100), sec.axis = sec_axis(~./12, name = "Numero di coppie nidificanti")) 


grid.arrange(plover_graph_veg, nrow=1)

# __________To plot them together____________________________________________________________________________________________________________________________________________

grid.arrange(plover_graph_sand, plover_graph_veg, nrow=1)

# __________Calculating Pearson's correlation coefficient____________________________________________________________________________________________________________________
# __________For bare sand and plover pairs___________________________________________________________________________________________________________________________________

# To check if the data are normally distributed:
dist_sand_plover_area <- shapiro.test(monomoy_sand_plover$sand_area) 
dist_sand_plover_area
# p = 0.08485 (above significance threshold of 0.05, so considered normally distributed)

dist_sand_plover_pairs <- shapiro.test(monomoy_sand_plover$sand_pairs)
dist_sand_plover_pairs
# p = 0.2752 (above significance threshold of 0.05, so considered normally distributed)

# To calculate the correlation coefficient for bare sand and breeding pairs:
cor_sand_plover <- cor.test(sand_area, sand_pairs, method = c("pearson"))
cor_sand_plover
# R = 0.8614462

# To create the scatter plot with line of best fit:
scatter_sand_plover <- ggscatter(monomoy_sand_plover, x = "sand_area", y = "sand_pairs", add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", xlab = "Area di sabbia nuda (ha)", ylab = "Numero di coppie nidificanti")
scatter_sand_plover

# __________For vegetation and plover pairs___________________________________________________________________________________________________________________________________

# To check if the data are normally distributed:
dist_veg_plover_area <- shapiro.test(monomoy_veg_plover$veg_area) 
dist_veg_plover_area
# p = 0.1622 (above significance threshold of 0.05, so considered normally distributed)

dist_veg_plover_pairs <- shapiro.test(monomoy_veg_plover$veg_pairs)
dist_veg_plover_pairs
# p = 0.2752 (above significance threshold of 0.05, so considered normally distributed)

# To calculate the correlation coefficient for vegetation and breeding pairs:
cor_veg_plover <- cor.test(veg_area, veg_pairs, method = c("pearson"))
cor_veg_plover
# R = 0.5905803 

# To create the scatter plot with line of best fit:
scatter_veg_plover <- ggscatter(monomoy_veg_plover, x = "veg_area", y = "veg_pairs", add = "reg.line", conf.int = TRUE, cor.coef = TRUE, cor.method = "pearson", xlab = "Area di vegetazione costiera (ha)", ylab = "Numero di coppie nidificanti")
scatter_veg_plover

# ____________________________________________________________________________________________________________________________________________________________________________

# To plot both scatter plots together:
both_scatters <- grid.arrange(scatter_sand_plover, scatter_veg_plover, nrow=1, top= "Correlazione fra il numero di coppie nidificanti del corriere canoro e rispettive estensioni \n della sabbia nuda e della vegetazione costiera nella Riserva Statale di Monomoy tra l'anno 2013 e il 2020")
both_scatters

# ____________________________________________________________________________________________________________________________________________________________________________


