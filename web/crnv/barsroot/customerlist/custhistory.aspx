<%@ Page language="c#" CodeFile="custhistory.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.CustHistory" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Історія зміни параметрів</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="Scripts\Common.js"></script>
		<script language="JavaScript" src="Scripts\CustHistory.js?v.1.0.1"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="javascript">
		 window.onload = InitCustHistory;
	     var image1 = new Image(); image1.src="/Common/Images/REFRESH.gif";
	     var image3 = new Image(); image3.src="/Common/Images/DISCARD.gif";
	     </script>
	</HEAD>
	<body>
			<span  id="lbHist" style="font-family:Verdana;font-size:8pt;COLOR:navy"></span><span id="lbNmk" style="font-family:Verdana;font-size:8pt;COLOR:maroon"></span>
			<TABLE id="T1" cellSpacing="1" cellPadding="1" border="1">
				<TR>
					<TD><span runat="server" meta:resourcekey="spFrom">C </span><INPUT id="date1" type="text" size="10" style="text-align: center"></TD>
					<TD><span runat="server" meta:resourcekey="spTill">По </span><INPUT id="date2" type="text" size="10" style="text-align: center"></TD>
					<TD>&nbsp;<SELECT id="cmb1" style="WIDTH: 150px" onchange="getValueForCmd1(this)">
							<OPTION selected>Все</OPTION>
							<OPTION>...</OPTION>
						</SELECT>&nbsp;</TD>
					<TD>&nbsp;<SELECT id="cmb2" style="WIDTH: 150px" disabled onclick="d_dlg(this)">
							<OPTION selected>Все</OPTION>
						</SELECT></TD>
					<TD><IMG class="outset" id="btRefresh" title="Перечитать данные" onclick="fnRefreshHist()"></TD>
					<TD><IMG class="outset" id="btClose" onclick="goBack()"></TD>
				</TR>
			</TABLE>
			<div class="webservice" id="webService" showProgress="true"></div>
			<!-- #include file="/Common/Include/Localization.inc"-->
			<!-- #include file="/Common/Include/WebGrid2005.inc"-->   
			<input runat="server" type="hidden" id="Message12" meta:resourcekey="Message12" value="История изменения параметров счета:" />
			<input runat="server" type="hidden" id="Message13" meta:resourcekey="Message13" value="История изменения параметров клиента:" />
			<input runat="server" type="hidden" id="forbtRefresh" meta:resourcekey="forbtRefresh" value="Перечитать данные" />
			<input runat="server" type="hidden" id="forbtPrint" meta:resourcekey="forbtPrint" value="Печать" />
			<input runat="server" type="hidden" id="forbtClose" meta:resourcekey="forbtClose" value="Выход" />
	</body>
</HTML>
