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

for /d %%D in ("%SRC%\*") do (
    set "SUBDIR=%%~nxD"
    if not exist "%DEST%\%%~nxD" mkdir "%DEST%\%%~nxD"
    for %%F in ("%%D\*") do (
        if exist "%DEST%\%%~nxD\%%~nxF" (
            echo   Skipping %%~nxD\%%~nxF - already exists
        ) else (
            copy "%%F" "%DEST%\%%~nxD\%%~nxF" >nul
            echo   Copied %%~nxD\%%~nxF -^> %DEST%\%%~nxD\%%~nxF
        )
    )
    for /d %%E in ("%%D\*") do (
        if not exist "%DEST%\%%~nxD\%%~nxE" mkdir "%DEST%\%%~nxD\%%~nxE"
        for %%G in ("%%E\*") do (
            if exist "%DEST%\%%~nxD\%%~nxE\%%~nxG" (
                echo   Skipping %%~nxD\%%~nxE\%%~nxG - already exists
            ) else (
                copy "%%G" "%DEST%\%%~nxD\%%~nxE\%%~nxG" >nul
                echo   Copied %%~nxD\%%~nxE\%%~nxG -^> %DEST%\%%~nxD\%%~nxE\%%~nxG
            )
        )
    )
)

echo.
echo Done. Global Claude files installed to %DEST%
echo.
pause
