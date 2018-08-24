@echo off
rem set callPngquant1Deletion=1
rem ---------- confuse sequences ----------
rem --- 1.csv
rem --- 2.xml
rem --- 3.lua
rem --- 4.png
rem ---    pngquant    : pngquant
rem ---    pngquant 1 : delete pngs
rem ---    pngquant 2 : rename *-fs8.png
rem ---    pngquant 3 : rename *-or8.png
rem --- 5.ogg
rem --- 6.omod
rem --- 7.ktx
rem --- 8.pvr
set mStartTimeAssetsConfusion=%time%
set mPathProjAndroidAssetsConfusion=%mPathCurrentProjAndroid%

%DRIVE%
cd %mPathProjAndroidAssetsConfusion%\%DIR_ASSETS%

echo ---------- confuse assets start ----------
set mConfuseLength=64

set fileAssetsConfuse=assetsconfuse.bat
set fileZipConfuse=zipconfuse.bat
set fileSkipPngs=skip_pngs_for_bat_script.txt

rem ----- checkout the sub batch script existence -----
set fileLost=cygwin1.dll
if not exist %PATH_BUILD%\%fileLost% copy %PATH_AUTOMATIC_BUILD%\%fileLost% %PATH_BUILD%\%fileLost%
set fileLost=cygz.dll
if not exist %PATH_BUILD%\%fileLost% copy %PATH_AUTOMATIC_BUILD%\%fileLost% %PATH_BUILD%\%fileLost%
set fileLost=%fileSkipPngs%
if not exist %PATH_PROJ_ANDROID_STUDIO%\%fileLost% copy %PATH_AUTOMATIC_BUILD%\%fileLost% %PATH_PROJ_ANDROID_STUDIO%\%fileLost%

rem ---------- lua start ----------
rem find . -name "*.lua" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\lua2luac.sh %SUFFIX_EXE% {} \;
rem find . -name "*.lua" -exec file {} \;
rem ---------- lua end ----------

rem ---------- confuse csv start ----------
rem find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
echo ----- confuse csv files start -----
set totalSizeOfCsvFilesBefore=0
set totalSizeOfCsvFilesAfter=0
set confuseCount=0
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfCsvFilesBefore+=%%~zi
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse csv: %%~nxi
    call %PATH_BUILD%\%fileAssetsConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.csv) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfCsvFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfCsvFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfCsvFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfCsvFilesBefore% - %totalSizeOfCsvFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfCsvFilesBefore = %totalSizeOfCsvFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfCsvFilesAfter = %totalSizeOfCsvFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfCsvFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! csv files end -----
rem find . -name "*.csv" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
rem ---------- confuse csv end ----------

rem ---------- confuse xml start ----------
rem cd .\assets
rem find . -name "*.xml"  ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "xml SUM= "SUM\1024\1024}'
rem find . -name "*.xml"  ! -name lint.xml ! -name AndroidManifest.xml ! -wholename ".\res\*.xml" ! -wholename "*\sdkassets\*.xml" ! -wholename "build\*" ! -wholename ".\.idea\*" -exec ..\..\..\..\build\assetsconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {}  \; 
echo ----- confuse xml files start -----
set totalSizeOfXmlFilesBefore=0
set totalSizeOfXmlFilesAfter=0
set confuseCount=0
for /r %%i in (*.xml) do (
  set bTheSameExists=
  if exist %mPathProjAndroidAssetsConfusion%\lint.xml if "%%~nxi" == "lint.xml" set bTheSameExists=true
  if exist %mPathProjAndroidAssetsConfusion%\AndroidManifest.xml if "%%~nxi" == "AndroidManifest.xml" set bTheSameExists=true
  for /r %%j in (.\res\*.xml) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\sdkassets\*.xml) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfXmlFilesBefore+=%%~zi
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse xml: %%~nxi
    call %PATH_BUILD%\%fileAssetsConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.xml) do (
  set bTheSameExists=
  if exist %mPathProjAndroidAssetsConfusion%\lint.xml if "%%~nxi" == "lint.xml" set bTheSameExists=true
  if exist %mPathProjAndroidAssetsConfusion%\AndroidManifest.xml if "%%~nxi" == "AndroidManifest.xml" set bTheSameExists=true
  for /r %%j in (.\res\*.xml) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (*\sdkassets\*.xml) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfXmlFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfXmlFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfXmlFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfXmlFilesBefore% - %totalSizeOfXmlFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfXmlFilesBefore = %totalSizeOfXmlFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfXmlFilesAfter = %totalSizeOfXmlFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfXmlFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! xml files end -----
rem cd ..
rem ---------- confuse xml end ----------

rem ---------- confuse lua start ----------
echo ----- confuse lua files start -----
set totalSizeOfLuaFilesBefore=0
set totalSizeOfLuaFilesAfter=0
set confuseCount=0
for /r %%i in (*.lua) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfLuaFilesBefore+=%%~zi
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse lua: %%~nxi
    call %PATH_BUILD%\%fileZipConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.lua) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%~nxi == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfLuaFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfLuaFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfLuaFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfLuaFilesBefore% - %totalSizeOfLuaFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfLuaFilesBefore = %totalSizeOfLuaFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfLuaFilesAfter = %totalSizeOfLuaFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfLuaFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! lua files end -----
rem ---------- confuse lua end ----------

rem ---------- pngquant start ----------
echo ----- confuse quant png files start -----
set totalSizeOfPngFilesBefore=0
set totalSizeOfPngFilesAfter=0
set confuseCount=0
for /r %%i in (*.png) do (
  set bTheSameExists=
  for /r %%j in (.\res\*.png) do (
    if %%i == %%j set bTheSameExists=true
    if defined bTheSameExists goto :loop_end_confuse_png_quant
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
    if defined bTheSameExists goto :loop_end_confuse_png_quant
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
    if defined bTheSameExists goto :loop_end_confuse_png_quant
  )
  :loop_end_confuse_png_quant
  if not defined bTheSameExists (
    set /a totalSizeOfPngFilesBefore+=%%~zi
    set /a confuseCount+=1
    %PATH_BUILD%\pngquant%SUFFIX_EXE% -f %%~i
    if defined DEBUG_ECHO echo confuse with quanting !confuseCount! png: %%~pnxi
  ) else ( 
    echo png confusion is running 
  )
)
REM for /r %%i in (*.png) do (
  REM set bTheSameExists=
  REM for /r %%j in (.\res\*.png) do (
    REM if %%i == %%j set bTheSameExists=true
    REM if defined bTheSameExists goto :loop_end_calculate_png_size
  REM )
  REM for /r %%j in (.\build\*) do (
    REM if %%i == %%j set bTheSameExists=true
    REM if defined bTheSameExists goto :loop_end_calculate_png_size
  REM )
  REM for /r %%j in (.\.idea\*) do (
    REM if %%i == %%j set bTheSameExists=true
    REM if defined bTheSameExists goto :loop_end_calculate_png_size
  REM )
  REM :loop_end_calculate_png_size
  REM if not defined bTheSameExists (
    REM set /a totalSizeOfPngFilesAfter+=%%~zi
    REM echo Calculating the size after confusion: !totalSizeOfPngFilesAfter!
  REM )
REM )
for /f "delims=" %%i in (%PATH_PROJ_ANDROID_STUDIO%\%fileSkipPngs%) do (
  if exist %mPathProjAndroidAssetsConfusion%\%DIR_ASSETS%\%%i %PATH_BUILD%\pngquant%SUFFIX_EXE% -f %mPathProjAndroidAssetsConfusion%\%DIR_ASSETS%\%%i
)

set /a kbBefore=!totalSizeOfPngFilesBefore!/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=!totalSizeOfPngFilesAfter!/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=!totalSizeOfPngFilesBefore! - !totalSizeOfPngFilesAfter!
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfPngFilesBefore = !totalSizeOfPngFilesBefore! Byte , !kbBefore! KB , !mbBefore! MB
REM echo totalSizeOfPngFilesAfter = !totalSizeOfPngFilesAfter! Byte , !kbAfter! KB , !mbAfter! MB
REM echo confuseSizeOfPngFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse quant !confuseCount! png files end -----

rem ---------- pngquant 1 start ----------
if defined callPngquant1Deletion call %PATH_AUTOMATIC_BUILD%\automatic_build_pngquant_1_deleting_png.bat

rem ---------- pngquant 2 start ----------
echo ----- pngquant 2 rename -fs8.png files start -----
set renameCountOfPngFiles=0
for /r %%i in (*-fs8.png) do (
  set bTheSameExists=
  for /r %%j in (.\res\*.png) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a renameCountOfPngFiles+=1
    set nameOfPng=%%~ni
    if defined DEBUG_ECHO echo confuse with renaming -fs8.png file %%~nxi, !nameOfPng!
    del /q "%%~dpi\!nameOfPng:~0,-4!.png"
    rename "%%~i" "!nameOfPng:~0,-4!.png"
  )
)
echo ----- pngquant 2 rename %deleteCountOfPngFiles% -fs8.png files end -----

rem ---------- pngquant 3 start ----------
echo ----- pngquant 3 rename -or8.png files start -----
set renameCountOfPngFiles=0
for /r %%i in (*-or8.png) do (
  set bTheSameExists=
  for /r %%j in (.\res\*.png) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  for /r %%j in (.\.idea\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a renameCountOfPngFiles+=1
    set nameOfPng=%%~ni
    if defined DEBUG_ECHO echo confuse with renaming -or8.png file %%~nxi, !nameOfPng!
    del /q "%%~dpi\!nameOfPng:~0,-4!.png"
    rename "%%~i" "!nameOfPng:~0,-4!.png"
  )
)
echo ----- pngquant 3 rename %deleteCountOfPngFiles% -or8.png files end -----

rem ---------- pngquant 4 start ----------
rem find . -name "*.png" ! -wholename ".\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "PNG SUM= "SUM\1024\2014" M" }' 

rem ---------- pngquant end ----------

rem ---------- confuse png start ----------
rem find . -name "*.png" ! -wholename ".\res\*.png" ! -wholename "build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \;
rem find . -name "*.png" ! -wholename ".\res\*.png"  ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\notconfuse_pngs.txt)) -exec ..\..\..\build\zipconfuse.sh %SUFFIX_ARCH%%SUFFIX_EXE% {} %mConfuseLength% \; 
rem ---------- confuse png end ----------


rem ---------- confuse ogg start ----------
echo ----- confuse ogg files start -----
set totalSizeOfOggFilesBefore=0
set totalSizeOfOggFilesAfter=0
set confuseCount=0
for /r %%i in (*.ogg) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfOggFilesBefore+=%%~zi
  )
)
for /r %%i in (*.ogg) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse ogg: %%~nxi
    call %PATH_BUILD%\%fileZipConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.ogg) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfOggFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfOggFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfOggFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfOggFilesBefore% - %totalSizeOfOggFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfOggFilesBefore = %totalSizeOfOggFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfOggFilesAfter = %totalSizeOfOggFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfOggFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! ogg files end -----
rem ---------- confuse ogg end ----------

rem ---------- confuse omod start ----------
echo ----- confuse omod files start -----
set totalSizeOfOmodFilesBefore=0
set totalSizeOfOmodFilesAfter=0
set confuseCount=0
for /r %%i in (*.omod) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfOmodFilesBefore+=%%~zi
  )
)
for /r %%i in (*.omod) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse omod: %%~nxi
    call %PATH_BUILD%\%fileZipConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.omod) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfOmodFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfOmodFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfOmodFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfOmodFilesBefore% - %totalSizeOfOmodFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfOmodFilesBefore = %totalSizeOfOmodFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfOmodFilesAfter = %totalSizeOfOmodFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfOmodFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! omod files end -----
rem ---------- confuse omod end ----------

rem ---------- confuse ktx start ----------
echo ----- confuse ktx files start -----
set totalSizeOfKtxFilesBefore=0
set totalSizeOfKtxFilesAfter=0
set confuseCount=0
for /r %%i in (*.ktx) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfKtxFilesBefore+=%%~zi
  )
)
for /r %%i in (*.ktx) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse ktx: %%~nxi
    call %PATH_BUILD%\%fileZipConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.ktx) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfKtxFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfKtxFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfKtxFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfKtxFilesBefore% - %totalSizeOfKtxFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfKtxFilesBefore = %totalSizeOfKtxFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfKtxFilesAfter = %totalSizeOfKtxFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfKtxFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! ktx files end -----
rem ---------- confuse ktx end ----------

rem ---------- confuse pvr start ----------
echo ----- confuse pvr files start -----
set totalSizeOfPvrFilesBefore=0
set totalSizeOfPvrFilesAfter=0
set confuseCount=0
for /r %%i in (*.pvr) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfPvrFilesBefore+=%%~zi
  )
)
for /r %%i in (*.pvr) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a confuseCount+=1
    if defined DEBUG_ECHO echo confuse pvr: %%~nxi
    call %PATH_BUILD%\%fileZipConfuse% %SUFFIX_ARCH%%SUFFIX_EXE% %%i %mConfuseLength%
  )
)
for /r %%i in (*.pvr) do (
  set bTheSameExists=
  for /r %%j in (.\build\*) do (
    if %%i == %%j set bTheSameExists=true
  )
  if not defined bTheSameExists (
    set /a totalSizeOfPvrFilesAfter+=%%~zi
  )
)
set /a kbBefore=%totalSizeOfPvrFilesBefore%/1024
set /a mbBefore=!kbBefore!/1024
set /a kbAfter=%totalSizeOfPvrFilesAfter%/1024
set /a mbAfter=!kbAfter!/1024
set /a byteSubtraction=%totalSizeOfPvrFilesBefore% - %totalSizeOfPvrFilesAfter%
set /a kbSubtraction=!byteSubtraction!/1024
set /a mbSubtraction=!kbSubtraction!/1024
echo totalSizeOfPvrFilesBefore = %totalSizeOfPvrFilesBefore% Byte , !kbBefore! KB , !mbBefore! MB
echo totalSizeOfPvrFilesAfter = %totalSizeOfPvrFilesAfter% Byte , !kbAfter! KB , !mbAfter! MB
echo confuseSizeOfPvrFiles = !byteSubtraction! Byte , !kbSubtraction! KB , %mbSubtraction% MB
echo ----- confuse !confuseCount! pvr files end -----


rem ---------- other ----------
copy %PATH_BIN%\res\entity\110029\yanse.png entity\110029\yanse.png
copy %PATH_BIN%\res\entity\110029\yanse1.png entity\110029\yanse1.png
copy %PATH_BIN%\res\entity\140007\female.pvr entity\140007\female.pvr
copy %PATH_BIN%\res\entity\player\player12\body.png entity\player\player12\body.png

rem ---------- remove sub files ----------
del /q /s ui\mobile\texture\bigtex_pc\*
del /q /s ui\mobile\texture\uitcomm1\*
del /q /s ui\mobile\texture\uitex\*
del /q /s ui\mobile\texture\uitex2\*
del /q /s ui\mobile\texture\uitex3\*
del /q /s ui\mobile\texture\uitex4\*
del /q /s ui\mobile\texture\uitpc\*
del /q /s ui\mobile\texture\uipc_alpha.ktx

rd /q /s ui\mobile\texture\bigtex_pc
rd /q /s ui\mobile\texture\uitcomm1
rd /q /s ui\mobile\texture\uitex
rd /q /s ui\mobile\texture\uitex2
rd /q /s ui\mobile\texture\uitex3
rd /q /s ui\mobile\texture\uitex4
rd /q /s ui\mobile\texture\uitpc

set mEndTimeAssetsConfusion=%time%
echo ---------- confuse assets end ----------

