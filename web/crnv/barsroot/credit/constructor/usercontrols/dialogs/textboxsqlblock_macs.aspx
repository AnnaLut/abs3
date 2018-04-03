<%@ Page Language="C#" AutoEventWireup="true" CodeFile="textboxsqlblock_macs.aspx.cs"
    Inherits="credit_usercontrols_dialogs_textboxsqlblock_macs" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Макросы-МАКи" Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectMacs" TypeName="credit.VWcsMacs"
            SortParameterName="SortExpression"></Bars:BarsObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="MAC_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true"
            meta:resourcekey="gvVWcsMacsResource1" ShowExportExcelButton="false">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="MAC_ID" HeaderText="Идентификатор" SortExpression="MAC_ID"
                    meta:resourcekey="BoundFieldResource1">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="MAC_NAME" HeaderText="Наименование" SortExpression="MAC_NAME"
                    meta:resourcekey="BoundFieldResource2" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME"
                    meta:resourcekey="BoundFieldResource3">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
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
