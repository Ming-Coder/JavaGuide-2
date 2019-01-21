#!/bin/bash
if [ x"$1" = x ]; then 
    echo "填写 commit参数..."
    exit 1
fi
echo "执行脚本生成目录结构"
node createcatalogue.js
echo "目录结构生成完毕！"
echo "上传到GitHub上"
git add .
git commit -m "$1"
git push origin master
echo "上传GitHub完毕"

