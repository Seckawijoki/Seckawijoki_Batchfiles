@echo off

if not exist %DRIVE%\%DIR_OUTPUT% mkdir %DRIVE%\%DIR_OUTPUT%
if not exist %DRIVE%\%DIR_OUTPUT%\so mkdir %DRIVE%\%DIR_OUTPUT%\so
if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%

cd %PATH_APP_PLAY%\%DIR_BACKUP%

set currentHour=%time:~0,2%
set projectName=%mDirCurrentProjAndroid:~13%
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID%" set projectName=ProjAndroid
if "%mDirCurrentProjAndroid%" == "%DIR_PROJ_ANDROID_STUDIO_BLOCKARK%" set projectName=AndroidStudioBlockark
echo projectName = %projectName%
if %currentHour% lss 10 (
  rem set dirBackupNdkBuild=NDK_build_%mDirCurrentProjAndroid%_%mNdkBuildAbi%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%0%time:~1,1%-%time:~3,2%-%time:~6,2%.%time:~9,2%
  set dirBackupNdkBuild=so_%projectName%_%mNdkBuildAbi%_%date:~3,4%%date:~8,2%%date:~11,2%_0%time:~1,1%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
) else (
  rem set dirBackupNdkBuild=NDK_build_%mDirCurrentProjAndroid%_%mNdkBuildAbi%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%%time:~0,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%
  set dirBackupNdkBuild=so_%projectName%_%mNdkBuildAbi%_%date:~3,4%%date:~8,2%%date:~11,2%_%time:~0,2%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
)

echo dirBackupNdkBuild = %dirBackupNdkBuild%

mkdir %dirBackupNdkBuild%
mkdir %dirBackupNdkBuild%\libs
mkdir %dirBackupNdkBuild%\libs\%mNdkBuildAbi%
rem mkdir %PATH_APP_PLAY%\%DIR_BACKUP%\%dirBackupNdkBuild%\obj_local_%mNdkBuildAbi% 

if "%mPathProjAndroidNdkBuild%" == "" (
  set mPathProjAndroidNdkBuild=%mPathCurrentProjAndroid%
)

echo ----- backup %mDirCurrentProjAndroid% so files start -----
copy %mPathProjAndroidNdkBuild%\%DIR_NDK_BUILD_OUT%\%mNdkBuildAbi%\*  %dirBackupNdkBuild%\libs\%mNdkBuildAbi%\
echo ----- backup %mDirCurrentProjAndroid% so files end -----

echo ----- 7-zip %mDirCurrentProjAndroid% so files in backup start -----
7z a -mx9 %dirBackupNdkBuild%.7z %dirBackupNdkBuild%
echo ----- 7-zip %mDirCurrentProjAndroid% so files in backup end -----

copy %dirBackupNdkBuild%.7z %DRIVE%\%DIR_OUTPUT%\so\%dirBackupNdkBuild%.7z
echo a | xcopy /a /s /e /q %mPathProjAndroidNdkBuild%\obj\local\%mNdkBuildAbi%\* %dirBackupNdkBuild%\obj_local_%mNdkBuildAbi%\