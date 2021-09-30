echo off
ECHO 0. "Spawining a command prompt window with administrative privilages"
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~dp0"" && %~0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

SET LOCAL
SET pPath=Particl` Desktop\particld\unpacked\particld.exe
SET particldPath=%APPDATA%%pPath%
ECHO "Particl daemon path is %particldPath%"

ECHO "Get the current directory with no trailing slash"
SET ScriptDir=%~dp0
ECHO "The current directory path is %ScriptDir%"

ECHO 1. "Setting temporary execution policy to allow powershell scripts..."
powershell Set-ExecutionPolicy Bypass -Scope Process
ECHO "Execution policy is set to Bypass. It will return to its previous value when this command prompt window is closed"

ECHO 2. "Setting the antivirus exclussion rules"

ECHO 2A. "Adding an antivirus exclussion rule for the Particl datadir"
powershell Add-MpPreference -ExclusionPath "%APPDATA%\Particl"
ECHO "Folder "%APPDATA%\Particl" excluded from the antivirus scanning

ECHO 2B. "Adding an exclussion rule for the Particl Core daemon"
powershell Add-MpPreference -ExclusionPath "%APPDATA%\%pPath%"
ECHO "Executable "%APPDATA%\%pPath%" excluded from the antivirus scanning"

ECHO 2C. "Adding an exclussion rule for the Particl Desktop folder"
powershell Add-MpPreference -ExclusionPath "%ScriptDir:~0,-1%"
ECHO "Folder "%ScriptDir:~0,-1%" excluded from the antivirus scanning"
ECHO 2D. "Adding an exclussion rule for the Particl Desktop executable"
powershell Add-MpPreference -ExclusionPath "%ScriptDir%Particl` Desktop.exe"
ECHO "Executable "%ScriptDir%Particl` Desktop.exe" excluded from the antivirus scanning

ECHO 3. "Modifying the firewall rules"

ECHO 3A. "Setting the firewall rules for the Particl Core daemon"
powershell New-NetFirewallRule -DisplayName "particldaemon-Inbound" -Direction Inbound -Action Allow -Program "%APPDATA%\%pPath%"
ECHO "Inbound allowed"
powershell New-NetFirewallRule -DisplayName "particldaemon-Outbound" -Direction Outbound -Action Allow -Program "%APPDATA%\%pPath%"
ECHO "Outbound allowed"
ECHO "Firewall rules for the Particl Core daemon are set"

ECHO 3B. "Setting the firewall rules for the Particl Desktop executable"
powershell New-NetFirewallRule -DisplayName "particldesktop-Inbound" -Direction Inbound -Action Allow -Program "%ScriptDir%Particl` Desktop.exe"
ECHO "Inbound allowed"
powershell New-NetFirewallRule -DisplayName "particldesktop-Outbound" -Direction Outbound -Action Allow -Program "%ScriptDir%Particl` Desktop.exe"
ECHO "Outbound allowed"
ECHO "Firewal rules for the Particl Desktop executable are set"
