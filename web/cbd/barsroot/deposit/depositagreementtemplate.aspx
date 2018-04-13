<%@ Page language="c#" CodeFile="DepositAgreementTemplate.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementTemplate" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозптний модуль: Формування додаткових угод</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
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
						<input id="btForm" meta:resourcekey="btForm3" type="button" value="Выбрать" class="AcceptButton" runat="server" tabIndex="1"/>
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
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
