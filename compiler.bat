@ECHO OFF
:: This file compiles all java files in a directory
TITLE Java from: %1, %2.class

set Dir=%1
set _Dir=%1
set File=%2
set call=%3

set bin=bin
call set _Dir=%%_Dir:src=%bin%%%

if exist %Dir% (
	cd /d %Dir%
	call :selectDirectory

) else (
)

PAUSE

:: Call the class.class
:executeClass 		- executes a class
	echo ============================================================
	rem Change directory to bin, call Package.Class.class
	cd /d ../bin

	echo Directory: %_Dir%
	echo Class: %File%.class
	echo ============================================================
	java %call%

EXIT /B

:: Expects a directory with a src
:selectDirectory 	- select a directory
	echo Trying to open '%Dir%'...

	if exist src (
		if not exist bin (
			rem Create bin folder if not present
			echo No 'bin' directory found, creating bin...
			mkdir bin
		)
		echo ============================================================
		cd src
		dir
		echo ============================================================
		rem Loop over everything in src and compile
		rem Put compiled files in ../bin
		for /r %%g in ( *.java ) do (
			echo Compiling '%%g'...
			javac -d %cd%/bin %%g
		)

		echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		echo Done compiling!

		call :executeClass

	rem Given directory doesnt have any src
	) else (
		echo %Dir% doesn't have any 'src' folder. Try again...

		dir
		cd /d ..

		if not %cd% == D:\ (
			call :selectDirectory
		) else (
			echo Nothing found
			PAUSE
		)
	)
EXIT /B
