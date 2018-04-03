<%@ Page language="c#" CodeFile="PhoneState.aspx.cs" AutoEventWireup="false" Inherits="mobinet.PhoneState" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Справка о состоянии счета телефонного номера</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="/Common/CSS/AppCSS.css" type="text/css" rel=Stylesheet />
		<STYLE> @media Print { .screen_action { DISPLAY: none }}
		</STYLE>
	</HEAD>
	<body>
		<form id="FormPhoneState" method="post" runat="server">
			<DIV class="print_action">
				<b>Справка о состоянии счета телефонного номера</b>
			</DIV>
			<DIV class="print_action" align="center">
				<HR width="100%" SIZE="1">
			</DIV>
			<DIV class="print_action">
				<TABLE id="TableInfo" cellSpacing="0" cellPadding="2" border="0">
					<TR>
						<TD>Номер телефона:</TD>
						<TD><asp:Label id="label_phone" runat="server">номер телефона</asp:Label>
						</TD>
					</TR>
					<TR>
						<TD>Номер счета:</TD>
						<TD>
							<asp:Label id="label_account" runat="server">номер счета</asp:Label></TD>
					</TR>
					<TR>
						<TD>Имя (у оператора):</TD>
						<TD>
							<asp:Label id="label_name" runat="server">имя у оператора</asp:Label></TD>
					</TR>
					<TR>
						<TD>Баланс:</TD>
						<TD>
							<asp:Label id="label_balance" runat="server">баланс грн</asp:Label></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
						<TD>&nbsp;</TD>
					</TR>
					<TR>
						<TD>Оператор:</TD>
						<TD>
							<asp:Label id="label_operator" runat="server">ЗАО "Киевстар GSM"</asp:Label></TD>
					</TR>
					<TR>
						<TD>Дата выдачи:</TD>
						<TD>
							<asp:Label id="label_timestamp" runat="server">дата выдачи</asp:Label></TD>
					</TR>
				</TABLE>
			</DIV>
			<DIV class="print_action" align="center">
				<HR width="100%" SIZE="1">
			</DIV>
			<DIV class="print_action" align="center">&nbsp;</DIV>
			<DIV class="screen_action" align="center">
				<INPUT type="button" value="Печать" onclick="window.print()">
			</DIV>
		</form>
	</body>
</HTML>
