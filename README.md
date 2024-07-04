# Safari On Windows

Developer focused github repo for getting Webkit/Safari on Windows. The intent is to accumulate information, issues, videos and scripts to make it better over time. As it stands, many websites and forum posts focus on the fact that there is no Safari distribution for windows, ignoring the other ways of running webkit/Safari.

There are two routes: Official builds or Node.js playwright.
Official builds are just files that need to be downloaded; however setting up Node.js playwright enables easier updates via npm.

## Official builds

Official documentation details how to build or download it: https://docs.webkit.org/Ports/WindowsPort.html

For convenience, here are the links from July 4, 2024, based on the [instructions](https://docs.webkit.org/Ports/WindowsPort.html#downloading-build-artifacts-from-buildbot).

- WinCairo: [Download](https://s3-us-west-2.amazonaws.com/archives.webkit.org/wincairo-x86_64-release/280661@main.zip) ([Build](https://build.webkit.org/#/builders/731/builds/18948))
- WebKitForWindows:
  [Download](https://github.com/WebKitForWindows/WebKitRequirements/releases/download/v2024.06.28/WebKitRequirementsWin64.zip)
  ([Release](https://github.com/WebKitForWindows/WebKitRequirements/releases/tag/v2024.06.28))
- Microsoft Visual C++ Redistributable for Visual Studio: [Download](https://aka.ms/vs/17/release/vc_redist.x64.exe) ([Information page](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170))


### Command line version

The following script downloads the WinCairo build, extracts it and opens the browser.
```batch
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

@REM REM copy wincairo/bin64 to Safari folder
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
```


## Node.js playwright

Playwright is a Node.js library that enables automation of web browsers. It supports Webkit, Chromium and Firefox.

Requirements:

- Download and install Node.js from https://nodejs.org/en/download/
- The following script installs playwright and opens a Webkit browser on Windows.
```bash
npm install playwright
npx playwright install webkit
npx playwright wk https://webkit.org/
```

- To update playwright and Webkit:
```bash
npm update playwright
npx playwright update
```


# Potential future work
- Making the script find the latest versions, including the Microsoft Visual C++ Redistributable for Visual Studio install.
- Testing if more UI can be added, i.e, tabs like https://pd4d10.github.io/chrome-ui/ (Currently they will not work for almost all webpages due to using an iframe to load the page, which is blocked due to security reasons.)


# Screenshot

![image](https://github.com/rsxdalv/safari-on-windows/assets/6757283/d8708cc1-9ea6-4693-ad9c-3653bf6fe674)
