#install.packages("raster")
#install.packages("rgdal")
#install.packages("devtools")
#install.packages("RStoolbox")
#library(devtools)
#install_github("bleutner/RStoolbox")
library("raster")
library("cluster")


#part 1
A=stack(c("p134r027_7dt20020722.SR.b01.tif","p134r027_7dt20020722.SR.b02.tif","p134r027_7dt20020722.SR.b03.tif","p134r027_7dt20020722.SR.b04.tif","p134r027_7dt20020722.SR.b05.tif", "p134r027_7dt20020722.SR.b07.tif"))
writeRaster(A, filename="merge.tif")
plotRGB(A, 3, 2, 1, stretch="hist")



#part 2
B <- stack(c("p134r027_7t20010820_z48_nn10.tif","p134r027_7t20010820_z48_nn20.tif","p134r027_7t20010820_z48_nn30.tif","p134r027_7t20010820_z48_nn40.tif","p134r027_7t20010820_z48_nn50.tif", "p134r027_7t20010820_z48_nn70.tif"))
plotRGB(B, 3,2,1)
ext <- drawExtent() #draw a box by clicking upper left and lower right corner in the plot, click two times on the map
C <- crop(B, ext)
DF <- as.data.frame(C)
summary(C) # to make sure you don't have any NA's
E <- kmeans(DF, 12, iter.max = 100, nstart = 10)
#DF[,7] <- E$cluster
#EM <- matrix(DF[,7], nrow=E@nrows,ncol=E@ncols, byrow=TRUE)
#EM <- matrix(DF[,7], nrow=nrow(DF),ncol=nclo(DF)-1, byrow=TRUE)
#E.raster <- raster(EM,crs=C@crs, xmn=C@extent@xmin, ymn=C@extent@ymin, xmx=C@extent@xmax, ymx=C@extent@ymax)
clusters<- raster(C)
clusters<- setValues(clusters, E$cluste)
#writeRaster(E.raster,"12_classes.tif", overwrite=TRUE)
spplot(clusters)
writeRaster(clusters,"12_classes.tif", overwrite=TRUE)
