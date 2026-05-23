@echo off
setlocal
rem ********************************************************************************
rem  update-gpodder+-prod.cmd
rem  ------------------------
rem  Updates gPodder+ PROD files with latest version from DEV.
rem ********************************************************************************

rem Output start message.
echo Updating gPodder+ PROD files from DEV...

rem Define the log file and initialize it.
set "LOG_FILE=%APPDATA%\update-gpodder+-prod.log"
echo Updating gPodder+ PROD files from DEV on %DATE% at %TIME%... > "%LOG_FILE%"
echo. >>"%LOG_FILE%"

rem Define DEV and PROD locations.
set "DEV_ROOT=D:\SWDevRepos\GitHub\rlampere\gPodder+"
set "PROD_ROOT=C:\Program Files (x86)\gPodder+"
set "REPO_FOLDER=gpodder"

rem Perform the pull.
echo.
echo ^> Copying from %DEV_ROOT%\%REPO_FOLDER% to %PROD_ROOT%\%REPO_FOLDER%...
robocopy /mir "%DEV_ROOT%\%REPO_FOLDER%" "%PROD_ROOT%\%REPO_FOLDER%" >> %LOG_FILE%

rem Display the log file if necessary.
if /i not "%1"=="-nolog" if /i not "%2"=="-nolog" notepad "%LOG_FILE%"
exit /b 0
endlocal