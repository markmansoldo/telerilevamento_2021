#21/04/21
#R_code_classification.r

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

