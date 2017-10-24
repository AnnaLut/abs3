<%@ Page Language="c#" CodeFile="default.aspx.cs" AutoEventWireup="false" Inherits="CustomerList.Test" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Перегляд контрагентів</title>
    <link href="Styles.css" type="text/css" rel="stylesheet">
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" src="Scripts/Common.js"></script>
    <script language="JavaScript" src="Scripts/Default.js?v1.6"></script>
    <script language="JavaScript" src="/Common/WebGrid/Grid2005.js?v1.1"></script>
    <script language="javascript" src="/Common/Script/Localization.js"></script>
    
    <script language="javascript">
        window.onload = InitDefaultParams;
        var image1 = new Image(); image1.src = "/Common/Images/SMTHING.gif";
        var image2 = new Image(); image2.src = "/Common/Images/CUSTPERS.gif";
        var image3 = new Image(); image3.src = "/Common/Images/CUSTCORP.gif";
        var image4 = new Image(); image4.src = "/Common/Images/CUSTBANK.gif";
        var image5 = new Image(); image5.src = "/Common/Images/CUSTCLSD.gif";
        var image6 = new Image(); image6.src = "/Common/Images/INSERT.gif";
        var image7 = new Image(); image7.src = "/Common/Images/DELREC.gif";
        var image8 = new Image(); image8.src = "/Common/Images/UNDO.gif";
        var image9 = new Image(); image9.src = "/Common/Images/REFRESH.gif";
        var image10 = new Image(); image10.src = "/Common/Images/FILTER_.gif";
        var image12 = new Image(); image12.src = "/Common/Images/OPEN_.gif";
        var image13 = new Image(); image13.src = "/Common/Images/BOOK.gif";
        var image14 = new Image(); image14.src = "/Common/Images/BOOKS1.gif";
        var image15 = new Image(); image15.src = "/Common/Images/DISCARD.gif";
        var image16 = new Image(); image16.src = "/Common/Images/ref_edit.gif";
        var image17 = new Image(); image17.src = "/Common/Images/USER.gif";
    </script>
</head>
<body>
    <div style="background-color: lightgrey">
        <table id="T" cellspacing="0" cellpadding="0" border="2">
            <tr>
                <td>
                    <img runat="server" meta:resourcekey="btAll" class="inset" id="btAll" title="Контрагенты всех типов"
                        onclick="fnAll()"><img runat="server" class="outset" meta:resourcekey="btPerson"
                            id="btPerson" title="Контрагенты - физические лица" onclick="fnPerson()"><img runat="server"
                                class="outset" meta:resourcekey="btPersonSPD" id="btPersonSPD" title="Контрагенты - физические лица СПД"
                                onclick="fnPersonSPD()"><img runat="server" class="outset" meta:resourcekey="btCorp"
                                    id="btCorp" title="Контрагенты - юридические лица" onclick="fnCorp()"><img runat="server"
                                        class="outset" meta:resourcekey="btBank" id="btBank" title="Контрагенты - банки"
                                        onclick="fnBank()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" meta:resourcekey="btShow" id="btShow" title="Показывать закрытых контрагентов"
                        style="border-top-style: outset" onclick="fnShow()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" meta:resourcekey="btReg" id="btReg" title="Зарегистрировать нового контрагента"
                        onclick="fnRegKontr()"><img runat="server" class="outset" meta:resourcekey="btClose"
                            id="btClose" title="Закрыть контрагента" onclick="fnCloseKontr()"><img runat="server"
                                class="outset" meta:resourcekey="btResurect" id="btResurect" title="Перерегистрировать закрытого контрагента"
                                onclick="fnResurect()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" meta:resourcekey="btRefresh" id="btRefresh"
                        title="Перечитать данные" onclick="fnRefresh()"><img runat="server" class="outset"
                            meta:resourcekey="btFilter" id="btFilter" title="Установить фильтр" onclick="ShowFilter()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" meta:resourcekey="btKontr" id="btKontr"
                        title="Показать карточку контрагента" onclick="fnRedirPer()"><img runat="server"
                            class="outset" meta:resourcekey="btAcc" id="btAcc" title="Показать счета контрагента"
                            onclick="fnRedirAcc()"><img runat="server" class="outset" meta:resourcekey="btHist"
                                id="btHist" title="Показать историю" onclick="fnShowHist()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" style="visibility: hidden" meta:resourcekey="btCredits"
                        id="btCredits" title="Потребительские кредиты контрагента" onclick="fnCredits()">&nbsp;
                </td>
                <td>
                    &nbsp;<img runat="server" class="outset" meta:resourcekey="Choose" id="Choose" title="Выход"
                        onclick="goBack()">&nbsp;
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
    <input runat="server" type="hidden" id="Message14" meta:resourcekey="Message14" value="Закрыть Клиента банка" />
    <input runat="server" type="hidden" id="Message15" meta:resourcekey="Message15" value="Клиент закрыт!" />
    <input runat="server" type="hidden" id="Message16" meta:resourcekey="Message16" value="Перерегистрировать Клиента банка" />
    <input runat="server" type="hidden" id="Message17" meta:resourcekey="Message17" value="Клиент перерегистрирован!" />
</body>
</html>
