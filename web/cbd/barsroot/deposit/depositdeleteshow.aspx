<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositdeleteshow.aspx.cs" Inherits="deposit_depositdeleteshow" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Перегляд запитів на видалення</title>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTitle"
                        Text="Запросы на удаление депозитных договоров"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <Bars:BarsGridView ID="gridRequest" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CssClass="BaseGrid" DataSourceID="dsReqest" DateMask="dd/MM/yyyy"
                        ShowPageSizeBox="True" meta:resourcekey="gridRequestResource1">
                        <Columns>
                            <asp:BoundField DataField="DETAIL" HeaderText="*" HtmlEncode="False" meta:resourcekey="BoundFieldResource1" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_ID" HeaderText="Запит" SortExpression="REQ_ID" meta:resourcekey="BoundFieldResource2" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_CRDATE" HeaderText="Дата створення" SortExpression="REQ_CRDATE" meta:resourcekey="BoundFieldResource3" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_CRUSER" HeaderText="Створив" SortExpression="REQ_CRUSER" meta:resourcekey="BoundFieldResource4" >
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_PRCDATE" HeaderText="Дата обробки" SortExpression="REQ_PRCDATE" meta:resourcekey="BoundFieldResource5" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_PRCUSER" HeaderText="Обробив" SortExpression="REQ_PRCUSER" meta:resourcekey="BoundFieldResource6" >
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DPT_ND" HeaderText="№ договору" SortExpression="DPT_ND">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DPT_ID" HeaderText="Сист. № депозиту" SortExpression="DPT_ID" meta:resourcekey="BoundFieldResource7" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BRANCH_NAME" HeaderText="Відділення" SortExpression="BRANCH_NAME" meta:resourcekey="BoundFieldResource8" >
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_STATENAME" HeaderText="Статус" SortExpression="REQ_STATENAME" meta:resourcekey="BoundFieldResource9" >
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </Bars:BarsGridView>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbDetail" runat="server" CssClass="InfoLabel" meta:resourcekey="lbDetail"
                        Text="Детализация"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <Bars:BarsGridView ID="BarsGridView1" runat="server" CssClass="BaseGrid"
                        DataSourceID="dsDetail" DateMask="dd/MM/yyyy" AutoGenerateColumns="False" meta:resourcekey="BarsGridView1Resource1">
                        <Columns>
                            <asp:BoundField DataField="REQ_ID" HeaderText="Запит" meta:resourcekey="BoundFieldResource10"
                                SortExpression="REQ_ID" />
                            <asp:BoundField DataField="USER_ID" HeaderText="Ід. користувача" meta:resourcekey="BoundFieldResource11"
                                SortExpression="USER_ID" />
                            <asp:BoundField DataField="USER_FIO" HeaderText="Користувач" meta:resourcekey="BoundFieldResource12"
                                SortExpression="USER_FIO" />
                            <asp:BoundField DataField="USER_DATE" HeaderText="Дата" meta:resourcekey="BoundFieldResource13"
                                SortExpression="USER_DATE" />
                            <asp:BoundField DataField="USER_STATE" HeaderText="Статус" meta:resourcekey="BoundFieldResource14"
                                SortExpression="USER_STATE" />
                        </Columns>
                    </Bars:BarsGridView>
                </td>
            </tr>
            <tr>
                <td>
                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsReqest" runat="server">
                    </Bars:barssqldatasource>
                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsDetail" runat="server">
                    </Bars:barssqldatasource>
                    <input type="hidden" runat="server" id="SelId" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
