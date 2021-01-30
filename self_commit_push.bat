echo "self commit & push"

mysqldump --opt -u root esp32project > ./db/esp32project.sql

pandoc -s index.docx -t markdown -o README.md
pandoc -s index.docx -t markdown --pdf-engine=xelatex -o README.pdf
git add -A
git commit -a -m "Auto commit "
git push

EXIT