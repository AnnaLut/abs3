<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fin_list_conclusions.aspx.cs"
    Inherits="credit_fin_nbu_Fin_list_conclusions" %>

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
        <asp:Panel runat="server" ID="Pn1" Width="700Px">
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
                        <asp:DropDownList ID="ddl_print" runat="server" IsRequired="true" Width="55px" Visible="True"
                            ToolTip="Формат друку">
                            <asp:ListItem Text="PDF" Value="PDF"></asp:ListItem>
                            <asp:ListItem Text="RTF" Value="RTF"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 5%">
                        <asp:ImageButton ID="Bt_print" runat="server" ImageUrl="/Common/Images/default/24/printer.png"
                            Style="text-align: right" OnClick="Bt_print_Click" Visible="True" ToolTip="Сформувати документ"
                            Height="27px" Width="29px" />
                    </td>
                    <td style="width: 10%">
                    </td>
                    <td style="width: 15%">
                        <asp:Label runat="server" ID="Lb_zvitp" Text="Звітний період"></asp:Label>
                    </td>
                    <td style="width: 20%">
                        <asp:DropDownList runat="server" ID="Drd_dat" AutoPostBack="True" OnTextChanged="Drd_dat_TextChanged">
                        </asp:DropDownList>
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
                DataSourceID="dsMain" CssClass="tableTitle" DataKeyNames="RNK, ND, DAT, FDAT"
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
                    <asp:BoundField DataField="rnk" SortExpression="rnk" HeaderText="РНК" Visible="false" />
                    <asp:BoundField DataField="nd" SortExpression="nd" HeaderText=" Референс договору"
                        Visible="false" />
                    <asp:BoundField DataField="tip_v" HeaderText=" Тип висновку" />
                    <asp:BoundField DataField="dat" SortExpression="dat" HeaderText=" Звітна дата" DataFormatString="{0:dd/MM/yyyy}"
                        ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fdat" SortExpression="fdat" HeaderText=" Дата формування висновку"
                        DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fin23" HeaderText=" Клас боржника" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="obs23" HeaderText=" Стан обслуговування боргу " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="kat23" HeaderText=" Категорія якості " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="k23" HeaderText=" Значення показника ризику " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="vnkr" HeaderText=" Внутрішній кредитний рейтинг" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ved" HeaderText=" Вид еконмічної діяльності " ItemStyle-HorizontalAlign="Center">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <RowStyle CssClass="normalRow"></RowStyle>
            </Bars:BarsGridViewEx>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
