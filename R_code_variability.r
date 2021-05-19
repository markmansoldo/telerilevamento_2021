# 19/05/21
# R_code_variability.r

library(raster)
library(RStoolbox)

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
