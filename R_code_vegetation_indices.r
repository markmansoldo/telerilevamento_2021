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
