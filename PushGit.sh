#!/bin/bash
echo "注意:文件夹或者文件的命名不要带有空格...."
if [ x"$1" = x ]; then 
    echo "填写 commit参数..."
    exit 1
fi
echo "上传到GitHub上"
git add .
git commit -m "$1"
git push origin master
echo "上传GitHub完毕"

