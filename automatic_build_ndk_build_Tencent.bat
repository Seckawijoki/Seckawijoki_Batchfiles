::
@echo off

:: Manually change the variable below.
set mDirCurrentBuildProject=%DIR_PROJ_ANDROID_TENCENT%
set mPathCurrentBuildProject=%PATH_PROJ_ANDROID_TENCENT%

%DRIVE%
cd %PATH_IWORLD%
:: --------- ndk-build start ----------
%PATH_BUILD%\tolua++.exe -o ClientToLua.cpp ClientToLuaM.pkg

cd %mPathProjAndroidNdkBuild%
if "%mPathNdkBuildCmd%" == "" (
  set mPathNdkBuildCmd=C:\android-ndk-r10e\ndk-build.cmd
)
if "%mNDKBuildApi%" == "" (
  set mNDKBuildApi=armeabi
)
%mPathNdkBuildCmd% NDK_PROJECT_PATH=. NDK_LIBS_OUT=jniLibs APP_BUILD_SCRIPT:=jni/Android_without_upward_path.mk NDK_APPLICATION_MK=jni/Application.mk ENGINE_ROOT_LOCAL=%DRIVE%/%DIR_ENV_1%/%DIR_CLIENT% NDK_MODULE_PATH=%DRIVE%/%DIR_ENV_1%/%DIR_CLIENT% APP_ABI:=%mNDKBuildApi% APP_SHORT_COMMANDS:=true
:: --------- ndk-build end ----------

:: --------- copy so file to the Proj.Android ----------
if not exist %mPathProjAndroidNdkBuild%\libs\%mNDKBuildApi% (
  mkdir %mPathProjAndroidNdkBuild%\libs\%mNDKBuildApi%
)
echo ----- copy so files to %mPathCurrentProjAndroid% start -----
copy obj\%mNDKBuildApi%\* %mPathCurrentProjAndroid%\libs\%mNDKBuildApi%\
echo ----- copy so files to %mPathCurrentProjAndroid% end -----


:: --------- copy so file to MiniBeta ----------
if defined seckawijoki (
  if not exist %mPathProjAndroidNdkBuild%\libs\%mNDKBuildApi% (
    mkdir %mPathProjAndroidNdkBuild%\libs\%mNDKBuildApi%
  )
  echo ----- copy so files to MiniBeta start -----
  copy obj\%mNDKBuildApi%\* %mPathProjAndroidNdkBuild%\libs\%mNDKBuildApi%\
  echo ----- copy so files to MiniBeta end -----
)
