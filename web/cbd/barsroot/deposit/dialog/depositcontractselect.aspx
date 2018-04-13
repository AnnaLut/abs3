<%@ Page language="c#" CodeFile="DepositContractSelect.aspx.cs" AutoEventWireup="true" Inherits="DepositContractSelect" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк договорів</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="../style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="../js/js.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable" id="Table1">
				<tr>
					<td><asp:label id="lbTitle" meta:resourcekey="lbTitle15" runat="server" CssClass="InfoLabel">Выбор соглашений для печати</asp:label></td>
				</tr>
				<tr>
					<td><asp:datagrid id="gridContract" runat="server" CssClass="BaseGrid"></asp:datagrid></td>
				</tr>
				<tr>
					<td><input id="_ID" type="hidden" runat="server"/></td>
				</tr>
			</table>
			<!-- #include virtual="../Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
