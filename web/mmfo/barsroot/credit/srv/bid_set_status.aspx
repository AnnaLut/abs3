<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="bid_set_status.aspx.cs" Inherits="credit_crdsrv_bid_set_status" Title="Рішення по заявці №{0}"
    Theme="default" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="../usercontrols/DDLList.ascx" TagName="DDLList" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <bars:BarsSqlDataSourceEx ID="sds" runat="server" ProviderName="barsroot.core" AllowPaging="False" PageButtonCount="10" PagerMode="NextPrevious" PageSize="10">
    </bars:BarsSqlDataSourceEx>
    <div class="dataContainer" style="text-align: center">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td align="right">
                    <asp:Label ID="lbStatus" runat="server" Text="Результат перевірки"></asp:Label>
                </td>
                <td align="left">
                    <bec:DDLList ID="ddlStatus" runat="server" DataSourceID="sds" DataValueField="ORD"
                        DataTextField="TEXT" IsRequired="true">
                    </bec:DDLList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <asp:Label ID="lbComment" runat="server" Text="Коментар"></asp:Label>
                </td>
                <td align="left">
                    <bec:TextBoxString ID="Comment" runat="server" IsRequired="false" Rows="5" Width="300px" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btSetStatus" runat="server" Text="Підтвердити" OnClick="btSetStatus_Click" />
                    <asp:Button ID="btCancel" runat="server" Text="Відміна" CausesValidation="False" OnClick="btCancel_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
