<%@ Page Language="c#" Inherits="clientregister.registration" EnableViewState="False" CodeFile="registration.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >
<html lang="ru" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Регистрация</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/WebTab.css" rel="stylesheet" />
    <%--  <link href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet" />--%>
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="additionalFuncs.js?v1.3"></script>
    <script type="text/javascript" src="Parameters.js?v.1.3"></script>
    <script type="text/javascript" src="../Scripts/WebTab.js"></script>

    <%--  <script type="text/javascript" src="/Common/WebTab/WebTab.js"></script>--%>
    <script type="text/javascript" src="JScriptForregistration.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>-1"></script>
    <script type="text/javascript" src="InitService.js"></script>
    <script type="text/javascript" src="/Common/Script/json.js"></script>

    <link href="../Content/Themes/ModernUI/css/Style.css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/jquery-ui.css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/buttons.css" rel="stylesheet" />
    <link href="../content/themes/modernui/css/tiptip.css" rel="stylesheet" />

    <script type="text/javascript" src="../Scripts/html5shiv.js"></script>
    <script type="text/javascript" src="../Scripts/respond.min.js"></script>

    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.numbermask.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script type="text/javascript" src="../Content/Themes/ModernUI/scripts/jquery.tiptip.js"></script>
</head>
<body onload="FullInit(); InitObjects(); InitTabs();">
    <div class="webservice" id="webService" showprogress="true"></div>
    <form id='MyForm' method="post" runat="server" style="padding: 5px">
        <asp:ScriptManager ID="sm" runat="server">
            <Services>
                <asp:ServiceReference Path="~/clientregister/defaultWebService.asmx" />
            </Services>
            <Scripts>
                <asp:ScriptReference Path="/barsroot/clientregister/XMLHttpSyncExecutor.js" />
            </Scripts>
        </asp:ScriptManager>
        <table id="tb_main" height="100%" cellspacing="1" cellpadding="1" width="100%" border="0">
            <tr>
                <td height="20">
                    <table id="tb_header" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td style="width: 152px; height: 22px">
                                <input id="bt_reg"
                                        runat="server"
                                        onclick="Register()"
                                        disabled
                                        meta:resourcekey="bt_reg"
                                        type="button"
                                        class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                                        style="width: 150px;"
                                        role="button"
                                        aria-disabled="true"
                                        value ="Зберегти"/>
                                
                                

                                <%--<input id="bt_reg" meta:resourcekey="bt_reg" style="border-right: black 1px outset; border-top: black 1px outset; font-weight: bold; font-size: 10pt; border-left: black 1px outset; width: 150px; border-bottom: black 1px outset; font-family: Arial; background-color: whitesmoke"
                                    type="button" value="Зарегистрировать" runat="server" onclick="Register()" disabled />--%>
                            </td>
                            <td style="padding-left: 2px; height: 22px">
                                <input id="bt_accounts" 
                                    meta:resourcekey="bt_accounts" 
                                    style="width: 150px"
                                    class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                                    type="button" 
                                    value="Счета клиента" 
                                    runat="server" 
                                    onclick="accounts()" />
                            </td>
                            <td style="padding-left: 2px; height: 22px">
                                <input id="bt_print" 
                                    meta:resourcekey="bt_print" 
                                    style="width: 150px"
                                    type="button" 
                                    value="Печать" 
                                    runat="server" 
                                    onclick="btPrintClick()" />
                            </td>
                            <td style="padding-left: 2px; width: 100%; height: 22px"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <div id="webtab">
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" runat="server" id="Mes02" meta:resourcekey="Mes02" value="Введите полный адрес клиента!" />
        <input type="hidden" runat="server" id="Mes03" meta:resourcekey="Mes03" value="Дата привышает допустимую" />
        <input type="hidden" runat="server" id="Mes04" meta:resourcekey="Mes04" value="Наименование банка не найдено!!!" />
        <input type="hidden" runat="server" id="Mes05" meta:resourcekey="Mes05" value="Неправильно заполнено поле 'Код банка - МФО'" />
        <input type="hidden" runat="server" id="Mes06" meta:resourcekey="Mes06" value="Зарегистрировать клиента?" />
        <input type="hidden" runat="server" id="Mes07" meta:resourcekey="Mes07" value="Перерегистрировать клиента" />
        <input type="hidden" runat="server" id="Mes08" meta:resourcekey="Mes08" value="Клиент не зарегистрирован" />
        <input type="hidden" runat="server" id="Mes19" meta:resourcekey="Mes19" value="Не заполнен обязательный допреквизит" />
        <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
        <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
        <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
        <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
        <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
        <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
    </form>
</body>
</html>
