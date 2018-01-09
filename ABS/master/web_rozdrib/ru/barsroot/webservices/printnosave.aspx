<%@ Page Language="C#" AutoEventWireup="true" CodeFile="printnosave.aspx.cs" Inherits="webservices_printnosave" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Друк</title>
    <meta name="DownloadOptions" content="nosave">
    <script language=javascript>
        function setTimer()
        {
            window.setInterval('window.close()',5000);
        }
    </script>
</head>
<body onload="__doPostBack('btPrint','');setTimer();">
    <form id="form1" runat="server">
        <asp:Label ID="lbPrint" runat="server" Text="Зачекайте, йде формування файлу для друку...." Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Вікно закриється автоматично." Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"></asp:Label>
        <asp:Button ID="btPrint" runat="server" OnClick="btPrint_Click" Text="Print" style="visibility:hidden" />
        <input type=hidden runat=server id=isPrint value=0 />
    </form>
</body>
</html>
