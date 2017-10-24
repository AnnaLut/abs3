<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositpayoffresource.aspx.cs" Inherits="deposit_depositpayoffresource" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>
<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
		<title>Депозитний модуль: Ресурс по термінах погашення</title>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<link href="/Common/css/barsgridview.css" type="text/css" rel="stylesheet"/>		
</head>
<body>
    <form id="form1" runat="server">
    <table class="MainTable">
        <tr>
            <td colspan="3" align="center">
                <asp:Label ID="lbTitle" runat="server" CssClass="InfoHeader" meta:resourcekey="lbTitleResource1"
                    Text="Ресурс по срокам погашення"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <cc1:ImageTextButton ID="btRefreshByDay" runat="server" EnabledAfter="0" ImageUrl="\Common\Images\default\16\refresh.png" 
                meta:resourcekey="btRefreshByDayResource1" OnClick="btRefreshByDay_Click" Text="По днях" ToolTip="По днях" style="width:150px"/>
            </td>
            <td style="width:1%">
                <cc1:ImageTextButton ID="btRefreshMonth" runat="server" EnabledAfter="0" ImageUrl="\Common\Images\default\16\refresh_table.png"
                meta:resourcekey="btRefreshMonthResource1" OnClick="btRefreshMonth_Click" Text="По місяцях" ToolTip="По місяцях" style="width:150px"/>
            </td>
            <td style="width:100%"></td>
        </tr>
        <tr>
            <td colspan="3">
                <Bars:BarsGridView ID="BarsGridView1" runat="server" AllowPaging="True" AllowSorting="True" CssClass="BaseGrid" DataSourceID="dsResource" 
                    DateMask="dd/MM/yyyy" meta:resourcekey="BarsGridView1Resource1" AutoGenerateColumns="False"
                    ShowPageSizeBox="True" PageSize="20" >
                    <Columns>
                        <asp:BoundField DataField="LCV" HeaderText="Валюта" meta:resourcekey="BoundFieldResource1"
                            SortExpression="LCV" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DAT" HeaderText="Дата" meta:resourcekey="BoundFieldResource2"
                            SortExpression="DAT" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SUMA" HeaderText="Сума" meta:resourcekey="BoundFieldResource3"
                            SortExpression="SUMA" >
                            <itemstyle horizontalalign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BRANCH" HeaderText="Підрозділ" meta:resourcekey="BoundFieldResource4"
                            SortExpression="BRANCH" >
                            <itemstyle horizontalalign="Center" />
                        </asp:BoundField>
                    </Columns>
                </Bars:BarsGridView>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsResource" runat="server">
                </Bars:BarsSqlDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
