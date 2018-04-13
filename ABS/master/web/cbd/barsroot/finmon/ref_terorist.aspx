<%@ Page Language="C#" AutoEventWireup="true" Title="Повний перелік назв ЮО/ФО, пов`яз. зі здійсненням терористичної діяльності"
    CodeFile="ref_terorist.aspx.cs" Inherits="finmon_refterorist" Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Повний перелік назв ЮО/ФО, пов`яз. зі здійсненням терористичної діяльності</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
    <base target="_self" />
</head>
<script language="javascript" type="text/javascript">

    var vCloseValue = new Object();
    vCloseValue.code = -1;
    window.returnValue = vCloseValue;

</script>
<body>
    <form id="formKdfm01a" runat="server">
        <div class="pageTitle">
            <asp:Label ID="lbTitle" runat="server" Text="Повний перелік назв ЮО/ФО, пов`яз. зі здійсненням терористичної діяльності"></asp:Label>
        </div>
        <p></p>
        <BarsEX:BarsSqlDataSourceEx ID="odsRefTer" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

        <BarsEX:BarsGridViewEx ID="gvRefTer" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
            PageSize="20" AllowPaging="True" AllowSorting="True"
            DataSourceID="odsRefTer" CssClass="barsGridView" DataKeyNames="ORIGIN" DateMask="dd/MM/yyyy"
            JavascriptSelectionType="None" AutoGenerateColumns="false" CaptionType="Cool"
            ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
            AutoSelectFirstRow="false"
            RefreshImageUrl="/common/images/default/16/refresh.png"
            ExcelImageUrl="/common/images/default/16/export_excel.png"
            FilterImageUrl="/common/images/default/16/filter.png">
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="ORIGIN" HeaderText="Довідник" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C1" HeaderText="Номер особи в довіднику" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C6" HeaderText="Прізвище резидента/ім`я 1 нерезидента/найменув" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C7" HeaderText="Ім`я резидента/ім`я 2 нерезидента" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C8" HeaderText="По батькові резидента/ім`я 3 нерезидента" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C9" HeaderText="Ім`я 4 нерезидента" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C2CHAR" HeaderText="Дата внесення до Переліку" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="C13" HeaderText="Дата народження" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                <asp:BoundField DataField="C34" HeaderText="Адреса" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C20" HeaderText="Документ" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C4" HeaderText="Тип особи" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                <asp:BoundField DataField="C5" HeaderText="Джерело, відповідно до якого особу внесено до Переліку" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                <asp:BoundField DataField="C37" HeaderText="Додаткова інформація" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
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
