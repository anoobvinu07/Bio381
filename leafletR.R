# Leaflet for R
# November 29, 2018
# AnB

# easily make interactive maps within R
# used by many to publish maps
# easily render spatial objects from the sp and sf packages or dataframes with lat/long column

# basic example
library(leaflet)
library(maps)

# basic usage
#1. create a map widget by calling leaflet()
#2. add layers to maps using layer functions to modify the map widget
#3. repeat step 2 as desired
#print the map widget

#basic example
m <- leaflet() %>%
  addTiles() %>%
  addMarkers(lng = -73.2013, lat = 44.4783, popup = "landmark", label= "landmark")
m

m <- leaflet(options = leafletOptions(minZoom = 12, maxZoom = 18)) %>%
  addTiles() %>%
  addMarkers(lng = -73.2013, lat = 44.4783, popup = "landmark", label= "landmark")
m

# views
m <- leaflet %>% addTiles()
m %>% setView(-73.2, 44.48, zoom = 16)

m %>% fitBounds(-73.2, 44.48,-73.1, 44.49)

m %>% setMaxBounds(-73.2, 44.48,-73.1, 44.49)

m %>% clearBounds()

# dataobjects
# base R
df <- data.frame(Lat=1:10,Long=rnorm(10))
leaflet(df) %>% addTiles() %>% addCircles()

# maps package
library(maps)
mapStates <- map("state",fill=TRUE,plot=FALSE)
leaflet(mapStates) %>% addTiles() %>% 
  addPolygons(fillColor = topo.colors(10, alpha=NULL), stroke=FALSE)

# Basemaps
m
m %>% addTiles()
names(providers)

m %>% addProviderTiles(providers$Stamen.Toner)
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)

# Stacking maps

m %>% addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addProviderTiles(providers$Stamen.TonerLines,
                   options = providerTileOptions(opacity = 0.95)) %>%
  addProviderTiles(providers$Stamen.TonerLabels)

# Shapes and polygons

# Circles
cities <- read.csv(textConnection("
                                  City,Lat,Long,Pop
                                  Boston,42.36,-71.05,645966
                                  New York City,40.71,-74,8406000
                                  Philadelphia,39.95,-75.16,1553000"))

leaflet(cities) %>% addTiles() %>%
  addCircles(lng=~Long,lat=~Lat, weight=1,
             radius = ~sqrt(Pop)*30, popup = ~City)

# rectangles
leaflet() %>% addTiles() %>% 
  addRectangles(
    lng1 = -118.45, lat1 = 34.07,
    lng2 = -118.43,lat2 = 34.06,
    fillColor = "red"
  )

# Markers
data(quakes) # locations of earthquakes off fiji
head(quakes)
leaflet(data=quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long,~lat,popup = ~as.character(mag), label = ~as.character(mag))

leaflet(quakes) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
) %>% addMeasure() %>% addMiniMap()

