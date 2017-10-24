@echo off

If "%1" == ""  goto usage
If "%2" == ""  goto setit
set _outFile=%2
goto process

:setit 
set _outFile=out.awk

:process
echo Input  "%1"
echo Output "%_outFile%"
echo Define "%3"
echo Preprocessing...
%BARS_HOME%\GAWK\gawk -f %BARS_HOME%\BIN\plsql.awk -v v=%3 %1 > %_outFile%
echo done
goto finish

:usage
echo "Usage: gaw <input> [<output>='out.awk'] [<define>='']"
:finish