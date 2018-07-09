@echo off

set pathSource=C:\Users\Administrator\Desktop\
set pathDestination=F:\working_notes_of_Miniworld\

copy %pathSource%\* %pathDestination%\*
copy %~nx0 %pathDestination%\*