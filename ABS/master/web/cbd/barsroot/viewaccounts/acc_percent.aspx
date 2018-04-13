<%@ Page Language="c#" CodeFile="acc_percent.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.Tab5"
    EnableViewState="False" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <link href="Styles.css" type="text/css" rel="stylesheet">
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <script language="jscript" src="/Common/WebGrid/Grid2005.js"></script>
    <script language="javascript" src="/Common/Script/Localization.js"></script>
    <script language="jscript" src="Scripts/Common.js?v.1.0"></script>
    <script language="jscript" src="Scripts/Percent.js?v1.3"></script>
    <script language="jscript">        window.onload = InitPercent;</script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table width="100%">
        <tr>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:DropDownList runat="server" ID="ddGroups">
                            </asp:DropDownList>
                        </td>
                        <td style="width: 19px">
                            <div id="Copy" style="visibility: hidden">
                                <img src="/Common/Images/COPY.gif" onclick="fnCopyPer()" title="Перенести параметры из основной карточки"></div>
                        </td>
                        <td>
                            <span class="CheckBox">
                                <input id="cb23" type="checkbox" name="cb23" onclick="Open23Percent()" /><label runat="server"
                                    meta:resourcekey="lbOpen23" for="cb23">Открыть 2,3</label></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 8px" align="center">
                <table cellspacing="1" cellpadding="1" width="100%" style="border-right: 2px outset;
                    border-top: 2px outset; border-left: 2px outset; border-bottom: 2px outset">
                    <tr>
                        <td>
                        </td>
                        <td align="right" width="268">
                            <span runat="server" id="lbMetr" meta:resourcekey="lbMetr" class="BarsLabel">Метод начисления</span>
                        </td>
                        <td>
                            <select id="ddMetr" onclick="d_dlg(this)" style="width: 400px">
                                <option selected value=""></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <span runat="server" meta:resourcekey="lbProf" class="BarsLabel">Профиль</span>
                        </td>
                        <td align="right">
                            <span runat="server" id="lbBaseY" meta:resourcekey="lbBaseY" class="BarsLabel">Базовый
                                год</span>
                        </td>
                        <td>
                            <select id="ddBaseY" onclick="d_dlg(this)" style="width: 400px">
                                <option selected value=""></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <select id="ddProf" onchange="setProf()" style="width: 100px">
                                <option selected value=""></option>
                            </select>
                        </td>
                        <td align="right">
                            <span runat="server" id="lbFreq" meta:resourcekey="lbFreq" class="BarsLabel">Периодичность</span>
                        </td>
                        <td align="left">
                            <select id="ddFreq" disabled="disabled" style="width: 400px">
                                <option selected value=""></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="right">
                            <span runat="server" id="lbOstat" meta:resourcekey="lbOstat" class="BarsLabel">Остаток</span>
                        </td>
                        <td>
                            <select runat="server" name="ddOstat" id="ddOstat" meta:resourcekey="ddOstat" onchange="SaveP(this)"
                                style="width: 400px">
                                <option value="0" selected>Исходящий</option>
                                <option value="1">Входящий</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="height: 3px" align="center">
                <div runat="server" id="hintDiv" meta:resourcekey="lbToolTip1" align="center" class="hint">
                    Двойной клик по полю - получения возможного значения по умолчанию</div>
                <table width="100%">
                    <tr>
                        <td align="center" width="100">
                            <span runat="server" id="lbDati" meta:resourcekey="lbDati" class="BarsLabelItalic">Даты</span>
                        </td>
                        <td align="center" width="150">
                            <span runat="server" id="lbNachis" meta:resourcekey="lbNachis" class="BarsLabel">Начисления</span>
                        </td>
                        <td align="center" width="150">
                            <span runat="server" id="lbViplat" meta:resourcekey="lbViplat" class="BarsLabel">Выплаты</span>
                        </td>
                        <td align="center" width="150">
                            <span runat="server" id="lbZaver" meta:resourcekey="lbZaver" class="BarsLabel">Завершение</span>
                        </td>
                        <td align="left">
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td align="center">
                            <input type="text" id="tbAcrDat" onchange="SaveP(this)" style="width: 120px">
                        </td>
                        <td align="center">
                            <input type="text" id="tbAplDat" onchange="SaveP(this)" style="width: 120px">
                        </td>
                        <td align="center">
                            <input type="text" id="tbStpDat" onchange="SaveP(this)" style="width: 120px">
                        </td>
                        <td align="left">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" height="1">
                <table width="100%">
                    <tr>
                        <td align="center" width="100">
                            <span runat="server" id="lbOper" meta:resourcekey="lbOper" class="BarsLabelItalic">Операции</span>
                        </td>
                        <td align="center">
                            <span runat="server" id="lbTip" meta:resourcekey="lbTip2" class="BarsLabel">Тип</span>
                        </td>
                        <td align="center">
                            <span runat="server" id="lbVal1" meta:resourcekey="lbVal1" class="BarsLabel">Вал</span>
                        </td>
                        <td align="center" width="150">
                            <span runat="server" id="lbSch" meta:resourcekey="lbSch" class="BarsLabel">Сч. нач.
                                %%</span>
                        </td>
                        <td align="center" width="90">
                            <span runat="server" id="lbMFO" meta:resourcekey="lbMFO2" class="BarsLabel">МФО</span>
                        </td>
                        <td align="center" width="40">
                            <span runat="server" id="lbVal2" meta:resourcekey="lbVal2" class="BarsLabel">Вал</span>
                        </td>
                        <td align="center" width="150">
                            <span runat="server" id="lbKontr" meta:resourcekey="lbKontr" class="BarsLabel">КонтрСчет</span>
                        </td>
                        <td align="center">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" width="100">
                            <span runat="server" id="lbNachisl" meta:resourcekey="lbNachisl" class="BarsLabel">Начисл</span>
                        </td>
                        <td align="center" width="40">
                            <input name="tbTT1" type="text" id="tbTT1" ondblclick="ValidPer(this)" onchange="SaveP(this)"
                                style="width: 50px">
                        </td>
                        <td align="center" width="40">
                            <input name="tbKvA" type="text" id="tbKvA" ondblclick="ValidPer(this)" onchange="SaveP(this)"
                                style="width: 40px">
                        </td>
                        <td align="center" width="150">
                            <input name="tbNlsA" type="text" id="tbNlsA" ondblclick="ValidPer(this)" onchange="ValidNlsA()"
                                style="width: 150px">
                        </td>
                        <td align="center">
                        </td>
                        <td align="center" width="40">
                            <input name="tbKvB" type="text" id="tbKvB" ondblclick="ValidPer(this)" onchange="SaveP(this)"
                                style="width: 40px">
                        </td>
                        <td align="center" width="150">
                            <input name="tbNlsB" type="text" id="tbNlsB" ondblclick="ValidPer(this)" onchange="ValidNlsB()"
                                style="width: 150px">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td align="center" width="100">
                            <span runat="server" id="lbVip" meta:resourcekey="lbVip" class="BarsLabel">Выплат</span>
                        </td>
                        <td width="50">
                            <input name="tbTT2" type="text" id="tbTT2" ondblclick="ValidPer(this)" onchange="SaveP(this)"
                                style="width: 50px">
                        </td>
                        <td width="193">
                            <input name="tbNamC" type="text" id="tbNamC" onchange="SaveP(this)" style="width: 193px">
                        </td>
                        <td width="90">
                            <input name="tbMFO" type="text" id="tbMFO" onchange="SaveP(this)" style="width: 90px">
                        </td>
                        <td width="40">
                            <input name="tbKvC" type="text" id="tbKvC" ondblclick="ValidPer(this)" onchange="SaveP(this)"
                                style="width: 40px">
                        </td>
                        <td width="150">
                            <input name="tbNlsC" type="text" id="tbNlsC" onchange="ValidNlsC()" style="width: 150px">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td width="100">
                        </td>
                        <td width="536">
                            <input name="tbNazn" type="text" id="tbNazn" onchange="SaveP(this)" style="width: 538px">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <div runat="server" id="hintDiv1" meta:resourcekey="lbToolTip2" align="center" class="hint">
                    Двойной клик по строке - изменение значений</div>
            </td>
        </tr>
    </table>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    <div id="a_d">
        <img id="add" onclick="Add()" src="/Common/Images/INSERT.gif"><img src="/Common/Images/DELREC.gif"
            onclick="DelRow()"></div>
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
    <input type="hidden" runat="server" id="forbtOb0" meta:resourcekey="forbtOb0" value="АКТИВЫ" />
    <input type="hidden" runat="server" id="forbtOb1" meta:resourcekey="forbtOb1" value="ПАССИВЫ" />
    <input type="hidden" runat="server" id="forbtOb2" meta:resourcekey="forbtOb2" value="ПЕНЯ" />
    <input type="hidden" runat="server" id="forbtOb3" meta:resourcekey="forbtOb3" value="Ид. 3" />
    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
    <input runat="server" type="hidden" id="Message30" meta:resourcekey="Message30" value=" не открыт. Открыть?" />
    <input runat="server" type="hidden" id="Message31" meta:resourcekey="Message31" value="Ошибка! Контрольный разряд" />
    <input runat="server" type="hidden" id="Message32" meta:resourcekey="Message32" value="Счет открыт!" />
    <input runat="server" type="hidden" id="Message33" meta:resourcekey="Message33" value="Счет невозможно открыть!" />
    </form>
</body>
</html>
