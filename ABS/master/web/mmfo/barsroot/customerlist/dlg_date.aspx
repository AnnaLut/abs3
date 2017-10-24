<%@ Page Language="C#" AutoEventWireup="true" CodeFile="dlg_date.aspx.cs" Inherits="customerlist_dlg_date" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEx" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title title="Обороти за період">Обороти за період</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
    <link href="/Common/CSS/barsextenders.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebEdit/NumericEdit.js"></script>
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
         <div>
            <table>
                <tr>
                    <td>
                        <br>Обороти за період
                        </br>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbDat1" Text="Дата З"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                        <bec:TextBoxDate runat="server" ID="tbDat1" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbDat2" Text="Дата По"></asp:Label>
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                        <bec:TextBoxDate runat="server" ID="tbDat2" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>
                        <asp:Button runat="server" ID="btApply" Text="Застосувати" OnClick="btApply_Click" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
