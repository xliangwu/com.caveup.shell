#!/bin/bash

#
# Split models
#
# target_models : output zip files
#

target_folder=$1

if [[ ! -d $target_folder ]];then
	echo "target folder :'${target_folder}' doesn't exist"
	exit 0
fi

if [[ ! -e source_models ]];then
	mkdir source_models
fi
rm -rf source_models/*
cd source_models
cp -r ${target_folder}/* .
tar czvf model.tar.gz *
split -a 3 -d -b 1024m model.tar.gz
mkdir sub_models targets
rm sub_models/x*
rm target_models/*.zip
mv x0* sub_models

cd targets
for file in `ls ../sub_models`
do
  zip ${file}.zip ../sub_models/${file}
  echo "`date` [INFO] zip ${file}"
done

echo "remove temp files"
rm -rf ../sub_models
echo "`date` [INFO] remove folder sub_models"
rm -f ../model.tar.gz
echo "`date` [INFO] remove file model.tar.gz"
