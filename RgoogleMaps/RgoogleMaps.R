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



#####################
install.packages('plotGoogleMaps')
library(plotGoogleMaps)
data(meuse)
coordinates(meuse)<-~x+y # convert to SPDF
proj4string(meuse) <- CRS('+init=epsg:28992')
# adding Coordinate Referent Sys.
# Create web map of Point data
m<-plotGoogleMaps(meuse,filename='myMap1.htm')

# zinc labels
ic<-iconlabels(meuse$zinc, height=12)
m<-plotGoogleMaps(meuse,zcol='zinc',filename='myMap_z2.htm',
                  iconMarker=ic, mapTypeId='ROADMAP',layerName = 'MEUSE POINTS')

m<-bubbleGoogleMaps(meuse,zcol='zinc',max.radius = 80,filename='myMap3.htm')
# remove outlines
m<-bubbleGoogleMaps(meuse,zcol='zinc',max.radius = 80,
                    filename='myMap3.htm',strokeOpacity=0)


# colPalette defines colors for plot
m<-segmentGoogleMaps(meuse, zcol=c('zinc','dist.m'),
                     mapTypeId='ROADMAP', filename='myMap4.htm',
                     colPalette=c('#E41A1C','#377EB8'), strokeColor='black')

# Results of least square
ell<- data.frame(E=c(7456263,7456489,7456305,7457415,7457688),
                 N=c(4954146 ,4952978, 4952695, 4953038, 4952943),
                 Name=c('30T', '31T', '3N', '40T', '41T'),
                 A=c(2.960863 ,4.559694, 7.100088, 2.041084 ,3.375919),
                 B=c(2.351917, 2.109060, 2.293085, 1.072506, 2.382449),
                 teta=c(28.35242, 41.04491, 38.47216, 344.73686, 27.53695))
coordinates(ell) <- ~E+N
proj4string(ell) <- CRS("+proj=tmerc +lat_0=0 +lon_0=21 +k=0.9999
+x_0=7500000 +y_0=0 +ellps=bessel
+towgs84=574.027,170.175,401.545,4.88786,-0.66524,-
13.24673,0.99999311067 +units=m")
# fillOpacity 100 %
m<-ellipseGoogleMaps( ell,filename="Ellipse.htm",zcol=2:4,
                      mapTypeId='ROADMAP',fillOpacity=1,strokeOpacity=0)


# Line data
data(meuse.grid)
coordinates(meuse.grid)<-c('x','y')
meuse.grid<-as(meuse.grid,'SpatialPixelsDataFrame')
im<-as.image.SpatialGridDataFrame(meuse.grid['dist'])
cl<-ContourLines2SLDF(contourLines(im))
proj4string(cl) <- CRS('+init=epsg:28992')
mapMeuseCl<- plotGoogleMaps(cl,zcol='level',strokeWeight=1:9 ,
                            filename='myMap5.htm',mapTypeId='ROADMAP')

#Polygon data
nc <- readShapeSpatial( system.file("shapes/sids.shp",package="maptools")[1],
                     proj4string=CRS("+proj=longlat +datum=NAD27"))
install.packages("RColorBrewer")
library(RColorBrewer)
m<-plotGoogleMaps(nc,zcol="NWBIR74",filename='MyMap6.htm',
                  mapTypeId='TERRAIN',colPalette= brewer.pal(7,"Reds"),
                  strokeColor="white")


#Pixels
data(meuse.grid)
coordinates(meuse.grid)<-c('x','y')
meuse.grid<-as(meuse.grid,'SpatialPixelsDataFrame')
proj4string(meuse.grid) <- CRS('+init=epsg:28992')
m=plotGoogleMaps(meuse.grid,zcol='dist',
                 at=seq(0,0.9,0.1), colPalette=brewer.pal(9,"Reds"))


#Several layers
m1<- plotGoogleMaps(cl,zcol='level',
                    strokeWeight=1:9 ,
                    colPalette='grey',
                    add=TRUE)
m2<-bubbleGoogleMaps(meuse,zcol='zinc',
                     colPalette= brewer.pal(5,"Accent"),
                     max.radius = 80,
                     previousMap= m1,
                     filename='comb.html')


#STFDF data from spacetime vignette
# spacetime: Spatio-Temporal Data in R
install.packages('spacetime')
library(spacetime)
library("maps")
states.m = map('state',plot=FALSE,fill=TRUE)
IDs <- sapply(strsplit(states.m$names, ":"),function(x) x[1])
library("maptools")
states = map2SpatialPolygons(states.m,IDs=IDs)
yrs = 1970:1986
time = as.POSIXct(paste(yrs, "-01-01", sep=""),tz = "GMT")
install.packages('plm')
library("plm")
data("Produc")
Produc.st = STFDF(states[-8], time,
                  Produc[order(Produc[2], Produc[1]),])
Produc.st@sp@proj4string=CRS('+proj=longlat +datum=WGS84')
library(RColorBrewer)
ee= stplotGoogleMaps(Produc.st,zcol='unemp',
                     stfilename='USA.htm',colPalette=brewer.pal(9, "YlOrRd"),
                     mapTypeId='ROADMAP',w='49%',h='49%', fillOpacity=0.85)
# without control
ee= stplotGoogleMaps(Produc.st,zcol='unemp',
                     stfilename='USA2.htm',colPalette=brewer.pal(9, "YlOrRd"),
                     mapTypeId='ROADMAP',w='33%',h='25%',
                     fillOpacity=0.85, control.width=0)

















