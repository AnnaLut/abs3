rem Скрипт на очистку каталога BARS\BIN от лишних библиотек
rem для внутреннего пользования на БАРСе
rem SERG     25-03-2004

rem !!!! замените значение BARS_HOME на Ваш каталог
SET BARS_HOME=D:\BARS-NBU

SET BARS_BIN=%BARS_HOME%\BIN

del %BARS_BIN%\BARSGTW.EXE
del %BARS_BIN%\BARSGTW.HLP
del %BARS_BIN%\MFC42.DLL 
del %BARS_BIN%\MICO236.DLL 
del %BARS_BIN%\MILLSEC.DLL 
del %BARS_BIN%\MSVCP60.DLL 
del %BARS_BIN%\MSVCRT.DLL 
del %BARS_BIN%\NGSEC.DLL
del %BARS_BIN%\SECLOGIN.DLL 
