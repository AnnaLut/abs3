<%@ Page Language="C#" Inherits="clientregister.tab_ek_norm" CodeFile="tab_ek_norm.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Экономические нормативы</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script language="javascript" type="text/javascript" src="additionalFuncs.js"></script>

    <link href="../Content/Themes/ModernUI/css/Style.css" rel="stylesheet" />
    <link href="../Content/Themes/ModernUI/css/jquery-ui.css" rel="stylesheet" />  
    <link href="../Content/Themes/ModernUI/css/buttons.css" rel="stylesheet" />
    <link href="../content/themes/modernui/css/tiptip.css" rel="stylesheet" />
    
    <script type="text/javascript" src="../Scripts/html5shiv.js"></script>
    
    <script type="text/javascript" src="../Scripts/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskMoney.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.numbermask.js"></script>
    <script type="text/javascript" src="../scripts/jquery/jquery.maskedinput-1.3.1.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script type="text/javascript" src="../Content/Themes/ModernUI/scripts/jquery.tiptip.js"></script>

    <script language="javascript" type="text/javascript" src="JScriptFortab_ek_norm.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>"></script>
</head>
<body>
    <div style="padding: 10px">
    <form id="Form1" method="post" runat="server">
    <asp:ScriptManager ID="sm" runat="server">
        <Services>
            <asp:ServiceReference Path="~/clientregister/defaultWebService.asmx" />
        </Services>
        <Scripts>
            <asp:ScriptReference Path="/barsroot/clientregister/XMLHttpSyncExecutor.js" />
        </Scripts>
    </asp:ScriptManager>
    <table class="tab_ek_norm_tb_main" id="tb_main" cellspacing="1" cellpadding="0">
        <tr>
            <td style="padding-left: 20px; height: 30px">
                <input id="ckb_main" onclick="MyChengeEnable(this.checked);ToDoOnChange();"
                    type="checkbox" checked="checked" />
                <div runat="server" meta:resourcekey="divEkNorm" class="simpleTextStyle" style="display: inline">
                    Заполнять Экономические нормативы</div>
            </td>
        </tr>
        <tr>
            <td style="font-size: 10pt; font-family: Arial">
                <table id="tb_ek_norm" style="font-size: 10pt; font-family: Arial" cellspacing="0"
                    cellpadding="0" width="100%" border="0">
                    <tr>
                        <td runat="server" meta:resourcekey="tdEKSec" style="width: 221px">
                            Инст. сек. экономики (К070)
                        </td>
                        <td height="1">
                            <input class="tab_ek_norm_ed1_style" id="ed_ISE" type="text" maxlength="5" onchange="GetIseCom(getEl('ed_ISE').value);ToDoOnChange();"
                                tabindex="1" />
                            <div style="display: inline; font-size: 12pt; width: 8px; color: red" id="lb_1">
                                *</div>
                        </td>
                        <td height="1">
                            <select class="tab_ek_norm_ed2_style" id="ddl_ISE_com" onclick="GetHelpValue(getEl('ed_ISE'), getEl('ddl_ISE_com'), 'ISE');ToDoOnChange();"
                                runat="server">
                                <option selected="selected"></option>
                            </select>
                        </td>
                    </tr>
                    <tr runat="server" id="trK080">
                        <td runat="server" meta:resourcekey="tdEKForm">
                            Форма собственности (К080)
                        </td>
                        <td height="1">
                          <input class="tab_ek_norm_ed1_style" id="ed_FS" tabindex="2" type="text" maxlength="2"
                                 onchange="GetFsCom(getEl('ed_FS').value);ToDoOnChange();" />
                          <div style="display: inline; font-size: 12pt; width: 8px; color: red" id="lb_2">*</div>
                        </td>
                        <td height="1">
                            <select class="tab_ek_norm_ed2_style" id="ddl_FS_com" onclick="GetHelpValue(getEl('ed_FS'), getEl('ddl_FS_com'), 'FS');GetFsCom(getEl('ed_FS').value);ToDoOnChange();">
                                <option selected="selected"></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdEKType">
                            Вид эк. деятельности (К110)
                        </td>
                        <td height="1">
                            <input class="tab_ek_norm_ed1_style" id="ed_VED" tabindex="3" type="text" maxlength="5"
                                onchange="GetVedCom(getEl('ed_VED').value);ToDoOnChange();">
                            <div style="display: inline; font-size: 12pt; width: 8px; color: red" id="lb_3">
                                *</div>
                        </td>
                        <td height="1">
                            <select class="tab_ek_norm_ed2_style" id="ddl_VED_com" onclick="GetHelpValue(getEl('ed_VED'), getEl('ddl_VED_com'), 'VED');ToDoOnChange();">
                                <option selected></option>
                            </select>
                        </td>
                    </tr>
                    <tr id="tr_OE" style="display: none;">
                        <td runat="server" meta:resourcekey="tdEKBranch">
                            Отрасль экономики (К090)
                        </td>
                        <td>
                            <input class="tab_ek_norm_ed1_style" id="ed_OE" tabindex="4" type="text" maxlength="5"
                                onchange="GetOeCom(getEl('ed_OE').value);ToDoOnChange();" />
                            <div style="display: inline; font-size: 12pt; width: 8px; color: red" id="lb_4">
                                *</div>
                        </td>
                        <td>
                            <select class="tab_ek_norm_ed2_style" id="ddl_OE_com" onclick="GetOEHelpValue();ToDoOnChange();">
                                <option selected></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td id="Td1" runat="server" meta:resourcekey="tdEKForm3" style="width: 221px">
                            Орг. правова ф-ма госп (К050)
                        </td>
                        <td>
                            <input class="tab_ek_norm_ed1_style" id="ed_K050" tabindex="5" type="text" maxlength="3"
                                onchange="GetK050Com(getEl('ed_K050').value);ToDoOnChange();" />
                            <div style="display: inline; font-size: 12pt; width: 8px; color: red" id="lb_5">*</div>
                        </td>
                        <td>
                            <select class="tab_ek_norm_ed2_style" id="ddl_K050_com" onclick="GetHelpValue(getEl('ed_K050'), getEl('ddl_K050_com'), 'SP_K050');ToDoOnChange();CalcSedValue(getEl('ed_K050').value);">
                                <option selected="selected"></option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td runat="server" meta:resourcekey="tdEKForm2" style="width: 221px">
                            Форма хозяйствования (К051)
                        </td>
                        <td>
                            <input class="tab_ek_norm_ed1_style" id="ed_SED" tabindex="6" type="text" maxlength="2"
                                disabled="disabled" />
                        </td>
                        <td>
                            <select class="tab_ek_norm_ed2_style" id="ddl_SED_com" disabled="disabled">
                                <option selected="selected"></option>
                            </select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <input type="hidden" id="Mes01" meta:resourcekey="Mes01" runat="server" value="Сервис заблокирован. Попробуйте снова через несколько секунд." />
    <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
    <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
    <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
    <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
    <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
    <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
    </form>
    </div>
</body>
</html>
