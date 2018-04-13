<%@ Page Language="c#" Inherits="clientregister.tab_main_rekv" CodeFile="tab_main_rekv.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>tab_main_rekv</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script language="javascript" type="text/javascript" src="additionalFuncs.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>"></script>
    
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

    <script language="javascript" type="text/javascript" src="JScriptFortab_main_rekv.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>"></script>
    <script language="javascript" type="text/javascript" src="JScriptFortab_main_rekv_person.js?v=<%= barsroot.ServicesClass.GetVersionWeb() %>"></script>

    <script language="javascript" type="text/javascript">
        $(function () {
            $('.edit').change(function () {
                ToDoOnChange();
            });
            InitObjects();
        });
    </script>
    <style type="text/css">
        div.required
        {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }
        #tblMain td.checkbox
        {
            padding-left: 20px;
            height: 44px;
        }
        #tblEdits col.title
        {
            width: 200px;
            font-size: 10pt;
            font-family: Arial;
        }
        .edit
        {
            width: 150px;
            border: 1px solid #000000;
        }
        
        .edit.long
        {
            width: 300px;
        }
        .edit.date
        {
            text-align: center;
        }
        .edit.centered
        {
            text-align: center;
        }
        
        .edit.composite1-code
        {
            width: 45px;
            text-align: center;
        }
        .edit.composite1-value
        {
            width: 251px;
        }
        
        .edit.composite2-code
        {
            width: 125px;
            text-align: center;
        }
        .edit.composite2-value
        {
            width: 171px;
        }
        
        .ref
        {
            width: 20px;
        }
        /*клас помилки*/
        .err
        {
            background-color:#ffffd5;
            border:1px solid red;
            color:#000;
            /*background-color:#ffc0c0;
            border:1px solid red;*/
        }
    </style>
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
    <table id="tblEdits" border="0" cellpadding="1" cellspacing="0" style="">
        <col class="title" />
        <tr>
            <td runat="server" meta:resourcekey="tdRegDate">
                Дата регистрации
            </td>
            <td>
                <input class="edit date" id="ed_DATE_ON" disabled="disabled" tabindex="1" type="text"
                    maxlength="8" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdCloseDate">
                Дата закрытия
            </td>
            <td>
                <input class="edit date" id="ed_DATE_OFF" disabled="disabled" tabindex="2" type="text"
                    maxlength="8" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdRegN">
                Рег. №
            </td>
            <td>
                <input class="edit centered" id="ed_ID" disabled="disabled" tabindex="3" type="text"
                    maxlength="70" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdAgrN">
                № дог.
            </td>
            <td>
                <input class="edit centered" id="ed_ND" tabindex="4" type="text" maxlength="70" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdClientNameN">
                Наименование клиента (нац.)
            </td>
            <td>
                <input class="edit long" id="ed_NMK" tabindex="5" type="text" maxlength="70" onchange="getEl('ed_NMK').value = getEl('ed_NMK').value.toUpperCase();CopyNMK();" />
                <input id="bt_FullDopRekv" style="display:none;height: 24px" 
                    title="Режим ввода доп. реквизитов" class="ref" 
                    onclick="ShowInputFIO();"
                    type="button" value="..." tabindex="8" />
                <div class="required">*</div>
            </td>
        </tr>

        <tr class="trPersonFIO" id="trPersonFIO" style="display: none">
            <td colspan="2">
                <div style="float:right;margin:0 173px 0 0;width:320px">
                  <div style="float:right;margin:0">
                      Прізвище клієнта:
                      <input class="edit" id="ed_FIO_LN" tabindex="114" type="text" maxlength="70" />
                      <div class="required">*</div>
                  </div><br/>
                  <div style="float:right;margin:0">
                      Ім'я клієнта:
                      <input class="edit" id="ed_FIO_FN" tabindex="114" type="text" maxlength="70" />
                      <div class="required">*</div>
                  </div><br/>
                  <div style="float:right;margin:0 12px 0 0">
                      По-батькові клієнта:
                      <input class="edit" id="ed_FIO_MN" tabindex="114" type="text" maxlength="70" />
                  </div><br/>
                </div>
            </td>
        </tr>
        <tr class="trPersonFIONR" id="trPersonFIONR" style="display: none">
            <td colspan="2">
                <div style="float:right;margin:0 173px 0 0;border:1px solid #9b9b9b;width:320px">
                <div style="float:right;margin:0">
                    Ім'я-1 нерезидента:
                    <input class="edit" id="ed_FIO_LN_NR" tabindex="114" type="text" maxlength="70" />
                    <div class="required">*</div>
                </div>
                <div style="float:right;margin:0 12px 0 0">
                    Ім'я-2 нерезидента:
                    <input class="edit" id="ed_FIO_FN_NR" tabindex="114" type="text" maxlength="70" />
                </div>
                <div style="float:right;margin:0 12px 0 0">
                    Ім'я-3 нерезидента:
                    <input class="edit" id="ed_FIO_MN_NR" tabindex="114" type="text" maxlength="70" />
                </div>
                <div style="float:right;margin:0 12px 0 0">
                    Ім'я-4 нерезидента:
                    <input class="edit" id="ed_FIO_4N_NR" tabindex="114" type="text" maxlength="70" />
                </div>
                </div>
            </td>
        </tr>


        <tr>
            <td runat="server" meta:resourcekey="tdClientNameI">
                Наименование (межд.)
            </td>
            <td>
                <input class="edit long" id="ed_NMKV" tabindex="6" type="text" maxlength="70" onchange="getEl('ed_NMKV').value = getEl('ed_NMKV').value.toUpperCase();" />
                <div class="required">*</div>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdClientNameS">
                Наименование (краткое)
            </td>
            <td>
                <input class="edit long" id="ed_NMKK" tabindex="7" type="text" maxlength="35" onchange="getEl('ed_NMKK').value = getEl('ed_NMKK').value.toUpperCase();" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdClientAdres">
                Адрес клиента
            </td>
            <td>
                <input class="edit long" id="ed_ADR" tabindex="20" type="text" maxlength="70" />
                <input id="bt_fullADR" 
                        style="height: 24px"
                        title="Режим ввода полного адреса" 
                        class="ref" 
                        onclick="ShowfullADR();ToDoOnChange();"
                        type="button" 
                        value="..." tabindex="8" />
                <div class="required">*</div>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdClientChar">
                Характеристика клиента (К010)
            </td>
            <td>
                <select class="edit long" id="ddl_CODCAGENT" title="Выбор по нажатию левой кнопки мыши"
                    tabindex="9" onchange="OnCodecagentChange();">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdClientCountry">
                Страна клиента (К040)
            </td>
            <td>
                <input id="ed_COUNTRYCd" class="edit composite1-code" tabindex="10" type="text" maxlength="10"
                    onchange="OnCOUNTRYCdChange();" />
                <select class="edit composite1-value" id="ddl_COUNTRY" title="Выбор по нажатию левой кнопки мыши"
                    tabindex="11" onchange="PutCOUNTRYCd();">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdInsider">
                Признак инсайдера (К060)
            </td>
            <td>
                <select class="edit long" id="ddl_PRINSIDER" title="Выбор по нажатию левой кнопки мыши"
                    tabindex="12" runat="server">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdStateRegType">
                Тип гос. реестра
            </td>
            <td>
                <select class="edit long" id="ddl_TGR" title="Выбор по нажатию левой кнопки мыши"
                    tabindex="13">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdIdCode">
                Идентификационный код
            </td>
            <td>
                <input class="edit centered" id="ed_OKPO" onblur="checkOKPO(getEl('ed_OKPO'),true);" tabindex="14"
                    type="text" maxlength="10" />
                <div class="required">
                    *</div>
            </td>
        </tr>
        <tr id="trNRezidCode" style="display: none">
            <td runat="server">
                Код в країні реєстрації
            </td>
            <td>
                <input class="edit centered" id="edNRezidCode" tabindex="14" type="text" maxlength="25" />
                <div class="required">*</div>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdElCode">
                Электронный код клиента
            </td>
            <td>
                <input class="edit centered" id="ed_SAB" tabindex="15" type="text" maxlength="4" />
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdTypeExtract">
                Вид выписки
            </td>
            <td>
                <select class="edit long" id="ddl_STMT" title="Выбор по нажатию левой кнопки мыши"
                    tabindex="16" runat="server">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdBranchCode">
                Код безбаланс. отделения
            </td>
            <td>
                <input id="ed_TOBOCd" class="edit composite2-code" tabindex="17" type="text" maxlength="12"
                    onchange="OnTOBOCdChange();" runat="server" />
                <select class="edit composite2-value" id="ddl_TOBO" tabindex="18" onchange="PutTOBOCd();"
                    runat="server">
                </select>
            </td>
        </tr>
        <tr>
            <td runat="server" meta:resourcekey="tdNotClient">
                НЕ является клиентом банка
            </td>
            <td>
                <input id="ckb_BC" type="checkbox" size="20" onclick="ToDoOnChange();" />
            </td>
        </tr>
    </table>
    <input type="hidden" runat="server" id="forbt_fullADR" meta:resourcekey="forbt_fullADR" value="Режим ввода полного адреса" />
    <input type="hidden" id="Mes01" meta:resourcekey="Mes01" runat="server" value="Сервис заблокирован. Попробуйте снова через несколько секунд." />
    <input type="hidden" id="Mes10" meta:resourcekey="Mes10" runat="server" value="Страна не найдена" />
    <input type="hidden" id="Mes11" meta:resourcekey="Mes11" runat="server" value="Неверный Идентификационный Код!" />
    <input type="hidden" id="Mes12" meta:resourcekey="Mes12" runat="server" value="Введите полный адрес ->" />
    <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
    <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
    <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
    <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
    <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
    <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
    <input type="hidden" id="Mes19" meta:resourcekey="Mes19" runat="server" value="Веден неприпустимый символ" />
    </form>
    </div>
</body>
<script type="text/javascript" language="javascript">
    LocalizeHtmlTitle('bt_fullADR');
</script>
</html>
