# Remote Sensing Exam

# __________Libraries and working directory_______________________________________________________________________________________________

library(raster)
library(rasterdiv)
library(ggplot2)
library(viridis)
library(RStoolbox)
library(imagefx)
setwd("C:/esame/")

# __________Importing images____________________________________________________________________________________________________________

# To list all the files together, with the common pattern "cod" in the file name:
codlist <- list.files(pattern="cod")
codlist

# To have each file as a raster brick, with each image containing three layers:
codimport <- lapply(codlist,brick)
codimport

# To import all of the images as a stack:
codstack <- stack(codimport)
codstack

# To assign a name to the first rasterbrick:
codimage1 <- brick("cod_1993.jpg")

# To crop the first rasterbrick:
cod1993 <- crop(codimage1, extent(codimage1, 10, 2000, 10, 2000))

# To create a colour palette:
colour <- colorRampPalette(c("black","dark grey","light grey"))(100)

# To plot the image with this colour palette:
plot(cod1993, col=colour)

# To use the RGB function, showing sediment load:
plotRGB(cod1993, 2, 1, 3, stretch="Lin")

# To view ONLY the first layer of the first image, using the colour palette:
plot(cod1993$cod_1993.1, col=colour)

# __________Cropping original images_____________________________________________________________________________________________________

# To upload the first raster
cod1993 <- raster("cod_1993.jpg")

# To plot the raster
plot(cod1993)

# To draw the area I want to crop
codcrop1993 <- drawExtent(show=TRUE, col="red") 

# To create the cropped object
newcrop1993 <- crop(x = cod1993, y = codcrop1993)

# To plot the cropped object
plot(newcrop1993)

# To set the x and y values for the cropped area to be used with any of the rasters:
new_extent <- extent(1815, 2374, 291, 1003)
class(new_extent)

# To plot the new cropped area
newcrop2003 <- crop(x = cod2003, y = new_extent)

# _______________________________________________________________________________________________

# To assign a name to each raster
cod1993 <- raster("cod_1993.jpg")
cod1997 <- raster("cod_1997.jpg")
cod2003 <- raster("cod_2003.jpg")
cod2008 <- raster("cod_2008.jpg")
cod2013 <- raster("cod_2013.jpg")
cod2018 <- raster("cod_2018.jpg")

# To use the specified extent box to crop all images:
newcrop1993 <- crop(x = cod1993, y = new_extent)
newcrop1997 <- crop(x = cod1997, y = new_extent)
newcrop2003 <- crop(x = cod2003, y = new_extent)
newcrop2008 <- crop(x = cod2008, y = new_extent)
newcrop2013 <- crop(x = cod2013, y = new_extent)
newcrop2018 <- crop(x = cod2018, y = new_extent)

# __________Experimenting with colours_____________________________________________________________________________________________________

# To plot each cropped area in black and white:
par(mfrow=c(2,3))
plot(newcrop1993, col=colour)
plot(newcrop1997, col=colour)
plot(newcrop2003, col=colour)
plot(newcrop2008, col=colour)
plot(newcrop2013, col=colour)
plot(newcrop2018, col=colour)

codlist <- list.files(pattern="cod")
codlist

codimport <- lapply(codlist,brick)
codimport

# To import all of the images as a stack:
codstack <- stack(codimport)
codstack

# To plot all of them together
par(mfrow=c(2,3))
plot(cod1993, col=colour)
plot(cod1997, col=colour)
plot(cod2003, col=colour)
plot(cod2008, col=colour)
plot(cod2013, col=colour)
plot(cod2018, col=colour)

# First and last year
par(mfrow=c(1,2))
plot(cod1993, col=colour)
plot(cod2018, col=colour)


