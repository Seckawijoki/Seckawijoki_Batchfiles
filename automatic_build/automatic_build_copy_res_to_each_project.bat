@echo off

echo ----- copy assets to %mPathCurrentProjAndroid% start -----
if  not "%mPathProjAndroidAssetsCopying%" == "%mPathCurrentProjAndroid%" (
  echo a | xcopy /s /e /a /q %mPathProjAndroidAssetsCopying%\%DIR_ASSETS%\* %mPathCurrentProjAndroid%\%DIR_ASSETS%\ 
)
echo ----- copy assets to %mPathCurrentProjAndroid% end -----

:: ---------- Test ----------
:: ---------- copy assets to MiniBeta ----------
if defined seckawijoki (
  rd /s /q %PATH_PROJ_ANDROID_MINIBETA%\%DIR_ASSETS%
  mkdir %PATH_PROJ_ANDROID_MINIBETA%\%DIR_ASSETS% 
  echo ----- copy assets to MiniBeta start -----
  echo a | xcopy /s /e /a /q %mPathProjAndroidAssetsCopying%\%DIR_ASSETS%\* %PATH_PROJ_ANDROID_MINIBETA%\%DIR_ASSETS%\ 
  echo ----- copy assets to MiniBeta end -----
)


