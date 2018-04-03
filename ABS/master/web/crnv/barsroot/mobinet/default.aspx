<%@ Page language="c#" CodeFile="Default.aspx.cs" AutoEventWireup="false" Inherits="mobinet.Default" description="Пополнение счета мобильных операторов" enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Mobinet system</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<LINK href="ws.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="util.js"></script>
		<link href="/Common/CSS/AppCSS.css" type="text/css" rel=Stylesheet />
		<script language="javascript">
		      <!--
		       function test() {		         
				 return true;
		       }		       		       		       
		      //-->
		</script>
	</HEAD>
	<body onbeforeunload="Dispose()" onload="Init(document.getElementById('id_phone'))">
		<div class="webservice" id="webServiceSync"></div>
		<div class="webservice" id="webServiceAsync"></div>
		<form language="javascript" id="MobinetForm" onreset="return do_reset();" onsubmit="return do_submit();"
			action="Default.aspx" method="post" runat="server">
			<TABLE id="CenteringTable" height="100%" width="100%">
				<TR>
					<TD vAlign="top" align="right" height="30%">
						<TABLE id="TopTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD align="left" width="50%"><span style="FONT-SIZE: x-small">Дата валютирования&nbsp;</span>
									<asp:textbox id="inputValDate" runat="server" CssClass="centerme" Wrap="False" MaxLength="10"
										EnableViewState="False" Width="85px" Font-Size="X-Small" ReadOnly="True"></asp:textbox></TD>
								<TD align="right" width="50%"><A title="Установить другую кассу" style="FONT-SIZE: x-small" href="/barsweb/SetUserCash.aspx">Касса</A>&nbsp;
									<asp:textbox id="inputCash" runat="server" CssClass="centerme" Wrap="False" ToolTip="Активная касса"
										MaxLength="15" EnableViewState="False" Width="115px" Font-Size="X-Small" ReadOnly="True"></asp:textbox></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="HeadTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD style="FONT-WEIGHT: bold" align="center">Пополнение счета ЗАО Киевстар™</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="MainTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD class="cell_label" align="left">№ телефона</TD>
								<TD style="WIDTH: 130px" align="center"><INPUT class="input_style" onkeypress="return validatePhone(form, document.getElementById('id_phone'), form.id_sum, form.id_name, event);"
										id="id_phone" onblur="blurPhone(form, document.getElementById('id_phone'), form.id_sum, form.id_name, 'phone_validator', event);" style="TEXT-ALIGN: right"
										tabIndex="1" type="text" maxLength="9" align="center" name="id_phone">
								</TD>
								<TD class="asterisk" align="left">&nbsp;* <span id="phone_validator" style="FONT: statusbar; COLOR: red">
									</span>
								</TD>
							</TR>
							<TR>
								<TD class="cell_label" align="left">Сумма грн.</TD>
								<TD style="WIDTH: 130px" align="center"><INPUT class="input_style" onkeypress="return validateSum(form, form.id_sum, form.id_name, event);"
										id="id_sum" onblur="blurSum(form, form.id_sum, form.id_name, 'sum_validator', event);" style="TEXT-ALIGN: right" tabIndex="2"
										type="text" maxLength="19" name="id_sum">
								</TD>
								<TD class="asterisk" align="left">&nbsp;* <span id="sum_validator" style="FONT: statusbar; COLOR: red">
									</span>
								</TD>
							</TR>
							<TR>
								<TD class="cell_label" align="left">Ф.И.О.</TD>
								<TD style="WIDTH: 130px" align="center"><INPUT class="input_style" onkeypress="return validateName(form, form.id_name, form.id_pay, event);"
										id="id_name" tabIndex="3" type="text" maxLength="256" name="id_name" autocomplete="on">
								</TD>
								<TD></TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="ButtonTable" cellSpacing="0" cellPadding="0" width="260" border="0">
							<TR>
								<TD class="cell_label" align="right"><INPUT id="id_pay" tabIndex="4" type="submit" value="Оплата">&nbsp;
								</TD>
								<TD style="WIDTH: 130px" align="left"><INPUT id="id_reset" tabIndex="5" type="reset" value="Отмена">
								</TD>
								<TD style="WIDTH: 130px" align="left"><INPUT id="id_state" tabIndex="6" type="button" value="Состояние" onclick="do_state();">
								</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="InfoTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD align="left">
									<div style="FONT: statusbar; COLOR: red">* - обязательные для заполнения поля</div>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD height="70%"></TD>
				</TR>
			</TABLE>
			<INPUT id="hMobiTrans" type="hidden" name="hMobiTrans"> <INPUT id="hMobiCheque" type="hidden" name="hMobiCheque">
			<INPUT id="hBankRef" type="hidden" name="hBankRef">
		</form>
	</body>
</HTML>
