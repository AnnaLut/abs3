<%@ Page Language="c#" CodeFile="acc_sp.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Tab4"
    EnableViewState="false" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title></title>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/WebGrid/Grid2005.js"></script>
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="Scripts/Common.js"></script>
    <script type="text/javascript" src="Scripts/SP.js?v1.2"></script>
</head>
<body onload="InitSP()">
    <span class="CheckBox">
        <input id="cbSPOpt" type="checkbox" name="cbSPOpt" checked="checked" /><label runat="server"
            for="cbSPOpt" meta:resourcekey="cbSPOpt">Проверять заполнение обязательных спецпараметров</label></span>
    <div runat="server" id="hintDiv" meta:resourcekey="ToolTip5" align="center" class="hint">
        Двойной клик по строке - изменение значения</div>
    <div id="dvButtons2">
    </div>
    <table id="tabButtons"></table>
    <div class="webservice" id="webService" showprogress="true" style="overflow:auto; height:372px">
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
    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
    <input runat="server" type="hidden" id="Message34" meta:resourcekey="Message34" value="Вы ввели недопустимое значение!" />
</body>
</html>
