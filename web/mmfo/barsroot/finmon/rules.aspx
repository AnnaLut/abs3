<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rules.aspx.cs" Inherits="rules" %>

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
           
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Правила відбору"></asp:Label>
        </div>
        <BarsEX:BarsSqlDataSourceEx ID="odsRules" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gvRules" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="100" AllowPaging="True"
            DataSourceID="odsRules" CssClass="barsGridView" DataKeyNames="ID,NAME" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            ExcelImageUrl="/common/images/default/16/export_excel.png">
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
