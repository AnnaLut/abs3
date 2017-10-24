<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentPrint.aspx.cs" Inherits="DocumentPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Друк документів</title>
    <link href="style/style.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="script/JScript.js"></script>                
</head>
<body>
    <form id="form1" runat="server">
		<table class="MainTable">
			<tr>
				<td align="center">
				    <asp:label id="lbTitle" runat="server" 
				    CssClass="InfoLabel">Вибір документів для друку</asp:label></td>
			</tr>
			<tr>
				<td>
				    <asp:datagrid id="gridContract" runat="server" CssClass="BaseGrid"></asp:datagrid>
				</td>
			</tr>
			<tr>
				<td>
				    <input id="_ID" type="hidden" runat="server"/>
				</td>
			</tr>
		</table>
    </form>
</body>
</html>
