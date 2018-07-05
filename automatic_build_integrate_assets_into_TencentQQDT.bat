@echo off


%DRIVE%
cd %mPathProjAndroidResIntegration%
rem ----------copy resources start----------
if not exist %DIR_ASSETS% (
  mkdir %DIR_ASSETS%
)

echo y | cacls * /p everyone:F

copy %PATH_BIN%\proto_cs.meta %DIR_ASSETS%\proto_cs.meta
copy %PATH_BIN%\proto_hc.meta %DIR_ASSETS%\proto_hc.meta
copy %PATH_BIN%\proto_room.meta %DIR_ASSETS%\proto_room.meta
copy %PATH_BIN%\proto_comm.meta %DIR_ASSETS%\proto_comm.meta
copy %PATH_BIN%\proto_tconn.meta %DIR_ASSETS%\proto_tconn.meta
copy %PATH_BIN%\serverlist.data %DIR_ASSETS%\serverlist.data
copy %PATH_BIN%\serverlist_release.data %DIR_ASSETS%\serverlist_release.data
copy %PATH_BIN%\serverlist_developer.data %DIR_ASSETS%\serverlist_developer.data
copy %PATH_BIN%\serverlist_releasetest.data %DIR_ASSETS%\serverlist_releasetest.data
copy %PATH_BIN%\serverlist_en_test_12.data %DIR_ASSETS%\serverlist_en_test_12.data
copy %PATH_BIN%\serverlist_en_release_10.data %DIR_ASSETS%\serverlist_en_release_10.data
copy %PATH_BIN%\shadercache.key %DIR_ASSETS%\shadercache.key
copy %PATH_BIN%\shadercache_ogl.dat %DIR_ASSETS%\shadercache_ogl.dat
copy %PATH_BIN%\uitexture.ref %DIR_ASSETS%\uitexture.ref
copy %PATH_BIN%\dnsconfig.ini %DIR_ASSETS%\dnsconfig.ini

rem cfg res
if "%mProjType%" == "%PROJ_TYPE_ADT%" (
  echo ----- mProjType == "%PROJ_TYPE_ADT%" -----
  copy %PATH_BIN%\iworld_android.cfg %DIR_ASSETS%\iworld.cfg
  copy %PATH_BIN%\iworld_android_overseas.cfg %DIR_ASSETS%\iworld_overseas.cfg
  copy %PATH_BIN%\iworld_androidbeta.cfg %DIR_ASSETS%\iworld_androidbeta.cfg
  copy %PATH_BIN%\iworld_android_overseasbeta.cfg %DIR_ASSETS%\iworld_android_overseasbeta.cfg
  if defined DEBUG_ECHO (
    echo ----- copy %PATH_BIN%\res\* start -----
    echo a | xcopy /s /e /a /l %PATH_BIN%\res\* %DIR_ASSETS%\
    echo ----- copy %PATH_BIN%\res\* end -----
  ) else (
    echo The copying of "%PATH_BIN%\res\*" under ADT is running...
    echo a | xcopy /s /e /a /q %PATH_BIN%\res\* %DIR_ASSETS%\
  )
 
  if %mApkLoad% == 1 (
    mkdir %PATH_MAKE_WEB%\all\mobileResToload 
    %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %PATH_MAKE_WEB%\all\mobileResToload\%mApkVersionName%
  )

  if %mApkLoad% == 2 (
    mkdir %PATH_MAKE_WEB%\all\mobileResToload 
    %PATH_MAKE_WEB%\all\MobileGameResPatch.exe  %PATH_MAKE_WEB%\all\mobileResToload\%mApkVersionName% 1
  )
  
  cd %DIR_ASSETS%
  copy %PATH_BUILD%\clean_imag_android.bat clean_imag_android.bat
  call clean_imag_android.bat
  cd ..
) else (
  if defined DEBUG_ECHO (
    echo ----- copy %PATH_BIN%\res\* start -----
    echo a | xcopy /s /e /a /l %PATH_BIN%\res\* %DIR_ASSETS%\
    echo ----- copy %PATH_BIN%\res\* end -----
  ) else (
    echo The copying of "%PATH_BIN%\res\*" under other projects is running...
    echo a | xcopy /s /e /a /q %PATH_BIN%\res\* %DIR_ASSETS%\
  )

  set bOverseasTypesMatchesProjectType=
  for %%i in (%OVERSEAS_TYPES%) do if "%%i" == "%mProjType%" set bOverseasTypesMatchesProjectType=1
  
  if defined bOverseasTypesMatchesProjectType (
    echo  mProjType in "%OVERSEAS_TYPES%" 
    echo cfg only iworld_android_overseas.cfg,zhishu ktx only zhishu_m_p1.ktx
    copy %PATH_BIN%\iworld_android_overseas.cfg %DIR_ASSETS%\iworld.cfg
    rem TODO
    rsync /A /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
    copy %DIR_ASSETS%\english\fonts\Fonts.xml %DIR_ASSETS%\ui\mobile\Fonts.xml
  ) else (
    if "%mProjType%" == "%PROJ_TYPE_OVERSEAS_BETA%" (
    echo  mProjType = %PROJ_TYPE_OVERSEAS_BETA%
    echo cfg only iworld_android_overseasbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
    copy %PATH_BIN%\iworld_android_overseasbeta.cfg %DIR_ASSETS%iworld.cfg
    rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
    ) else (
      if "%mProjType%" == "%PROJ_TYPE_MINIBETA%" (
      echo mProjType = %PROJ_TYPE_MINIBETA%"
      echo cfg only iworld_androidbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
      copy %PATH_BIN%\iworld_androidbeta.cfg %DIR_ASSETS%\iworld.cfg
      rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
      ) else (
        echo mProjType = OTHER
        echo no overseas_res,cfg only iworld_android.cfg,zhishu ktx only zhishu_m_p1.ktx
        copy %PATH_BIN%\iworld_android.cfg %DIR_ASSETS%\iworld.cfg
        rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %PATH_BIN%\res\* 
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
 
  cd %DIR_ASSETS%
  if "%mProjType%" == "%PROJ_TYPE_BLOCKARK_IOS_RES%" (
    echo mProjType = %PROJ_TYPE_BLOCKARK_IOS_RES% clean_imag_ios.bat start 
    copy %PATH_BUILD%\clean_imag_ios.bat clean_imag_ios.bat
    call clean_imag_ios.bat
    echo mProjType = %PROJ_TYPE_BLOCKARK_IOS_RES% clean_imag_ios.bat end 
  ) else (
    echo mProjType = %PROJ_TYPE_BLOCKARK_IOS_RES% clean_imag_android.bat start 
    copy %PATH_BUILD%\clean_imag_android.bat clean_imag_android.bat
    call clean_imag_android.bat
    echo mProjType = %PROJ_TYPE_BLOCKARK_IOS_RES% clean_imag_android.bat end 
  )
  cd ..
)

cd %PATH_BIN%\res\csvdef\
if not exist %mPathProjAndroidResIntegration%\%DIR_ASSETS%\csvdef (
  mkdir %mPathProjAndroidResIntegration%\%DIR_ASSETS%\csvdef
)

:: Checkout the existent of some directories with name ending with csv.
for /r %%i in (%PATH_BIN%\res\csvdef\*.csv) do (
  pushd "%%i" 2>nul && ( call :is_a_folder_with_name_ending_with_csv "%%i" & popd ) || call :is_a_csv_file "%%i"
)


:: Go back to the last directory.
cd %mPathProjAndroidResIntegration%

:: ---------- remove unused files start ----------
cd %DIR_ASSETS%
del /q toolres\
mkdir shaders
copy %PATH_BIN%\res\shaders\materials.xml shaders\materials.xml
del /q shaders\*.fx
del /q ui\mobile\texture\bigtex_pc
del /q ui\mobile\texture\uitcomm1
del /q ui\mobile\texture\uitex
del /q ui\mobile\texture\uitex2
del /q ui\mobile\texture\uitex3
del /q ui\mobile\texture\uitex4
del /q ui\mobile\texture\uitpc
del /q ui\mobile\texture\uitpc.png
del /q ui\mobile\texture\uitpc.kte
del /q ui\mobile\texture\uitpc.ktx
del /q ui\mobile\texture\uitpc.pve
del /q ui\mobile\texture\uitpc.pvr
del /q ui\mobile\texture\uipc_alpha.kte
del /q ui\mobile\texture\uipc_alpha.ktx
del /q ui\mobile\texture\uipc.xml
del /q csvdef\translate
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.ktx
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.pvr
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.png
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_p2.ktx
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_p2.pvr
del /q ui\mobile\texture\bigtex_comm\zhishu_pc_p2.png

rd /s /q  csvdef\translate
::-----2018-7-2-----
::rd /s /q entity\player\player12
del /q entity\100040\male.ktx
del /q entity\100040\male.pvr
del /q entity\100041\male.ktx
del /q entity\100041\male.pvr
del /q entity\100042\male.ktx
del /q entity\100042\male.pvr
del /q entity\100043\body.omod
del /q entity\100044\body.omod
del /q entity\100044\male.ktx
del /q entity\100044\male.pvr
del /q entity\100045\body.omod
del /q entity\100045\male.ktx
del /q entity\100045\male.pvr
del /q entity\100046\body.omod
del /q entity\100047\body.omod
del /q entity\100048\body.omod
del /q entity\100049\body.omod
del /q entity\100049\male.ktx
del /q entity\100049\male.pvr
del /q player\player12\7.png*
del /q itemmods\11324\body.omod
del /q itemmods\12006\body.omod
del /q itemmods\12006\body1.omod
del /q itemmods\12006\body2.omod
del /q items\icon258.png
rd /s /q overseas_res
del /q  particles\BUFF_CLASP.emo
del /q  particles\item_4_evaporation.ent
del /q  particles\item_817_extinguish.ent
del /q  particles\item_1045_work.ent
del /q  particles\item_12253_shut.emo
del /q  particles\item_12280_shut.emo
del /q  particles\item_15059_tail.emo
del /q  particles\item_15060_tail.emo
del /q  particles\item_15060_trigger.ent
del /q  particles\item_15064_tail.emo
del /q  particles\item_15065_tail.emo
del /q  particles\item_15066_1.emo
del /q  particles\mob_3103_body.emo
del /q  particles\mob_3103_magic.emo
del /q  particles\rockets_moke.emo
del /q  particles\rocket_prompt.emo
del /q  particles\texture\O2.png
del /q  particles\texture\tielian_01.png
del /q  particles\texture\cloud_02.png
del /q  particles\texture\yun_03.png
rd /s /q shaders\max_shaders
rd /s /q shaders\test
rd /s /q sounds\ent\3103
del /q sounds\ent\3803\countdown.ogg
del /q sounds\ent\3803\warn.ogg
rd /s /q toolres

REM del /q  ui\*.png
REM del /q  ui\aiicons\*.png
REM del /q  ui\bufficons\*.png
REM del /q  ui\cursor\*.png
REM del /q  ui\headframes\*.png
REM del /q  ui\itemexticons\*.png
REM del /q  ui\itemskillicons\*.png
REM del /q  ui\mobile\*.png
REM del /q  ui\mobile\effect\*.png
REM del /q  ui\mobile\texture\*.ktx
REM rd /s /q  ui\mobile\texture\bigtex_pc
REM rd /s /q  ui\mobile\texture\uitcomm1
REM rd /s /q  ui\mobile\texture\uitex
REM rd /s /q  ui\mobile\texture\uitex2
REM rd /s /q  ui\mobile\texture\uitex3
REM rd /s /q  ui\mobile\texture\uitex4
REM rd /s /q  ui\mobile\texture\uitpc
REM del /q  ui\mobile\texture\bigtex_comm\*.png
REM del /q  ui\models\*.png
REM del /q  ui\rideicons\*.png
REM del /q  ui\rideskillicons\*.png
REM del /q  ui\skineffecticons\*.png

del /q  ui\*.pvr
del /q  ui\aiicons\*.pvr
del /q  ui\bufficons\*.pvr
del /q  ui\cursor\*.pvr
del /q  ui\headframes\*.pvr
del /q  ui\itemexticons\*.pvr
del /q  ui\itemskillicons\*.pvr
del /q  ui\mobile\*.pvr
del /q  ui\mobile\texture\*.ktx
del /q  ui\mobile\texture\*.pvr
rd /s /q  ui\mobile\texture\bigtex_pc
rd /s /q  ui\mobile\texture\uitcomm1
rd /s /q  ui\mobile\texture\uitex
rd /s /q  ui\mobile\texture\uitex2
rd /s /q  ui\mobile\texture\uitex3
rd /s /q  ui\mobile\texture\uitex4
rd /s /q  ui\mobile\texture\uitpc
del /q  ui\mobile\texture\bigtex_comm\*.pvr
del /q  ui\models\*.pvr
del /q  ui\rideicons\*.pvr
del /q  ui\rideskillicons\*.pvr
del /q  ui\roleicons\*.pvr
del /q  ui\skineffecticons\*.pvr
cd ..
:: ---------- remove unused files end ----------

mkdir %DIR_ASSETS%\GCloudVoice
copy %DIR_SDK_ASSETS%\GCloudVoice\* %DIR_ASSETS%\GCloudVoice\

for /f "delims=" %%i in ('dir /b %DIR_ASSETS%\csvdef\autogen\*.*') do (
  for /f "delims=" %%j in ('dir /b %DIR_ASSETS%\csvdef\*.*') do (
    if %%~nxi == %%~nxj (
      del /q %%~dpnxj
    )
  )
)
echo ----- copy ucgamesdk start -----
mkdir %DIR_ASSETS%\ucgamesdk\lib
echo a | xcopy /s /e /a /l %PATH_APP_PLAY%\%DIR_PROJ_ANDROID_UC%\%DIR_SDK_ASSETS%\ucgamesdk\lib\* %DIR_ASSETS%\ucgamesdk\lib\
echo ----- copy ucgamesdk end -----


:: ----------copy fonts to overseas project ----------
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
:: ----------copy resources end ----------


::--------------------------------------------------------------- 
::-- Desciption: 
::      If the iterated csv file is a file. 
::-- Param: 
::      the csv file
::-- Global Return: 
::      nul
::--------------------------------------------------------------- 
:is_a_csv_file
if "%~1" == "" goto :eof
iconv -f GBK -t UTF-8 -c %~1> csvdef\%~n1
goto :eof

::--------------------------------------------------------------- 
::-- Desciption: 
::      If the iterated csv file is a directory, the correct logical operation of file cannot be executed. 
::-- Param: 
::      the csv file
::-- Global Return: 
::      nul
::--------------------------------------------------------------- 
:is_a_folder_with_name_ending_with_csv
if "%~1" == "" goto :eof
echo %~n1 is directory, cannot be convert to utf8
goto :eof
