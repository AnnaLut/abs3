<%@ Page Language="C#" AutoEventWireup="true" CodeFile="doprekv.aspx.cs" Inherits="DopRekv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Доп. Реквизиты</title>
	<link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
        <asp:GridView ID="grdRes" runat="server" AutoGenerateColumns="False" EnableViewState="False">
            <Columns>
                <asp:BoundField DataField="NAME" HeaderText="Реквизит" meta:resourcekey="BoundFieldResource1" />
                <asp:BoundField DataField="VALUE" HeaderText="Значение" meta:resourcekey="BoundFieldResource2" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
