<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bis.aspx.cs" Inherits="BIS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BIS</title>
    <link href="CSS/AppCSS.css" type="text/css" rel="Stylesheet" />
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <asp:GridView ID="grd_Data" runat="server" AutoGenerateColumns="False" EnableViewState="False">
            <Columns>
                <asp:BoundField DataField="BIS" HeaderText="Значение" meta:resourcekey="BoundFieldResource1" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
