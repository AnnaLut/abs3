<%@ Page Language="c#" Inherits="clientregister.registration" EnableViewState="False" CodeFile="registration.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >
<html lang="ru" xmlns="http://www.w3.org/1999/xhtml">

<head>
    <title>Регистрация</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/WebTab.css" rel="stylesheet" />
    <%--  <link href="/Common/WebTab/WebTab.css" type="text/css" rel="stylesheet" />--%>
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>

    <%--  <script type="text/javascript" src="/Common/WebTab/WebTab.js"></script>--%>
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
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js?v1.0"></script>
    <script type="text/javascript" src="../Content/Themes/ModernUI/scripts/jquery.tiptip.js"></script>

    
    <%--kendo--%>
    <link href="../Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    <link href="../Content/images/PureFlat/pf-icons.css" rel="stylesheet" />
    <script src="../Scripts/kendo/kendo.all.min.js"></script>
    <script src="../Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script src="../Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
    <script src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
    <script src="../Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>
    <script src="../Scripts/Bars/bars.ui.js"></script>
    <script src="../Scripts/Bars/bars.utils.js"></script>
    <script src="../Scripts/Bars/bars.config.js"></script>
    <script src="../Scripts/Bars/bars.extension.js?v1.0"></script>
    <script type="text/javascript" src="../Scripts/KendoCommon.js?v1.0.0"></script>
    <script type="text/javascript" src="additionalFuncs.js?v1.3"></script>
    <script type="text/javascript" src="Parameters.js?v.1.3"></script>
    <script type="text/javascript" src="../Scripts/WebTab.js"></script>
    <script type="text/javascript" src="JScriptForregistration.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>.t043"></script>
    <script type="text/javascript" src="InitService.js"></script>
</head>
<body onload="FullInit(); InitObjects(); InitTabs();">
    
        <div id="realPhotoWin" style="display:none">
        <table>
            <tr>
                <td align="center" style="border: 1px solid;padding:4px"><img id="kkPhoto_WEB" runat="server" src="/Common/Images/empty_image.png" alt="" /></td>
                <td align="center" style="border: 1px solid;padding:4px"><img id="kkPhoto_JPG" runat="server" src="/Common/Images/empty_image.png" alt="" /></td>
                <td align="center" style="border: 1px solid;padding:4px"><img id="kkPhoto_PHOTO" runat="server" src="/Common/Images/empty_image.png" alt="" /></td>
            </tr>
            <tr>
                <td align="center" style="border: 1px solid"><h1>Веб-камера</h1></td>
                <td align="center" style="border: 1px solid"><h1>Скан</h1></td>
                <td align="center" style="border: 1px solid"><h1>Фото</h1></td>
            </tr>
            <tr>
                <td align="center" style="color:darkgreen" id="kkPhoto_WEB_Date"><h3></h3></td>
                <td align="center" style="color:darkgreen" id="kkPhoto_JPG_Date"><h3></h3></td>
                <td align="center" style="color:darkgreen" id="kkPhoto_PHOTO_Date"><h3></h3></td>
            </tr>
        </table>
    </div>
    <div id="selectPhotoWin" style="display:none">
        <h3>Ширина та висота має бути – 480-640 pixels. Розмір не повинен перевищувати 150 Кб.</h3>
        <input style="width: 150px" type="file" runat="server" id="image_file" accept="image/*" />
    </div>


    <div class="webservice" id="webService" showprogress="true"></div>
    <form id='MyForm' method="post" runat="server" style="padding: 5px">
        <h1 runat="server" id="PageTitle">Реєстрація клієнта</h1>
        <div style="color:red; font-size:12px;" runat="server" id="ErrorSumaryMessage"></div>
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
                            <td style="padding-left: 2px; height: 22px">
                                <input id="bt_reg"
                                        runat="server"
                                        onclick="Register()"
                                        disabled
                                        meta:resourcekey="bt_reg"
                                        type="button"
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

                            <td style="padding-left: 2px; height: 22px">
                                <input id="btn_scan_img"
                                    meta:resourcekey="btn_scan_img"
                                    style="width: 165px"
                                    type="button"
                                    value="Фото/Сканування"
                                    runat="server"
                                    onclick="showDialogScanPhoto()" />
                            </td>
                            <td style="padding-left: 2px; height: 22px">
                                <input id="Button1"
                                    meta:resourcekey="btn_scan_img"
                                    style="width: 165px"
                                    type="button"
                                    value="Вибір фотографії"
                                    runat="server"
                                    onclick="showDialogSelectPhoto()" />
                            </td>


<%--                            <td style="padding-left: 2px; height: 22px">
                                <input style="width: 150px" type="file" runat="server" id="image_file" accept="image/*" />
                            </td>--%>
                            <td>
                                <%--<label id="lb_empty_photo" style="font-size: 12px; font-weight: 400;">Вибір фотографії.</label>--%>
                                <input id="btnSavePhoto" style="display:none" type="button" value="Зберегти фото" runat="server" onclick="btSavePhoto()" />
                            </td>
                            <td style="padding-left: 10px;" align="center" >
<%--                                <input type="file" runat="server" id="image_file" style="display:none" accept="image/*" />                                
                                <a href="#" onclick="showDialogOpenPhoto()">
                                  <img id="kkPhoto" runat="server" src="/Common/Images/empty_image.png" alt="" style="width:128px;height:128px;border:0;"/>
                                </a>--%>

                                <a href="#" onclick="openRealPhoto()">
                                    <img id="kkPhoto" runat="server" src="/Common/Images/empty_image.png" alt="" style="width:64px;height:64px;border:0;position:center"/>
                                </a>
                                <div runat="server" id="kkPhotoText"></div>
                            </td>


                            <td id="dptChangeRekv" style="padding-left: 2px; height: 22px; display: none; white-space: nowrap;">
                                <nobr>                                
                                    <input id="bt_print_change_rekv" 
                                        style="width: 150px;"
                                        type="button" 
                                        value="Заява про зміну рекв." 
                                        runat="server" 
                                        onclick="dptModule.saveCustChange()" />

                                    <label id="lb_save_change_rekv" style="font-size: 12px; font-weight: 400;">
                                        <input id="ch_save_change_rekv"
                                            disabled="disabled"
                                            type="checkbox" 
                                            onchange="if(this.checked)dptModule.seveCust();" />
                                        Підписано клієнтом
                                    </label>
                                </nobr>

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
