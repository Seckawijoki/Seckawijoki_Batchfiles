@echo off
set commitTime=%date% %time%
git add .
git commit -m "%commitTime%"
git push origin master