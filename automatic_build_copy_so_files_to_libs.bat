@echo off
echo ---------- ndk-build end -----------
set mEndTimeNdkBuild=%time%

mkdir %mPathCurrentProjAndroid%\libs\%mNDKBuildApi%

echo ----- copy so files to %mDirCurrentProjAndroid%\libs start -----
copy %mPathProjAndroidNdkBuild%\%DIR_NDK_BUILD_OUT%\%mNDKBuildApi%\* %mPathCurrentProjAndroid%\libs\%mNDKBuildApi%
echo ----- copy so files to %mDirCurrentProjAndroid%\libs end -----