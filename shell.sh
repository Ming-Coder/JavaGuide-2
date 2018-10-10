echo '执行脚本生成目录结构'
node createcatalogue.js
echo '上传到GitHub上'
git add .
git commit -m "修改文件"
git push origin master

