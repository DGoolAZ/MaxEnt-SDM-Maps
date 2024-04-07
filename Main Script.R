#LIBRARIES ---------------------------------------------------------------------
library(ggplot2)
library(raster)
library(sf)

#LOAD DATA ---------------------------------------------------------------------

#SHP Files 
Arizona_Outline <- st_read("C:\\Users\\doang\\OneDrive\\Desktop\\Gen2 Modeling\\R work\\SDM Maps\\MaxEnt-SDM-Maps\\Shape Files\\Arizona_State_Boundary_3538494511604515904\\Arizona_State_Boundary_0.shp")
#Pima Global Trained Raster 
Pima_Global <- raster("C:\\Users\\doang\\OneDrive\\Desktop\\Gen2 Modeling\\R work\\SDM Maps\\MaxEnt-SDM-Maps\\Rasters\\Pima_Global_Median.asc")





#Pima RASTERS -------------------------------------------------------------------


#Pima Global Trained 
Pima_Global_DF <- as.data.frame(Pima_Global, xy = TRUE)
Pima_Global_DF <- na.omit(Pima_Global_DF)
# Reproject the raster data to match the shapefile's CRS
Pima_Global_Projected <- projectRaster(Pima_Global, crs = crs(Arizona_Outline))

# Convert the reprojected raster data to a data frame for plotting
Pima_Global_DF_Projected <- as.data.frame(Pima_Global_Projected, xy = TRUE)
Pima_Global_DF_Projected <- na.omit(Pima_Global_DF_Projected)

# Reproject the raster data to match the shapefile's CRS
Pima_Global_Projected <- projectRaster(Pima_Global, crs = crs(Arizona_Outline))

# Convert the reprojected raster data to a data frame for plotting
Pima_Global_DF_Projected <- as.data.frame(Pima_Global_Projected, xy = TRUE)
Pima_Global_DF_Projected <- na.omit(Pima_Global_DF_Projected)
# Plot with the reprojected raster data
ggplot() +
  geom_sf(data = Arizona_Outline) +
  geom_raster(data = Pima_Global_DF_Projected, aes(x = x, y = y, fill = Pima_Global_Median)) +
  scale_fill_gradientn(colors = c("blue", "green", "yellow", "red")) + # This is an example
  coord_sf()


# Plot the raster
plot(Pima_Global_Projected, main="Pima Global Median Raster with Arizona Outline")

# Overlay the shapefile on the raster
plot(st_geometry(Arizona_Outline), add=TRUE)