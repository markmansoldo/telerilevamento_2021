#Time series analysis
#Greenland increase of temperature

library(raster)  #extract this file from inside R
setwd("C:/lab/greenland")

#07/04/21

#To import each file from outside R and assign a name
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#To plot the maps with 2 rows and 2 columns
# par (multipanel)
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#list files with a common expression/pattern and assign a name to the list
rlist <- list.files(pattern="lst")
rlist

#lapply: applies a function over a list-like or vector-like object
import <- lapply(rlist,raster)
import

#stack function: stacking files into one block
TGr <- stack(import) #assign name TGr
TGr
plot(TGr) #plot this file with all the files inside the stack

#To add the colour depending on the year/file order
#All files selected overlap in the plot
#First is red, second is green, third is blue
plotRGB(TGr, 1, 2, 3, stretch="Lin") 
plotRGB(TGr, 2, 3, 4, stretch="Lin") 
plotRGB(TGr, 4, 3, 2, stretch="Lin") 

#09/04/21

library(rasterVis) #extract this file from inside R

#3 key steps:

  #1 To create a list using a common pattern in the file name (i.e. 1st):
rlist <- list.files(pattern="lst") #assign this name to this list using a common pattern
rlist

  #2 Import the file:
import <- lapply(rlist,raster) #assign this name to this list
import

  #3 Stack/group the files to put them together in a block:
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




