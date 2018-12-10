# tmap and tmaptools
# December 05, 2018
# Natalia NAU

library(tmap)
library(tmaptools)

# brief intro on spatial data
# discrete spatial data - vector data - i.e. waterbody, country border. Most common are shapefiles.
# Continuous spatialfield - raster data
# addtitional variable that describe data, called attributes
# example of using a shapefile

# example of using a shapefile
data(World, metro)
names(c(World, metro))

tm_shape(World) + 
  tm_polygons("HPI",
              style = "pretty",
              palette = "YlOrRd", # reverse the color with a negative sign like "-YlOrRd"
              id = "name",
              popup.var = TRUE,
              colorNA = NULL) + 
  tm_shape(metro) + tm_dots("black")

summary(World$HPI)
happy <- c(12.78, 26.48, 44.71)

# include breaks in continuous data
tm_shape(World) +
  tm_polygons("HPI",
              breaks = happy,
              labels = c("unhappy","happy",
                         colorNA = NULL) +
                tm_facets(by = "continent"))

# compare two or more maps
tm_shape(World) + 
  tm_polygons(c("economy","HPI"),
              palette = "seq",
              breaks = happy,
              colorNA = NULL,
              border.col = "grey",
              border.alpha = 0.1) +
  tm_legend(legend.position = c("left","bottom"))

# examples with raster data
data(land)
names(land)

tm_shape(land) +
  tm_raster(col = "cover_cls",
            title = "Global land cover classes",
            legend.hist = TRUE,
            legend.hist.title = "Frequency of land cover clasees") + 
  tmap_style("col_blind") +
  tm_legend(legend.position = c("left","bottom")) + 
  tm_shape(World) + 
  tm_border(col="black") + 
  tm_layout(scale = 0.8) + 
  tm_shape(metro + tm_dots("black"))

# change view mode
ttm()
qtm()
last_map()

save_tmap(filename)

# continuous raster data
tm_shape(land) + 
  tm_raster(col = "trees",
            palette = "seq", 
            style = "cont",
            n = 3) + 
  tm_legend(legend.position = c("left","bottom"))


