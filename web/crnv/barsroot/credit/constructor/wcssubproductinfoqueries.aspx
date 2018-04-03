<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductinfoqueries.aspx.cs"
    Inherits="credit_constructor_wcssubproductinfoqueries" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Информационные запросы субпродукта" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/jscript">
        function ShowAvailableInfoQueries(subproduct_id) {
            var rnd = Math.random();
            var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsavailableinfoqueries.aspx?subproduct_id=' + subproduct_id + '&rnd=' + rnd, window, dialogFeatures);

            if (result == null) return false;
            else return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:ImageButton ID="ibExpandCollapse" runat="server" ImageUrl="/barsroot/barsweb/images/downarrows.gif"
                        CausesValidation="false" />
                    <asp:Label ID="lbAdditional" runat="server" Text="Дополнительно"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlClone" runat="server" GroupingText="Клонировать из">
                        <table border="0" cellpadding="3" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:ObjectDataSource ID="odsVWcsProducts" runat="server" SelectMethod="SelectProducts"
                                        TypeName="credit.VWcsProducts"></asp:ObjectDataSource>
                                    <bec:DDLList ID="PRODUCT_ID" runat="server" DataSourceID="odsVWcsProducts" DataValueField="PRODUCT_ID"
                                        DataTextField="PRODUCT_NAME" IsRequired="true" ValidationGroup="gClone" OnValueChanged="PRODUCT_ID_ValueChanged">
                                    </bec:DDLList>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:ObjectDataSource ID="odsVWcsSubproducts" runat="server" SelectMethod="SelectSubproducts"
                                        TypeName="credit.VWcsSubproducts">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="PRODUCT_ID" ControlID="PRODUCT_ID" PropertyName="SelectedValue"
                                                Size="100" Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <bec:DDLList ID="CLONE_ID" runat="server" DataSourceID="odsVWcsSubproducts" DataValueField="SUBPRODUCT_ID"
                                        DataTextField="SUBPRODUCT_DESC" IsRequired="true" ValidationGroup="gClone">
                                    </bec:DDLList>
                                </td>
                                <td>
                                    <asp:Button ID="btClone" runat="server" Text="Клонировать" OnClick="btClone_Click"
                                        CausesValidation="true" ValidationGroup="gClone" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <act:CollapsiblePanelExtender ID="cpeClone" runat="Server" TargetControlID="pnlClone"
            Collapsed="True" ExpandControlID="ibExpandCollapse" CollapseControlID="ibExpandCollapse"
            AutoCollapse="False" AutoExpand="False" ScrollContents="False" ImageControlID="ibExpandCollapse"
            ExpandedImage="/barsroot/barsweb/images/uparrows.gif" CollapsedImage="/barsroot/barsweb/images/downarrows.gif"
            ExpandDirection="Vertical" />
    </div>
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSbpInfoqueries"
            TypeName="credit.VWcsSubproductInfoqueries" SortParameterName="SortExpression">
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
            ShowPageSizeBox="False" DataKeyNames="IQUERY_ID" AllowSorting="True" AutoSelectFirstRow="True"
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
                <asp:BoundField DataField="IQUERY_ID" HeaderText="Идентификатор" SortExpression="IQUERY_ID">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="IQUERY_NAME" HeaderText="Наименование" SortExpression="IQUERY_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="SERVICE_ID" HeaderText="Служба" SortExpression="SERVICE_ID"
                    meta:resourcekey="BoundFieldResource4" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSubproductInfoqueriesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSbpInfoquery"
            TypeName="credit.VWcsSubproductInfoqueries" UpdateMethod="Update">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gv" Name="IQUERY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsServices" runat="server" SelectMethod="Select" TypeName="credit.WcsServices">
        </asp:ObjectDataSource>
        <Bars:BarsSqlDataSourceEx ID="sdsActLevels" runat="server" ProviderName="barsroot.core"
            SelectCommand="select 0 as id, 'Авторизація' as name from dual union select 1 as id, 'Ввід даних та доробка' as name from dual union select 2 as id, 'Авторизація + Ввід даних та доробка' as name from dual">
        </Bars:BarsSqlDataSourceEx>
        <asp:FormView ID="fv" runat="server" DataSourceID="odsFV" DataKeyNames="SUBPRODUCT_ID,IQUERY_ID,TYPE_ID"
            OnItemCommand="fv_ItemCommand" OnItemDeleted="fv_ItemDeleted" CssClass="formView"
            EnableModelValidation="True" OnItemUpdated="fv_ItemUpdated" OnDataBound="fv_DataBound">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="IQUERY_IDTitle" runat="server" Text="Идентификатор :" />
                        </td>
                        <td>
                            <asp:Label ID="IQUERY_ID" runat="server" Text='<%# Bind("IQUERY_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IQUERY_NAMETitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <asp:Label ID="IQUERY_NAME" runat="server" Text='<%# Bind("IQUERY_NAME") %>' />
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
                    <tr id="trACT_LEVEL" runat="server">
                        <td>
                            <asp:Label ID="ACT_LEVELTitle" runat="server" Text="Уровень активации :" />
                        </td>
                        <td>
                            <bec:DDLList ID="ACT_LEVEL" runat="server" DataSourceID="sdsActLevels" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("ACT_LEVEL") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr id="trSERVICE_ID" runat="server">
                        <td>
                            <asp:Label ID="SERVICE_IDTitle" runat="server" Text="Служба :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SERVICE_ID" runat="server" DataSourceID="odsWcsServices" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("SERVICE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязателен :' />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="false" runat="server"
                                Value='<%# Bind("IS_REQUIRED") %>' />
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
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="IQUERY_IDTitle" runat="server" Text="Идентификатор :" />
                        </td>
                        <td>
                            <asp:Label ID="IQUERY_ID" runat="server" Text='<%# Bind("IQUERY_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IQUERY_NAMETitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <asp:Label ID="IQUERY_NAME" runat="server" Text='<%# Bind("IQUERY_NAME") %>' />
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
                    <tr id="trACT_LEVEL" runat="server">
                        <td>
                            <asp:Label ID="ACT_LEVELTitle" runat="server" Text="Уровень активации :" />
                        </td>
                        <td>
                            <bec:DDLList ID="ACT_LEVEL" runat="server" DataSourceID="sdsActLevels" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("ACT_LEVEL") %>' ReadOnly="true">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr id="trSERVICE_ID" runat="server">
                        <td>
                            <asp:Label ID="SERVICE_IDTitle" runat="server" Text="Служба :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SERVICE_ID" runat="server" DataSourceID="odsWcsServices" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("SERVICE_ID") %>' ReadOnly="true">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_REQUIREDTitle" runat="server" Text='Обязателен :' />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_REQUIRED" IsRequired="true" DefaultValue="false" runat="server"
                                ReadOnly="true" Value='<%# Bind("IS_REQUIRED") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать"
                                meta:resourcekey="ibEditResource1" />
                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" meta:resourcekey="ibDeleteResource1" />
                            <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" OnClientClick=<%# "return ShowAvailableInfoQueries('" + Master.SUBPRODUCT_ID + "');" %>
                                CommandName="NewFromRef" ImageUrl="/Common/Images/default/16/reference_open.png"
                                ToolTip="Добавить инфо-запрос из справочника" meta:resourcekey="ibNewFromRefResource2" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNewFromRef" runat="server" CausesValidation="False" OnClientClick=<%# "return ShowAvailableInfoQueries('" + Master.SUBPRODUCT_ID + "');" %>
                                CommandName="NewFromRef" ImageUrl="/Common/Images/default/16/reference_open.png"
                                ToolTip="Добавить инфо-запрос из справочника" meta:resourcekey="ibNewFromRefResource1" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
