<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vip_template.aspx.cs" Inherits="clientregister_vip_template" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="frm_vip_template" runat="server">
    <div>
    <table>
        <tr>
            <td>
                <asp:TextBox runat="server" ID="tbTemplate" TextMode="MultiLine" BackColor="#facfc5" Width="100%" Height="400Px"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td>
                <asp:Button id="btSave" runat="server" Text="Зберегти" OnClick="btSave_Click"/>
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
