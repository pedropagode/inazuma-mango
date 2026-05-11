@echo off
title Inazuma's Mango -- HWID
cd /d "%~dp0"

:: Tenta py primeiro (Python Launcher do Windows), depois python
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
echo [ERRO] Python nao foi encontrado no PATH.
echo.
echo Instale o Python em https://www.python.org/downloads/
echo Durante a instalacao, marque "Add Python to PATH".
echo.

:done
echo.
pause
