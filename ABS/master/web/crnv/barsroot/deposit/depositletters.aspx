<%@ Page language="c#" CodeFile="DepositLetters.aspx.cs" AutoEventWireup="true" Inherits="DepositLetters" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Листи та повідомлення</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center">
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle" runat="server" CssClass="InfoHeader">Письма и уведомления</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<div style="OVERFLOW: scroll; HEIGHT: 200px">
							<asp:DataGrid id="gridLetters" CssClass="BaseGrid" runat="server" EnableViewState="False" tabIndex="1"></asp:DataGrid>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<input class="AcceptButton" id="btForm" meta:resourcekey="btForm" tabIndex="2" type="button" value="Формировать"
							runat="server"> <input id="letter_id" type="hidden" runat="server" name="letter_id">
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
