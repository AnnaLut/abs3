<%@ Page Language="c#" CodeFile="accountform.aspx.cs" AutoEventWireup="false" Inherits="ViewAccounts.AccountsForm" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Просмотр атрибутов счета</title>
    <link href="Styles.css" type="text/css" rel="stylesheet" />
    <link href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="/Common/WebTab/WebTab.js"></script>
    <script type="text/javascript" src="Scripts/Common.js?v1.1"></script>
    <script type="text/javascript" src="Scripts/Default.js?v1.9"></script>

    <link href="../lib/alertify/css/alertify.core.css" rel="stylesheet" />
    <link href="../lib/alertify/css/alertify.default.css" rel="stylesheet" />
    <script src="../lib/alertify/js/alertify.min.js"></script>

    <script type="text/javascript">
        window.onload = InitDefault;
        var image1 = new Image(); image1.src = "/Common/Images/SAVE.gif";
        var image2 = new Image(); image2.src = "/Common/Images/DELREC.gif";
        var image3 = new Image(); image3.src = "/Common/Images/PRINT.gif";
        var image4 = new Image(); image4.src = "/Common/Images/DISCARD.gif";
    </script>
</head>
<body>
    <form runat="server">
    <span id="lbNls" style="font-size: 8pt; color: navy; font-family: Verdana"></span>
    <span id="lbNmk" style="font-size: 8pt; color: maroon; font-family: Verdana"></span>
    <div id="acc_obj">
    </div>
    <div id="per_obj">
    </div>
    <div id="edit_data">
    </div>
    <table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td>
                &nbsp;
                <img class="outset" id="btSave" onclick="SaveAccount()" runat="server" alt=""/>
                <img class="outset" id="btClose" onclick="CloseAccount()" runat="server" alt=""/>
                <img class="outset" id="btPrint" onclick="Print()" runat="server" alt=""/>
                &nbsp;
            </td>
            <td>
                &nbsp;<img class="outset" id="btDiscard" onclick="exit_page()" runat="server">&nbsp;
            </td>
            <td>
                <span class="CheckBox">
                    <input disabled id="cbOnAllValuts" type="checkbox" name="cbOnAllValuts" onclick="fnShowValutes()"><label
                        runat="server" for="cbOnAllValuts" meta:resourcekey="cbOnAllValuts">По валютам</label></span>
            </td>
        </tr>
    </table>
    <div class="webservice" id="webService" showprogress="true">
    </div>
    <div id="webtab">
    </div>
    <input type="hidden" runat="server" id="parNBSNULL" />
    <input type="hidden" runat="server" id="forbtSave" meta:resourcekey="forbtSave" value="Сохранить" />
    <input type="hidden" runat="server" id="forbtClose" meta:resourcekey="forbtClose"
        value="Удалить" />
    <input type="hidden" runat="server" id="forbtPrint" meta:resourcekey="forbtPrint"
        value="Печать" />
    <input type="hidden" runat="server" id="forbtDiscard" meta:resourcekey="forbtDiscard"
        value="Выйти" />
    <input type="hidden" runat="server" id="tb1" meta:resourcekey="tb1" value="Осн.реквизиты" />
    <input type="hidden" runat="server" id="tb2" meta:resourcekey="tb2" value="Фин.реквизиты" />
    <input type="hidden" runat="server" id="tb3" meta:resourcekey="tb3" value="Права доступа" />
    <input type="hidden" runat="server" id="tb4" meta:resourcekey="tb4" value="Спецпараметры" />
    <input type="hidden" runat="server" id="tb5" meta:resourcekey="tb5" value="Проценты" />
    <input type="hidden" runat="server" id="tb6" meta:resourcekey="tb6" value="Тарифы" />
    <input type="hidden" runat="server" id="tb7" meta:resourcekey="tb7" value="График событий" />
    <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Проставление прав доступа для пользователей &nbsp;Другие&nbsp; существенно повышает риск нежелательного доступа к счету. Продолжать с текущими установками?" />
    <input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="Контрагент:" />
    <input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="Открытие ЛС." />
    <input runat="server" type="hidden" id="Message4" meta:resourcekey="Message4" value="Обновление реквизитов ЛС" />
    <input runat="server" type="hidden" id="Message5" meta:resourcekey="Message5" value="Просмотр реквизитов ЛС" />
    <input runat="server" type="hidden" id="Message6" meta:resourcekey="Message6" value="Вы действительно хотите закрыть текущий счет?" />
    <input runat="server" type="hidden" id="Message7" meta:resourcekey="Message7" value="В карточке есть несохраненные данные! Игнорировать изменения и выйти?" />
    <input runat="server" type="hidden" id="Message8" meta:resourcekey="Message8" value="Не заполнен реквизит < Номер счета >" />
    <input runat="server" type="hidden" id="Message9" meta:resourcekey="Message9" value="Не заполнен реквизит < Валюта >" />
    <input runat="server" type="hidden" id="Message10" meta:resourcekey="Message10" value="Не заполнен реквизит < Наименование счета >" />
    <input runat="server" type="hidden" id="Message11" meta:resourcekey="Message11" value="Не заполнен реквизит < Тип счета >" />
    <input runat="server" type="hidden" id="Message12" meta:resourcekey="Message12" value="Не заполнен реквизит < Вид счета >" />
    <input runat="server" type="hidden" id="Message13" meta:resourcekey="Message13" value="Не заполнен реквизит < Исполнитель >" />
    <input runat="server" type="hidden" id="Message14" meta:resourcekey="Message14" value="< Права доступа > Не назначена группа счетов" />
    <input runat="server" type="hidden" id="Message15" meta:resourcekey="Message15" value="< Права доступа > Не назначена группа счета" />
    <input runat="server" type="hidden" id="Message16" meta:resourcekey="Message16" value="Изменений нет!" />
    <input runat="server" type="hidden" id="Message17" meta:resourcekey="Message17" value="Открыть " />
    <input runat="server" type="hidden" id="Message18" meta:resourcekey="Message18" value=" ВНЕСИСТЕМНЫЙ " />
    <input runat="server" type="hidden" id="Message19" meta:resourcekey="Message19" value="лицевой счет: " />
    <input runat="server" type="hidden" id="Message20" meta:resourcekey="Message20" value=" валюта: " />
    <input runat="server" type="hidden" id="Message21" meta:resourcekey="Message21" value=" ВНЕСИСТЕМНЫЕ " />
    <input runat="server" type="hidden" id="Message22" meta:resourcekey="Message22" value="лицевые счета: " />
    <input runat="server" type="hidden" id="Message23" meta:resourcekey="Message23" value=" по выбранным валютам ?" />
    <input runat="server" type="hidden" id="Message24" meta:resourcekey="Message24" value="Сохранить изменения в реквизитах лицевого счета " />
    <input runat="server" type="hidden" id="Message25" meta:resourcekey="Message25" value="Изменения успешно сохранены!" />
    </form>
</body>
</html>
