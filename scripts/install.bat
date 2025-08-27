@echo off
setlocal enabledelayedexpansion

REM Define directories
set "BAYA_DIR=baya_releases"
set "EXTRACTED_DIR=."
set "EXAMPLES_DIR=examples"

REM Find the first archive in baya_releases
set "BAYA_ARCHIVE="
for %%f in (%BAYA_DIR%\*) do (
    set "BAYA_ARCHIVE=%%f"
    goto :found
)
if not defined BAYA_ARCHIVE (
    echo Baya release not found in %BAYA_DIR%.
    echo Please upload the Baya tool release (.zip/.tar.gz) into %BAYA_DIR% and re-run this script.
    exit /b 1
)

:found
echo Found Baya tool: %BAYA_ARCHIVE%
if not exist "%EXTRACTED_DIR%" mkdir "%EXTRACTED_DIR%"

REM Extract archive
REM Note: .tar.gz extraction requires tar (Windows 10+). .zip uses PowerShell.
set "EXTRACTED_BAYA="
if /I "%BAYA_ARCHIVE:~-7%"==".tar.gz" (
    echo Installing too, it will take couple of minutes, please wait ...
    tar -xzf "%BAYA_ARCHIVE%" -C "%EXTRACTED_DIR%"
) else if /I "%BAYA_ARCHIVE:~-4%"==".zip" (
    echo Installing - it will take couple of minutes, please wait ...
    powershell -Command "Expand-Archive -Path '%BAYA_ARCHIVE%' -DestinationPath '%EXTRACTED_DIR%'"
) else (
    echo Unsupported archive format. Please use .zip or .tar.gz.
    exit /b 2
)

REM Find the most recent directory inside baya_tool\baya-shell
set "BAYA_SHELL_DIR="
for /f "delims=" %%d in ('dir "%EXTRACTED_DIR%\baya-shell" /b /ad /o-d 2^>nul') do (
    set "BAYA_SHELL_DIR=%EXTRACTED_DIR%\baya-shell\%%d"
    goto :gotdir
)
:gotdir

if not defined BAYA_SHELL_DIR (
    echo Could not find extracted Baya shell directory.
    exit /b 3
)

echo Baya tool extracted to %BAYA_SHELL_DIR%

REM Change to the extracted directory
pushd "%BAYA_SHELL_DIR%"

REM Source setup_env.sh (requires Git Bash or similar; native batch does not support "source")
REM If you want to support native Windows, convert setup_env.sh to .bat/.cmd or provide Windows-compatible env setup.
if exist setup_env.bat (
    setup_env.bat 
) else (
    echo Warning: setup_env.sh not found in %BAYA_SHELL_DIR%.
)

REM Try running examples
if exist "%EXAMPLES_DIR%\" (
    set "anyExample="
    for /d %%e in ("%EXAMPLES_DIR%\*") do (
        set "EXAMPLE_PATH=%%e"
        if exist "!EXAMPLE_PATH!\runme.bat" (
            echo Running Example: !EXAMPLE_PATH!
            REM Requires Cygwin or WSL for .csh script; otherwise, skip or convert to .bat/.cmd
            echo Please run !EXAMPLE_PATH!\runme.csh in an appropriate shell (Cygwin/WSL/Git Bash).
            set "anyExample=1"
        )
        else (
            pushd  %EXAMPLE_PATH%
                runme.bat
            popd
        )
    )
    if not defined anyExample (
        echo No runnable examples found in %EXAMPLES_DIR%. Add some example projects with runme.csh!
    )
) else (
    echo No examples found in %EXAMPLES_DIR%. Add some example projects!
)

popd

echo Setup complete.
exit /b 0
