<%@ Page Language="c#" Inherits="barsroot.udeposit.Default" CodeFile="default.aspx.cs"
    AutoEventWireup="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Депозити юридичних осіб. Депозитний портфель</title>
    <meta content="C#" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="Javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="JavaScript" src="/Common/WebGrid/Grid2005.js?v1.0"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Default.js?v1.1"></script>
    <script type="text/javascript" language="JavaScript" src="Scripts/Common.js?v1.0"></script>
</head>
<body>
    <div style="background-color: lightgrey">
        <table id="T" cellspacing="0" cellpadding="0" border="2">
            <tr>
                <td>
                    &nbsp;
                    <img class="outset" id="btIns" title="Відкрити новий договір " alt=""
                        onclick="fnIns()" src="/Common/Images/INSERT.gif" />
                    <img class="outset" id="btClose" title="Закрити договір " alt=""
                        onclick="fnClose()" src="/Common/Images/DELREC.gif" />
                    <img class="outset" id="btRefresh" title="Перечитати записи в таблиці " alt=""
                        onclick="fnRefresh()" src="/Common/Images/REFRESH.gif" />
                    &nbsp;
                </td>
                <td>
                    <img class="outset" id="btShow" title="Показати/сховати закриті договора" alt=""
                        onclick="fnShow()" src="/Common/Images/SHOW.gif" style="border-top-style: outset" />
                </td>
                <td>
                    &nbsp;
                    <img class="outset" id="btFilter" title="Встановити фільтр"  alt=""
                        onclick="ShowModalFilter()" src="/Common/Images/FILTER_.gif" />
                    <img class="outset" id="btPrint" title="Друк" alt=""
                        onclick="printTable()" src="/Common/Images/PRINT.gif" style="visibility: visible" />
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                    <img class="outset" id="btParam" title="Параметри договору"  alt=""
                        onclick="fnShowParam()" height="16" src="/Common/Images/OPEN_.gif" />
                    <img class="outset" id="btState" title="Поточний стан договору" alt=""
                        onclick="fnShowState()" height="16" src="/Common/Images/DOCVIEW.gif" />
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div class="webservice" id="webService" showprogress="true">
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
</body>
</html>
