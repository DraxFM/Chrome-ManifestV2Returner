:: runs powershell script with appropiate flags
:: made by draxfm

@echo off

:: Credits to Eneerge
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

echo.
echo Chrome Manifest V2 Returner
echo Made by draxfm ^| github.com/DraxFM ^| github.com/DraxFM/Chrome-ManifestV2Returner
echo.
echo Running powershell script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0ChromeManifestV2Returner.ps1"
echo.
echo Script ran.
echo Press Enter to exit.
pause > nul
exit
