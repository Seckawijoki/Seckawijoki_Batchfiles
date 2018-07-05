@echo off

%DRIVE%
cd %mPathProjAndroidResConfusion%\%DIR_ASSETS%
:: ---------- compress lua files start ----------

:: ---------- lua start ----------
:: find . -name "*.lua" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\lua2luac.sh %SUFFIX_EXE% {} \;
:: find . -name "*.lua" -exec file {} \;
:: ---------- lua end ----------

:: ---------- confuse csv start ----------
::find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse csv: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i
  )
)
::find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
:: ---------- confuse csv end ----------

:: ---------- confuse xml start ----------
::cd .\assets
::find . -name "*.xml"  ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "xml SUM= "SUM\1024\1024}'
::find . -name "*.xml"  ! -name lint.xml ! -name AndroidManifest.xml ! -wholename "*\res\*.xml" ! -wholename "*\sdkassets\*.xml" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\..\build\assetsconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {}  \; 
for /r %%i in (*.xml) do (
  set bTheSameExists=
  if exist %mPathProjAndroidResConfusion%\lint.xml if "%%~nxi" == "lint.xml" set bTheSameExists=true
  if exist %mPathProjAndroidResConfusion%\AndroidManifest.xml if "%%~nxi" == "AndroidManifest.xml" set bTheSameExists=true
  for /r %%j in (*\res\*.xml) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\sdkassets\*.xml) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse xml: %%~nxi
    call %PATH_BUILD%\assetsconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i
  )
)
::find . -name "*.xml" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "xml SUM= "SUM\1024\1024}'
::cd ..
:: ---------- confuse xml end ----------

:: ---------- confuse lua start ----------
::find . -name "*.lua" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "lua SUM= "SUM\1024\1024}'
::find . -name "*.lua" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {}  \; 
for /r %%i in (*.lua) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse lua: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i
  )
)
::find . -name "*.lua" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "lua SUM= "SUM\1024\1024}'
:: ---------- confuse lua end ----------

:: ---------- pngquant start ----------
:: Count the amount size of files excluding some specific files.
::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "PNG SUM= "SUM\1024\2014" M" }' 
::find . -name a.aaaa  ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf " -o -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "SKIPED PNG SUM= "SUM\1024\2014" M" }' 
echo pngquant is running, plz wait ...
::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ..\..\..\build\pngquant%SUFFIX_EXE% -f {} \; 
for /r %%i in (*.png) do (
  set bTheSameExists=
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
    echo confuse with quanting png: %%~nxi
    %PATH_BUILD%\pngquant%SUFFIX_EXE% -f %%~i
  )
)
for /f "delims=" %%i in (%PATH_PROJ_ANDROID_STUDIO%\skip_pngs_for_bat_script.txt) do (
  if defined DEBUG_ECHO echo confuse png %%~nxi
  %PATH_BUILD%\pngquant%SUFFIX_EXE% -f %%i
)


:: ---------- pngquant 1 start ----------
echo pngquant 1
::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) ! -name "*-fs8.png" ! -name "*-or8.png"  -delete
for /r %%i in (*.png) do (
  set bTheSameExists=
  for /r %%j in (*\res\*.png) do (
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  for /r %%j in (*\build\*) do (
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if exist %%j if "%%i" == "%%j" set bTheSameExists=true
  )
  for /f "delims=" %%j in (%PATH_PROJ_ANDROID_STUDIO%\skip_pngs_for_bat_script.txt) do (
    if exist .\%%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%i in (*-fs8.png) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  for /r %%i in (*-or8.png) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse with deleting png: %%~nxi
    del /q %%i
  )
)

:: ---------- pngquant 2 start ----------
echo pngquant 2
::find . -name "*-fs8.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-fs8\\'  {} \;
for /r %%i in (*-fs8.png) do (
  set bTheSameExists=
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
    echo confuse with remaning -fs8.png: %%~nxi
    rename "%%~ni" "%%i-fs8"
  )
)

:: ---------- pngquant 3 start ----------
echo pngquant 3
::find . -name "*-or8.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-or8\\'  {} \;
for /r %%i in (*-or8.png) do (
  set bTheSameExists=
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
    echo confuse with renaming -or8.png: %%~nxi
    rename "%%~ni" "%%i-or8"
  )
)

:: ---------- pngquant 4 start ----------
::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "PNG SUM= "SUM\1024\2014" M" }' 

:: ---------- pngquant end ----------

:: ---------- confuse png start ----------
rem find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \;
::find . -name "*.png" ! -wholename "*\res\*.png"  ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\notconfuse_pngs.txt)) -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} 64 \; 
:: ---------- confuse png end ----------


:: ---------- confuse ogg start ----------
::find . -name "*.ogg" ! -wholename "build\*" -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} 64 \; 
for /r %%i in (*.ogg) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse ogg: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i 64
  )
)
:: ---------- confuse ogg end ----------

:: ---------- confuse omod start ----------
::find . -name "*.omod" ! -wholename "build\*" -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} 64 \; 
for /r %%i in (*.omod) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse omod: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i 64
  )
)
:: ---------- confuse omod end ----------

:: ---------- confuse ktx start ----------
::find . -name "*.ktx" ! -wholename "build\*" -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} 64 \; 
for /r %%i in (*.ktx) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse ktx: %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i 64
  )
)
:: ---------- confuse ktx end ----------

:: ---------- confuse pvr start ----------
::find . -name "*.pvr" ! -wholename "build\*" -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} 64 \;  
for /r %%i in (*.pvr) do (
  set bTheSameExists=
  for /r %%j in (*\build\*) do (
    if exist %%j if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    echo confuse pvr %%~nxi
    call %PATH_BUILD%\zipconfuse.bat %SUFFIX_ARCH%%SUFFIX_EXE% %%i 64
  )
)
:: ---------- confuse pvr end ----------


