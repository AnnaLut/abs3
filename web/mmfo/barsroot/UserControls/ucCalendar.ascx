<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCalendar.ascx.cs" Inherits="ucCalendar" %>
<script language=javascript>
   var clockID = 0;
   var elemId  = "";
   function UpdateClock()
   {
   if(clockID) {
      clearTimeout(clockID);
      clockID  = 0;
   }
   var tDate = new Date();
   var hour = (tDate.getHours()> 9)?(tDate.getHours()):("0"+tDate.getHours());
   var min = (tDate.getMinutes()> 9)?(tDate.getMinutes()):("0"+tDate.getMinutes());
   var sec = (tDate.getSeconds()> 9)?(tDate.getSeconds()):("0"+tDate.getSeconds());
   document.getElementById(elemId).value = hour + ":" + min + ":" + sec;
   clockID = setTimeout("UpdateClock()", 1000);
}
function StartClock(id) {
   elemId = id; 
   clockID = setTimeout("UpdateClock()", 500);
}
</script>
<table cellpadding="0" cellspacing="0">
    <tr>
        <td nowrap="noWrap" align="right">
            <asp:Label ID="lbCurDate" runat="server" Font-Bold="False" Font-Italic="True" Font-Size="9pt"
                Text="Текущая дата:"></asp:Label></td>
        <td nowrap="nowrap">
            <asp:TextBox ID="tbCurDate" runat="server" BorderStyle="Ridge" BorderWidth="2px"
                CssClass="DateBox" ReadOnly="True" Width="100px"></asp:TextBox></td>
    </tr>
    <tr>
        <td nowrap="noWrap" align="right">
            <asp:Label ID="lbCurTime" runat="server" Font-Bold="False" Font-Italic="True" Font-Size="9pt"
                Text="Текущее время:"></asp:Label></td>
        <td nowrap="nowrap" align="left">
            <asp:TextBox ID="tbCurTime" runat="server" BorderStyle="Ridge" BorderWidth="2px"
                CssClass="DateBox" ReadOnly="True" Width="60px"></asp:TextBox></td>
    </tr>
    <tr>
        <td align="center" colspan="2">
            <asp:Calendar ID="Calendar" runat="server" BackColor="White" BorderColor="#999999" DayNameFormat="Shortest" Font-Names="Verdana"
                Font-Size="8pt" ForeColor="Black" EnableTheming="True" SelectionMode="None">
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <TodayDayStyle BackColor="SteelBlue" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <WeekendDayStyle BackColor="#FFFFCC" ForeColor="Red" />
                <OtherMonthDayStyle ForeColor="Gray" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <TitleStyle BackColor="Silver" BorderColor="Transparent" Font-Bold="True" ForeColor="Black" />
            </asp:Calendar>
        </td>
    </tr>
</table>