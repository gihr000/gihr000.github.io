#!/bin/bash

baseDir='/home/workstation/websites/webzona/webyzona.com/templates/themeforest/globalnews'
projectDir=$baseDir'/assets/js'
exportDir=$baseDir'/_site/assets/js'

cd $exportDir && echo 'Removing everyting from directory:' $exportDir && rm *.js;
cd $projectDir
for file in *.js;
do short=${file%.js};
echo 'Writing to ' $exportDir/$short.js
uglifyjs $file > $exportDir/$short.js
done;