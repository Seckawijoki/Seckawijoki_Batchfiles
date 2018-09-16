@echo off
chcp 65001
setlocal EnableDelayedExpansion

set count=0
REM set A_DIRS_PROJ_ANDROID_APK_LOAD_0=Proj.Android.Blockark proj.AndroidStudio.Blockark
set A_DIRS_PROJ_ANDROID_APK_LOAD_1=Proj.Android Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniJinliYY Proj.Android.MiniJuFeng Proj.Android.MiniKubi Proj.Android.MiniLeiZheng Proj.Android.MiniMeiTu Proj.Android.MiniNubia Proj.Android.MiniQingNing Proj.Android.MiniSmartisan Proj.Android.MiniWuFan Proj.Android.MiniXianGuo Proj.Android.MiniYDMM Proj.Android.MiniYouFang Proj.Android.MiniYYH Proj.Android.MiniZhongXing
set A_DIRS_PROJ_ANDROID_APK_LOAD_2=Proj.Android.Anzhi Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.Coolpad Proj.Android.Dangle Proj.Android.Egame Proj.Android.Gg Proj.Android.Haixin Proj.Android.Huawei Proj.Android.Iqiyi Proj.Android.Jinli Proj.Android.Jrtt Proj.Android.Lenovo Proj.Android.Leshi Proj.Android.T4399 Proj.Android.Meizu Proj.Android.Mi Proj.Android.Migu Proj.Android.Mumayi Proj.Android.Muzhiwan Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Samsung Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.TianTian Proj.Android.uc Proj.Android.Vivo Proj.Android.Wdj Proj.Android.Wo
set A_DIRS_PROJ_ANDROID_ALL=%A_DIRS_PROJ_ANDROID_APK_LOAD_1% %A_DIRS_PROJ_ANDROID_APK_LOAD_2%


set basepath=f:\trunk\env1\client\AppPlay
f:
cd %basepath%
set filename=AppPlayApplication.java
REM svn --username pengdapu --password seckawijoki9212 cleanup
for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
    if exist %%i\src\org\appplay\lib\%filename% (
        echo %%i\org\appplay\lib\%filename%
        set "filelist=!filelist!*%basepath%\%%i\src\org\appplay\lib\%filename%"
        set /a count=!count!+1
    ) else if exist %%i\src\com\minitech\miniworld\TMobile\%filename% (
        echo %%i\com\minitech\miniworld\TMobile\%filename%
        set "filelist=!filelist!*%basepath%\%%i\src\com\minitech\miniworld\TMobile\%filename%"
        set /a count=!count!+1
    ) else if exist %%i\src\com\minitech\miniworld\%filename% (
        echo %%i\com\minitech\miniworld\%filename%
        set "filelist=!filelist!*%basepath%\%%i\src\com\minitech\miniworld\%filename%"
        set /a count=!count!+1
    )
)
echo Proj.Android.Dangle\src\com\minitech\miniworld\dcn\%filename%
set "filelist=!filelist!*%basepath%\Proj.Android.Dangle\src\com\minitech\miniworld\dcn\%filename%"

echo Proj.Android.Huawei\src\com\minitech\miniworld\huawei\%filename%
set "filelist=!filelist!*%basepath%\Proj.Android.Huawei\src\com\minitech\miniworld\huawei\%filename%"

echo Proj.Android.Migu\src\com\minitech\miniworld\Migu\%filename%
set "filelist=!filelist!*%basepath%\Proj.Android.Migu\src\com\minitech\miniworld\Migu\%filename%"

echo Proj.Android.T4399\src\com\minitech\miniworld\T4399\%filename%
set "filelist=!filelist!*%basepath%\Proj.Android.T4399\src\com\minitech\miniworld\T4399\%filename%"

REM echo proj.AndroidStudio.Blockark\app\src\main\java\org\appplay\lib\%filename%
REM set "filelist=!filelist! proj.AndroidStudio.Blockark\app\src\main\java\org\appplay\lib\%filename%"
set /a count=!count!+4

echo count = !count!
echo.
set filelist=!filelist:~1!
echo !filelist!
REM svn commit !filelist! -m "Commit %filename% in each project."
REM TortoiseProc.exe /command:add /path:"!filelist!"
TortoiseProc.exe /command:commit /path:"!filelist!"