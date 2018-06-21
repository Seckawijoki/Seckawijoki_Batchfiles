@echo off
set array=c:\ e:\ f:\
set array2="c:\ e:\ f:\" rem 字符串
set "array3=c:\ e:\ f:\"

for %%a in (%array%) do (
  echo %%a
)
for %%a in (%array2%) do (
  echo %%a
)
for %%a in (%array3%) do (
  echo %%a
)
echo %array%

pause 1>nil
