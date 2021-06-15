# R_code_no2.r

# Best to put all packages at the beginning of the file
library(raster)

# 1: Set the working directory EN:

setwd("C:/lab/EN")

# 2: Import the first image (single band):

EN01 <- raster("EN_0001.png") # assign name EN01

# 3: Plot the first imported image with your preferred colour ramp palette:

cls <- colorRampPalette(c("purple","red","orange","yellow"))(200)
plot(EN01, col=cls)

# 4: Import the last image (13th) and plot it with the previous colour ramp palette:

EN13 <- raster("EN_0013.png")
plot(EN13, col=cls)

# 5: Make the difference between the two images and plot it:

ENdif <- EN13 - EN01    #either March-January or January-March
plot(ENdif, col=cls)

# 6: Plot everything together:

par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (March-January)")

# 7: Import the whole set:

# list of files:
rlist <- list.files(pattern="EN")
rlist

import <- lapply(rlist,raster)
import

EN <- stack(import)
plot(EN, col=cls)

# 8: Replicate the plot of images 1 and 13 using the stack:

par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)
 
# 9: Compute a PCA over the 13 images:

ENpca <- rasterPCA(EN)

summary(ENpca$model)

dev.off()

plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 10: Compute the local variability (local standard deviation) of the first:

PC1sd <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd) #remember the nested elements ($)

plot(PC1sd, col=cls)

