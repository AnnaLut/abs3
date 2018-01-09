<%@ Page language="c#" Inherits="barsweb.SberMbo"  enableViewState="False" CodeFile="SberMbo.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Welcome</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body bgColor="#f0f0f0">
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<TABLE id="Table1" style="Z-INDEX: 105; LEFT: 0px; POSITION: absolute; TOP: 0px" height="100%"
				cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="center" height="40%">
						<asp:Image id="Image2" runat="server" ImageUrl="../images/sber_log.gif"></asp:Image></TD>
				</TR>
				<TR>
					<TD align="center">
						<P><asp:label id="labelWelcome" runat="server" Font-Italic="True" ForeColor="Navy" EnableViewState="False"
								Font-Size="16pt" Font-Names="Arial">Добро пожаловать</asp:label><BR>
							<BR>
							<asp:label id="labelBARS" runat="server" Font-Italic="True" ForeColor="Navy" EnableViewState="False"
								Font-Size="16pt" Font-Names="Arial">в модуль "Специализированые вкладные операции"</asp:label></P>
						<P><asp:label id="Label2" runat="server" Font-Italic="True" ForeColor="Navy" EnableViewState="False"
								Font-Size="16pt" Font-Names="Arial">АБС "БАРС Милленниум"</asp:label><BR>
							<asp:label id="labelBankdateClosed" runat="server" ForeColor="Red" EnableViewState="False"
								Font-Size="10pt" Font-Names="Arial" Font-Bold="True"></asp:label><BR>
							<BR>
							<asp:label id="labelUseARMMenu" runat="server" EnableViewState="False" Font-Size="10pt" Font-Names="Arial"
								Font-Bold="True"> Используйте меню АРМов в левой части экрана для выбора задачи.</asp:label></P>
						<P>&nbsp;</P>
					</TD>
				</TR>
				<TR>
					<TD vAlign="top" align="center" height="60%"></TD>
				</TR>
				<TR>
					<TD vAlign="bottom" align="right" height="60%"><asp:label id="Label1" runat="server" Font-Size="8pt" Font-Names="Verdana">Copyright © 2004-2006, UNITY-BARS </asp:label></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
