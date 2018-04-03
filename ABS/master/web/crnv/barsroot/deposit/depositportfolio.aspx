<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositportfolio.aspx.cs" Inherits="deposit_depositportfolio" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Src="uc_portfolio.ascx" TagName="uc_portfolio" TagPrefix="uc1" %>

<%@ Register Assembly="WebChart" Namespace="WebChart" TagPrefix="Web" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Портфель</title>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" Text="Портфель вкладов населения" meta:resourcekey="lbTitleResource1"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btRefresh" runat="server" ButtonStyle="Image" ImageUrl="\Common\Images\default\16\refresh.png"
                                TabIndex="1" ToolTip="Перечитать" EnabledAfter="0" meta:resourcekey="btRefreshResource1" OnClick="btRefresh_Click" OnClientClick="if (GetFilter())" />
                        </td>
                        <td style="width:1%">
                            <cc1:ImageTextButton ID="btPayOffResource" runat="server" ButtonStyle="Image" ImageUrl="\Common\Images\default\16\reference_open.png"
                                TabIndex="3" ToolTip="Ресурс по срокам погашения" EnabledAfter="0" meta:resourcekey="btPayOffResourceResource1" OnClientClick="location.replace('depositpayoffresource.aspx'); return;" />
                        </td>
                        <td style="width:1%">
                        </td>
                        <td style="width:100%"></td>
                    </tr>
                </table>
            </td>
        </tr>        
        <tr>
            <td>
                <table class="InnerTable">
                    <tr>
                        <td colspan="4" align="center">
                            <asp:Label ID="lbFIlter" runat="server" CssClass="InfoLabel" meta:resourcekey="lbFIlter"
                                Text="Критерии формирования"></asp:Label></td>                    
                    </tr>
                    <tr>
                        <td style="width:50%" rowspan="6" colspan="2">
                            <table id="FILTER" class="InnerTable" style="width:100%" runat="server">
                                <tr>
                                    <td align="center" style="width:5%">
                                        <asp:Label ID="lbMark" runat="server" CssClass="InfoText"
                                            Text="*" meta:resourcekey="lbMarkResource1" Font-Bold="True"></asp:Label></td>
                                    <td style="width:25%">
                                        <asp:Label ID="lbOrder" runat="server" CssClass="InfoText"
                                            Text="Порядок" meta:resourcekey="lbOrderResource1" Font-Bold="True"></asp:Label></td>
                                    <td style="width:100%">
                                        <asp:Label ID="lbCriteria" runat="server" CssClass="InfoText"
                                            Text="Разрез" meta:resourcekey="lbCriteriaResource1" Font-Bold="True"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                        <td style="width:20%">
                            <asp:Label ID="lbStartDate" runat="server" CssClass="InfoText" Text="Начало периода" meta:resourcekey="lbStartDateResource1"></asp:Label></td>
                        <td style="width:30%">
                            <cc1:DateEdit ID="StartDate" runat="server" TabIndex="10" Date="" MaxDate="2099-12-31" meta:resourcekey="StartDateResource2" MinDate="" Text="01/01/0001 00:00:00"></cc1:DateEdit></td>
                    </tr>
                    <tr>
                        <td style="width: 20%">
                            <asp:Label ID="lbEndDate" runat="server" CssClass="InfoText" Text="Конец периода" meta:resourcekey="lbEndDateResource1"></asp:Label></td>
                        <td style="width: 30%">
                            <cc1:DateEdit ID="EndDate" runat="server" TabIndex="11" Date="" MaxDate="2099-12-31" meta:resourcekey="EndDateResource2" MinDate="" Text="01/01/0001 00:00:00"></cc1:DateEdit>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 50%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 40%">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <Bars:BarsGridView ID="gridPortfolio" runat="server" AllowPaging="True" AllowSorting="True" CssClass="BaseGrid" DataSourceID="dsPortfolio" DateMask="dd/MM/yyyy"
                    ShowPageSizeBox="True" meta:resourcekey="gridPortfolioResource1" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="TOBO" HeaderText="Отдел." meta:resourcekey="BoundFieldResource1"
                            SortExpression="TOBO" />
                        <asp:BoundField DataField="ISP" HeaderText="Исп." meta:resourcekey="BoundFieldResource2"
                            SortExpression="ISP" />
                        <asp:BoundField DataField="VIDD" HeaderText="Вид вклада" meta:resourcekey="BoundFieldResource3"
                            SortExpression="VIDD" />
                        <asp:BoundField DataField="KV" HeaderText="Вал." meta:resourcekey="BoundFieldResource4"
                            SortExpression="KV" />
                        <asp:BoundField DataField="NBS" HeaderText="Бал. счет" meta:resourcekey="BoundFieldResource5"
                            SortExpression="NBS" />
                        <asp:BoundField DataField="DPTSAL1" HeaderText="Сумма вкладов на начало" meta:resourcekey="BoundFieldResource6"
                            SortExpression="DPTSAL1" />
                        <asp:BoundField DataField="RAT1" HeaderText="Средне- взвешенная % ставка на начало" meta:resourcekey="BoundFieldResource7"
                            SortExpression="RAT1" />
                        <asp:BoundField DataField="DOSD" HeaderText="Сумма ДТ оборотов по вкладам" meta:resourcekey="BoundFieldResource8"
                            SortExpression="DOSD" />
                        <asp:BoundField DataField="KOSD" HeaderText="Сумма КТ оборотов по вкладам" meta:resourcekey="BoundFieldResource9"
                            SortExpression="KOSD" />
                        <asp:BoundField DataField="DPTSAL2" HeaderText="Сумма вкладов на конец" meta:resourcekey="BoundFieldResource10"
                            SortExpression="DPTSAL2" />
                        <asp:BoundField DataField="RAT2" HeaderText="Средне- взвешенная % ставка на конец" meta:resourcekey="BoundFieldResource11"
                            SortExpression="RAT2" />
                        <asp:BoundField DataField="PERSAL1" HeaderText="Сумма % на начало" meta:resourcekey="BoundFieldResource12"
                            SortExpression="PERSAL1" />
                        <asp:BoundField DataField="DOSP" HeaderText="Сумма ДТ оборотов по %" meta:resourcekey="BoundFieldResource13"
                            SortExpression="DOSP" />
                        <asp:BoundField DataField="KOSP" HeaderText="Сумма КТ оборотов по %" meta:resourcekey="BoundFieldResource14"
                            SortExpression="KOSP" />
                        <asp:BoundField DataField="PERSAL2" HeaderText="Сумма % на конец" meta:resourcekey="BoundFieldResource15"
                            SortExpression="PERSAL2" />
                        <asp:BoundField DataField="ACC1" HeaderText="К-во счетов на начало" meta:resourcekey="BoundFieldResource16"
                            SortExpression="ACC1" />
                        <asp:BoundField DataField="ACCO" HeaderText="Открыто счетов" SortExpression="ACCO" meta:resourcekey="BoundFieldResource17" />
                        <asp:BoundField DataField="ACCC" HeaderText="Закрыто счетов" SortExpression="ACCC" meta:resourcekey="BoundFieldResource18" />
                        <asp:BoundField DataField="ACC2" HeaderText="К-во счетов на конец" SortExpression="ACC2" meta:resourcekey="BoundFieldResource19" />
                    </Columns>
                </Bars:BarsGridView>
            </td>
        </tr>
        <tr>
            <td>
                <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsPortfolio" runat="server">
                </Bars:barssqldatasource>
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" runat="server" id="CLIENT_FILTER" />
                <input type="hidden" runat="server" id="FILTER_POS" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        window.attachEvent("onload",InitFilter);
    </script>
    </form>
</body>
</html>
