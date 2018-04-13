<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="perfom_default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Тестирование производительности</title>
</head>
<body>
    <form id="formPerfom" runat="server">
    <div style="text-align:center">
        <table>
            <tr>
                <td align="center" colspan="3">
                    <asp:Label ID="lbTitle" runat="server" Font-Bold="True" Text="Тестирование производительности веб-сервера"></asp:Label></td>
            </tr>
            <tr>
                <td align=right style="white-space:nowrap">
                    <asp:Label ID="Label1" runat="server" Text="Пустой postback:"></asp:Label></td>
                <td>
                    <asp:Button ID="btRunSimple" runat="server" Text="Запуск" OnClick="btRunSimple_Click" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td align=right style="white-space:nowrap">
                    <asp:Label ID="Label2" runat="server" Text="Postback данных:"></asp:Label></td>
                <td><asp:Button ID="btRunPostData" runat="server" Text="Запуск" OnClick="btRunPostData_Click" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td align=right style="white-space:nowrap">
                    <asp:Label ID="Label3" runat="server" Text="Простой connect:"></asp:Label></td>
                <td><asp:Button ID="btRunConnect" runat="server" Text="Запуск" OnClick="btRunConnect_Click" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td align=right style="white-space:nowrap">
                    <asp:Label ID="Label4" runat="server" Text="Connect c нагрузкой:"></asp:Label></td>
                <td><asp:Button ID="btRunHardConnect" runat="server" Text="Запуск" OnClick="btRunHardConnect_Click" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:TextBox ID="tbResult" runat="server" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
