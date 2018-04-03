<%@ Page Language="c#" Inherits="barsroot.udeposit.Default" CodeFile="default.aspx.cs"
    AutoEventWireup="false" meta:resourcekey="PageResource1" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Депозити юридичних осіб. Депозитний портфель</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="Styles.css" type="text/css" rel="stylesheet">
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">

    <script language="Javascript" src="/Common/Script/Localization.js"></script>

    <script language="JavaScript" src="/Common/WebGrid/Grid2005.js?v1.0"></script>

    <script language="JavaScript" src="Scripts/Default.js?v1.0"></script>

    <script language="JavaScript" src="Scripts/Common.js?v1.0"></script>

</head>
<body>
    <div style="background-color: lightgrey">
        <table id="T" cellspacing="0" cellpadding="0" border="2">
            <tr>
                <td>
                    <img class="outset" id="btIns" title="Відкрити новий договір " onclick="fnIns()"
                        src="/Common/Images/INSERT.gif"><img class="outset" id="btClose" title="Закрити договір"
                            onclick="fnClose()" src="/Common/Images/DELREC.gif"><img class="outset" id="btRefresh"
                                title="Перечитати записи в таблиці" onclick="fnRefresh()" src="/Common/Images/REFRESH.gif">&nbsp;
                </td>
                <td>
                    <img class="outset" id="btShow" title="Показати/сховати закриті договора" style="border-top-style: outset"
                        onclick="fnShow()" src="/Common/Images/SHOW.gif">
                </td>
                <td>
                    &nbsp;<img class="outset" id="btFilter" title="Встановити фільтр" onclick="ShowModalFilter()"
                        src="/Common/Images/FILTER_.gif"><img class="outset" id="btPrint" title="Друк" src="/Common/Images/PRINT.gif"
                            onclick="printTable()" style="visibility:hidden">&nbsp;
                </td>
                <td>
                    &nbsp;<img class="outset" id="btParam" title="Параметри договору" onclick="fnShowParam()"
                        height="16" src="/Common/Images/OPEN_.gif"><img class="outset" id="btState" title="Поточний стан договору"
                            onclick="fnShowState()" height="16" src="/Common/Images/DOCVIEW.gif">&nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    <!-- #include file="/Common/Include/Localization.inc"-->
    <!-- #include file="/Common/Include/WebGrid2005.inc"-->
</body>
</html>
