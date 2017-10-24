<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wcssubproductmacs.aspx.cs"
    Inherits="credit_constructor_wcssubproductmacs" Theme="default" MasterPageFile="~/credit/constructor/master.master"
    Title="МАКи субпродукта" meta:resourcekey="PageResource1" MaintainScrollPositionOnPostback="true"
    Trace="false" %>

<%@ MasterType VirtualPath="~/credit/constructor/master.master" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="/barsroot/UserControls/LabelTooltip.ascx" TagName="LabelTooltip"
    TagPrefix="Bars" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/jscript">
        function ShowAvailableMACs(subproduct_id) {
            var rnd = Math.random();
            var result = window.showModalDialog('/barsroot/credit/constructor/dialogs/wcsavailablemacs.aspx?subproduct_id=' + subproduct_id + '&rnd=' + rnd, window, dialogFeatures);

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
        <asp:ObjectDataSource ID="odsVWcsSubproductMacs" runat="server" SelectMethod="SelectSubproductMacs"
            TypeName="credit.VWcsSubproductMacs" SortParameterName="SortExpression">
            <SelectParameters>
                <asp:SessionParameter Name="SUBPRODUCT_ID" SessionField="WCS_SUBPRODUCT_ID" Size="100"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <Bars:BarsGridViewEx ID="gvVWcsSubproductMacs" runat="server" AutoGenerateColumns="False"
            CaptionText="" ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CssClass="barsGridView" DataSourceID="odsVWcsSubproductMacs" DateMask="dd.MM.yyyy"
            ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowPageSizeBox="False" DataKeyNames="MAC_ID" AllowSorting="True" JavascriptSelectionType="None"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            EnableModelValidation="True" HoverRowCssClass="hoverRow" meta:resourcekey="gvVWcsSubproductMacsResource1"
            ShowExportExcelButton="True" OnRowCommand="gvVWcsSubproductMacs_RowCommand">
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <NewRowStyle CssClass=""></NewRowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="MAC_ID" HeaderText="Идентификатор" SortExpression="MAC_ID" />
                <asp:BoundField DataField="MAC_NAME" HeaderText="Наименование" SortExpression="MAC_NAME" />
                <asp:BoundField DataField="TYPE_NAME" HeaderText="Тип" SortExpression="TYPE_NAME" />
                <asp:TemplateField HeaderText="Значение" SortExpression="VAL">
                    <ItemTemplate>
                        <div>
                            <asp:ImageButton ID="ibEdit" runat="server" ToolTip="Редактировать значение" ImageUrl="/Common/Images/default/16/open.png"
                                CommandName="VALUES" CommandArgument='<%# Eval("MAC_ID") %>' />
                            <Bars:LabelTooltip ID="VAL" runat="server" Text='<%# Eval("VAL") %>' TextLength="30"
                                UseTextForTooltip="true" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="APPLY_LEVEL_NAME" HeaderText="Уровень" SortExpression="APPLY_LEVEL">
                </asp:BoundField>
            </Columns>
            <RowStyle CssClass="normalRow"></RowStyle>
        </Bars:BarsGridViewEx>
    </div>
</asp:Content>
