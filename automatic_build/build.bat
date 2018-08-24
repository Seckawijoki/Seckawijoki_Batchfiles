@echo on
setlocal EnableDelayedExpansion
set ENGIN_SVN_ROOT=%1%
set PROJ_TYPE=%2%
set PROJ_NAME=%3%
set APK_RELEASE=%4%
rem set NDK_ROOT_LOCAL=%5%
set PWD=%~dp0
rem set BAK_CURDIR=%6%
rem set %CYGWIN%=
set APK_VERSION_NAME=%7
:: set APK_CONFUSE=%8
set APK_LOAD=1
set APK_LOAD=2
 

echo %ENGIN_SVN_ROOT%

set ENGINE_ROOT_LOCAL=%ENGIN_SVN_ROOT%\client
set APPPLAY_MYAPP_BIN_ROOT_LOCAL=%ENGIN_SVN_ROOT%\bin
echo Proj: %PROJ_NAME%
set APPPLAY_MYAPP_ANDROID_ROOT=%ENGINE_ROOT_LOCAL%\AppPlay\%PROJ_NAME%
set ASSETS_DIR=assets
set SDK_ASSETS_ROOT=%APPPLAY_MYAPP_ANDROID_ROOT%\sdkassets
set SDK_LIBS_ROOT=%APPPLAY_MYAPP_ANDROID_ROOT%\sdklibs

set PROJ_ROOTS=%ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Huawei %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Migu %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Wo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Egame %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.uc %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.T4399 %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Anzhi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Baidu %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.BaiduDK %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.BaiduSJZS %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.BaiduTB %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Lenovo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Meizu %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Mi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Oppo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Qihoo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Tencent %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.TencentQQDT %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Muzhiwan %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Jinli %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Mumayi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Wdj %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Coolpad %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Vivo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Leshi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.SougouLLQ %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.SougouSJZS %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.SougouSRF %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.SougouSS %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.SougouYX %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Google %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Dianyou %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Samsung %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Haixin %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.TencentAce %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Kuaifa %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Blockark %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.TianTian %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.x7sy %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Dangle %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Gg %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Iqiyi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Jrtt %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Mini %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniQingCheng   %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniJieKu %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniJuFeng %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniLeiZheng %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniSmartisan %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniYouFang %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniNubia %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniKubi %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniBeta %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniZhongXing %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniYYH %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniYDMM %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniMeiTu %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniQingNing %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Mini18183 %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniGGZS %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniDuoWan %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniJinliYY %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniXianGuo %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniWuFan

set OVERSEAS_PROJ_ROOTS=%ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Google %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.Blockark
set BETA_PROJ_ROOTS=%ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.MiniBeta
set TencentQQDT_PROJ_ROOTS=%ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.TencentQQDT
set IOSRES_PROJ_ROOTS=%ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android.BlockarkIosRes
set OVERSEAS_TYPES=GOOGLE BLOCKARK BLOCKARKIOSRES

rem echo 1: %APPPLAY_MYAPP_ANDROID_ROOT%
rem system
set SYSTEM_NAME=%CYGWIN%
set EXE_SUFFIX=.exe
set ARCH_SUFFIX=_32
echo system: %SYSTEM_NAME% arch: %ARCH_SUFFIX%

rem tolua
set OLDDIR=%~dp0
cd %ENGINE_ROOT_LOCAL%\OgreMain\UILib
..\..\..\build\tolua++%EXE_SUFFIX% -o UITolua.cpp UITolua.pkg

cd %ENGINE_ROOT_LOCAL%\iworld
..\..\build\tolua++%EXE_SUFFIX% -o ClientToLua.cpp ClientToLuaM.pkg

cd %OLDDIR%

rem clear and make dir
if exist %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR% (
 rd /s /q %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%
)

rem copy resources
md %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%

echo y | cacls %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR% /p everyone:F

copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\proto_cs.meta %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\proto_cs.meta
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\proto_hc.meta %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\proto_hc.meta
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\proto_room.meta %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\proto_room.meta
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\proto_comm.meta %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\proto_comm.meta
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\proto_tconn.meta %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\proto_tconn.meta
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist_release.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist_release.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist_developer.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist_developer.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist_releasetest.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist_releasetest.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist_en_test_12.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist_en_test_12.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\serverlist_en_release_10.data %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\serverlist_en_release_10.data
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\shadercache.key %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\shadercache.key
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\shadercache_ogl.dat %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\shadercache_ogl.dat
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\uitexture.ref %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\uitexture.ref
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\dnsconfig.ini %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\dnsconfig.ini

rem cfg res
if "%PROJ_TYPE%" equ "ADT" do (
 echo all res
 copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld.cfg
 copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android_overseas.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld_overseas.cfg
 copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_androidbeta.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld_androidbeta.cfg
 copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android_overseasbeta.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld_android_overseasbeta.cfg
 copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
 
  if %APK_LOAD% equ 1 (
    md %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload 
    %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\MobileGameResPatch.exe %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload\%APK_VERSION_NAME%
  )
  if %APK_LOAD% equ 2 (
    md %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload 
    %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\MobileGameResPatch.exe %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload\%APK_VERSION_NAME% 1
  )
 
 set OLDDIR=%PWD%
 cd %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%
 call ..\..\..\..\build\clean_imag_android.bat
 cd %OLDDIR%
) else (

 set OVERSEAS_TYPES_MATCHES_PROJECT_TYPE=
 for %%i in (%OVERSEAS_TYPES%) do if "%%i" == "%PROJ_TYPE%" set OVERSEAS_TYPES_MATCHES_PROJECT_TYPE=1

 if defined OVERSEAS_TYPES_MATCHES_PROJECT_TYPE (
  echo cfg only iworld_android_overseas.cfg,zhishu ktx only zhishu_m_p1.ktx
  copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android_overseas.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld.cfg
  rem TODO
  rsync /A /XF "zhishu_m_47_p3.*" %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
  copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\overseas_res\english\fonts\Fonts.xml %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\Fonts.xml
 ) else (
   if "%PROJ_TYPE%" equ "OVERSEASBETA" (
   echo cfg only iworld_android_overseasbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
   copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android_overseasbeta.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld.cfg
   rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
  ) else (
   if "%PROJ_TYPE%" equ "MINIBETA" (
   echo cfg only iworld_androidbeta.cfg,zhishu ktx only zhishu_m_p1.ktx
   copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_androidbeta.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld.cfg
   rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
   ) else (
    echo no overseas_res,cfg only iworld_android.cfg,zhishu ktx only zhishu_m_p1.ktx
    copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\iworld_android.cfg %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\iworld.cfg
    rsync /A /XF "overseas_res" /XF "zhishu_m_47_p3.*" %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
    if "%PROJ_TYPE%" equ "TENCENTQQDT" (
     echo zhishu ktx add zhishu_m_47_p3.ktx zhishu_m_47_p3_alpha.ktx
     copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx
     copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx
    )
   )
  )
 )
) 

 if "%APK_LOAD%" equ "1" (
  md %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload 
  %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\MobileGameResPatch.exe %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\..\makeweb\all\mobileResToload\ %APK_VERSION_NAME%
 )
 
 set OLDDIR=%PWD%
 cd %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%
 if "%PROJ_TYPE%" equ "BLOCKARKIOSRES" (
  call ..\..\..\..\build\clean_imag_ios.bat
 ) else (
  call ..\..\..\..\build\clean_imag_android.bat
 )
 cd %OLDDIR%
)



rem csv convert to utf8
cd %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\csvdef\
if not exist %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\ (
  md %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\
)

REM for /f "delims=" %%i in ('dir \b *.csv') do (
 REM if exist %%i (
  REM echo %%i is directory, cannot be convert to utf8
 REM )
 REM rem TODO
 REM if exist %%i (
 REM iconv -f GBK -t UTF-8 -c %%i > %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\%%i
 REM )
REM )

@echo off
:: Checkout the existent of some directories with name ending with csv.
for /f "delims=" %%i in ('dir /a/b/s *.csv') do (
  pushd "%%i" 2>nul && ( call :is_a_folder_with_name_ending_with_csv "%%i" & popd ) || call :is_a_csv_file "%%i"
)
@echo on


:: 返回进入此目录之前所在的目录
popd
@echo off
rem delete unused fies
del /q %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\toolres\
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\shaders
md %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\shaders
copy %APPPLAY_MYAPP_BIN_ROOT_LOCAL%\res\shaders\materials.xml %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\shaders\materials.xml
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_pc
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitcomm1
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitex
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitex2
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitex3
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitex4
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc.png
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc.kte
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc.ktx
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc.pve
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uitpc.pvr
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uipc_alpha.kte
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uipc_alpha.ktx
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\uipc.xml
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\translate

del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.ktx
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.pvr
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_101_p4.png
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_p2.ktx
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_p2.pvr
del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\texture\bigtex_comm\zhishu_pc_p2.png
@echo on

for /f "delims=" %%i in ('dir /b %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\autogen\*.*') do (
 for /f "delims=" %%j in ('dir /b %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\*.*') do (
  if %%i == %%j (
   del %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\%%j
  )
 )
)


rem release
echo %APK_RELEASE%
:: echo %APK_CONFUSE%
:: 字符串非空
if "!APK_RELEASE!" equ "" (

  rem luac
  
  echo "luac begin"

  rem find . -name "*.lua" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\lua2luac.sh %EXE_SUFFIX% {} \;
  rem find . -name "*.lua" -exec file {} \;
  echo "luac end"

  rem cvs confuse
  echo confuse csv file begin
  find . -name "*.csv" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'

  ::find . -name "*.csv" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {}  \; 

  ::find . -name "*.csv" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "csv SUM= "SUM\1024\1024}'
  echo confuse csv file end

  rem xml confuse
  cd .\assets
  echo confuse xml file begin
  ::find . -name "*.xml"  ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "xml SUM= "SUM\1024\1024}'

  ::find . -name "*.xml"  ! -name lint.xml ! -name AndroidManifest.xml ! -wholename "*\res\*.xml" ! -wholename "*\sdkassets\*.xml" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\..\build\assetsconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {}  \; 

  ::find . -name "*.xml" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "xml SUM= "SUM\1024\1024}'
  echo confuse xml file end
  popd

  rem lua confuse
  echo confuse lua file begin
  ::find . -name "*.lua" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "lua SUM= "SUM\1024\1024}'

  ::find . -name "*.lua" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {}  \; 

  ::find . -name "*.lua" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ls -ltr {} \; | awk 'BEGIN {SUM=0} {SUM += $5} END {print "lua SUM= "SUM\1024\1024}'
  echo confuse lua file end

  rem pngquant
  :: Count the amount size of files excluding some specific files.
  ::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "PNG SUM= "SUM\1024\2014" M" }' 
  ::find . -name a.aaaa  ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(printf " -o -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "SKIPED PNG SUM= "SUM\1024\2014" M" }' 
  echo pngquant is running, plz wait ...
  find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(cat ..\Proj.Android.Studio\skip_pngs.txt) -exec ..\..\..\build\pngquant%EXE_SUFFIX% -f {} \; 
  echo pngquant 1
  ::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) ! -name "*-fs8.png" ! -name "*-or8.png"  -delete
  echo pngquant 2
  ::find . -name "*-fs8.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-fs8\\'  {} \;
  echo pngquant 3
  ::find . -name "*-or8.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" -exec ..\..\..\build\rename  -f 's\-or8\\'  {} \;
  echo pngquant 4
  ::find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \; | awk 'BEGIN{SUM=0 } {SUM += $5} END {print "PNG SUM= "SUM\1024\2014" M" }' 

  rem png confuse
  echo png confuse begin
  rem find . -name "*.png" ! -wholename "*\res\*.png" ! -wholename "*\build\*" ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\skip_pngs.txt)) -exec ls -l {} \;
  ::find . -name "*.png" ! -wholename "*\res\*.png"  ! -wholename ".\.idea\*" $(printf "! -wholename %s " $(cat ..\Proj.Android.Studio\notconfuse_pngs.txt)) -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {} 64 \; 

  echo png confuse end

  rem ogg confuse
  echo ogg confuse begin

  find . -name "*.ogg" ! -wholename "*\build\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {} 64 \; 

  echo ogg confuse end

  rem omod confuse
  echo omod confuse begin

  find . -name "*.omod" ! -wholename "*\build\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {} 64 \; 

  echo omod confuse end
  
  rem ktx  confuse
  echo ktx confuse begin

  find . -name "*.ktx" ! -wholename "*\build\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {} 64 \; 

  echo ktx confuse end
  
  rem pvr  confuse
  echo pvr confuse begin

  find . -name "*.pvr" ! -wholename "*\build\*" -exec ..\..\..\build\zipconfuse.sh %ARCH_SUFFIX%%EXE_SUFFIX% {} 64 \; 

  echo pvr confuse end

  rem edit versionCode versionName in AndroidManifest.xml
 
  rem TODO
  echo APK_VERSION_NAME = %APK_VERSION_NAME%
  if "%APK_VERSION_NAME%"  neq "" (
    rem statements
    echo calculate apk version from %APK_VERSION_NAME%
   
    rem ----- split the %APK_VERSION_NAME% start -----
    set VERSION_CODE_DIGIT_1=
    set VERSION_CODE_DIGIT_2=
    set VERSION_CODE_DIGIT_3=
    setlocal EnableDelayedExpansion
    call :split_the_version_code !APK_VERSION_NAME!
    echo VERSION_CODE_DIGIT_1 = !VERSION_CODE_DIGIT_1!
    echo VERSION_CODE_DIGIT_2 = !VERSION_CODE_DIGIT_2!
    echo VERSION_CODE_DIGIT_3 = !VERSION_CODE_DIGIT_3!
    rem ----- split the %APK_VERSION_NAME% end -----
   
    set /a version = %VERSION_CODE_PART_1% * 65536 + %VERSION_CODE_PART_2% * 256 + %VERSION_CODE_PART_3%
    echo version = %version%
   
    :: find ..\..\iworld\ -name ClientManager.cpp -exec sed%EXE_SUFFIX% -i -r 's\(.*)(\*sClientVersion)(.*)(")([0-9.]+)(".*)\echo "\1\2\3\\\4%APK_VERSION_NAME%\\\6"\ge' {} \;
    :: The extraction of cpp file has special usage, cannot be temporarily widely applied.
   
  
    :: ----- extract sClientVersion start -----
    set APK_VERSION_NAME=
    setlocal EnableDelayedExpansion
    call :extract_sClientVersion %~dp0\..\..\iworld\ClientManager.cpp
    echo APK_VERSION_NAME = !APK_VERSION_NAME!
    :: ----- extract sClientVersion end -----
  
    if "%PROJ_TYPE%" equ "ADT" (
      for %%i in (%PROJ_ROOTS%) do (
        set "ANDROIDMANIFEST_ROOT=%%i"
        cd %ANDROIDMANIFEST_ROOT%
    
        :: The extraction from xml file is umperfect for only having special usage.
        :: ----- extract versionCode and versionName start -----
        set VERSION_CODE=
        set VERSION_NAME=
        setlocal EnableDelayedExpansion
        call :extract_version_code AndroidManifest.xml
        call :extract_version_name AndroidManifest.xml
        endlocal
        set version=%VERSION_CODE%
        set APK_VERSION_NAME=%VERSION_NAME%
        echo version = %version%
        echo APK_VERSION_NAME = %APK_VERSION_NAME%
        :: ----- extract versionCode and versionName end -----
      )
      cd %ENGINE_ROOT_LOCAL%\AppPlay\proj.AndroidStudio.Blockark\app\src\main\
      :: ----- extract versionCode and versionName start -----
      setlocal EnableDelayedExpansion
      call :extract_version_code AndroidManifest.xml
      call :extract_version_name AndroidManifest.xml
      endlocal
      set version=%VERSION_CODE%
      set APK_VERSION_NAME=%VERSION_NAME%
      :: ----- extract versionCode and versionName end -----
    ) else (
      :: ----- extract versionCode and versionName start -----
      setlocal EnableDelayedExpansion
      call :extract_version_code AndroidManifest.xml
      call :extract_version_name AndroidManifest.xml
      endlocal
      set version=%VERSION_CODE%
      set APK_VERSION_NAME=%VERSION_NAME%
      :: ----- extract versionCode and versionName end -----
      if "%PROJ_TYPE%" equ "BLOCKARK" (
        cd %ENGINE_ROOT_LOCAL%\AppPlay\proj.AndroidStudio.Blockark\app\src\main\
        :: ----- extract versionCode and versionName start -----
        setlocal EnableDelayedExpansion
        call :extract_version_code AndroidManifest.xml
        call :extract_version_name AndroidManifest.xml
        endlocal
        set version=%VERSION_CODE%
        set APK_VERSION_NAME=%VERSION_NAME%
        :: ----- extract versionCode and versionName end -----
      )
    )
  )
)
echo ----- overseas -----
echo %OVERSEAS_PROJ_ROOTS%
echo %IOSRES_PROJ_ROOTS%
echo %APPPLAY_MYAPP_ANDROID_ROOT%
rem 海外版替换字体配置文件
set OVERSEAS_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT=
for %%i in (%OVERSEAS_PROJ_ROOTS%) do if "%%i" == "%APPPLAY_MYAPP_ANDROID_ROOT%" set OVERSEAS_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT=1
if defined OVERSEAS_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT (
 echo "kekeke copy Fonts.xml"
 copy %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\overseas_res\english\fonts\Fonts.xml %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\Fonts.xml
)
rem 
set IOSRES_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT=
for %%i in (%IOSRES_PROJ_ROOTS%) do if "%%i" == "%APPPLAY_MYAPP_ANDROID_ROOT%" set IOSRES_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT=1
if defined IOSRES_PROJ_ROOTS_MATCHES_APPPLAY_MYAPP_ANDROID_ROOT ( 
:: if echo "${IOSRES_PROJ_ROOTS[@]}" | grep -w "\<%APPPLAY_MYAPP_ANDROID_ROOT%\>" &>\dev\null; then 
 echo "kekeke copy Fonts.xml"
 copy %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\overseas_res\english\fonts\Fonts.xml %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\ui\mobile\Fonts.xml
)


rem build
echo "start build"

set NDK_MODULE_PATH=%ENGINE_ROOT_LOCAL%\
:%ENGINE_ROOT_LOCAL%\openssl\

%NDK_ROOT_LOCAL%\ndk-build.exe -C %APPPLAY_MYAPP_ANDROID_ROOT% -j4

echo "end build"
rem echo 2: %APPPLAY_MYAPP_ANDROID_ROOT%
rem 拷贝到所有工程
if "%PROJ_TYPE%" equ "ADT" (
  for %%i in (%PROJ_ROOTS%) do (
    set PROJ_ROOT=%%i
    del /q %PROJ_ROOT%\libs\armeabi
    del /q %PROJ_ROOT%\assets\*
    
    rem 拷贝libs
    copy %APPPLAY_MYAPP_ANDROID_ROOT%\libs\armeabi %PROJ_ROOT%\libs
    rem 拷贝assets    
    set OVERSEAS_PROJ_ROOTS_MATCHES_PROJ_ROOT=
    for %%j in (%OVERSEAS_PROJ_ROOTS%) do if %%j==%PROJ_ROOT% set OVERSEAS_PROJ_ROOTS_MATCHES_PROJ_ROOT=1
    if defined OVERSEAS_PROJ_ROOTS_MATCHES_PROJ_ROOT (
      rsync -a /xf "iworld*" /xf "Fonts.xml" /xf "zhishu_*" /xf "*.pvr" %APPPLAY_MYAPP_ANDROID_ROOT%\assets %PROJ_ROOT%
      copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\iworld_overseas.cfg %PROJ_ROOT%\assets\iworld.cfg
      copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\overseas_res\english\fonts\Fonts.xml %PROJ_ROOT%\assets\ui\mobile\Fonts.xml
    ) else (
      set IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT=
      for %%j in (%IOSRES_PROJ_ROOTS%) do if %%j==%PROJ_ROOT% set IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT=1
      if defined IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT (
        rsync /a /xf "iworld*" /xf "Fonts.xml" /xf "zhishu_*" /xf "*.ktx" %APPPLAY_MYAPP_ANDROID_ROOT%\assets %PROJ_ROOT%
        copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\iworld_overseas.cfg %PROJ_ROOT%\assets\iworld.cfg
        copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\overseas_res\english\fonts\Fonts.xml %PROJ_ROOT%\assets\ui\mobile\Fonts.xml
      ) else (
        set BETA_PROJ_ROOTS_MATCHES_PROJ_ROOT=
        for %%j in (%BETA_PROJ_ROOTS%) do if %%j=%PROJ_ROOT% set BETA_PROJ_ROOTS_MATCHES_PROJ_ROOT=1
        if defined BETA_PROJ_ROOTS_MATCHES_PROJ_ROOT (
          rsync /a /xf overseas_res /xf "iworld*" /xf "zhishu_*" /xf "*.pvr" %APPPLAY_MYAPP_ANDROID_ROOT%\assets %PROJ_ROOT%
          copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\iworld_androidbeta.cfg %PROJ_ROOT%\assets\iworld.cfg
        ) else (
          rsync /a /xf overseas_res /xf "iworld*" /xf "zhishu_*" /xf "*.pvr" %APPPLAY_MYAPP_ANDROID_ROOT%\assets %PROJ_ROOT%
          copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\iworld.cfg %PROJ_ROOT%\assets\iworld.cfg
          
          set TencentQQDT_PROJ_ROOTS_MATCHES_PROJ_ROOT=
          for %%j in (%TencentQQDT_PROJ_ROOTS%) do if %%j==%PROJ_ROOT% set TencentQQDT_PROJ_ROOTS_MATCHES_PROJ_ROOT=1
          if defined TencentQQDT_PROJ_ROOTS_MATCHES_PROJ_ROOT (
            rem 47 QQDT zhishu201803
            copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx %PROJ_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3.ktx
            copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx %PROJ_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_47_p3_alpha.ktx
          )
        )
      )
    )
    
    set IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT=
    for %%j in (%IOSRES_PROJ_ROOTS%) do if %%j==%PROJ_ROOT% set IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT=1
    if defined IOSRES_PROJ_ROOTS_MATCHES_PROJ_ROOT (
      copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1.png %PROJ_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1.png
    ) else (
      copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1.ktx %PROJ_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1.ktx
      copy %APPPLAY_MYAPP_ANDROID_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1_alpha.ktx %PROJ_ROOT%\assets\ui\mobile\texture\bigtex_comm\zhishu_m_p1_alpha.ktx
    )
    copy %PROJ_ROOT%\sdklibs\* %PROJ_ROOT%\libs\armeabi\
    copy %PROJ_ROOT%\sdkassets\* %PROJ_ROOT%\assets\

    echo %PROJ_ROOT% "file copy end"
  )
  
  rem clear and make debug_so dir
  set DEBUGSO_DIR=%ENGINE_ROOT_LOCAL%\AppPlay\ApkOutput\%APK_VERSION_NAME%
  if exist %DEBUGSO_DIR% (
    rd /s /q %DEBUGSO_DIR%
  )
  rem  copy debug_so
  md %DEBUGSO_DIR%
  copy %ENGINE_ROOT_LOCAL%\AppPlay\Proj.Android\obj\local\ %DEBUGSO_DIR%
) else (
  rem sdk assets files
  if  "%SDK_ASSETS_ROOT%" neq "" (
    copy %SDK_ASSETS_ROOT%\* %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\
  )
  rem sdk libs files
  if "%SDK_LIBS_ROOT%" neq "" (
    copy %SDK_LIBS_ROOT%\* %APPPLAY_MYAPP_ANDROID_ROOT%\libs\armeabi\
  )
  
  rem if [ "%PROJ_TYPE%" = "BLOCKARK" ]; then
  rem   unzip
  rem fi
)

::--------------------------------------------------------------- 
::-- All the functions defined below.
::--------------------------------------------------------------- 

::--------------------------------------------------------------- 
::-- Desciption: 
::      If the iterated csv file is a file. 
::-- Param: 
::      the csv file
::-- Global Return: 
::      nul
::--------------------------------------------------------------- 
:is_a_csv_file
  iconv -f GBK -t UTF-8 -c %~1> %APPPLAY_MYAPP_ANDROID_ROOT%\%ASSETS_DIR%\csvdef\%~n1
goto :eof

::--------------------------------------------------------------- 
::-- Desciption: 
::      If the iterated csv file is a directory, the correct logical operation of file cannot be executed. 
::-- Param: 
::      the csv file
::-- Global Return: 
::      nul
::--------------------------------------------------------------- 
:is_a_folder_with_name_ending_with_csv
  echo %~n1 is directory, cannot be convert to utf8
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "sClientVersion" in a cpp file.
::-- Param: 
::      a file path
::-- Global Return: 
::      !APK_VERSION_NAME!
::--------------------------------------------------------------- 
:extract_sClientVersion
if "%~1" equ "" goto :eof
set CLIENT_MANAGER_CPP_FILE=%~1
echo CLIENT_MANAGER_CPP_FILE = !CLIENT_MANAGER_CPP_FILE!
set SEARCH_RESULT_FILE=sClientVersion.txt
find "static const char *sClientVersion" !CLIENT_MANAGER_CPP_FILE! > !SEARCH_RESULT_FILE!
set APK_VERSION_NAME=
for /f "skip=2 tokens=* delims= " %%i in (!SEARCH_RESULT_FILE!) do (
  set TEMP_LINE=%%i
  :: This can be optimized by splitting the string.
  set APK_VERSION_NAME=!TEMP_LINE:~37,6!
  echo APK_VERSION_NAME = !APK_VERSION_NAME!
  goto :eof
)

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionCode" in an AndroidManifest.xml file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !VERSION_CODE!
::--------------------------------------------------------------- 
:extract_version_code
if "%~1" equ "" goto :eof 
set ANDROID_MANIFEST_FILE=%~1
echo ANDROID_MANIFEST_FILE = !ANDROID_MANIFEST_FILE!
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionCode" %ANDROID_MANIFEST_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set TEMP_VERSION_CODE=%%i
  echo ORIGIN=!TEMP_VERSION_CODE!
  :: This can be optimized by splitting the string.
  set VERSION_CODE=!TEMP_VERSION_CODE:~21,4!
  echo VERSION_CODE = !VERSION_CODE!
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" in an AndroidManifest.xml file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !VERSION_NAME!
::--------------------------------------------------------------- 
:extract_version_name
if "%~1" equ "" goto :eof 
set ANDROID_MANIFEST_FILE=%~1
echo ANDROID_MANIFEST_FILE = !ANDROID_MANIFEST_FILE!
set SEARCH_RESULT_FILE=versionCode_and_versionName.txt
find "android:versionName" %ANDROID_MANIFEST_FILE% > !SEARCH_RESULT_FILE!
for /f "skip=2 tokens=*" %%i in (%SEARCH_RESULT_FILE%) do (
  set TEMP_VERSION_NAME=%%i
  echo ORIGIN=!TEMP_VERSION_NAME!
  :: This can be optimized by splitting the string.
  set VERSION_NAME=!TEMP_VERSION_NAME:~21,6!
  echo VERSION_NAME = !VERSION_NAME!
  goto :eof
)
goto :eof

::---------------------------------------------------------------  
::-- Desciption: 
::      Extract the variable "android:versionName" in an AndroidManifest.xml file.
::-- Param: 
::      an AndroidManifest.xml file
::-- Global Return: 
::      !VERSION_CODE_DIGIT_1!
::      !VERSION_CODE_DIGIT_2!
::      !VERSION_CODE_DIGIT_3!
::--------------------------------------------------------------- 
:split_the_version_code
if "%~1" equ "" goto :eof
set TEMP_VERSION_CODE=%~1
:: Add value "1*" to "tokens" to read the next iterated element in the for-loop.
for  /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_1=%%i
  :: Set the remaining part to the digit.
  set TEMP_VERSION_CODE=%%j
  goto split_version_code_digit_2_start
)
:split_version_code_digit_2_start
for /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_2=%%i
  set TEMP_VERSION_CODE=%%j
  goto split_version_code_digit_3_start
)
:split_version_code_digit_3_start
for /f "tokens=1* delims=." %%i in ("%TEMP_VERSION_CODE%") do (
  set VERSION_CODE_DIGIT_3=%%i
  goto split_version_code_digit_3_end
)
goto :eof


