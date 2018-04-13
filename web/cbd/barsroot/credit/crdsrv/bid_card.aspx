<%@ Page Language="C#" MasterPageFile="~/credit/srv_bid_card.master" AutoEventWireup="true"
    CodeFile="bid_card.aspx.cs" Inherits="credit_crdsrv_bid_card" Title="Карточка заявки №{0}"
    Trace="false" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/srv_bid_card.master" %>
<asp:Content ID="cCommands" ContentPlaceHolderID="cphCommands" runat="Server">
    <asp:Panel ID="pnlCommands" runat="server" GroupingText="Команды" meta:resourcekey="pnlCommandsResource1" Height="162px">
        <table class="dataTable" style="height: 70px">
            <tr>
                <td>
                    <asp:LinkButton ID="lbSend2Srvs" runat="server" CommandName="Send2Srvs" OnClick="lbSend2Srvs_Click"
                        Text="Завершить обработку и передать на рассмотрение служб" meta:resourcekey="lbSend2SrvsResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbFinishSrvAnalyse" runat="server" CommandName="FinishSrvAnalyse"
                        OnClick="lbFinishSrvAnalyse_Click" Text="Завершить анализ рассмотрения службами и передать на КК"
                        meta:resourcekey="lbFinishSrvAnalyseResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbFinishCcAnalyse" runat="server" CommandName="FinishCcAnalyse"
                        OnClick="lbFinishCcAnalyse_Click" Text="Завершить анализ решения КК" meta:resourcekey="lbFinishCcAnalyseResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lb2SrvsReInput" runat="server" CommandName="2SrvsReInput"
                         OnClick="lb2SrvsReInput_Click" Text="Вернуть на рассмотрение службами" meta:resourcekey="lb2SrvsReInputResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lbDataReInput" runat="server" CommandName="DataReInput" OnClick="lbDataReInput_Click"
                        Text="Передать на доработку" meta:resourcekey="lbDataReInputResource1"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td style="height: 13px">
                    <asp:LinkButton ID="lbDeny" runat="server" CommandName="Deny" OnClick="lbDeny_Click"
                        Text="Отклонить заявку" meta:resourcekey="lbDenyResource1"></asp:LinkButton>
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
