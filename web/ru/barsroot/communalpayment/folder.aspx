<%@ Page language="c#" CodeFile="folder.aspx.cs" AutoEventWireup="false" Inherits="CommunalPayment.Folder" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Просмотр пачки</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="Styles.css" type="text/css" rel="stylesheet">
		<LINK href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="/Common/WebGrid/Grid2005.js"></script>
		<script language="JavaScript" src="Scripts/Folder.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
	</HEAD>
	<body onfocus="fnFocus()">
		<table cellSpacing="0" cellPadding="0" border="0">
			<tr>
				<td><IMG runat="server" meta:resourcekey="btSelectAll" class="out" id="btClear" alt="Выделить все(Ctrl+Alt+A)" onclick="fnSelAll()" src="/Common/Images/CHEKIN.gif"
						width="16">
				<td>&nbsp;<label runat="server" meta:resourcekey="lbP" class="BarsLabel" style="COLOR: maroon">Пачка:</label>
				</td>
				<td><label class="BarsLabel" id="pName" style="COLOR: navy"></label></td>
			</tr>
		</table>
		<div class="webservice" id="webService" showProgress="true"></div>
		<div align=center>
		<INPUT class="bt" runat="server" id="btSave" meta:resourcekey="btSave" style="WIDTH: 80px; HEIGHT: 18px" onclick="Applay()" type="button"
				value="Принять" name="btSave">&nbsp;&nbsp;
		<INPUT class="bt" runat="server" meta:resourcekey="btCancel" style="WIDTH: 80px; HEIGHT: 18px" onclick="Close()" type="button" value="Отмена">
		</div>
		<input type="hidden" runat="server" id="titleFolder" meta:resourcekey="titleFolder" value="Просмотр пачки" />
		<input type="hidden" runat="server" id="Mes28" meta:resourcekey="Mes28" value="Не задан код пачки!" />
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
	</body>
	<script language="javascript">
		window.document.title = LocalizedString('titleFolder');
	</script>
</HTML>
