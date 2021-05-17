#05/05/21

library(raster)
library(RStoolbox) #classification
library(ggplot2)
library(gridExtra) #for grid.arrange plotting

setwd("C:/lab/")

#NIR 1, RED 2, GREEN 3

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

#07/05/21

#unsupervised classification (unsupervised because the software does everything for us)
#crs = Reference System (lost when the data is downloaded)

d1c <- unsuperClass(defor1, nClasses=2)
#nClasses = number of Classes

plot(d1c$map)
#class 1: agriculture
#class 2: forest
#some plots have the value '1' as forest and '2' as agricultural land or vice versa
#set.seed() would allow you to attain the same results

d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
#some plots have the value '1' as forest and '2' as agricultural land or vice versa

d2c3 <- unsuperClass(defor2, nClasses=3) #with 3 classes
plot(d2c3$map)

#frequencies
freq(d1c$map)
#counts the number of pixels for each class:
 value  count
[1,]     1  34647
[2,]     2 306645

#to figure out the proportion, we first find the total number of pixels (sum1):
s1 <- 34647+306645

#for the first proportion (prop1):
prop1 <- freq(d1c$map)/s1
prop1
#prop agirculture: 0.1015172
#prop forest: 0.8984828

#for the second proportion (prop2):
s2 <- 342726
prop2 <- freq(d2c$map)/s2
prop2
#prop agirculture: 0.4786039
#prop forest: 0.5213961

#to build a dataframe, with factors (aka: cover) being the percentage cover:
cover <- c("Forest","Agriculture") #we use the "" for words
percent_1992 <- c(89.85, 10.15)
percent_2006 <- c(52.14, 47.86)
 
#assign the name to the dataframe with the appropriate factors
percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#let's plot them!
#to make bar charts with the percentage cover land use, use ggplot:
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#then assign the names respectively:
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#use grid.arrange() to put two or more graphs together in the same space
#grid.arrange() is found in the gridExtra package
grid.arrange(p1, p2, nrow=1)

