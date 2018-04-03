<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextBoxNumb.ascx.cs" Inherits="Bars.UserControls.TextBoxNumb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:TextBox ID="tb" runat="server" CssClass="cssTextBoxNumb"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfv" runat="server" Display="None" ControlToValidate="tb"
    Enabled="false" ErrorMessage='<%# RequiredErrorText %>'></asp:RequiredFieldValidator>
<asp:RangeValidator ID="rv" runat="server" Display="None" ControlToValidate="tb"
    Type="Integer" ErrorMessage='<%# MinMaxValueErrorText %>' MinimumValue="0" MaximumValue="2147483646"></asp:RangeValidator>
<act:ValidatorCalloutExtender ID="vceRFV" runat="server" TargetControlID="rfv" CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
    CssClass="validatorCallout" Enabled="false" WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>
<act:ValidatorCalloutExtender ID="vceRV" runat="server" TargetControlID="rv" CloseImageUrl="/Common/Images/default/16/cancel_blue.png"
    CssClass="validatorCallout" WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>
