﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="textboxscanner_show.aspx.cs"
    Inherits="dialogs_textboxscanner_show" meta:resourcekey="PageResource1" Trace="false"
    UICulture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Сканкопия</title>
    <script language="javascript" type="text/javascript">
        var ShowUrl = location.href.replace('textboxscanner_show.aspx', 'textboxscanner_show.aspx');
        var EmptyUrl = '/Common/Images/empty_image.png';

        // инициализация контролов
        function Page_Load() {
            document.getElementById('img').src = ShowUrl;
        }
        // закрываем диалог
        function CloseDialog(res) {
            window.returnValue = res;
            window.close();
            return false;
        }
    </script>
    <link href="/Common/CSS/default.css" type="text/css" rel="stylesheet" />
</head>
<body onload="Page_Load()">
    <form id="form1" runat="server">
    <table border="0" cellpadding="3" cellspacing="0" width="99%">
        <tr>
            <td class="pageTitle" align="center" style="padding-top: 20px">
                <asp:Label ID="lbScanTitle" runat="server" Text="Сканкопия" meta:resourcekey="lbScanTitleResource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="border: solid 1px #94ABD9" align="center" valign="middle">
                <img id="img" alt="Image" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="text-align: center; padding-top: 20px">
                <asp:ImageButton ID="ibPrint" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                    Text="Печать" ToolTip="Печать" OnClick="ibPrint_Click" meta:resourcekey="ibPrintResource1" />
                <asp:ImageButton ID="ibCancel" runat="server" ImageUrl="/Common/Images/default/24/delete2.png"
                    Text="Отмена" ToolTip="Отмена" OnClientClick="CloseDialog(null); return false;"
                    meta:resourcekey="ibCancelResource1" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>