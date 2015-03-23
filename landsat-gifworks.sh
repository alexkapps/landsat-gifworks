#!/bin/bash

LAT=$1
LON=$2
#S=$3
#E=$4
#RESCALESIZE=$5

mkdir ~/land-gif
mkdir ~/land-gif/working
mkdir ~/land-gif/output

cd ~/land-gif/working

landsat search --lat $LAT --lon $LON -s "august 30 2014" -e "march 23 2015" > ~/land-gif/working/search.txt

awk '/"sceneID": "/,/",/' ~/land-gif/working/search.txt | awk -F'"' '{print $4}' > test2.txt

IDLIST=( "$(awk '/"sceneID": "/,/",/' ~/land-gif/working/search.txt | awk -F'"' '{print $4}')" )
echo $IDLIST

#to do: print how many items there are in list 

download_process () {
	echo $1' is going'
	landsat download $1;
	landsat process ~/landsat/downloads/$1.tar.bz;
}

export -f download_process

echo 'GNU parallel is downloading and processing landsat scenes with landsat-util. This may take a long time.'
parallel --progress "download_process {}" ::: $(for ID in ${IDLIST}; do echo $ID; done)

#MAXLAT=$(expr $LAT + 1)
#echo $MAXLAT
#MINLAT=$(expr $LAT - 1)
#echo $MINLAT
#MAXLON=$(expr $LON + 1)
#echo $MAXLON
#MINLON=$(expr $LON - 1)
#echo $MINLON

crop_and_cp () {
	echo $1
	FORCUT=$1

	IDDATE=${FORCUT:9:7}
	IDPATHROW=${FORCUT:3:6}
	echo $IDPATHROW

	cp ~/landsat/processed/$1/$1'_bands_432.TIF' ~/land-gif/working/$IDPATHROW'_'$IDDATE'.TIF'
	convert -resize 25% ~/land-gif/working/$IDPATHROW'_'$IDDATE'.TIF' ~/land-gif/working/$IDPATHROW'_'$IDDATE'.TIF'
	#cp ~/landsat/processed/$1/$1'_bands_432.TIF' ~/land-gif/working/$IDDATE'_working.TIF'
	#gdal_translate -projwin $MINLON $MAXLAT $MAXLON $MINLAT ~/land-gif/working/$IDDATE'_working.TIF' ~/land-gif/working/$IDDATE'.TIF'

}

export -f crop_and_cp

parallel --progress "crop_and_cp {}" ::: $(for ID in ${IDLIST}; do echo $ID; done)
#for ID in ${IDLIST}; do crop_and_cp_scene $ID; done

echo "creating gif with imagemagick.. this takes a while.."
#convert -delay 20 -loop 0 ~/land-gif/working/$IDPATHROW*'.TIF' $IDPATHROW'_ANIMATE.gif'
convert -delay 80 -loop 0 ~/land-gif/working/012031'_'*'.TIF' ~/land-gif/working/012031_ANIMATE.gif
convert -delay 80 -loop 0 ~/land-gif/working/011031'_'*'.TIF' ~/land-gif/working/011031_ANIMATE.gif

#rm -r ~/landsat/downloads/$ID*
#rm -r ~/landsat/processed/$ID*
