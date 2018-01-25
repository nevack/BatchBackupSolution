@echo off
set /p backup="Enter backup path: "
7-zip.exe /S
attrib -H %userprofile%\appdata
attrib +H %userprofile%\.* /D
xcopy %userprofile%\source %backup%\source\ /Y /E /Q
xcopy %userprofile%\IdeaProjects %backup%\IdeaProjects\ /Y /E /Q
xcopy %userprofile%\CLionProjects %backup%\CLionProjects\ /Y /E /Q
xcopy %userprofile%\Documents %backup%\Documents\ /Y /E /Q
xcopy %localappdata%\Google\Chrome %backup%\Chrome\ /Y /E /Q
xcopy 

xcopy "%userprofile%\AppData\Roaming\Sublime Text 3" %backup%\ST3\ /Y /E /Q
xcopy %userprofile%\source %backup%\source\ /Y /E /Q
xcopy %userprofile%\source %backup%\source\ /Y /E /Q
xcopy %userprofile%\source %backup%\source\ /Y /E /Q
