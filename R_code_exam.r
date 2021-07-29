# Esame di Telerilevamento

library(raster)
library(rasterdiv)
library(ggplot2)
library(viridis)
library(RStoolbox)
setwd("C:/esame/")

codlist <- list.files(pattern="cod")
codlist

codimport <- lapply(codlist,raster)
codimport

codstack <- stack(codimport)
codstack


