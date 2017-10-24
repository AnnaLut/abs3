<%@ Page language="c#" CodeFile="DepositSelectTrustee.aspx.cs" AutoEventWireup="false" Inherits="DepositSelectTrustee"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Соціальні депозити: Вибір довіреної особи</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="C#" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link href="style.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="Scripts/Default.js"></script>
	</head>
	<body onload="focusControl('btTrustee');">
		<form id="Form1" method="post" runat="server">
			<table class="MainTable">
				<tr>
					<td colSpan="2">
						<table class="InnerTable">
							<tr>
								<td align="right" style="width:80%">
								    <asp:label id="lbCurDopAgr" runat="server" CssClass="InfoLabel">Вибір довіреної особи для оформлення дод. угоди по договору №</asp:label>
								</td>
								<td align="left"><asp:textbox id="dpt_num" runat="server" CssClass="HeaderText" ReadOnly="True"></asp:textbox></TD>
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
								<asp:BoundColumn DataField="version" HeaderText="Версія">
									<HeaderStyle Width="15%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="rnk"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Назва">
									<HeaderStyle Width="35%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 особа">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="18%"></HeaderStyle>
								</asp:BoundColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
				<tr>
					<td colSpan="2"></td>
				</tr>
				<tr>
					<td style="width:50%">
					    <input class="AcceptButton" id="btTrustee" tabIndex="1"
							type="button" value="Оформити на довірену особу" runat="server" onserverclick="btTrustee_ServerClick1"/>
					</td>
					<td style="width:50%">
					    <input class="AcceptButton" id="btOwner" tabIndex="2" type="button" value="Оформити на власника"
							runat="server"/> <input id="dest" type="hidden" name="dest" runat="server"/>
					</td>
				</tr>
				<tr>
					<td colSpan="2">
					    <input id="rnk" type="hidden" name="rnk" runat="server"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
