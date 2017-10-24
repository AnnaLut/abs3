<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsinsurances.aspx.cs" Inherits="credit_constructor_wcsinsurances"
    Theme="default" MasterPageFile="~/credit/constructor/master.master" Title="Страховки"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../constructor/usercontrols/TextBoxSQLBlock.ascx" TagName="TextBoxSQLBlock"
    TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="Select" TypeName="credit.VWcsInsurances"
            SortParameterName="SortExpression"></asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="INSURANCE_ID" AutoSelectFirstRow="True"
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
                <asp:BoundField DataField="INSURANCE_ID" HeaderText="Идентификатор" SortExpression="INSURANCE_ID" />
                <asp:BoundField DataField="INSURANCE_NAME" HeaderText="Наименование" SortExpression="INSURANCE_NAME" />
                <asp:BoundField DataField="SURVEY_NAME" HeaderText="Анкета" SortExpression="SURVEY_NAME" />
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <Bars:BarsObjectDataSource ID="odsFV" runat="server" DataObjectTypeName="credit.VWcsInsurancesRecord"
            SelectMethod="SelectInsurance" TypeName="credit.VWcsInsurances" UpdateMethod="Update">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="INSURANCE_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsObjectDataSource ID="odsVWcsSurveys" runat="server" SelectMethod="Select"
            TypeName="credit.VWcsSurveys">
        </Bars:BarsObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="INSURANCE_ID" DataSourceID="odsFV"
            OnItemUpdated="fv_ItemUpdated" CssClass="formView" EnableModelValidation="True">
            <EditItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="INSURANCE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="INSURANCE_ID" runat="server" Text='<%# Bind("INSURANCE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="INSURANCE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <asp:Label ID="INSURANCE_NAME" runat="server" Text='<%# Bind("INSURANCE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text="Анкета :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SURVEY_ID" runat="server" DataSourceID="odsVWcsSurveys" DataValueField="SURVEY_ID"
                                DataTextField="SURVEY_NAME" SelectedValue='<%# Bind("SURVEY_ID") %>' IsRequired="true"
                                ValidationGroup="Main">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibUpdate" runat="server" CommandName="Update" ImageUrl="/Common/Images/default/16/save.png"
                                ToolTip="Сохранить" ValidationGroup="Main" />
                            <asp:ImageButton ID="ibCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                SkinID="ibCancel" />
                        </td>
                    </tr>
                </table>
            </EditItemTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="INSURANCE_IDTitle" runat="server" Text='Идентификатор :' />
                        </td>
                        <td>
                            <asp:Label ID="INSURANCE_ID" runat="server" Text='<%# Bind("INSURANCE_ID") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="INSURANCE_NAMETitle" runat="server" Text='Наименование :' />
                        </td>
                        <td>
                            <asp:Label ID="INSURANCE_NAME" runat="server" Text='<%# Bind("INSURANCE_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="titleCell">
                            <asp:Label ID="SURVEY_IDTitle" runat="server" Text="Анкета :" />
                        </td>
                        <td>
                            <bec:DDLList ID="SURVEY_ID" runat="server" DataSourceID="odsVWcsSurveys" DataValueField="SURVEY_ID"
                                DataTextField="SURVEY_NAME" SelectedValue='<%# Bind("SURVEY_ID") %>' Enabled="false">
                            </bec:DDLList>
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="/Common/Images/default/16/open.png" Text="Редактировать" ToolTip="Редактировать" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
