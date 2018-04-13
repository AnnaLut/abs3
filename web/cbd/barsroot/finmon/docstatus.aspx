<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docstatus.aspx.cs" Inherits="finmon_docstatus" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Статуси документу</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    window.onunload = refreshParent;
    function refreshParent() {
        window.opener.location.reload();
    }

    window.onunload = Ok;
    function Ok() {
        var vReturnValue = new Object();
        vReturnValue.close = "ok";
        window.returnValue = vReturnValue;
        window.close();
    }

    function closing() {
        alert("Статус зміненно.");
    }



</script>
<body bgcolor="#f0f0f0">
    <form id="formFinMonFilter" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server"></asp:Label>
        </div>
        <table>
            <tr align="right">
                <td colspan="2">
                    <asp:TextBox ID="tbComent" runat="server" Width="580px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="ImageTextButton1" runat="server" Text="Застосувати" ImageUrl="/common/images/default/16/ok.png" OnClick="btSearch_Click" />
                </td>
                <td align="center" style="width: 50%">
                    <cc1:ImageTextButton ID="btCancel" runat="server" Text="Закрити" ImageUrl="/common/images/default/16/cancel.png" OnClientClick="close()" />
                </td>
            </tr>
        </table>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
