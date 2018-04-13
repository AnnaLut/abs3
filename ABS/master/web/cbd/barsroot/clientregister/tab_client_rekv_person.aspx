<%@ Page Language="c#" Inherits="clientregister.tab_client_rekv_person" CodeFile="tab_client_rekv_person.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Реквизиты клиента "Физ. лицо"</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script type="text/javascript" src="additionalFuncs.js"></script>
    
    <link href="../Content/Themes/ModernUI/css/Style.css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/jquery-ui.css" rel="stylesheet" />  
    <link href="../Content/Themes/ModernUI/css/buttons.css" rel="stylesheet" />
    <link href="../content/themes/modernui/css/tiptip.css" rel="stylesheet" />
    <link href="../Content/images/PureFlat/pf-icons.css" rel="stylesheet" />    
    
    <script type="text/javascript" src="../Scripts/html5shiv.js"></script>
    
    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskMoney.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.numbermask.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskedinput-1.3.1.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script type="text/javascript" src="../Content/Themes/ModernUI/scripts/jquery.tiptip.js"></script>
    
    <script type="text/javascript" src="JScriptFortab_client_rekv_person.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>"></script>
    <style type="text/css">
        div.required {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }
        #tblMain td.checkbox {
            padding-left: 20px;
            height: 44px;
        }
        #tblEdits col.title {
            width: 200px;
        }
        .edit {
            width: 150px;
            border: 1px solid #000000;
        }

            .edit.long {
                width: 250px;
            }

            .edit.date {
                text-align: center;
            }

        .reference {
            width: 16px;
            height: 16px;
        }
    </style>
</head>
<body>
    <form id="Form1" method="post" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
            <Services>
                <asp:ServiceReference Path="~/clientregister/defaultWebService.asmx" />
            </Services>
            <Scripts>
                <asp:ScriptReference Path="/barsroot/clientregister/XMLHttpSyncExecutor.js" />
            </Scripts>
        </asp:ScriptManager>
        <div style="padding: 10px">
        <table id="tblMain" border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td class="checkbox">
                    <input id="ckb_main" onclick="MyChengeEnable(this.checked); ToDoOnChange();"
                        tabindex="1" type="checkbox" checked runat="server" />
                    <label runat="server" class="simpleTextStyle" meta:resourcekey="divPersInfo" for="ckb_main">Заполнять персональные реквизиты</label>                   
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblEdits" border="0" cellpadding="2" cellspacing="0">
                        <col class="title" />
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocType">
                                Вид документа
                            </td>
                            <td>
                                <select class="edit" id="ddl_PASSP" tabindex="2" runat="server" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); ">
                                    <option selected="selected"></option>
                                </select>
                                <div class="required">*</div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdSerial">
                                Серия
                            </td>
                            <td>
                                <input class="edit" id="ed_SER" tabindex="3" type="text" maxlength="10" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); " onkeypress="return CheckDocSeries('ed_SER', 'ddl_PASSP'); " />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocNumber">
                                Номер док.
                            </td>
                            <td>
                                <input class="edit" id="ed_NUMDOC" tabindex="4" type="text" maxlength="20" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); " onkeypress="return CheckDocNumber('ed_NUMDOC', 'ddl_PASSP'); " />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdOrg">
                                Кем выдан
                            </td>
                            <td>
                                <input class="edit long" id="ed_ORGAN" tabindex="5" type="text" maxlength="70" />
                                <button id="bt_help"
                                        style="height: 24px" 
                                        onclick="GetOrganHelp();ToDoOnChange();"
                                        title="довідник">
                                     <i class="pf-icon pf-16 pf-help"></i>
                                </button>
                                <%--<img id="bt_help" runat="server" meta:resourcekey="btHelp" src="/Common/Images/HELP.gif"
                                    class="reference" alt="Справка" onclick="GetOrganHelp();ToDoOnChange();" />--%>
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocDate">
                                Когда выдан
                            </td>
                            <td>
                                <input class="edit date" id="ed_PDATE" title="Формат: dd.MM.yyyy" tabindex="6" type="text"
                                    maxlength="10" onchange="isDateCheck(getEl('ed_PDATE'));" />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdBirthDay">
                                Дата рождения
                            </td>
                            <td>
                                <input class="edit date" id="ed_BDAY" title="Формат: dd.mm.yyyy" tabindex="7" type="text"
                                    maxlength="10" onchange="isDateCheck(getEl('ed_BDAY'));" />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdBirthPlace">
                                Место рождения
                            </td>
                            <td>
                                <input class="edit long" id="ed_BPLACE" tabindex="8" type="text" maxlength="70" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdSex">
                                Пол
                            </td>
                            <td>
                                <select class="edit" id="ddl_SEX" tabindex="9" runat="server">
                                    <option selected="selected"></option>
                                </select>
                                <div class="required">*</div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdMobilePhone">Моб. тел.</td>
                            <td>
                                <div>
                                    <label>
                                        <input type="checkbox" id="notUseTelm"/> У клієнта відсутній мобільний телефон
                                    </label>
                                </div>
                                <div>
                                    <i id="imgPhoneConfirmed" title="телефон підтверджено" style="margin: 3px;display: none;" class="pf-icon pf-16 pf-phone-ok2"></i>
                                    <i id="imgPhoneNotConfirmed"  title="телефон не підтверджено" style="margin: 3px;display: none;" class="pf-icon pf-16 pf-phone-error"></i>
                                    <div id="codeMobPhone" style="display: inline;">
                                        <span>+380</span>
                                        <input id="ed_TELM_CODE" onkeypress="return false;" style="width: 50px;" />
                                    </div>
                                    <input class="edit" onchange="ChangeMobilePhone(this);" id="ed_TELM" tabindex="10" type="text" maxlength="7" />
                                    <div class="required">*</div>
                                    
                                    <button id="btnConfirmPhone" 
                                        onclick="ValidatePhone.SendValidationSms()"
                                        style="display: none"
                                        title="Пройти процедуру підтвердження мобільного телефону">
                                        підтвердити
                                    </button>
                                    
                                    <div id="phoneConfirmedSmsBlock" style="display:none;">
                                        <span>sms:</span>
                                        <input id="phoneConfirmSms" value="" maxlength="8" required=""/>

                                        <button id="btnConfirmPhoneSms" 
                                            onclick="ValidatePhone.ValidateSms();"
                                            title="Підпвердити SMS">
                                            <i class="pf-icon pf-16 pf-ok"></i>
                                        </button>
                                        <button id="btnCencelConfirmPhoneSms" 
                                            onclick="ValidatePhone.CancelValidate()"
                                            title="відмінити процедуру підтвердження мобільного телефону">
                                            <i class="pf-icon pf-16 pf-delete_button_error"></i>
                                        </button>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdHomePhone">Дом. тел.</td>
                            <td>
                                <div id="codeCityPhone" style="display: inline;">
                                  <span>+380</span> 
                                  <input id="ed_TELD_CODE" onkeypress="return false;" style="width: 50px;"/>
                                </div>
                                <input class="edit" id="ed_TELD" tabindex="10" type="text" maxlength="7" />
                                <div class="required">*</div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdWorkPhone">Раб. тел.
                            </td>
                            <td>
                                <input class="edit" id="ed_TELW" tabindex="11" type="text" maxlength="20" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
            </div>
        <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
        <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
        <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
        <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
        <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
        <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
    </form>
    <script type="text/javascript" src="../Scripts/respond.min.js"></script>
</body>
</html>
