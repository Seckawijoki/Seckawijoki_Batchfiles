@echo off

echo bNdkBuildFinished = %bNdkBuildFinished%

%DRIVE%
cd %mPathProjAndroidAssetsIntegration%
echo mPathProjAndroidAssetsIntegration = %mPathProjAndroidAssetsIntegration%

echo y | cacls * /p everyone:F

echo.
echo ----- copy %PATH_BIN%\res\* start -----
if defined mDebugEcho echo a | xcopy /s /e /a /c /l %PATH_BIN%\res\* %DIR_ASSETS%\
if not defined mDebugEcho echo a | xcopy /s /e /a /c /q %PATH_BIN%\res\* %DIR_ASSETS%\
echo ----- copy %PATH_BIN%\res\* end -----

echo ----- call MobileGameResPatch.exe start -----
if %mApkLoad% == %APK_LOAD_DISTRIBUTED_DOWNLOAD% (
  if not exist %PATH_MAKE_WEB%\all\mobileResToload mkdir %PATH_MAKE_WEB%\all\mobileResToload 
  %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %mPathProjAndroidAssetsIntegration% %PATH_MAKE_WEB%\all\mobileResToload\ %mApkVersionName%
)
if %mApkLoad% == %APK_LOAD_DISTRIBUTED_DOWNLOAD_AND_AUTOMATIC_DECOMPRESSION% (
  if not exist %PATH_MAKE_WEB%\all\mobileResToload mkdir %PATH_MAKE_WEB%\all\mobileResToload 
  %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %mPathProjAndroidAssetsIntegration% %PATH_MAKE_WEB%\all\mobileResToload\ %mApkVersionName% 1
)
echo ----- call MobileGameResPatch.exe end -----

if "%mProjType%" == "%PROJ_TYPE_OVERSEAS%" (
  echo ----- clean_imag_ios.sh in %PROJ_TYPE_OVERSEAS% start -----
  cd %DIR_ASSETS%
  call %PATH_BUILD%\clean_imag_ios.sh
  cd ..
  echo ----- clean_imag_ios.sh in %PROJ_TYPE_OVERSEAS% end -----
) else (
  echo ----- clean_imag_android.sh start -----
  cd %DIR_ASSETS%
  call %PATH_BUILD%\clean_imag_android.sh
  cd ..
  echo ----- clean_imag_android.sh end -----
)

echo ----- iconv csv files start -----
cd %PATH_BIN%\res\csvdef\
if not exist %mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%\csvdef (
  mkdir %mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%\csvdef
)
rem Checkout the existent of some directories with name ending with csv.
for /r %%i in (%PATH_BIN%\res\csvdef\*.csv) do (
  pushd "%%i" 2>nul && ( call :is_a_folder_with_name_ending_with_csv "%%i" & popd ) || call :is_a_csv_file "%%i"
)
echo ----- iconv csv files end -----


echo ----- remove unused files start -----
cd %mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%
mkdir shaders
del /q /s shaders\*
copy %PATH_BIN%\res\shaders\materials.xml shaders\materials.xml
del /q csvdef\translate\*
rd /s /q  csvdef\translate

del /q csvdef\achievement.csv
del /q csvdef\aidef.csv
del /q csvdef\book.csv
del /q csvdef\bookseries.csv
del /q csvdef\buffdef.csv
del /q csvdef\enchant.csv
del /q csvdef\filterstring.csv
del /q csvdef\fruit.csv
del /q csvdef\HomeLevelLove.csv
del /q csvdef\horseability.csv
del /q csvdef\hotkey.csv
del /q csvdef\itemdef.csv
del /q csvdef\key.csv
del /q csvdef\minicoin_google.csv
del /q csvdef\minicoin_ios_en.csv
del /q csvdef\monster.csv
del /q csvdef\plot.csv
del /q csvdef\role.csv
del /q csvdef\roleskin.csv
del /q csvdef\ruleoption.csv
del /q csvdef\signin.csv
del /q csvdef\storehorse.csv
del /q csvdef\storeprop.csv
del /q csvdef\stringdef.csv
del /q csvdef\task.csv

copy %PATH_BIN%\res\entity\110058\touming.png entity\110058\touming.png
copy %PATH_BIN%\res\entity\110058\yanse.png entity\110058\yanse.pngg
copy %PATH_BIN%\res\entity\140014\face_100108.ktx entity\140014\face_100108.ktx
copy %PATH_BIN%\res\entity\140014\face_100130.ktx entity\140014\face_100130.ktx
copy %PATH_BIN%\res\entity\140014\male.ktx entity\140014\male.ktx
copy %PATH_BIN%\res\entity\player\player12\2.png_ entity\player\player12\2.png_
copy %PATH_BIN%\res\entity\player\player12\3.png_ entity\player\player12\3.png_
copy %PATH_BIN%\res\entity\player\player12\4.png_ entity\player\player12\4.png_
copy %PATH_BIN%\res\entity\player\player12\body.png entity\player\player12\body.png

del /q music\bgm_planet_day_3.ogg
del /q music\bgm_planet_night_3.ogg

del /q mods\Material_1.2_3a3fefca-3b02-11e7-a919-92ebcb67fe33.zip
del /q mods\Realistic_1.2_aef3f5e6-48be-4631-b20f-d386bc333f99.zip
del /q /s overseas_res\*
del /q /s shaders\max_shaders\*
del /q /s shaders\test\*
rd /q /s overseas_res
rd /q /s shaders\max_shaders
rd /q /s shaders\test
del /q /s shaders\*.fx
del /q /s toolres\*
rd /q /s toolres
del /q /s ui\*.pvr
del /q /s entity\*.png
del /q /s ui\*.pvr
del /q /s ui\*.png
del /q /s ui\*.pvr
del /q /s ui\mobile\texture\bigtex_pc\*
del /q /s ui\mobile\texture\uitcomm1\*
del /q /s ui\mobile\texture\uitex\*
del /q /s ui\mobile\texture\uitex2\*
del /q /s ui\mobile\texture\uitex3\*
del /q /s ui\mobile\texture\uitex4\*
del /q /s ui\mobile\texture\uitpc\*

cd ..
echo ----- remove unused files end -----

echo ----- remove redundant csv files start -----
for /r "delims=" %%i in (%DIR_ASSETS%\csvdef\autogen\*.*) do (
  for /r "delims=" %%j in (%DIR_ASSETS%\csvdef\*.*) do (
    if %%~nxi == %%~nxj (
      if defined mDebugEcho echo remove redundant csv files: %%~j
      del /q %%~j
    )
  )
)
echo ----- remove redundant csv files end -----


::--------------------------------------------------------------- 
::-- Desciption: 
rem      If the iterated csv file is a file. 
::-- Param: 
rem      the csv file
::-- Global Return: 
rem      nul
::--------------------------------------------------------------- 
:is_a_csv_file
if "%~1" == "" goto :eof
iconv -f GBK -t UTF-8 -c %~1> csvdef\%~n1
goto :eof

::--------------------------------------------------------------- 
::-- Desciption: 
rem      If the iterated csv file is a directory, the correct logical operation of file cannot be executed. 
::-- Param: 
rem      the csv file
::-- Global Return: 
rem      nul
::--------------------------------------------------------------- 
:is_a_folder_with_name_ending_with_csv
if "%~1" == "" goto :eof
echo %~n1 is directory, cannot be convert to utf8
goto :eof
