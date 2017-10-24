<%@ Page Language="C#" AutoEventWireup="true" Title="Довідник"
    CodeFile="dwh_references.aspx.cs" Inherits="dwh_references" Trace="false" MaintainScrollPositionOnPostback="true" %>

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
    vCloseValue.id = -1;
    vCloseValue.name = -1;
    window.returnValue = vCloseValue;

    function Close(id, name) {
        var vReturnValue = new Object();
        vReturnValue.id = id;
        vReturnValue.name = name;
        window.returnValue = vReturnValue;
        window.close();
    }

    function NoRows() {
        alert("Не вибрано жодного рядка.");
        return false;
    }
</script>
<body>
    <form id="formDwhRef" runat="server">
        <asp:Panel ID="panelFilters" runat="server" GroupingText="Фільтр:" Style="margin-left: 10px;" Visible="true">
            <table>
                <tr align="right">
                    <td>
                        <asp:Label ID="lbId" runat="server" Text="Код"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbId" runat="server" MaxLength="5" EnabledStyle-HorizontalAlign="Left"></Bars2:BarsTextBox>
                    </td>
                    <td style="width: 50px">
                        <asp:Label ID="lbName" runat="server" Text="Найменування"></asp:Label>
                    </td>
                    <td>
                        <Bars2:BarsTextBox ID="tbName" runat="server" MaxLength="50" Width="250px"></Bars2:BarsTextBox>
                    </td>
                    <td>
                        <asp:Button ID="btSearch" runat="server" Text="Пошук" OnClick="btSearch_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnDwhRef" runat="server" Visible="false">
            <div class="pageTitle">
                <asp:Label ID="lbTitle" runat="server" Text="Довідник"></asp:Label>
            </div>
            <BarsEX:BarsSqlDataSourceEx ID="odsDwhRef" runat="server" AllowPaging="False" ProviderName="barsroot.core"></BarsEX:BarsSqlDataSourceEx>

            <BarsEX:BarsGridViewEx ID="gvDwhRef" runat="server" PagerSettings-PageButtonCount="10" PageIndex="0"
                PageSize="10" AllowPaging="True" AllowSorting="True"
                DataSourceID="odsDwhRef" CssClass="barsGridView" DataKeyNames="ID,NAME" DateMask="dd/MM/yyyy"
                JavascriptSelectionType="SingleRow" AutoGenerateColumns="false" CaptionType="Cool"
                ShowPageSizeBox="true" EnableViewState="true" OnRowDataBound="gv_RowDataBound"
                AutoSelectFirstRow="false"
                RefreshImageUrl="/common/images/default/16/refresh.png"
                ExcelImageUrl="/common/images/default/16/export_excel.png"
                FilterImageUrl="/common/images/default/16/filter.png">
                <AlternatingRowStyle CssClass="alternateRow" />
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="Код" SortExpression="ID" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                    <asp:BoundField DataField="NAME" HeaderText="Найменування" SortExpression="NAME"
                        ItemStyle-HorizontalAlign="Left" ItemStyle-Width="90%"></asp:BoundField>
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
            <table width="100%">
                <tr>
                    <td align="right" style="width: 50%">
                        <cc1:ImageTextButton ID="ibtOk" runat="server" Text="Застосувати" ImageUrl="/common/images/default/16/ok.png" OnClick="btOK_Click" />
                    </td>
                    <td align="center" style="width: 50%">
                        <cc1:ImageTextButton ID="ibtCancel" runat="server" Text="Закрити" ImageUrl="/common/images/default/16/cancel.png" OnClick="btCancel_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </form>
</body>
</html>
