<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositcommissionquest.aspx.cs" Inherits="deposit_depositcommissionquest" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Запити на відміну комісії</title>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td colspan="3" align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTitle"
                        Text="Запросы об отмене комиссии"></asp:Label></td>                
            </tr>
            <tr>
                <td colspan="3">
                    <bars:barsgridview id="BarsGridView1" runat="server" autogeneratecolumns="False"
                        cssclass="BaseGrid" datasourceid="dsQuest" datemask="dd/MM/yyyy" meta:resourcekey="BarsGridView1Resource1">
                        <Columns>
                            <asp:BoundField DataField="ACCEPT" HeaderText="*" SortExpression="ACCEPT" HtmlEncode="False" meta:resourcekey="BoundFieldResource1">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DEL" HeaderText="*" HtmlEncode="False" SortExpression="DEL" meta:resourcekey="BoundFieldResource2">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_ID" HeaderText="Ід." SortExpression="REQ_ID" meta:resourcekey="BoundFieldResource3">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_CRDATE" HeaderText="Дата створення" SortExpression="REQ_CRDATE" meta:resourcekey="BoundFieldResource4">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_CRUSER" HeaderText="Ким створений" SortExpression="REQ_CRUSER" meta:resourcekey="BoundFieldResource5">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_PRCDATE" HeaderText="Дата обробки" SortExpression="REQ_PRCDATE" meta:resourcekey="BoundFieldResource6">
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_PRCUSER" HeaderText="Ким оброблений" SortExpression="REQ_PRCUSER" meta:resourcekey="BoundFieldResource7">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AGRMNT_TYPENAME" HeaderText="Тип дод. угоди" SortExpression="AGRMNT_TYPE" meta:resourcekey="BoundFieldResource8">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REQ_STATENAME" HeaderText="Стан" SortExpression="REQ_STATENAME" meta:resourcekey="BoundFieldResource9">
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                        </Columns>
                    </bars:barsgridview>
                </td>                
            </tr>
            <tr>
                <td colspan="3">
                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsQuest" runat="server"></bars:barssqldatasource>
                </td>                
            </tr>
            <tr>
                <td style="width:25%">
                    <input id="btTakeComission" runat="server" class="AcceptButton" onserverclick="btTakeComission_ServerClick"
                        type="button" value="С оплатой комиссии" tabindex="1" meta:resourcekey="btTakeComission" /></td>
                <td style="width:25%">
                    <input id="btForm" runat="server" class="AcceptButton" onserverclick="btForm_ServerClick"
                        type="button" value="Отменить комиссию" tabindex="2" meta:resourcekey="btForm" /></td>
                <td style="width:50%">
                    <input type="hidden" runat="server" id="reqid" /></td>                
            </tr>
            <tr>
                <td style="width: 25%">
                    </td>
                <td style="width: 25%">
                    <input id="btRefresh" runat="server" class="AcceptButton" type="button" value="Обновить" 
                        tabindex="3" onserverclick="btRefresh_ServerClick"  meta:resourcekey="btRefresh"/></td>
                <td style="width: 50%">
                    <input type="hidden" runat="server" id="confirm_reqid" />
                    <input type="hidden" runat="server" id="confirm_agr_type" />
                </td>
            </tr>
        </table>
    </form>
    <script type="text/javascript">
        focusControl('btTakeComission');
    </script>
</body>
</html>
