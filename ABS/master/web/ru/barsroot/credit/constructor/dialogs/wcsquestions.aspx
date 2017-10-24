<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsquestions.aspx.cs" Inherits="credit_constructor_dialogs_wcsquestions"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Макросы-вопросы"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="1" cellpadding="3" cellspacing="0" style="height: 520px; width: 850">
            <tr>
                <td rowspan="2" style="vertical-align: top; height: 520px; width: 250px">
                    <div style="overflow: scroll; height: 520px; width: 250px">
                        <asp:Panel ID="pnlSections" runat="server" GroupingText="Разделы">
                            <asp:TreeView ID="tv" runat="server" ShowCheckBoxes="All" OnTreeNodeCheckChanged="tv_TreeNodeCheckChanged">
                                <Nodes>
                                    <asp:TreeNode Checked="True" Expanded="True" Text="Все" Value="ALL"></asp:TreeNode>
                                </Nodes>
                            </asp:TreeView>
                        </asp:Panel>
                        <asp:Panel ID="pnlTypes" runat="server" GroupingText="Типы">
                            <asp:TreeView ID="tvTypes" runat="server" ShowCheckBoxes="All">
                                <Nodes>
                                    <asp:TreeNode Checked="True" Expanded="True" Text="Все" Value="ALL"></asp:TreeNode>
                                </Nodes>
                            </asp:TreeView>
                        </asp:Panel>
                        <asp:Panel ID="pnlFilter" runat="server" GroupingText="Фильтр">
                            <asp:CheckBox ID="cbCurSbp" runat="server" AutoPostBack="True" Text="Текущий субпродукт" />
                        </asp:Panel>
                    </div>
                </td>
                <td>
                    <div style="overflow: scroll; height: 420px; width: 600px">
                        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core">
                        </Bars:BarsSqlDataSourceEx>
                        <Bars:BarsGridViewEx ID="gv" runat="server" DataSourceID="sds" AutoGenerateColumns="False"
                            CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                            CssClass="barsGridView" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                            ShowPageSizeBox="False" DataKeyNames="ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
                            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="True" ShowFooter="true" PageSize="100" AllowPaging="true">
                            <FooterStyle CssClass="footerRow"></FooterStyle>
                            <HeaderStyle CssClass="headerRow"></HeaderStyle>
                            <EditRowStyle CssClass="editRow"></EditRowStyle>
                            <PagerStyle CssClass="pagerRow"></PagerStyle>
                            <NewRowStyle CssClass=""></NewRowStyle>
                            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="ibAdd" runat="server" CausesValidation="False" CommandArgument='<%# Eval("ID") %>'
                                            ImageUrl="/Common/Images/default/16/ok.png" Text="Выбрать" OnClientClick=<%# "if (!confirm('Выбрать значение " + Eval("ID") + "')) return false;" %> />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ID" HeaderText="Идентификатор" SortExpression="ID" />
                                <asp:BoundField DataField="NAME" HeaderText="Наименование" SortExpression="NAME" />
                                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
                            </Columns>
                            <RowStyle CssClass="normalRow"></RowStyle>
                        </Bars:BarsGridViewEx>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="height: 100px">
                    <asp:Panel ID="pnlParams" runat="server" GroupingText="Параметры">
                        <asp:TreeView ID="tvParams" runat="server" OnSelectedNodeChanged="tvParams_SelectedNodeChanged">
                            <Nodes>
                                <asp:TreeNode Expanded="False" Text="Константы" Value="CONSTS">
                                    <asp:TreeNode Text="Номер заявки" Value="BID_ID" />
                                    <asp:TreeNode Text="Идентификатор субпродукта" Value="SBP_ID" />
                                    <asp:TreeNode Text="Идентификатор продукта" Value="PRD_ID" />
                                </asp:TreeNode>
                            </Nodes>
                        </asp:TreeView>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
