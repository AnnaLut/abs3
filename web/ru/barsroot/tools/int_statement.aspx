<%@ Page Language="C#" AutoEventWireup="true" CodeFile="int_statement.aspx.cs" Inherits="tools_int_statement" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="bwc" %>
<%@ Register Assembly="Bars.DataComponentsEx" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Розрахунок процентів для активних залишків </title>
    <link href="/common/css/default.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        .title
        {
            border-bottom-color: #CCD7ED;
            border-bottom: 1px solid;
            font-size: 9pt;
            color: #1C4B75;
        }
        .readonly
        {
            background-color: lightgray;
        }
    </style>
    <base target="_self" />
</head>
<body>
    <form id="formIntStatement" runat="server">
    <div>
        <asp:Panel runat="server" ID="pnAccounts" GroupingText="Інформація по рахунках">
            <table>
                <tr>
                    <td colspan="4">
                        <div class="title">
                            Основний рахунок</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        Найменування:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbMainNms" BackColor="LightGray" Width="300px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td>
                        Рахунок:
                        <asp:TextBox runat="server" ID="tbMainNls" BackColor="LightGray" Width="150px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td>
                        Валюта:
                        <asp:TextBox runat="server" ID="tbMainKv" BackColor="LightGray" Width="30px" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lbMainIntRate" Text="% ставка:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbMainIntRate" BackColor="LightGray" Width="58px"
                            ReadOnly="true"></asp:TextBox>
                        Базовий рік:
                        <asp:TextBox runat="server" ID="tbMainIntYear" BackColor="LightGray" Width="160px"
                            ReadOnly="true"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <div class="title">
                            Рахунок нарахованих відсотків</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        Найменування:
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbIntNms" BackColor="LightGray" Width="300px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td>
                        Рахунок:
                        <asp:TextBox runat="server" ID="tbIntNls" BackColor="LightGray" Width="150px" ReadOnly="true"></asp:TextBox>
                    </td>
                    <td>
                        Валюта:
                        <asp:TextBox runat="server" ID="tbIntKv" BackColor="LightGray" Width="30px" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    <asp:Panel runat="server" ID="pnCalc" GroupingText="Розрахунки">
        <table>
            <tr>
                <td style="width: 230px">
                    <div style="height: 300px; overflow: auto; margin-left:-10px;">
                        <Bars:BarsSqlDataSourceEx ID="sdsMain" runat="server" OldValuesParameterFormatString="old_{0}"
                            AllowPaging="False" ProviderName="barsroot.core"></Bars:BarsSqlDataSourceEx>
                        <Bars:BarsGridViewEx ID="gvMain" runat="server" DataSourceID="sdsMain" 
                            AutoGenerateColumns="False" Width="90%"
                            CaptionText="" CssClass="barsGridView" DateMask="dd/MM/yyyy" ExcelImageUrl="/common/images/default/16/export_excel.png"
                            FilterImageUrl="/common/images/default/16/find.png" MetaFilterImageUrl="/common/images/default/16/filter.png"
                            MetaTableName="" RefreshImageUrl="/common/images/default/16/refresh.png"
                            ShowPageSizeBox="False" BackColor="White" BorderColor="#CCCCCC" 
                            BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                            ClearFilterImageUrl="/common/images/default/16/filter_delete.png" 
                            EnableModelValidation="True" HoverRowCssClass="hoverRow" ShowCaption="False"><Columns><asp:BoundField DataField="FDAT" SortExpression="FDAT" HeaderText="Дата" /><asp:BoundField DataField="OST" SortExpression="OST" HeaderText="Залишок" /></Columns><FooterStyle 
                            CssClass="footerRow" BackColor="White" ForeColor="#000066" /><HeaderStyle 
                            CssClass="headerRow" BackColor="#006699" Font-Bold="True" ForeColor="White" /><EditRowStyle CssClass="editRow" /><PagerStyle 
                            CssClass="pagerRow" BackColor="White" ForeColor="#000066" 
                            HorizontalAlign="Left" /><NewRowStyle CssClass="" /><AlternatingRowStyle CssClass="alternateRow" /><RowStyle 
                            CssClass="normalRow" ForeColor="#000066" /><SelectedRowStyle 
                            CssClass="selectedRow" BackColor="#669999" Font-Bold="True" ForeColor="White" /></Bars:BarsGridViewEx>
                    </div>
                </td>
                <td style="vertical-align: top">
                    <asp:Panel runat="server" ID="pnDates" GroupingText="">
                        <table>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <bwc:DateEdit ID="tbAcrDat" runat="server" Width="90px" BackColor="LightGray" Date=""
                                        MaxDate="2999-12-31" MinDate="" ReadOnly="True" ToolTip="Дата, по яку відсотки вже нараховано">01/01/0001 00:00:00</bwc:DateEdit>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neOSTI" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="Поточний залишок на рахунку нарахованих відсотків"></bwc:NumericEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="tbCount1" BackColor="LightGray" ToolTip="Кількість днів"
                                        Width="40px" ReadOnly="true" Style="text-align: right"></asp:TextBox>
                                </td>
                                <td>
                                    <bwc:DateEdit ID="tbDat1" runat="server" BackColor="LightGray" Date="" MaxDate="2999-12-31"
                                        MinDate="" ReadOnly="True" Width="90px" ToolTip="Попередній день">01/01/0001 00:00:00</bwc:DateEdit>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neDOS1" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="План донарахування відсотків по попередній день"></bwc:NumericEdit>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neOST1" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="Плановий залишок на рахунку нарахованих %% за попередній день"></bwc:NumericEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="tbCount2" BackColor="LightGray" ToolTip="Кількість днів"
                                        Width="40px" ReadOnly="true" Style="text-align: right"></asp:TextBox>
                                </td>
                                <td>
                                    <bwc:DateEdit ID="tbDat2" runat="server" Width="90px" BackColor="LightGray" Date=""
                                        MaxDate="2999-12-31" MinDate="" ReadOnly="True" ToolTip="Поточна банківська дата">01/01/0001 00:00:00</bwc:DateEdit>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neSum" Width="110px" ToolTip="Погатити (-), Видати (+)"></bwc:NumericEdit>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neDOS2" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="План доначислення відсотків по поточну банківську дату"></bwc:NumericEdit>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neOST2" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="Плановий залишок на рахунку нарахованих %% за поточну банківську дату"></bwc:NumericEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox runat="server" ID="tbCount3" BackColor="LightGray" ToolTip="Кількість днів"
                                        Width="40px" ReadOnly="true" Style="text-align: right"></asp:TextBox>
                                </td>
                                <td>
                                    <bwc:DateEdit ID="tbDat3" runat="server" Width="90px" Date="" MaxDate="2999-12-31"
                                        MinDate="" ToolTip="Остання календарна дата місяця або контрольна дата">01/01/0001 00:00:00</bwc:DateEdit>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neDOS3" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="План доначислення відсотків по вказану дату"></bwc:NumericEdit>
                                </td>
                                <td>
                                    <bwc:NumericEdit runat="server" ID="neOST3" Width="110px" BackColor="LightGray" ReadOnly="true"
                                        ToolTip="Плановий залишок на рахунку нарахованих %% за вказану дату"></bwc:NumericEdit>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <br />
                                    <asp:Button runat="server" ID="btRefresh" Text="Розрахувати" Width="150px" OnClick="btRefresh_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    </asp:Panel>
    </form>
</body>
</html>
