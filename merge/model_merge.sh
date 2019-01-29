#!/bin/sh

#
# Split models
#

target_folder=$1

if [[ ! -d $target_folder ]];then
	echo "target folder :'${target_folder}' doesn't exist"
	exit 0
fi

cd ${target_folder}
mkdir models
if [[ -d models ]];then
	rm -rf models/*
	rm -rf sub_models
fi

for file in `ls x*.zip`
do
  unzip ${file}
  echo "unzip ${file}"
done

cat sub_models/* >models/model.tar.gz
cd models
tar xvf model.tar.gz
rm -rf ../sub_models
echo "`date` [INFO] remove folder sub_models"
rm -f model.tar.gz
echo "`date` [INFO] remove file model.tar.gz"
