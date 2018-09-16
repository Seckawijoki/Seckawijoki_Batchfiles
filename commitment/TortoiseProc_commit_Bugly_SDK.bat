@echo off
chcp 65001
setlocal EnableDelayedExpansion

REM choice /c:YN /m "上传每个工程的sdklibs\libBugly.so、libs\bugly_crash_release.jar、AndroidManifest.xml和AppPlayApplication.java, Y for sure."
REM if errorlevel 2 ( exit )

REM choice /c:YN /m "确定？Y for sure."
REM if errorlevel 2 ( exit )

set count=0
REM set A_DIRS_PROJ_ANDROID_APK_LOAD_0=Proj.Android.Blockark proj.AndroidStudio.Blockark
set A_DIRS_PROJ_ANDROID_APK_LOAD_1=Proj.Android Proj.Android.Mini Proj.Android.Mini18183 Proj.Android.MiniGGZS Proj.Android.MiniJinliYY Proj.Android.MiniJuFeng Proj.Android.MiniKubi Proj.Android.MiniLeiZheng Proj.Android.MiniMeiTu Proj.Android.MiniNubia Proj.Android.MiniQingNing Proj.Android.MiniSmartisan Proj.Android.MiniWuFan Proj.Android.MiniXianGuo Proj.Android.MiniYDMM Proj.Android.MiniYouFang Proj.Android.MiniYYH Proj.Android.MiniZhongXing
set A_DIRS_PROJ_ANDROID_APK_LOAD_2=Proj.Android.Anzhi Proj.Android.BaiduDK Proj.Android.BaiduSJZS Proj.Android.Coolpad Proj.Android.Dangle Proj.Android.Egame Proj.Android.Gg Proj.Android.Haixin Proj.Android.Huawei Proj.Android.Iqiyi Proj.Android.Jinli Proj.Android.Jrtt Proj.Android.Lenovo Proj.Android.Leshi Proj.Android.T4399 Proj.Android.Meizu Proj.Android.Mi Proj.Android.Migu Proj.Android.Mumayi Proj.Android.Muzhiwan Proj.Android.Oppo Proj.Android.Qihoo Proj.Android.Samsung Proj.Android.SougouLLQ Proj.Android.SougouSJZS Proj.Android.SougouSS Proj.Android.SougouYX Proj.Android.Tencent Proj.Android.TencentQQDT Proj.Android.TianTian Proj.Android.uc Proj.Android.Vivo Proj.Android.Wdj Proj.Android.Wo Proj.Android.MiniBeta
set A_DIRS_PROJ_ANDROID_ALL=%A_DIRS_PROJ_ANDROID_APK_LOAD_1% %A_DIRS_PROJ_ANDROID_APK_LOAD_2%

set basepath=f:\trunk\env1\client\AppPlay
f:
cd %basepath%
set filename=AppPlayApplication.java
REM for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
REM     if exist %%i\src\org\appplay\lib\%filename% (
REM         echo %%i\org\appplay\lib\%filename%
REM         set "filelist=!filelist!*%%i\src\org\appplay\lib\%filename%"
REM         set /a count=!count!+1
REM     ) else if exist %%i\src\com\minitech\miniworld\TMobile\%filename% (
REM         echo %%i\com\minitech\miniworld\TMobile\%filename%
REM         set "filelist=!filelist!*%%i\src\com\minitech\miniworld\TMobile\%filename%"
REM         set /a count=!count!+1
REM     ) else if exist %%i\src\com\minitech\miniworld\%filename% (
REM         echo %%i\com\minitech\miniworld\%filename%
REM         set "filelist=!filelist!*%%i\src\com\minitech\miniworld\%filename%"
REM         set /a count=!count!+1
REM     )
REM )
REM echo Proj.Android.Dangle\src\com\minitech\miniworld\dcn\%filename%
REM set "filelist=!filelist!*Proj.Android.Dangle\src\com\minitech\miniworld\dcn\%filename%"

REM echo Proj.Android.Huawei\src\com\minitech\miniworld\huawei\%filename%
REM set "filelist=!filelist!*Proj.Android.Huawei\src\com\minitech\miniworld\huawei\%filename%"

REM echo Proj.Android.Migu\src\com\minitech\miniworld\Migu\%filename%
REM set "filelist=!filelist!*Proj.Android.Migu\src\com\minitech\miniworld\Migu\%filename%"

REM echo Proj.Android.T4399\src\com\minitech\miniworld\T4399\%filename%
REM set "filelist=!filelist!*Proj.Android.T4399\src\com\minitech\miniworld\T4399\%filename%"

REM REM echo proj.AndroidStudio.Blockark\app\src\main\java\org\appplay\lib\%filename%
REM REM set "filelist=!filelist! proj.AndroidStudio.Blockark\app\src\main\java\org\appplay\lib\%filename%"
REM set /a count=!count!+4

for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
    if not exist %%i\sdklibs\ (
        mkdir %%i\sdklibs\
    )
    set "filelist=!filelist!*%%i\sdklibs"
    if not exist %%i\sdklibs\libBugly.so copy f:\libBugly.so %%i\sdklibs\libBugly.so
    echo %%i\sdklibs\libBugly.so
    set "filelist=!filelist!*%%i\sdklibs\libBugly.so"
    set /a count=!count!+1
)

for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
    if not exist %%i\libs\ (
        mkdir %%i\libs\
        set "filelist=!filelist!*%%i\libs"
    )
    if not exist %%i\libs\bugly_crash_release.jar copy f:\bugly_crash_release.jar %%i\libs\bugly_crash_release.jar
    echo %%i\libs\bugly_crash_release.jar
    set "filelist=!filelist!*%%i\libs\bugly_crash_release.jar"
    set /a count=!count!+1
)

REM for %%i in (%A_DIRS_PROJ_ANDROID_ALL%) do (
REM     echo %%i\AndroidManifest.xml
REM     set "filelist=!filelist!*%%i\AndroidManifest.xml"
REM     set /a count=!count!+1
REM )

echo count = !count!
echo.
set filelist=!filelist:~1!
echo !filelist!
TortoiseProc.exe /command:add /path:"!filelist!"
TortoiseProc.exe /command:commit /path:"!filelist!"
REM svn commit !filelist! -m "Commit %filename% in each project."