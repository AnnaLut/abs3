<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Load_corp2_docs.aspx.cs"
    Inherits="tools_Load_corp2_docs"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <dl>
        <dd>
            <h1>
                <asp:Label ID="Lb_title" runat="server" Font-Italic="True" Font-Strikeout="False"
                    Font-Underline="True" Style="color: #0066FF; font-weight: 700">Валютні платежі Corp2</asp:Label>
            </h1>
        </dd>
    </dl>
    <div>
        <asp:Panel ID="Pn_dat" runat="server">
            <table>
                <tr>
                    <td style="width: 155Px">
                        <asp:Label ID="Lb1" runat="server" Text="Дата з" Visible="true"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate ID="DAT1" runat="server" IsRequired="true" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Lb2" runat="server" Text="Дата по" Visible="true"></asp:Label>
                    </td>
                    <td>
                        <bec:TextBoxDate ID="DAT2" runat="server" IsRequired="true"/>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <bars:ImageTextButton ID="Bt_save" runat="server" Text="Завантажити" Width="155px" 
                            Height="30Px" OnClick="saveToFolders" ImageUrl="/Common/Images/default/16/save.png"
                            Enabled="true" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
