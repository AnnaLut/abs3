<%@ Page Language="C#" MasterPageFile="~/credit/manager/master.master" AutoEventWireup="true"
    CodeFile="bid_deny.aspx.cs" Inherits="credit_manager_bid_deny" Title="Причина отказа по заявке №{0}"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/manager/master.master" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Src="../usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer" style="text-align: center">
        <table border="0" cellpadding="3" cellspacing="0">
            <tr>
                <td>
                    <asp:Label ID="lbComment" runat="server" Text="Комментарий" meta:resourcekey="lbCommentResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <bec:TextBoxString ID="Comment" runat="server" IsRequired="true" Rows="5" Width="300px" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btDeny" runat="server" Text="Отказать" OnClick="btDeny_Click" meta:resourcekey="btDenyResource1" />
                    <asp:Button ID="btCancel" runat="server" Text="Отмена" CausesValidation="False" OnClick="btCancel_Click"
                        meta:resourcekey="btCancelResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
