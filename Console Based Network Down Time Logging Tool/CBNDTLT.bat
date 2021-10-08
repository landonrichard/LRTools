@echo off

rem Title and About
echo _-_-_Console Based Network Down Time Logging Tool_-_-_
echo.
echo This tool will attempt to ping Google.com every second and store that data in readable values.
echo.
echo You can edit this file with notepad to change the ping target
echo.
echo ---Press 'CTRL+C' to stop---
echo. & pause

rem Setup Variables
set up=0
set down=0
set total=0

rem Give feedback and start the loop
echo RUNNING 
:startping
rem wait one second between each loop
timeout 1 > nul
rem Add a dot after each ping
echo|set /p="."

rem Loop
rem Ping the dest. and look for time=
ping google.com -n 1 -w 3000| find "time=" > nul
if not errorlevel 1 (
	rem Add to Up
	set /A up+=1
) else (
	rem Add to Down 
	set /A down+=1
)

rem Math for Percentage
set /A total=%up%+%down%
set /A downtime=(%down%*100)/%total%

rem Get Date and Time
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%

rem Save Results to a file that updates every second
echo Downtime is %downtime% percent at %mydate%:%mytime% >> CBNDTLT_Results.txt 

rem Restart Loop
goto :startping

rem Landon Richard 10/7/2021