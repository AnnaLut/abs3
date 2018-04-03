<%@ Page language="c#" CodeFile="DepositShowClients.aspx.cs" AutoEventWireup="false" Inherits="DepositShowClients" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Соціальні депозити: Перегляд існуючих клієнтів</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="style.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="Scripts/Default.js"></script>
	</HEAD>
	<body onload="focusControl('btShow');">
		<form id="Form1" method="post" runat="server">
			<TABLE class="MainTable">
				<TR>
					<TD align="center">
						<asp:Label id="lbTitle" runat="server" CssClass="InfoHeader">Увага! З вказаним ідентифікаційним кодом вже існують зареєстровані клієнти</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:DataGrid id="gridClients" runat="server" CssClass="BaseGrid" DataSource="<%# dsClients %>">
						</asp:DataGrid>
					</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:Label id="Label1" runat="server" CssClass="InfoLabel">Для реєстрації (обновлення) натисніть "Продовжити"</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<TABLE class="InnerTable">
							<TR>
								<TD width="1%">
									<INPUT id="btShow" class="AcceptButton" onclick="if (ckRNK()) showClient()" type="button"
										value="Перегляд" tabIndex="1">
								</TD>
								<TD width="1%">
									<asp:Button id="btContinue" runat="server" CssClass="AcceptButton" Text="Продовжити" tabIndex="2"></asp:Button>
								</TD>
								<TD width="100%">
									<INPUT id="btBack" onclick="history.back();" type="button" class="AcceptButton" value="Назад"
										tabIndex="3" runat="server">
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD colSpan="3">
						<INPUT id="rnk" type="hidden" runat="server">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
