if %time% gtr 1:00:00 (
  schtasks /create /tn "shutdown" /tr "shutdown /s" /sc once /st 1:00:00
) else (
  schtasks /create /tn "shutdown" /tr "shutdown /s" /sc once /st 1:00:00
)

pause