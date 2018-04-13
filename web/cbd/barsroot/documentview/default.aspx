<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="_default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Карточка документа</title>
    <base target="_self" />
    <style>
        .webservice
        {
            behavior: url(/Common/WebService/js/WebService.htc);
        }
    </style>
    <meta name="DownloadOptions" content="nosave">
    <link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet" />
    <script src="/Common/WebTab/WebTab.js" language="javascript" type="text/jscript"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js"></script>
    <script language="javascript" type="text/jscript">
        function getCookie(par) {
            var pageCookie = document.cookie;
            var pos = pageCookie.indexOf(par + '=');
            if (pos != -1) {
                var start = pos + par.length + 1;
                var end = pageCookie.indexOf(';', start);
                if (end == -1) end = pageCookie.length;
                var value = pageCookie.substring(start, end);
                value = unescape(value);
                return value;
            }
        }
        //референс документа
        var doc_ref = '';
        function onChangeTab() {
        }
        function initServrice() {
            var port = (location.port != "") ? (":" + location.port) : ("");
            document.all.webService.useService(location.protocol + "//" + location.hostname + port + "/barsroot/docinput/DocService.asmx?wsdl", "Doc");
            var printTrnModel = getCookie("prnModel");
            if (printTrnModel) {
                document.getElementById("cbPrintTrnModel").checked = (printTrnModel==1)?(true):(false);
            }
        }
        function setCookie(name, val)
        {
            var date = new Date((new Date()).getTime() + 24 * 3600000);
            document.cookie = name + '=' + val + "; expires=" + date.toGMTString();
        }
        function getTicketFile(ref) {
            if ("" != ref)
                document.all.webService.Doc.callService(onPrint, "GetFileForPrint", ref, document.getElementById("cbPrintTrnModel").checked);
            return false;
        }
        function onPrint(result) {
            if (!getError(result)) return;
            barsie$print(result.value);
        }
        function getError(result, modal) {
            if (result.error) {
                if (window.dialogArguments || parent.frames.length == 0 || modal) {
                    window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
                }
                else
                    location.replace("dialog.aspx?type=err");
                return false;
            }
            return true;
        }
    </script>
</head>
<body onload="InitTabs();initServrice();">
    <form id="Form1" method="post" runat="server">
    <table id="tbMain" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td style="padding-bottom: 10px; border-bottom: black 1px solid;">
                <asp:Label ID="lb_refer" CssClass="title" runat="server" Text="Референс документа - "
                    meta:resourcekey="lb_referResource1"></asp:Label>
                <asp:Label ID="lb_title" CssClass="title" runat="server"></asp:Label>
            </td>
            <td style="padding-bottom: 10px; border-bottom: black 1px solid;" align="right">
                <input runat="server" id="cbPrintTrnModel" style="width: auto; border-width: 0;"
                    type="checkbox" onclick="setCookie('prnModel', ((this.checked) ? (1) : (0)))" title="Друкувати бух. модель по документу" /><label for="cbPrintTrnModel"
                        style="white-space: nowrap;" title="Друкувати бух. модель по документу">друк бух. моделі</label>&nbsp;
                <asp:LinkButton ID="btPdfFile" runat="server" Font-Bold="False" ForeColor="Black"
                    BackColor="WhiteSmoke" OnClick="btPdfFile_Click" TabIndex="1" Text="вигрузити(pdf)"></asp:LinkButton>
                &nbsp;
                <asp:LinkButton ID="bt_print" runat="server" Font-Bold="False" ForeColor="Black"
                    BackColor="WhiteSmoke" OnClick="bt_print_Click" TabIndex="2" Text="вигрузити(html)"></asp:LinkButton>
                &nbsp;
                <asp:LinkButton ID="btTextFile" runat="server" Font-Bold="False" ForeColor="Black"
                    BackColor="WhiteSmoke" TabIndex="3" Text="вигрузити(txt)" OnClick="btTextFile_Click"></asp:LinkButton>
                &nbsp;
                <asp:LinkButton ID="btFile" runat="server" Font-Bold="False" ForeColor="Black" BackColor="WhiteSmoke"
                    OnClick="btFile_Click" TabIndex="4" Text="друк"></asp:LinkButton>
            </td>
        </tr>
    </table>
    <div id="webtab" style="width: 100%; height: 100%">
    </div>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    </form>
</body>
</html>
