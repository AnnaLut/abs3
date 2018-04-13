<%@ Page language="c#" Inherits="clientregister.tab_client_rekv_corp" CodeFile="tab_client_rekv_corp.aspx.cs" %>
<%@ Register TagPrefix="igtbl" Namespace="Infragistics.WebUI.UltraWebGrid" Assembly="Infragistics.WebUI.UltraWebGrid.v3, Version=3.0.20041.11, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Реквизиты клиента "Юр. лицо"</title>
		<LINK href="DefaultStyleSheet.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript" src="additionalFuncs.js"></script>
		<script language="javascript" src="JScriptFortab_client_rekv_corp.js"></script>
	</HEAD>
	<body onload="InitObjects()">
		<form id="mainForm" runat="server">
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td>
									<TABLE id="tb_main" style="FONT-SIZE: 10pt; FONT-FAMILY: Arial; TEXT-ALIGN: left" cellSpacing="0"
										border="0">
										<TR>
											<TD runat="server" meta:resourcekey="tdEntName" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Наименование по уставу</TD>
											<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_NMKU" tabIndex="1" type="text" maxLength="70"
													onchange="ToDoOnChange();" /></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdLeader" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Руководитель</TD>
											<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_RUK" tabIndex="2" type="text" maxLength="70"
													onchange="ToDoOnChange()"></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdGlBuh" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Гл. бухгалтер</TD>
											<TD><INPUT class="tab_main_rekv_ed2_style" id="ed_BUH" tabIndex="3" type="text" maxLength="70"
													onchange="ToDoOnChange();"></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdLeaderPhone" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Телефон руководителя</TD>
											<TD><INPUT class="tab_main_rekv_ed_style" id="ed_TELR" tabIndex="4" type="text" maxLength="20"
													onchange="ToDoOnChange();"></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdGLBuhPhone" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Телефон гл. бухгалтера</TD>
											<TD><INPUT class="tab_main_rekv_ed_style" id="ed_TELB" tabIndex="5" type="text" maxLength="20"
													onchange="ToDoOnChange();"></TD>
										</TR>
										<TR>
											<TD style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>E-mail</TD>
											<TD><INPUT class="tab_main_rekv_ed_style" id="ed_E_MAIL" tabIndex="6" type="text" onchange="ToDoOnChange();"></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdFax" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Факс</TD>
											<TD><INPUT class="tab_main_rekv_ed_style" id="ed_TEL_FAX" tabIndex="7" type="text" maxLength="20"
													onchange="ToDoOnChange();"></TD>
										</TR>
										<TR>
											<TD runat="server" meta:resourcekey="tdIdImg" style="PADDING-RIGHT: 3px; PADDING-LEFT: 3px" noWrap>Ид. графического образа печати
											</TD>
											<TD><INPUT class="tab_main_rekv_ed_style" id="ed_SEAL_ID" onclick="ShowSealHelp()" tabIndex="7"
													readOnly type="text"></TD>
										</TR>
									</TABLE>
								</td>
								<td vAlign="middle" align="center" width="100%"><IMG id="img_picture" height="100" src="pictureFile.aspx?id=0">
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<TABLE id="Table1" height="100%" cellSpacing="0" cellPadding="0" width="100%">
							<tr>
								<td runat="server" meta:resourcekey="tdCurAcc" style="FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: darkblue; FONT-FAMILY: Arial; TEXT-ALIGN: center">Текущие счета</td>
							</tr>
							<TR>
								<TD style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; WIDTH: 100%"
									height="20">
									<TABLE id="Table2" width="100%">
										<TR>
											<TD meta:resourcekey="tdAdd" id="td_add_accs" style="FONT-SIZE: 10pt; WIDTH: 64px; CURSOR: hand; COLOR: darkgreen; FONT-FAMILY: Arial; TEXT-DECORATION: underline"
												onclick="MyAddRow('grdACCS');ToDoOnChange();" runat="server">Добавить</TD>
											<TD meta:resourcekey="tdDel" id="td_del_accs" style="FONT-SIZE: 10pt; CURSOR: hand; COLOR: darkred; FONT-FAMILY: Arial; TEXT-DECORATION: underline"
												onclick="MyDeleteRow('grdACCS');ToDoOnChange();" runat="server">Удалить
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
							<TR>
								<TD style="BORDER-RIGHT: black 1px solid; BORDER-LEFT: #000000 1px solid; WIDTH: 100%; BORDER-BOTTOM: black 1px solid"
									vAlign="top"><igtbl:ultrawebgrid id="grdACCS" runat="server" Height="60px" Width="100%">
										<DisplayLayout ColWidthDefault="25%" AutoGenerateColumns="False" RowHeightDefault="20px" Version="3.00"
											BorderCollapseDefault="Separate" Name="grdACCS" CellClickActionDefault="Edit">
											<AddNewBox>
												<Style BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">

<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White">
</BorderDetails>

												</Style>
											</AddNewBox>
											<Pager>
												<Style BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">

<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White">
</BorderDetails>

												</Style>
											</Pager>
											<HeaderStyleDefault BorderStyle="Solid" BackColor="LightGray">
												<Padding Left="2px" Right="2px"></Padding>
												<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
											</HeaderStyleDefault>
											<FrameStyle Width="100%" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="Solid"
												Height="60px"></FrameStyle>
											<FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
												<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
											</FooterStyleDefault>
											<ClientSideEvents BeforeCellChangeHandler="MyBeforeCellChange" BeforeEnterEditModeHandler="MyBeforeEnterEditMode"></ClientSideEvents>
											<EditCellStyleDefault BorderWidth="0px" BorderStyle="None"></EditCellStyleDefault>
											<RowStyleDefault BorderWidth="1px" BorderColor="Gray" BorderStyle="Solid">
												<Padding Left="3px"></Padding>
												<BorderDetails WidthLeft="0px" WidthTop="0px"></BorderDetails>
											</RowStyleDefault>
										</DisplayLayout>
										<Bands>
											<igtbl:UltraGridBand AllowColSizing="Free">
												<Columns>
													<igtbl:UltraGridColumn Key="ID" Hidden="True" BaseColumnName="ID"></igtbl:UltraGridColumn>
													<igtbl:UltraGridColumn HeaderText="МФО Банка" Key="MFO" BaseColumnName="MFO"></igtbl:UltraGridColumn>
													<igtbl:UltraGridColumn HeaderText="Номер Счета" Key="NLS" BaseColumnName="NLS"></igtbl:UltraGridColumn>
													<igtbl:UltraGridColumn HeaderText="Код Валюты" Key="KV" BaseColumnName="KV">
														<CellStyle HorizontalAlign="Center"></CellStyle>
													</igtbl:UltraGridColumn>
													<igtbl:UltraGridColumn HeaderText="Комментарий" Key="COMMENTS" BaseColumnName="COMMENTS">
														<CellStyle HorizontalAlign="Center"></CellStyle>
													</igtbl:UltraGridColumn>
												</Columns>
											</igtbl:UltraGridBand>
										</Bands>
									</igtbl:ultrawebgrid></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<input type="hidden" id="Mes01" meta:resourcekey="Mes01" runat="server" value="Сервис заблокирован. Попробуйте снова через несколько секунд." />
		    <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
		    <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
		    <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
		    <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
		    <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
		    <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
		</form>
	</body>
</HTML>
