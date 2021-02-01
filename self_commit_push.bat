echo "self commit & push"

mysqldump --opt -u root esp32project > ./db/esp32project.sql

pandoc --extract-media ./docs/images -s index.docx -t markdown -o readme.md
pandoc --extract-media ./docs/images  -s index.docx -o ./docs/index.html --metadata title="Diplomamunka"
pandoc -s index.docx -t  --pdf-engine=xelatex -o README.pdf
git add -A
git commit -a -m "Auto commit "
git push

EXIT