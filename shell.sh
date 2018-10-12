#!/bin/bash
echo '执行脚本生成目录结构'
node createcatalogue.js
echo '目录结构生成完毕！'
echo '上传到GitHub上'
commit_str = "fix JavaGuide"
if [ $# -lt 1  ]; then
	echo "have not any args,default a commit"
    commit_str = "fix JavaGuide"
fi
commit_str = $1
echo ${#commit_str}
git add .
git commit -m ${#commit_str}
#git push origin master
echo '上传GitHub完毕'

