<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="inn_create.aspx.cs" Inherits="credit_manager_inn_create" Title="Выбор клиента"
    Theme="default" Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/ByteImage.ascx" TagName="ByteImage" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <table class="dataTable">
        <tr>
            <td id="tdContainer" runat="server">
                <div class="dataContainer">
                    <table border="0" cellpadding="3" cellspacing="0">
                        <tr>
                            <td style="padding: 10px">
                                <table border="0" cellpadding="3" cellspacing="0" style="text-align: center">
                                    <tr>
                                        <td>
                                            <asp:Label ID="INNTitle" runat="server" Text='ИНН :' 
                                                meta:resourcekey="INNTitleResource1" />
                                        </td>
                                        <td>
                                            <bec:TextBoxString ID="INN" runat="server" IsRequired="True" MinLength="10" MaxLength="10">
                                            </bec:TextBoxString>
                                        </td>
                                        <td>
                                            <asp:Button ID="btSearch" runat="server" Text="Застосувати" SkinID="bSearch" 
                                                OnClick="btSearch_Click" meta:resourcekey="btSearchResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="SelectCustomers" TypeName="credit.VWcsCustomers">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="OKPO" ControlID="INN" PropertyName="Value" Size="100"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <Bars:BarsGridViewEx ID="gv" runat="server" AutoGenerateColumns="False" CaptionText=""
                                    ClearFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_delete.png"
                                    CssClass="barsGridView" DataSourceID="ods" DateMask="dd.MM.yyyy" ExcelImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.export_excel.png"
                                    FilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    MetaFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_open.png"
                                    MetaTableName="" RefreshImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.refresh.png"
                                    ShowPageSizeBox="False" AutoSelectFirstRow="True" CloseFilterImageUrl="mvwres://Bars.DataComponentsEx, Version=1.0.0.0, Culture=neutral, PublicKeyToken=464dd68da967e56c/Bars.DataComponents.Resources.filter_close.png"
                                    EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowExportExcelButton="True"
                                    DataKeyNames="RNK,OKPO" JavascriptSelectionType="ServerSelect" 
                                    meta:resourcekey="gvResource1">
                                    <FooterStyle CssClass="footerRow"></FooterStyle>
                                    <HeaderStyle CssClass="headerRow"></HeaderStyle>
                                    <EditRowStyle CssClass="editRow"></EditRowStyle>
                                    <PagerStyle CssClass="pagerRow"></PagerStyle>
                                    <NewRowStyle CssClass=""></NewRowStyle>
                                    <SelectedRowStyle CssClass="selectedRow"></SelectedRowStyle>
                                    <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="RNK" HeaderText="РНК" SortExpression="RNK" 
                                            meta:resourcekey="BoundFieldResource1"></asp:BoundField>
                                        <asp:BoundField DataField="OKPO" HeaderText="ИНН" SortExpression="OKPO" 
                                            meta:resourcekey="BoundFieldResource2" />
                                        <asp:BoundField DataField="NMK" HeaderText="Найменування" SortExpression="NMK" 
                                            meta:resourcekey="BoundFieldResource3"></asp:BoundField>
                                        <asp:BoundField DataField="DATE_ON" DataFormatString="{0:d}" HeaderText="Дата рег."
                                            SortExpression="DATE_ON" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle CssClass="normalRow"></RowStyle>
                                </Bars:BarsGridViewEx>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td class="nextButtonContainer" colspan="2">
                <asp:Button ID="bNext" SkinID="bNext" runat="server" OnClick="bNext_Click" 
                    meta:resourcekey="bNextResource1" />
            </td>
        </tr>
    </table>
</asp:Content>
