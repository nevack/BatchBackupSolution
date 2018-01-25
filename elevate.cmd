@echo off
title Elevation
cd /d %~dp0
powershell.exe -command "Start-Process makebackup.cmd -Verb runas"
exit