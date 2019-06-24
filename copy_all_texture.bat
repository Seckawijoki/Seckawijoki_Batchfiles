@echo off
setlocal EnableDelayedExpansion

set mDirCurrentProjAndroid=Proj.Android.Egame
set mPathCurrentProjAndroid=F:\trunk\env1\client\AppPlay\%mDirCurrentProjAndroid%

set "aTextureFolders=!aTextureFolders! texture2"
set "aTextureFolders=!aTextureFolders! texture3"
set "aTextureFolders=!aTextureFolders! texture4"

set aTextureFolders=!aTextureFolders:~1!

REM if not exist %mPathCurrentProjAndroid%\assets\ui\mobile\ mkdir %mPathCurrentProjAndroid%\assets\ui\mobile\
for %%i in (!aTextureFolders!) do (
    echo a | xcopy /s /e /a /c /q %mPathCurrentProjAndroid%\%%i\* %mPathCurrentProjAndroid%\assets\
)