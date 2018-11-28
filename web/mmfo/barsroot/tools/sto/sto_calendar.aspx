<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sto_calendar.aspx.cs" Inherits="tools_sto_calendar"
    Culture="uk-UA" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="~/credit/usercontrols/TextBoxDate.ascx" TagName="TextBoxDate" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxString.ascx" TagName="TextBoxString" TagPrefix="bec" %>
<%@ Register Src="~/credit/usercontrols/TextBoxNumb.ascx" TagName="TextBoxNumb" TagPrefix="bec" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title></title>
</head>
<body bgcolor="#edf4fc">
    <form id="form1" runat="server">
         <asp:ScriptManager ID="sm" runat="server" EnablePartialRendering="true" EnableScriptGlobalization="True" EnableScriptLocalization="True">
        </asp:ScriptManager>
    <div>
        <table border="2" cellpadding="5" cellspacing="0" style="width: 890px" dir="ltr"
                        frame="border" >
            <tr> <td>Дт</td>
                <td> <asp:Label ID="Lb_Nls_a" runat="server"></asp:Label>               </td>
                <td> <asp:Label ID="Lb_nam_a" runat="server"></asp:Label>            </td>
                <td> Календар                                                          </td>


            </tr>
              <tr>
                <td>Кт</td>
                <td> <asp:Label ID="Lb_Nls_b" runat="server"></asp:Label>               </td>
                <td> <asp:Label ID="Lb_nam_b" runat="server"></asp:Label>            </td>
                <td> <asp:DropDownList ID="Drlist" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Drlist_SelectedIndexChanged"></asp:DropDownList>                                                </td>


            </tr>

           <tr> <td>                                                                   </td>
                <td> Сума платежу                                                      </td>
                <td> <div style="margin-bottom:5px"> Сума формулою (так):  
                    <asp:CheckBox ID="FormulaCheckbox" runat="server"
                    AutoPostBack="True"
                    Text=""
                    TextAlign="Left"
                    OnCheckedChanged="Check_Clicked"
                    /> </div>
                    <bec:TextBoxString ID="Lb_Summ_String" runat="server" Width="550" MaxLength="160" IsRequired="true" Visible="false" AutoPostBack="True"/>
                    <bec:TextBoxNumb ID="Lb_Summ_Numb" runat="server" Width="550" MaxLength="160" IsRequired="true" Visible="false" AutoPostBack="True"/></td>
                <td>                                                                   </td>

            </tr>
              <tr>
                <td>                                                                   </td>
                <td> Призначення платежу                                               </td>
                  <td>  <bec:TextBoxString ID="Lb_nazn" runat="server" Width="550" MaxLength="160" IsRequired="true" AutoPostBack="True"/>
                  </td>
                <td>  <asp:Label ID="bd" runat="server" Visible="false"></asp:Label>   </td>
                
            </tr>
            <tr>
                <td>                                                                   </td>
                <td> Дата з                                             </td>
                <td>
                    <bec:TextBoxDate ID="DATE_FROM" runat="server"  IsRequired="true" />
             </td>
                <td>            </td> 
            </tr>
            <tr>
                <td>                                                                   </td>
                <td>                                           </td>
                <td>   <asp:Button runat="server" ID="Save_date_nazn" Text="Зберегти зміни" OnClick="Save_date_nazn_Click"/>
             </td>
                <td>                      </td> 
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar1" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" ShowNextPrevMonth="False"
                        Width="220px" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="Calendar1_DayRender"
                        DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar2" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar2_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar2_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar3" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar3_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar3_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar4" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" ShowNextPrevMonth="False"
                        Width="220px" OnSelectionChanged="Calendar4_SelectionChanged" OnDayRender="Calendar4_DayRender"
                        DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar5" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar5_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar5_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar6" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar6_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar6_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar7" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" ShowNextPrevMonth="False"
                        Width="220px" OnSelectionChanged="Calendar7_SelectionChanged" OnDayRender="Calendar7_DayRender"
                        DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar8" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar8_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar8_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar9" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar9_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar9_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar10" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" ShowNextPrevMonth="False"
                        Width="220px" OnSelectionChanged="Calendar10_SelectionChanged" OnDayRender="Calendar10_DayRender"
                        DayNameFormat="Shortest">
                        <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar11" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar11_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar11_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
                <td>
                    <asp:Calendar ID="Calendar12" runat="server" VisibleDate="1901-01-01" BackColor="#FFFFCC"
                        BorderColor="#FFCC66" BorderWidth="1px" FirstDayOfWeek="Monday" Font-Names="Verdana"
                        Font-Size="8pt" ForeColor="#663399" Height="200px" ShowGridLines="True" OnSelectionChanged="Calendar12_SelectionChanged"
                        ShowNextPrevMonth="False" Width="220px" OnDayRender="Calendar12_DayRender" DayNameFormat="Shortest">
                        <DayHeaderStyle Font-Bold="True" BackColor="#FFCC66" Height="1px" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                    </asp:Calendar>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
