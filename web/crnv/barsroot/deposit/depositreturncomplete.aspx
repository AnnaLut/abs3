<%@ Page language="c#" CodeFile="DepositReturnComplete.aspx.cs" AutoEventWireup="true" Inherits="DepositReturnComplete"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Виплата по завершенні</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="MainTable" class="MainTable">
				<tr>
					<td align="center">
						<asp:label id="lbInfo" meta:resourcekey="lbInfo15" runat="server" CssClass="InfoHeader">Возврат депозита</asp:label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:Label id="lbActionResult" meta:resourcekey="lbActionResult" runat="server" CssClass="InfoText">Транзакция завершена</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<asp:button id="btnSubmit" meta:resourcekey="btnSubmit2" runat="server" Text="Следующий" CssClass="DirectionButton"></asp:button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
