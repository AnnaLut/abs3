<%@ Page language="c#" CodeFile="DepositCancelAgreement.aspx.cs" AutoEventWireup="true" Inherits="DepositCancelAgreement"  enableViewState="False"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Відміна діючої додаткової угоди</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
	</head>
	<body onload="focusControl('btCancel');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td align="center">
						<asp:Label id="lbInfo" meta:resourcekey="lbInfo8" runat="server" CssClass="InfoLabel">Отмена действующего доп. соглашения </asp:Label>
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid id="gridAgreement" runat="server" CssClass="BaseGrid" AutoGenerateColumns="False"
							EnableViewState="False">
							<Columns>
								<asp:BoundColumn DataField="adds" HeaderText="№">
									<HeaderStyle Width="3%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="version" HeaderText="Версия">
									<HeaderStyle Width="17%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="agr_id"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Название">
									<HeaderStyle Width="40%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="rnk_tr"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 лицо">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="10%"></HeaderStyle>
								</asp:BoundColumn>
                                <asp:BoundColumn DataField="TRUST_ID" Visible="False"></asp:BoundColumn>
							</Columns>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td>
						<input id="btCancel" meta:resourcekey="btCancel3" type="button" value="Отменить доп. соглашение" runat="server" class="AcceptButton"/>
					</td>
				</tr>
				<tr>
					<td>
						<input id="rnk" type="hidden" runat="server"/> <input id="dpt_id" type="hidden" runat="server"/>
						<input id="template" type="hidden" runat="server"/> <input id="agr_id" type="hidden" runat="server"/>
						<input id="TRUST_ID" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
