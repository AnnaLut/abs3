<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsmacs.aspx.cs" Inherits="credit_constructor_wcsmacs"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="МАКи"
    Trace="false" meta:resourcekey="PageResource1" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/MACListEditor.ascx" TagName="MACListEditor" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/MACReferEditor.ascx" TagName="MACReferEditor" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="odsVWcsMacs" runat="server" SelectMethod="SelectMacs" TypeName="credit.VWcsMacs"
            SortParameterName="SortExpression"></asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gvVWcsMacs" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="odsVWcsMacs" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="MAC_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" AllowSorting="true"
            meta:resourcekey="gvVWcsMacsResource1">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="MAC_ID" HeaderText="Идентификатор" SortExpression="MAC_ID"
                    meta:resourcekey="BoundFieldResource1">
                    <ItemStyle Width="20%" />
                </asp:BoundField>
                <asp:BoundField DataField="MAC_NAME" HeaderText="Наименование" SortExpression="MAC_NAME"
                    meta:resourcekey="BoundFieldResource2" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME"
                    meta:resourcekey="BoundFieldResource3">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="APPLY_LEVEL_NAME" HeaderText="Уровень" SortExpression="APPLY_LEVEL"
                    meta:resourcekey="BoundFieldResource4"></asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsMacsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectMac" TypeName="credit.VWcsMacs"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gvVWcsMacs" Name="MAC_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsMacTypes" runat="server" SelectMethod="Select" TypeName="credit.WcsMacTypes">
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="odsWcsSrvHierarchy" runat="server" SelectMethod="Select"
            TypeName="credit.WcsSrvHierarchy"></asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="MAC_ID" DataSourceID="odsFV" OnItemDeleted="fv_ItemDeleted"
            OnItemInserted="fv_ItemInserted" OnItemUpdated="fv_ItemUpdated" CssClass="formView"
            EnableModelValidation="True" meta:resourcekey="fvResource1">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("MAC_ID") %>' meta:resourcekey="IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("MAC_NAME") %>'
                                Width="300px"></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsMacTypes" DataValueField="ID"
                                DataTextField="NAME" ReadOnly="true" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="APPLY_LEVELTitle" runat="server" Text="Уровень применения :" meta:resourcekey="APPLY_LEVELTitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="APPLY_LEVEL" runat="server" DataSourceID="odsWcsSrvHierarchy" DataValueField="ID"
                                DataTextField="NAME" SelectedValue='<%# Bind("APPLY_LEVEL") %>'>
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
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:MultiView ID="mv" runat="server" Visible='<%# (String)Eval("TYPE_ID") == "LIST" || (String)Eval("TYPE_ID") == "REFER" %>'
                                ActiveViewIndex='<%# (String)Eval("TYPE_ID") == "LIST" ? 0 : 1 %>'>
                                <asp:View ID="vList" runat="server">
                                    <asp:Panel ID="pnlList" runat="server" GroupingText="Список">
                                        <bec:MACListEditor ID="le" runat="server" MAC_ID='<%# Bind("MAC_ID") %>' />
                                    </asp:Panel>
                                </asp:View>
                                <asp:View ID="vRefer" runat="server">
                                    <asp:Panel ID="Panel1" runat="server" GroupingText="Справочник">
                                        <bec:MACReferEditor ID="re" runat="server" MAC_ID='<%# Bind("MAC_ID") %>' />
                                    </asp:Panel>
                                </asp:View>
                            </asp:MultiView>
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <InsertItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="IDTextBox" runat="server" IsRequired="True" MaxLength="100"
                                Value='<%# Bind("MAC_ID") %>'></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("MAC_NAME") %>'
                                Width="300px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource2" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsMacTypes" DataValueField="ID"
                                DataTextField="NAME" IsRequired="true" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="APPLY_LEVELTitle" runat="server" Text="Уровень применения :" meta:resourcekey="APPLY_LEVELTitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="APPLY_LEVEL" runat="server" DataSourceID="odsWcsSrvHierarchy" DataValueField="ID"
                                DataTextField="NAME" IsRequired="true" SelectedValue='<%# Bind("APPLY_LEVEL") %>'>
                            </bec:DDLList>
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
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("MAC_ID") %>' meta:resourcekey="IDLabelResource2" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="NAMELabel" runat="server" Text='<%# Bind("MAC_NAME") %>' meta:resourcekey="NAMELabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource3" />
                        </td>
                        <td>
                            <bec:DDLList ID="TYPEDropDownList" runat="server" DataSourceID="odsWcsMacTypes" DataValueField="ID"
                                DataTextField="NAME" ReadOnly="true" SelectedValue='<%# Bind("TYPE_ID") %>'>
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="APPLY_LEVELTitle" runat="server" Text="Уровень применения :" meta:resourcekey="APPLY_LEVELTitleResource1" />
                        </td>
                        <td>
                            <bec:DDLList ID="APPLY_LEVEL" runat="server" DataSourceID="odsWcsSrvHierarchy" DataValueField="ID"
                                DataTextField="NAME" ReadOnly="true" SelectedValue='<%# Bind("APPLY_LEVEL") %>'>
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
