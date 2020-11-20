#!/bin/sh

# 3.2 Select target district using ogr2ogr
 ogr2ogr -where '"Name_2" = "Izola"' Izola.shp gadm36_SVN.gpkg gadm36_SVN_2

ogrinfo Izola.shp Izola -so
# Feature Count: 1

# 3.3. Clip the DEM to district
gdalwarp -t_srs EPSG:32632 -cutline Izola.shp -crop_to_cutline -dstnodata 0 dem_merge.tif dem_merge_cut_Izola.tif

# 3.4 Calculate the slope
gdaldem slope dem_merge_cut_Izola.tif dem_slope_Izola

# 3.5 Create a hillshade image
gdaldem hillshade dem_merge_cut_Izola.tif dem_hillshade_Izola
