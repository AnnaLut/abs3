<%@ Page Language="C#" AutoEventWireup="true" CodeFile="exportdbf.aspx.cs" Inherits="moper_ExportDbf" meta:resourcekey="PageResource" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Формирование выписки в dbf-файле</title>
    <link href="CSS/AppCSS.css" rel="Stylesheet" type="text/css" />
</head>
<body bgcolor="#f0f0f0">
    <form id="form1" runat="server">
    <div>
        <table style="width: 100%">
            <tr >
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt" meta:resourcekey="lbTitle">Формирование выписки в dbf-файле для </asp:Label></td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbBank" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt"
                        ForeColor="Navy"></asp:Label></td>
            </tr>
            <tr>
                <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="border-style:ridge;border-width:2;width:1px">
                                 <table  cellpadding="0" cellspacing="0">
                                 <tr>
                                    <td valign="top">
                    <asp:Label ID="lbDate" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                        Text="Дата:" meta:resourcekey="lbDate"></asp:Label></td>
                                <td valign="top">
                    <cc1:DateEdit ID="tbDate" runat="server" Width="100px" ReadOnly="True" Date="1980-01-01" MaxDate="2099-12-31" meta:resourcekey="tbDate" MinDate="1980-01-01" Enabled="False">01/01/1980 00:00:00</cc1:DateEdit>
                                </td>
                                <td valign="top">
                                    <asp:Calendar ID="Calendar" runat="server" BackColor="White" BorderColor="Black"
                                        BorderStyle="Solid" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" OnDayRender="Calendar_DayRender" OnSelectionChanged="Calendar_SelectionChanged" CellPadding="0" Width="230px" CellSpacing="2">
                                        <SelectedDayStyle BackColor="White" ForeColor="Black" />
                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <DayStyle BackColor="#CCCCCC" BorderColor="Gray" BorderStyle="Solid" BorderWidth="2px"
                                            ForeColor="Black" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <NextPrevStyle Font-Bold="True" Font-Size="12pt" ForeColor="Black" />
                                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                        <TitleStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True"
                                            Font-Names="Verdana" Font-Size="12pt" ForeColor="Black" Height="12pt" />
                                    </asp:Calendar>
                                </td> 
                                 </tr>
                                 </table>   
                                </td>
                                <td valign="top" style="border-style:ridge;border-width:2;width:1px">
                                    <table style="width: 100%" border="0" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td>
                    <asp:Button ID="btGetData" runat="server" meta:resourcekey="btGetData"
                        OnClick="btGetData_Click" Text="Сформировать данные" Width="265px" /></td>
                                        </tr>
                                        <tr>
                                          <td style="white-space:nowrap" >
                                            <asp:Label ID="lbCount" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" meta:resourcekey="lbCount" Text="Количество строк:"></asp:Label>
                                            <asp:Label ID="lbCountVal" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="Maroon" Text=""></asp:Label>
                                          </td>
                                        </tr>
                                        <tr>
                                            <td>
                                    <asp:Button ID="btShowData" runat="server" meta:resourcekey="btShowData" Text="Показать данные" Width="265px" Enabled="False" OnClick="btShowData_Click" /></td>
                                        </tr>
                                        <tr>
                                            <td>
                                    <asp:Label ID="lbVid" runat="server" meta:resourcekey="lbVid" Text="Вид экспотритуемого файла:" Font-Names="Verdana" Font-Size="10pt" Font-Bold="True" Width="270px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                    <asp:DropDownList ID="ddVid" runat="server" Width="270px">
                                    </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td>
                                    <asp:Label ID="lbFName" meta:resourcekey="lbFName" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt"
                                        Text="Имя выходного файлу:" Width="270px"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                    <asp:TextBox ID="tbFileName" runat="server" Enabled="False" Font-Bold="True" Font-Names="Verdana"
                                        Font-Size="10pt" Width="260px" style="text-align:center"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>
                    <asp:Button ID="btGenerateDbf" runat="server" meta:resourcekey="btGenerateDbf"
                        OnClick="btGenerateDbf_Click" Text="Экспорт в dbf-файл" Enabled="False" Width="265px" /></td>
                                        </tr>
                                    </table>
                                </td>
                        <td></td>
                            </tr>
                        </table>
                    
                    <asp:Label ID="lbInfo" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="12pt"
                        ></asp:Label></td>
            </tr>
            <tr>
                <td>
                <div runat="server" visible="false"  id="divFrame" style="height:400px;OVERFLOW:scroll;WIDTH:expression(document.body.clientWidth-12)" >
                    <asp:GridView ID="DataGrid" runat="server">
                    </asp:GridView>
                 </div>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 20px">
                    </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
