commitTime=$(date)
git add .
git commit -m "$commitTime"
git push origin master
#read -p "Press any key to continue."