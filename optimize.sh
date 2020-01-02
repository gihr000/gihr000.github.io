#!/bin/bash
RED='\033[0;31m';
GREEN='\e[92m'
NC='\033[0m';
imagesDir='/home/workstation/websites/webzona/webyzona.com/templates/themeforest/globalnews/assets/images';
imgoptimize='/home/workstation/.img-optimize/optimize.sh';
function optima() {
   echo "Optimizing images...";  
   $imgoptimize --all $imagesDir/boxes &&
   $imgoptimize --all $imagesDir/contributors &&
   $imgoptimize --all $imagesDir/general &&
   $imgoptimize --all $imagesDir/posts &&
   printf "${GREEN}Optimization complete!${NC} \n";
}

dependencies="jpegoptim optipng webp";
dpkg -s $dependencies &> /dev/null
if [$? -ne 0]
   then echo -e "Installing ${RED}jpeg optimization dependencies... ${NC} \n"; 
   sudo apt install $dependencies -y &&
   git clone https://github.com/VirtuBox/img-optimize.git ~/.img-optimize &&
   echo "alias img-optimize=$HOME/.img-optimize/optimize.sh" >> $HOME/.bash_profile &&
   source $HOME/.bash_profile &&
   optima
else
   optima
fi