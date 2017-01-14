@echo off
SET THEFILE=c:\users\irsyad\desktop\algo\rawati~1\rawati~1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  C:\Users\Irsyad\Desktop\ALGO\RAWATI~1\rsrc.o -s   -b base.$$$ -o c:\users\irsyad\desktop\algo\rawati~1\rawati~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
