<%@ Page Language="c#" CodeFile="custhistory.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.CustHistory" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Історія зміни параметрів</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="Styles.css" type="text/css" rel="stylesheet">
    <link href="\Common\WebGrid\Grid.css" type="text/css" rel="stylesheet">
    <link href="../lib/alertify/css/alertify.core.css" rel="stylesheet" />
    <link href="../lib/alertify/css/alertify.default.css" rel="stylesheet" />
    <link href="/Common/CSS/jquery/jquery.1.8.css?v1.1" type="text/css" rel="stylesheet" />
    <link href="/barsroot/cim/style/cim.css?v1.1" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery-ui.1.8.js"></script>
    <script type="text/javascript" language="javascript" src="../lib/alertify/js/alertify.min.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/jquery/jquery.ui.datepicker-uk.js"></script>
    <script type="text/javascript" language="javascript" src="Scripts\Common.js?v.1.23"></script>
    <script type="text/javascript" language="javascript" src="Scripts\CustHistory.js?v.1.0"></script>
    <script type="text/javascript" language="javascript" src="\Common\WebGrid\Grid2005.js"></script>
    <script type="text/javascript" language="javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" language="javascript">
        window.onload = InitCustHistory;
        var image1 = new Image(); image1.src = "/Common/Images/REFRESH.gif";
        var image3 = new Image(); image3.src = "/Common/Images/DISCARD.gif";
    </script>
</head>
<body>
    <span id="lbHist" style="font-family: Verdana; font-size: 8pt; color: navy"></span><span id="lbNmk" style="font-family: Verdana; font-size: 8pt; color: maroon"></span>
    <table id="T1" cellspacing="1" cellpadding="1" border="1">
        <tr>
            <td><span runat="server" meta:resourcekey="spFrom">C </span>
                <input id="date1" type="text" size="10" style="text-align: center" class="ctrl-date"></td>
            <td><span runat="server" meta:resourcekey="spTill">По </span>
                <input id="date2" type="text" size="10" style="text-align: center" class="ctrl-date"></td>
            <td>&nbsp;<select id="cmb1" style="width: 150px" onchange="getValueForCmd1(this)">
                <option selected>Все</option>
                <option>...</option>
            </select>&nbsp;</td>
            <td>&nbsp;<select id="cmb2" style="width: 150px" disabled onclick="d_dlg(this)">
                <option selected>Все</option>
            </select></td>
            <td>
                <img class="outset" id="btRefresh" title="Перечитать данные" onclick="fnRefreshHist()"></td>
            <td>
                <img class="outset" id="btClose" onclick="goBack()"></td>
        </tr>
    </table>
    <div class="webservice" id="webService" showprogress="true"></div>
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
</html>
