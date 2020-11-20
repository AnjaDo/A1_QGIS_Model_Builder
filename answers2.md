2. GDAL/OGR
2.1 Retrieving information about the DEM files via gdalinfo.

$ gdalinfo n45_e013_1arc_v3.tif 
$ gdalinfo N45E014.hgt

	2.1.1 What is the coordinate reference system (EPSG)?
		EPSG:4326 for both

	2.1.2 What is the driver (file format)?
		GTiff/GeoTIFF and SRTMHGT/SRTMHGT

	2.1.3 What is the spatial resolution?
		Pixel Size = (0.000277777777778,-0.000277777777778/  Unit: degree

2.2 Creating a raster mosaic
	2.2.1  Create a raster mosaic with gdal_merge and gdalbuildvrt

$ gdal_merge.py -o dem_merge.tif N45E014.hgt n45_e013_1arc_v3.tif 
$ gdalbuildvrt -separate dem_buildvrt.vrt N45E014.hgt n45_e013_1arc_v3.tif 


	2.2.2 What ist the difference between the two output files?

File size: dem_merge.tif is larger than dem_buildvrt.vrt, as the latter only 	builds a virtual dataset, which does not include the executed/merged product.  
Content-wise: The dem_merge.tif includes all pixels from both initial datasets and only one band. Because of the difference in band color interpretation the dem_buildvrt.vrt however demands for the -separate flag, which results in two separate bands.  


	2.2.3 What might be an advantage of using gdalbuildvrt instead of gdalmerge?

Using gdalbuildvrt saves space, in that no merged output is stored; but it needs the initial datasets/files to run the process.


3. Creating a GDAL/OGR script

3.1 Creat batch/shell script

$ touch calculate_slope_hillshade.sh



_____in shell_____

#!/bin/sh

# 3.2 Select target district using ogr2ogr

# ogr2ogr -where 'Column = Nameofdistrict' output_name_file input whichlayer 
ogr2ogr -where '"Name_2" = "Izola"' Izola.shp gadm36_SVN.gpkg gadm36_SVN_2

ogrinfo Izola.shp Izola -so
# Feature Count: 1


# 3.3. Clip the DEM to district

gdalwarp -t_srs EPSG:32632 -cutline Izola.shp -crop_to_cutline -dstnodata 0 dem_merge.tif dem_merge_cut_Izola.tif

# 3.4 Calculate the slope
gdaldem slope dem_merge_cut_Izola.tif dem_slope_Izola

# 3.5 Create a hillshade image
gdaldem hillshade dem_merge_cut_Izola.tif dem_hillshade_Izola


_____in terminal_____

3.6 Execute the script

$ chmod +x calculate_slope_hillshade.sh
$ ./calculate_slope_hillshade.sh
