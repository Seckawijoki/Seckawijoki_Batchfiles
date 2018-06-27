@echo off
set VERSION_CODE=0.25.78
set DIGIT=%VERSION_CODE%
set VERSION_CODE_DIGIT_1=
set VERSION_CODE_DIGIT_2=
set VERSION_CODE_DIGIT_3=
:: Add value "1*" to "tokens" to read the next iterated element in the for-loop.
for  /f "tokens=1* delims=." %%i in ("%DIGIT%") do (
  set VERSION_CODE_DIGIT_1=%%i
  :: Set the remaining part to the digit.
  set DIGIT=%%j
  goto split_version_code_digit_1_end
)
:split_version_code_digit_1_end
echo VERSION_CODE_DIGIT_1 = %VERSION_CODE_DIGIT_1%
for /f "tokens=1* delims=." %%i in ("%DIGIT%") do (
  set VERSION_CODE_DIGIT_2=%%i
  set DIGIT=%%j
  goto split_version_code_digit_2_end
)
:split_version_code_digit_2_end
echo VERSION_CODE_DIGIT_2 = %VERSION_CODE_DIGIT_2%
for /f "tokens=1* delims=." %%i in ("%DIGIT%") do (
  set VERSION_CODE_DIGIT_3=%%i
  goto split_version_code_digit_3_end
)
:split_version_code_digit_3_end
echo VERSION_CODE_DIGIT_3 = %VERSION_CODE_DIGIT_3%
set /a version = %VERSION_CODE_DIGIT_1% * 65536 + %VERSION_CODE_DIGIT_2% * 256 + %VERSION_CODE_DIGIT_3%
echo version = %version%