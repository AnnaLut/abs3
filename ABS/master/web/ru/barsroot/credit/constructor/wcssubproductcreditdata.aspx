<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductcreditdata.aspx.cs"
    Inherits="credit_constructor_wcssubproductcreditdata" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Trace="false" Title="Данные кредита" MaintainScrollPositionOnPostback="true" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Src="../usercontrols/TextBoxQuestion_ID.ascx" TagName="TextBoxQuestion_ID"
    TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../constructor/usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
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
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectSubproductCreditdata"
            TypeName="credit.VWcsSubproductCreditdata">
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
            ShowPageSizeBox="False" DataKeyNames="CRDDATA_ID" AllowSorting="True" AutoSelectFirstRow="True"
            JavascriptSelectionType="ServerSelect" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvVWcsSubproductMacsResource1"
            ShowExportExcelButton="True">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="CRDDATA_NAME" HeaderText="Параметр" SortExpression="CRDDATA_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
                <asp:ImageField HeaderText="Установлен" NullImageUrl="/Common/Images/default/16/gear_error.png"
                    DataImageUrlField="QUESTION_ID" DataImageUrlFormatString="/Common/Images/default/16/gear_ok.png">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:ImageField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsSubproductCreditdataRecord"
            DeleteMethod="Delete" SelectMethod="SelectParam" TypeName="credit.VWcsSubproductCreditdata"
            UpdateMethod="Update">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gv" Name="CRDDATA_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
            <DeleteParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
                <asp:ControlParameter ControlID="gv" Name="CRDDATA_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </DeleteParameters>
        </asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="CRDDATA_ID" DataSourceID="odsFV"
            CssClass="formView" EnableModelValidation="True" OnItemUpdating="fv_ItemUpdating"
            OnItemDeleted="fv_ItemDeleted" OnItemUpdated="fv_ItemUpdated" OnItemDeleting="fv_ItemDeleting">
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell">
                    <tr>
                        <td>
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Параметр :' meta:resourcekey="IDLabelTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("CRDDATA_NAME") %>' meta:resourcekey="IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="TYPELabel" runat="server" Text='<%# Bind("TYPE_NAME") %>' meta:resourcekey="TYPETitleResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text="Вопрос обработчик :" />
                        </td>
                        <td>
                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" QUESTION_ID='<%# Bind("QUESTION_ID") %>'
                                TYPES='<%# Bind("TYPE_ID") %>' SECTIONS="inc:CREDITDATAS" IsRequired="true" runat="server"
                                ReadOnly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_VISIBLETitle" runat="server" Text="Отображать :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_VISIBLE" Value='<%# Bind("IS_VISIBLE") %>' runat="server" ReadOnly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_CHECKABLETitle" runat="server" Text="Проверять :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_CHECKABLE" Value='<%# Bind("IS_CHECKABLE") %>' runat="server"
                                DefaultValue="false" IsRequired="true" OnValueChanged="ValueChanged" OnPreRender="IS_CHECKABLE_PreRender"
                                Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_READONLYTitle" runat="server" Text='Только чтение:' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="IS_READONLY" runat="server" Value='<%# Bind("IS_READONLY") %>'
                                SECTIONS="inc:AUTHS,SURVEYS" Width="200" Enabled="false">
                            </bec:TextBoxSQLBlock>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="CHECK_PROCTitle" runat="server" Text="Текст проверки :" />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Rows="5" SECTIONS="inc:CREDITDATAS"
                                TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" Value='<%# Bind("CHECK_PROC") %>'
                                Width="350px" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать"
                                meta:resourcekey="ibEditResource1" />
                            <asp:ImageButton ID="ibDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                SkinID="ibDelete" OnClientClick="return confirm('Удалить строку?');" meta:resourcekey="ibDeleteResource1" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell">
                    <tr>
                        <td>
                            <asp:Label ID="IDLabelTitle" runat="server" Text='Параметр :' meta:resourcekey="IDLabelTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="IDLabel" runat="server" Text='<%# Bind("CRDDATA_NAME") %>' meta:resourcekey="IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPETitle" runat="server" Text="Тип :" meta:resourcekey="TYPETitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="TYPELabel" runat="server" Text='<%# Bind("TYPE_NAME") %>' meta:resourcekey="TYPETitleResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="QUESTION_IDTitle" runat="server" Text="Вопрос обработчик :" />
                        </td>
                        <td>
                            <bec:TextBoxQuestion_ID ID="QUESTION_ID" QUESTION_ID='<%# Bind("QUESTION_ID") %>'
                                TYPES='<%# Bind("TYPE_ID") %>' SECTIONS="inc:CREDITDATAS" IsRequired="true" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_VISIBLETitle" runat="server" Text="Отображать :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_VISIBLE" Value='<%# Bind("IS_VISIBLE") %>' runat="server" IsRequired="true"
                                DefaultValue="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_READONLYTitle" runat="server" Text='Только чтение:' />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="IS_READONLY" runat="server" Value='<%# Bind("IS_READONLY") %>'
                                SECTIONS="inc:AUTHS,SURVEYS" Width="200">
                            </bec:TextBoxSQLBlock>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="IS_CHECKABLETitle" runat="server" Text="Проверять :" />
                        </td>
                        <td>
                            <bec:RBLFlag ID="IS_CHECKABLE" Value='<%# Bind("IS_CHECKABLE") %>' runat="server"
                                DefaultValue="false" IsRequired="true" OnValueChanged="ValueChanged" OnPreRender="IS_CHECKABLE_PreRender" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="CHECK_PROCTitle" runat="server" Text="Текст проверки :" />
                        </td>
                        <td>
                            <bec:TextBoxSQLBlock ID="CHECK_PROC" runat="server" Rows="5" SECTIONS="inc:CREDITDATAS"
                                TextMode="MultiLine" TYPES="TEXT,NUMB,DECIMAL,DATE,LIST,REFER,BOOL" Value='<%# Bind("CHECK_PROC") %>'
                                Width="350px" />
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
        </asp:FormView>
    </div>
</asp:Content>
