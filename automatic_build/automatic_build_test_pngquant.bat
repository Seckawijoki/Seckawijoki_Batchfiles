@echo on
setlocal EnableDelayedExpansion
cd %mPathProjAndroidResConfusion%\%DIR_ASSETS%
:: ---------- pngquant 1 start ----------
echo pngquant 1
::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) ! -name "*-fs8.png" ! -name "*-or8.png"  -delete
set aFilesPng=
set pngFileCount=0
for /r %%i in (*.png) do (
  set bTheSameExists=
  echo confuse with deleting png: %%~nxi
  for /r %%j in (*\res\*.png) do (
    echo %%j
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  echo 1
  for /r %%j in (*\build\*) do (
    echo %%j
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  echo 2
  for /r %%j in (.\.idea\*) do (
    echo %%j
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  echo 3
  for /f "delims=" %%j in (%PATH_PROJ_ANDROID_STUDIO%\skip_pngs_for_bat_script.txt) do (
    echo %%j
    if exist .\%%j if %%i == %%j set bTheSameExists=true
  )
  echo 4
  for /r %%i in (*-fs8.png) do (
    echo %%j
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  echo 5
  for /r %%i in (*-or8.png) do (
    echo %%j
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  echo 6
  if not defined bTheSameExists (
    set "aFilesPng=!aFilesPng! %%i"
    set /a pngFileCount+=1
    rem del /q %%i
  )
)
echo !aFilesPng!
echo pngquant 1 : delete png files
if not "!aFilesPng!" == "" del /q !aFilesPng!
pause
:: ---------- pngquant 1 end ----------

:: ---------- pngquant 2 start ----------
echo pngquant 2
::find . -name "*-fs8.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-fs8\\'  {} \;
for /r %%i in (*-fs8.png) do (
  set bTheSameExists=
  echo confuse with remaning -fs8.png: %%~nxi
  for /r %%j in (*\res\*.png) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo rename %%~ni
    rem rename "%%~ni" "%%i-fs8"
  )
)

pause
:: ---------- pngquant 2 end ----------

:: ---------- pngquant 3 start ----------
echo pngquant 3
::find . -name "*-or8.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-or8\\'  {} \;
for /r %%i in (*-or8.png) do (
  set bTheSameExists=
  echo confuse with renaming -or8.png: %%~nxi
  for /r %%j in (*\res\*.png) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo rename %%~ni
    rem rename "%%~ni" "%%i-or8"
  )
)
