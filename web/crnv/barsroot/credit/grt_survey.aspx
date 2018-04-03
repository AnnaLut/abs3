<%@ Page Language="C#" MasterPageFile="~/credit/master.master" AutoEventWireup="true"
    CodeFile="grt_survey.aspx.cs" Inherits="credit_crdsrv_grt_survey" Theme="default"
    Title="Анкета обеспечения {0} - {1} заявки №{2}" meta:resourcekey="PageResource1" %>

<%@ MasterType VirtualPath="~/credit/master.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="dataContainer">
        <table id="tbSurveyContainer" runat="server" border="0" cellpadding="3" cellspacing="0">
            <tr id="Tr2" runat="server">
                <td id="Td1" runat="server">
                    <asp:ImageButton ID="ibShowHideAll" runat="server" ImageUrl="/Common/Images/default/16/win_max_all.png"
                        OnClientClick="ShowHideAll(this); return false;" meta:resourcekey="ibShowHideAllResource1" />
                </td>
                <td id="Td2" runat="server" colspan="2" style="font-size: 7pt">
                    <asp:Label ID="lbShowHideAll" runat="server" Text="Применить ко всем" meta:resourcekey="lbShowHideAllResource1"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
