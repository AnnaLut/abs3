set SSDIR=\\Barsapp\BarsSourceDB
set BARSDIR=D:\BARS98
set VSSUSER=Anny
set VSSREPORTSDIR=D:\BARS98\SQL\REPORTS
set VSSDIR=C:\Program Files\Microsoft Visual SourceSafe


rem =======================================
rem == set current project       
rem =======================================



set CURRDIR=%~dp0
call "%VSSDIR%\ss.exe"  Cp $/BARS/SQL/REPORTS


rem =======================================
rem == adding file to VSS
rem =======================================
if %2. == 1. goto e1
goto p2
:e1
call "%VSSDIR%\ss.exe"  Add -I- "%BARSDIR%"\PRINT\%1 -O@"%CURRDIR%$vssadd.log"
goto END_VSS


:p2
rem =======================================
rem == checkout  file 
rem =======================================

if %2. == 2. goto e2
goto p3
:e2
call "%VSSDIR%\ss.exe" Checkout  -I- $/BARS/SQL/REPORTS/%1 -O@"%CURRDIR%$vsschecko.log" -GL"%VSSREPORTSDIR%"

goto END_VSS


:p3
rem =======================================
rem == checkin  file 
rem =======================================

if %2. == 3. goto e3
goto p4
:e3
call "%VSSDIR%\ss.exe" Checkin  -I- $/BARS/SQL/REPORTS/%1 -O@"%CURRDIR%$vsschecki.log" -GL"%VSSREPORTSDIR%"
goto END_VSS



:p4
rem =======================================
rem == check status for file
rem =======================================

if %2. == 4. goto e4
goto p5
:e4
call "%VSSDIR%\ss.exe" Status  -I- %1 -O@"%CURRDIR%\$vssstatus.log" 
goto END_VSS




:p5
rem =======================================
rem == check status for all users checked files   %1 - username
rem =======================================

if %2. == 5. goto e5
goto p6
:e5
call "%VSSDIR%\ss.exe" Status  -I-  -O@"%CURRDIR%\$vssstatus.log" 
goto END_VSS



:p6
rem =======================================
rem == Locate file
rem =======================================

if %2. == 6. goto e6
goto p7
:e6

call "%VSSDIR%\ss.exe" Locate    %1 

goto END_VSS


:p7
rem =======================================
rem == Properties
rem =======================================

if %2. == 7. goto e7
goto END_VSS
:e7

rem call "%VSSDIR%\ss.exe" Project 
call "%VSSDIR%\ss.exe" Properties

goto END_VSS


:END_VSS


