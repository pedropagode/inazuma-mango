@echo off
title Inazuma's Mango -- HWID
cd /d "%~dp0"

:: Try py first (Windows Python Launcher), then python
where py >nul 2>&1
if %errorlevel%==0 (
    py "%~dp0get_hwid.py"
    goto :done
)

where python >nul 2>&1
if %errorlevel%==0 (
    python "%~dp0get_hwid.py"
    goto :done
)

echo.
echo [ERROR] Python was not found on the PATH.
echo.
echo Install Python from https://www.python.org/downloads/
echo During installation, make sure to check "Add Python to PATH".
echo.

:done
echo.
pause
