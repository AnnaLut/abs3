<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CardIndex.aspx.cs" Inherits="CardIndex" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
	<LINK href="Styles.css" type="text/css" rel="stylesheet">
	<LINK href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="/Common/Css/AppCSS.css" type="text/css" rel="stylesheet">
	<script language="Javascript" src="/Common/Script/Localization.js"></script>
	<script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>
    <script language="JavaScript" src="Scripts/CardIndex.js"></script>
	<script language="JavaScript" src="Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <span style="font-weight: bold; color: activecaption; font-family: Verdana">Картотека поступлений на консолидированные балансовые счета (тип NL8)</span>
    <div style="BACKGROUND-COLOR: lightgrey">
		<TABLE id="T" cellSpacing="0" cellPadding="0" border="2" style="width:auto">
			<TR>
				<TD><IMG class="outset" id="btSeize" title="Изъять из картотеки" onclick="fnSeize()" src="/Common/Images/DELREC.gif"><IMG class="outset" id="btRefresh" title="Перечитать записи в таблице" onclick="fnRefresh()"
						src="/Common/Images/REFRESH.gif"><IMG class="outset" id="btRegister" title="Провести сумму по внесистемному счету" onclick="fnRegister()" src="/Common/Images/SAVE.gif"><IMG class="outset" id="btViewDoc" title="Просмотреть выбранный документ" onclick="fnViewDoc()" height="16"
						src="/Common/Images/OPEN_.gif">&nbsp;</TD>
				<TD>&nbsp;<IMG class="outset" id="tbExit" title="Выход" onclick="goBack()" src="/Common/Images/DISCARD.gif">&nbsp;</TD>
			</TR>
		</TABLE>
	</div>
    <div>
	<div class="webservice" id="webService" style="text-align:center; OVERFLOW: auto; WIDTH: 100%; height: 250px;"
	showProgress="true"></div>
	<div id="Div1" style="cursor:hand; text-align:center; OVERFLOW: auto; WIDTH: 100%;">
	
	<table id="secondTable">
	  <tr>
	    <th width='5%'  title="Валюта">Вал</th>
	    <th width='15%' title="Лицевой счет">Лиц. счет</th>
	    <th width='60%' title="Наименование счета">Наименование счета</th>
	    <th width='10%' title="Фактический остаток">Факт. остаток</th>
	    <th width='10%' title="Плановый остаток">План. остаток</th>
	  </tr>
	</table>
	</div>
    </div>
    	<!-- #include file="/Common/Include/Localization.inc"-->
		<!-- #include file="/Common/Include/WebGrid2005.inc"-->  
    </form>
</body>
</html>
