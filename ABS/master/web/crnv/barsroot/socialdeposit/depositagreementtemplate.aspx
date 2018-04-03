<%@ Page language="c#" CodeFile="DepositAgreementTemplate.aspx.cs" AutoEventWireup="false" Inherits="DepositAgreementTemplate" enableViewState="False" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Формування додаткових угод</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
	</HEAD>
	<body onload="focusControl('btForm');">
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD align="center" colSpan="2">
						<asp:Label id="lbTitle" runat="server" CssClass="InfoLabel">Вибір шаблону дод. угоди</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD width="30%">
						<asp:Label id="lbDpt_id" CssClass="InfoText" runat="server">Соціальний договір №</asp:Label>
					</TD>
					<TD>
						<asp:TextBox id="text_dpt_num" CssClass="InfoText" runat="server" ReadOnly="True"></asp:TextBox>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:Label id="lbAgr_id" runat="server" CssClass="InfoText">Тип дод. угоди</asp:Label>
					</TD>
					<TD>
						<asp:TextBox id="text_agr_id" runat="server" ReadOnly="True" CssClass="InfoText"></asp:TextBox>
					</TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD colSpan="2">
						<asp:DataGrid id="gridTemplate" runat="server" CssClass="BaseGrid" AutoGenerateColumns="False"
							EnableViewState="False">
							<Columns>
								<asp:BoundColumn Visible="False" DataField="id"></asp:BoundColumn>
								<asp:BoundColumn DataField="name" HeaderText="Найменування шаблону"></asp:BoundColumn>
							</Columns>
						</asp:DataGrid>
					</TD>
				</TR>
				<TR>
					<TD colSpan="2"></TD>
				</TR>
				<TR>
					<TD>
						<INPUT id="btForm" type="button" value="Вибрати" class="InfoText" runat="server" tabIndex="1">
					</TD>
					<TD>
						<INPUT id="Template_id" type="hidden" runat="server"> <INPUT id="hid_agr_id" type="hidden" runat="server">
						<INPUT id="OP" type="hidden" runat="server">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
