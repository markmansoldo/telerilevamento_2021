# 19/05/21
# R_code_variability.r

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

