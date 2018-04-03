<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="bid_stateshistory.aspx.cs" Inherits="credit_bid_stateshistory" Title="История статусов заявки №{0}"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidStatesHistory"
            TypeName="credit.VWcsBidStatesHistory" SortParameterName="SortExpression">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Size="100" Type="Decimal" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" EnableModelValidation="True"
            ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowExportExcelButton="True" ShowPageSizeBox="False" AllowSorting="True" meta:resourcekey="gvResource1">
            <NewRowStyle CssClass="" />
            <NewRowStyle CssClass="" />
            <NewRowStyle CssClass=""></NewRowStyle>
            <AlternatingRowStyle CssClass="alternateRow" />
            <Columns>
                <asp:BoundField DataField="STATE_NAME" HeaderText="Состояние" SortExpression="STATE_NAME"
                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                <asp:BoundField DataField="CHECKOUT_DAT" HeaderText="Дата/Время" SortExpression="CHECKOUT_DAT"
                    DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" meta:resourcekey="BoundFieldResource2">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="CHECKOUT_USER_F" HeaderText="Пользователь" SortExpression="CHECKOUT_USER_F"
                    meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                <asp:TemplateField HeaderText="Комментарий" SortExpression="USER_COMMENT" meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <Bars:LabelTooltip ID="Label1" runat="server" Text='<%# Eval("USER_COMMENT") %>'
                            TextLength="30" UseTextForTooltip="true" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CHANGE_ACTION_NAME" HeaderText="Действие" SortExpression="CHANGE_ACTION_NAME"
                    meta:resourcekey="BoundFieldResource4" />
                <asp:BoundField DataField="CHANGE_DAT" HeaderText="Дата" SortExpression="CHANGE_DAT"
                    DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" meta:resourcekey="BoundFieldResource5" />
            </Columns>
            <EditRowStyle CssClass="editRow" />
            <FooterStyle CssClass="footerRow" />
            <HeaderStyle CssClass="headerRow" />
            <PagerStyle CssClass="pagerRow" />
            <RowStyle CssClass="normalRow" />
            <SelectedRowStyle CssClass="selectedRow" />
        </Bars:BarsGridViewEx>
    </div>
</asp:Content>
