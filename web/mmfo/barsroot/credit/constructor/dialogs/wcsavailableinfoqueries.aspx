<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsavailableinfoqueries.aspx.cs"
    Inherits="credit_constructor_dialogs_wcsavailableinfoqueries" Theme="default"
    MasterPageFile="~/credit/constructor/master.master" Title="Доступные информационные запросы"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" AllowPaging="False" ProviderName="barsroot.core"
            SelectCommand="select * from v_wcs_infoqueries i where i.iquery_id not in (select si.iquery_id from v_wcs_subproduct_infoqueries si where si.subproduct_id = :SUBPRODUCT_ID) order by i.iquery_id">
            <SelectParameters>
                <asp:QueryStringParameter Name="SUBPRODUCT_ID" QueryStringField="subproduct_id" Type="String" />
            </SelectParameters>
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="sds" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="IQUERY_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvResource1"
            ShowExportExcelButton="True">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="IQUERY_ID" HeaderText="Идентификатор" SortExpression="IQUERY_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="IQUERY_NAME" HeaderText="Наименование" SortExpression="IQUERY_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
            <tr>
                <td class="actionButtonsContainer" colspan="2">
                    <asp:ImageButton ID="ibAdd" runat="server" ImageUrl="/Common/Images/default/16/ok.png"
                        ToolTip="Добавить" OnClick="ibAdd_Click" />
                    <asp:ImageButton ID="ibClose" runat="server" CausesValidation="False" SkinID="ibCancel"
                        OnClientClick="CloseDialog(null);" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
