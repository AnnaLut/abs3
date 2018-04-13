<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="import_macs.aspx.cs" Inherits="credit_sync_import_macs" Title="Импорт МАКов из файла"
    Theme="default" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/TextBoxDecimal.ascx" TagName="TextBoxDecimal" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/RBLFlag.ascx" TagName="RBLFlag" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table border="0" cellpadding="3" cellspacing="0" width="99%">
            <tr>
                <td class="sectionTitle">
                    <asp:Label ID="SearchTitle" runat="server" Text="Файл"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px">
                    <table border="0" cellpadding="3" cellspacing="0" width="99%">
                        <tr valign="top">
                            <td>
                                <table border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="DateTitle" runat="server" Text="Файл для импорта :"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:FileUpload ID="fu" runat="server" Width="300px" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="padding-top: 10px">
                                <asp:Button ID="btUpload" runat="server" SkinID="bUpload" Text="Загрузить" OnClick="btUpload_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px">
                                <asp:Panel ID="pnlImpProtocol" runat="server" GroupingText="Протокол импорта">
                                    <asp:Literal ID="lProtocol" runat="server"></asp:Literal>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
