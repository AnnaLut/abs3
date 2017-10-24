<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxDate.ascx.cs" 
Inherits="Bars.UserControls.TextBoxDate" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:TextBox ID="tb" runat="server" CssClass="cssTextBoxDate"></asp:TextBox>

<act:MaskedEditExtender ID="mee" runat="server" TargetControlID="tb" MaskType="Date" Mask="99/99/9999"></act:MaskedEditExtender>
<act:MaskedEditValidator ID="mev" runat="server" ControlToValidate="tb" ControlExtender="mee" Display="None" IsValidEmpty="true" InvalidValueMessage='<%# InvalidValueErrorText %>'></act:MaskedEditValidator>

<asp:RequiredFieldValidator ID="rfv" runat="server" Display="None" ControlToValidate="tb" Enabled="false" ErrorMessage='<%# RequiredErrorText %>'></asp:RequiredFieldValidator>
<asp:RangeValidator ID="rv" runat="server" Display="None" EnableViewState="true" ControlToValidate="tb" Type="Date" ErrorMessage='<%# MinMaxValueErrorText %>'></asp:RangeValidator>

<act:ValidatorCalloutExtender ID="vceMEV" runat="server" TargetControlID="mev" 
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" 
    CssClass="validatorCallout" 
    WarningIconImageUrl="/Common/Images/default/16/warning.png"></act:ValidatorCalloutExtender>
<act:ValidatorCalloutExtender ID="vceRFV" runat="server" TargetControlID="rfv" 
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" 
    CssClass="validatorCallout" Enabled="false" 
    WarningIconImageUrl="/Common/Images/default/16/warning.png"></act:ValidatorCalloutExtender>
<act:ValidatorCalloutExtender ID="vceRV" runat="server" TargetControlID="rv" 
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" 
    CssClass="validatorCallout" 
    WarningIconImageUrl="/Common/Images/default/16/warning.png"></act:ValidatorCalloutExtender>

<act:CalendarExtender ID="ce" runat="server" TargetControlID="tb" Enabled="true" Format='<%# System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern %>'></act:CalendarExtender>

