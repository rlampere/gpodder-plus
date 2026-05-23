rem *********************************
rem * gPodder+ - Production Version *
rem *********************************
@echo off
setlocal

rem ===== gPodder+ Root Directory =====
set "GPODDER_P_ROOT=C:\Program Files (x86)\gPodder+"

rem ===== gPodder+ Log File =====
rem Create a log file unique to each execution of the app.
set "LOG_DIR=%APPDATA%\gPodder+"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%"
set "STAMP=%DATE:/=-%_%TIME::=-%"
set "STAMP=%STAMP: =0%"
set "STAMP=%STAMP:.=-%"
set "LOG_FILE=%LOG_DIR%\launch-gpodder+_%STAMP%.log"

echo Launching gPodder+ application on %DATE% at %TIME%... > "%LOG_FILE%"
echo. >>"%LOG_FILE%"

rem ===== gPodder+ Lock File =====
rem This ensures only one instance of gPodder+ is executing.
set "LOCK_FILE=%APPDATA%\gPodder+\launch-gpodder+.lock"
if exist "%LOCK_FILE%" (
    echo Existing lock file found: %LOCK_FILE% >>"%LOG_FILE%"
    echo Another gPodder+ launch may already be in progress. >>"%LOG_FILE%"
    echo If gPodder+ is not running, delete this lock file manually. >>"%LOG_FILE%"
    exit /b 0
) else (
    echo %DATE% %TIME% > "%LOCK_FILE%"
    echo Lock file successfully created: %LOCK_FILE% >> "%LOG_FILE%"
)

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
rem NOTE: The following 3 if statement cause errors. I do not know why since
rem the same 3 if statements were used in a dev environment and worked fine.
rem Since they aren't really necessary the have been commented out so the
rem command file works.
rem if not exist "%PYTHON_EXE%" (
rem     echo ERROR: Python Executable not found: %PYTHON_EXE% >>"%LOG_FILE%"
rem     echo. >>"%LOG_FILE%"
rem     exit /b 1
rem )
rem if not exist "%LAUNCHER_SCRIPT%" (
rem     echo ERROR: gPodder launcher script not found: %LAUNCHER_SCRIPT% >>"%LOG_FILE%"
rem     echo. >>"%LOG_FILE%"
rem     exit /b 1
rem )
rem if not exist "%FAKE_DBUS_DIR%" (
rem rem     echo ERROR: fake-dbus module folder not found: %FAKE_DBUS_DIR% >>"%LOG_FILE%"
rem     echo. >>"%LOG_FILE%"
rem     exit /b 1
rem )

echo ----- gPodder+ Data Locations -----         >>"%LOG_FILE%"
echo --Using System Environment Variables--      >>"%LOG_FILE%"
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

rem ===== gPodder+ Launch Application =====
echo ----- Launching gPodder+ Application ----- >>"%LOG_FILE%"

rem Move the proper directory to execute the app.
cd /d "%GPODDER_DIR%"

rem Output execution information for debug purposes.
echo Note: CMD PID info is not directly available in cmd.exe. >>"%LOG_FILE%"
echo Launch command: "%PYTHON_EXE%" "%LAUNCHER_SCRIPT%" >>"%LOG_FILE%"
echo Current directory: %CD% >>"%LOG_FILE%"

rem Start python and execute the launcher script.
"%PYTHON_EXE%" "%LAUNCHER_SCRIPT%" 1>>"%LOG_FILE%" 2>&1

rem Save the execution status upon exiting python.
set "EXIT_CODE=%ERRORLEVEL%"

rem Delete the lock file after the application terminates.
del "%LOCK_FILE%" >nul 2>&1
echo Lock file successfully deleted: %LOCK_FILE% >> "%LOG_FILE%"

rem Check if an error occurred during execution and output an error.
if not "%EXIT_CODE%"=="0" (
    echo. >>"%LOG_FILE%"
    echo gPodder+ exited with error: %EXIT_CODE% >>"%LOG_FILE%"
    echo. >>"%LOG_FILE%"
    exit /b %EXIT_CODE%
) else (
    echo Python exit code: %EXIT_CODE% >>"%LOG_FILE%"
)
echo. >>"%LOG_FILE%"
echo gPodder+ terminated. >>"%LOG_FILE%"

endlocal