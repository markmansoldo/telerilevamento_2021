#21/04/21
#R_code_classification.r

library(raster)
library(RStoolbox)
setwd("C:/lab/")

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


