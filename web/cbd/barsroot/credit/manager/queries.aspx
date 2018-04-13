<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="queries.aspx.cs" Inherits="credit_manager_queries" Title="Обробка заявок"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td class="sectionTitle">
                    <asp:Label ID="SearchTitle" runat="server" Text="Пошук" 
                        meta:resourcekey="SearchTitleResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px">
                    <table border="0" cellpadding="3" cellspacing="0" style="text-align: center">
                        <tr>
                            <td>
                                <asp:Label ID="SearchBidIdTitle" runat="server" Text="№ заявки :" 
                                    meta:resourcekey="SearchBidIdTitleResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="SearchInnTitle" runat="server" Text="ІПН :" 
                                    meta:resourcekey="SearchInnTitleResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="SearchFioTitle" runat="server" Text="Прізвище клієнта :" 
                                    meta:resourcekey="SearchFioTitleResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <bec:TextBoxNumb ID="SearchBidId" runat="server" IsRequired="False" ValidationGroup="Search" />
                            </td>
                            <td>
                                <bec:TextBoxString ID="SearchInn" runat="server" IsRequired="False" ValidationGroup="Search" />
                            </td>
                            <td>
                                <bec:TextBoxString ID="SearchFio" runat="server" IsRequired="False" ValidationGroup="Search"
                                    Width="250" />
                            </td>
                            <td>
                                <asp:Button ID="btSearch" runat="server" Text="Применить" SkinID="bSearch" 
                                    OnClick="btSearch_Click" meta:resourcekey="btSearchResource1" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectMgrBids" TypeName="credit.VWcsMgrBids"
                        SortParameterName="SortExpression" EnablePaging="True">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="SearchBidId" Name="BidId" PropertyName="Value" Type="Decimal" />
                            <asp:ControlParameter ControlID="SearchInn" Name="Inn" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="SearchFio" Name="Fio" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                        ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                        CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                        FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                        MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                        AllowSorting="True" AllowPaging="True" PageSize="30" ShowFooter="True" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                        EnableModelValidation="True" HoverRowCssClass="hoverRow" 
                        ShowExportExcelButton="True" meta:resourcekey="gvResource1">
                        <PagerSettings Mode="Numeric" PageButtonCount="3" />
                        <FooterStyle CssClass="footerRow"></FooterStyle>
                        <HeaderStyle CssClass="headerRow"></HeaderStyle>
                        <EditRowStyle CssClass="editRow"></EditRowStyle>
                        <PagerStyle CssClass="pagerRow"></PagerStyle>
                        <NewRowStyle CssClass=""></NewRowStyle>
                        <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                        <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="BID_ID" DataNavigateUrlFormatString="/barsroot/credit/manager/bid_card.aspx?bid_id={0}"
                                DataTextField="BID_ID" DataTextFormatString="{0}" HeaderText="№ заявки" 
                                SortExpression="BID_ID" meta:resourcekey="HyperLinkFieldResource1">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:HyperLinkField>
                            <asp:TemplateField HeaderText="Субпродукт" SortExpression="SUBPRODUCT_ID" 
                                meta:resourcekey="TemplateFieldResource1">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>' ToolTip='<%# Bind("SUBPRODUCT_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="CRT_DATE" HeaderText="Дата заявки" SortExpression="CRT_DATE"
                                DataFormatString="{0:d}" meta:resourcekey="BoundFieldResource1">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FIO" HeaderText="ПІБ клієнта" SortExpression="FIO" 
                                meta:resourcekey="BoundFieldResource2"></asp:BoundField>
                            <asp:BoundField DataField="INN" HeaderText="Ідент. код клієнта" 
                                SortExpression="INN" meta:resourcekey="BoundFieldResource3" />
                            <asp:BoundField DataField="SUMM" DataFormatString="{0:### ### ### ##0.00}" HeaderText="Сума кредиту"
                                SortExpression="SUMM" meta:resourcekey="BoundFieldResource4">
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TERM" DataFormatString="{0:F0}" HeaderText="Термін кредиту"
                                SortExpression="TERM" meta:resourcekey="BoundFieldResource5" />
                            <asp:BoundField DataField="GARANTEES" HeaderText="Забезпечення" 
                                SortExpression="GARANTEES" meta:resourcekey="BoundFieldResource6">
                            </asp:BoundField>
                            <asp:BoundField DataField="MGR_FIO" HeaderText="ПІБ менеджера" 
                                SortExpression="MGR_FIO" meta:resourcekey="BoundFieldResource7" />
                            <asp:TemplateField HeaderText="Відділення" SortExpression="BRANCH" 
                                meta:resourcekey="TemplateFieldResource2">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("BRANCH") %>' ToolTip='<%# Eval("BRANCH_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="STATES" HeaderText="Статус" SortExpression="STATES" 
                                meta:resourcekey="BoundFieldResource8" />
                        </Columns>
                        <RowStyle CssClass="normalRow"></RowStyle>
                    </Bars:BarsGridViewEx>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
