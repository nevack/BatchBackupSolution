:: Author: Dmitry Nevedomsky <dimchik01050@gmail.com>
:: Comments:
::   "echo("        -- echo empty line
::   "<nul set /p=" -- echo without new line
::   ">NUL 2>&1"    -- hide output

:: Hide prompt and set title
@ECHO OFF
title Backup

:: Script name with extension
SET me=%~nx0
:: Script location
SET parent=%~dp0
:: Change dir to script location
:: cd /d %parent%

:: Check if run from explorer by double click
::SET interactive=0
::ECHO %CMDCMDLINE% | FINDSTR /L %COMSPEC% >NUL 2>&1
::IF %ERRORLEVEL% == 0 SET interactive=1

:: Second var
SET interactive=1
ECHO %CMDCMDLINE% | FIND /I "/c" >NUL 2>&1
IF %ERRORLEVEL% == 0 SET interactive=0

:: Check if we are elevated to Administrator, if not - exiting
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Failure: Need Administrative permissions.
    IF "%interactive%"=="1" (
        exit /B 0
    )
    :: 0C -- Light Red text
    color 0C
    echo Rerunning with elevated shell...

    :: Run in elevated window (UAC will ask for access) and exit
    powershell.exe -command "Start-Process %parent%%me% -Verb runas"
    exit /B 0
)

echo(

<nul set /p="This PC registry tweak: "
regedit.exe /S %parent%postinstall\thispctweak.reg
echo Done^!

echo(
echo Done^!
IF "%interactive%"=="0" (
    :: Light Green text
    color 0A
    PAUSE
)
color
endlocal
EXIT /B 0