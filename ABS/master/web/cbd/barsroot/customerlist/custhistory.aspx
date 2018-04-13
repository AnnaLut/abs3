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
		<script language="JavaScript" src="Scripts\CustHistory.js"></script>
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
			<input runat="server" type="hidden" id="Message12" meta:resourcekey="Message12" value="История изменения параметров счета:" />
			<input runat="server" type="hidden" id="Message13" meta:resourcekey="Message13" value="История изменения параметров клиента:" />
			<input runat="server" type="hidden" id="forbtRefresh" meta:resourcekey="forbtRefresh" value="Перечитать данные" />
			<input runat="server" type="hidden" id="forbtPrint" meta:resourcekey="forbtPrint" value="Печать" />
			<input runat="server" type="hidden" id="forbtClose" meta:resourcekey="forbtClose" value="Выход" />
	</body>
</HTML>
