rem ****************************************************************************
rem * launch-gpodder+-dev.vbs
rem * -----------------------
rem * This VBScript is designed to launch the gPodder+ DEVELOPMENT application
rem * in a runtime environment. It uses the CMD batch script of the same name
rem * to start the application.
rem ****************************************************************************
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run Chr(34) & "D:\SWDevRepos\GitHub\rlampere\gPodder+\launch-gpodder+.cmd" & Chr(34), 0, False