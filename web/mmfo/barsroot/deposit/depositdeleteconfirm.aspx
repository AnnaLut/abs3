<%@ Page Language="C#" AutoEventWireup="true" CodeFile="depositdeleteconfirm.aspx.cs" Inherits="deposit_depositdeleteconfirm" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="Bars.DataComponents" Namespace="Bars.DataComponents" TagPrefix="Bars" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
		<title>Депозитний модуль: Підтвердження запитів на видалення</title>
		<link href="style/dpt.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" language="javascript" src="js/js.js"></script>
	    <script type="text/javascript" language="javascript" src="js/ck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="MainTable">
            <tr>
                <td align="center">
                    <asp:Label ID="lbTitle" runat="server" CssClass="InfoLabel"
                        Text="Запросы на удаление депозитных договоров" meta:resourcekey="lbTitle"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <bars:barsgridview id="gridQuest" runat="server" allowpaging="True" allowsorting="True"
                        autogeneratecolumns="False" cssclass="BaseGrid" datasourceid="dsDeleteQue" datemask="dd/MM/yyyy"
                        showpagesizebox="True"><Columns>
<asp:BoundField HtmlEncode="False" DataField="CONFIRM" HeaderText="*">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataField="DECLINE" HeaderText="*">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="REQ_ID" SortExpression="REQ_ID" HeaderText="Запит">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataField="DPT_ID" SortExpression="DPT_ID" HeaderText="Сист. № депозиту">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DPT_ND" SortExpression="DPT_ND" HeaderText="№ депозиту">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="DPT_DATE" SortExpression="DPT_DATE" HeaderText="Дата">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="USER_FIO" SortExpression="USER_FIO" HeaderText="ПІБ">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
</asp:BoundField>
</Columns>
</bars:barsgridview>
                </td>
            </tr>
            <tr>
                <td>
                    <bars:barssqldatasource ProviderName="barsroot.core" id="dsDeleteQue" runat="server"></bars:barssqldatasource>
                </td>
            </tr>
            <tr>
                <td>
                    <input runat="server" type="hidden" id="hidDeclineDelete" />
                    <input runat="server" type="hidden" id="hidConfirmDelete" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
