<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateEdit.ascx.cs" Inherits="controls_DateEdit" %>
<%@ Register Assembly="Bars.Web.Controls.2" Namespace="UnityBars.WebControls" TagPrefix="ibank2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>

<span style="white-space: nowrap;">
    <ibank2:BarsDateInput ID="dateInput" runat="server" EnabledStyle-HorizontalAlign="Center" CausesValidation="True">
    </ibank2:BarsDateInput>
    <img id="btnShow" runat="server"  src="img/calendar.gif" alt="Показать календарь" style="margin-bottom:-5px;margin-left:-3px;cursor:pointer;" />
<asp:RequiredFieldValidator ID="dateValidator" runat="server" 
    ControlToValidate="dateInput" ErrorMessage="Необхідно заповнити" 
    Display="None" Enabled="False"></asp:RequiredFieldValidator>
<ajax:ValidatorCalloutExtender ID="dateValidator_ValidatorCalloutExtender" 
    runat="server" Enabled="True" TargetControlID="dateValidator">
</ajax:ValidatorCalloutExtender>
</span>