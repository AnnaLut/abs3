<%@ Page language="c#" CodeFile="acc_rates.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Tab6" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/Rates.js?v1.0"></script>
		<script language="javascript">
		 window.onload = InitRates;
		</script>
	</HEAD>
	<body scroll=no>
			<div runat="server" id=hintDiv meta:resourcekey="ToolTip3" align="center" class="hint">Двойной клик по строке - изменение значений</div>	
	    	<div class="webservice" id="webService" showProgress="true"></div>
			<div align=center><INPUT id="def" meta:resourcekey="def" runat="server" type=button value='Значения по умолчанию' onclick='onDef()'></div>
			<!-- #include file="/Common/Include/Localization.inc"-->
			<!-- #include file="/Common/Include/WebGrid2005.inc"-->
			<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" /> 
		</body>
</HTML>
