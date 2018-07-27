@echo off

%DRIVE%
cd %mPathProjAndroidAssetsIntegration%

set mStartTimeAssetsIntegration=%time%
rem ---------- configure mProjType ---------- 
set mProjType=%PROJ_TYPE_ADT%
if "!mDirCurrentProjAndroid!" == "%DIR_PROJ_ANDROID_BLOCKARK_IOS_RES%" set mProjType=%PROJ_TYPE_OVERSEAS%
if "!mDirCurrentProjAndroid!" == "%DIR_PROJ_ANDROID_MINIBETA%" set mProjType=%PROJ_TYPE_MINIBETA%
if "!mDirCurrentProjAndroid!" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" set mProjType=%PROJ_TYPE_OVERSEAS%
if "!mDirCurrentProjAndroid!" == "%DIR_PROJ_ANDROID_TENCENT_QQDT%" set mProjType=%PROJ_TYPE_TENCENT_QQDT%

echo ----- delete original assets start -----
if "%mPathProjAndroidAssetsIntegration%" == "%mPathCurrentProjAndroid%" (
  set pathDeleteAssets=%mPathProjAndroidAssetsIntegration%\%DIR_ASSETS%
) else (
  set pathDeleteAssets=%mPathCurrentProjAndroid%\%DIR_ASSETS%
)
if not defined mRemainPreviousAssets if exist %pathDeleteAssets% del /s /q %pathDeleteAssets%\*
if not exist %pathDeleteAssets% mkdir %pathDeleteAssets%\
echo ----- delete original assets end -----

echo ----- copy ini, meta, data, key, dat, ref files start -----
copy %PATH_BIN%\dnsconfig.ini !mPathCurrentProjAndroid!\%DIR_ASSETS%\dnsconfig.ini
copy %PATH_BIN%\proto_comm.meta !mPathCurrentProjAndroid!\%DIR_ASSETS%\proto_comm.meta
copy %PATH_BIN%\proto_cs.meta !mPathCurrentProjAndroid!\%DIR_ASSETS%\proto_cs.meta
copy %PATH_BIN%\proto_hc.meta !mPathCurrentProjAndroid!\%DIR_ASSETS%\proto_hc.meta
copy %PATH_BIN%\proto_room.meta !mPathCurrentProjAndroid!\%DIR_ASSETS%\proto_room.meta
copy %PATH_BIN%\proto_tconn.meta !mPathCurrentProjAndroid!\%DIR_ASSETS%\proto_tconn.meta
copy %PATH_BIN%\serverlist.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist.data
copy %PATH_BIN%\serverlist_developer.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist_developer.data
copy %PATH_BIN%\serverlist_en_test_12.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist_en_test_12.data
copy %PATH_BIN%\serverlist_en_release_10.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist_en_release_10.data
copy %PATH_BIN%\serverlist_release.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist_release.data
copy %PATH_BIN%\serverlist_releasetest.data !mPathCurrentProjAndroid!\%DIR_ASSETS%\serverlist_releasetest.data
copy %PATH_BIN%\shadercache.key !mPathCurrentProjAndroid!\%DIR_ASSETS%\shadercache.key
copy %PATH_BIN%\shadercache_ogl.dat !mPathCurrentProjAndroid!\%DIR_ASSETS%\shadercache_ogl.dat
copy %PATH_BIN%\uitexture.ref !mPathCurrentProjAndroid!\%DIR_ASSETS%\uitexture.ref
copy %PATH_MAKE_WEB%\all\mobileResToLoad\%mApkVersionName%\md5filesdata.dat %DIR_ASSETS%\md5filesdata.dat 
echo ----- copy ini, meta, data, key, dat, ref files end -----

echo ----- copy cfg files start -----
set bProjTypeMatched=
if "%mProjType%" == "%PROJ_TYPE_ADT%" (
  echo ----- mProjType == ADT -----
  copy %PATH_BIN%\iworld_android.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
  REM copy %PATH_BIN%\iworld_android_overseas.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld_overseas.cfg
  REM copy %PATH_BIN%\iworld_androidbeta.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld_androidbeta.cfg
  REM copy %PATH_BIN%\iworld_android_overseasbeta.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld_android_overseasbeta.cfg
  set bProjTypeMatched=1
) 
set bOverseasTypesMatchesProjectType=
for %%i in (%A_DIRS_OVERSEAS_PROJ_ANDROID%) do if "%%i" == "!mDirCurrentProjAndroid!" set bOverseasTypesMatchesProjectType=1
if defined bOverseasTypesMatchesProjectType (
  echo mProjType in "A_DIRS_OVERSEAS_PROJ_ANDROID" 
  echo cfg only iworld_android_overseas.cfg,zhishu ktx only zhishu_m_p1.ktx
  copy %PATH_BIN%\iworld_android_overseas.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
  copy %DIR_ASSETS%\english\fonts\Fonts.xml !mPathCurrentProjAndroid!\%DIR_ASSETS%\ui\mobile\Fonts.xml
  del /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\zhishu_m_47_p3.*
  set bProjTypeMatched=1
) 
if "%mProjType%" == "%PROJ_TYPE_OVERSEAS_BETA%" (
  echo mProjType = %PROJ_TYPE_OVERSEAS_BETA%
  echo cfg only iworld_android_overseasbeta.cfg, zhishu ktx only zhishu_m_p1.ktx
  copy %PATH_BIN%\iworld_android_overseasbeta.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
  rd /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\overseas_res
  del /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\zhishu_m_47_p3.*
  set bProjTypeMatched=1
) 
if "%mProjType%" == "%PROJ_TYPE_MINIBETA%" (
  echo mProjType = %PROJ_TYPE_MINIBETA%
  echo cfg only iworld_androidbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
  copy %PATH_BIN%\iworld_androidbeta.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
  rd /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\overseas_res
  del /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\zhishu_m_47_p3.*
  set bProjTypeMatched=1
)
if "%mProjType%" == "%PROJ_TYPE_TENCENT_QQDT%" (
  echo  mProjType = %PROJ_TYPE_TENCENT_QQDT%
  echo zhishu ktx add zhishu_m_47_p3.ktx zhishu_m_47_p3_alpha.ktx
  rd /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\overseas_res
  del /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\zhishu_m_47_p3.*
  copy %PATH_BIN%\iworld_android.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
  copy %PATH_BIN%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx !mPathCurrentProjAndroid!\%DIR_ASSETS%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx
  copy %PATH_BIN%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx !mPathCurrentProjAndroid!\%DIR_ASSETS%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx
  set bProjTypeMatched=1
)
if not defined bProjTypeMatched (
  echo mProjType = OTHER
  echo no overseas_res,cfg only iworld_android.cfg,zhishu ktx only zhishu_m_p1.ktx
  rd /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\overseas_res
  del /s /q !mPathCurrentProjAndroid!\%DIR_ASSETS%\zhishu_m_47_p3.*
  copy %PATH_BIN%\iworld_android.cfg !mPathCurrentProjAndroid!\%DIR_ASSETS%\iworld.cfg
)
echo ----- copy cfg files end -----
