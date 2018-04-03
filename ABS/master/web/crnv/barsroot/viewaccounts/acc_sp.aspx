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
    <script type="text/javascript" src="Scripts/SP.js?v1.1"></script>
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
    <!-- #include file="/Common/Include/Localization.inc"-->
    <!-- #include file="/Common/Include/WebGrid2005.inc"-->
    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
    <input runat="server" type="hidden" id="Message34" meta:resourcekey="Message34" value="Вы ввели недопустимое значение!" />
</body>
</html>
