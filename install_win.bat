@echo off
setlocal

set "SRC=%~dp0files"
set "DEST=%USERPROFILE%\.claude"

if not exist "%DEST%" mkdir "%DEST%"

for %%F in ("%SRC%\*") do (
    if exist "%DEST%\%%~nxF" (
        echo   Skipping %%~nxF - already exists in %DEST%
    ) else (
        copy "%%F" "%DEST%\%%~nxF" >nul
        echo   Copied %%~nxF -^> %DEST%\%%~nxF
    )
)

echo.
echo Done. Global Claude files installed to %DEST%
echo.
pause
