@echo off
@break off
@cls

setlocal EnableDelayedExpansion

REM  ----------------------------------- Overview ------------------------------------

	REM  Original script by:    Jonathan Warner
	REM  Updated on:            20200131
	REM  Updated by:            Computer Repair Sacramento :: info@computerrepairsacramentoca.net
	REM  Filename:              wcs_clear-printer-queue.bat
	REM  distributed freely without any warranty or guarantee of suitability of fitness for any purpose! Use at your own risk!

REM  --------------------------------- Begin Code ------------------------------------ 

net stop spooler>nul & IF ERRORLEVEL 1 ( 
								set "scriptnotes=Error stopping spooler"
								goto END
)


del %windir%\system32\spool\printers\*.* /F /Q>nul & IF ERRORLEVEL 1 ( 
								set "scriptnotes=Error clearing cache"
								goto END
)

net start spooler>nul & IF ERRORLEVEL 1 ( 
								set "scriptnotes=Error starting spooler"
								goto END
)

set "scriptnotes=Local print cache and queue cleared"

cls

:END
REM  ending and housekeeping duties
echo %scriptnotes%
endlocal
exit /b
