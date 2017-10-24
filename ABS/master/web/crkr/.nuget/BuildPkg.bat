@ECHO OFF

ECHO Packing the NuGet files
rem NuGet.exe pack NuSpecs\Infragistics.nuspec -OutputDirectory ..\Packages  -NoPackageAnalysis

NuGet.exe pack NuSpecs\FastReport.Bars.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\FastReport.Editor.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\Cl3ClientLib.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\ibank.core.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\FastReport.Full.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\Bars.Web.Controls.nuspec -OutputDirectory ..\src\bars.nuget\Packages
NuGet.exe pack NuSpecs\Infragistics.nuspec -OutputDirectory ..\src\bars.nuget\Packages
 
IF ERRORLEVEL 1 GOTO :showerror

GOTO :EOF

:showerror
PAUSE
