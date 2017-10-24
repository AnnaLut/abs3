<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxString.ascx.cs"
    Inherits="Bars.UserControls.TextBoxString" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:TextBox ID="tb" runat="server" CssClass="cssTextBoxString"></asp:TextBox>

<asp:RequiredFieldValidator ID="rfv" runat="server" ControlToValidate="tb" 
    Display="None" Enabled="False" ErrorMessage='<%# MinMaxLengthErrorText %>'></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="rev" runat="server" ControlToValidate="tb" Display="None" ErrorMessage='<%# RequiredErrorText %>'></asp:RegularExpressionValidator>

<act:ValidatorCalloutExtender ID="vceRFV" runat="server" 
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" 
    CssClass="validatorCallout" Enabled="True" TargetControlID="rfv" 
    WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>
<act:ValidatorCalloutExtender ID="vceREV" runat="server" 
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" 
    CssClass="validatorCallout" TargetControlID="rev" 
    WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>