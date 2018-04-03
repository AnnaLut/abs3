<%@ Page language="c#" CodeFile="acc_sob.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Tab7" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Tab7</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/Sob.js"></script>
		<script language="javascript">
				window.onload = InitSob;
		</script>
	</HEAD>
	<body scroll="no">
		<div runat="server" id=hintDiv meta:resourcekey="ToolTip4" align="center" class="hint">Двойной клик по строке - изменение значений</div>
		<div class="webservice" id="webService"></div>
		<div id="a_d"><img src="/Common/Images/INSERT.gif" id="add" onclick="Add()">
			<img src="/Common/Images/DELREC.gif" onclick="DelRow()" id="del"></div>
		<!-- #include file="/Common/Include/Localization.inc"-->
		<!-- #include file="/Common/Include/WebGrid2005.inc"--> 
		<input type="hidden" runat="server" id="foradd" meta:resourcekey="foradd" value="Добавить" />
		<input type="hidden" runat="server" id="fordel" meta:resourcekey="fordel" value="Удалить текущую" />
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
	</body>
</HTML>
