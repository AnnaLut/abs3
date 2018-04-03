<%@ Page language="c#" CodeFile="DepositCancelAgreement.aspx.cs" AutoEventWireup="false" Inherits="DepositCancelAgreement"  enableViewState="False"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Відміна діючої додаткової угоди</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
	</HEAD>
	<body onload="focusControl('btCancel');">
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD align="center">
						<asp:Label id="lbInfo" runat="server" CssClass="InfoLabel">Скасування існуючої дод. угоди</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:DataGrid id="gridAgreement" runat="server" CssClass="BaseGrid" AutoGenerateColumns="False"
							EnableViewState="False">
							<Columns>
								<asp:BoundColumn DataField="adds" HeaderText="№">
									<HeaderStyle Width="3%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="version" HeaderText="Версія">
									<HeaderStyle Width="17%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="agr_id"></asp:BoundColumn>
								<asp:BoundColumn DataField="agr_name" HeaderText="Назва">
									<HeaderStyle Width="40%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="template"></asp:BoundColumn>
								<asp:BoundColumn Visible="False" DataField="rnk"></asp:BoundColumn>
								<asp:BoundColumn DataField="nmk" HeaderText="3 особа">
									<HeaderStyle Width="30%"></HeaderStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="comm" HeaderText="Статус">
									<HeaderStyle Width="10%"></HeaderStyle>
								</asp:BoundColumn>
							</Columns>
						</asp:DataGrid>
					</TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="btCancel" type="button" value="Скасувати угоду" runat="server" class="AcceptButton">
					</TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="rnk" type="hidden" runat="server"> <INPUT id="dpt_id" type="hidden" runat="server">
						<INPUT id="template" type="hidden" runat="server"> <INPUT id="agr_id" type="hidden" runat="server">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
