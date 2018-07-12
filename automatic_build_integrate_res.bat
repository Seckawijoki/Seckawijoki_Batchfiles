@echo off

set mStartTimeResIntegration=%time%
set mPathProjAndroidResIntegration=%mPathCurrentProjAndroid%

%DRIVE%
cd %mPathProjAndroidResIntegration%

rem ---------- integrate res start ----------


echo ---------- integrate res start ----------
if exist %DIR_ASSETS% del /s /q %DIR_ASSETS%\*
if not exist %DIR_ASSETS% mkdir %DIR_ASSETS%

echo y | cacls * /p everyone:F

rem ----- checkout the sub batch script existence -----

copy %PATH_BIN%\dnsconfig.ini %DIR_ASSETS%\dnsconfig.ini
copy %PATH_BIN%\proto_comm.meta %DIR_ASSETS%\proto_comm.meta
copy %PATH_BIN%\proto_cs.meta %DIR_ASSETS%\proto_cs.meta
copy %PATH_BIN%\proto_hc.meta %DIR_ASSETS%\proto_hc.meta
copy %PATH_BIN%\proto_room.meta %DIR_ASSETS%\proto_room.meta
copy %PATH_BIN%\proto_tconn.meta %DIR_ASSETS%\proto_tconn.meta
copy %PATH_BIN%\serverlist.data %DIR_ASSETS%\serverlist.data
copy %PATH_BIN%\serverlist_developer.data %DIR_ASSETS%\serverlist_developer.data
copy %PATH_BIN%\serverlist_en_test_12.data %DIR_ASSETS%\serverlist_en_test_12.data
copy %PATH_BIN%\serverlist_en_release_10.data %DIR_ASSETS%\serverlist_en_release_10.data
copy %PATH_BIN%\serverlist_release.data %DIR_ASSETS%\serverlist_release.data
copy %PATH_BIN%\serverlist_releasetest.data %DIR_ASSETS%\serverlist_releasetest.data
copy %PATH_BIN%\shadercache.key %DIR_ASSETS%\shadercache.key
copy %PATH_BIN%\shadercache_ogl.dat %DIR_ASSETS%\shadercache_ogl.dat
copy %PATH_BIN%\uitexture.ref %DIR_ASSETS%\uitexture.ref

echo ----- copy cfg files start -----
if "%mProjType%" == "%PROJ_TYPE_ADT%" (
  echo ----- mProjType == "%PROJ_TYPE_ADT%" -----
  copy %PATH_BIN%\iworld_android.cfg %DIR_ASSETS%\iworld.cfg
  copy %PATH_BIN%\iworld_android_overseas.cfg %DIR_ASSETS%\iworld_overseas.cfg
  copy %PATH_BIN%\iworld_androidbeta.cfg %DIR_ASSETS%\iworld_androidbeta.cfg
  copy %PATH_BIN%\iworld_android_overseasbeta.cfg %DIR_ASSETS%\iworld_android_overseasbeta.cfg
 
  if %mApkLoad% == 1 (
    mkdir %PATH_MAKE_WEB%\all\mobileResToload 
    %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %PATH_MAKE_WEB%\all\mobileResToload\%mApkVersionName%
  )

  if %mApkLoad% == 2 (
    mkdir %PATH_MAKE_WEB%\all\mobileResToload 
    %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %PATH_MAKE_WEB%\all\mobileResToload\%mApkVersionName% 1
  )
) else (

  set bOverseasTypesMatchesProjectType=
  for %%i in (%OVERSEAS_TYPES%) do if "%%i" == "%mProjType%" set bOverseasTypesMatchesProjectType=1
  
  if defined bOverseasTypesMatchesProjectType (
    echo mProjType in "OVERSEAS_TYPES" 
    echo cfg only iworld_android_overseas.cfg, zhishu ktx only zhishu_m_p1.ktx
    copy %PATH_BIN%\iworld_android_overseas.cfg %DIR_ASSETS%\iworld.cfg
    rem TODO
    rsync /A /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
    copy %DIR_ASSETS%\english\fonts\Fonts.xml %DIR_ASSETS%\ui\mobile\Fonts.xml
  ) else (
    if "%mProjType%" == "%PROJ_TYPE_OVERSEAS_BETA%" (
    echo mProjType = %PROJ_TYPE_OVERSEAS_BETA%
    echo cfg only iworld_android_overseasbeta.cfg, zhishu ktx only zhishu_m_p1.ktx
    copy %PATH_BIN%\iworld_android_overseasbeta.cfg %DIR_ASSETS%\iworld.cfg
    rem rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
    ) else (
      if "%mProjType%" == "%PROJ_TYPE_MINIBETA%" (
      echo mProjType = %PROJ_TYPE_MINIBETA%
      echo cfg only iworld_androidbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
      copy %PATH_BIN%\iworld_androidbeta.cfg %DIR_ASSETS%\iworld.cfg
      rem rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
      ) else (
        echo mProjType = OTHER
        echo no overseas_res,cfg only iworld_android.cfg,zhishu ktx only zhishu_m_p1.ktx
        copy %PATH_BIN%\iworld_android.cfg %DIR_ASSETS%\iworld.cfg
        rem rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
        if "%mProjType%" == "%PROJ_TYPE_TENCENT_QQDT%" (
          echo  mProjType = %PROJ_TYPE_TENCENT_QQDT%
          echo zhishu ktx add zhishu_m_47_p3.ktx zhishu_m_47_p3_alpha.ktx
          copy %PATH_BIN%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx %DIR_ASSETS%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx
          copy %PATH_BIN%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx %DIR_ASSETS%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx
        )
      )
    )
  )
  if %mApkLoad% == 1 (
    mkdir %PATH_MAKE_WEB%\all\mobileResToload %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %PATH_MAKE_WEB%\all\mobileResToload\ %mApkVersionName%
  )
)
echo ----- copy cfg files end -----

echo ----- copy %PATH_BIN%\res\* start -----
if defined DEBUG_ECHO echo a | xcopy /s /e /a /c /f %PATH_BIN%\res\* %DIR_ASSETS%\*
if not defined DEBUG_ECHO echo a | xcopy /s /e /a /c /q %PATH_BIN%\res\* %DIR_ASSETS%\*
echo ----- copy %PATH_BIN%\res\* end -----

echo ----- clean_imag_android.sh start -----
cd %DIR_ASSETS%
call %PATH_BUILD%\clean_imag_android.sh
cd ..
echo ----- clean_imag_android.sh end -----


echo ----- iconv csv files start -----
cd %PATH_BIN%\res\csvdef\
if not exist %mPathProjAndroidResIntegration%\%DIR_ASSETS%\csvdef (
  mkdir %mPathProjAndroidResIntegration%\%DIR_ASSETS%\csvdef
)
rem Checkout the existent of some directories with name ending with csv.
for /r %%i in (%PATH_BIN%\res\csvdef\*.csv) do (
  pushd "%%i" 2>nul && ( call :is_a_folder_with_name_ending_with_csv "%%i" & popd ) || call :is_a_csv_file "%%i"
)
echo ----- iconv csv files end -----

cd %mPathProjAndroidResIntegration%\%DIR_ASSETS%
mkdir shaders
del /q /s shaders\*
copy %PATH_BIN%\res\shaders\materials.xml shaders\materials.xml

rem ---------- remove unused files start ----------
echo ----- remove unused files start -----
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

del /q /s shaders\max_shaders\*
del /q /s shaders\test\*
rd /q /s shaders\max_shaders
rd /q /s shaders\test
del /q /s shaders\*.fx
del /q /s toolres\*
rd /q /s toolres
del /q /s ucgamesdk\*
cd ..
echo ----- remove unused files end -----

mkdir %DIR_ASSETS%\GCloudVoice
copy %DIR_SDK_ASSETS%\GCloudVoice\* %DIR_ASSETS%\GCloudVoice\

for /r "delims=" %%i in (%DIR_ASSETS%\csvdef\autogen\*.*) do (
  for /r "delims=" %%j in (%DIR_ASSETS%\csvdef\*.*) do (
    if %%~nxi == %%~nxj (
      del /q %%~j
    )
  )
)

echo ----- copy overseas font start -----
set bOverseasAndroidProjMatchesCurrentProj=
for %%i in (%A_PATHS_OVERSEAS_PROJ_ANDROID%) do if "%%i" == "%mPathProjAndroidResIntegration%" set bOverseasAndroidProjMatchesCurrentProj=1
if defined bOverseasAndroidProjMatchesCurrentProj (
 copy %mPathProjAndroidResIntegration%\%DIR_ASSETS%\overseas_res\english\fonts\Fonts.xml %mPathProjAndroidResIntegration%\%DIR_ASSETS%\ui\mobile\Fonts.xml
)
set bBlockarkIosResMatchesCurrentProj=
for %%i in (%PATH_PROJ_ANDROID_BLOCKARK_IOS_RES%) do if "%%i" == "%mPathProjAndroidResIntegration%" set bBlockarkIosResMatchesCurrentProj=1
if defined bBlockarkIosResMatchesCurrentProj ( 
 copy %mPathProjAndroidResIntegration%\%DIR_ASSETS%\overseas_res\english\fonts\Fonts.xml %mPathProjAndroidResIntegration%\%DIR_ASSETS%\ui\mobile\Fonts.xml
)
echo ----- copy overseas font end -----
echo ---------- integrate res end ----------

set mEndTimeResIntegration=%time%

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
