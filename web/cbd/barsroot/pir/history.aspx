<%@ Page Language="C#" AutoEventWireup="true" CodeFile="history.aspx.cs" Inherits="pir_history" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Історія проходження заявки </title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
    <script type="text/javascript" src="/common/jquery/jquery.js"></script>
    <script type="text/javascript" src="/common/jquery/jquery-ui.js"></script>
    <script type="text/javascript" src="/common/jquery/jquery.blockUI.js"></script>
</head>
<script language="javascript" type="text/javascript">

    //window.onunload = Ok;

</script>
<body>
    <form id="formFinMonFilter" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Історія проходження заявки № "></asp:Label>
        </div>
        <%--  <BarsEX:BarsSqlDataSourceEx ID="odsReqHistory" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>--%>

        <BarsEX:BarsGridViewEx ID="gvReqHistory" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            CssClass="barsGridView" DataKeyNames="STATE_ID" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <%--   <asp:BoundField DataField="STATE_ID" HeaderText="Код статусу" SortExpression="STATE_ID" ItemStyle-HorizontalAlign="Right"></asp:BoundField>--%>
                <asp:BoundField DataField="SET_DATE" HeaderText="Дата встановленя статусу" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="STATE_NAME" HeaderText="Найменування статусу" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="UPD_STAFF" HeaderText="Користувач що встановив статус" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="COMM" HeaderText="Коментар" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
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
