<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EADoc.ascx.cs" Inherits="Bars.UserControls.EADoc" %>
<table border="0">
    <tr>
        <td>
            <asp:Label ID="lbTitle" runat="server" />
        </td>
        <td>
            <asp:ImageButton ID="ibPrint" runat="server" AlternateText="Друкувати документ" ImageUrl="/Common/Images/default/24/printer.png" OnClick="ibPrint_Click" />
        </td>
        <td>
            <asp:CheckBox ID="cbSigned" runat="server" Text="&nbsp;Підписано" ToolTip="Документ підписаний клієнтом та готовий до передачі в ЕА" OnCheckedChanged="cbSigned_CheckedChanged" AutoPostBack="true" />
        </td>
    </tr>
</table>
<asp:HiddenField ID="hDocID" runat="server" />
