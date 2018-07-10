@echo off

set pathSource=C:\Users\Administrator\Desktop\
set pathDestination=F:\working_notes_of_Miniworld\

copy %pathSource%\* %pathDestination%\*
copy %~nx0 %pathDestination%\*
copy F:\trunk\Miniworld_projects\client\AppPlay\ApkBuilderScripts\automatic_build\* %pathDestination%\*