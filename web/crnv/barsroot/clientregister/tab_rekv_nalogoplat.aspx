<%@ Page language="c#" Inherits="clientregister.tab_rekv_nalogoplat" CodeFile="tab_rekv_nalogoplat.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Реквизиты налоплатильщика</title>
		<LINK href="DefaultStyleSheet.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" src="JScriptFortab_rekv_nalogoplat.js?v1.3"></script>
		<script language="javascript" src="additionalFuncs.js"></script>
	</HEAD>
	<body onload="InitObjects()">		
		<TABLE class="tab_rekv_nalogoplat_tb_main" id="tb_main" cellSpacing="1" cellPadding="0">
			<TR>
				<TD style="PADDING-LEFT: 20px; HEIGHT: 30px" align="left"><INPUT id="ckb_main" onclick="MyChengeEnable(document.getElementById('ckb_main').checked);ToDoOnChange();"
						tabIndex="1" type="checkbox" CHECKED runat="server">
					<DIV runat="server" meta:resourcekey="divNal" class="simpleTextStyle" style="DISPLAY: inline">Заполнять реквизиты Налогоплательщика</DIV>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE id="tb_rekv" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial" cellSpacing="0" cellPadding="1"
						align="left" border="0">
						<TR>
							<TD runat="server" meta:resourcekey="tdRNI" width="250">Областная НИ</TD>
							<TD><SELECT class="tab_main_rekv_ed2_style" id="ddl_C_REG" tabIndex="2" onchange="GetC_dstList(); if(trim(parent.obj_Parameters['TGR']) != '3') document.getElementById('ddl_C_DST').remove(0);ToDoOnChange();"
									runat="server">
									<OPTION selected></OPTION>
								</SELECT></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdDNI">Районная НИ</TD>
							<TD><SELECT id="ddl_C_DST" tabIndex="3" onchange="ToDoOnChange();">
									<OPTION selected></OPTION>
								</SELECT></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdAdm">Адм. орган регистрации</TD>
							<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_ADM" tabIndex="4" type="text" maxLength="70" onchange="ToDoOnChange();"></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdRegNumInAdm">Рег. номер в Адм.</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_RGADM" tabIndex="5" type="text" maxLength="30" onchange="ToDoOnChange();"></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdRegNumInNI">Рег. номер в НИ</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_RGTAX" tabIndex="6" type="text" maxLength="15" onchange="ToDoOnChange();"></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdNalCode">Налоговый код (К050)</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_TAXF" tabIndex="7" type="text" maxLength="12" onblur="isNumberCheck(document.getElementById('ed_TAXF'));ToDoOnChange();"></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="RegDateInNI">Дата рег. в НИ</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_DATET" title="Формат: dd.mm.yyyy или /" tabIndex="8"
									type="text" maxLength="10" onchange="document.getElementById('ed_DATET').value = document.getElementById('ed_DATET').value.replace('/','.');ToDoOnChange();" onblur="isDateCheck(document.getElementById('ed_DATET'))">
								<DIV id="lb_1" style="DISPLAY: inline; FONT-SIZE: 12pt; WIDTH: 8px; COLOR: red; HEIGHT: 18px">*</DIV>
							</TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="RegDateInAdm">Дата рег. в Адм.</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_DATEA" title="Формат: dd.mm.yyyy или /" tabIndex="9"
									type="text" maxLength="10" onchange="document.getElementById('ed_DATEA').value = document.getElementById('ed_DATEA').value.replace('/','.');ToDoOnChange();" onblur="isDateCheck(document.getElementById('ed_DATEA'))">
								<DIV id="lb_2" style="DISPLAY: inline; FONT-SIZE: 12pt; WIDTH: 8px; COLOR: red; HEIGHT: 18px">*</DIV>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
		<input type="hidden" id="Mes01" meta:resourcekey="Mes01" runat="server" value="Сервис заблокирован. Попробуйте снова через несколько секунд." />
		<input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
		<input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
		<input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
		<input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
		<input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
		<input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
	</body>
</HTML>
