<%@ Page language="c#" Codefile="Replication.aspx.cs" AutoEventWireup="false" Inherits="Replication"  enableViewState="False"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Replication</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<style>
		.webservice { BEHAVIOR: url(/Common/WebService/js/WebService.htc) }
		.InfoHeader { FONT-SIZE: 12pt; WIDTH: 100%; FONT-FAMILY: Arial }
		.InfoText { FONT-SIZE: 10pt; WIDTH: 100%; FONT-FAMILY: Arial }
		.AcceptButton { FONT-SIZE: 10pt; WIDTH: 200px; FONT-FAMILY: Arial }
		.InnerTable { BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT: 0px; WIDTH: 100% }
		</style>
		<script language="javascript" src="js/repl.js"></script>
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
		<script language="Javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>
	</HEAD>
	<body onbeforeunload="Dispose();">
		<form id="Form1" method="post" runat="server">
			<TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD align="center"><asp:label id="lbTitle" meta:resourcekey="lbTitle" runat="server" CssClass="InfoHeader" Font-Bold="True" Font-Italic="True">Синхронизация баз</asp:label></TD>
				</TR>
				<TR>
					<TD align="center"></TD>
				</TR>
				<TR>
					<TD><INPUT class="AcceptButton" runat="server" id="btReplicate" meta:resourcekey="btReplicate" onclick="Init();Begin();" type="button" value="Выполнить синхронизацию"
							name="Button1">
					</TD>
				</TR>
				<TR>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						<TABLE class="InnerTable" id="tbStatus">
							<TR>
								<TD style="HEIGHT: 17px" width="25%"><asp:label id="lbRequest" meta:resourcekey="lbRequest" runat="server" CssClass="InfoText">Дата запроса</asp:label></TD>
								<TD style="HEIGHT: 17px" width="25%"><asp:label id="lbBegin" meta:resourcekey="lbBegin" runat="server" CssClass="InfoText">Дата начала репликации</asp:label></TD>
								<TD style="HEIGHT: 17px" width="25%"><asp:label id="lbEnd" meta:resourcekey="lbEnd" runat="server" CssClass="InfoText">Дата завершения репликации</asp:label></TD>
								<TD style="HEIGHT: 17px" width="25%"><asp:label id="lbStatus" meta:resourcekey="lbStatus" runat="server" CssClass="InfoText">Статус репликации</asp:label></TD>
							</TR>
							<TR>
								<TD><INPUT class="InfoText" id="textRequest" readOnly type="text"></TD>
								<TD><INPUT class="InfoText" id="textBegin" readOnly type="text" name="Text1"></TD>
								<TD><INPUT class="InfoText" id="textEnd" readOnly type="text" name="Text2"></TD>
								<TD><INPUT class="InfoText" id="textStatus" readOnly type="text" name="Text3"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
					</TD>
				</TR>
			</TABLE>
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
			<DIV class="webservice" id="webService" showProgress="false"></DIV>
		</form>
	</body>
</HTML>
