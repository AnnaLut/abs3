<%@ Page language="c#" CodeFile="acc_general.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Acc_General"   enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<script language="jscript" src="Scripts/Common.js?v1.0"></script>
		<script language="jscript" src="Scripts/General.js?v1.4.3"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="jscript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="jscript">window.onload = InitGeneral;</script>
	</HEAD>
	<body scroll="no">
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbDateOn" meta:resourcekey="lbDateOn" class="BarsLabel">Дата открытия:</span></TD>
				<TD><input type="text" readonly id="tbDateOn" class="BarsTextBox_ReadOnly" onchange="SaveG(this)"
						style="WIDTH:100px"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lb_DateOff" meta:resourcekey="lb_DateOff" class="BarsLabel">Дата закрытия:</span></TD>
				<TD><input type="text" readonly id="tbDateOff" class="BarsTextBox_ReadOnly" onchange="SaveG(this)"
						style="WIDTH:100px"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbNbs" meta:resourcekey="lbNbs" class="BarsLabel">Балансовый счет (R020):</span></TD>
				<TD><a id="bAccountPlan" onclick="fnSelectNbs()" href="#" style="FONT-WEIGHT: bold; FONT-SIZE: 14pt; WIDTH: 17px; FONT-FAMILY: Arial">?</a><input type="text" id="tbNbs" class="BarsTextBox_ReadOnly" onchange="fnGetNbs()" style="WIDTH:78px"><input type="text" readonly id="tbNameNbs" class="BarsTextBox_ReadOnly" style="WIDTH:386px"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lb_Nls" meta:resourcekey="lb_Nls" class="BarsLabel">№ счета:</span></TD>
				<TD><a id="bAccountMask" onclick="fnAccMask()" href="#" style="FONT-WEIGHT: bold; FONT-SIZE: 14pt; WIDTH: 17px; FONT-FAMILY: Arial">?</a><input type="text" id="tbNls" class="BarsTextBox" onchange="fnKeyAcc()" style="WIDTH:464px" maxlength="14"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbNlsAlt" meta:resourcekey="lbNlsAlt" class="BarsLabel">Альтернативный №:</span></TD>
				<TD><input type="text" id="tbNlsAlt" class="BarsTextBox" onchange="SaveG(this)" style="WIDTH:481px"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbNms" meta:resourcekey="lbNms" class="BarsLabel">Наименование:</span></TD>
				<TD><input type="text" id="tbNms" class="BarsTextBox" onchange="SaveG(this)" style="WIDTH:481px" maxlength="70"></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbLcv" meta:resourcekey="lbLcv" class="BarsLabel">Валюта (R030):</span></TD>
				<TD><input style="WIDTH: 68px; TEXT-ALIGN: center" type="text" id="tb_Lcv" class="BarsTextBox"
						onchange="fnGetValuta()"><select id="ddValuta" onclick="d_dlg(this,tb_Lcv)" style="WIDTH:415px;BACKGROUND-COLOR:white">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbLspCode" meta:resourcekey="lbLspCode" class="BarsLabel">Исполнитель:</span></TD>
				<TD><input style="WIDTH: 68px; TEXT-ALIGN: center" type="text" id="tbLspCode" class="BarsTextBox"
						onchange="fnGetUser()"><select id="ddUser" onclick="d_dlg(this,tbLspCode)" style="WIDTH:415px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbPap" meta:resourcekey="lbPap" class="BarsLabel">А/П/АП (T020):</span></TD>
				<TD><select id="ddPap" onclick="d_dlg(this)" style="WIDTH:483px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbHar" meta:resourcekey="lbHar" class="BarsLabel">Характеристика:</span></TD>
				<TD><input type="text" readonly id="tbHar" class="BarsTextBox_ReadOnly" style="WIDTH:481px"></TD>
			</TR>
			<TR>
				<TD class="TD_Left" colSpan="1"><span runat="server" id="lbTip" meta:resourcekey="lbTip" class="BarsLabel">Тип счета:</span></TD>
				<TD><input type="text" readonly id="tbTip" class="BarsTextBox_ReadOnly" style="WIDTH:68px"><select id="ddTip" onclick="listTips(this,tbTip)" style="WIDTH:415px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbPos" meta:resourcekey="lbPos" class="BarsLabel">Признак счета:</span></TD>
				<TD><select id="ddPos" onclick="d_dlg(this)" style="WIDTH:483px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left"><span runat="server" id="lbVid" meta:resourcekey="lbVid" class="BarsLabel">Вид счета (НИ):</span></TD>
				<TD><select id="ddVid" onclick="d_dlg(this)" style="WIDTH:483px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left" style="height: 24px"><span runat="server" id="lbMfo" meta:resourcekey="lbMfo" class="BarsLabel">МФО для процессинг. счета:</span></TD>
				<TD style="height: 24px"><input type="text" id="tbMfo" class="BarsTextBox_ReadOnly" readonly="readonly" onchange="fnGetMfo()" style="WIDTH:100px"><select id="ddMfo" class="BarsTextBox_ReadOnly" disabled="disabled" onclick="d_dlg(this,tbMfo)" style="WIDTH:383px">
						<option value="" selected></option>
					</select></TD>
			</TR>
			<TR>
				<TD class="TD_Left" style="height: 24px"><span runat="server" id="lbTobo" meta:resourcekey="lbTobo" class="BarsLabel">Код безбаланс. отделения:</span></TD>
				<TD style="height: 24px"><input type="text" id="tbTobo" readonly="readonly" class="BarsTextBox_ReadOnly" onchange="fnGetTobo()" style="WIDTH:100px"><select id="ddTobo" onclick="d_dlg(this,tbTobo)" style="WIDTH:383px">
						<option value="" selected></option>
					</select></TD>
			</TR>
		</TABLE>
		<DIV class="webservice" id="webService" showProgress="true"></DIV>
		<input runat="server" type="hidden" id="currentPageCulture" meta:resourcekey="currentPageCulture" value="ru" />
        <input runat="server" type="hidden" id="wgPageSizeText" meta:resourcekey="wgPageSizeText" value="Cтрок на странице:" />
        <input runat="server" type="hidden" id="wgPrevPage" meta:resourcekey="wgPrevPage" value="Предыдущая страница" />
        <input runat="server" type="hidden" id="wgNextPage" meta:resourcekey="wgNextPage" value="Следующая страница" />
        <input runat="server" type="hidden" id="wgRowsInTable" meta:resourcekey="wgRowsInTable" value="Количество строк в таблице" />
        <input runat="server" type="hidden" id="wgAscending" meta:resourcekey="wgAscending" value="По возрастанию" />
        <input runat="server" type="hidden" id="wgDescending" meta:resourcekey="wgDescending" value="По убыванию" />
        <input runat="server" type="hidden" id="wgSave" meta:resourcekey="wgSave" value="Сохранить" />
        <input runat="server" type="hidden" id="wgCancel" meta:resourcekey="wgCancel" value="Отмена" />
        <input runat="server" type="hidden" id="wgSetFilter" meta:resourcekey="wgSetFilter" value="Установить фильтр" />
        <input type="hidden" id="wgFilter" value="Фильтр" />
        <input type="hidden" id="wgAttribute" value="Атрибут" />
        <input type="hidden" id="wgOperator" value="Оператор" />
        <input type="hidden" id="wgLike" value="похож" />
        <input type="hidden" id="wgNotLike" value="не похож" />
        <input type="hidden" id="wgIsNull" value="пустой" />
        <input type="hidden" id="wgIsNotNull" value="не пустой" />
        <input type="hidden" id="wgOneOf" value="один из" />
        <input type="hidden" id="wgNotOneOf" value="ни один из" />
        <input type="hidden" id="wgValue" value="Значение" />
        <input type="hidden" id="wgApply" value="Применить" />
        <input type="hidden" id="wgFilterCancel" value="Отменить" />
        <input type="hidden" id="wgCurrentFilter" value="Текущий фильтр:" />
        <input type="hidden" id="wgDeleteRow" value="Удалить строку" />
        <input type="hidden" id="wgDeleteAll" value="Удалить все" />
		<input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
		<input runat="server" type="hidden" id="Message26" meta:resourcekey="Message26" value="Признак АКТ-ПАС не отвечает плану счетов" />
        <input runat="server" type="hidden" id="Message27" meta:resourcekey="Message27" value="Нет такого балансового счета или балансовый счет закрыт" />
        <input runat="server" type="hidden" id="Message28" meta:resourcekey="Message28" value=" уже существует!" />
        <input runat="server" type="hidden" id="Message29" meta:resourcekey="Message29" value="Исполнителя с таким кодом не существует" />
		<script>fnLoadGeneral();</script>
	</body>
</HTML>
