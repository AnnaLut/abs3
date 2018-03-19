<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Kartoteka_hist.aspx.cs" Inherits="tools_Nlk_Kartoteka_hist" %>

<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="Bars" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Common/css/barsgridview.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        .style1
        {
            height: 30px;
        }
        .style2
        {
            font-style: italic;
            font-weight: bold;
            color: #003399;
        }
        .style3
        {
            font-style: italic;
            font-weight: bold;
            color: #003399;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel runat="server" ID="Pn1">
            <input type="hidden" runat="server" id="ACC_" />
            <input type="hidden" runat="server" id="REF1_" />
            <input type="hidden" runat="server" id="REF2_" />
            <table>
                <tr>
                    <td style="width: 50Px">
                    </td>
                    <td style="width: 200Px">
                        <asp:Label ID="Lbrefx" runat="server" Text="Референс: " CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbrefl" runat="server" CssClass="style3"></asp:Label>
                    </td>
                    <td style="width: 200Px">
                        <asp:Label ID="Lbdatdx" runat="server" Text="Дата" CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbdatdl" runat="server" CssClass="style3"></asp:Label>
                    </td>
                    <td style="width: 200Px">
                        <asp:Label ID="Lbsumx" runat="server" Text="Сума поч." CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbsuml" runat="server" CssClass="style3" ToolTip="Сума початкового референсу"></asp:Label>
                    </td>
                    <td style="width: 200Px">
                        <asp:Label ID="Lbamoux" runat="server" Text="Сума  карт." CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbamoul" runat="server" CssClass="style3" ToolTip="Залишок в картотеці по референсу"></asp:Label>
                    </td>
                    <td style="width: 200Px">
                        <asp:Label ID="Lbkarx" runat="server" Text="Сума док." CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbkarl" runat="server" CssClass="style3" ToolTip=" Сума документів привязаних до референсе"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 50Px">
                    </td>
                    <td colspan="3">
                        <asp:Label ID="Lbnaznx" runat="server" Text="Призначення: " CssClass="style2"></asp:Label>
                        <asp:Label ID="Lbnaznl" runat="server" CssClass="style3"></asp:Label>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td style="width: 50Px">
                    </td>
                    <td style="width: 25Px">
                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="/Common/Images/default/16/arrow_left.png"
                            CausesValidation="false" TabIndex="7" ToolTip="повернутись на попередню сторінку"
                            OnClick="backToFolders" Width="16px" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator1" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                        <asp:ImageButton ID="bt_del" runat="server" ImageUrl="/common/Images/default/16/delete.png"
                            ToolTip="Відвязати документ" OnClick="Clik_bt_del" OnClientClick="if (!confirm('Відвязати документ?')) return false;"
                            CausesValidation="false" />
                    </td>
                    <td>
                        <Bars:Separator ID="Separator2" runat="server" BorderWidth="1px" />
                    </td>
                    <td>
                        <asp:ImageButton ID="Bt_refr" runat="server" ImageUrl="/common/Images/default/16/gear_ok.png"
                            ToolTip="Розрахувати залишок по документу" OnClick="Clik_bt_refr" OnClientClick="if (!confirm('Здіснити розрахунок?')) return false;"
                            CausesValidation="false" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel runat="server" ID="Pn2">
            <Bars:BarsGridViewEx ID="grid_nlk" runat="server" DataSourceID="dsgrid_nlk" CssClass="barsGridView"
                DataKeyNames="SOS" JavascriptSelectionType="None" AutoGenerateColumns="false"
                AllowPaging="True" AllowSorting="True" ShowPageSizeBox="true" EnableViewState="true"
                OnRowDataBound="gridCCPortf_RowDataBound" AutoSelectFirstRow="False" PageSize="15">
                <AlternatingRowStyle CssClass="alternateRow" />
                <Columns>
                    <asp:BoundField DataField="REF2" HeaderText="РЕФ документу" SortExpression="REF2"
                        ItemStyle-Width="120Px" ItemStyle-HorizontalAlign="Left"></asp:BoundField>
                    <asp:BoundField HeaderText="Дата документа" DataField="DATD" ItemStyle-Width="100Px"
                        ItemStyle-HorizontalAlign="Center" DataFormatString="{0:d}" />
                    <asp:BoundField DataField="NLSB" HeaderText="Рах. зарахування" SortExpression="NLSB"
                        ItemStyle-Width="150Px"></asp:BoundField>
                    <asp:BoundField DataField="S" HeaderText="Сума зарахування" SortExpression="S" DataFormatString="{0:N2}"
                        ItemStyle-Width="150Px" ItemStyle-HorizontalAlign="Right"></asp:BoundField>
                    <asp:BoundField DataField="NAZN" HeaderText="Призначення платежу" SortExpression="NAZN"
                        ItemStyle-Width="570Px"></asp:BoundField>
                    <asp:BoundField DataField="SOS" HeaderText="SOS" SortExpression="SOS" ItemStyle-Width="30Px"
                        ItemStyle-HorizontalAlign="Right" Visible="true"></asp:BoundField>
                    <asp:BoundField DataField="FIO" HeaderText="Операціоніст" Visible="false" />
                </Columns>
                <FooterStyle CssClass="footerRow"></FooterStyle>
                <HeaderStyle CssClass="headerRow"></HeaderStyle>
                <EditRowStyle CssClass="editRow"></EditRowStyle>
                <PagerStyle CssClass="pagerRow"></PagerStyle>
                <NewRowStyle CssClass=""></NewRowStyle>
                <SelectedRowStyle ForeColor="Black"></SelectedRowStyle>
                <RowStyle CssClass="normalRow"></RowStyle>
            </Bars:BarsGridViewEx>
            <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True" EnableScriptLocalization="True">
            </asp:ScriptManager>
            <Bars:BarsSqlDataSourceEx ProviderName="barsroot.core" ID="dsgrid_nlk" runat="server">
            </Bars:BarsSqlDataSourceEx>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID="Insert" runat="server" Text="+.." OnClick="Insert_Click"></asp:LinkButton>
            <asp:Panel ID="Pn_Ins" runat="server" GroupingText="Додати документ" Width="335px"
                Visible="false">
                <table>
                    <tr>
                        <td style="width: 50Px">
                        </td>
                        <td style="width: 100Px">
                            <asp:Label ID="Lb_ref" runat="server" Text="Референс" Style="font-style: italic;
                                font-weight: 700; color: #003399"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Tb_ref" runat="server" Style="background-color: #CCFFFF"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="/common/Images/default/16/folder-open.gif"
                                ToolTip="Відкрити документ" OnClick="Clik_bt_docs" CausesValidation="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                        </td>
                        <td style="text-align: center" class="style1">
                            <asp:Button ID="Btok" runat="server" Text="Ok" Width="60Px" OnClick="Btok_Click" />
                        </td>
                        <td style="text-align: center" class="style1">
                            <asp:Button ID="btcan" runat="server" Text="Cancel" Width="60Px" OnClick="btcan_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
