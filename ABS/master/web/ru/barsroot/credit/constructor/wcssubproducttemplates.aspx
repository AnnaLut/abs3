<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproducttemplates.aspx.cs"
    Inherits="credit_constructor_wcssubproducttemplates" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Шаблоны" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSubproductTemplates"
            TypeName="credit.VWcsSubproductTemplates" SortParameterName="SortExpression">
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
            ShowPageSizeBox="False" DataKeyNames="TEMPLATE_ID" AllowSorting="True" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" 
            meta:resourcekey="gvVWcsSubproductMacsResource1" ShowExportExcelButton="True">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="PRINT_STATE_NAME" HeaderText="Этап" SortExpression="PRINT_STATE_NAME" />
                <asp:BoundField DataField="TEMPLATE_ID" HeaderText="Идентификатор" SortExpression="TEMPLATE_ID" />
                <asp:BoundField DataField="TEMPLATE_NAME" HeaderText="Наименование" SortExpression="STOP_NAME" />
                <asp:TemplateField HeaderText="Обязательное сканирование" 
                    SortExpression="IS_SCAN_REQUIRED">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("IS_SCAN_REQUIRED") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# (Decimal)Eval("IS_SCAN_REQUIRED") == 1 %>' Enabled="False" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSubproductTemplatesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSubproductTemplate"
            TypeName="credit.VWcsSubproductTemplates" UpdateMethod="Update">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gv" Name="TEMPLATE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsVWcsTemplates" runat="server" SelectMethod="SelectTemplates"
            TypeName="credit.VWcsTemplates"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsPrintStates" runat="server" SelectMethod="SelectPrintStates"
            TypeName="credit.WcsPrintStates"></asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataSourceID="odsFV" DataKeyNames="SUBPRODUCT_ID,TEMPLATE_ID"
            OnItemDeleted="fv_ItemDeleted" CssClass="formView" EnableModelValidation="True"
            OnItemUpdated="fv_ItemUpdated" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <bec:DDLList ID="TEMPLATE_ID" runat="server" DataSourceID="odsVWcsTemplates" DataValueField="TEMPLATE_ID"
                                DataTextField="TEMPLATE_NAME" SelectedValue='<%# Bind("TEMPLATE_ID") %>' Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="PRINT_STATE_IDTitle" runat="server" Text="Этап :" />
                        </td>
                        <td>
                            <bec:DDLList ID="PRINT_STATE_ID" runat="server" DataSourceID="odsWcsPrintStates"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("PRINT_STATE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_SCAN_REQUIREDTitle" runat="server" Text="Обязательное сканирование :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_SCAN_REQUIRED" IsRequired="false" DefaultValue="true" runat="server"
                                Value='<%# Bind("IS_SCAN_REQUIRED") %>' />
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
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <bec:DDLList ID="TEMPLATE_ID" runat="server" DataSourceID="odsVWcsTemplates" DataValueField="TEMPLATE_ID"
                                DataTextField="TEMPLATE_NAME" SelectedValue='<%# Bind("TEMPLATE_ID") %>' Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="PRINT_STATE_IDTitle" runat="server" Text="Этап :" />
                        </td>
                        <td>
                            <bec:DDLList ID="PRINT_STATE_ID" runat="server" DataSourceID="odsWcsPrintStates"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("PRINT_STATE_ID") %>'
                                Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_SCAN_REQUIREDTitle" runat="server" Text="Обязательное сканирование :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_SCAN_REQUIRED" IsRequired="false" DefaultValue="true" runat="server"
                                Value='<%# Bind("IS_SCAN_REQUIRED") %>' Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" ToolTip="Редактировать" />
                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" />
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" ToolTip="Добавить строку" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text="Наименование :" />
                        </td>
                        <td>
                            <bec:DDLList ID="TEMPLATE_ID" runat="server" DataSourceID="odsVWcsTemplates" DataValueField="TEMPLATE_ID"
                                DataTextField="TEMPLATE_NAME" SelectedValue='<%# Bind("TEMPLATE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="PRINT_STATE_IDTitle" runat="server" Text="Этап :" />
                        </td>
                        <td>
                            <bec:DDLList ID="PRINT_STATE_ID" runat="server" DataSourceID="odsWcsPrintStates"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("PRINT_STATE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IS_SCAN_REQUIREDTitle" runat="server" Text="Обязательное сканирование :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_SCAN_REQUIRED" IsRequired="false" DefaultValue="true" runat="server"
                                Value='<%# Bind("IS_SCAN_REQUIRED") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Добавить" ToolTip="Добавить" meta:resourcekey="ibUpdateResource2" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" meta:resourcekey="ibCancelResource2" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" ToolTip="Добавить строку" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
