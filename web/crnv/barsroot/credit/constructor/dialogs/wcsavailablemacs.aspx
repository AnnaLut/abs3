<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcsavailablemacs.aspx.cs"
    Inherits="credit_constructor_dialogs_wcsavailablemacs" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="Доступные МАКи" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../../usercontrols/TextBoxString.ascx" TagName="TextBoxString"
    TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal"
    TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <base target="_self" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsSqlDataSourceEx ID="sds" runat="server" AllowPaging="False" ProviderName="barsroot.core"
            SelectCommand="select * from v_wcs_macs m where m.mac_id not in (select sm.mac_id from v_wcs_subproduct_macs sm where sm.subproduct_id = :SUBPRODUCT_ID) order by m.mac_id">
            <SelectParameters>
                <asp:QueryStringParameter Name="SUBPRODUCT_ID" QueryStringField="subproduct_id" Type="String" />
            </SelectParameters>
        </Bars:BarsSqlDataSourceEx>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="sds" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="MAC_ID" AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvResource1"
            ShowExportExcelButton="True">
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
        <asp:ObjectDataSource ID="odsWcsMacListItems" runat="server" SelectMethod="Select"
            TypeName="credit.WcsMacListItems">
            <SelectParameters>
                <asp:ControlParameter ControlID="gv" Name="MAC_ID" PropertyName="SelectedValue" Size="100"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsSqlDataSourceEx ID="sdsFV" runat="server" AllowPaging="False" ProviderName="barsroot.core"
            SelectCommand="select * from v_wcs_macs m where m.mac_id not in (select sm.mac_id from v_wcs_subproduct_macs sm where sm.subproduct_id = :SUBPRODUCT_ID) and m.mac_id = :MAC_ID order by m.mac_id">
            <SelectParameters>
                <asp:QueryStringParameter Name="SUBPRODUCT_ID" QueryStringField="subproduct_id" Type="String" />
                <asp:ControlParameter ControlID="gv" Name="MAC_ID" PropertyName="SelectedValue" Size="100"
                    Type="String" />
            </SelectParameters>
        </Bars:BarsSqlDataSourceEx>
        <asp:FormView ID="fvVWcsAvailableMacs" runat="server" DataSourceID="sdsFV" DataKeyNames="MAC_ID,TYPE_ID"
            OnItemCommand="fvVWcsAvailableMacs_ItemCommand" CssClass="formView" EnableModelValidation="True"
            meta:resourcekey="fvVWcsAvailableMacsResource1">
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <col class="titleCell" />
                    <tr>
                        <td>
                            <asp:Label ID="MAC_IDTitle" runat="server" Text="Идентификатор :" meta:resourcekey="MAC_IDTitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="MAC_IDLabel" runat="server" Text='<%# Bind("MAC_ID") %>' meta:resourcekey="MAC_IDLabelResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="MAC_NAMETitle" runat="server" Text="Наименование :" meta:resourcekey="MAC_NAMETitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="MAC_NAME" runat="server" Text='<%# Bind("MAC_NAME") %>' meta:resourcekey="MAC_NAMEResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="TYPE_NAMETitle" runat="server" Text="Тип :" meta:resourcekey="TYPE_NAMETitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="TYPE_NAME" runat="server" Text='<%# Bind("TYPE_NAME") %>' meta:resourcekey="TYPE_NAMEResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="APPLY_LEVEL_NAMETitle" runat="server" Text="Уровень применения :"
                                meta:resourcekey="APPLY_LEVEL_NAMETitleResource1" />
                        </td>
                        <td>
                            <asp:Label ID="APPLY_LEVEL_NAME" runat="server" Text='<%# Bind("APPLY_LEVEL_NAME") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="VALTitle" runat="server" Text="Значение :" meta:resourcekey="VALTitleResource1" />
                        </td>
                        <td>
                            <bec:TextBoxString ID="VAL_TEXTTextBox" Visible='<%# (String)Eval("TYPE_ID") == "TEXT" %>'
                                runat="server" IsRequired="True"></bec:TextBoxString>
                            <bec:TextBoxNumb ID="VAL_NUMBTextBox" Visible='<%# (String)Eval("TYPE_ID") == "NUMB" %>'
                                runat="server" IsRequired="True"></bec:TextBoxNumb>
                            <bec:TextBoxDecimal ID="VAL_DECIMALTextBox" Visible='<%# (String)Eval("TYPE_ID") == "DECIMAL" %>'
                                runat="server" IsRequired="True"></bec:TextBoxDecimal>
                            <bec:TextBoxDate ID="VAL_DATETextBox" Visible='<%# (String)Eval("TYPE_ID") == "DATE" %>'
                                runat="server" IsRequired="True"></bec:TextBoxDate>
                            <bec:DDLList ID="VAL_LISTDropDownList" Visible='<%# (String)Eval("TYPE_ID") == "LIST" %>'
                                runat="server" AppendSelectedValue="true" DataSourceID="odsWcsMacListItems" DataTextField="TEXT"
                                DataValueField="ORD">
                            </bec:DDLList>
                            <bec:TextBoxRefer ID="VAL_REFERTextBox" Visible='<%# (String)Eval("TYPE_ID") == "REFER" %>'
                                runat="server" IsRequired="True" MAC_ID='<%# Bind("MAC_ID") %>' />
                            <bec:TextBoxFile ID="VAL_FILETextBox" Visible='<%# (String)Eval("TYPE_ID") == "FILE" %>'
                                runat="server" FileName="ico.jpg" IsRequired="true" />
                            <bec:RBLFlag ID="VAL_BOOLRadioButtonList" Visible='<%# (String)Eval("TYPE_ID") == "BOOL" %>'
                                IsRequired="true" DefaultValue="false" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:ImageButton ID="ibAdd" runat="server" CommandName="Add" ImageUrl="/Common/Images/default/16/ok.png"
                                Text="Добавить" ToolTip="Добавить" meta:resourcekey="ibAddResource1" />
                            <asp:ImageButton ID="ibClose" runat="server" CausesValidation="False" CommandName="Close"
                                SkinID="ibCancel" OnClientClick="CloseDialog(null);" meta:resourcekey="ibCloseResource1" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
            <EmptyDataTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable" style="width: auto">
                    <tr>
                        <td class="actionButtonsContainer" colspan="2">
                            <asp:Label ID="NO_MACSLable" runat="server" Text="Доступных МАКов нет." meta:resourcekey="NO_MACSLableResource1" />
                        </td>
                    </tr>
                </table>
            </EmptyDataTemplate>
        </asp:FormView>
    </div>
</asp:Content>
