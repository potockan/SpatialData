install.packages('RgoogleMaps')
library(RgoogleMaps)
lat = c(40.702147,40.718217,40.711614);
lon = c(-74.012318,-74.015794,-73.998284);
center = c(mean(lat), mean(lon));
zoom <- min(MaxZoom(range(lat), range(lon)));
#this overhead is taken care of implicitly by GetMap.bbox();
markers = paste0("&markers=color:blue|label:S|40.702147,-74.015794&markers=color:",
                 "green|label:G|40.711614,-74.012318&markers=color:red|color:red|",
                 "label:C|40.718217,-73.998284")
MyMap <- GetMap(center=center, zoom=zoom,markers=markers,destfile = "MyTile2.png");
#Note that in the presence of markers one often needs to add some extra padding to the
#latitude range to accomodate the extent of the top most marker



####################
install.packages('maps')
library(maps)
install.packages('mapdata')
library(mapdata)
map('worldHires','Canada', xlim=c(-141,-53), ylim=c(40,85), col='gray90', fill=TRUE)



library(RgoogleMaps)
library(stringi)

lat <- c(48,64) #define our map's ylim
lon <- c(-140,-110) #define our map's xlim
center = c(mean(lat), mean(lon))  #tell what point to center on
zoom <- 5  
#zoom: 1 = furthest out (entire globe), larger numbers = closer in
samps <- GetMap(center=center, zoom=zoom, maptype= "terrain", destfile = "terrain.png") #lots of visual options, just like google maps: maptype = c("roadmap", "mobile", "satellite", "terrain", "hybrid", "mapmaker-roadmap", "mapmaker-hybrid")

names(mymarkers) <- c("lat", "lon", "size", "col", "char")  #assign column headings
markers<-stri_paste("&markers=color:red|label:HERE|49.7, -121.05")

lat <- c(48,60)  #now we are plotting the map
lon <- c(-140,-110)
terrain_close <- GetMap.bbox(lonR= range(lon), latR= range(lat), center= c(49.7, -121.05), destfile= "terrclose.png", markers= markers, zoom=13, maptype="terrain")




######################
lat<-c(52.220103,52.223008)
lon<-c(21.004989,21.011801)
center = c(mean(lat), mean(lon))  #tell what point to center on
zoom <- 16
terrmap <- GetMap(center=center, zoom=zoom, maptype= "mapmaker-roadmap", destfile = "polibuda.png", NEWMAP=FALSE) #lots of visual options, just like google maps: maptype = c("roadmap", "mobile", "satellite", "terrain", "hybrid", "mapmaker-roadmap", "mapmaker-hybrid")











