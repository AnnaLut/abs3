<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositwornoutbills.aspx.cs" Inherits="deposit_dialog_depositwornoutbills" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Прийом на вклад зношених купюр</title>
		<base target="_self" />
		<link href="../style/dpt.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" language="javascript" src="../js/ck.js"></script>
		<script type="text/javascript" language="javascript" src="../js/js.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" Text="Укажите сумму ветхих купюр" CssClass="InfoHeader" meta:resourcekey="lbTitleResource1"></asp:Label></td>
        </tr>
        <tr>
            <td align="center">
                <cc1:NumericEdit ID="SUM" runat="server" meta:resourcekey="SUMResource1" Value="0"></cc1:NumericEdit>
            </td>
        </tr>
        <tr>
            <td align="center">
                <cc1:ImageTextButton ID="btSubmit" runat="server" CssClass="AcceptButton" ImageUrl="\Common\Images\default\16\ok.png" Text="Далее" 
                    EnabledAfter="0" meta:resourcekey="btSubmitResource1" ToolTip="Далее" OnClientClick="GetSum(); return;" />
            </td>
        </tr>        
    </table>
    </form>
</body>
</html>
