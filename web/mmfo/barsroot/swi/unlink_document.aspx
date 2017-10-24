<%@ Page Language="C#" AutoEventWireup="true" CodeFile="unlink_document.aspx.cs" Inherits="swi_unlink_document" %>
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Видалення прив'язки документу</title>
</head>
<body>
    <form id="frm_unlink" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lbRef" Text="Референс:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="tbRef"></asp:TextBox>
                </td>
                <td>
                    <asp:Button runat="server" ID="btSearh" Text="Переглянути" OnClick="btSearh_Click"/>
                </td>
                <td>
                    <asp:Button runat="server" ID="btUnlink" Text="Відкріпити" OnClick="btUnlink_Click" OnClientClick='return confirm("Відкріпити документ?")'/>
                </td>
            </tr>
        </table>
    </div>
     <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
