<%@ Page Language="C#" AutoEventWireup="true" CodeFile="docfilter.aspx.cs" Inherits="finmon_docfilter" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Період відбору документів</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <script type="text/javascript" src="/common/jquery/jquery.js"></script>
    <script type="text/javascript" src="/common/jquery/jquery-ui.js"></script>
    <script type="text/javascript" src="/common/jquery/jquery.blockUI.js"></script>
</head>
<script language="javascript" type="text/javascript">

    window.onload = rul;

    function rul() {
        var rules = document.getElementById('tbRules').value;

        var x = 0;
        var c = 0;
        //опредиляем количиство строк грида(всех)
        $(".barsGridView tbody tr").each(function (z) {
            x = z;
        });

        //опредиляем есть ли пейджинг
        var c = $(".pagerRow td table tbody tr td span").text();
        // если пейджинг есть 
        if (parseInt(c, 10) > 0) {
            y = x - 3;
        }
        else {
            y = x - 1;
        }
        //проставляем чекбоксы
        $(".barsGridView tbody tr").each(function (i) {

            if (i > 0 && i < y + 1) {

                //получаес значение кода
                var td = $(this).find('td:first');
                var vall = td.next('td').text();
                var cb = td.find('input');
                var our_string = ',' + rules;
                if (our_string.indexOf(',' + vall + ',') + 1) {
                    $(this).find('input').attr('checked', 'checked');
                }
            }
        });
    }

    window.onunload = Ok;
    function Ok() {
        var vReturnValue = new Object();
        vReturnValue.close = "ok";
        window.returnValue = vReturnValue;
        window.close();
    }

    function closing() {
        alert("Запит принято в роботу, вікно закриється автоматично");
    }


    function btnLoadClick() {
        if (1 == 2) {
            alert('Потрiбно вибрати файл');
            $.unblockUI();
            return false;
        } else {
            return true;
        }
    }


</script>
<body>

    <script type="text/javascript">
        $(document).ajaxStop($.unblockUI);

        function blockUI() {
            $.blockUI({ message: '<div style="border: 1px solid gray; padding: 8px; margin:5px;">Зачекайте...</div>', css: { border: 'none' } });
        }

    </script>
    <form id="formFinMonFilter" runat="server">
        <div id="resdlg" style="display: none; cursor: default; border: 1px solid gray; padding: 8px; margin: 5px;">
            <asp:Label ID="lblRes" runat="server"></asp:Label><br />
            <input type="button" id="btnOk" value="OK" onclick="$.unblockUI(); return false;" />
        </div>
        <asp:Panel ID="panelDates" runat="server" GroupingText="Період відбору документів:" Style="margin-left: 10px;">
            <asp:HiddenField ID="tbRules" runat="server" />
            <table>
                <tr align="right">
                    <td>
                        <asp:Label ID="lbDat1" runat="server" Text="З " Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diDat1" runat="server" DateFormat="dd.MM.yyyy" EnabledStyle-HorizontalAlign="Center" EnabledStyle-Font-Size="Larger" AutoPostBack="false"></Bars2:BarsDateInput>
                    </td>
                    <td style="width: 50px">
                        <asp:Label ID="lbDat2" runat="server" Text="по" Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsDateInput ID="diDat2" runat="server" DateFormat="dd.MM.yyyy" EnabledStyle-HorizontalAlign="Center" EnabledStyle-Font-Size="Larger" AutoPostBack="false"></Bars2:BarsDateInput>
                    </td>
                    <td>
                        <asp:Button ID="btSearch" runat="server" Text="Застосувати" OnClientClick="blockUI()" OnClick="btSearch_Click" />
                    </td>
                    <td>
                        <input type="hidden" runat="server" id="RulesCount" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Правила відбору"></asp:Label>
        </div>
        <BarsEX:BarsSqlDataSourceEx ID="odsRules" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gvRules" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="100" AllowPaging="True" AllowSorting="True"
            DataSourceID="odsRules" CssClass="barsGridView" DataKeyNames="ID,NAME" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="Код" SortExpression="ID" ItemStyle-Width="4%" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="NAME" HeaderText="Найменування" SortExpression="NAME"
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="95%"></asp:BoundField>
            </Columns>
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <EditRowStyle CssClass="editRow" />
            <PagerStyle CssClass="pagerRow" />
            <SelectedRowStyle CssClass="selectedRow" />
            <AlternatingRowStyle CssClass="alternateRow" />
            <PagerSettings Mode="Numeric"></PagerSettings>
            <RowStyle CssClass="normalRow" />
            <NewRowStyle CssClass="newRow" />

        </BarsEX:BarsGridViewEx>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    </form>
</body>
</html>
