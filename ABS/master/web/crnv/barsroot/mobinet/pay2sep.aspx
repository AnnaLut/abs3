<%@ Page language="c#" CodeFile="Pay2SEP.aspx.cs" AutoEventWireup="false" Inherits="mobinet.Pay2SEP" enableViewState="False"%>
<%@ Register TagPrefix="igtxt" Namespace="Infragistics.WebUI.WebDataInput" Assembly="Infragistics.WebUI.WebDataInput.v1, Version=1.0.20041.14, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Pay2SEP</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="ws.css" type="text/css" rel="stylesheet">
		<link href="/Common/CSS/AppCSS.css" type="text/css" rel=Stylesheet />
		<script language="JavaScript" src="util.js"></script>
		<script language="javascript">
		      <!--
		      //-->
		</script>
	</HEAD>
	<body onbeforeunload="Dispose()" onload="Init(document.FormMain.makepay);InitDoc();">
		<div class="webservice" id="webServiceSync"></div>
		<div class="webservice" id="webServiceAsync"></div>
		<div class="webservice" id="webServiceDoc"></div>
		<form id="FormMain" method="post" runat="server">
			<TABLE id="TableMain" cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
				<TR>
					<TD height="30%"></TD>
				</TR>
				<TR>
					<TD align="center">
						<TABLE id="HeadTable" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<TR>
								<TD style="FONT-WEIGHT: bold" align="center">Формирование платежей СЭП в пользу 
									Киевстар™:</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="MainTable" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD width="163" align="left" style="WIDTH: 183px">Дата начала периода</TD>
								<TD style="WIDTH: 130px" align="center">
									<igtxt:WebDateTimeEdit id="date1" tabIndex="1" runat="server" HorizontalAlign="Center" EditModeFormat="dd.MM.yyyy"
										DisplayModeFormat="dd.MM.yyyy" HideEnterKey="True" EnableViewState="False" Width="130px"></igtxt:WebDateTimeEdit>
								</TD>
							</TR>
							<TR>
								<TD width="163" align="left" style="WIDTH: 183px">Дата окончания периода</TD>
								<TD style="WIDTH: 130px" align="center">
									<igtxt:WebDateTimeEdit id="date2" runat="server" Width="130px" EnableViewState="False" HideEnterKey="True"
										DisplayModeFormat="dd.MM.yyyy" EditModeFormat="dd.MM.yyyy" HorizontalAlign="Center" tabIndex="1"></igtxt:WebDateTimeEdit>
								</TD>
							</TR>
						</TABLE>
						<BR>
						<TABLE id="ButtonTable" cellSpacing="0" cellPadding="0" width="260" border="0">
							<TR>
								<TD class="cell_label" align="center">
									<INPUT id="makepay" tabIndex="2" type="submit" value="Сформировать" onclick="MakeSEPPayment(document.FormMain.date1_t.value,document.FormMain.date2_t.value);return false;">
								</TD>
							</TR>
						</TABLE>
						<BR>
					</TD>
				</TR>
				<TR>
					<TD height="70%"></TD>
				</TR>
			</TABLE>
			<asp:HiddenField ID="hd_signtype" runat="server" EnableViewState="False" />
			<asp:HiddenField ID="hd_bankdate" runat="server" EnableViewState="False" />
			<asp:HiddenField ID="hd_regncode" runat="server" EnableViewState="False" />
		</form>        
	</body>
</HTML>
