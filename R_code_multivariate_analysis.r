#23/04/21

library(raster)
library(RStoolbox)

setwd("C:/lab/")

#We use brick to upload everything together
p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
#col assigns the colour of the graph
#pch=19 assigns the symbol for the graph

#Pairs: Scatterplot Matrices
#We can compare between different bands in a huge matrix of graphs, along with significance values
pairs(p224r63_2011)

