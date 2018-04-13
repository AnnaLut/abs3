<%@ Page language="c#" CodeFile="DepositDelete.aspx.cs" AutoEventWireup="true" Inherits="DepositDelete"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Депозитний модуль: Видалення депозиту</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	</head>
	<body onload="focusControl('btCancel');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center">
						<asp:Label id="lbDepositClose" meta:resourcekey="lbDepositClose" runat="server" CssClass="InfoHeader">Удаление депозитного договора № %s</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td width="30%">
									<asp:label id="lbClientInfo" meta:resourcekey="lbClientInfo" runat="server" CssClass="InfoLabel">Вкладчик</asp:label>
								</td>
								<td width="70%">
									<asp:textbox id="textClientName" meta:resourcekey="textClientName3" runat="server" ReadOnly="True" ToolTip="Вкладчик" CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td></td>
								<td>
									<asp:textbox id="textClientPasp" meta:resourcekey="textClientPasp" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Информация о вкладчике"
										CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
							<tr>
								<td>
									<asp:label id="lbContractType" meta:resourcekey="lbContractType" runat="server" CssClass="InfoLabel">Вид договора</asp:label>
								</td>
								<td>
									<asp:textbox id="textContractTypeName" meta:resourcekey="textContractTypeName" runat="server" BorderStyle="Inset" ReadOnly="True" ToolTip="Вид договора"
										CssClass="InfoText"></asp:textbox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label id="lbDepDeleteConfirm" meta:resourcekey="lbDepDeleteConfirm" runat="server" CssClass="InfoLabel" ForeColor="Red">Вы подтверждаете удаление этого договора?</asp:Label>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td style="width:50%">
								    <input type="button" id="btShowDepositCard" onclick="ShowDepositCard(document.getElementById('dpt_id').value)" meta:resourcekey="btShowDepositCard" runat="server" value="Просмотр депозита" tabindex="1" class="AcceptButton"/>
                                </td>
								<td style="width:50%">
									<asp:Button id="btConfirmDelete" meta:resourcekey="btConfirmDelete" runat="server" Text="Подтверждаю удаление" tabIndex="2" CssClass="AcceptButton"></asp:Button>
								</td>
							</tr>
							<tr>
							    <td style="height: 26px">
									<asp:Button id="btCancel" meta:resourcekey="btCancel" runat="server" Text="Отмена" tabIndex="3" CssClass="AcceptButton"></asp:Button>
							    </td>
							    <td style="height: 26px">
									<asp:Button id="btNext" meta:resourcekey="btNext" runat="server" Text="Следующий" Visible="False" tabIndex="4" CssClass="AcceptButton"></asp:Button>
							    </td>
							</tr>
						</table>
						<input type="hidden" runat="server" id="dpt_id" />
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label id="lbAlert" meta:resourcekey="lbAlert" runat="server" ForeColor="Red" Visible="False" CssClass="InfoLabel">Договор №%s был успешно удалён</asp:Label>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
