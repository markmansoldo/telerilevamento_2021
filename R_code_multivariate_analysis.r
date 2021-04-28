#23/04/21

library(raster)
library(RStoolbox)

setwd("C:/lab/")

#We use brick to upload the whole data package together
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)
#An image is composed of 7 bands: B1_sre... etc.

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)
#B1 = Band 1, B2 = Band 2
#col assigns the colour of the graph
#pch=19 assigns the symbol for the graph

#Pairs: Scatterplot Matrices
#We can compare between different bands in a huge matrix of graphs, along with significance values
pairs(p224r63_2011)

#28/04/21

#Aggregate package: aggregate raster cells or spatial polygons
#Look at the "dimensions" of the file to understand how many pixels there are per band
#Resampling (ricampionamento) of a factor of 10
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

#To display two plots together
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#Summary package: 
summary(p224r63_2011res_pca$model)

#To close the previously created images:
dev.off()

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

