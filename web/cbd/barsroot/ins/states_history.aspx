<%@ Page Title="Історія зміни статусів" Language="C#" MasterPageFile="~/ins/ins_master.master"
    AutoEventWireup="true" CodeFile="states_history.aspx.cs" Inherits="ins_deals" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="Bars" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="Bars" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" runat="Server">
    <div class="content_container">
        <div class="gridview_container">
            <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectDealStsHistory"
                TypeName="Bars.Ins.VInsDealStsHistory" DataObjectTypeName="Bars.Ins.VInsDealStsHistoryRecord">
                <SelectParameters>
                    <asp:QueryStringParameter DefaultValue="-1" Name="DEAL_ID" Type="Decimal" QueryStringField="deal_id" />
                </SelectParameters>
            </Bars:BarsObjectDataSource>
            <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CssClass="barsGridView"
                DataSourceID="ods" DateMask="dd.MM.yyyy" EnableModelValidation="True" HoverRowCssClass="hoverRow"
                ShowExportExcelButton="True" AllowSorting="True" AllowPaging="True" ShowFooter="True"
                PageSize="30" CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png">
                <NewRowStyle CssClass=""></NewRowStyle>
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="SET_DATE" DataFormatString="{0:dd.MM.yyyy HH:mm}" HeaderText="Дата"
                        SortExpression="SET_DATE">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Статус" SortExpression="STATUS_ID">
                        <ItemTemplate>
                            <Bars:LabelTooltip ID="Label1" runat="server" Text='<%# Bind("STATUS_NAME") %>' ToolTip='<%# Bind("STATUS_ID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Користувач" SortExpression="STAFF_ID">
                        <ItemTemplate>
                            <Bars:LabelTooltip ID="lbSTAFF" runat="server" Text='<%# Eval("STAFF_ID") %>' ToolTip='<%# (String)Eval("STAFF_LOGNAME") + " - " + (String)Eval("STAFF_FIO") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="COMM" HeaderText="Коментар" SortExpression="COMM"></asp:BoundField>
                </Columns>
                <EditRowStyle CssClass="editRow"></EditRowStyle>
                <FooterStyle CssClass="footerRow"></FooterStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <RowStyle CssClass="normalRow"></RowStyle>
                <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            </Bars:BarsGridViewEx>
        </div>
    </div>
</asp:Content>
