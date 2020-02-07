@break off
@cls

REM ----------------------------------- Overview ------------------------------------

	REM  Original script to prevent Windows 10 Upgrade pieced together by:    Jonathan Warner
	REM  Updated on:            20200131
	REM  Updated by:            Computer Repair Sacramento
	REM  Filename:              wcs_prevent-win10-upgrade.bat
	REM  distributed freely without any warranty or guarantee of suitability of fitness for any purpose! Use at your own risk!

REM --------------------------------- Begin Code ------------------------------------

setlocal EnableDelayedExpansion

IF EXIST C:\Windows\System32\GWX (

set "scriptnotes=GWX detected... "

TASKKILL /IM GWX.exe /T /F
TASKKILL /IM GWXUX.exe /T /F

schtasks.exe /Change /TN "\Microsoft\Windows\Setup\gwx\launchtrayprocess" /Disable
schtasks.exe /Change /TN "\Microsoft\Windows\Setup\gwx\refreshgwxconfig" /Disable

rem uninstall KB3035583

start /wait wusa /uninstall /kb:3035583 /quiet /norestart /log
start /wait wusa /uninstall /kb:3035583 /quiet /norestart /log

if exist wusa.etl (del wusa.etl)
if exist wusa.etl.dpx (del wusa.etl.dpx)

rem delete folders present

if exist C:\Windows\System32\GWX (
takeown /f C:\Windows\System32\GWX /r /d y
icacls C:\Windows\System32\GWX /grant administrators:F /t
rmdir /s /q C:\Windows\System32\GWX\
timeout 5
)

if exist "%localappdata%\GWX" (
takeown /f "%localappdata%\GWX" /r /d y
icacls "%localappdata%\GWX" /grant administrators:F /t
rmdir /s /q "%localappdata%\GWX\"
timeout 5
)

if exist C:\$Windows~BT (
takeown /f C:\$Windows~BT /r /d y
icacls C:\$Windows~BT /grant administrators:F /t
rmdir /s /q C:\$Windows~BT\
timeout 5
)

if exist C:\Windows\SoftwareDistribution\Download (
takeown /f C:\Windows\SoftwareDistribution\Download /r /d y
icacls C:\Windows\SoftwareDistribution\Download /grant administrators:F /t
for /d %%i in (C:\Windows\SoftwareDistribution\Download\*) do rd /s /q "%%i"
del /s /q C:\Windows\SoftwareDistribution\Download\*.*
timeout 5
)

set "scriptnotes=!scriptnotes! Removed. "

) else (

set "scriptnotes=GWX not detected. "

)

REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Gwx" /v DisableGWX /d 1 /f&gt;Nul
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v DisableOSUpgrade /d 1 /f&gt;Nul
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v AllowOSUpgrade /d 0 /f&gt;Nul
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v ReservationsAllowed /d 0 /f&gt;Nul

cls

set "scriptnotes=!scriptnotes! Prevention applied."

:END
echo !scriptnotes!
endlocal
exit /b
