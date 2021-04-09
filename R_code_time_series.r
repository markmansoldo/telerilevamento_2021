# install.packages("raster")
library(raster)

setwd("C:/lab/greenland")



#09/04/21

library(rasterVis) #extract this file from inside R

#3 key steps:

  #To create a list using a common pattern in the file name (i.e. 1st):
rlist <- list.files(pattern="lst") #assign this name to this list using a common pattern
rlist

  #Import the file:
import <- lapply(rlist,raster) #assign this name to this list
import

  #Stack/group the files to put them together in a block:
TGr <- stack(import)
TGr

levelplot(TGr) #draw level plots: more powerful and useful than normal plots

library(rgdal) #extract this file from inside R
levelplot(TGr$lst_2000)
levelplot(TGr)

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #colour gradient
levelplot(TGr, col.regions=cl)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #level plot with several years

levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#Melt
#3 key steps:

  #To create a list using a common pattern in the file name (i.e. melt):
meltlist <- list.files(pattern="melt")

  #Import the file:
melt_import <- lapply(meltlist,raster)

  #Stack/group the files to put them together in a block:
melt <- stack(melt_import)

melt
levelplot(melt)

melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #use the dollar to attach the file within the folder

clb <- colorRampPalette(c("blue","white","red"))(100) #assign these colours to this palette name
plot(melt_amount, col=clb) #create plot with this colour palette clb

levelplot(melt_amount, col.regions=clb) #create level plot with this colour palette clb




