#LIBRARIES ---------------------------------------------------------------------
library(ggplot2)
library(raster)
library(sf)

#LOAD DATA ---------------------------------------------------------------------

#SHP Files 
Pima_Bound <- st_read("C:\\Users\\doang\\OneDrive\\Desktop\\Gen2 Modeling\\R work\\SDM Maps\\MaxEnt-SDM-Maps\\Shape Files\\PimaBound\\PimaBound.shp")
Arizona_Outline <- st_read("C:\\Users\\doang\\OneDrive\\Desktop\\Gen2 Modeling\\R work\\SDM Maps\\MaxEnt-SDM-Maps\\Shape Files\\Arizona_State_Boundary_3538494511604515904\\Arizona_State_Boundary_0.shp")
#Pima Global Trained Raster 
Pima_Global <- raster("C:\\Users\\doang\\OneDrive\\Desktop\\Gen2 Modeling\\R work\\SDM Maps\\MaxEnt-SDM-Maps\\Rasters\\Pima_Global_Median.asc")





#Pima_Global RASTER -------------------------------------------------------------------

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

crs_Arizona_Outline <- st_crs(Arizona_Outline)
crs_Pima_Bound <- st_crs(Pima_Bound)

# Print the CRSs to see if they match
print(crs_Arizona_Outline)
print(crs_Pima_Bound)

# If they don't match, reproject Pima_Bound
if (crs_Arizona_Outline != crs_Pima_Bound) {
  Pima_Bound <- st_transform(Pima_Bound, crs = crs_Arizona_Outline)
}
# Plot with the reprojected raster data
#ggplot() +
  #geom_sf(data = Arizona_Outline) +
  #geom_raster(data = Pima_Global_DF_Projected, aes(x = x, y = y, fill = Pima_Global_Median)) +
  #scale_fill_gradientn(colors = c("blue", "green", "yellow", "red")) + # This is an example
  #coord_sf()


my_palette <- colorRampPalette(c("purple4","purple2", "orchid", "green4", 'green1', "yellow4", 'yellow1', "red4", 'red1'))

# Determine the number of breaks in the raster data (for example, 100)
num_colors <- 100

# Plot the raster with the defined color palette
plot(Pima_Global_Expanded, col=my_palette(num_colors), main="Pima Global Median Raster with Arizona Outline", axes=TRUE, box=FALSE)

# Overlay the Arizona shapefile on the raster
plot(st_geometry(Arizona_Outline), add=TRUE, border='black', lwd=3)

# Overlay the Pima_Bound shapefile with a red outline on the raster
plot(st_geometry(Pima_Bound), add=TRUE, border='red', lwd=2)

