<%@ Page language="c#" CodeFile="DepositSignDialog.aspx.cs" AutoEventWireup="true" Inherits="DepositDialog" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Вибір документів для підпису</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="../style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="../js/js.js"></script>
		<script type="text/javascript" language="javascript">
			var l_sgn = new Array();
		</script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle13" runat="server" CssClass="InfoLabel">Документы по текущему депозитному договору</asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid id="gridTemplates" runat="server" CssClass="BaseGrid" DataSource="<%# dsDocs %>">
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input class="AcceptButton" id="btSelect" meta:resourcekey="btSelect2" 
						    type="button" value="Подписать" name="btSelect" runat="server"/>
					</td>
				</tr>
				<tr>
					<td>
						<input id="templ" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="../Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
