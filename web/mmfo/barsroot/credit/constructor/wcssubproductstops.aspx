<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductstops.aspx.cs"
    Inherits="credit_constructor_wcssubproductstops" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Стопы субпродукта" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/jscript">
        function ShowAvailableStops(subproduct_id) {
            var rnd = Math.random();
            var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsavailablestops.aspx?subproduct_id=' + subproduct_id + '&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSubproductStops"
            TypeName="credit.VWcsSubproductStops" SortParameterName="SortExpression">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="STOP_ID" AllowSorting="True" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvVWcsSubproductMacsResource1">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="STOP_ID" HeaderText="Идентификатор" SortExpression="STOP_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="STOP_NAME" HeaderText="Наименование" SortExpression="STOP_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="ACT_LEVEL" HeaderText="Уровень активации" SortExpression="ACT_LEVEL"
                    meta:resourcekey="BoundFieldResource4" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSubproductStopsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSubproductStop"
            TypeName="credit.VWcsSubproductStops" UpdateMethod="Update">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gv" Name="STOP_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsSqlDataSourceEx ID="sdsActLevels" runat="server" ProviderName="barsroot.core"
            SelectCommand="select 0 as id, 'Авторизація' as name from dual union select 1 as id, 'Ввід даних та доробка' as name from dual union select 2 as id, 'Авторизація + Ввід даних та доробка' as name from dual">
        </Bars:BarsSqlDataSourceEx>
        <asp:FormView ID="fv" runat="server" DataSourceID="odsFV" DataKeyNames="SUBPRODUCT_ID,STOP_ID"
            OnItemCommand="fv_ItemCommand" OnItemDeleted="fv_ItemDeleted" CssClass="formView"
            EnableModelValidation="True" OnItemUpdated="fv_ItemUpdated">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell">
                    <tr>
                        <td>
                            <asp:Label ID="STOP_IDTitle" runat="server" Text="Идентификатор :" />
                        </td>
                        <td>
                            <asp:Label ID="STOP_IDLabel" runat="server" Text='<%# Bind("STOP_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="STOP_NAMETitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <asp:Label ID="STOP_NAMELabel" runat="server" Text='<%# Bind("STOP_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text="Тип :" />
                        </td>
                        <td>
                            <asp:Label ID="TYPE_NAME" runat="server" Text='<%# Bind("TYPE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="ACT_LEVELTitle" runat="server" Text="Уровень активации :" />
                        </td>
                        <td>
                            <bec:DDLList ID="ACT_LEVEL" runat="server" DataSourceID="sdsActLevels" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("ACT_LEVEL") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Сохранить" ToolTip="Сохранить" meta:resourcekey="ibUpdateResource1" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" meta:resourcekey="ibCancelResource1" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell">
                    <tr>
                        <td>
                            <asp:Label ID="STOP_IDTitle" runat="server" Text="Идентификатор :" />
                        </td>
                        <td>
                            <asp:Label ID="STOP_IDLabel" runat="server" Text='<%# Bind("STOP_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="STOP_NAMETitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <asp:Label ID="STOP_NAMELabel" runat="server" Text='<%# Bind("STOP_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text="Тип :" />
                        </td>
                        <td>
                            <asp:Label ID="TYPE_NAME" runat="server" Text='<%# Bind("TYPE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="ACT_LEVELTitle" runat="server" Text="Уровень активации :" />
                        </td>
                        <td>
                            <bec:DDLList ID="ACT_LEVEL" runat="server" DataSourceID="sdsActLevels" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("ACT_LEVEL") %>' ReadOnly="true">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать"
                                meta:resourcekey="ibEditResource1" />
                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" meta:resourcekey="ibDeleteResource1" />
                            <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" OnClientClick=<%# "return ShowAvailableStops('" + Master.SUBPRODUCT_ID + "');" %>
                                CommandName="NewFromRef" ImageUrl="/Common/Images/default/16/reference_open.png"
                                ToolTip="Добавить стоп из справочника" meta:resourcekey="ibNewFromRefResource2" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" OnClientClick=<%# "return ShowAvailableStops('" + Master.SUBPRODUCT_ID + "');" %>
                                CommandName="NewFromRef" ImageUrl="/Common/Images/default/16/reference_open.png"
                                ToolTip="Добавить стоп из справочника" meta:resourcekey="ibNewFromRefResource1" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
