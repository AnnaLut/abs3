<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ByteImage.ascx.cs" Inherits="Bars.UserControls.ByteImage" %>
<table border="0">
    <tr>
        <asp:Image ID="img" runat="server" sid="" pcount_id="" prev_id="" next_id="" imgcount="" curimg="" type="" />
    </tr>
    <tr id="trButtonContainer" runat="server">
        <td style="text-align: center">
            <div id="dvPagerContainer" runat="server">
                <asp:ImageButton ID="ibPrev" runat="server" ImageUrl="/Common/Images/default/16/navigate_left.png"
                    Text="Попередня" ToolTip="Попередня сторінка" />
                <asp:Label ID="lbPageCount" runat="server" Text="Зображення 0 з 0" Font-Bold="True"
                    Font-Italic="True" ForeColor="#94ABD9"></asp:Label>
                <asp:ImageButton ID="ibNext" runat="server" ImageUrl="/Common/Images/default/16/navigate_right.png"
                    Text="Наступна" ToolTip="Наступна сторінка" />
            </div>
        </td>
        <td style="text-align: center; width: 25px">
            <div id="dvViewContainer" runat="server">
                <asp:ImageButton ID="ibView" runat="server" ImageUrl="/Common/Images/default/24/view.png"
                    ToolTip="Перегляд" CausesValidation="False" />
            </div>
        </td>
    </tr>
</table>
