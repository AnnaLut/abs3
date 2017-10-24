<%@ Page language="c#" CodeFile="DepositAgreementTemplate.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementTemplate" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозптний модуль: Формування додаткових угод</title>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
	</head>
	<body onload="focusControl('btForm');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center" colspan="2">
						<asp:Label id="lbTitle" meta:resourcekey="lbTitle7" runat="server" CssClass="InfoLabel">Выбор шаблона доп. соглашения</asp:Label>
					</td>
				</tr>
				<tr>
					<td style="width:30%">
						<asp:Label id="lbDpt_id" meta:resourcekey="lbDpt_id" CssClass="InfoText" runat="server" Text="Депозитный договор №"></asp:Label>
					</td>
					<td>
						<asp:TextBox id="text_dpt_num" CssClass="InfoText" runat="server" ReadOnly="True"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Label id="lbAgr_id" meta:resourcekey="lbAgr_id" runat="server" CssClass="InfoText">Тип доп. соглашения</asp:Label>
					</td>
					<td>
						<asp:TextBox id="text_agr_id" runat="server" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:DataGrid id="gridTemplate" runat="server" CssClass="BaseGrid" AutoGenerateColumns="False"
							EnableViewState="False">
							<Columns>
								<asp:BoundColumn Visible="False" DataField="id"></asp:BoundColumn>
								<asp:BoundColumn DataField="name" HeaderText="Наименование шаблона"></asp:BoundColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>
						<input id="btForm" meta:resourcekey="btForm3" type="button" value="Выбрать" class="AcceptButton" runat="server" tabindex="1"/>
					</td>
					<td>
						<input id="Template_id" type="hidden" runat="server"/>
                        <input id="hid_agr_id" type="hidden" runat="server"/>
						<input id="OP" type="hidden" runat="server"/>
                        <input id="rnk" type="hidden" runat="server"/>
						<input id="WORNSUM" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
