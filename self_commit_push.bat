echo "self commit & push"

mysqldump --opt -u root esp32project > ./db/esp32project.sql

git add -A
git commit -a -m "Auto commit "+%date%
git push
