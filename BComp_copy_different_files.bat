@echo off

set pathSrc=f:\trunk\env1\bin\res\
set pathDes=f:\trunk\env1\client\AppPlay\Proj.Android.Wo\assets\
REM set pathDes=f:\trunk\env1\client\AppPlay\Proj.Android.x7sy\assets\
set fileRules=rules_copy_different_files.txt
set fileOutput=assets_copy_report.html

if not exist %pathDes% mkdir %pathDes%\

set startTime=%time%
BComp.com @%fileRules% "%pathSrc%" "%pathDes%" "%fileOutput%"
echo startTime = %startTime%
echo endTime  =  %time%

start %fileOutput% 

