@echo off
set mStartTimeBuildApk=%time%

if not exist %DRIVE%\%DIR_OUTPUT%\apk mkdir %DRIVE%\%DIR_OUTPUT%\apk

cd %mPathCurrentProjAndroid%

set batchAnt=d:\adt-bundle-windows-x86_64-20140321\ant\bin\ant
set batchAndroid=d:\adt-bundle-windows-x86_64-20140321\sdk\tools\android
set exeAapt=d:\adt-bundle-windows-x86_64-20140321\sdk\build-tools\android-4.4.2\aapt
set jarAndroid=D:\adt-bundle-windows-x86_64-20140321\sdk\platforms\android-19\android.jar
set projectName=%mDirCurrentProjAndroid%

rem set androidVersion=%5%
rem set androidVersion=android-25
if "%androidVersion%"=="android-25" ( set androidId=android-25 ) else ( set androidId=android-19 )
if "%androidVersion%"=="android-25" (
  set batchAndroid=E:\\Android\\sdk\\tools\android
) else ( 
  set batchAndroid=d:\adt-bundle-windows-x86_64-20140321\sdk\tools\android
)

rem call %exeAapt% p -f -m -J gen -S res -I %jarAndroid% -M AndroidManifest.xml

copy %PATH_APP_PLAY%\ApkBuilderScripts\scripts\* %mPathCurrentProjAndroid%\
call %batchAndroid% update project --name %projectName% --path %mPathCurrentProjAndroid% --subprojects --target %androidId%

del /q bin\%projectName%-release.apk
del /q bin\%projectName%-release-unsigned.apk
del /q bin\%projectName%-release-unaligned.apk
del /F /S /Q bin\*
del /F /S /Q gen\*
call %batchAnt% release

set currentHour=%time:~0,2%
if %currentHour% lss 10 (
  set apkFileName=%mDirCurrentProjAndroid%_%date:~3,4%%date:~8,2%%date:~11,2%_0%time:~1,1%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
) else (
  set apkFileName=%mDirCurrentProjAndroid%_%date:~3,4%%date:~8,2%%date:~11,2%_%time:~0,2%%time:~3,2%%time:~6,2%_%mApkVersionName%_%DIR_ENV_1%
)

echo ----- copy %projectName%-release.apk to %DIR_BACKUP%\apk ----- 
mkdir %DRIVE%\%DIR_OUTPUT%\apk\%apkFileName%

cd bin
if exist %projectName%-release.apk copy %projectName%-release.apk %DRIVE%\%DIR_OUTPUT%\apk\%apkFileName%\%projectName%.apk

if not exist %PATH_APP_PLAY%\%DIR_BACKUP% mkdir %PATH_APP_PLAY%\%DIR_BACKUP%
if exist %projectName%-release.apk copy %projectName%-release.apk %PATH_APP_PLAY%\%DIR_BACKUP%\%apkFileName%.apk

REM if exist %projectName%-release.apk copy %projectName%-release.apk %PATH_APP_PLAY%\%DIR_BACKUP%\%apkFileName%-release.apk
REM if exist %projectName%-release-unsigned.apk copy %projectName%-release-unsigned.apk %PATH_APP_PLAY%\%DIR_BACKUP%\%apkFileName%-release-unsigned.apk
REM if exist %projectName%-release-unaligned.apk copy %projectName%-release-unaligned.apk %PATH_APP_PLAY%\%DIR_BACKUP%\%apkFileName%-release-unaligned.apk

set mEndTimeBuildApk=%time%