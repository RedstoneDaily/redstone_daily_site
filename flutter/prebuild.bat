@echo off
REM 执行 PowerShell 脚本
powershell.exe -ExecutionPolicy Bypass -File "prebuild.ps1" %*

REM 检查 PowerShell 脚本的退出代码
if %errorlevel% neq 0 (
    exit /b 1
) else (
    exit /b 0
)