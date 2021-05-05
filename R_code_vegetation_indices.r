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

