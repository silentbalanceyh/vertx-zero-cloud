#!/usr/bin/env bash
source .env.development
mkdir -p deployment/
# rm -rf deployment/*
cp -rf environment/$ZA_ENV/* deployment/
chmod +x deployment/*/*
echo "1. 测试验证环境处理完成！！"
# 替换环境变量
function read_dir(){
  for file in ` ls $1 `
  do
    if [ -d $1"/"$file ]
    then
      read_dir $1"/"$file
    else
      fileName=$1"/"$file
      extension=${fileName##*.}
      # .yml
      # .sh
      if [ "yml" == $extension -o "yaml" == $extension ]
      then
         fileOld="${fileName}.lock"
         echo "处理文件：$fileName"
         envsubst < $fileName > $fileOld
         mv $fileOld $fileName
      fi
    fi
  done
}
read_dir deployment
echo "2. 配置文件处理完成！！"