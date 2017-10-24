<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Load_tikets_cp.aspx.cs" Inherits="tools_Load_tikets_cp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%">
    <tr>
    <td style="width: 150Px"><asp:Label ID="lb_ref" runat="server" Text="Референс угоди"></asp:Label></td>
    <td><asp:TextBox ID="Tb_ref" runat="server" Enabled="true" ReadOnly="True"></asp:TextBox>
        <asp:ImageButton ID="Bt_save" runat="server" ImageUrl="/Common/Images/default/16/save.png"
                            CausesValidation="false" TabIndex="7" ToolTip="повернутись на попередню сторінку"
                            OnClick="saveToFolders" Width="16px" />
    </td>
    </tr>
    <tr>
    <td colspan = "2">
    <asp:TextBox ID="TB_ticets" runat="server" Width="100%" Height="600px" Rows="2000" TextMode="MultiLine"></asp:TextBox>
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
