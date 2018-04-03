<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositbonus.aspx.cs" Inherits="deposit_DepositBonus" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.Web.Controls" Namespace="Bars.Web.Controls" TagPrefix="cc1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Бонуси</title>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body onload="focusControl('btRefresh');">
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel" meta:resourcekey="lbTitle"
                        Text="Сформовані запити на отримання пільг по депозитному договору №%"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <bars:barsgridview id="gridBonus" runat="server" allowpaging="True" allowsorting="True"
                        autogeneratecolumns="False" cssclass="BaseGrid" datasourceid="dsBonus" datemask="dd/MM/yyyy" OnRowDataBound="gridBonus_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="BONUS_ID" HeaderText="Ід. бонуса" SortExpression="BONUS_ID" />
                            <asp:BoundField DataField="BONUS_NAME" HeaderText="Бонус" SortExpression="BONUS_NAME" />
                            <asp:BoundField DataField="BONUS_VALUE_PLAN" HeaderText="План. значення" SortExpression="BONUS_VALUE_PLAN" />
                            <asp:BoundField DataField="BONUS_VALUE_FACT" HeaderText="Факт. значення" SortExpression="BONUS_VALUE_FACT" />
                            <asp:BoundField DataField="REQ_CONFIRM" HeaderText="Потребує підтвердження" SortExpression="REQ_CONFIRM" />
                            <asp:BoundField DataField="REQ_DELETED" HeaderText="Виключений" SortExpression="REQ_DELETED" />
                            <asp:BoundField DataField="REC_STATENAME" HeaderText="Статус" SortExpression="REC_STATENAME" />
                            <asp:BoundField DataField="DEL" HeaderText="*" HtmlEncode="False" />
                        </Columns>
                    </bars:barsgridview>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lbAvailable" runat="server" CssClass="InfoLabel" meta:resourcekey="lbAvailable"
                        Text="Доступні для формування пільги по депозитному договору №%"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <bars:barsgridview id="Barsgridview1" runat="server" allowpaging="True" allowsorting="True"
                        autogeneratecolumns="False" cssclass="BaseGrid" datasourceid="dsFree" datemask="dd/MM/yyyy">
                        <Columns>
                            <asp:BoundField DataField="BONUS_ID" HeaderText="Код бонуса" SortExpression="BONUS_ID" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="BONUS_CODE" HeaderText="Назва" SortExpression="BONUS_CODE" >
                                <itemstyle horizontalalign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FRM" HeaderText="*" HtmlEncode="False" >
                                <itemstyle horizontalalign="Center" />
                            </asp:BoundField>
                        </Columns>
                    </Bars:BarsGridView>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="InnerTable">
                        <tr>
                            <td style="width:20%">
                                <input id="btRefresh"  runat="server" class="AcceptButton" tabindex="1" type="button"
                                    value="Перечитати дані" onserverclick="btRefresh_ServerClick" /></td>
                            <td style="width:20%"><input id="btNext"  runat="server" class="AcceptButton" tabindex="2" type="button"
                                    value="Картка вкладу" onclick="location.replace('depositcontractinfo.aspx');" /></td>
                            <td style="width:20%"></td>
                            <td style="width:20%"></td>
                            <td style="width:20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>            
            <tr>
                <td>
                    <Bars:barssqldatasource ProviderName="barsroot.core" ID="dsFree" runat="server"></Bars:barssqldatasource><bars:barssqldatasource ProviderName="barsroot.core" id="dsBonus" runat="server"></bars:barssqldatasource>
                    <input type="hidden" runat="Server" id="bonus_id" /><input type="hidden" runat="Server" id="ins_bonus_id" />
                </td>                    
            </tr>
        </table>
    </form>
</body>
</html>
