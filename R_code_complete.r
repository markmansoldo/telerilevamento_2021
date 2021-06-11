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

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 1st file: R_code_remote_sensing_first

# Il mio primo codice in R per il telerilevamento!

setwd("C:/lab/")

library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#colour change
cl <- colorRampPalette(c("black","grey","light grey")) (100)

#colour change inserted into plot
plot(p224r63_2011, col=cl)

#colour change exercise
cl2 <- colorRampPalette(c("dark blue","medium blue","light blue")) (100)
plot(p224r63_2011, col=cl2)

cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)

dev.off()
plot (p224r63_2011, col=cl)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# 2 rows, 1 column
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

# plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands...:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2))
 
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #molto scuro

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #molto rosso

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #molto verde

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") #molto blu

# Exercise: mount a 2x2 multiframe

pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #verde con magenta

 # par natural colours, false colours, and false colours with histogram stretching
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

install.packages("RStoolbox")
library(RStoolbox)

#Multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
plot(p224r63_1988)
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#Compare 1988 and 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Lin and hist
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 2nd file: R_code_time_series
# Time series analysis
# Greenland increase of temperature

library(raster)  #extract this file from inside R
setwd("C:/lab/greenland")

#07/04/21

#To import each file from outside R and assign a name
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#To plot the maps with 2 rows and 2 columns
# par (multipanel)
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#list files with a common expression/pattern and assign a name to the list
rlist <- list.files(pattern="lst")
rlist

#lapply: applies a function over a list-like or vector-like object
import <- lapply(rlist,raster)
import

#stack function: stacking files into one block
TGr <- stack(import) #assign name TGr
TGr
plot(TGr) #plot this file with all the files inside the stack

#To add the colour depending on the year/file order
#All files selected overlap in the plot
#First is red, second is green, third is blue
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

#09/04/21

library(rasterVis) #extract this file from inside R

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

levelplot(TGr) #draw level plots: more powerful and useful than normal plots

library(rgdal) #extract this file from inside R
levelplot(TGr$lst_2000)
levelplot(TGr)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #colour gradient
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #level plot with several years

levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#Melt
#3 key steps:

  #To create a list using a common pattern in the file name (i.e. melt):
meltlist <- list.files(pattern="melt")

  #Import the file:
melt_import <- lapply(meltlist,raster)

  #Stack/group the files to put them together in a block:
melt <- stack(melt_import)

melt
levelplot(melt)

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #use the dollar to attach the file within the folder

clb <- colorRampPalette(c("blue","white","red"))(100) #assign these colours to this palette name
plot(melt_amount, col=clb) #create plot with this colour palette clb

levelplot(melt_amount, col.regions=clb) #create level plot with this colour palette clb

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 3rd file: R_code_Copernicus
# Visualizing Copernicus data

install.packages("ncdf4")
library(raster)
library(ncdf4)
setwd("C:/lab/")

#Import copernicus data file
copernicus <- raster("copernicus_data.nc")
copernicus

#Colour palette to be used for the plot
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(copernicus, col=cl)

#To aggregate pixels
#Resampling
copernicusagg <- aggregate(copernicus, fact=100) #assign name to new aggregate
plot(copernicusagg, col=cl) #plot new aggregate using this palette

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 4th file: R_code_knitr

#16/04/21

("C:/lab/")
install.packages("knitr")
library(knitr)

stitch("rcodegreenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 5th file: R_code_multivariate_analysis

#23/04/21

library(raster)
library(RStoolbox)

setwd("C:/lab/")

#We use brick to upload the whole data package together
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)
#An image is composed of 7 bands: B1_sre... etc.

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)
#B1 = Band 1, B2 = Band 2
#col assigns the colour of the graph
#pch=19 assigns the symbol for the graph

#Pairs: Scatterplot Matrices
#We can compare between different bands in a huge matrix of graphs, along with significance values
pairs(p224r63_2011)

#28/04/21

#Aggregate package: aggregate raster cells or spatial polygons
#Look at the "dimensions" of the file to understand how many pixels there are per band
#Resampling (ricampionamento) of a factor of 10
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

#To display two plots together
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#Summary package: 
summary(p224r63_2011res_pca$model)

#To close the previously created images:
dev.off()

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 6th file: R_code_classification

#21/04/21

setwd("C:/lab/")

library(raster)
library(RStoolbox)

#To create a RasterBrick object, use "brick" and assign the name with the <-
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#To visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

#Unsupervised classification with 3 classes
soc <- unsuperClass(so, nClasses=3)
plot(soc$map)

#Unsupervised classification with 20 classes
#We assign a different name, otherwise the previous file "soc" gets overwritten
som <- unsuperClass(so, nClasses=20)
plot(som$map)

#Download image of the sun from ESA Multimedia
sun <- brick("sun.png")

#Unsupervised classification with 3 classes
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(sunc$map,col=cl)

#23/04/21

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1, g=2, b=3, stretch="lin") #linear stretch
plotRGB(gc, r=1, g=2, b=3, stretch="hist") #histogram stretch

gcc2 <- unsuperClass(gc, nClasses=2)
plot(gcc2$map)

gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 7th file: R_code_ggplot2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 8th file: R_code_vegetation_indices

#28/04/21

library(raster)
library(RStoolbox) #for vegetation indices calculation
setwd("C:/lab/")

#To upload both images that we will use:
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1 = NIR, b2 = red, b3 = green
# NIR = near infrared 

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#05/05/21

library(rasterdiv) #for the global NDVI
library(rasterVis)

#Worldwide NDVI
plot(copNDVI) #Normalised Difference Vegetation Index 21/06

#Pixels with values 253, 254 and 255 (water) will be set as not applicable
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

levelplot(copNDVI)
#high values in yellow indicate high biomass and forest cover
#low values in blue indicate low biomass

#30/04/21

#you can also use require(raster) instead of library(raster)

# b1 = NIR, b2 = red, b3 = green
# NIR = near infrared 
# if you just type the name of the file, you can visualize all the details, including the names of the bands

# DVI: Difference Vegetation Index
# to create a map of the DVI, being the difference in wavelength, we subtract one band from another. The value of the resulting pixels will be the difference

dvi1 <- defor1$defor1.1 - defor1$defor1.2
# subtract the band defor1.2 from the band defor1.1, both found within the image called defor1
#this is how we find the difference between the pixels

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) #colour scheme
plot(dvi1, col=cl, main="DVI at time 1")

# Then we do exactly the same thing for defor2

dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")

# to plot them together:
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# to close previously created graphs:
# dev.off() 

# to find the difference between them:
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100) #colour scheme
plot(difdvi, col=cld)

# if the warning message says that the raster objects have different extents, it's because the two images have a different number of pixels

# NDVI: Normalized Difference Vegetation Index
# (NIR - RED) / (NIR + RED)

ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl) #use previously created colour scheme

# we can use the RStoolbox package for the spectralIndices function
# follow the usage instructions to understand how to insert the function

vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

# to find the difference between the two NDVIs:
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

#Many different indices exist, for example:
  #SAVI: Soil Adjusted Vegetation Index
  #NDWI: Normalized Difference Water Index

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 9th file: R_code_land_cover

#05/05/21

library(raster)
library(RStoolbox) #classification
library(ggplot2)
library(gridExtra) #for grid.arrange plotting

setwd("C:/lab/")

#NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

#07/05/21

#unsupervised classification (unsupervised because the software does everything for us)
#crs = Reference System (lost when the data is downloaded)

d1c <- unsuperClass(defor1, nClasses=2)
#nClasses = number of Classes

plot(d1c$map)
#class 1: agriculture
#class 2: forest
#some plots have the value '1' as forest and '2' as agricultural land or vice versa
#set.seed() would allow you to attain the same results

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#some plots have the value '1' as forest and '2' as agricultural land or vice versa

d2c3 <- unsuperClass(defor2, nClasses=3) #with 3 classes
plot(d2c3$map)

#frequencies
freq(d1c$map)
#counts the number of pixels for each class:
 value  count
[1,]     1  34647
[2,]     2 306645

#to figure out the proportion, we first find the total number of pixels (sum1):
s1 <- 34647+306645

#for the first proportion (prop1):
prop1 <- freq(d1c$map)/s1
prop1
#prop agirculture: 0.1015172
#prop forest: 0.8984828

#for the second proportion (prop2):
s2 <- 342726
prop2 <- freq(d2c$map)/s2
prop2
#prop agirculture: 0.4786039
#prop forest: 0.5213961

#to build a dataframe, with factors (aka: cover) being the percentage cover:
cover <- c("Forest","Agriculture") #we use the "" for words
percent_1992 <- c(89.85, 10.15)
percent_2006 <- c(52.14, 47.86)
 
#assign the name to the dataframe with the appropriate factors
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#let's plot them!
#to make bar charts with the percentage cover land use, use ggplot:
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#then assign the names respectively:
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#use grid.arrange() to put two or more graphs together in the same space
#grid.arrange() is found in the gridExtra package
grid.arrange(p1, p2, nrow=1)

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 10th file: R_code_variability

# 19/05/21

library(raster)
library(RStoolbox)
library(ggplot2) # for ggplot plotting
library(gridExtra) # for plotting ggplots together 
library(viridis) # for ggplot colouring

setwd("C:/lab/")

sent <- brick("sentinel.png")

# Bands: NIR 1, RED 2, GREEN 3
# r=1, g=2, b=3

plotRGB(sent, stretch="lin")
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#to associate a band to an object:
nir <- sent$sentinel.1
red <- sent$sentinel.2

#to calculate the NDVI:
ndvi <- (nir-red)/(nir+red)
plot(ndvi)

cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) #colour scheme
plot(ndvi,col=cl) #to plot with the colour scheme

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
#nrow = number of rows
#ncol = number of columns
#fun = function
#sd = standard deviation

#to plot the NDVI with the standard deviation:
plot(ndvisd3)

#colour scheme:
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 

#to plot with the colour scheme
plot(ndvisd3, col=clsd)

#to calculate the mean NDVI with focal:
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

#to plot the mean NDVI with the colour scheme:
plot(ndvimean3, col=clsd)

#to calculate the NDVI with standard deviation with a different number of rows and columns:
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

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)

# Used to upload and insert code created previously: source("")
# Useful instead of 'copy and paste'
# Must be in the working directory, otherwise it won't work
source("source_test_lezione.r")
source("source_ggplot.r")

# The following functions are useful:
#   geom_point: used to create scatterplots
#   geom_line: used to connect single points
#   geom_raster: rectangles

# ggplot function: to create a new blank canvas for graphics
# geom_raster is added, with the axes equal to our current axes
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

# Standard deviation in the graphics is very useful for:
#   observing any kind of topographic discontinuity
#   observing ecological, ecotonal and geological variability

# Viridis package
#   a collection of colour palettes easily visible to everyone, regardless of colour blindness
#   colour scales can be inserted using the legend, instead of having to write the order of each individual colour

ggplot() + # to open a blank canvas
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + # to specify what to map
scale_fill_viridis() # to use the default viridis colour scale
ggtitle("Standard deviation of PC1 by viridis colour scale") # to add a title

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

# in general, rainbow palettes are often avoided as the central value is yellow, but the human eye incorrectly assumes that yellow is the extreme value

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# END FILE
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

