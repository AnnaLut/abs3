<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsstops.aspx.cs" Inherits="credit_constructor_wcsstops"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Стопы"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../constructor/usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsStops"
            SortParameterName="SortExpression"></asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="STOP_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true">
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
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsStopsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectStop" TypeName="credit.VWcsStops"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="STOP_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsStopTypes" runat="server" SelectMethod="Select" TypeName="credit.WcsStopTypes">
        </asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="STOP_ID" DataSourceID="odsFV"
            OnItemDeleted="fv_ItemDeleted" OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated"
            CssClass="formView" EnableModelValidation="True">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("STOP_ID") %>' meta:resourcekey="IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("STOP_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsStopTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" colspan="2" style="text-align: left">
                            <asp:Label ID="PLSQLTitle" runat="server" Text="plsql блок :" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <bec:TextBoxSQLBlock ID="PLSQLTextBox" Value='<%# Bind("PLSQL") %>' IsRequired="true"
                                Rows="8" TextMode="MultiLine" Width="400px" runat="server" />
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
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="IDTextBox" runat="server" IsRequired="True" MaxLength="100"
                                Value='<%# Bind("STOP_ID") %>'></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("STOP_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsStopTypes"
                                DataValueField="ID" DataTextField="NAME" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell" colspan="2" style="text-align: left">
                            <asp:Label ID="PLSQLTitle" runat="server" Text="plsql блок :" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <bec:TextBoxSQLBlock ID="PLSQLTextBox" Value='<%# Bind("PLSQL") %>' IsRequired="true"
                                Rows="8" TextMode="MultiLine" Width="400px" runat="server" />
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
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("STOP_ID") %>' meta:resourcekey="IDLabelResource2" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="NAMELabel" runat="server" Text='<%# Bind("STOP_NAME") %>' meta:resourcekey="NAMELabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource3" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsStopTypes"
                                DataValueField="ID" DataTextField="NAME" ReadOnly="true" SelectedValue='<%# Bind("TYPE_ID") %>'>
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
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку"
                                meta:resourcekey="ibNewResource2" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibNew" runat="server" CausesValidation="False" CommandName="New"
                                ImageUrl="/Common/Images/default/16/new.png" Text="Добавить строку" ToolTip="Добавить строку"
                                meta:resourcekey="ibNewResource1" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
