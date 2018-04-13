<%@ Page Language="c#" CodeFile="optionlist.aspx.cs" AutoEventWireup="false" Inherits="barsweb.OptionList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Настройки пользователя</title>
    <base target="_self" />
    
    <script language="javascript" src="/Common/Script/Localization.js"></script>
    <script language="javascript">

    
    window.onload = LocalizeHtmlValues;    

    function LocalizeHtmlValues() {
        LocalizeHtmlValue('btnCancel');
    }
    
    function openClose(obj, g) {
        var el = document.getElementById(obj);
        var group = document.getElementById(g);
        if (el.style.display=='none') {
            el.style.display='block';
            group.innerText=group.innerText.substring(0,group.innerText.length-2)+'>>';
        }
        else
        {
            el.style.display='none';
            group.innerText=group.innerText.substring(0,group.innerText.length-2)+'<<';
        }
    }
    
    function setDefault(par, obj) {
        res = null;
        switch (par) {
            case 1:
            res='ru';
            break;
            case 2:
            res='ru';
            break;
        }
        var el = document.getElementById(obj);
        el.value = res;
    }
    </script>

</head>
<body style="text-align: center; font-family: Verdana; color: #000066; font-size: 10pt;
    font-weight: bold;">
    <div style="width: 600px; text-align: left;">
        <div meta:resourcekey="mainHeader" align="center" runat="server">
            НАСТРОЙКИ ПОЛЬЗОВАТЕЛЯ
        </div>
        <form id="form1" runat="server">
            <span id="groupGL" meta:resourcekey="groupGL" runat="server" onclick="openClose('openOptions','groupGL')" style="cursor: hand;">
                Локализация и глобализация >></span>
            <div id="openOptions" style="display: block;">
                <table width="100%" style="font-size: 10pt; font-family: Verdana; text-indent: 5px;">
                    <tr>
                        <td meta:resourcekey="olPar" runat="server" style="background-color: gainsboro; text-align: center; height: 30px;" width="50%">
                            ПАРАМЕТР</td>
                        <td meta:resourcekey="olVal" runat="server" style="background-color: gainsboro; text-align: center">
                            ЗНАЧЕНИЕ</td>
                    </tr>
                    <tr>
                        <td meta:resourcekey="olLangLoc" runat="server" style="background-color: ivory;" width="50%">
                            Язык локализации</td>
                        <td style="background-color: ivory;">
                            <table width="100%" cellpadding="0px" cellspacing="0px">
                                <tr>
                                    <td width="50%" align="center">
                                        <select id="selLoc" runat="server" style="width: 100px;">
                                            <option value="ru">Русский</option>
                                            <option value="uk">Українська</option>
                                            <option value="en">English</option>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <input id="defLoc" meta:resourcekey="olDef" runat="server" onclick="setDefault(2, 'selLoc')" type="button" value="По умолчанию" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td meta:resourcekey="olRegion" runat="server" width="50%" style="background-color: whitesmoke">
                            Регион</td>
                        <td style="background-color: whitesmoke; text-align: right;">
                            <table width="100%" cellpadding="0px" cellspacing="0px">
                                <tr>
                                    <td width="50%" align="center">
                                        <select id="selGlob" runat="server" style="width: 100px;">
                                            <option value="ru">Россия</option>
                                            <option value="ua">Україна</option>
                                            <option value="gb">Great Britain</option>
                                        </select>
                                    </td>
                                    <td align="center">
                                        <input id="defGlob" meta:resourcekey="olDef" runat="server" onclick="setDefault(2, 'selGlob')" type="button" value="По умолчанию" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <table width="100%" style="font-size: 10pt; font-family: Verdana; text-indent: 5px;">
                <tr>
                    <td width="50%" style="background-color: gainsboro; text-align: center;">
                        <input id="btnCancel" type="reset" value="Сброс"></td>
                    <td style="background-color: gainsboro; text-align: center; height: 26px;">
                        <input id="btnSave" meta:resourcekey="btnSave" runat="server" type="button" value="Сохранить" onserverclick="btnSave_ServerClick">
                    </td>
                </tr>
            </table>
        <input id="forbtnCancel" meta:resourcekey="forbtnCancel" runat="server" type="hidden" value="Сброс">
        </form></div>
</body>
</html>
