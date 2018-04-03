<%@ Page language="c#" CodeFile="listvaluts.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.ListValuts" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Список валют</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/ListValuts.js"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript">
		window.onload = InitListValuts;
		</script>
	</HEAD>
	<body bgColor="#f0f0f0">
		<DIV class="webservice" id="webService" showProgress="true"></DIV>
			<div align="center"><IMG id="btClick" title="Сохранить" src="/Common/Images/SAVE.gif" onclick="fnCloseValutes()">&nbsp;&nbsp;<IMG id="btDiscard" onclick="document.close();window.close();" title="Выйти" src="/Common/Images/DISCARD.gif"></div>
			<!-- #include file="/Common/Include/Localization.inc"-->
			<!-- #include file="/Common/Include/WebGrid2005.inc"--> 
		    <input type="hidden" runat="server" id="forbtClick" meta:resourcekey="forbtSave" value="Сохранить" />
		    <input type="hidden" runat="server" id="forbtDiscard" meta:resourcekey="forbtDiscard" value="Выйти" />
		    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />		
	</body>
</HTML>
