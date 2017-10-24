<%@ Page language="c#" CodeFile="DepositSelectTrustee.aspx.cs" AutoEventWireup="true" Inherits="DepositSelectTrustee"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html xmlns="http://www.w3.org/1999/xhtml">
	<head id="Head1" runat="server">
		<title>Депозитний модуль: Вибір довіреної особи</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="/barsroot/deposit/style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/js.js"></script>
		<script type="text/javascript" language="javascript" src="/barsroot/deposit/js/ck.js"></script>
	</head>
	<body onload="focusControl('btTrustee');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td colspan="2">
						<table class="InnerTable">
							<tr>
								<td align="right" width="60%"><asp:label id="lbCurDopAgr" meta:resourcekey="lbCurDopAgr" runat="server" CssClass="InfoLabel" Text="Выбор довереного лица по депозитному договору №"></asp:label></td>
								<td align="left"><asp:textbox id="dpt_num" runat="server" CssClass="HeaderText" ReadOnly="True"></asp:textbox></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colSpan="2"><asp:datagrid id="gridTrustee" runat="server" CssClass="BaseGrid" EnableViewState="False" HorizontalAlign="Left"
							AutoGenerateColumns="False">
							<Columns>
								<asp:BoundColumn DataField="adds" HeaderText="№">
									<HeaderStyle Width="2%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="version" HeaderText="Версия">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="rnk"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Название">
									<HeaderStyle Width="35%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 лицо">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="18%"></HeaderStyle>
								</asp:BoundColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
				<tr>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td width="50%">
                        <input type="button" id="btTrustee" meta:resourcekey="btTrustee" tabIndex="1" class="AcceptButton"
							value="Оформить на довереное лицо" runat="server"/>
					</td>
					<td width="50%">
                        <input type="button" id="btOwner" meta:resourcekey="btOwner" tabindex="2" class="AcceptButton"
                            value="Оформить на владельца" runat="server" />
                        <input id="dest" type="hidden" name="dest" runat="server"/>
					</td>
				</tr>
				<tr>
					<td colspan="2"><input id="rnk" type="hidden" name="rnk" runat="server"/>
					</td>
				</tr>
			</table>
			<!-- #include virtual="/barsroot/deposit/Inc/DepositCk.inc"-->
			<!-- #include virtual="/barsroot/deposit/Inc/DepositJs.inc"-->
		</form>
	</body>
</html>
