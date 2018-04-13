<%@ Page language="c#" CodeFile="tab_contracts.aspx.cs" AutoEventWireup="false" Inherits="KP.Tab_Contracts" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
  <HEAD>
		<title>Платежи по договорам</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" Content="C#" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<LINK href="Styles.css" type="text/css" rel="stylesheet" />
		<LINK href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="/Common/Script/Localization.js"></script>
		<script language="JavaScript" src="\Common\WebGrid\Grid2005.js"></script>
        <script language="JavaScript" src="Scripts/Tab_Contracts.js"></script>
		<script language="JavaScript" src="Scripts/Common.js"></script>
		<script language="jscript" src="/Common/WebEdit/NumericEdit.js"></script>
</HEAD>
	<body onkeydown="fnHotKeyContracts()" onfocus="fnFocus()">
		<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td><asp:Label id="lbMfo" meta:resourcekey="lbMfo" runat="server" CssClass="BarsLabel">МФО:</asp:Label></td>
				<td><input type="text" runat="server" id="tbMfo" size="10"></td>
				<td><asp:Label id="lbNls" meta:resourcekey="lbNls" runat="server" CssClass="BarsLabel">Счет:</asp:Label></td>
				<td><input type="text" runat="server" id="tbNls" size="15"></td>
				<td><input type="button" runat="server" id="btFind" meta:resourcekey="btFind" value="Поиск" class="BarsLabel" style="COLOR:navy" onclick="fnFind()"></td>
				<td><img class="out" runat="server" id="btClear" meta:resourcekey="btClear" src="/Common/Images/delete.gif"
						onclick="fnClear()" width=16 alt="Очистить фильтр(Ctrl+Alt+D)"></td>
				<td><img class="out" runat="server" id="btDetail" meta:resourcekey="btDetail" src="/Common/Images/BROWSE.gif"
						onclick="fnShowDetail(this)" alt="Показать дополнительную информацию(Ctrl+Alt+S)"></td>
				<td><input type="text" runat="server" id="tbPos" size="5" onkeyup="fnFindOnPos(this)" /></td>
			</tr>
		</table>
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
		<input type="hidden" runat="server" id="fortbMfo" meta:resourcekey="fortbMfo" value="Мфо банка(Ctrl+Alt+1)" />
		<input type="hidden" runat="server" id="fortbNls" meta:resourcekey="fortbNls" value="Счет(Ctrl+Alt+2)" />
		<input type="hidden" runat="server" id="forbtFind" meta:resourcekey="forbtFind" value="Поиск (ALT+CTRL+F)" />
		<input type="hidden" runat="server" id="fortbPos" meta:resourcekey="fortbPos" value="Поиск по номеру(Ctrl+Alt+Z)" />  
		
		<input type="hidden" runat="server" id="Mes25" meta:resourcekey="Mes25" value="Несуществующий МФО!" />
		<input type="hidden" runat="server" id="Mes26" meta:resourcekey="Mes26" value="Неверный контрольный разряд!" />
		<input type="hidden" runat="server" id="Mes30" meta:resourcekey="Mes30" value="Для даного отделения не задан параметр NLS2902 (справочник TOBO_PARAMS)" />
		<input type="hidden" runat="server" id="Mes31" meta:resourcekey="Mes31" value="Счет " />
		<input type="hidden" runat="server" id="Mes32" meta:resourcekey="Mes32" value="не найден(параметр NLS2902 из справочника TOBO_PARAMS)" />
		
		<div class="webservice" id="webService" showProgress="true"></div>
		<script language="javascript">
		LocalizeHtmlTitle('tbMfo');
		LocalizeHtmlTitle('tbNls');
		LocalizeHtmlTitle('btFind');
		LocalizeHtmlTitle('tbPos');
		</script>
	</body>
</HTML>
