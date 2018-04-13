<%@ Page language="c#" CodeFile="DepositPrint.aspx.cs" AutoEventWireup="true" Inherits="DepositPrint"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	</head>
	<frameset id="mFrameSet" rows="100,*" cols="*" onload="enablePrintButton()" frameborder="yes">
		<frame frameBorder="0" name="header" width="100%" src="cmd.aspx" scrolling="yes" noresize>
		<frame name="contents" frameBorder="0" src="depositprintcontract.aspx">
	</frameset>
</html>
