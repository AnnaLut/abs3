﻿<%@ Page Language="C#" AutoEventWireup="true" Title="Довідник Клієнтів"
    CodeFile="refcustomers.aspx.cs" Inherits="finmon_refcustomers" Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Довідник Клієнтів</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    var vCloseValue = new Object();
    vCloseValue.rnk = -1;
    
    window.returnValue = vCloseValue;

    function Close(rnk, okpo, nmk) {
        var vReturnValue = new Object();
        vReturnValue.rnk = rnk;
        vReturnValue.okpo = okpo;
        vReturnValue.nmk = nmk
        window.returnValue = vReturnValue;
        window.close();
    }

    function NoRows() {
        alert("Не вибрано жодного рядка.");
        return false;
    }
    

</script>
<body>
    <form id="formRefCustomers" runat="server">
      <asp:Panel ID="panelFilters" runat="server" GroupingText="Фільтр:" Style="margin-left: 10px;">
           <table width="75%">
                <tr align="right">
                    <td>
                        <asp:Label ID="lbCode" runat="server" Text="РНК " Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbRNK" runat="server" MaxLength="38" EnabledStyle-HorizontalAlign="Center"></Bars2:BarsTextBox>
                    </td>
                    <td style="width: 100px">
                        <asp:Label ID="lbName" runat="server" Text="ОКПО" Font-Size="Larger"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbOKPO" runat="server" MaxLength="14" Width="180px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <asp:Button ID="btSearch" runat="server" Text="Пошук" OnClick="btSearch_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <table width="75%">
            <tr>
                <td align="right" style="width: 75%">
                    <cc1:ImageTextButton ID="ImageTextButton1" runat="server" Text="Застосувати" ImageUrl="/common/images/default/16/ok.png" OnClick="btOK_Click" />
                    <cc1:ImageTextButton ID="btCancel" runat="server" Text="Закрити    " ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                </td>
            </tr>
        </table>
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Перелік клієнтів"></asp:Label>
        </div>
        <BarsEX:BarsSqlDataSourceEx ID="odsRefCustomers" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gvRefCustomers" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="15" AllowPaging="True" AllowSorting="True"
            DataSourceID="odsRefCustomers" CssClass="barsGridView" DataKeyNames="RNK,NMK,OKPO" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="RNK" HeaderText="РНК" SortExpression="RNK" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="OKPO" HeaderText="ОКПО" SortExpression="OKPO"
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10%"></asp:BoundField>
                <asp:BoundField DataField="NMK" HeaderText="Найменування" SortExpression="NMK"
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="80%"></asp:BoundField>

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