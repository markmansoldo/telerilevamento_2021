#Il mio primo codice in R per il telerilevamento!

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
