<%@ Page Language="C#" AutoEventWireup="true" CodeFile="garantees.aspx.cs" Inherits="credit_garantees"
    Theme="default" MasterPageFile="~/credit/master.master" Title="Обеспечение заявки №{0}"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectBidGarantees" TypeName="credit.VWcsBidGarantees">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowExportExcelButton="True"
            DataKeyNames="GARANTEE_ID,GARANTEE_NUM" meta:resourcekey="gvResource1">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField HeaderText="Обеспечение" meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <asp:HyperLink ID="hl" runat="server" NavigateUrl='<%# "/barsroot/credit/grt_survey.aspx?bid_id=" + Convert.ToString(Eval("BID_ID")) + "&garantee_id=" + (String)Eval("GARANTEE_ID") + "&garantee_num=" + Convert.ToString(Eval("GARANTEE_NUM")) %>'
                            Text='<%# (String)Eval("GARANTEE_NAME") + "(" + Convert.ToString(Eval("GARANTEE_NUM")) + ")" %>'
                            meta:resourcekey="hlResource1"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Тип (ОБУ)" SortExpression="TYPE_OBU_ID" meta:resourcekey="TemplateFieldResource2">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TYPE_OBU_ID") %>' ToolTip='<%# Eval("TYPE_OBU_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GRT_NAME" HeaderText="Название" SortExpression="GRT_NAME"
                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                <asp:BoundField DataField="AGR_NUMBER" HeaderText="№ дог." SortExpression="AGR_NUMBER"
                    meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                <asp:BoundField DataField="AGR_DATE" DataFormatString="{0:d}" HeaderText="Дата дог."
                    SortExpression="AGR_DATE" meta:resourcekey="BoundFieldResource3">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="GRT_COST" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Оц. стоимость"
                    SortExpression="GRT_COST" meta:resourcekey="BoundFieldResource4">
                    <ItemStyle HorizontalAlign="Right" />
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
</asp:Content>
