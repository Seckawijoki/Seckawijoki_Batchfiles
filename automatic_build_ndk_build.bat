::
@echo off

rem ---------- [abi type] Compile thumb sequences ----------
REM LOCAL_STATIC_LIBRARIES := OgreMain
REM LOCAL_STATIC_LIBRARIES += raknet
REM LOCAL_STATIC_LIBRARIES += ssl
REM LOCAL_STATIC_LIBRARIES += crypto
REM LOCAL_STATIC_LIBRARIES += websockets
REM LOCAL_STATIC_LIBRARIES += libwebp
REM LOCAL_STATIC_LIBRARIES += libprotobuf
REM LOCAL_SHARED_LIBRARIES  := fmod
REM LOCAL_SHARED_LIBRARIES += libGCloudVoice
REM LOCAL_SHARED_LIBRARIES += libcubehawk

%DRIVE%

rem --------- UITolua.pkg ----------
cd %PATH_OGRE_MAIN%\UILib
%PATH_BUILD%\tolua++.exe -o  UITolua.cpp UITolua.pkg
echo ---------- build UITolua.pkg finished ----------

rem --------- ClientToLuaM.pkg ----------
cd %PATH_IWORLD%
%PATH_BUILD%\tolua++.exe -o ClientToLua.cpp ClientToLuaM.pkg
echo ---------- build ClientToLuaM.pkg finished ----------

rem ---------- ndk-build start -----------
cd %mPathProjAndroidNdkBuild%

if not defined mRemainPreviousSoFiles if exist obj\local\%mNdkBuildAbi% del /s /q obj\local\%mNdkBuildAbi%\*

set fileAndroidMk=Android_without_upward_path.mk
if not exist jni\%fileAndroidMk% copy %PATH_AUTOMATIC_BUILD%\%DIR_SUB_FILES%\%fileAndroidMk% jni\%fileAndroidMk%


set engineRootLocal=%DRIVE%/%DIR_TRUNK%/%DIR_ENV_1%/%DIR_CLIENT%
set ndkModulePath=%DRIVE%/%DIR_TRUNK%/%DIR_ENV_1%/%DIR_CLIENT%
echo ---------- ndk-build start -----------
set mStartTimeNdkBuild=%time%
set bNdkBuildFinished=false
%PATH_NDK_BUILD_CMD% NDK_PROJECT_PATH=. NDK_LIBS_OUT=%DIR_NDK_BUILD_OUT% APP_BUILD_SCRIPT:=jni/%fileAndroidMk% NDK_APPLICATION_MK=jni/Application.mk ENGINE_ROOT_LOCAL=%engineRootLocal% NDK_MODULE_PATH=%ndkModulePath% APP_ABI:=%mNdkBuildAbi% APP_SHORT_COMMANDS:=true
set bNdkBuildFinished=true
rem --------- ndk-build end ----------
rem  Do not do anything after ndk build in this batch script.  -- by Author


