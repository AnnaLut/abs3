<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ByteImage.ascx.cs" Inherits="Bars.UserControls.ByteImage" %>
<table border="0" style="border: 1px solid #94ABD9" cellpadding="3" cellspacing="0">
    <tr>
        <td id="ph" runat="server" colspan="2">
        </td>
    </tr>
    <tr>
        <td align="left">
            <asp:Label ID="lbPageCount" runat="server" Text="Зображення 0 з 0" Font-Bold="True"
                Font-Italic="True" ForeColor="#94ABD9" meta:resourcekey="lbPageCountResource1"></asp:Label>
        </td>
        <td align="right">
            <asp:ImageButton ID="ibView" runat="server" ImageUrl="/Common/Images/default/24/view.png"
                ToolTip="Просмотр" CausesValidation="False" meta:resourcekey="ibViewResource1" />
        </td>
    </tr>
</table>
