<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Анкетування</title>
    <link href="style/StyleSheet.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <form id="form1" runat="server">
        <TABLE style="Z-INDEX: 105; LEFT: 0px; POSITION: absolute; TOP: 0px" cellSpacing="1"
				cellPadding="1" width="100%" border="0" height="100%">
				<TR>
					<TD height="40%"></TD>
				</TR>
				<TR>
					<TD align="center">
							<asp:Label id="labelWelcome" runat="server" Font-Names="Arial" Font-Size="16pt" Font-Bold="True"
								EnableViewState="False">Дякуємо за участь в анкетуванні!</asp:Label>
					</TD>
				</TR>
				<TR>
					<TD height="60%" vAlign="bottom" align="right"></TD>
				</TR>
			</TABLE>
	</form>
</body>
</html>
