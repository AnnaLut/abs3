<%@ Page language="c#" CodeFile="ProcAccounts.aspx.cs" AutoEventWireup="false" Inherits="BarsWeb.BasicFunctions.ProcAccounts" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="jscript" src="\Common\WebGrid\Grid.js"></script>
		<script language="jscript" src="Scripts/Common.js"></script>
		<script language="jscript" src="Scripts/ProcAccounts.js"></script>
		<script language="jscript">window.onload = InitPercent;</script>
	</HEAD>
	<body scroll="no">
		<TABLE width="100%">
			<TR>
				<TD>
					<TABLE>
						<TR>
							<TD>&nbsp;<IMG class="outset" id="btIns" title="Добавить новую запись" onclick="Add()" src="/Common/Images/INSERT.gif"><IMG class="outset" id="btDel" title="Удалить строку" onclick="DelRow()" src="/Common/Images/Delete.gif"
									width="16"><IMG class="outset" id="btRefresh" title="Перечитать записи в таблице" onclick="LoadTable()"
									src="/Common/Images/Refresh.gif"><IMG class="outset" id="btSave" title="Сохранить изменения строки" onclick="fnSave()"
									height="16" src="/Common/Images/Save.gif">&nbsp;
							</TD>
							<TD align="left" width="54"><input id="btOb0" title="АКТИВЫ" style="FONT-WEIGHT: bold; WIDTH: 22px; COLOR: red" onclick="P_B0(this)"
									type="button" value="0" name="btOb0" disabled>&nbsp; <input id="btOb1" title="ПАСИВЫ" style="FONT-WEIGHT: bold; WIDTH: 22px; COLOR: blue" onclick="P_B1(this)"
									type="button" value="1" name="btOb1" disabled></TD>
							<TD style="WIDTH: 5px"></TD>
							<TD align="left" width="54"><input id="btOb2" title="ПЕНЯ" style="FONT-WEIGHT: bold; WIDTH: 22px; COLOR: red" onclick="P_B2(this)"
									type="button" value="2" name="btOb2" disabled>&nbsp; <input id="btOb3" title="Ид. 3" style="FONT-WEIGHT: bold; WIDTH: 22px; COLOR: blue" onclick="P_B3(this)"
									type="button" value="3" name="btOb3" disabled></TD>
							<TD style="WIDTH: 19px">
								<div id="Copy" style="VISIBILITY: hidden"><IMG title="Перенести параметры из основной карточки " onclick="fnCopyPer()" src="/Common/Images/COPY.gif"></div>
							</TD>
							<TD><span class="CheckBox"><input id="cb23" onclick="Open23Percent()" type="checkbox" name="cb23"><label for="cb23">Открыть 
										2,3</label></span>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
							<TD><IMG class="outset" id="btClose" title="Выход" onclick="window.close()" src="/Common/Images/DISCARD.gif"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD style="HEIGHT: 8px" align="center">
					<TABLE style="BORDER-RIGHT: 2px outset; BORDER-TOP: 2px outset; BORDER-LEFT: 2px outset; BORDER-BOTTOM: 2px outset"
						cellSpacing="1" cellPadding="1" width="100%">
						<TR>
							<TD align="right" width="268"><span class="BarsLabel" id="lbMetr">Метод начисления</span></TD>
							<TD><select id="ddMetr" style="WIDTH: 400px" onclick="d_dlg(this)">
									<option value="" selected></option>
								</select></TD>
						</TR>
						<TR>
							<TD align="right"><span class="BarsLabel" id="lbBaseY">Базовый год</span></TD>
							<TD><select id="ddBaseY" style="WIDTH: 400px" onclick="d_dlg(this)">
									<option value="" selected></option>
								</select></TD>
						</TR>
						<TR>
							<TD align="right"><span class="BarsLabel" id="lbFreq">Периодичность</span></TD>
							<TD align="left"><select id="ddFreq" style="WIDTH: 400px" onclick="d_dlg(this)">
									<option value="" selected></option>
								</select>
							</TD>
						</TR>
						<TR>
							<TD align="right"><span class="BarsLabel" id="lbOstat">Остаток</span></TD>
							<TD><select id="ddOstat" style="WIDTH: 400px" onchange="SaveP(this)" name="ddOstat">
									<option value="0" selected>Исходящий</option>
									<option value="1">Входящий</option>
								</select></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD style="HEIGHT: 3px" align="center">
					<div class="hint" align="center">Двойной клик по полю - получения возможного 
						значения по умолчанию</div>
					<TABLE width="100%">
						<TR>
							<TD align="center" width="100"><span class="BarsLabelItalic" id="lbDati">Даты</span></TD>
							<TD align="center" width="150"><span class="BarsLabel" id="lbNachis">Начисления</span></TD>
							<TD align="center" width="150"><span class="BarsLabel" id="lbViplat">Выплаты</span></TD>
							<TD align="center" width="150"><span class="BarsLabel" id="lbZaver">Завершение</span></TD>
							<TD align="left"></TD>
						</TR>
						<TR>
							<TD></TD>
							<TD align="center"><input id="tbAcrDat" style="WIDTH: 120px; TEXT-ALIGN: center" type="text" onchange="SaveP(this)"></TD>
							<TD align="center"><input id="tbAplDat" style="WIDTH: 120px; TEXT-ALIGN: center" type="text" onchange="SaveP(this)"></TD>
							<TD align="center"><input id="tbStpDat" style="WIDTH: 120px; TEXT-ALIGN: center" type="text" onchange="SaveP(this)"></TD>
							<TD align="left"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD align="left" height="1">
					<TABLE width="100%">
						<TR>
							<TD align="center" width="100"><span class="BarsLabelItalic" id="lbOper">Операции</span></TD>
							<TD align="center"><span class="BarsLabel" id="lbTip">Тип</span></TD>
							<TD align="center"><span class="BarsLabel" id="lbVal1">Вал</span></TD>
							<TD align="center" width="150"><span class="BarsLabel" id="lbSch">Сч. нач. %%</span></TD>
							<TD align="center" width="90"><span class="BarsLabel" id="lbMFO">МФО</span></TD>
							<TD align="center" width="40"><span class="BarsLabel" id="lbVal2">Вал</span></TD>
							<TD align="center" width="150"><span class="BarsLabel" id="lbKontr">КонтрСчет</span></TD>
							<TD align="center"></TD>
						</TR>
						<TR>
							<TD align="center" width="100"><span class="BarsLabel" id="lbNachisl">Начисл</span></TD>
							<TD align="center" width="40"><input id="tbTT1" ondblclick="ValidPer(this)" style="WIDTH: 50px; TEXT-ALIGN: center" type="text"
									onchange="SaveP(this)" name="tbTT1"></TD>
							<TD align="center" width="40"><input id="tbKvA" ondblclick="ValidPer(this)" style="WIDTH: 40px; TEXT-ALIGN: center" type="text"
									onchange="SaveP(this)" name="tbKvA"></TD>
							<TD align="center" width="150"><input id="tbNlsA" ondblclick="ValidPer(this)" style="WIDTH: 150px" type="text" onchange="ValidNlsA()"
									name="tbNlsA"></TD>
							<TD align="center"></TD>
							<TD align="center" width="40"><input id="tbKvB" ondblclick="ValidPer(this)" style="WIDTH: 40px; TEXT-ALIGN: center" type="text"
									onchange="SaveP(this)" name="tbKvB"></TD>
							<TD align="center" width="150"><input id="tbNlsB" ondblclick="ValidPer(this)" style="WIDTH: 150px" type="text" onchange="ValidNlsB()"
									name="tbNlsB"></TD>
							<TD></TD>
						</TR>
					</TABLE>
					<TABLE width="100%">
						<TR>
							<TD align="center" width="100"><span class="BarsLabel" id="lbVip">Выплат</span></TD>
							<TD width="50"><input id="tbTT2" ondblclick="ValidPer(this)" style="WIDTH: 50px; TEXT-ALIGN: center" type="text"
									onchange="SaveP(this)" name="tbTT2"></TD>
							<TD width="193"><input id="tbNamC" style="WIDTH: 193px" type="text" onchange="SaveP(this)" name="tbNamC"></TD>
							<TD width="90"><input id="tbMFO" style="WIDTH: 90px; TEXT-ALIGN: center" type="text" onchange="SaveP(this)"
									name="tbMFO"></TD>
							<TD width="40"><input id="tbKvC" ondblclick="ValidPer(this)" style="WIDTH: 40px; TEXT-ALIGN: center" type="text"
									onchange="SaveP(this)" name="tbKvC"></TD>
							<TD width="150"><input id="tbNlsC" style="WIDTH: 150px" type="text" onchange="ValidNlsC()" name="tbNlsC"></TD>
							<TD></TD>
						</TR>
					</TABLE>
					<TABLE width="100%">
						<TR>
							<TD width="100"></TD>
							<TD width="536"><input id="tbNazn" style="WIDTH: 538px" type="text" onchange="SaveP(this)" name="tbNazn"></TD>
							<TD></TD>
						</TR>
					</TABLE>
					<div class="hint" align="center">Двойной клик по строке - изменение значений</div>
				</TD>
			</TR>
		</TABLE>
		<div class="webservice" id="webService" showProgress="true"></div>
	</body>
</HTML>
