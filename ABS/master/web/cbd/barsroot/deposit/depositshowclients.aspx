<%@ Page language="c#" CodeFile="DepositShowClients.aspx.cs" AutoEventWireup="true" Inherits="DepositShowClients" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
        <base target="_self" />	
		<title>Депозитний модуль: Перегляд існуючих клієнтів</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" Content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body onload="focusControl('btShow');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center">
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle4" runat="server" CssClass="InfoHeader">Внимание! С указаным идентиикационным кодом уже существуют зарегистрированные клиенты</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td colSpan="3">
						<asp:DataGrid id="gridClients" runat="server" CssClass="BaseGrid" DataSource="<%# dsClients %>">
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td colSpan="3">
						<asp:Label id="Label1" meta:resourcekey="Label1_2" runat="server" CssClass="InfoLabel">Для регистрации (обновления) нажмите "Продолжить"</asp:Label>
					</td>
				</tr>
				<tr>
					<td colSpan="3">
						<table class="InnerTable">
							<tr>
								<td width="1%">
									<input id="btShow" meta:resourcekey="btShow" class="AcceptButton" onclick="if (ckRNK()) showClient()" type="button"
										value="Просмотр" tabIndex="1" runat="server">
								</td>
								<td width="1%">
									<asp:Button id="btContinue" meta:resourcekey="btContinue" runat="server" CssClass="AcceptButton" Text="Продолжить" tabIndex="2"></asp:Button>
								</td>
								<td width="100%">
									<input id="btBack" meta:resourcekey="btBack" onclick="history.back();" type="button" class="AcceptButton" value="Назад"
										tabIndex="3" runat="server">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="3">
						<input id="rnk" type="hidden" runat="server">
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
