<%@ Page language="c#" CodeFile="Default.aspx.cs" AutoEventWireup="false" Inherits="BarsWeb.CrystalReports._Default" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<TITLE>Печать отчетов</TITLE>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<script language="javascript">
		 function InitFrames()
		 {
		  	window.frames["contents"].location.replace("PrintReport.aspx"+location.search)
		   	window.frames["header"].location.replace("HeadPrint.htm");
		 }
		</script>
	</HEAD>
	
	<frameset id="mFrameSet" rows="30,*" cols="*" onload="InitFrames();" frameborder="yes">
		<frame frameBorder="0" name="header" width="100%" scrolling="no" noresize>
		<frame name="contents" frameBorder="0">
	</frameset>
</HTML>
