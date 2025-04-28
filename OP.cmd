@echo off
setlocal enabledelayedexpansion

set "psScriptPath=%~dp0OP.ps1"

if not exist "%psScriptPath%" (
    echo Файл OP.ps1 не найден в директории: %~dp0
    pause
    exit /b 1
)

set "tempVbsFile=%temp%\elevate.vbs"
echo Set UAC = CreateObject^("Shell.Application"^) > "%tempVbsFile%"
if errorlevel 1 (
    echo Не удалось создать временный файл elevate.vbs. Проверьте права доступа.
    pause
    exit /b 1
)

echo UAC.ShellExecute "PowerShell.exe", "-NoProfile -ExecutionPolicy Bypass -File ""%psScriptPath%""", "", "runas", 1 >> "%tempVbsFile%"
if errorlevel 1 (
    echo Не удалось записать данные во временный файл elevate.vbs. Проверьте права доступа.
    pause
    exit /b 1
)

if not exist "%tempVbsFile%" (
    echo Временный файл elevate.vbs не был создан. Проверьте права доступа или наличие свободного места на диске.
    pause
    exit /b 1
)

"%tempVbsFile%"

del "%tempVbsFile%" >nul 2>&1
if exist "%tempVbsFile%" (
    echo Не удалось удалить временный файл elevate.vbs. Проверьте права доступа.
    pause
    exit /b 1
)

exit /b 0