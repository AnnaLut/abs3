<%@ Page language="c#" CodeFile="listnbs.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.ListNbs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>ListValuts</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/ListNbs.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="JavaScript">
		window.onload = InitListNbs; 
		</script>
</HEAD>
	<body bgColor="#f0f0f0">
			<div align=center><input runat="server" id=btPrev meta:resourcekey="btPrev" class=bt type=button value="Назад" onclick="fnNbuPrev()">
			<input runat="server" meta:resourcekey="btCancel" class=bt type=button value="Отмена" onclick="fnNbuCancel()">
			<input runat="server" meta:resourcekey="btChoice" class=bt type=button value="Выбор" onclick="fnNbuSet()">
			<input runat="server" id=btNext meta:resourcekey="btNext" class=bt type=button value="Вперед" onclick="fnNbuNext()"></div>
			<DIV class="webservice" id="webService" showProgress="true"></DIV>	
			<!-- #include file="/Common/Include/Localization.inc"-->
			<!-- #include file="/Common/Include/WebGrid2005.inc"-->
			<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" /> 	
		</body>
</HTML>
