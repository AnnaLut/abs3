<%@ Page language="c#" CodeFile="DepositAddSumComplete.aspx.cs" AutoEventWireup="true" Inherits="DepositAddSumComplete"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Друк додаткової угоди на зміну суми вкладу.</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="MainTable" class="MainTable">
				<tr>
					<td align="center">
						<asp:label CssClass="InfoHeader" id="lbInfo" meta:resourcekey="lbInfo14" runat="server">Пополнение депозита</asp:label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:Label CssClass="InfoText" id="lbActionResult" meta:resourcekey="lbActionResult" runat="server">Операция пополнения для депозита № %s выполнена</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:button id="btnSubmit" meta:resourcekey="btnSubmit" CssClass="AcceptButton" runat="server" Text="Следующий" Enabled="False"></asp:button>
						<input id="_ID" type="hidden" name="Hidden1" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
