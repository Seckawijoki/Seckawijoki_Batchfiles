@echo off
chcp 65001
setlocal EnableDelayedExpansion

choice /c:YN /m "上传每个工程的SplashScreenActivity.java及相应渠道的闪屏Activity, Y for sure."
if errorlevel 2 ( exit )

choice /c:YN /m "确定？Y for sure."
if errorlevel 2 ( exit )

set "arrayFileList=!arrayFileList! Proj.Android.Anzhi\src\com\minitech\miniworld\anzhiSplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Anzhi\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.Egame\src\com\minitech\miniworld\EgameScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Egame\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.Gg\src\com\minitech\miniworld\GgScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Gg\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.Iqiyi\src\com\minitech\miniworld\IqiyiScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Iqiyi\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.Jrtt\src\com\minitech\miniworld\JrttScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Jrtt\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.Lenovo\src\com\minitech\miniworld\SplashActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Lenovo\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.SougouLLQ\src\com\minitech\miniworld\SougouScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.SougouLLQ\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.SougouSJZS\src\com\minitech\miniworld\SougouScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.SougouSJZS\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.SougouSS\src\com\minitech\miniworld\SougouScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.SougouSS\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.SougouYX\src\com\minitech\miniworld\SougouScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.SougouYX\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.T4399\src\com\minitech\miniworld\M4399ScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.T4399\src\com\minitech\miniworld\SplashScreenActivity.java"

set "arrayFileList=!arrayFileList! Proj.Android.BaiduDK\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.BaiduSJZS\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Coolpad\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Dangle\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Haixin\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Huawei\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Jinli\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Leshi\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Meizu\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Mi\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Migu\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Mini18183\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniBeta\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniGGZS\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniJinliYY\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniJuFeng\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniKubi\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniLeiZheng\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniMeiTu\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniNubia\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniQingNing\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniSmartisan\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniWuFan\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniXianGuo\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniYDMM\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniYouFang\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniYYH\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.MiniZhongXing\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Mumayi\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Muzhiwan\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Oppo\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Qihoo\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Samsung\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Tencent\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.TencentQQDT\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.TianTian\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.uc\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Vivo\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Wdj\src\com\minitech\miniworld\SplashScreenActivity.java"
set "arrayFileList=!arrayFileList! Proj.Android.Wo\src\com\minitech\miniworld\SplashScreenActivity.java"

set count=0
f:
cd trunk\env1\client\AppPlay
for %%i in (!arrayFileList!) do (
  echo %%i
  set /a count=!count!+1
)
echo count = !count!
echo.
echo !filelist!
echo svn cleanup
svn --username pengdapu --password seckawijoki9212 cleanup
echo svn commit
svn commit !arrayFileList! -m "After minibox's downloading maps, play standalone game by calling miniworld."
pause