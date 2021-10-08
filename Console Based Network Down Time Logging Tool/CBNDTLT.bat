@echo off
echo _-_-_Console Based Network Down Time Logging Tool_-_-_
echo.
echo This tool will attempt to ping Google.com every second and store that data in readable values.
echo.
echo You can edit this file with notepad to change the ping target
echo.
echo ---Press 'CTRL+C' to stop---
echo. & pause

set /A up=0
set /A down=0
set /A downtime=0
set /A uptime=0

echo RUNNING 
:startping
timeout 1 > nul
echo|set /p="."
ping google.com -n 1 -w 3000| find "time=" > nul
if not errorlevel 1 (
	set /A up+=1
	REM echo Network Connection is Up
	REM echo Ups are set at %up%
) else (
	set /A down+=1
	REM echo Network Connection is Down
	REM echo Downs are set at %down%
)
set /A downtime=(%down%/(%down%+%up%))*100
set /A uptime=(%up%/(%down%+%up%))*100
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
echo Downtime is %downtime% percent at %mydate%:%mytime% >> CBNDTLT_Results.txt 
goto :startping