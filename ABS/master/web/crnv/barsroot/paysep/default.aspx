<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="paysep_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Расчет сум</title>
</head>
<body>
    <form id="formSepDeafult" runat="server">
        <table style="width: 100%">
            <tr>
                <td align="center">
        <asp:Label ID="lbTitle" runat="server" Font-Bold="True" Text="Расчет сумм за услуги СЕП"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbPeriod" runat="server" Font-Bold="True" Font-Italic="True" Font-Size="10pt"
                                    Text="Период:"></asp:Label></td>
                            <td>
                                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="10pt"
                                    Text="с"></asp:Label></td>
                            <td >
                                <asp:TextBox ID="tbStartDate" style="text-align:center" runat="server" BackColor="Info" Enabled="False" Font-Bold="True"
                                    ForeColor="Navy" ReadOnly="True" Width="80px"></asp:TextBox></td>
                            <td >
                                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="10pt"
                                    Text="по"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="tbFinishDate" style="text-align:center" runat="server" BackColor="Info" Enabled="False" Font-Bold="True"
                                    ForeColor="Navy" ReadOnly="True" Width="80px"></asp:TextBox></td>
                            <td>
                                &nbsp; &nbsp;
                            </td>
                            <td nowrap="noWrap">
                                <asp:Label ID="lbTotalSum" runat="server" Text="Общая сумма:" Font-Bold="True" Font-Italic="True" Font-Size="10pt"></asp:Label></td>
                            <td>
                                <asp:TextBox style="text-align:right" ID="tbTotalSum" runat="server" ReadOnly="True" Font-Bold="True" ForeColor="Red" Width="140px"></asp:TextBox></td>
                            <td align="right" width="100%" nowrap="noWrap">
                                <asp:Button ID="btCalculate" runat="server" Text="Рассчитать" Width="144px" OnClick="btCalculate_Click" />
                                <asp:Button ID="btPay" runat="server" Text="Взыскать" Width="144px" OnClick="btPay_Click" />&nbsp; &nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="9">
                                <asp:Label ID="lbStatus" runat="server" Font-Size="10pt" ForeColor="Green"></asp:Label></td>
                        </tr>
                        
                    </table>
                    <div runat=server id="gridDiv" style="height:400px;OVERFLOW:auto;border-width:1px;border-style:solid;">
                    <asp:GridView ID="Grid" runat="server" AutoGenerateColumns="False" BackColor="White"
                        BorderColor="#E7E7FF" BorderStyle="Ridge" BorderWidth="1px" CellPadding="3" Font-Size="10pt">
                        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                        <Columns>
                            <asp:BoundField DataField="MFO" HeaderText="МФО">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SAB" HeaderText="Эл. адр.">
                                <ItemStyle Font-Bold="True" ForeColor="Black" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NB" HeaderText="Наименование" />
                            <asp:BoundField DataField="SUM_TOTAL" HeaderText="Сумма" DataFormatString="{0:### ### ### ##0.00}" HtmlEncode="False">
                                <ItemStyle ForeColor="Red" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REF" HeaderText="Реф. док." HtmlEncode="False">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REF2" HeaderText="Реф. док. ком." HtmlEncode="False">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                        <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                        <HeaderStyle BackColor="DimGray" Font-Bold="True" ForeColor="White" Font-Size="10pt" />
                        <AlternatingRowStyle BackColor="#F7F7F7" />
                    </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
