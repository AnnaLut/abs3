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
    </form>
</body>
</html>
