@echo off

set currentHour=%time:~0,2%
if %currentHour% lss 10 (
  set dirBackupNdkBuild=NDK_build_%mDirCurrentProjAndroid%_%mNDKBuildApi%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%0%time:~1,1%-%time:~3,2%-%time:~6,2%.%time:~9,2%
) else (
  set dirBackupNdkBuild=NDK_build_%mDirCurrentProjAndroid%_%mNDKBuildApi%_%date:~0,4%-%date:~5,2%-%date:~8,2%%date:~11,2%%time:~0,2%-%time:~3,2%-%time:~6,2%.%time:~9,2%
)
echo dirBackupNdkBuild = %dirBackupNdkBuild%

if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%
mkdir %PATH_APP_PLAY%\%DIR_BACKUP%\%dirBackupNdkBuild%

echo ----- copy %mDirCurrentProjAndroid% so files to backup start -----
copy %mPathProjAndroidNdkBuild%\%DIR_NDK_BUILD_OUT%\%mNDKBuildApi%\* %PATH_APP_PLAY%\%DIR_BACKUP%\%dirBackupNdkBuild%
echo ----- copy %mDirCurrentProjAndroid% so files to backup end -----