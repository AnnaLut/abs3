<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fin_list_dat.aspx.cs" Inherits="credit_fin_nbu_Fin_list_dat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/common/css/BarsGridView.css" type="text/css" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel runat="server" ID="Pn1" Width="950Px">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%">
                        <asp:Label runat="server" ID="Lb_rnk1" Text="РНК клієнта" Enabled="false"></asp:Label>
                    </td>
                    <td style="width: 20%">
                        <asp:Label runat="server" ID="Lb_rnk2" Enabled="false"> </asp:Label>
                    </td>
                    <td style="width: 100%">
                        <asp:Label runat="server" ID="Lb_rnk3" Enabled="false"> </asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="Lb_nd1" Text="REF угоди" Enabled="false"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Lb_nd2" Enabled="false"> </asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Lb_nd3" Enabled="false">  </asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--                    <td>
                    </td>--%>
                    <td>
                        <asp:Label runat="server" ID="Lb_sdat1" Text="Дата почтаку дії" Enabled="false"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Lb_sdat2" Enabled="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <%--                   <td>
                    </td>--%>
                    <td>
                        <asp:Label runat="server" ID="Lb_wdat1" Text="Дата завершення" Enabled="false"></asp:Label>
                    </td>
                    <td>
                        <asp:Label runat="server" ID="Lb_wdat2" Enabled="false"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel runat="server" ID="Pn2" Width="700Px">
            <table style="width: 100%">
                <tr>
                    <td style="width: 10%">
                        <asp:ImageButton ID="Ib_back" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                            Style="text-align: right" OnClick="Bt_Back_Click" ToolTip="Повернутись на попередню сторінку"
                            Height="20px" Width="20px" Visible="true" />
                    </td>
                    <td style="width: 5%">
                    </td>
                    <td style="width: 5%">
                    </td>
                    <td style="width: 10%">
                        <%-- <asp:DropDownList ID="ddl_print" runat="server" IsRequired="true" Width="55px" 
                            ToolTip="Формат друку" Visible="true"  Enabled="false" >
                            <asp:ListItem Text="PDF" Value="PDF"></asp:ListItem>
                            <asp:ListItem Text="RTF" Value="RTF"></asp:ListItem>
                        </asp:DropDownList>--%>
                        <asp:DropDownList ID="ddl_print" runat="server" IsRequired="true" Width="255px" ToolTip="Формат друку"
                            Visible="true" Enabled="true">
                            <asp:ListItem Text="Висновок що до визначення ВНКР" Value="VNKR"></asp:ListItem>
                            <asp:ListItem Text="Інформація за наданим кредитом" Value="V351"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 5%">
                        <asp:ImageButton ID="Bt_print" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                            Style="text-align: right" OnClick="Bt_print_Click" ToolTip="Сформувати документ"
                            Height="20px" Width="20px" Visible="true" Enabled="true" />
                    </td>
                    <td style="width: 100%">
                        <asp:Image runat="server" ID="Im_run" ImageUrl="/Common/Images/loader.gif" Visible="false" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <br />
        <asp:Panel runat="server" ID="Pn3">
            <Bars:BarsSqlDataSourceEx ID="dsMain" runat="server" AllowPaging="False" ProviderName="barsroot.core">
            </Bars:BarsSqlDataSourceEx>
            <Bars:BarsGridViewEx ID="gvMain" runat="server" AllowPaging="false" AllowSorting="True"
                DataSourceID="dsMain" CssClass="tableTitle" DataKeyNames="RNK, ND, FDAT, DAT"
                ShowPageSizeBox="False" AutoGenerateColumns="False" DateMask="dd/MM/yyyy" JavascriptSelectionType="ServerSelect"
                OnRowDataBound="gvMain_RowDataBound" AutoSelectFirstRow="true">
                <FooterStyle CssClass="footerRow"></FooterStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <EditRowStyle CssClass="editRow"></EditRowStyle>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <NewRowStyle CssClass=""></NewRowStyle>
                <SelectedRowStyle ForeColor="Black" BackColor="#6699FF"></SelectedRowStyle>
                <AlternatingRowStyle CssClass="alternateRow"></AlternatingRowStyle>
                <Columns>
                    <asp:BoundField DataField="rnk" SortExpression="rnk" HeaderText="РНК" Visible="true" />
                    <asp:BoundField DataField="nd" SortExpression="nd" HeaderText=" Реф.договору" Visible="true" />
                    <asp:BoundField DataField="fdat" SortExpression="fdat" HeaderText=" Звітна дата корегування класу"
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dat" SortExpression="fdat" HeaderText=" Дата звітності"
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ved" HeaderText=" Вид еконмічної діяльності " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="cls" HeaderText="Зкорегований клас " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="clsp" HeaderText="Зкорегований клас з врахуванням кількості днів прострочки "
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="pd" HeaderText="Значення коофіцієнту PD " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" Width="90Px" />
                    </asp:BoundField>
                </Columns>
                <RowStyle CssClass="normalRow"></RowStyle>
            </Bars:BarsGridViewEx>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
