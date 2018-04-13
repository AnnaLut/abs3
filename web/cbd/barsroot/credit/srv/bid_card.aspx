<%@ Page Language="C#" MasterPageFile="~/credit/srv_bid_card.master" AutoEventWireup="true"
    CodeFile="bid_card.aspx.cs" Inherits="credit_srv_bid_card" Title="Карточка заявки №{0}"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/srv_bid_card.master" %>
<asp:Content ID="cCommands" ContentPlaceHolderID="cphCommands" runat="Server">
    <asp:Panel ID="pnlCommands" runat="server" GroupingText="Команды" meta:resourcekey="pnlCommandsResource1">
        <table class="dataTable">
            <tr>
                <td>
                    <asp:LinkButton ID="lbFinish" runat="server" CommandName="Finish" OnClick="lbFinish_Click"
                        Text="Завершить обработку заявки" meta:resourcekey="lbFinishResource1"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
<asp:Content ID="cProcess" ContentPlaceHolderID="cphProcess" runat="server">
    <asp:Panel ID="pnlProcess" runat="server" GroupingText="Обработка" meta:resourcekey="pnlProcessResource1">
        <table class="dataTable">
            <tr>
                <td>
                    <asp:LinkButton ID="lbPROCCESS" runat="server" Text="Обработать" CommandName="PROCCESS"
                        OnClick="lbPROCCESS_Click" meta:resourcekey="lbPROCCESSResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbDOCS" runat="server" Text="Печать документов" CommandName="DOCS"
                        OnClick="lbDOCS_Click" meta:resourcekey="lbDOCSResource1"></asp:LinkButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
