:: Author: Dmitry Nevedomsky <dimchik01050@gmail.com>
:: Comments:
::   "echo("        -- echo empty line
::   "<nul set /p=" -- echo without new line
::   ">NUL 2>&1"    -- hide output

:: Hide prompt and set title
@ECHO OFF 
title Backup

:: Check if we are elevated to Administrator, if not - exiting
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Failure: Need Administrative permissions. Exiting...
    pause >nul
    exit /B 1
)

:: Check if run from explorer by double click
SET interactive=0
ECHO %CMDCMDLINE% | FINDSTR /L %COMSPEC% >NUL 2>&1
IF %ERRORLEVEL% == 0 SET interactive=1

:: Second var
::   SET interactive=1
::   ECHO %CMDCMDLINE% | FIND /I "/c" >NUL 2>&1
::   IF %ERRORLEVEL% == 0 SET interactive=0

:: Script name
SET me=%~n0
:: Script location
SET parent=%~dp0

:: Ask for backup path and update title accordingly
echo(
set /p backup="Enter backup path: "
set backup=%backup%\backup-%date%
title Backuping to %backup%
color 06

:: Change dir to script location
cd /d %parent%
mkdir %backup%

:: Backup projects
echo(

<nul set /p="Visual Studio projects: "
xcopy %userprofile%\source %backup%\source\ /Y /E /Q

<nul set /p="IntelliJ Idea Projects: "
xcopy %userprofile%\IdeaProjects %backup%\IdeaProjects\ /Y /E /Q

<nul set /p="CLion Projects: "
xcopy %userprofile%\CLionProjects %backup%\CLionProjects\ /Y /E /Q

<nul set /p="%username%'s Documents: "
xcopy %userprofile%\Documents %backup%\Documents\ /Y /E /Q

:: Backup Chrome
echo(
:chrome

<nul set /p="Chrome data: "
xcopy %localappdata%\Google\Chrome %backup%\Chrome\ /Y /E /Q

if /I %errorLevel% NEQ 0 (

    setlocal enableDelayedExpansion
	echo Close Google Chrome to continue

    :: Confirm Killing chrome
    set /p confirm="Kill it? [y/N]: "

    if !confirm!==yes (set confirm=y)
    if !confirm!==y (
        :: Killing
        echo Killing...
        call :kill "chrome.exe"

        goto :chrome
    ) else (
        :: If don't want to kill - skip
        echo Skipped
    )
)

:: Backup configs
echo(
<nul set /p="Battle net configs and data: "
xcopy "%localappdata%\Battle.net" %backup%\BN\ /Y /E /Q

<nul set /p="Sublime Text license and configs: "
xcopy "%AppData%\Sublime Text 3" %backup%\ST3\ /Y /E /Q

<nul set /p="Cuphead game save: "
xcopy %AppData%\Cuphead %backup%\Cuphead\ /Y /E /Q

<nul set /p="Factorio game save: "
xcopy %AppData%\Factorio %backup%\Factorio\ /Y /E /Q

<nul set /p="qBittorrent config: "
xcopy %AppData%\qBittorrent %backup%\qBittorrent\ /Y /E /Q

<nul set /p="Summatra config: "
xcopy %AppData%\SumatraPDF %backup%\SumatraPDF\ /Y /E /Q

<nul set /p="Telegram login: "
xcopy "%AppData%\Telegram Desktop\tdata" %backup%\Telegram\ /Y /E /Q

<nul set /p="Yousician: "
xcopy "%AppData%\Yousician Launcher" %backup%\Yousician\ /Y /E /Q

<nul set /p="Gitconfig file: "
xcopy %userprofile%\.gitconfig %backup%\* /Y /Q

<nul set /p="Steam skins: "
xcopy "C:\Program Files (x86)\Steam\skins" %backup%\skins\ /Y /E /Q

:: Allow to restore copy
xcopy ".\restore.cmd" "%backup%\*" /Y /Q >nul 2>&1

:: If run from explorer by double click ask to press eny key
:: Else just quit without prompt
echo(
echo Done!
IF "%interactive%"=="0" (
    color 0A
    PAUSE
)
EXIT /B 0


:: Kill function
::   /f  -- force kill.
::   /t  -- kill with children processes.
::   /im -- specify name of program to kill. Ex: chrome.exe, explorer.exe, etc.
::   %*  -- argument passed with function call. 
:kill
taskkill /F /IM %* /T >nul 2>&1
EXIT /B 0
:: return to call