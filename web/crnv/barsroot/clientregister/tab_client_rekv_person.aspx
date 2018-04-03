<%@ Page Language="c#" Inherits="clientregister.tab_client_rekv_person" CodeFile="tab_client_rekv_person.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Реквизиты клиента "Физ. лицо"</title>
    <link href="DefaultStyleSheet.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
    <script language="javascript" type="text/javascript" src="JScriptFortab_client_rekv_person.js?v1.3"></script>
    <script language="javascript" type="text/javascript" src="additionalFuncs.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $('.edit').change(function () {
                ToDoOnChange();
            });
            InitObjects();
        });
    </script>
    <style type="text/css">
        div.required {
            display: inline;
            font-size: 12pt;
            width: 8px;
            color: red;
            height: 18px;
        }

        #tblMain {
        }

            #tblMain td.checkbox {
                padding-left: 20px;
                height: 44px;
            }

        #tblEdits {
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
        <table id="tblMain" border="0" cellpadding="2" cellspacing="0">
            <tr>
                <td class="checkbox">
                    <input id="ckb_main" onclick="MyChengeEnable(getEl('ckb_main').checked); ToDoOnChange();"
                        tabindex="1" type="checkbox" checked="checked" />
                    <div runat="server" meta:resourcekey="divPersInfo" class="simpleTextStyle" style="display: inline">
                        Заполнять Персональные реквизиты
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="tblEdits" border="0" cellpadding="2" cellspacing="0">
                        <col class="title" />
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocType">Вид документа
                            </td>
                            <td>
                                <select class="edit" id="ddl_PASSP" tabindex="2" runat="server" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); ">
                                    <option selected="selected"></option>
                                </select>
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdSerial">Серия
                            </td>
                            <td>
                                <input class="edit" id="ed_SER" tabindex="3" type="text" maxlength="10" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); " onkeypress="return CheckDocSeries('ed_SER', 'ddl_PASSP'); " />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocNumber">Номер док.
                            </td>
                            <td>
                                <input class="edit" id="ed_NUMDOC" tabindex="4" type="text" maxlength="20" onchange="ValidateDocument(getEl('ddl_PASSP'), getEl('ed_SER'), getEl('ed_NUMDOC')); " onkeypress="return CheckDocNumber('ed_NUMDOC', 'ddl_PASSP'); " />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdOrg">Кем выдан
                            </td>
                            <td>
                                <input class="edit long" id="ed_ORGAN" tabindex="5" type="text" maxlength="70" />
                                <img id="bt_help" runat="server" meta:resourcekey="btHelp" src="/Common/Images/HELP.gif"
                                    class="reference" alt="Справка" onclick="GetOrganHelp();ToDoOnChange();" />
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdDocDate">Когда выдан
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
                            <td runat="server" meta:resourcekey="tdBirthDay">Дата рождения
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
                            <td runat="server" meta:resourcekey="tdBirthPlace">Место рождения
                            </td>
                            <td>
                                <input class="edit long" id="ed_BPLACE" tabindex="8" type="text" maxlength="70" />
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdSex">Пол
                            </td>
                            <td>
                                <select class="edit" id="ddl_SEX" tabindex="9" runat="server">
                                    <option selected="selected"></option>
                                </select>
                                <div class="required">
                                    *
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" meta:resourcekey="tdHomePhone">Дом. тел.
                            </td>
                            <td>
                                <input class="edit" id="ed_TELD" tabindex="10" type="text" maxlength="20" />
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
        <input type="hidden" id="Mes13" meta:resourcekey="Mes13" runat="server" value="Дата введена с ошибкой." />
        <input type="hidden" id="Mes14" meta:resourcekey="Mes14" runat="server" value="Месяц записан с ошибкой." />
        <input type="hidden" id="Mes15" meta:resourcekey="Mes15" runat="server" value="Число указано с ошибкой." />
        <input type="hidden" id="Mes16" meta:resourcekey="Mes16" runat="server" value="Неправильный формат даты. Используйте формат dd.MM.yyyy" />
        <input type="hidden" id="Mes17" meta:resourcekey="Mes17" runat="server" value="Введите число" />
        <input type="hidden" id="Mes18" meta:resourcekey="Mes18" runat="server" value="Заполните поле" />
    </form>
</body>
</html>
