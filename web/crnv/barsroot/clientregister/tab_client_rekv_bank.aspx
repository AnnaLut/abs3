<%@ Page language="c#" Inherits="clientregister.tab_client_rekv_bank" CodeFile="tab_client_rekv_bank.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Реквизиты клиента "Банк"</title>
		<LINK href="DefaultStyleSheet.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" src="additionalFuncs.js"></script>
		<script language="javascript" src="JScriptFortab_client_rekv_bank.js"></script>
	</HEAD>
	<body onload="InitObjects()">
			<div id="main">
				<TABLE id="tb_rekv" style="FONT-SIZE: 10pt" cellSpacing="0" cellPadding="1" align="left"
					border="0">
					<TR>
						<TD align="center" width="180">
							<DIV runat="server" meta:resourcekey="divBank" class="titleStyle">Банк</DIV>
						</TD>
						<TD align="center">
							<DIV class="simpleTextStyle" id="lb_title_bank" style="TEXT-ALIGN: center"></DIV>
						</TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdTop">Рейтинг банка</TD>
						<TD><INPUT class="tab_main_rekv_ed_style" id="ed_RATING" tabIndex="1" type="text" maxLength="1" onchange="ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdMFO">Код банка - МФО</TD>
						<TD><table cellpadding="0" cellspacing="0">
								<tr>
									<td style="height: 23px"><INPUT class="tab_main_rekv_ed_style" id="ed_MFO" tabIndex="2" type="text" maxLength="12"
											onchange="GetMfoCom(getEl('ed_MFO').value);ToDoOnChange();"></td>
									<td style="height: 23px">
									    <img id="bt_help" runat="server" meta:resourcekey="btHelp" src="/Common/Images/HELP.gif" height="16" width="16" alt="Справка" onclick="var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=banks&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px'); if(result != null)PutIntoEdit(getEl('ed_MFO'),result[0]); GetMfoCom(getEl('ed_MFO').value);ToDoOnChange();" />
									</td>
									<td style="PADDING-LEFT: 7px; height: 23px;"><DIV id="lb_1" style="DISPLAY: inline; FONT-SIZE: 15pt; WIDTH: 8px; COLOR: red; HEIGHT: 18px">*</DIV>
									</td>
								</tr>
							</table>
						</TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdBIC">Код банка - ВІС</TD>
						<TD><table cellpadding="0" cellspacing="0">
								<tr>
									<td><INPUT class="tab_main_rekv_ed_style" id="ed_BIC" tabIndex="3" type="text" maxLength="11" onchange="ToDoOnChange();"></td>
									<td>
                                        <img id="Img1" runat="server" meta:resourcekey="btHelp" src="/Common/Images/HELP.gif" height="16" width="16" alt="Справка" onclick="var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=sw_banks&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px'); if(result != null) PutIntoEdit(getEl('ed_BIC'), result[0]);ToDoOnChange();" />
                                    </td>
								</tr>
							</table>
						</TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdAltBIC">Альтернативный ВІС</TD>
						<TD><INPUT class="tab_main_rekv_ed_style" id="ed_ALT_BIC" tabIndex="4" type="text" maxLength="11" onchange="ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="td1PB">Код банка для 1ПБ</TD>
						<TD><INPUT class="tab_main_rekv_ed_style" id="ed_KOD_B" tabIndex="5" type="text" maxLength="4" onchange="isNumberCheck(getEl('ed_KOD_B'));ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdLeader">Руководитель</TD>
						<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_RUK" tabIndex="6" type="text" maxLength="70" onchange="ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdGlBuh">Гл. бухгалтер банка</TD>
						<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_BUH" tabIndex="7" type="text" maxLength="70" onchange="ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdLeaderPhone">Телефон руководителя</TD>
						<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_TELR" tabIndex="8" type="text" maxLength="20" onchange="ToDoOnChange();"></TD>
					</TR>
					<TR>
						<TD runat="server" meta:resourcekey="tdGLBuhPhone">Телефон гл. бухгалтера</TD>
						<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_TELB" tabIndex="9" type="text" maxLength="20" onchange="ToDoOnChange();"></TD>
					</TR>
				</TABLE>
			</div>
			<input type="hidden" id="Mes01" meta:resourcekey="Mes01" runat="server" value="Сервис заблокирован. Попробуйте снова через несколько секунд." />
		    <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
		    <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
		    <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
		    <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
		    <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
		    <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
	</body>
</HTML>
