# R_code_spectral_signatures.r

library(raster)
library(rgdal)      # look at gdal.org

setwd("C:/lab/")

defor2 <- brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
# NIR, red, green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# id(identity), xy(spatial data), cell(pixel), type(point)
# then click on the image and you will see the information for that particular pixel

# define the columns of the dataset:
band <- c(1,2,3)
forest <- c(206,6,19)
water <- c(40,99,139)

# create the data frame:
spectrals <- data.frame(band, forest, water)

# plot the spectral signatures:
 ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=forest), color="green") +
 geom_line(aes(y=water), color="blue") 

#________Multitemporal_______________________________________________

# spectral signatures defor1:

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# spectral signatures defor2:

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="yellow")

# define the columns of the dataset:

band <- c(1,2,3)
time1 <- c(223,11,33)
time2 <- c(197,163,151)

spectralst <- data.frame(band, time1, time2)

# plot the sepctral signatures:

ggplot(spectrals, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time2), color="gray") +
 labs(x="band",y="reflectance")

# define the columns of the dataset:

band <- c(1,2,3)
time1 <- c(223,11,33)
time1p2 <- c(218,16,38)
time2 <- c(197,163,151)
time2p2 <- c(149.157,133)
 
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

# plot the sepctral signatures:

ggplot(spectralst, aes(x=band)) +
 geom_line(aes(y=time1), color="red") +
 geom_line(aes(y=time1p2), color="red") +
 geom_line(aes(y=time2), color="gray") +
 geom_line(aes(y=time2p2), color="gray") +
 labs(x="band",y="reflectance")

# define the columns of the dataset:

band <- c(1,2,3)
stratum1 <- c(187,163,11)
stratum2 <- c(11,140,0)
stratum3 <- c(41,40,20)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

# plot the sepctral signatures:

ggplot(spectralsg, aes(x=band)) +
 geom_line(aes(y=stratum1), color="yellow") +
 geom_line(aes(y=stratum2), color="green") +
 geom_line(aes(y=stratum3), color="blue") +
 labs(x="band",y="reflectance")


