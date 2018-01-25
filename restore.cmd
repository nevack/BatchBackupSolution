:: Author: Dmitry Nevedomsky <dimchik01050@gmail.com>
:: Comments:
::   "echo("        -- echo empty line
::   "<nul set /p=" -- echo without new line
::   ">NUL 2>&1"    -- hide output

:: Hide prompt and set title
@ECHO OFF 
title Restore

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

color 06

:: Change dir to script location
cd /d %parent%
mkdir %backup%

xcopy source\ %userprofile%\source /Y /E /Q
xcopy IdeaProjects\ %userprofile%\IdeaProjects /Y /E /Q
xcopy CLionProjects\ %userprofile%\CLionProjects /Y /E /Q
xcopy Documents\ %userprofile%\Documents /Y /E /Q
xcopy Chrome\ %localappdata%\Google\Chrome /Y /E /Q
xcopy BN\ "%localappdata%\Battle.net" /Y /E /Q

xcopy ST3\ "%AppData%\Sublime Text 3" /Y /E /Q
xcopy Cuphead\ %AppData%\Cuphead /Y /E /Q
xcopy Factorio\ %AppData%\Factorio /Y /E /Q
xcopy qBittorrent\ %AppData%\qBittorrent /Y /E /Q
xcopy SumatraPDF\ %AppData%\SumatraPDF /Y /E /Q
xcopy Telegram\ "%AppData%\Telegram Desktop\tdata" /Y /E /Q
xcopy Yousician\ "%AppData%\Yousician Launcher" /Y /E /Q

copy gitconfig %userprofile%\.gitconfig

xcopy skins\ "C:\Program Files (x86)\Steam\skins" /Y /E /Q
pause