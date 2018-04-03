<%@ Page Language="C#" AutoEventWireup="true" CodeFile="document.aspx.cs" Inherits="Document" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Документ</title>
	<link href="CSS/AppCSS.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/jscript">
        var naznOffset = 50;
        var naznMin = 500;

        function ResizeNazn() {
            // Check if document width is higher than window width
            if ($(document).width() > $(window).width()) {
                var naznWidth = $(window).width() - naznOffset;
                // alert('naznWidth = ' + naznWidth + ' naznMin = ' + naznMin);
                $("#lbDetails").width(Math.max(naznWidth, naznMin));
            }
        }
        
        // подгоняем размер при старет страницы и при изменении размеров
        $(document).ready(ResizeNazn);
        $(window).resize(ResizeNazn);
    </script>
</head>
<body bottommargin="0" rightmargin="0">
	<form id="Form1" method="post" runat="server">
		<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td id="lbDoctitle" colspan="5" class="title" runat="server">нет данных</td>
			</tr>
			<tr>
				<td id="lbDocDate" colspan="5" class="title" runat="server">нет данных</td>
			</tr>
			<tr>
				<td id="Td1" class="title" meta:resourcekey="ValueDateLabel" runat="server">Дата валютирования :</td>
				<td colspan="3"><input id="edValueDate" type="text" style="text-align: center" runat="server" readonly="readonly" /></td>
				<td id="Td2" class="title" meta:resourcekey="DEBETLabel" runat="server">ДЕБЕТ</td>
			</tr>
			<tr>
				<td id="Td3" meta:resourcekey="SendreOKPOLabel" class="text" runat="server">Отправитель :</td>
				<td colspan="2"><input id="edSendreOKPO" type="text" style="text-align: right" value="нет данных" runat="server" readonly="readonly" /></td>
				<td id="Td4" meta:resourcekey="SCHETLabel" class="text" runat="server">Счет :</td>
				<td id="Td5" meta:resourcekey="VALUTALabel" class="text" runat="server">Валюта :</td>
			</tr>
			<tr>
				<td id="lbSender" class="text" runat="server" style="color: Blue; padding-left: 10px" colspan="3">нет данных</td>
				<td><input id="edAccA" type="text" style="text-align: left" value="нет данных" runat="server" readonly="readonly" /></td>
				<td><input id="edCcyA" type="text" style="text-align: center" value="нет данных" runat="server" readonly="readonly" /></td>
			</tr>
			<tr>
				<td id="Td6" meta:resourcekey="BANKOTPRAVITELIALabel" class="text" runat="server" colspan="3">Банк отправителя :</td>
				<td id="Td7" meta:resourcekey="MFOLabel" class="text" runat="server">МФО :</td>
				<td id="Td8" meta:resourcekey="SUMMALabel" class="text" runat="server">Сумма :</td>
			</tr>
			<tr>
				<td id="lbBankA" class="text" runat="server" style="color: Blue; padding-left: 10px" colspan="3">нет данных</td>
				<td><input id="edMfoA" type="text" style="text-align: left" value="нет данных" runat="server" readonly="readonly" /></td>
				<td><input id="edSumA" type="text" style="text-align: right" value="нет данных" runat="server" readonly="readonly" /></td>
			</tr>
			<tr>
			    <td style="height: 20px" colspan="5"></td>
			</tr>
			<tr>
				<td colspan="4"></td>
				<td id="Td9" meta:resourcekey="CREDITLabel" class="title" runat="server">КРЕДИТ</td>
			</tr>
			<tr>
				<td id="Td10" meta:resourcekey="ReceiverOKPOLabel" class="text" runat="server">Получатель :</td>
				<td colspan="2"><input id="edReceiverOKPO" type="text" style="text-align: right" value="нет данных" runat="server" readonly="readonly" /></td>
				<td id="Td11" meta:resourcekey="SCHETLabel" class="text" runat="server">Счет :</td>
				<td id="lbCcyB" meta:resourcekey="VALUTALabel" class="text" runat="server">Валюта :</td>
			</tr>
			<tr>
				<td id="lbReceiver" class="text" runat="server" style="color: Blue; padding-left: 10px" colspan="3">нет данных</td>
				<td><input id="edAccB" type="text" style="text-align: left" value="нет данных" runat="server" readonly="readonly" /></td>
				<td><input id="edCcyB" type="text" style="text-align: center" value="нет данных" runat="server" readonly="readonly" /></td>
			</tr>
			<tr>
				<td id="Td12" meta:resourcekey="BANKPOLUCHATELIALabel" class="text" runat="server" colspan="3">Банк получателя :</td>
				<td id="Td13" meta:resourcekey="MFOLabel" class="text" runat="server">МФО :</td>
				<td id="lbSumB" meta:resourcekey="SUMMALabel" class="text" runat="server">Сумма :</td>
			</tr>
			<tr>
				<td id="lbBankB" class="text" runat="server" style="color: Blue; padding-left: 10px" colspan="3">нет данных</td>
				<td><input id="edMfoB" type="text" style="text-align: left" value="нет данных" runat="server" readonly="readonly" /></td>
				<td><input id="edSumB" type="text" style="text-align: right" value="нет данных" runat="server" readonly="readonly" /></td>
			</tr>
			<tr>
			    <td style="height: 20px" colspan="5"></td>
			</tr>
			<tr>
				<td id="Td14" meta:resourcekey="SUMMASLOVAMILabel" class="text" runat="server" colspan="5">Сумма прописью :</td>
			</tr>
			<tr>
				<td id="lbSumPr" class="text" runat="server" style="color: Blue; padding-left: 10px" colspan="5">нет данных</td>
			</tr>
			<tr>
				<td id="Td15" meta:resourcekey="NAZNACHENIEPLATEGALabel" class="text" runat="server" colspan="5">Назначение платежа :</td>
			</tr>
			<tr>
				<td id="lbDetails" class="nazn" runat="server" colspan="5">нет данных 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111</td>
			</tr>
		</table>
	</form>
</body>
</html>
