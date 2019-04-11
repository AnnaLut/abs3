<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DDLList.ascx.cs" Inherits="Bars.UserControls.DDLList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>
<asp:DropDownList ID="ddl" runat="server" AppendDataBoundItems="true">
    <asp:ListItem Text="" Value=""></asp:ListItem>
</asp:DropDownList>
<asp:RequiredFieldValidator ID="rfv" runat="server" Enabled="false" Display="None"
    ControlToValidate="ddl" InitialValue="" ErrorMessage='<%# RequiredErrorText %>'></asp:RequiredFieldValidator>
<act:ValidatorCalloutExtender ID="vceRFV" runat="server" Enabled="false" TargetControlID="rfv"
    CloseImageUrl="/Common/Images/default/16/cancel_blue.png" CssClass="validatorCallout"
    WarningIconImageUrl="/Common/Images/default/16/warning.png">
</act:ValidatorCalloutExtender>
