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
setwd("C:/esame/")

# __________Importing images__________________________________________________________________________________________________________________________________________________

# To list all the files together, with the common pattern "cod" in the file name:
codlist <- list.files(pattern="cod")
codlist

# To have each file as a raster brick, with each image containing three layers:
codimport <- lapply(codlist,brick)
codimport

# Did not import them as a stack as one image had a slightly different extent so I uploaded them manually as rasters or bricks accordingly (see below)

# __________Cropping original images__________________________________________________________________________________________________________________________________________

# To upload the first raster:
cod1993 <- raster("cod_1993.jpg")

# To plot the raster:
plot(cod1993)

# To specify the area I want to crop by drawing a box around it:
codcrop1993 <- drawExtent(show=TRUE, col="red") 

# To create the cropped object for raster 1993:
newcrop1993 <- crop(x = cod1993, y = codcrop1993)

# To plot the cropped object:
plot(newcrop1993)

# To set the x and y values for the cropped area to be used with any of the rasters:
new_extent <- extent(1815, 2374, 291, 1003)
class(new_extent)

# To check that the "extent" works and create a new cropped area for raster 2003:
newcrop2003 <- crop(x = cod2003, y = new_extent)

# ___________Importing rasters, assigning names and cropping them with extent_________________________________________________________________________________________________

# To assign names to images as rasters:
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

# __________Experimenting with rasters and colours____________________________________________________________________________________________________________________________

# To create a colour palette:
colour <- colorRampPalette(c("black","dark grey","light grey"))(100)

# To plot all of them together
par(mfrow=c(2,3))
plot(newcrop1993, col=colour)
plot(newcrop1997, col=colour)
plot(newcrop2003, col=colour)
plot(newcrop2008, col=colour)
plot(newcrop2013, col=colour)
plot(newcrop2018, col=colour)

# First and last year
par(mfrow=c(1,2))
plot(newcrop1993, col=colour)
plot(newcrop2018, col=colour)

# To create a colour palette:
greek <- colorRampPalette(c("dark blue","blue","white"))(100)

# First and last year with "greek"
par(mfrow=c(1,2))
plot(newcrop1993, col=greek)
plot(newcrop2018, col=greek)
# Shows some contrast with ocean in dark blue, land in blue and exposed sands in white

# To create a colour palette:
blbl <- colorRampPalette(c("black","blue","white"))(100)

# First and last year with "blbl"
par(mfrow=c(1,2))
plot(newcrop1993, col=blbl)
plot(newcrop2018, col=blbl)
# Shows great contrast with ocean in black and sedimentation differences in blue or yellow

# To create a colour palette:
changer <- colorRampPalette(c("steelblue3","black","yellow"))(100)

# To create a colour palette:
fire <- colorRampPalette(c("white","orange3","purple"))(100)

# __________Importing bricks, assigning names and cropping them with extent___________________________________________________________________________________________________

# To assign names to bricks with all bands:
cod1993brick <- brick("cod_1993.jpg")
cod1997brick <- brick("cod_1997.jpg")
cod2003brick <- brick("cod_2003.jpg")
cod2008brick <- brick("cod_2008.jpg")
cod2013brick <- brick("cod_2013.jpg")
cod2018brick <- brick("cod_2018.jpg")

# To use the specified extent box to crop all raster bricks:
newcrop1993brick <- crop(x = cod1993brick, y = new_extent)
newcrop1997brick <- crop(x = cod1997brick, y = new_extent)
newcrop2003brick <- crop(x = cod2003brick, y = new_extent)
newcrop2008brick <- crop(x = cod2008brick, y = new_extent)
newcrop2013brick <- crop(x = cod2013brick, y = new_extent)
newcrop2018brick <- crop(x = cod2018brick, y = new_extent)

# __________Experimenting with bricks and RGB plots to best visualize the geomorphology of the coast__________________________________________________________________________

# Underwater sediment is yellow and inland is green
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 3, 2, 1, stretch="Lin")
plotRGB(newcrop1997brick, 3, 2, 1, stretch="Lin")
plotRGB(newcrop2003brick, 3, 2, 1, stretch="Lin")
plotRGB(newcrop2008brick, 3, 2, 1, stretch="Lin")
plotRGB(newcrop2013brick, 3, 2, 1, stretch="Lin")
plotRGB(newcrop2018brick, 3, 2, 1, stretch="Lin")

# Underwater sediement is yellow and inland is magenta
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 2, 3, 1, stretch="Lin")
plotRGB(newcrop1997brick, 2, 3, 1, stretch="Lin")
plotRGB(newcrop2003brick, 2, 3, 1, stretch="Lin")
plotRGB(newcrop2008brick, 2, 3, 1, stretch="Lin")
plotRGB(newcrop2013brick, 2, 3, 1, stretch="Lin")
plotRGB(newcrop2018brick, 2, 3, 1, stretch="Lin")

# Underwater sediment is turquoise and inland is green
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 1, 2, 3, stretch="Lin")
plotRGB(newcrop1997brick, 1, 2, 3, stretch="Lin")
plotRGB(newcrop2003brick, 1, 2, 3, stretch="Lin")
plotRGB(newcrop2008brick, 1, 2, 3, stretch="Lin")
plotRGB(newcrop2013brick, 1, 2, 3, stretch="Lin")
plotRGB(newcrop2018brick, 1, 2, 3, stretch="Lin")

# Underwater sediment is magenta and inland is green
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 3, 1, 2, stretch="Lin")
plotRGB(newcrop1997brick, 3, 1, 2, stretch="Lin")
plotRGB(newcrop2003brick, 3, 1, 2, stretch="Lin")
plotRGB(newcrop2008brick, 3, 1, 2, stretch="Lin")
plotRGB(newcrop2013brick, 3, 1, 2, stretch="Lin")
plotRGB(newcrop2018brick, 3, 1, 2, stretch="Lin")

# Underwater sediment is magenta and inland is green, with white sand and good contrast:
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 2, 1, 3, stretch="Lin")
plotRGB(newcrop1997brick, 2, 1, 3, stretch="Lin")
plotRGB(newcrop2003brick, 2, 1, 3, stretch="Lin")
plotRGB(newcrop2008brick, 2, 1, 3, stretch="Lin")
plotRGB(newcrop2013brick, 2, 1, 3, stretch="Lin")
plotRGB(newcrop2018brick, 2, 1, 3, stretch="Lin")

# Underwater sediment is magenta and inland is green but "hist" is too blurry and hinders visualization of geomorphology
par(mfrow=c(2,3))
plotRGB(newcrop1993brick, 2, 1, 3, stretch="hist")
plotRGB(newcrop1997brick, 2, 1, 3, stretch="hist")
plotRGB(newcrop2003brick, 2, 1, 3, stretch="hist")
plotRGB(newcrop2008brick, 2, 1, 3, stretch="hist")
plotRGB(newcrop2013brick, 2, 1, 3, stretch="hist")
plotRGB(newcrop2018brick, 2, 1, 3, stretch="hist")

# __________Experimenting with different bands within the bricks to visualize geomorphology___________________________________________________________________________________

# Coastal geomorphology with first band of first and last year:
par(mfrow=c(1,2))
plot(newcrop1993brick$cod_1993.1, col=blbl)
plot(newcrop2018brick$cod_2018.1, col=blbl)
        # First band is useful for visualizing the geomorphological changes above sea level

# Coastal geomorphology with second band of first and last year:
par(mfrow=c(1,2))
plot(newcrop1993brick$cod_1993.2, col=blbl)
plot(newcrop2018brick$cod_2018.2, col=blbl)
        # Second band is useful for visualizing underwater sediment

# Coastal geomorphology with third band of first and last year:
par(mfrow=c(1,2))
plot(newcrop1993brick$cod_1993.3, col=blbl)
plot(newcrop2018brick$cod_2018.3, col=blbl)
        # Third band is a mid-way reflection between the first two bands and removes the noise of the second band

# __________Calculating the degree of change in geomorphology between 1993 and 2018___________________________________________________________________________________________

# Subtracting the first year from the last year to find the difference:
codchange <- newcrop2018brick - newcrop1993brick
plot(codchange, col=changer)

# Investigating the degree of change shown by the first layer of each year, as it shows good contrast between stable and active sediment zones:
codchangefirstband <- newcrop2018brick$cod_2018.1 - newcrop1993brick$cod_1993.1

# Levelplot, using previously created colour palette, to analyse the degree of change in the first band:
levelplot(codchangefirstband, col.regions=changer)

# __________Principal Components Analysis (PCA)_______________________________________________________________________________________________________________________________

# Aggregate the raster cells and look at the dimensions to see how many pixels there are per band:
# Resampling by a factor of 10:

# To conduct a PCA:

# __________Unsupervised classification_______________________________________________________________________________________________________________________________________

# To classify the brick into 2 classes:
class1993 <- unsuperClass(newcrop1993brick, nClasses=2)
plot(class1993$map)

# __________Normalized Difference Water Index (NDWI)__________________________________________________________________________________________________________________________

NDWI1993 <- (newcrop1993brick$cod_1993.2 - newcrop1993brick$cod_1993.3)/(newcrop1993brick$cod_1993.2 + newcrop1993brick$cod_1993.3)
NDWI2018 <- (newcrop2018brick$cod_2018.2 - newcrop2018brick$cod_2018.3)/(newcrop2018brick$cod_2018.2 + newcrop2018brick$cod_2018.3)

NDWIdiff <- NDWI2018-NDWI1993

# ____________________________________________________________________________________________________________________________________________________________________________
