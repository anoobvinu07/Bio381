# Leaflet for R
# November 29, 2018
# AnB

# easily make interactive maps within R
# used by many to publish maps
# easily render spatial objects from the sp and sf packages or dataframes with lat/long column

library(leaflet)
library(maps)

#basic example
leaflet(options = leafletOptions(minZoom = 12, maxZoom = 18)) %>% 
  addTiles() %>%
  addMarkers(lng=-73.2013, lat=44.4783, popup = "landmark")

# map views
m %>% setView(-73.2,44.48, zoom = 16)
m %>% fitBounds(-73.2,44.48, -73.1,44.49)
m %>% setMaxBounds(-73.2,44.48, -73.1,44.49)

# data objects
# from base R
df <- data.frame(Lat=1:10, Long=rnorm(10))
leaflet(df) %>% addTiles() %>% addCircles()
head(df)

# basemaps
m
names(providers)

m %>% addProviderTiles(providers$Stamen)
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)

# stacking base maps
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap) %>% addProviderTiles(providers$Stamen.TonerLines, options = providerTileOptions(opacity = 0.95)) %>% addProviderTiles(providers$Stamen.TonerLabels)

# shapes and polygons
# Circles
cities <- read.csv(textConnection("
                                  City,Lat,Long,Pop
Boston, 42.36,-71.05,645966
                                  New York City, 40.71,-74.00,8406000
                                  Phiadelphia,39.95,-75.16,1553000"))

leaflet(cities) %>% addTiles() %>% 
  addCircles(lng =~Long, lat=~Lat, weight=1,
             radius = ~sqrt(Pop)*30, popup = ~City)

leaflet() %>% addTiles() %>% 
  addRectangles(
    lng1 = -118.45, lat1 = 34.07,
    lng2 = -118.43, lat2 = 34.06,
    fillColor = "tranparent"
  )

#Markers
data(quakes)  # locations of the earthquakes off Fiji
head(quakes)

leaflet(data=quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long,~lat,popup = ~as.character(mag), label = ~as.character(mag))

leaflet(quakes) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
) %>% addMeasure() %>% addMiniMap()
