<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="process.aspx.cs" Inherits="credit_secretarycc_process" Title="Обработка заявки №{0}"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxFile.ascx" TagName="TextBoxFile" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxRefer.ascx" TagName="TextBoxRefer" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxScanner.ascx" TagName="TextBoxScanner" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <Bars:BarsObjectDataSource ID="ods" runat="server" SelectMethod="SelectCcBidInfoqueries"
            TypeName="credit.VWcsCcBidInfoqueries">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                <asp:QueryStringParameter QueryStringField="srvhr" Name="SRV_HIERARCHY" Type="String" />
            </SelectParameters>
        </Bars:BarsObjectDataSource>
        <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
            ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
            CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
            CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" EnableModelValidation="True"
            ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
            FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            HoverRowCssClass="hoverRow" MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
            MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
            ShowExportExcelButton="True" ShowPageSizeBox="False" DataKeyNames="IQUERY_ID,WS_ID"
            AutoSelectFirstRow="True" JavascriptSelectionType="ServerSelect" meta:resourcekey="gvResource1">
            <NewRowStyle CssClass=""></NewRowStyle>
            <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
            <Columns>
                <asp:BoundField DataField="IQUERY_NAME" HeaderText="Задание" SortExpression="IQUERY_NAME"
                    meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                <asp:TemplateField HeaderText="Обязательное" SortExpression="IS_REQUIRED" meta:resourcekey="TemplateFieldResource1">
                    <ItemTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="/Common/Images/default/16/gear_warning.png"
                            Visible='<%# (Decimal)Eval("IS_REQUIRED") == 1 %>' meta:resourcekey="img1Resource1" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Выполнено" SortExpression="STATUS" meta:resourcekey="TemplateFieldResource2">
                    <ItemTemplate>
                        <asp:Image ID="img2" runat="server" ImageUrl='<%# "/Common/Images/default/16/" + ((Decimal?)Eval("STATUS") == 2 ? "gear_ok.png" : "gear_forbidden.png") %>'
                            meta:resourcekey="img2Resource1" />
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
            </Columns>
            <EditRowStyle CssClass="editRow"></EditRowStyle>
            <FooterStyle CssClass="footerRow"></FooterStyle>
            <HeaderStyle CssClass="headerRow"></HeaderStyle>
            <PagerStyle CssClass="pagerRow"></PagerStyle>
            <RowStyle CssClass="normalRow"></RowStyle>
            <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
        </Bars:BarsGridViewEx>
    </div>
    <div class="formViewContainer">
        <asp:ObjectDataSource ID="odsFV" runat="server" SelectMethod="SelectCcBidInfoquery"
            TypeName="credit.VWcsCcBidInfoqueries">
            <SelectParameters>
                <asp:QueryStringParameter Name="BID_ID" QueryStringField="bid_id" Type="Decimal" />
                <asp:QueryStringParameter QueryStringField="srvhr" Name="SRV_HIERARCHY" Type="String" />
                <asp:ControlParameter ControlID="gv" Name="IQUERY_ID" PropertyName="SelectedValue"
                    Size="100" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:FormView ID="fv" runat="server" DataKeyNames="BID_ID,IQUERY_ID" DataSourceID="odsFV"
            CssClass="formView" OnPreRender="fv_PreRender" OnItemCommand="fv_ItemCommand"
            OnItemCreated="fv_ItemCreated" EnableModelValidation="True" meta:resourcekey="fvResource1">
            <ItemTemplate>
                <table border="0" cellpadding="3" cellspacing="0" class="contentTable">
                    <tr>
                        <td style="text-align: center">
                            <asp:Label ID="IQUERY_TEXT" runat="server" Text='<%# Bind("IQUERY_TEXT") %>' meta:resourcekey="IQUERY_TEXTResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 20px">
                            <asp:PlaceHolder ID="ph" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 20px" class="actionButtonsContainer">
                            <asp:Button ID="bFinish" SkinID="bNext" runat="server" Text="Далее" CommandName="Finish"
                                meta:resourcekey="bFinishResource1" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
</asp:Content>
