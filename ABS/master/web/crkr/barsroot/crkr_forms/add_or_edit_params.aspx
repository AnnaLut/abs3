<%@ Page Language="C#" AutoEventWireup="true" CodeFile="add_or_edit_params.aspx.cs" Inherits="add_or_edit_crkr_params" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Src="../credit/usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="Bars" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <script src="../documentsview/Script.js" type="text/javascript"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script src="../documentsview/Script.js" type="text/javascript"></script>

    <script type="text/javascript">
        //var vCloseValue = new Object();
        //vCloseValue.code = -1;
        //window.returnValue = vCloseValue;

        //function Close(code) {
        //    alert(code);
        //    var vReturnValue = new Object();
        //    vReturnValue.code = code;
        //    window.returnValue = vReturnValue;
        //    window.close();
        //}
    </script>
</head>
<body bgcolor="#f0f0f0">
    <form id="formCrkrParams" runat="server" style="vertical-align: central">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:Panel ID="pnAddOrEditParam" runat="server" GroupingText="" Style="margin-left: 10px; margin-right: 10px">
            <br />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lbParTypes" runat="server" Text="Вид"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlParTypes" runat="server" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlParTypes_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbParams" runat="server" Text="Найменування"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlParams" runat="server" Width="350px"></asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbValue" runat="server" Text="Значення"></asp:Label>
                    </td>
                    <td colspan="2">
                        <Bars2:BarsNumericTextBox ID="tbValue" runat="server" NumberFormat-DecimalSeparator="." NumberFormat-GroupSeparator=" "></Bars2:BarsNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDateFrom" runat="server" Text="З "></asp:Label>
                    </td>
                    <td colspan="2">
                        <bars:DateEdit ID="deDateFrom" runat="server"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbDateTo" runat="server" Text="По "></asp:Label>
                    </td>
                    <td colspan="2">
                        <bars:DateEdit ID="deDateTo" runat="server"></bars:DateEdit>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbIsEnable" runat="server" Text="   Статус"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:DropDownList ID="ddlIsEnable" runat="server" Width="100px">
                            <asp:ListItem Text="Діє" Value="1" />
                            <asp:ListItem Text="Не діє" Value="0" />
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                    </td>
                </tr>
            </table>
            <table width="20%">
                <tr>
                    <td align="center" style="width: 50%">
                        <cc1:ImageTextButton ID="btSave" runat="server" Text="Зберегти" ImageUrl="/common/images/default/16/ok.png" OnClick="btOK_Click" />
                    </td>
                    <td align="center" style="width: 50%">
                        <cc1:ImageTextButton ID="btCancel" runat="server" Text="Назад" ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
