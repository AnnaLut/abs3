<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxScanner.ascx.cs"
    Inherits="Bars.UserControls.TextBoxScanner" %>
<%@ Register Src="TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>

<table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td valign="middle">
            <bec:TextBoxString ID="tb" runat="server" ReadOnly="True" 
                MinMaxLengthErrorText="Не загружен файл" RequiredErrorText="Не загружен файл" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibScan" runat="server" 
                ImageUrl="/Common/Images/default/16/gear_run.png" CausesValidation="False"
                ToolTip="Сканировать" OnClick="ibScan_Click" 
                meta:resourcekey="ibScanResource1" />
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ibView" runat="server" 
                ImageUrl="/Common/Images/default/16/find.png" CausesValidation="False"
                ToolTip="Просмотр"
                meta:resourcekey="ibViewResource1" />
        </td>
    </tr>
</table>
