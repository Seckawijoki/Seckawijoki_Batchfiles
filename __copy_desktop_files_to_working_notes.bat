@echo off

set pathSource=C:\Users\Administrator\Desktop\
set pathDestination=F:\working_notes_of_Miniworld\
set pathAutomaticBuild=F:\trunk\env1\client\AppPlay\ApkBuilderScripts\automatic_build


f:
cd %pathDestination%
if not exist batch_scripts mkdir batch_scripts
if not exist note_documents mkdir note_documents
if not exist shortcuts mkdir shortcuts
if not exist sub_codes mkdir sub_codes

if exist %pathSource%\*.bat copy %pathSource%\*.bat batch_scripts\

if exist %pathSource%\*.docx copy %pathSource%\*.docx note_documents\
if exist %pathSource%\*.xlsx copy %pathSource%\*.xlsx note_documents\
if exist %pathSource%\*.pptx copy %pathSource%\*.pptx note_documents\
if exist %pathSource%\*.txt copy %pathSource%\*.txt note_documents\

if exist %pathSource%\*.lnk copy %pathSource%\*.lnk shortcuts\

if exist %pathSource%\*.h copy %pathSource%\*.h sub_codes\
if exist %pathSource%\*.hpp copy %pathSource%\*.hpp sub_codes\
if exist %pathSource%\*.c copy %pathSource%\*.c sub_codes\
if exist %pathSource%\*.cpp copy %pathSource%\*.cpp sub_codes\
if exist %pathSource%\*.java copy %pathSource%\*.java sub_codes\
if exist %pathSource%\*.xml copy %pathSource%\*.xml sub_codes\

if exist %pathAutomaticBuild%\sub_files copy %pathAutomaticBuild%\sub_files sub_files
