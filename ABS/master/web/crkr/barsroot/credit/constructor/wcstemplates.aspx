<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcstemplates.aspx.cs" Inherits="credit_constructor_wcstemplates"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Шаблоны"
    Trace="false" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectTemplates" TypeName="credit.VWcsTemplates"
            SortParameterName="SortExpression"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsDocexportTypes" runat="server" SelectMethod="Select"
            TypeName="credit.WcsDocexportTypes"></asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="TEMPLATE_ID" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="TEMPLATE_ID" HeaderText="Идентификатор" SortExpression="TEMPLATE_ID" />
                <asp:BoundField DataField="TEMPLATE_NAME" HeaderText="Наименование" SortExpression="TEMPLATE_NAME" />
                <asp:BoundField DataField="DOCEXP_TYPE_NAME" HeaderText="Формат" SortExpression="DOCEXP_TYPE_NAME" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsTemplatesRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectTemplate" TypeName="credit.VWcsTemplates"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="TEMPLATE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="TEMPLATE_ID" DataSourceID="odsFV"
            OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
            CssClass="formView" EnableModelValidation="True">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="TEMPLATE_ID" runat="server" Text='<%# Bind("TEMPLATE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="TEMPLATE_NAME" runat="server" IsRequired="True" Value='<%# Bind("TEMPLATE_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="DOCEXP_TYPE_NAMETitle" runat="server" Text='Формат :' />
                        </td>
                        <td>
                            <bec:DDLList ID="DOCEXP_TYPE_ID" runat="server" DataSourceID="odsDocexportTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("DOCEXP_TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="FILE_NAMETitle" runat="server" Text="Файл :" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="FILE_NAME" runat="server" IsRequired="True" Value='<%# Bind("FILE_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Сохранить" ToolTip="Сохранить" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="TEMPLATE_ID" runat="server" IsRequired="True" Value='<%# Bind("TEMPLATE_ID") %>'>
                            </bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <bec:TextBoxString ID="TEMPLATE_NAME" runat="server" IsRequired="True" Value='<%# Bind("TEMPLATE_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="DOCEXP_TYPE_NAMETitle" runat="server" Text='Формат :' />
                        </td>
                        <td>
                            <bec:DDLList ID="DOCEXP_TYPE_ID" runat="server" DataSourceID="odsDocexportTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("DOCEXP_TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="FILE_NAMETitle" runat="server" Text="Файл :" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="FILE_NAME" runat="server" IsRequired="True" Value='<%# Bind("FILE_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Insert" ImageUrl="/Common/Images/default/16/save.png"
                                Text="Добавить" ToolTip="Добавить" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                </table>
            </InsertItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="TEMPLATE_ID" runat="server" Text='<%# Bind("TEMPLATE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TEMPLATE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <asp:Label ID="TEMPLATE_NAME" runat="server" Text='<%# Bind("TEMPLATE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="DOCEXP_TYPE_NAMETitle" runat="server" Text='Формат :' />
                        </td>
                        <td>
                            <asp:Label ID="DOCEXP_TYPE_NAME" runat="server" Text='<%# Bind("DOCEXP_TYPE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="FILE_NAMETitle" runat="server" Text="Файл :" />
                        </td>
                        <td>
                            <asp:Label ID="FILE_NAME" runat="server" Text='<%# Bind("FILE_NAME") %>' />
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
