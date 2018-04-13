<%@ Page language="c#" CodeFile="DepositAgreementBeneficiary.aspx.cs" AutoEventWireup="true" Inherits="DepositAgreementBeneficiary"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Вступ 3-ї особи в права</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="C#"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<script type="text/javascript" language="javascript" src="js/ck.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
	</head>
	<body onload="focusControl('btEnter')">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td>
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:70%">
									<asp:Label id="lbInfo" meta:resourcekey="lbInfo7" CssClass="InfoLabel" runat="server" Text="Вступление 3 лица в права по депозитному договору №"></asp:Label>
								</td>
								<td align="left">
									<asp:TextBox id="dpt_num" CssClass="HeaderText" runat="server" ReadOnly="True"></asp:TextBox>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid id="gridAgreement" runat="server" AutoGenerateColumns="False" EnableViewState="False"
							CssClass="BaseGrid">
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
						<input id="btEnter" meta:resourcekey="btEnter" type="button" value="Вступить в права" class="AcceptButton" runat="server"/>
					</td>
				</tr>
				<tr>
					<td>
						<input id="template" type="hidden" runat="server"/> <input id="rnk" type="hidden" runat="server"/>
						<input id="TRUST_ID" type="hidden" runat="server"/><input id="dpt_id" type="hidden" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="Inc/DepositCk.inc"-->
			<!-- #include virtual="Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
