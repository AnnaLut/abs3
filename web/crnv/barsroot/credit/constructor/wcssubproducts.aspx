<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproducts.aspx.cs" Inherits="credit_constructor_wcssubproducts"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Субпродукты"
    meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="odsVWcsSubproducts" runat="server" SelectMethod="SelectSubproducts"
            TypeName="credit.VWcsSubproducts">
            <SelectParameters>
                <asp:SessionParameter Name="PRODUCT_ID" SessionField="WCS_PRODUCT_ID" Size="100"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gvVWcsSubproducts" runat="server" AutoGenerateColumns="False"
            CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="odsVWcsSubproducts" DateMask="dd.MM.yyyy"
            ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="SUBPRODUCT_ID" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvVWcsSubproductsResource1">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="SUBPRODUCT_ID" HeaderText="Идентификатор" SortExpression="SUBPRODUCT_ID"
                    meta:resourcekey="BoundFieldResource1">
                    <ItemStyle Width="30%" />
                </asp:BoundField>
                <asp:BoundField DataField="SUBPRODUCT_NAME" HeaderText="Наименование" SortExpression="SUBPRODUCT_NAME"
                    meta:resourcekey="BoundFieldResource2" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsVWcsSubproductsFV" runat="server" DataObjectTypeName="credit.VWcsSubproductsRecord"
            DeleteMethod="Delete" InsertMethod="Insert" SelectMethod="SelectSubproduct" TypeName="credit.VWcsSubproducts"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:SessionParameter Name="PRODUCT_ID" SessionField="WCS_PRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gvVWcsSubproducts" Name="SUBPRODUCT_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:FormView ID="fvVWcsSubproducts" runat="server" DataKeyNames="SUBPRODUCT_ID,PRODUCT_ID"
            DataSourceID="odsVWcsSubproductsFV" OnItemInserting="fvVWcsSubproducts_ItemInserting"
            OnItemDeleted="fvVWcsSubproducts_ItemDeleted" OnItemInserted="fvVWcsSubproducts_ItemInserted"
            OnItemUpdated="fvVWcsSubproducts_ItemUpdated" OnItemCommand="fvVWcsSubproducts_ItemCommand"
            CssClass="formView" EnableModelValidation="True" meta:resourcekey="fvVWcsSubproductsResource1">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Идентификатор :' meta:resourcekey="IDLabelTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>' meta:resourcekey="IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("SUBPRODUCT_NAME") %>'
                                Width="300px"></bec:TextBoxString>
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
                                Value='<%# Bind("SUBPRODUCT_ID") %>'></bec:TextBoxString>
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource2" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="NAMETextBox" runat="server" IsRequired="True" Value='<%# Bind("SUBPRODUCT_NAME") %>'
                                Width="300px"></bec:TextBoxString>
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
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("SUBPRODUCT_ID") %>' meta:resourcekey="IDLabelResource2" />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="NAMELabelTitle" runat="server" Text='Наименование :' meta:resourcekey="NAMELabelTitleResource3" />
                        </td>
                        <td>
                            <asp:Label ID="NAMELabel" runat="server" Text='<%# Bind("SUBPRODUCT_NAME") %>' meta:resourcekey="NAMELabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2" style="text-align: left">
                            <asp:LinkButton ID="lbtMACs" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowMACs" ToolTip="МАКи">МАКи</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtCreditData" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowCreditData" ToolTip="Данные кредита">Данные кредита</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtScanCopies" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowScanCopies" ToolTip="Карта сканкопий клиента">Карта сканкопий клиента</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtAuths" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowAuths" ToolTip="Карта авторизации">Карта авторизации</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtSurveys" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowSurveys" ToolTip="Анкета клиента">Анкета клиента</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtGarantee" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowGarantee" ToolTip="Обеспечение">Обеспечение</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtInsurance" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowInsurance" ToolTip="Страховки клиента">Страховки клиента</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtInfoQueries" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowInfoQueries" ToolTip="Информационные запросы">Информационные запросы</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtSolvencies" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowSolvencies" ToolTip="Карта кредитоспособности">Карта кредитоспособности</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtScorings" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowScorings" ToolTip="Карта скоринга">Карта скоринга</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtStops" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowStops" ToolTip="Стоп правила/факторы">Стоп правила/факторы</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtDocs" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowDocs" ToolTip="Шаблоны документов">Шаблоны документов</asp:LinkButton>
                            <br />
                            <asp:LinkButton ID="lbtPayments" runat="server" CommandArgument='<%# Eval("SUBPRODUCT_ID") %>'
                                CommandName="ShowPayments" ToolTip="Платежные инструкции">Платежные инструкции</asp:LinkButton>
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
