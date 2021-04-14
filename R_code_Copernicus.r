#R_code_copernicus.r
#Visualizing Copernicus data

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



