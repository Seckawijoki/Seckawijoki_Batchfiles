@echo off
set startTime=%time%
set startSecond=%time:~6,2%
set startMinute=%time:~3,2%
set startHour=%time:~0,2%
pause
set endTime=%time%
set endSecond=%time:~6,2%
set endMinute=%time:~3,2%
set endHour=%time:~0,2%

echo startHour = %startHour%
echo startMinute = %startMinute%
echo startSecond = %startSecond%
echo.
echo endHour = %endHour%
echo endMinute = %endMinute%
echo endSecond = %endSecond%

set /a executingSeconds=%endSecond% - %startSecond%
set /a executingMinutes=%endMinute% - %startMinute%
set /a executingHours=%endHour% - %endHour%
echo.
echo startTime = %startTime%
echo endTime = %endTime%
echo executingSeconds = %executingSeconds%
echo executingMinutes = %executingMinutes%
echo executingHours = %executingHours%

