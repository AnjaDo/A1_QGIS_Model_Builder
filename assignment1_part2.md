# Assignment 1.2: Automated GIS analyses using GDAL/OGR

**Submission deadline is Friday, Nov 27 2020 on your forked GitHub repository.**

This is the second part of Assignment 1. In this assignment you will use the program GDAL/OGR to process geodata in the command line. To solve the exercise refer to the [GDAL documentation](https://gdal.org/).

This is a **group assignment** in which you are supposed to solve these exercises in pairs of two students, but everyone should push the results to their own GitHub repository to get some practice in using git. 

Write the answers to the questions in a new markdown file called answers2.md. If your answer includes a command, format it using markdown syntax e.g. 

```
$ gdalinfo raster.tif
```

### 1. Preparation 

#### 1.1. Update your repository

The original repository [fossgis2021/A1\_QGIS\_Model\_Builder](https://github.com/fossgis2021/A1_QGIS_Model_Builder) now contains a new file called _assignment1\_part2.md_. In order to add this new file to your forked repository, you need to execute the following steps. 

1. Show the URLs of remote repositories (e.g. on GitHub) which are connected to your local repository. 

```
$ cd A1_QGIS_Model_Builder
$ git remote -v
```

2. Add the URL of the original repository as *upstream* to your forked repository.

```
$ git remote add upstream https://github.com/fossgis2021/A1_QGIS_Model_Builder.git
```

3. Pull updates (latests commits) from the upstream repository to your local repository.

```
$ git pull upstream main
```

#### 1.2. Download data 

Download the data for this assignment from [heiBox](https://heibox.uni-heidelberg.de/d/8d5adf89a1e847d3b74f/?dl=1). It contains: 

* [GADM](https://gadm.org/data.html) Administrative areas of Slovenia (gadm36\_SVN.gpkg)
* Two Digital Elevation Model files covering parts of Slovenia (N45E014.hgt, n45\_e013\_1arc\_v3.tif)


### 2. GDAL/OGR

#### 2.1 Retrieving information about the DEM files [3pt]

Use the command `gdalinfo` to answer the following questions about the **two DEM files**, e.g.

1. What is the coordinate reference system (EPSG)? 
2. What is the driver (file format)?
3. What is the spatial resolution? (Don't forget to provide the units)

#### 2.2 Creating a raster mosaic [4pt]

1. Create a raster mosaic of the files _N45E014.hgt_ and _n45_e013_1arc_v3.tif_ using the command `gdal_merge`. The output file should be called _dem\_merge.tif_. 
2. Create a raster mosaic of the files _N45E014.hgt_ and _n45_e013_1arc_v3.tif_ using the command `gdalbuildvrt`. The output file should be called _dem\_buildvrt.vrt_. 
3. Answer the following questions based on the results and the GDAL documentation: 
	* What is the difference between the two output files? 
	* What might be an advantage of using `gdalbuildvrt` instead of `gdalmerge`?
 
### 3. Creating a GDAL/OGR script   

Within this exercise you will write a batch/shell script which calculates the slope and creates a hillshade image from a digital elevation model within a selected district of Slovenia. 

##### 3.1 Creat batch/shell script [1pt]
Create a file called _calculate\_slope\_hillshade.bat_ on Windows or _calculate\_slope\_hillshade.sh_ on Linux/Mac OS (first line should be) and add the following commands into the file.

**Note for Mac OS/Linux:** The first line of the shell script should be `#!/bin/sh`.

##### 3.2 Select target district using `ogr2ogr` [1pt]
Select the Slovenian district with the name "Koper" from the GeoPackage _gadm36\_SVN.gpkg_ and save it as a new ESRI Shapefile file called _koper.shp_. Add the command in a new line to the _calculate\_slope_ script. 

**Hint:** Take a look at the examples given in the [ogr2ogr documentation](https://gdal.org/programs/ogr2ogr.html). 

Verify that the resulting koper.shp file contains exactly one feature by executing the command 

```
$ ogrinfo koper.shp koper -so 
```

##### 3.3. Clip the DEM to district. [1pt]

Clip the merged DEM _dem\_merge.tif_ to the selected district in _koper.shp_ and convert it to the coordinate reference system EPSG:32632. Do both in one command using the GDAL tool `gdalwarp`.

##### 3.4 Calculate the slope  [1pt]

Calculate the slope of the DEM file using a GDAL command. Add the command in a new line to the _calculate\_slope\_hillshade_ script. 

##### 3.5 Create a hillshade image [1pt]

Create a hill shade image based on the DEM using a GDAL command. Add the command in a new line to the _calculate\_slope\_hillshade_ script. 

##### 3.6 Execute the script [1pt]

Replace the district 'Koper' in your script with 'Izola'. Save the script and run it by executing the command `calculate_slope.bat` [Windows] or `./calculate_slope.sh ` [Linux/Mac OS]. You should get the slope and hill shade files for the district of Izola. 

**Note for Linux/Mac OS:** You might need to make the file executable using by running `$ chmod +x calculate_slope_hillshade.sh`.

##### 3.7 Push your script to GitHub

Finally, push your _calculate\_slope\_hillshade_ script to your GitHub repository. 

#### References

[GDAL documentation](https://gdal.org/)  

[Blogpost: git upstream explained](https://levelup.gitconnected.com/confusing-terms-in-the-git-terminology-c7115d6febc7)
