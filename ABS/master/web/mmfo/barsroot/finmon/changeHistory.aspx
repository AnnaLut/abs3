<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changeHistory.aspx.cs" Inherits="finmon_changeHistory" Title="Історія змін" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="BarsEX" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="Bars2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Історія змін</title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/CSS/BarsGridView.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="formChangeHistory" runat="server">
        <div>
            <div style="margin-left: auto; margin-right: auto; text-align: center;">
                <asp:Label ID="tbRef" runat="server" ReadOnly="true" Width="600px" Font-Size="Large" ></asp:Label>
            </div>
            <BarsEX:BarsSqlDataSourceEx ID="changeHistoryDataSource" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>
            <BarsEX:BarsGridViewEx ID="changeHistoryGrid" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
                PageSize="15" AllowPaging="True" DataSourceID="changeHistoryDataSource" CssClass="barsGridView"
                JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
                ShowPageSizeBox="true" EnableViewState="true"
                AutoSelectFirstRow="false"
                RefreshImageUrl="/common/images/default/16/refresh.png"
                ExcelImageUrl="/common/images/default/16/export_excel.png"
                FilterImageUrl="/common/images/default/16/filter.png">
                <AlternatingRowStyle CssClass="alternateRow" />
                <Columns>
                    <asp:BoundField DataField="MOD_DATE" HeaderText="Дата модифікації" SortExpression="MOD_DATE" ItemStyle-Width="20%" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd.MM.yy HH:mm:ss}"></asp:BoundField>
                    <asp:BoundField DataField="NAME" HeaderText="Назва" SortExpression="NAME" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="20%"></asp:BoundField>
                    <asp:BoundField DataField="USER_ID" HeaderText="ID користувача" SortExpression="USER_ID" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="10%"></asp:BoundField>
                    <asp:BoundField DataField="USER_NAME" HeaderText="ПІБ користувача" SortExpression="USER_NAME" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="25%"></asp:BoundField>
                    <asp:BoundField DataField="OLD_VALUE" HeaderText="Старе значення" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="25%"></asp:BoundField>
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

        </div>
    </form>
</body>
</html>
