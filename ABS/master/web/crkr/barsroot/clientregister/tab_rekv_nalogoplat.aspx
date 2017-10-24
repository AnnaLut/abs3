<%@ Page language="c#" Inherits="clientregister.tab_rekv_nalogoplat" CodeFile="tab_rekv_nalogoplat.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title>Реквизиты налоплатильщика</title>
		<LINK href="DefaultStyleSheet.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="/Common/Script/Localization.js"></script>
        
        <link href="../Content/Themes/ModernUI/css/Style.css" rel="stylesheet" />
        <link href="../Content/Themes/ModernUI/css/jquery-ui.css" rel="stylesheet" />  
        <link href="../Content/Themes/ModernUI/css/buttons.css" rel="stylesheet" />
        <link href="../content/themes/modernui/css/tiptip.css" rel="stylesheet" />
        
        <script type="text/javascript" src="../Scripts/html5shiv.js"></script>
        
        <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="../scripts/jquery/jquery.maskMoney.js"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery.numbermask.js"></script>
        <script type="text/javascript" src="../scripts/jquery/jquery.maskedinput-1.3.1.js"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
        <script type="text/javascript" src="../Content/Themes/ModernUI/scripts/jquery.tiptip.js"></script>

		<script type="text/javascript" src="JScriptFortab_rekv_nalogoplat.js?v1.1"></script>
		<script type="text/javascript" src="additionalFuncs.js"></script>
	</HEAD>
	<body onload="InitObjects()">
      <style type="text/css">
  	    div.required {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }
  	  </style>
        <div style="padding: 10px">
            
		<TABLE class="tab_rekv_nalogoplat_tb_main" id="tb_main" cellSpacing="1" cellPadding="0">
			<TR>
				<TD style="PADDING-LEFT: 20px; HEIGHT: 30px" align="left">
				  <input id="ckb_main" onclick="MyChengeEnable(this.checked);ToDoOnChange();"
				         tabIndex="1" type="checkbox" checked runat="server" />
					<label for="ckb_main" runat="server" meta:resourcekey="divNal" class="simpleTextStyle" style="DISPLAY: inline">Заполнять реквизиты Налогоплательщика</label>
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
							<TD><SELECT class="tab_main_rekv_ed2_style" id="ddl_C_DST" tabIndex="3" onchange="ToDoOnChange();">
									<OPTION selected></OPTION>
								</SELECT></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdAdm">Адм. орган регистрации</TD>
							<TD>
							  <INPUT class="tab_main_rekv_ed2_style" id="ed_ADM" tabIndex="4" type="text" maxLength="70" onchange="ToDoOnChange();">
                              <div id="lb_3" class="required">*</div>
							</TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdRegNumInAdm">Рег. номер в Адм.</TD>
							<TD>
							  <INPUT class="tab_main_rekv_ed2_style" id="ed_RGADM" tabIndex="5" type="text" maxLength="30" onchange="ToDoOnChange();">
							</TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdRegNumInNI">Рег. номер в ПІ</TD>
							<TD>
							  <INPUT class="tab_main_rekv_ed2_style" id="ed_RGTAX" tabIndex="6" type="text" maxLength="30" onchange="ToDoOnChange();">
                              <div id="lb_4" class="required">*</div>
							</TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="tdNalCode">Налоговый код (К050)</TD>
							<TD><INPUT class="tab_main_rekv_ed_style" id="ed_TAXF" tabIndex="7" type="text" maxLength="12" onblur="isNumberCheck(document.getElementById('ed_TAXF'));ToDoOnChange();"></TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="RegDateInNI">Дата рег. в НИ</TD>
							<TD>
							  <INPUT class="edit date" id="ed_DATET" title="Формат: dd.mm.yyyy или /" tabIndex="8"
									type="text" maxLength="10" onchange="this.value = this.value.replace('/','.');ToDoOnChange();" onblur="isDateCheck(document.getElementById('ed_DATET'))">
                              <div id="lb_1" class="required">*</div>
							</TD>
						</TR>
						<TR>
							<TD runat="server" meta:resourcekey="RegDateInAdm">Дата рег. в Адм.</TD>
							<TD>
							    <INPUT class="edit date" id="ed_DATEA" title="Формат: dd.mm.yyyy или /" tabIndex="9"
									type="text" maxLength="10" onchange="this.value = this.value.replace('/','.');ToDoOnChange();" onblur="isDateCheck(document.getElementById('ed_DATEA'))">
                              <div id="lb_2" class="required">*</div>
							</TD>
						</TR>
					</TABLE>
				</TD>
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
