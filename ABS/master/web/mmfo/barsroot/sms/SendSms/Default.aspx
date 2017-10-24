<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="sms_SendSms_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Відправка СМС</title>
</head>
<body>
    <form id="form1" runat="server">
    <ajx:ToolkitScriptManager ID="sm" runat="server" />
    <div class="pageTitle">
        <asp:Label ID="lbTitle" runat="server" Text="Відправка СМС" />
    </div>
    <table>
          <tr>
            <td>
                <asp:Label ID="lb_ph" runat="server" Text="Телефон:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_ph" runat="server" ToolTip="Телефон" Text="+380971499529"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lb_text" runat="server" Text="Текст повідомлення:"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="tb_text" runat="server" Width="140" Height="90" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="bt_send" runat="server" Text="Відіслати" ToolTip="Відіслати повідомлення!"
                    OnClick="bt_send_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
