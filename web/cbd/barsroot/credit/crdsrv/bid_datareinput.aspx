<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="bid_datareinput.aspx.cs" Inherits="credit_crdsrv_bid_datareinput" Title="Причина доработки по заявке №{0}"
    Theme="default" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
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
                    <asp:Button ID="btDataReInput" runat="server" Text="Отправить" ToolTip="Отправить на доработку"
                        OnClick="btDataReInput_Click" meta:resourcekey="btDataReInputResource1" />
                    <asp:Button ID="btCancel" runat="server" Text="Отмена" CausesValidation="False" OnClick="btCancel_Click"
                        meta:resourcekey="btCancelResource1" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
