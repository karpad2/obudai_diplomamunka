echo "self commit & push"

mysqldump --opt -u root esp32project > ./db/esp32project.sql

pandoc --extract-media ./wiki/images -s index.docx -t markdown -o index.md
pandoc --extract-media ./wiki/images -metadata title "Diplomamunka" -s index.docx -o index.html
pandoc -s index.docx -t  --pdf-engine=xelatex -o README.pdf
git add -A
git commit -a -m "Auto commit "
git push

EXIT