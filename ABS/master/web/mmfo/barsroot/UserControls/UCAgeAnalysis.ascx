<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCAgeAnalysis.ascx.cs" Inherits="UCAgeAnalysis" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bars" %>
<%@ Register Assembly="WebChart" Namespace="WebChart" TagPrefix="Web" %>
<table border="0" cellpadding="0" cellspacing="5">
    <asp:MultiView ID="mvMain" runat="server" ActiveViewIndex="1">
        <asp:View ID="vParams" runat="server">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="0">
                        <tr>
                            <td colspan="3" align="center" style="border-bottom: darkgray 1px solid">
                                <asp:RadioButtonList ID="rblPAP" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" Width="200px">
                                    <asp:ListItem Selected="True" Value="1">Активы</asp:ListItem>
                                    <asp:ListItem Value="2">Пасивы</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">Валюта</td>
                        </tr>
                        <tr>
                            <td colspan="3"><asp:DropDownList ID="ddlKV" runat="server" Width="350px" AutoPostBack="True"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">Балансовый счет: <asp:Label ID="lbNBSNo" runat="server" Text="Все"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="3"><asp:ListBox ID="lbNBS" runat="server" Height="160px" Width="350px" Font-Size="8pt"></asp:ListBox></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <bars:ImageTextButton ID="btBck" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/arrow_left.png" OnClick="btBck_Click" ToolTip="На уровень назад" />
                            </td>
                            <td align="left">
                                <bars:ImageTextButton ID="btFrw" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/arrow_right.png" OnClick="btFrw_Click" ToolTip="На уровень вперед" />
                            </td>
                            <td align="right">
                                <bars:ImageTextButton ID="btGraph" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/ok.png" OnClick="btGraph_Click" ToolTip="Показать диаграмму" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>        
        </asp:View>
        <asp:View ID="vGraph" runat="server">
            <tr>
                <td style="width: 100px">
                    <bars:ImageTextButton ID="btBack" runat="server" ButtonStyle="Image" ImageUrl="/Common/Images/default/16/options.png" OnClick="btBack_Click" ToolTip="Вернуться" />
                </td>
                <td class="title" align="left">Анализ по срокам</td>
            </tr>
            <tr>
                <td colspan="2">
                    <Web:ChartControl ID="chrtData" runat="server" BorderStyle="None" BorderWidth="5px" ChartPadding="10" GridLines="None" Padding="1" TopPadding="0" AlternateText="Нет данных" Height="300px">
                        <YAxisFont StringFormat="Far,Near,Character,LineLimit" />
                        <XTitle StringFormat="Center,Near,Character,LineLimit" />
                        <ChartTitle StringFormat="Center,Near,Character,LineLimit" />
                        <XAxisFont StringFormat="Center,Near,Character,LineLimit" />
                        <Background Color="Transparent" />
                        <Charts>
                            <Web:PieChart DataXValueField="ID" DataYValueField="VAL" Explosion="5" Name="MainChart">
                                <Data>
                                    <Web:ChartPoint XValue="a" YValue="30" />
                                    <Web:ChartPoint XValue="b" YValue="40" />
                                </Data>
                                <Shadow OffsetX="10" OffsetY="7" />
                                <DataLabels>
                                    <Border Color="Transparent" />
                                    <Background Color="Transparent" />
                                </DataLabels>
                            </Web:PieChart>
                        </Charts>
                        <YTitle StringFormat="Center,Near,Character,LineLimit" />
                        <Border Color="Transparent" />
                        <Legend Position="Bottom">
                            <Border Color="Transparent" />
                        </Legend>
                    </Web:ChartControl>
                </td>
            </tr>
        </asp:View>
    </asp:MultiView>
</table>