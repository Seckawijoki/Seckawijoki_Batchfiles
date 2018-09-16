@echo off
setlocal EnableDelayedExpansion
set A_DIRS_PROJ_ANDROID_APK_LOAD_0=Proj.Android.Blockark Proj.Android.BlockarkIosRes
set A_DIRS_PROJ_ANDROID_APK_LOAD_1=Proj.Android Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniJinliYY Proj.Android.MiniJuFeng Proj.Android.MiniKubi Proj.Android.MiniLeiZheng Proj.Android.MiniMeiTu Proj.Android.MiniNubia Proj.Android.MiniQingNing Proj.Android.MiniSmartisan Proj.Android.MiniWuFan Proj.Android.MiniXianGuo Proj.Android.MiniYDMM Proj.Android.MiniYouFang Proj.Android.MiniYYH Proj.Android.MiniZhongXing
set A_DIRS_PROJ_ANDROID_APK_LOAD_2=Proj.Android.Anzhi Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.Coolpad Proj.Android.Dangle Proj.Android.Egame Proj.Android.Gg Proj.Android.Haixin Proj.Android.Huawei Proj.Android.Iqiyi Proj.Android.Jinli Proj.Android.Jrtt Proj.Android.Lenovo Proj.Android.Leshi Proj.Android.T4399 Proj.Android.Meizu Proj.Android.Mi Proj.Android.Migu Proj.Android.Mumayi Proj.Android.Muzhiwan Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Samsung Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.TianTian Proj.Android.uc Proj.Android.Vivo Proj.Android.Wdj Proj.Android.Wo
set A_DIRS_PROJ_ANDROID_ALL=%A_DIRS_PROJ_ANDROID_APK_LOAD_1% %A_DIRS_PROJ_ANDROID_APK_LOAD_2%

f:
cd trunk\env1\client\AppPlay
REM set filename=Android_without_upward_path.mk
set filename=Android.mk
svn --username pengdapu --password seckawijoki9212 cleanup
for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
    set currentPath=%%i
    REM copy ApkBuilderScripts\automatic_build\sub_files\%filename% %%i\jni\%filename%
    REM copy f:\%filename% %%i\jni\%filename%
    echo %%i\jni\%filename%
    set "filelist=!filelist! %%i\jni\%filename%"
    REM svn delete %%i\jni\%filename%
)
set "filelist=!filelist! proj.AndroidStudio.Blockark\app\src\main\jni\%filename%"
echo.
echo !filelist!
REM svn commit !filelist! -m "Delete %filename% in each project."
pause