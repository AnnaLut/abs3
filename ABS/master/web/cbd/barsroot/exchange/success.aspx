<%@ Page Language="C#" AutoEventWireup="true" CodeFile="success.aspx.cs" Inherits="Success" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Файл успешно оплачен</title>
</head>
<body>
    <form id="formSuccess" runat="server" enableviewstate="false">
    <div>
        <asp:Label ID="label_success" runat="server" EnableViewState="False" meta:resourcekey="label_successResource1">Файл</asp:Label>&nbsp;
        <asp:Label ID="label_fn" runat="server" Text="$B____" meta:resourcekey="label_fnResource1"></asp:Label>&nbsp;
        <asp:Label ID="label_info" runat="server" Text="успешно оплачен." EnableViewState="False" meta:resourcekey="label_infoResource1"></asp:Label><br />
        <br />
        <asp:HyperLink ID="link_next" runat="server" EnableViewState="False" meta:resourcekey="link_nextResource1" NavigateUrl="/ab_exchange/Default.aspx">Выполнить импорт следующего файла</asp:HyperLink></div>
    </form>
</body>
</html>
