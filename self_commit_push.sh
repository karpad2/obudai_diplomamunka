echo "self commit & push"

mysqldump --opt -u root -p escape_room_lar > ./db/esp32project.sql
#cp ./server_part/config.php ./server_part/config_sample.php 
#pandoc --extract-media ./docs/images -s index.docx -t markdown -o README.md
#pandoc --extract-media ./docs/images  -s index.docx -o ./docs/index.html --metadata title="Diplomamunka"
#pandoc -s index.docx -t  --pdf-engine=xelatex -o README.pgit df
git add -A
git commit -a -m "SQL DUMP"
git push

EXIT
