#!/bin/bash

function convertToSize() {
   fileName=$1
   extension=$2
   resolution=$3
   if [[ $fileName =~ [0-9] ]]; then
      echo "File contains a number, discarding..." > /dev/null
   else
      rm -rf "$fileName-$resolution.$extension"   
      convert -size "$resolution" xc:white "$fileName.$extension" -gravity center -composite "$fileName-$resolution.$extension"
      printf "  |-- ${BLUE} $fileName.$extension -- ${GREEN} $fileName-$resolution.$extension ${NC} \n" 
   fi
}

GREEN='\e[92m'
NC='\e[0m';
BLUE='\e[34m';
imagesDir='/home/workstation/websites/webzona/webyzona.com/templates/themeforest/globalnews/assets/images';
webp='webp'

#width is first, height is second
resolutions=("440x292" "164x152" "540x300" "1600x972" "76x76" "336x280" "1000x606" "128x128")
resol=("900x500")

cd $imagesDir
for item in *; do
if [ -d "$imagesDir/$item" ]; then
   cd $imagesDir/$item;
   for pictureFile in *; do
      if [ -z "${pictureFile##*$webp*}" ]; then 
         echo > /dev/null
      else
         fullFileName=$(basename -- "$pictureFile")
         extension="${fullFileName##*.}"
         fileName="${fullFileName%.*}"
         for resolution in "${resol[@]}"
            do
            convertToSize "$fileName" "$extension" "$resolution"
         done   
      fi
   done;
fi  
done;