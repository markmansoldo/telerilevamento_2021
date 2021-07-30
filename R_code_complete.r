# R code complete - Telerilevamento Geo-Ecologico
#
# Summary:
#   1. R_code_remote_sensing_first
#   2. R_code_time_series
#   3. R_code_Copernicus
#   4. R_code_knitr
#   5. R_code_multivariate_analysis
#   6. R_code_classification
#   7. R_code_ggplot2
#   8. R_code_vegetation_indices
#   9. R_code_land_cover
#  10. R_code_variability
#  11. R_code_spectral_signatures

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 1: R_code_remote_sensing_first

# Il mio primo codice in R per il telerilevamento!

# To open the file in the set working directory:
setwd("C:/lab/")

# To use the "raster" package, already downloaded
# Put all libraries here at the beginning of each file:
library(raster)

# Brick function: upload file with all bands included (a multi-layered raster object from a multi-banded file)
# Use "<-" to assign a name to an object:
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

# To plot this object:
plot(p224r63_2011)

# colorRampPalette function: create a colour scheme. "100" is the colour depth.
# Use "<-" to assign a name to this colour palette:
cl <- colorRampPalette(c("black","grey","light grey")) (100)

# To plot the image with this colour scheme:
plot(p224r63_2011, col=cl)

# To create another colour scheme and plot it:
cl2 <- colorRampPalette(c("dark blue","medium blue","light blue")) (100)
plot(p224r63_2011, col=cl2)

# To experiment with alternative colours and colour depth:
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)

# To close current graphic:
dev.off()

# To plot image with "cl" colour scheme:
plot (p224r63_2011, col=cl)

# To plot images with specific bands attached, use band codes.
# For Landsat bands, these are the colour reference codes:
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino (NIR Near Infra Red)
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# To plot the image with the blue band (B1) attached:
plot(p224r63_2011$B1_sre)

# To plot the image with the green band (B2) attached:
plot(p224r63_2011$B2_sre)

# To change the layout of the graphics:
# First number = row
# Second number = column

# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 rows, 1 column
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# To plot the first four bands of Landsat in 4 rows and 2 columns:
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre) # blue
plot(p224r63_2011$B2_sre) # green
plot(p224r63_2011$B3_sre) # red
plot(p224r63_2011$B4_sre) # NIR (Near Infra Red)

# To plot a quadrat of bands in 2 rows and 2 columns:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre) # blue
plot(p224r63_2011$B2_sre) # green
plot(p224r63_2011$B3_sre) # red
plot(p224r63_2011$B4_sre) # NIR (Near Infra Red)

# To plot a quadrat of bands in 2 rows and 2 columns, with a different colour scheme for each band:
par(mfrow=c(2,2))
 
     # Various shades of blue for the blue band (B1):
     clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
     plot(p224r63_2011$B1_sre, col=clb)

     # Various shades of green for the green band (B2):
     clg <- colorRampPalette(c("dark green","green","light green")) (100)
     plot(p224r63_2011$B2_sre, col=clg)

     # Various shades of red for the red band (B3):
     clr <- colorRampPalette(c("dark red","red","pink")) (100)
     plot(p224r63_2011$B3_sre, col=clr)

     # Alternative shades of red for the NIR Near Infra Red band (B4):
     clnir <- colorRampPalette(c("red","orange","yellow")) (100)
     plot(p224r63_2011$B4_sre, col=clnir)

# Landsat Bands
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

# plotRGB function: Make a Red-Green-Blue plot based on three layers (in a RasterBrick or RasterStack).
         # Three layers (sometimes referred to as "bands" because they may represent different bandwidths in the electromagnetic spectrum)
         # are combined such that they represent the red, green and blue channel. This function can be used to make 'true (or false) color images' from Landsat
         # and other multi-band satellite images.

# To plot the image using the RGB function, assigning the Landsat Bands to each colour channel:
# stretch="Lin": The stretch is normalized from 0 to 1 (Linear)
# stretch="hist": The stretch is divided into regular intervals (Histogram)

# r=red (B3), g=green (B2), b=blue (B1)
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") # very dark

# r=NIR (B4), g=red (B3), b=green (B2)
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") # very red

# r=red (B3), g=NIR (B4), b=green (B2)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") # very green

# r=red (B3), g=green (B2), b=NIR (B4)
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") # very blue

# Exercise: mount a 2x2 multiframe

# To print a PDF in R:
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

# To plot using the RGB function, assigned bands to each colour channel and the histogram stretch:
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") # green with magenta

 # To plot natural colours with aligned bands and channels, false colours and false colours with histogram stretching:
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

# To install a package:
install.packages("RStoolbox")

# To use a package, already installed:
library(RStoolbox)

# Multitemporal set with assigned name to brick function object:
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988

# To plot this object:
plot(p224r63_1988)

# To plot this object with colour channels and linear stretching:
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

# To compare differences between years (1988 and 2011):
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

# To print a PDF:
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

# Here we can compare how linear and histogram stretching emphasise things differently:
# "Lin" = useful for vegetation
# "hist" = useful for contrasting large areas, for example the extension of urbanization, water bodies, agricultural fields etc.

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2: R_code_time_series
# Time series analysis
# Greenland increase of temperature

# To extract this file from inside R, so no need to use speech marks "")
# Always put the libraries and set working directory at the beginning of the file:
library(raster)
setwd("C:/lab/greenland")

#07/04/21

# To import each file from outside R and assign a name:
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

# To plot the maps with 2 rows and 2 columns:
# par (multipanel/quadrat)
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# To list files with a common expression/pattern that is present in each file and assign a name to the list:
rlist <- list.files(pattern="lst")
rlist

# lapply function: import a list-like or vector-like object as a raster
import <- lapply(rlist,raster)
import

# stack function: stacking files into one block to avoid uploading each image separately:
TGr <- stack(import)
TGr
plot(TGr) # Plot this file with all the files inside the stack

# To add the colour depending on the year/file order
# All files selected overlap in the plot
# First is red, second is green, third is blue
# No need to write the "r=" each time as the colour channels are implied:
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

#09/04/21

# File found within R so no need for the speech marks ""
library(rasterVis)

#3 key steps:

                   #1 To create a list using a common pattern in the file name (i.e. 1st):
                 rlist <- list.files(pattern="lst") #assign this name to this list using a common pattern
                 rlist

                   #2 Import the file:
                 import <- lapply(rlist,raster) #assign this name to this list
                 import

                   #3 Stack/group the files to put them together in a block:
                 TGr <- stack(import)
                 TGr

 # To draw level plots: more powerful and useful than normal plots as they provide a scale to compare colours and values:
levelplot(TGr)

# Use the dollar symbol $ to select a layer within:
library(rgdal) 
levelplot(TGr$lst_2000)
levelplot(TGr)

# To create a colour scheme and plot with it:
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)

# Level plots over several years
# To assign a title to each graph, use: names.attr=c("","")
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# To assign a main title to the document, use: main=""
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Melt
# 3 key steps:

              #1 To create a list using a common pattern in the file name (i.e. melt):
            meltlist <- list.files(pattern="melt")

              #2 Import the file:
            melt_import <- lapply(meltlist,raster)

              #3 Stack/group the files to put them together in a block:
            melt <- stack(melt_import)

melt
levelplot(melt)

# Use the dollar symbol $ to specify the file within the folder

# IMPORTANT: To calculate the difference between the two years:
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

# To create a colour scheme:
clb <- colorRampPalette(c("blue","white","red"))(100) 
plot(melt_amount, col=clb) 

# To create level plot with this colour palette clb
levelplot(melt_amount, col.regions=clb) 

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3: R_code_Copernicus
# Visualizing Copernicus data

# Always place libraries and the set working directory at the beginning of the file:
install.packages("ncdf4")
library(raster)
library(ncdf4)
setwd("C:/lab/")

# Import copernicus data file:
copernicus <- raster("copernicus_data.nc")
copernicus

# Colour palette to be used for the plot:
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(copernicus, col=cl)

#To aggregate pixels
#Resampling
copernicusagg <- aggregate(copernicus, fact=100) #assign name to new aggregate
plot(copernicusagg, col=cl) #plot new aggregate using this palette

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 4: R_code_knitr

# 16/04/21

# knitr is a package that allows code integration in LaTeX, LyX, HTML and reStructuredText documents. It allows research to be transferrable through literate programming.
install.packages("knitr")
library(knitr)
setwd("C:/lab/")

# the stitch function is used for small-scale automatic reporting based on an R script and a template. The default template is a Rnw file (LaTeX).
stitch("rcodegreenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 5: R_code_multivariate_analysis

# 23/04/21

library(raster)
library(RStoolbox)
setwd("C:/lab/")

# We use the brick function to upload the whole multi-layered raster object together:
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

# Use the dollar symbol $ to present a layer from a brick object:
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)
# B1 = Band 1, B2 = Band 2
# "col" assigns the colour of the graph
# "pch=19" assigns the symbol for the graph

# Pairs: Scatterplot Matrices
# We can compare between different bands in a huge matrix of graphs, along with significance values
pairs(p224r63_2011)

# 28/04/21

# Aggregate package: aggregate raster cells or spatial polygons
# Look at the "dimensions" of the file to understand how many pixels there are per band
# Resampling (ricampionamento) of a factor of 10:
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

# To display two plots together:
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# To conduct a Principal Components Analysis (PCA):
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

# Summary package: 
summary(p224r63_2011res_pca$model)

# To close the previously created images:
dev.off()

# To plot a particular layer using the dollar symbol $ with assigned bands and linear stretching:
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 6: R_code_classification

# 21/04/21

library(raster)
library(RStoolbox)
setwd("C:/lab/")

# To create a RasterBrick object, use "brick" and assign the name with the <-
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# To visualize RGB levels:
plotRGB(so, 1, 2, 3, stretch="lin")

# Unsupervised classification
          # In unsupervised classification, we use the reflectance data, but we don’t supply any response data,
          # meaning that we do not identify any pixel as belonging to a particular class.
          # This may seem odd, but it can be useful when we don’t have much prior knowledge of a study area or if you have
          # broad knowledge of the distribution of land cover classes of interest, but no specific ground data.
          # The algorithm groups pixels with similar spectral characteristics into groups.

# Unsupervised classification with 3 classes:
soc <- unsuperClass(so, nClasses=3)
plot(soc$map)

# Unsupervised classification with 20 classes:
# We assign a different name, otherwise the previous file "soc" gets overwritten:
som <- unsuperClass(so, nClasses=20)
plot(som$map)

# Download image of the sun from ESA Multimedia as a brick object:
sun <- brick("sun.png")

# Unsupervised classification with 3 classes:
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

# To create a colour palette:
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(sunc$map,col=cl)

# 23/04/21

# Using the brick function to import a multi-layered raster:
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin") #linear stretch
plotRGB(gc, r=1, g=2, b=3, stretch="hist") #histogram stretch

# We don't use the full colour spectrum because of colour blindness.

# Unsupervised classifications:
gcc2 <- unsuperClass(gc, nClasses=2)
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 7: R_code_ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/")

# Use the brick function to upload a multi-layered raster:
p224r63 <- brick("p224r63_2011_masked.grd")

# ggRGB function
            # Calculates RGB color composite raster for plotting with ggplot2.
            # Optional values for clipping and and stretching can be used to enhance the imagery.

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

# To assign a name to each object:
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

# 
grid.arrange(p1, p2, nrow = 2) # This needs gridExtra

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 8: R_code_vegetation_indices

# 28/04/21

library(raster)
library(RStoolbox) # For vegetation indices calculation
setwd("C:/lab/")

# To upload both images that we will use:
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green
# NIR = near infrared 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# 05/05/21

library(rasterdiv) # For the global NDVI
library(rasterVis)

# Worldwide NDVI
plot(copNDVI) #Normalised Difference Vegetation Index 21/06

# Pixels with values 253, 254 and 255 (water) will be set as not applicable
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

levelplot(copNDVI)
# High values in yellow indicate high biomass and forest cover
# Low values in blue indicate low biomass

# 30/04/21

# You can also use require(raster) instead of library(raster)

# b1 = NIR, b2 = red, b3 = green
# NIR = near infrared 
# If you just type the name of the file, you can visualize all the details, including the names of the bands

# DVI: Difference Vegetation Index
# To create a map of the DVI, being the difference in wavelength, we subtract one band from another. The value of the resulting pixels will be the difference.

dvi1 <- defor1$defor1.1 - defor1$defor1.2
# Subtract the band defor1.2 from the band defor1.1, both found within the image called "defor1"
# This is how we find the difference between the pixels

# To create a colour palette:
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")

# Then we do exactly the same thing for defor2:
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")

# To plot them together:
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# To close previously created graphs use: dev.off() 

# To find the difference between them:
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100) #colour scheme
plot(difdvi, col=cld)

# EXTENT WARNING: If the warning message says that the raster objects have different extents, it's because the two images have a different number of pixels.

# NDVI: Normalized Difference Vegetation Index
# (NIR - RED) / (NIR + RED)

ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl) #use previously created colour scheme

# We can use the RStoolbox package for the spectralIndices function
# Follow the usage instructions to understand how to insert the function

# Spectral Indices function:
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# To find the difference between the two NDVIs:
difndvi <- ndvi1 - ndvi2

# With this colour palette:
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

#Many different indices exist, for example:
      #SAVI: Soil Adjusted Vegetation Index
      #NDWI: Normalized Difference Water Index

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 9: R_code_land_cover

# 05/05/21

library(raster)
library(RStoolbox) #classification
library(ggplot2)
library(gridExtra) #for grid.arrange plotting
setwd("C:/lab/")

# NIR 1, RED 2, GREEN 3

# Use the brick function for multi-layered raster objects:
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

# To plot them together:
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

# Multiframe with ggplot2 and gridExtra
         # ggplot2 Package: To create graphics, indicating how to map the variables aesthetically.
         # gridExtra: Allows you to arrange multiple grid-based plots on a page and draw tables.
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

# 07/05/21

# Unsupervised classification (unsupervised because the software does everything for us)
# crs = Reference System (lost when the data is downloaded)

d1c <- unsuperClass(defor1, nClasses=2)
# nClasses = number of Classes

plot(d1c$map)
# class 1: agriculture
# class 2: forest
# NOTE: Some plots have the value '1' as forest and '2' as agricultural land or vice versa
# set.seed() would allow you to attain the same results

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# NOTE: Some plots have the value '1' as forest and '2' as agricultural land or vice versa

d2c3 <- unsuperClass(defor2, nClasses=3) # with 3 classes
plot(d2c3$map)

# Use the "Frequencies" function to generate frequency tables, which counts the number of pixels for each class:
freq(d1c$map)
 value  count
[1,]     1  34647
[2,]     2 306645

# To figure out the proportion, we first find the total number of pixels (sum1):
s1 <- 34647+306645

# For the first proportion (prop1):
prop1 <- freq(d1c$map)/s1
prop1
# prop agirculture: 0.1015172
#      prop forest: 0.8984828

# For the second proportion (prop2):
s2 <- 342726
prop2 <- freq(d2c$map)/s2
prop2
#prop agirculture: 0.4786039
#     prop forest: 0.5213961

# To build a dataframe, with factors (aka: cover) being the percentage cover:
# We use the "" for words:
cover <- c("Forest","Agriculture") 
percent_1992 <- c(89.85, 10.15)
percent_2006 <- c(52.14, 47.86)
 
# To assign the name to the dataframe with the appropriate factors:
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

# BAR CHARTS
     # To make bar charts with the percentage cover land use, use ggplot:
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

# Then assign the names respectively:
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

# Use grid.arrange() to put two or more graphs together in the same space, found in the gridExtra package:
grid.arrange(p1, p2, nrow=1)

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 10: R_code_variability

# 19/05/21

library(raster)
library(RStoolbox)
library(ggplot2)   # for ggplot plotting
library(gridExtra) # for plotting ggplots together 
library(viridis)   # for ggplot colouring
setwd("C:/lab/")

# To assign a name to a multi-layered raster:
sent <- brick("sentinel.png")

# Bands: NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3

plotRGB(sent, stretch="lin")
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

# To associate a band to an object:
nir <- sent$sentinel.1
red <- sent$sentinel.2

# To calculate the NDVI:
ndvi <- (nir-red)/(nir+red)
plot(ndvi)

# To create a colour palette:
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) #colour scheme
plot(ndvi,col=cl) #to plot with the colour scheme

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
# nrow = number of rows
# ncol = number of columns
# fun = function
# sd = standard deviation

# NDVI: To plot the NDVI with the standard deviation:
plot(ndvisd3)

# To create a colour palette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 

# To plot with the colour scheme:
plot(ndvisd3, col=clsd)

# To calculate the mean NDVI with focal: it uses a matrix of weights for the neighborhood of the focal cells
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

# To plot the mean NDVI with the colour scheme:
plot(ndvimean3, col=clsd)

# To calculate the NDVI with standard deviation with a different number of rows and columns:
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd5, col=clsd)

# PCA: Principal Component Analysis
sentpca <- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$model)

# 21/05/21

pc1 <- sentpca$map$PC1
# PC1 is the name of the band
# pc1 is the name assigned to this object

# Focal function: it uses a matrix of weights for the neighborhood of the focal cells
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)

# To create and then plot with a colour palette:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)

# source
    # Used to upload and insert code created previously: source("")
    # Useful instead of 'copy and paste'
    # Must be in the working directory, otherwise it won't work
source("source_test_lezione.r")
source("source_ggplot.r")

# VERY USEFUL geom functions:
        # geom_point: used to create scatterplots
        # geom_line: used to connect single points
        # geom_raster: rectangles

# ggplot function: To create a new blank canvas for graphics
# geom_raster is added, with the axes equal to our current axes
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

# Standard deviation in the graphics is very useful for:
        # observing any kind of topographic discontinuity
        # observing ecological, ecotonal and geological variability

# Viridis package:
        # a collection of colour palettes easily visible to everyone, regardless of colour blindness
        # colour scales can be inserted using the legend, instead of having to write the order of each individual colour

# To open a blank canvas:
ggplot() +
# To use the geom_raster function to specify what to map:
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
# To use the default viridis colour scale
scale_fill_viridis()
# To add a title:
ggtitle("Standard deviation of PC1 by viridis colour scale") 

# To use the "magma" colour scale in viridis:
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

# To use the "inferno" colour scale in viridis:
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

# To create and assign the name "pN" to each ggplot, with 3 different colour scales:
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")
 
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")
 
# Use grid.arrange to plot them together:
grid.arrange(p1, p2, p3, nrow = 1)

# In general, rainbow palettes are avoided as the central value is yellow, but the human eye incorrectly assumes that yellow is the extreme value

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 11: R_code_spectral_signatures

# 16/06/21

library(raster)
library(rgdal)      # look at gdal.org
setwd("C:/lab/")

defor2 <- brick("defor2.jpg")
# Band names: defor2.1, defor2.2, defor2.3
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# Click on the image and you will see the information for that particular pixel:
#             id(identity), xy(spatial data), cell(pixel), type(point)
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Define the columns of the dataset:
band <- c(1,2,3)
forest <- c(206,6,19)
water <- c(40,99,139)

# To create the data frame:
spectrals <- data.frame(band, forest, water)

# To plot the spectral signatures:
 ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") 

#________Multitemporal Spectral Signatures_________________________________________________________________________________________________

# Spectral Signature: The variation of reflectance or emittance of a material with respect to wavelengths.

# Spectral signatures defor1:
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Spectral signatures defor2:
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# Define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time2 <- c(197,163,151)

# To create a data frame:
spectralst <- data.frame(band, time1, time2)

# To plot the sepctral signatures:
ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")

# To define the columns of the dataset:
band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)
 
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

# To plot the sepctral signatures:
ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="band",y="reflectance")

# To define the columns of the dataset:
band <- c(1,2,3)
stratum1 <- c(187,163,11)
stratum2 <- c(11,140,0)
stratum3 <- c(41,40,20)

# To create a data frame:
spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

# To plot the sepctral signatures:
ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow") +
 geom_line(aes(y=stratum2), color="green") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# END FILE
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

