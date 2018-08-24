@echo off

echo ----- copy overseas font start -----
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_BLOCKARK_IOS_RES%" ( 
  copy %PATH_BIN%\res\overseas_res\english\fonts\Fonts.xml %mPathCurrentProjAndroid%\%DIR_ASSETS%\ui\mobile\Fonts.xml
)

if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" ( 
  copy %PATH_BIN%\res\overseas_res\english\fonts\Fonts.xml %mPathCurrentProjAndroid%\%DIR_ASSETS%\ui\mobile\Fonts.xml
)
echo ----- copy overseas font end -----

echo ----- copy sdkassets start -----
if exist %mPathCurrentProjAndroid%\sdkassets echo a | xcopy /s /e /a /c /q %mPathCurrentProjAndroid%\sdkassets\* %mPathCurrentProjAndroid%\%DIR_ASSETS%\
echo ----- copy sdkassets end -----

echo ----- copy sdklibs start -----
if exist %mPathCurrentProjAndroid%\sdklibs echo a | xcopy /s /e /a /c /q %mPathCurrentProjAndroid%\sdklibs\* %mPathCurrentProjAndroid%\libs\
echo ----- copy sdklibs end -----
set mEndTimeAssetsIntegration=%time%
