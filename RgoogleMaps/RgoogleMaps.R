######### plotGoogleMaps #########

### spatial data packages: ###
### http://cran.r-project.org/web/views/Spatial.html ###


#install.packages('plotGoogleMaps')
library(plotGoogleMaps)
data(meuse)

##This data set gives locations and topsoil heavy metal 
#concentrations, along with a number of soil and landscape 
#variablesat the observation locations, collected in 
#a flood plain of the river Meuse, near the village 
#of Stein (NL). Heavy metal concentrations are from
#composite samples of an area of approximately 15 m x 15 m.

coordinates(meuse)<-~x+y # convert to SPDF
#Class for spatial attributes that have spatial point locations

proj4string(meuse) <- CRS('+init=epsg:28992')
# adding Coordinate Referent Sys.

# meuse is a data.frame.
# 
# When you run this line
# 
# coordinates(meuse)<-~x+y
# it uses the x and y variables (columns) to construct 
# a SpatialPolygonsDataFrame object, which has 
# coordinates (from your x and y) and attributes on 
# various metals and land features.
# 
# It's not trivial to project curved surfaces 
# (we live on a big ball) to a plane, so some 
# calculations are needed to achieve this. This 
# is where you tell R in what projection your 
# data are, hence the line
# 
# proj4string(meuse) <- CRS('+init=epsg:28992')
#
#
# The person who created the data should provide 
# the information about which projection was used.




# Create web map of Point data
m<-plotGoogleMaps(meuse,filename='myMap1.htm')

# zinc labels
ic<-iconlabels(meuse$zinc, height=12)
m<-plotGoogleMaps(meuse,zcol='zinc',filename='myMap_z2.htm',
                  iconMarker=ic, mapTypeId='ROADMAP',layerName = 'MEUSE POINTS')
# zcol - the column we want to label

m<-bubbleGoogleMaps(meuse,zcol='zinc',max.radius = 80,
                    filename='myMap3.htm')
# Plot htm output with Google Maps API in form of bubble plot of spatial data, 
# with options for bicolour residual plots. Ready to use as local htm file 
# or into your own website.

# value for largest circle (the plotting symbols) in metre, 
# circumcircle of triange or quadrangle (square)

# remove outlines
m<-bubbleGoogleMaps(meuse,zcol='zinc',max.radius = 80,
                    filename='myMap3.htm',strokeOpacity=0)
#stroke opacity - przezroczystosc linii otaczajacej


# colPalette defines colors for plot
m<-segmentGoogleMaps(meuse, zcol=c('zinc','dist.m'),
                     mapTypeId='ROADMAP', filename='myMap4.htm',
                     colPalette=c('#E41A1C','#377EB8'), strokeColor='black')
# shows correlation between zinc concentration and distance to river.

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

# Plotting uncertainty of position is provided by ellipseGoogleMaps function.
# The ellipseGoogleMaps plots standard errors of the computed coordinates, error
# ellipses describing the uncertainty of a two-dimensional position. Parameters of
# input spatial points data frame should contain at least three columns: semi-major
# axis, semi-minor axis, and orientation in degrees. These parameters are product
# of geodetic least square adjustment or design of a geodetic control network.


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
#install.packages("RColorBrewer")
library(RColorBrewer)
m<-plotGoogleMaps(nc,zcol="NWBIR74",filename='MyMap6.htm',
                  mapTypeId='TERRAIN',colPalette= brewer.pal(7,"Reds"),
                  strokeColor="white")


# This is for the 100 counties of North Carolina, and includes counts of
# numbers of live births (also non white live births) and numbers of sudden infant
# deaths, for the July 1, 1974 to June 30, 1978 and July 1, 1979 to June 30, 1984
# periods (Bivand, 2011).


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
#install.packages('spacetime')
#install.packages('plm')
library("spacetime")
library("maps")
library("maptools")
library("plm")
states.m <- map('state',plot=FALSE,fill=TRUE)
IDs <- sapply(strsplit(states.m$names, ":"),function(x) x[1])
states <- map2SpatialPolygons(states.m,IDs=IDs)
yrs <- 1970:1986
time <- as.POSIXct(paste(yrs, "-01-01", sep=""),tz = "GMT")
data("Produc")
Produc.st = STFDF(states[-8], time,
                  Produc[order(Produc[2], Produc[1]),])
# Spatio-temporal data for which each location has 
# data for each time can be provided in two
# so-called wide formats.
# time-wide:  columns refer to a particular time: 
# SID74 contains to the infant death syndrome cases
# for each county at a particular time period (1974–1984). 
# columns refer to a particular time: SID74 contains to 
# the infant death syndrome cases
# for each county at a particular time period (1974–1984).
# space-wide format: each column refers to another 
# wind measurement location, and the
# rows reﬂect a single time period;
# Finally, panel data are shown in long form, 
# where the full spatio-temporal information is
# held in a single column, and other columns 
# denote location and time.
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


###STIDF
# Data preparation
# Point data
# data from plotKML package and plotKML tutorial
# install.packages('plotKML')
library(plotKML)
data(HRtemp08)
# The daily measurements of temperature (thermometers) 
# for year 2008 kindly contributed by the Croatian National 
# Meteorological Service. HRtemp08 contains 56,608 measurements 
# of temperature (159 stations by 365 days).
HRtemp08$ctime <- as.POSIXct(HRtemp08$DATE,format="%Y-%m-%dT%H:%M:%SZ")
library(spacetime)
sp <- SpatialPoints(HRtemp08[,c("Lon","Lat")])
proj4string(sp) <- CRS("+proj=longlat +datum=WGS84")
HRtemp08.st <- STIDF(sp, time = HRtemp08$ctime,
                     data = HRtemp08[,c("NAME","TEMP")])
HRtemp08_jan <- HRtemp08.st[1:500]
#str(HRtemp08_jan)
# plot STDIF
stplotGoogleMaps(HRtemp08_jan,zcol='TEMP',
                 mapTypeId='ROADMAP',w='49%',h='49%')
# plot STDIF bubble
stplotGoogleMaps(HRtemp08_jan,zcol='TEMP',
                 stfilename='HR_temp.html',
                 mapTypeId='ROADMAP',w='49%',h='49%',
                 strokeOpacity = 0,
                 do.bubble=T, bubble= list(max.radius=15000,
                                           key.entries =quantile(HRtemp08_jan@data[,'TEMP'],(1:5)/5, na.rm=T),
                                           do.sqrt = F) )














