<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxFile.ascx.cs" Inherits="Bars.UserControls.TextBoxFile" %>

<table border="0" cellpadding="3" cellspacing="0">
    <tr>
        <td valign="middle">
            <asp:FileUpload ID="fu" runat="server" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibUpLoad" runat="server" ImageUrl="/Common/Images/default/16/document_ok.png"
                ToolTip="Загрузить" OnClick="ibUpLoad_Click" CausesValidation="false" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibShow" runat="server" ImageUrl="/Common/Images/default/16/document_view.png"
                ToolTip="Просмотр" CausesValidation="false" />
        </td>
    </tr>
</table>
