<%@ Page language="c#" CodeFile="AcrInt.aspx.cs" AutoEventWireup="false" Inherits="BarsWeb.BasicFunctions.WebForm1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Начисление процентов</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="JavaScript" src="Scripts/AcrInt.js"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<div style="BACKGROUND-COLOR: lightgrey">
				<TABLE id="T" cellSpacing="0" cellPadding="0" border="2">
					<TR>
						<TD>&nbsp;<IMG class="outset" id="btIns" title="Добавить новую запись" onclick="fnIns()" src="/Common/Images/INSERT.gif"><IMG class="outset" id="btDel" title="Удалить строку" onclick="fnDel()" src="/Common/Images/Delete.gif"
								width="16"><IMG class="outset" id="btRefresh" title="Перечитать записи в таблице" onclick="fnRefresh()"
								src="/Common/Images/Refresh.gif"><IMG class="outset" id="btSave" title="Сохранить изменения строки" onclick="fnSave()"
								height="16" src="/Common/Images/Save.gif">&nbsp;
						</TD>
						<TD>&nbsp;<IMG class="outset" id="btDetails" title="Процентная карточка счета" onclick="fnDetails()"
								height="16" src="/Common/Images/Open_.gif"><IMG class="outset" id="btFilter" title="Фильтр" onclick="fnFilter()" src="/Common/Images/FILTER_.gif"><IMG class="outset" id="btViewFile" title="Просмотр файла печати" onclick="fnViewFile()"
								height="16" src="/Common/Images/DOCVIEW.gif"><IMG class="outset" id="btBuilRep" title="Сформировать ведомость" onclick="fnBuildRep()"
								height="16" src="/Common/Images/LOGFILE.gif">&nbsp;
						</TD>
						<TD>&nbsp;<label class="BarsLabel">Начислить по</label><input id="tbDatFor" style="WIDTH: 96px; TEXT-ALIGN: center" type="text" size="10"></TD>
						<TD>&nbsp;<IMG class="outset" id="btAccrue" title="Начислить проценты по указаную дату включительно"
								onclick="fnAccrue()" src="/Common/Images/A_PROC.gif"><IMG class="outset" id="btShowProv" title="Показать проводки по %" onclick="fnShowProv()"
								src="/Common/Images/TUDASUDA.gif">
						&nbsp;
						<TD>&nbsp;<IMG class="outset" id="btProvodki" title="Выполнить проводки по %" onclick="fnProvodki()"
								src="/Common/Images/EXECUTE.gif"><IMG class="outset" id="btCompress" title="Сжатие информации" onclick="fnCompress()"
								src="/Common/Images/SUMM.gif">&nbsp;
						</TD>
						<TD>&nbsp;<IMG class="outset" id="btClose" title="Выход" onclick="goBack()" src="/Common/Images/DISCARD.gif">&nbsp;
						</TD>
					</TR>
				</TABLE>
			</div>
			<div class="webservice" id="webService" style="OVERFLOW: scroll;   ; WIDTH: expression(document.body.clientWidth-10)"
				showProgress="true"></div>
		</form>
	</body>
</HTML>
