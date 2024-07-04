@echo off
setlocal

REM Define variables
set "WINCAIRO_URL=https://s3-us-west-2.amazonaws.com/archives.webkit.org/wincairo-x86_64-release/280661@main.zip"
set "WINCAIRO_ZIP=wincairo.zip"
set "WINCAIRO_DIR=wincairo"
set "WEBKIT_WIN_URL=https://github.com/WebKitForWindows/WebKitRequirements/releases/download/v2024.06.28/WebKitRequirementsWin64.zip"
set "WEBKIT_WIN_ZIP=WebKitRequirementsWin64.zip"
set "WEBKIT_WIN_DIR=WebKitRequirements"

REM Download WinCairo build
echo Downloading WinCairo build...
curl -L -o %WINCAIRO_ZIP% %WINCAIRO_URL%

REM Extract the downloaded zip file
echo Extracting WinCairo build...
powershell -Command "Expand-Archive -Path %WINCAIRO_ZIP% -DestinationPath %WINCAIRO_DIR%"

REM Download WebKitForWindows build
echo Downloading WebKitForWindows build...
curl -L -o %WEBKIT_WIN_ZIP% %WEBKIT_WIN_URL%

REM Extract the downloaded zip file
echo Extracting WebKitForWindows build...
powershell -Command "Expand-Archive -Path %WEBKIT_WIN_ZIP% -DestinationPath %WEBKIT_WIN_DIR%"

REM Create a Safari folder
if not exist Safari mkdir Safari

REM copy wincairo/bin64 to Safari folder
echo Copying WinCairo to Safari folder...
xcopy %WINCAIRO_DIR%\bin64 Safari /s /e

REM copy WebKitForWindows to Safari folder
echo Copying WebKitForWindows to Safari folder...
xcopy %WEBKIT_WIN_DIR%\bin64 Safari /s /e

REM Clean up
cd ..
rmdir /s /q %WINCAIRO_DIR%
del %WINCAIRO_ZIP%
rmdir /s /q %WEBKIT_WIN_DIR%
del %WEBKIT_WIN_ZIP%

REM Navigate to Safari folder and launch the browser
cd Safari
start MiniBrowser.exe https://www.bing.com

echo Done!
endlocal
pause
