<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="swi_default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Платіжні системи</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="pageTitle">
        <asp:Label ID="lbPageTitle" runat="server" Text="Платіжні системи"></asp:Label>
    </div>
    <br />
    <asp:Table runat="server" ID="tabCstList">
    </asp:Table>
    </form>
</body>
</html>
