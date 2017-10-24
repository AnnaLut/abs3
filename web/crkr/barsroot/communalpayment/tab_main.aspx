<%@ Page language="c#" CodeFile="tab_main.aspx.cs" AutoEventWireup="false" Inherits="KP.Tab_Main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Окно ввода</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="Scripts/Tab_main.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
	</head>
	<body onkeydown="fnHotKeyMain()">
		<div align="center" id=plGrid>
			<TABLE id="Oper" style="FONT-SIZE: 8pt; BORDER-LEFT-COLOR: black; BORDER-BOTTOM-COLOR: black; WIDTH: 100%; CURSOR: hand; BORDER-TOP-COLOR: black; FONT-FAMILY: Verdana; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: white; BORDER-RIGHT-COLOR: black"
				borderColor="black" cellSpacing="0" cellPadding="2" width="100%" border="1" tabIndex="1" onkeydown="KPress()">
				<TR style="FONT-WEIGHT: bold; FONT-SIZE: 8pt; COLOR: white; FONT-FAMILY: Verdana; BACKGROUND-COLOR: gray"
					align="center">
					<TD width="5%">№</TD>
					<TD runat="server" meta:resourcekey="td1">Наименование операции</TD>
					<TD width="10%" runat="server" meta:resourcekey="td2">МФО</TD>
					<TD width="10%" runat="server" meta:resourcekey="td3">Счет</TD>
					<TD width="10%" runat="server" meta:resourcekey="td4">Сумма</TD>
					<TD width="10%" runat="server" meta:resourcekey="td5">Комиссия</TD>
					<TD width="18px"></TD>
					<TD width="18px"></TD>
					<TD width="18px"></TD>
					<TD width="18px"></TD>
				</TR>
			</TABLE>
		</div>	
	<input type="hidden" runat="server" id="Mes29" meta:resourcekey="Mes29" value="Удалить операцию ?" />	
	</body>
</html>
