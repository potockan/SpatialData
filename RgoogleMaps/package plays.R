install.packages("osmar")
library(osmar)
library(OpenStreetMap)
library(maptools)

require(maps)
require(ggplot2)
gpclibPermit()

mp <- openmap(c(53.38332836757155,-130.517578125),
              c(15.792253570362446,-67.939453125),4,'stamen-watercolor')
mp_bing <- openmap(c(53.38332836757155,-130.517578125),
                   c(15.792253570362446,-67.939453125),4,'bing')
states_map <- map_data("state")
states_map_merc <- as.data.frame(
   projectMercator(states_map$lat,states_map$long))
states_map_merc$region <- states_map$region
states_map_merc$group <- states_map$group
crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
p <- autoplot(mp,expand=FALSE) + geom_polygon(aes(x=x,y=y,group=group),
                                              data=states_map_merc,fill="black",colour="black",alpha=.1) + theme_bw()
print(p)
p <- autoplot(mp_bing) + geom_map(aes(x=-10000000,y=4000000,map_id=state,fill=Murder),
                                  data=crimes,map=states_map_merc)
print(p)

######################################################################

m <- c(25.7738889,-80.1938889)
j <- c(58.3019444,-134.4197222)
miami <- projectMercator(25.7738889,-80.1938889)
jun <- projectMercator(58.3019444,-134.4197222)
data(states)
map <- openmap(j,m,4,type="stamen-terrain")
plot(map,removeMargin=FALSE)
plot(states,add=TRUE)
data(LA_places)
longBeachHarbor <- openmap(c(33.760525217369974,-118.22052955627441),
                           c(33.73290566922855,-118.17521095275879),14,'bing')
coords <- coordinates(LA_places)
x <- coords[,1]
y <- coords[,2]
txt <- slot(LA_places,"data")[,'NAME']
plot(longBeachHarbor)
points(x,y,col="red")
text(x,y,txt,col="white",adj=0)

