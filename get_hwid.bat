@echo off
title Inazuma's Mango -- HWID
cd /d "%~dp0"

:: ── Estrategia 1: usar InazumaMango.exe (Python embutido — sem deps) ────────
:: Funciona em qualquer Windows, mesmo sem Python instalado, porque a .exe
:: ja contem um interpretador Python via Nuitka. O modo --hwid no _launcher.py
:: anexa o console do cmd via AttachConsole e roda o get_hwid.py interno.
if exist "%~dp0InazumaMango.exe" (
    "%~dp0InazumaMango.exe" --hwid
    goto :done
)

:: ── Estrategia 2 (fallback dev): Python instalado no PATH ───────────────────
:: Util para rodar direto da pasta de desenvolvimento, antes de buildar a exe.
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

:: ── Nenhuma das duas estrategias disponivel ─────────────────────────────────
echo.
echo ============================================================
echo  [ERRO] Nao foi possivel obter seu HWID.
echo ============================================================
echo.
echo  InazumaMango.exe nao foi encontrado nesta pasta:
echo    %~dp0
echo.
echo  E Python tambem nao esta instalado no sistema.
echo.
echo  Solucoes (qualquer uma resolve):
echo.
echo    [A] Coloque get_hwid.bat na mesma pasta que InazumaMango.exe
echo        (jeito recomendado — nao precisa instalar nada).
echo.
echo    [B] Instale Python em https://www.python.org/downloads/
echo        (durante a instalacao, marque "Add Python to PATH").
echo.
echo ============================================================

:done
echo.
pause
