@echo off
rem ---------- Deprecated ----------

echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_PRODUCE_ALL_BATCHES% > %PATH_AUTOMATIC_BUILD%\生成人工脚本.bat

echo %PATH_AUTOMATIC_BUILD%\automatic_build_entrance.bat %DIR_TRUNK% %DIR_ENV_1% %mPathNdkBuildCmd% %mNdkBuildAbi% %mApkVersionName% %AUTOMATIC_BUILD_CREATE_BATCHES_IN_EACH_PROJECT% > %PATH_AUTOMATIC_BUILD%\每个项目生成3个脚本.bat