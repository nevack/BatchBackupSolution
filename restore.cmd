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