# Esame di Telerilevamento

library(raster)
library(rasterdiv)
library(ggplot2)
library(viridis)
library(RStoolbox)
library(imagefx)
setwd("C:/esame/")

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
