<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxRefer.ascx.cs"
    Inherits="Bars.UserControls.TextBoxRefer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>


<table border="0" cellpadding="0" cellspacing="0" style="width: auto">
    <tr>
        <td valign="middle">
            <asp:TextBox ID="tb" runat="server" Enabled="false"></asp:TextBox>
            <asp:HiddenField ID="h" runat="server"></asp:HiddenField>
        </td>
        <td valign="middle">
            <asp:ImageButton ID="ib" runat="server" 
                ImageUrl="/common/images/default/16/reference_open.png" 
                CausesValidation="false" />
        </td>
    </tr>
</table>

<asp:RequiredFieldValidator ID="rfv" runat="server" Display="None" ControlToValidate="tb"
    Enabled="false" ErrorMessage='<%# RequiredErrorText %>'></asp:RequiredFieldValidator>
<act:ValidatorCalloutExtender ID="vceRFV" runat="server" TargetControlID="rfv" CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
    CssClass="validatorCallout" Enabled="false" WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>
