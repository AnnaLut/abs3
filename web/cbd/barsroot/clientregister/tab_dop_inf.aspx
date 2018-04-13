<%@ Page Language="c#" Inherits="clientregister.tab_dop_inf" CodeFile="tab_dop_inf.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Доп. информация</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet">
    <script language="javascript" src="/Common/Script/Localization.js"></script>
    
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

    <script language="javascript" src="JScriptFortab_dop_inf.js"></script>
    <script language="javascript" src="additionalFuncs.js"></script>
</head>
<body onload="InitObjects();">
<div style="padding: 10px">
    <table id="tb_main" style="font-size: 10pt; font-family: Arial; text-align: center"
        cellspacing="0" cellpadding="1" border="0">
        <tr>
            <td align="left">
                <table id="tb_edits" style="font-size: 10pt; font-family: Arial" cellspacing="0"
                    cellpadding="1" border="0">
                    <tr>
                        <td runat="server" meta:resourcekey="tdManager" width="230">
                            Менеджер клиента (код)
                        </td>
                        <td align="center">
                            <%--<img id="bt_help" runat="server" meta:resourcekey="btHelp" src="/Common/Images/HELP.gif"
                                height="16" width="16" alt="Справка" onclick="var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=staff&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px'); if(result != null) PutIntoEdit(getEl('ed_ISP'), result[0]);ToDoOnChange();" />--%>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_ISP" tabindex="1" type="text" maxlength="20"
                                onchange="ToDoOnChange();" onblur="isNumberCheck(getEl('ed_ISP'))">
                            <button id="bt_help" 
                                    style="height: 24px"
                                    onclick="var result = window.showModalDialog('dialog.aspx?type=metatab&tabname=staff&tail=\'\'&role=WR_CUSTREG', 'dialogHeight:600px; dialogWidth:600px'); if(result != null) PutIntoEdit(getEl('ed_ISP'), result[0]);ToDoOnChange();"
                                    title="довідник">
                                 <i class="pf-icon pf-16 pf-help"></i>
                            </button>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdRem" width="230">
                            Примечание
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed2_style" id="ed_NOTES" tabindex="2" type="text" maxlength="140"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdClass">
                            Класс заемщика
                        </td>
                        <td>
                            <input id="ed_CRISK" style="width: 50px" tabindex="0" readonly type="text" maxlength="5"
                                onchange="ToDoOnChange();">
                        </td>
                        <td>
                            <select class="tab_ek_norm_ed2_style" id="ddl_CRISK" tabindex="3" onchange="SetClientColor(getEl('ddl_CRISK').item(getEl('ddl_CRISK').selectedIndex).value);ToDoOnChange();ToDoOnChange();"
                                runat="server">
                                <option selected></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdSmallBusiness">
                            Принадлежность малому бизнесу
                        </td>
                        <td>
                            <input id="ed_MB" style="width: 50px" tabindex="0" readonly type="text" maxlength="5"
                                onchange="ToDoOnChange();">
                        </td>
                        <td>
                            <select class="tab_ek_norm_ed2_style" id="ddl_MB" tabindex="4" onchange="SetMB();ToDoOnChange();"
                                runat="server">
                                <option selected></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdAltAdr">
                            Альтернативный адрес
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed2_style" id="ed_ADR_ALT" tabindex="5" type="text" maxlength="70"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdLimitOp">
                            Лимит на активные операции
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_LIM" tabindex="6" type="text" maxlength="20"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdLimitCash">
                            Лимит кассы
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_LIM_KASS" tabindex="7" type="text" maxlength="20"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdAgrNum">
                            № дог. за сопровождение
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_NOM_DOG" tabindex="8" type="text" maxlength="10"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdRegNumPDV">
                            № в реестре плательщиков ПДВ
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_NOMPDV" tabindex="9" type="text" maxlength="10"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdRegNumHold">
                            Рег. № холдинга
                        </td>
                        <td>
                        </td>
                        <td>
                            <input class="tab_main_rekv_ed_style" id="ed_RNKP" tabindex="10" type="text" maxlength="10"
                                onchange="ToDoOnChange();">
                        </td>
                    </tr>
                </table>
                <table style="font-size: 10pt; font-family: Arial" cellspacing="0" cellpadding="2"
                    width="100%">
                    <tr>
                        <td runat="server" meta:resourcekey="tdRemForSec" style="height: 1px" align="center">
                            Примечание для службы безопасности:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea onchange="ToDoOnChange();" class="tab_ek_norm_ed1_style" id="ed_NOTESEC"
                                style="width: 100%; height: 100px" tabindex="11"></textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
    <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
    <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
    <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
    <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
    <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
</div>
</body>
</html>
