<%@ Page Language="C#" AutoEventWireup="true" CodeFile="setperiod.aspx.cs" Inherits="paysep_setperiod" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Выбор периода</title>
    <link href="/Common/CSS/AjaxCSS.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="formSepPeriod" runat="server">
            <asp:ScriptManager ID="ScriptManager" runat="server" EnableScriptGlobalization=true />
            <table cellpadding="0" cellspacing="0" width="100%" height=70%>
                <tr >
                    <td valign="middle" align=center >
            <asp:Label ID="lbTitle" runat="server" Font-Bold="True" Text="Выбор периода расчетов"></asp:Label><br />
                        <br />
            <table border="1" cellpadding="2" cellspacing="0" bordercolor="gray">
                <tr>
                    <td align="right">
                        &nbsp;<asp:Label ID="lbStartDate" runat="server" Text="С" Font-Bold="True" Font-Italic="True" Font-Names="Verdana"></asp:Label>&nbsp;</td>
                    <td align="left">
                        <asp:TextBox ID="tbStartDate" runat="server" Width="100px" style="text-align:center"></asp:TextBox>
                        <asp:ImageButton ToolTip="Выбрать дату из календаря" ID="imgSetStart" runat="server" ImageUrl="/Common/Images/default/16/сalendar.png" />
                        </td>
                    <td align="left">
                        &nbsp;<asp:Label ID="lbFinishDate" runat="server" Text="по" Font-Bold="True" Font-Italic="True" Font-Names="Verdana"></asp:Label>&nbsp;</td>
                    <td align="left">
                        <asp:TextBox ID="tbFinishDate" runat="server" Width="100px" style="text-align:center"></asp:TextBox>
                        <asp:ImageButton ToolTip="Выбрать дату из календаря" ID="imgSetFinish" runat="server" ImageUrl="/Common/Images/default/16/сalendar.png" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        </td>
                    <td align="left">
                        <cc1:MaskedEditValidator
                            ID="mevStart" 
                            runat="server"
                            ControlToValidate="tbStartDate"
                            ControlExtender="meeStart" 
                            EmptyValueMessage="Заполните дату"
                            InvalidValueMessage="Неверный формат даты"
                            Display="Dynamic" Font-Bold="False" Font-Names="Verdana" Font-Size="8pt" IsValidEmpty="False"
                             />
                    </td>
                    <td align="left">
                    </td>
                    <td align="left">
                        <cc1:MaskedEditValidator 
                            ID="mevFinish" 
                            runat="server" 
                            ControlToValidate="tbFinishDate" 
                            ControlExtender="meeFinish" 
                            EmptyValueMessage="Заполните дату"
                            InvalidValueMessage="Неверный формат даты"
                            Display="Dynamic" Font-Bold="False" Font-Names="Verdana" Font-Size="8pt" IsValidEmpty="False"
                            />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Label ID="lbStatus" runat="server" Font-Size="9pt" ForeColor="Green"></asp:Label></td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        <asp:Button ID="btNext" runat="server" Text="Продолжить" OnClick="btNext_Click" /></td>
                </tr>
            </table>
            </td>
                </tr>
            </table>
        <cc1:MaskedEditExtender 
            ID="meeStart" 
            runat="server" 
            TargetControlID="tbStartDate" 
            Mask="99/99/9999"
            MessageValidatorTip="true"
            OnFocusCssClass="MaskedEditFocus"
            OnInvalidCssClass="MaskedEditError"
            MaskType="Date"
            AcceptNegative="Left"
            ErrorTooltipEnabled="True"
        />
        <cc1:MaskedEditExtender 
            ID="meeFinish" 
            runat="server" 
            TargetControlID="tbFinishDate"
            Mask="99/99/9999"
            MessageValidatorTip="true"
            OnFocusCssClass="MaskedEditFocus"
            OnInvalidCssClass="MaskedEditError"
            MaskType="Date"
            AcceptNegative="Left"
            ErrorTooltipEnabled="True"
        />
        <cc1:CalendarExtender 
            ID="ceStart" 
            runat="server" 
            PopupButtonID="imgSetStart" 
            TargetControlID="tbStartDate"
        />
        <cc1:CalendarExtender 
            ID="ceFinish" 
            runat="server" 
            PopupButtonID="imgSetFinish" 
            TargetControlID="tbFinishDate"
        />
    </form>
</body>
</html>
