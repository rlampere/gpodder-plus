@echo off
setlocal
rem ****************************************************************************
rem * launch-gpodder+-dev.cmd
rem * -----------------------
rem * This batch script is designed to launch the gPodder+ application in a
rem * DEVELOPMENT environment. It sets up the necessary environment variables
rem * to execute the gPodder+ development version of the open-source gPodder
rem * application, which is an application to manage and play podcasts.
rem ****************************************************************************

rem ===== gPodder+ Root Directory =====
set "GPODDER_P_ROOT=D:\SWDevRepos\GitHub\rlampere\gPodder+"

rem ===== gPodder+ Log File =====
set "LOG_FILE=%GPODDER_P_ROOT%\launch-gpodder+.log"

echo Launching gPodder+ application on %DATE% at %TIME%... > "%LOG_FILE%"
echo. >>"%LOG_FILE%"

rem ===== gPodder+ Executable Locations =====
set "PYTHON_EXE=C:\msys64\mingw64\bin\python.exe"
set "GPODDER_DIR=%GPODDER_P_ROOT%\gpodder"
set "LAUNCHER_SCRIPT=%GPODDER_DIR%\bin\gpodder+"
set "FAKE_DBUS_DIR=%GPODDER_DIR%\tools\fake-dbus-module"
set "PODCASTPARSER_DIR=%GPODDER_P_ROOT%\podcastparser"
set "MYGPOCLIENT_DIR=%GPODDER_P_ROOT%\mygpoclient"

echo ----- gPodder+ Executable Locations ----- >>"%LOG_FILE%"
echo GPODDER_P_ROOT=%GPODDER_P_ROOT%           >>"%LOG_FILE%"
echo PYTHON_EXE=%PYTHON_EXE%                   >>"%LOG_FILE%"
echo GPODDER_DIR=%GPODDER_DIR%                 >>"%LOG_FILE%"
echo LAUNCHER_SCRIPT=%LAUNCHER_SCRIPT%         >>"%LOG_FILE%"
echo FAKE_DBUS_DIR=%FAKE_DBUS_DIR%             >>"%LOG_FILE%"
echo PODCASTPARSER_DIR=%PODCASTPARSER_DIR%     >>"%LOG_FILE%"
echo MYGPOCLIENT_DIR=%MYGPOCLIENT_DIR%         >>"%LOG_FILE%"
echo.                                          >>"%LOG_FILE%"

rem ===== Validate Key Executable Locations =====
if not exist "%PYTHON_EXE%" (
    echo ERROR: Python Executable not found: %PYTHON_EXE% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b 1
)
if not exist "%LAUNCHER_SCRIPT%" (
    echo ERROR: gPodder+ launcher script not found: %LAUNCHER_SCRIPT% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b 1
)
if not exist "%FAKE_DBUS_DIR%" (
    echo ERROR: fake-dbus module folder not found: %FAKE_DBUS_DIR% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b 1
)

rem ===== gPodder+ Data Locations =====
rem If local data location definitions are commented out, it means the
rem system environment variable definitions should be used instead.
rem Local definitions allow for testing with different data.

rem Select between using system environment variables (USE_LOCAL_DEFS=false) or
rem using local definitions (USE_LOCAL_DEFS=true).
set USE_LOCAL_DEFS=false

if /i "%USE_LOCAL_DEFS%"=="true" (
    echo *** Using Local Environment Variables *** >>"%LOG_FILE%"
    set "GPODDER_HOME=D:\SWDevRepos\GitHub\rlampere\gPodder+\gpodder-home-test"
    set "GPODDER_DOWNLOAD_DIR=D:\SWDevRepos\GitHub\rlampere\gPodder+\gpodder-downloads-test"
) else (
    echo *** Using System Environment Variables *** >>"%LOG_FILE%"
)

echo ----- gPodder+ Data Locations -----         >>"%LOG_FILE%"
echo GPODDER_HOME=%GPODDER_HOME%                 >>"%LOG_FILE%"
echo GPODDER_DOWNLOAD_DIR=%GPODDER_DOWNLOAD_DIR% >>"%LOG_FILE%"
echo.                                            >>"%LOG_FILE%"

rem ===== Validate Data Locations =====
rem Regardless of how the data locations are defined, ensure they exist
rem before launching gPodder+.
if not exist "%GPODDER_HOME%" (
    echo ERROR: GPODDER_HOME not found: %GPODDER_HOME% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b 1
)
if not exist "%GPODDER_DOWNLOAD_DIR%" (
    echo ERROR: GPODDER_DOWNLOAD_DIR not found: %GPODDER_DOWNLOAD_DIR% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b 1
)

rem ===== gPodder+ Runtime Environment =====
set "PATH=C:\msys64\mingw64\bin;C:\msys64\usr\bin;%PATH%"
set "PYTHONPATH=%FAKE_DBUS_DIR%;%PODCASTPARSER_DIR%;%MYGPOCLIENT_DIR%"

echo ----- gPodder+ Runtime Environment ----- >>"%LOG_FILE%"
echo PATH=%PATH%                              >>"%LOG_FILE%"
echo PYTHONPATH=%PYTHONPATH%                  >>"%LOG_FILE%"
echo.                                         >>"%LOG_FILE%"

echo ----- Launching gPodder+ Application ----- >>"%LOG_FILE%"
cd /d "%GPODDER_DIR%"
"%PYTHON_EXE%" "%LAUNCHER_SCRIPT%" 1>>"%LOG_FILE%" 2>&1
if not "%ERRORLEVEL%"=="0" (
    echo.                                              >>"%LOG_FILE%"
    echo gPodder+ exited with error level %ERRORLEVEL% >>"%LOG_FILE%"
    echo.                                              >>"%LOG_FILE%"
    exit /b %ERRORLEVEL%
)
echo. >>"%LOG_FILE%"
echo gPodder+ terminated. >>"%LOG_FILE%"

endlocal