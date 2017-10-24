<%@ Page Language="C#" AutoEventWireup="true" CodeFile="techrecv.aspx.cs" Inherits="TechRecv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Тех. рекв</title>
	<link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
</head>
<body bottommargin="0" rightmargin="0">
    <form id="form1" runat="server">
		<table cellpadding="0" cellspacing="0" border="0" style="width: auto">
			<tr>
				<td id="Td1" runat="server" class="title" colspan="3"><asp:Label ID="Label1" CssClass="title" runat="server" meta:resourcekey="lbMainResource1">Основные</asp:Label></td>
			</tr>
			<tr>
				<td><asp:label id="lbPostedTitle" runat="server" meta:resourcekey="lbPostedTitleResource1">Дата ввода :</asp:label></td>
				<td colspan="2"><input id="edPosted" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
			</tr>
			<tr>
				<td colspan="3" class="title"><asp:label id="lbSystElPl" CssClass="title" runat="server" meta:resourcekey="lbSystElPlResource1">Система електронных платежей</asp:label></td>
			</tr>
		    <tr>
			    <td><asp:label ID="Label2" runat="server" EnableViewState="False" meta:resourcekey="lbArrivedtitleResource1">Поступил в банк А :</asp:label></td>
			    <td colspan="2"><input id="edArrived" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
		    </tr>
		    <tr>
			    <td><asp:label id="lbReceivedTitle" runat="server" EnableViewState="False" meta:resourcekey="lbReceivedTitleResource1">Получено в файле :</asp:label></td>
			    <td><input id="edFile" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
			    <td><input id="edFileDate" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
		    </tr>
		    <tr>
			    <td><asp:label id="lbInFileReceived" runat="server" EnableViewState="False" meta:resourcekey="lbInFileReceivedResource1">Поступил в наш РЦ :</asp:label></td>
			    <td colspan="2"><input id="edInFileRec" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
		    </tr>
		    <tr>
			    <td><asp:label id="lbInFilePay" runat="server" EnableViewState="False" meta:resourcekey="lbInFilePayResource1">Сквитован :</asp:label></td>
			    <td colspan="2"><input id="edInFilePay" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
		    </tr>
		    <tr>
			    <td class="text"><asp:label id="lbSenderTitle" runat="server" EnableViewState="False" meta:resourcekey="lbSenderTitleResource1">Отправлено :</asp:label></td>
			    <td><input id="edOutFile" type="text" runat="server" style="text-align: center" readonly="readonly" /></td>
			    <td><input id="edOutFileDate" type="text" runat="server" style="text-align: center" readonly="readonly" /></td>
		    </tr>
		    <tr>
			    <td><asp:label id="lbCheckedDate" runat="server" EnableViewState="False" meta:resourcekey="lbCheckedDateResource1">Сквитован :</asp:label></td>
			    <td colspan="2"><input id="edCheckedDate" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
		    </tr>
		</table>
    </form>
</body>
</html>
