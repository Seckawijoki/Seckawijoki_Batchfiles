@echo off
echo ---------- ndk-build end -----------
set mEndTimeNdkBuild=%time%

if not exist %mPathCurrentProjAndroid%\libs\%mNdkBuildAbi% mkdir %mPathCurrentProjAndroid%\libs\%mNdkBuildAbi%

echo ----- copy so files to %mDirCurrentProjAndroid%\libs start -----
copy %mPathProjAndroidNdkBuild%\%DIR_NDK_BUILD_OUT%\%mNdkBuildAbi%\* %mPathCurrentProjAndroid%\libs\%mNdkBuildAbi%
echo ----- copy so files to %mDirCurrentProjAndroid%\libs end -----