@echo off
chcp 65001 >nul
if not exist "%~dp0OP.exe" (
    echo Файл OP.exe не найден в директории: %~dp0
    pause
    exit /b 1
)

PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell.exe '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0OP.ps1\"' -Verb RunAs}"

exit