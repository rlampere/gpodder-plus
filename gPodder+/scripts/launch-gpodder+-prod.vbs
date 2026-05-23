rem ****************************************************************************
rem * launch-gpodder+-prod.vbs  -- gPodder+ Production Version
rem * ------------------------
rem * This VBScript is designed to launch the gPodder+ PRODUCTION application
rem * in a runtime environment. It uses the CMD batch script of the same name
rem * to start the application.
rem ****************************************************************************
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run Chr(34) & "C:\Program Files (x86)\gPodder+\launch-gpodder+-prod.cmd" & Chr(34), 0, False