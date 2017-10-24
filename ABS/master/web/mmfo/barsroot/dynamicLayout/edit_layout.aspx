<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_layout.aspx.cs" Inherits="edit_layout" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Динамічний макет - 2</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>
<%--<script language="javascript" type="text/javascript">
     

</script>--%>
<body bgcolor="#f0f0f0">
    <form id="formDinamicLayouts" runat="server" style="vertical-align: central">
        <br />
        <table>
            <tr>
                <td colspan="4" align="left">
                    <asp:RadioButtonList ID="rbListDk" runat="server" RepeatDirection="Horizontal" TextAlign="Left">
                        <asp:ListItem Value="1" Text="Деб" Selected="False"></asp:ListItem>
                        <asp:ListItem Value="0" Text="Кред" Selected="False"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="lbName" runat="server" Text="Назава макету"></asp:Label>
                </td>
                <td colspan="3">
                    <Bars2:BarsTextBox ID="tbName" runat="server" Enabled="false" Width="200px"></Bars2:BarsTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="lbNls" runat="server" Text="Рахунок А"></asp:Label>
                </td>
                <td colspan="3">
                    <Bars2:BarsTextBox ID="tbNls" runat="server" Enabled="true" MaxLength="14" Width="200px"></Bars2:BarsTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="lbBs" runat="server" Text="БалР Б"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsTextBox ID="tbBs" runat="server" Enabled="true" MaxLength="4" Width="80px"></Bars2:BarsTextBox>
                </td>
                <td>
                    <asp:Label ID="lbOb" runat="server" Text="ОБ22 Б"></asp:Label>
                </td>
                <td>
                    <Bars2:BarsTextBox ID="tbOb" runat="server" Enabled="true" MaxLength="2" Width="50px"></Bars2:BarsTextBox>
                </td>
            </tr>
            <tr>
                <td style="text-align: right">
                    <asp:Label ID="lbNazn" runat="server" Text="Призначення"></asp:Label>
                </td>
                <td colspan="3">
                    <Bars2:BarsTextBox ID="tbNazn" runat="server" Enabled="true" MaxLength="160" Width="200px"></Bars2:BarsTextBox>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <cc1:ImageTextButton ID="ibtOk" runat="server" Text="Застосувати" ToolTip="Виконати розрахунок по макету" ImageUrl="/common/images/default/16/ok.png" OnClick="btOK_Click" />
                </td>
                <td align="center" colspan="2">
                    <cc1:ImageTextButton ID="btCancel" runat="server" Text="Назад" ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
