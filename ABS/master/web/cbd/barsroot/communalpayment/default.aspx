<%@ Page language="c#" CodeFile="default.aspx.cs" AutoEventWireup="false" Inherits="KP.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>Комунальные платежи</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="jscript" src="/Common/Script/cross.js"></script>
		<script language="jscript" src="/Common/WebTab/WebTab.js"></script>
		<script language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
		<script language="jscript" src="Scripts/Default.js"></script>
		<script language="jscript" src="Scripts/Common.js"></script>
		<script language="jscript">window.onload = InitDefault;</script>
</HEAD>
	<body onkeydown="fnGlobalHotKey()" onfocus="fnFocusDef()">
		<div class="panel">
			<TABLE cellSpacing="0" cellPadding="0">
				<TR>
					<TD style="height: 24px"><span class="BarsLabel" runat="server" meta:resourcekey="spCashier">Кассир:</span></TD>
					<TD style="height: 24px"><input id="isp" style="WIDTH: 60px; BACKGROUND-COLOR: lightgrey" type="text" readonly="readOnly"></TD>
					<TD style="height: 24px"><input class="infobox" id="fio" type="text" readonly="readOnly"></TD>
					<TD style="height: 24px"><span class="BarsLabel" runat="server" meta:resourcekey="spCashBox">&nbsp;Касса:</span></TD>
					<TD style="height: 24px"><input id="cash" style="WIDTH: 80px; BACKGROUND-COLOR: lightgrey" type="text" readonly="readOnly"></TD>
					<TD style="height: 24px"><input class="infobox" id="cash_name" type="text" readonly="readOnly"></TD>
				</TR>
			</TABLE>
		</div>
		<div class="panel">
			<table cellSpacing="0" cellPadding="0">
				<tr>
					<TD noWrap width="130"><span class="BarsLabel" runat="server" meta:resourcekey="spSum">Сумма платежей:</span></TD>
					<TD><input class="tb_ro" id="tbTotal" style="WIDTH: 80px; COLOR: blue; TEXT-ALIGN: right" readOnly type="text"></TD>
					<TD><input class="tb_ro" id="tbTotalSum" style="WIDTH: 300px; COLOR: blue" readOnly type="text"></TD>
					<TD noWrap><span class="BarsLabel" runat="server" meta:resourcekey="spCount">Кол-во платежей:</span></TD>
					<TD><input class="tb_ro" id="tbTotalKol" style="WIDTH: 40px; COLOR: navy; TEXT-ALIGN: center"
							readOnly type="text"></TD>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0">
				<tr>
					<TD noWrap width="130"><span class="BarsLabel" runat="server" meta:resourcekey="spFIO">Фио плательщика:</span></TD>
					<TD><input class="tb_ro" id="tbFio" style="WIDTH: 240px; COLOR: navy" readOnly type="text"></TD>
					<TD align="center">&nbsp;<input class="bt" runat="server" id="btNewClient" meta:resourcekey="btNewClient" onclick="fnNewClient()" type="button" value="Новый (F7)">
						<input class="bt" id="btOplata" runat="server" meta:resourcekey="btOplata" onclick="fnOplata()" type="button" value="Оплата (F8)"></TD>
					<TD valign="bottom">&nbsp;<IMG src="/Common/Images/PRINT.gif" onclick="PrintAll()"
							class="out" id="btPrintAll" runat="server" meta:resourcekey="btPrintAll" alt="Напечатать пачку оплаченых документов(F9)" width="16" height="18">
					</TD>
				</tr>
			</table>
		</div>
		<div class="frame" id="cashGet" onkeydown="fnTryPay()" style="WIDTH: 640px" align="center">
			<table cellSpacing="0" cellPadding="0">
				<tr>
					<TD><span class="BarsLabel" runat="server" meta:resourcekey="spDep">Принято у клиента:</span></TD>
					<TD><input class="tb" id="tbNal" style="WIDTH: 80px; COLOR: maroon" tabIndex="1" type="text"
							onchange="fnConvSum()"></TD>
					<TD><input class="tb_ro" id="tbNalSum" style="WIDTH: 400px; COLOR: maroon" readOnly type="text"></TD>
				</tr>
				<tr>
					<TD><span class="BarsLabel" runat="server" meta:resourcekey="spReturn">Возвратить клиенту:</span></TD>
					<TD><input class="tb_ro" id="tbDel" style="WIDTH: 80px; COLOR: green; TEXT-ALIGN: right" readOnly type="text"></TD>
					<TD><input class="tb_ro" id="tbDelSum" style="WIDTH: 400px; COLOR: green" readOnly type="text"></TD>
				</tr>
			</table>
			<input class="bt" runat="server" id="btOplAll" meta:resourcekey="btOplAll" onclick="OplataAllDocs()" type="button" value="Оплатить">
			<input class="bt" runat="server" id="btHidePay" meta:resourcekey="btHidePay" onclick="HidePay()" type="button" value="Закрыть">
		</div>
		<div id="webtab"></div>
		<div class="webservice" id="webService" showProgress="true"></div>
		<div class="frame" id="data" onkeydown="fnTrySave()" style="WIDTH: 700px" align="center">
			<div id="mainAttr"><span class="BarsLabel" runat="server" meta:resourcekey="spTrAcc">Транзитный счет: </span><input id="NLS" style="WIDTH: 120px; BACKGROUND-COLOR: lightgrey" readOnly type="text"><input class="infobox" id="NMS" style="WIDTH: 300px" readOnly type="text">
				<table class="BarsLabel" cellSpacing="0" cellPadding="0" width="100%">
					<tr>
						<TD width="40" runat="server" meta:resourcekey="tdBank">Банк:</TD>
						<TD width="120"><input class="infobox" id="MFO" title="МФО банка" style="VERTICAL-ALIGN: middle; WIDTH: 100px"
								readOnly type="text" onchange="fnGetMfo()" maxLength="6"><input id="btBank" style="VERTICAL-ALIGN: middle; WIDTH: 20px; HEIGHT: 22px" onclick="fnGetList()"
								type="button" value=">"></TD>
						<TD><input class="infobox" id="NB" title="Наименование банка" style="WIDTH: 100%" readOnly type="text"></TD>
					</tr>
					<tr>
						<TD width="40" runat="server" meta:resourcekey="tdAcc" style="height: 24px">Счет:</TD>
						<TD width="120" style="height: 24px"><input class="infobox" id="NLSB" ondblclick="fnShowAliens()" title="Номер счета" style="WIDTH: 120px"
								readOnly type="text" onchange="fnGetNls()"></TD>
						<TD style="height: 24px"><input class="infobox" id="NMSB" title="Наименование счета" style="WIDTH: 400px" readOnly type="text"><input class="infobox" id="OKPO" ondblclick="fnGetOkpo()" title="ОКПО банка" style="WIDTH: 135px"
								readOnly type="text"></TD>
					</tr>
					<tr>
						<TD width="40" runat="server" meta:resourcekey="tdSCP">СКП:</TD>
						<TD width="120"><input class="infobox" id="SK" title="Символ касс-плана" style="VERTICAL-ALIGN: middle; WIDTH: 100px"
								type="text" onchange="fnGetSK()"><input id="btSK" style="VERTICAL-ALIGN: middle; WIDTH: 20px; HEIGHT: 22px" onclick="fnSKList()"
								type="button" value=">"></TD>
						<TD><input class="infobox" id="SKN" title="Наименование касс-плана" style="WIDTH: 300px" readOnly type="text"><input id="cbGroup" disabled type="checkbox"><label for="cbGroup" runat="server" meta:resourcekey="lbFroup">Группировать</label></TD>
					</tr>
				</table>
				<input id="NAZN" title="Назначение платежа" style="WIDTH: 100%; COLOR: navy" type="text">
			</div>
			<div class="BarsLabel" id="lbReq" align="center" runat="server" meta:resourcekey="divRekv">Реквизиты</div>
			<div id="fields"></div>
			<hr>
			<div align="center"><span class="BarsLabel" runat="server" meta:resourcekey="spS">Сумма:</span>&nbsp;<input id="curr_sum" style="WIDTH: 140px; COLOR: red" type="text" onfocus="fnCheckTotal()" tabIndex=1000></div>
			<div align="center">&nbsp; <input class="bt" runat="server" id="btSave" meta:resourcekey="btS" style="WIDTH: 80px; HEIGHT: 18px" onclick="CheckSum()" type="button"
					value="Сохранить" tabIndex=1001><input class="bt" meta:resourcekey="btCancel" runat="server" style="WIDTH: 80px; HEIGHT: 18px" onclick="HideParam()" type="button"
					value="Отмена" tabIndex=1002>
			</div>
		</div>
		<div id="fields_obj"></div>
		<div id="data_obj"></div>
		<input type="hidden" runat="server" id="forMFO" meta:resourcekey="forMFO" value="МФО банка" />
		<input type="hidden" runat="server" id="forNLSB" meta:resourcekey="forNLSB" value="Номер счета" />
		<input type="hidden" runat="server" id="forSK" meta:resourcekey="forSK" value="Символ касс-плана" />
		<input type="hidden" runat="server" id="forNB" meta:resourcekey="forNB" value="Наименование банка" />
		<input type="hidden" runat="server" id="forNMSB" meta:resourcekey="forNMSB" value="Наименование счета" />
		<input type="hidden" runat="server" id="forSKN" meta:resourcekey="forSKN" value="Наименование касс-плана" />
		<input type="hidden" runat="server" id="forOKPO" meta:resourcekey="forOKPO" value="ОКПО банка" />
		<input type="hidden" runat="server" id="forNAZN" meta:resourcekey="forNAZN" value="Назначение платежа" />
		
		<input type="hidden" runat="server" id="titleDefault" meta:resourcekey="titleDefault" value="Комунальные платежи" />
		
		<input type="hidden" runat="server" id="Mes01" meta:resourcekey="Mes01" value="Неверный контрольный разряд!" />
		<input type="hidden" runat="server" id="Mes02" meta:resourcekey="Mes02" value="Платежи по договорам" />
		<input type="hidden" runat="server" id="Mes03" meta:resourcekey="Mes03" value="Введеные операции" />
		<input type="hidden" runat="server" id="Mes04" meta:resourcekey="Mes04" value="Начать новую пачку?" />
		<input type="hidden" runat="server" id="Mes05" meta:resourcekey="Mes05" value="Не введено ни одного платежа!" />
		<input type="hidden" runat="server" id="Mes06" meta:resourcekey="Mes06" value="Сумма меньше требуемой!" />
		<input type="hidden" runat="server" id="Mes07" meta:resourcekey="Mes07" value="Ошибка суммы!" />
		<input type="hidden" runat="server" id="Mes08" meta:resourcekey="Mes08" value="Добавить документ на сумму" />
		<input type="hidden" runat="server" id="Mes09" meta:resourcekey="Mes09" value="комиссия с плательщика:" />
		<input type="hidden" runat="server" id="Mes10" meta:resourcekey="Mes10" value="Не заполнено поле:" />
		<input type="hidden" runat="server" id="Mes11" meta:resourcekey="Mes11" value="Не заполнен реквизит [ МФО ]" />
		<input type="hidden" runat="server" id="Mes12" meta:resourcekey="Mes12" value="Не заполнен реквизит [ Счет ]" />
		<input type="hidden" runat="server" id="Mes13" meta:resourcekey="Mes13" value="Не заполнен реквизит [ Имя счета ]" />
		<input type="hidden" runat="server" id="Mes14" meta:resourcekey="Mes14" value="Не заполнен реквизит [ ОКПО ]" />
		<input type="hidden" runat="server" id="Mes15" meta:resourcekey="Mes15" value="Не заполнен реквизит [ СК ]" />
		<input type="hidden" runat="server" id="Mes16" meta:resourcekey="Mes16" value="Не заполнен реквизит [ Назначение платежа ]" />
		<input type="hidden" runat="server" id="Mes17" meta:resourcekey="Mes17" value=". Плательщик:" />
		<input type="hidden" runat="server" id="Mes18" meta:resourcekey="Mes18" value="Пачка документов успешно оплачена!" />
		<input type="hidden" runat="server" id="Mes19" meta:resourcekey="Mes19" value="Удалить операцию(DEL)" />
		<input type="hidden" runat="server" id="Mes20" meta:resourcekey="Mes20" value="Распечатать тикет(ALT+CTRL+P)" />
		<input type="hidden" runat="server" id="Mes21" meta:resourcekey="Mes21" value="Карточка документа(ALT+CTRL+D)" />
		<input type="hidden" runat="server" id="Mes22" meta:resourcekey="Mes22" value="Напечатать оттиск(ALT+CTRL+T)" />
		<input type="hidden" runat="server" id="Mes23" meta:resourcekey="Mes23" value=" грн, ком. " />
		<input type="hidden" runat="server" id="Mes24" meta:resourcekey="Mes24" value=" грн" />
		<input type="hidden" runat="server" id="Mes25" meta:resourcekey="Mes25" value="Несуществующий МФО!" />
		<input type="hidden" runat="server" id="Mes26" meta:resourcekey="Mes26" value="Неверный контрольный разряд!" />
		<input type="hidden" runat="server" id="Mes27" meta:resourcekey="Mes27" value="Несуществующий СКП!" />
	</body>
	<script language="javascript">
		LocalizeHtmlTitle('MFO');
		LocalizeHtmlTitle('NLSB');
		LocalizeHtmlTitle('SK');
		LocalizeHtmlTitle('NB');
		LocalizeHtmlTitle('NMSB');
		LocalizeHtmlTitle('SKN');
		LocalizeHtmlTitle('OKPO');
		LocalizeHtmlTitle('NAZN');
		window.document.title = LocalizedString('titleDefault');
	</script>
</HTML>
