install.packages("leaflet") # main package 

install.packages("maps")


library(leaflet)

# basics
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-73.2013454, lat=44.4783732, popup="Waterman building, UVM") # Decimal degrees - latitude and longitude, the values are bounded by ±90° and ±180° respectively.

print(m)  

# map view

#setView()
m %>% setView(-73.2, 44.48, zoom = 16) #Restricts the map view to the given bounds

#fitBounds()
m %>% fitBounds(-73.2, 44.48,-73.1, 44.49) #Set the bounds of a map

#setMaxBounds() and clearBounds() similar functions

#Map widget
library(maps)
mapStates = map("state", fill = TRUE, plot = FALSE)

leaflet(data = mapStates) %>% addTiles() %>%
  addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)

##Basemaps
#The easiest way to add tiles is by calling addTiles() with no arguments; by default, OpenStreetMap tiles are used.
m <- leaflet() %>% setView(lng=-73.2013454, lat=44.4783732, zoom = 12)
m %>% addTiles() #default:OpenStreetMap

#Third party tiles or maps
names(providers) # list of third party map providers
#examples
m %>% addProviderTiles(providers$Stamen.Toner)
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap) #ESRI- reference map includes physical and natural features, administrative boundaries, cities, transportation infrastructure, landmarks, protected areas, ocean floors, and other layers

# stacking base maps
m %>% addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  addProviderTiles(providers$Stamen.TonerLines,
                   options = providerTileOptions(opacity = 0.95)) %>%
  addProviderTiles(providers$Stamen.TonerLabels)

#Shape and Polygons
#Circles
cities <- read.csv(textConnection("
City,Lat,Long,Pop
Boston,42.36,-71.05,645966
New York City,40.71,-74.00,8406000
Philadelphia,39.95,-75.16,1553000
"))

leaflet(cities) %>% addTiles() %>%
  addCircles(lng = ~Long, lat = ~Lat, weight = 1,
             radius = ~sqrt(Pop) * 30, popup = ~City
  )

#rectangles
leaflet() %>% addTiles() %>%
  addRectangles(
    lng1=-118.456554, lat1=34.078039,
    lng2=-118.436383, lat2=34.062717,
    fillColor = "transparent" #red, blue etc.
  )

#Markers
data(quakes) #Locations of Earthquakes off Fiji

head(quakes)

# Show first 20 rows from the `quakes` dataset
leaflet(data = quakes[1:20,]) %>% addTiles() %>%
  addMarkers(~long, ~lat, popup = ~as.character(mag), label = ~as.character(mag))

#Cluster markers together
leaflet(quakes) %>% addTiles() %>% addMarkers(
  clusterOptions = markerClusterOptions()
)