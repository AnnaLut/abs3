<%@ Page Language="c#" Inherits="BarsWeb.CheckInner.Documents" EnableViewState="False"
    CodeFile="documents.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>

<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Неоплаченые документы на контроле</title>
    <link href="CSS/AppStyles.css" type="text/css" rel="stylesheet">
    <script language="javascript" type="text/javascript" src="/Common/WebGrid/Grid2005.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <script language="javascript" type="text/javascript" src="JScript/additionalFuncs.js?v=1.1"></script>
    <script language="javascript" type="text/javascript" src="JScript/Script_Documents.js?v=1.6"></script>
    <script language="JavaScript" type="text/javascript" src="/Common/Script/Sign.js?v=1.1"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
    <link type="text/css" rel="stylesheet" href="/Common/CSS/jquery/jquery.css" />
    <style type="text/css">
        .doc_tooltip {
            border: 1px solid #ccd9ff;
            background-color: #eaf3ff;
            padding: 10px;
            width: 450px;
            position: absolute;
            display: none;
        }

            .doc_tooltip table {
                width: 420px;
            }

            .doc_tooltip td {
                font-size: 8pt;
            }

            .doc_tooltip span {
                font-weight: bold;
            }

            .doc_tooltip .sum {
                font-size: 9pt;
                font-weight: bold;
                color: #002ba9;
            }

            .doc_tooltip .separator {
                height: 10px;
            }

        .progress {
            position: absolute;
            left: 50%;
            top: 50%;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var ShowDocDialog = 0;

        function showToolTip(evt, ctrlID, p_nd, p_datd, p_namea, p_mfoa, p_ida, p_nlsa, p_nameb, p_mfob, p_nb_b, p_idb, p_nlsb, p_s, p_kv, p_nazn) {
            if (ShowDocDialog == 0) return;

            $('#nd').text(p_nd);
            $('#datd').html(p_datd);
            $('#namea').html(p_namea);
            $('#mfoa').html(p_mfoa);
            $('#ida').html(p_ida);
            $('#nlsa').html(p_nlsa);
            $('#nameb').html(p_nameb);
            $('#mfob').html(p_mfob);
            $('#nb_b').html(p_nb_b);
            $('#idb').html(p_idb);
            $('#nlsb').html(p_nlsb);
            $('#s').html(p_s);
            $('#kv ').html(p_kv);
            $('#nazn').html(p_nazn);

            var overlayX = document.body.clientWidth - (evt.clientX + $("#docTooltip").width());
            var overlayY = document.body.clientHeight - (evt.clientY + $("#docTooltip").height());

            var x = overlayX > 0 ? evt.clientX + 10 : evt.clientX - $("#docTooltip").width() - 10;
            var y = overlayY > 0 ? evt.clientY + 10 + document.body.scrollTop : evt.clientY - $("#docTooltip").height() - 10 + document.body.scrollTop;

            $("#docTooltip").css({ top: y, left: x }).show();
        }
        function hideToolTip() {
            $('#docTooltip').hide('fast');
        }


        // прогресс бар
        function ShowProgress() {
            $('#imgProgress').show();
        }
        function HideProgress() {
            $('#imgProgress').hide();
        }

        // первичная инициализация
        $(function () {
            InitOjects();
            InitAlert('modalDialog');
            HideProgress();
        });
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <asp:ScriptManager ID="sm" runat="server">
            <Services>
                <asp:ServiceReference Path="/barsroot/checkinner/Service.asmx" />
            </Services>
            <Scripts>
                <asp:ScriptReference Path="/Common/Script/XMLHttpSyncExecutor.js" />
            </Scripts>
        </asp:ScriptManager>
        <div id="modalDialog" title="Повідомлення"></div>
        <div id="docTooltip" class="doc_tooltip" onclick="hideToolTip(); ">
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td>№ <span id="nd"></span>від <span id="datd"></span>
                    </td>
                    <td align="right" class="sum">Сума: <span id="s"></span>(<span id="kv"></span>)
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="separator"></td>
                </tr>
                <tr>
                    <td colspan="2">Платник: <span id="namea"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">МФО: <span id="mfoa"></span>, ЗКПО: <span id="ida"></span>, рах: <span id="nlsa"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="separator"></td>
                </tr>
                <tr>
                    <td colspan="2">Отримувач: <span id="nameb"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">МФО: <span id="mfob"></span>, <span id="nb_b"></span></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">ЗКПО: <span id="idb"></span>, рах: <span id="nlsb"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="separator"></td>
                </tr>
                <tr>
                    <td colspan="2">Призначення:
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span id="nazn"></span>
                    </td>
                </tr>
            </table>
        </div>
        <img id="imgProgress" alt="Завантаження" class="progress" src="/Common/Images/process.gif" />
        <table cellspacing="0" cellpadding="0" width="100%">
            <tr height="20">
                <td style="border-bottom: black 2px solid" valign="middle">
                    <table cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td class="simpleTextStyle" nowrap>[<a class="greenText" id="lb_GroupName" runat="server"></a>]&nbsp;[<span class="greenText"
                                id="lbAggs" title="[кількість|сума]"></span>]
                            </td>
                            <td width="100%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 3px; padding-top: 3px; border-bottom: black 2px solid; height: 10px">
                    <table style="width: 100%">
                        <tr>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_Refresh" meta:resourcekey="bt_Refresh" runat="server"
                                    text="Обновить" tooltip="Обновить данные" imageurl="/Common/Images/default/16/refresh_table.png"
                                    onclientclick="RefreshButtonPressed();return false;" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_Filter" meta:resourcekey="bt_Filter" runat="server"
                                    text="Фильтр" tooltip="Установить фильтр" imageurl="/Common/Images/default/16/filter.png"
                                    onclientclick="FilterButtonPressed();return false;" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:separator id="sprt1" runat="server" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_PutVisa" meta:resourcekey="bt_PutVisa" runat="server"
                                    text="Виза" tooltip="Виза" imageurl="/Common/Images/default/16/visa.png" onclientclick="PutVisaButtonPressed(0);return false;" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:separator id="sprt2" runat="server" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_OneStepBack" meta:resourcekey="bt_OneStepBack" runat="server"
                                    text="Возврат" tooltip="Возврат на одну визу" imageurl="/Common/Images/default/16/visa_back.png"
                                    onclientclick="OneStepBackButtonPressed();return false;" />
                            </td>
                            <td style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_Storno" meta:resourcekey="bt_Storno" runat="server"
                                    text="Сторно" tooltip="Сторнировать" imageurl="/Common/Images/default/16/visa_storno.png"
                                    onclientclick="StornoButtonPressed();return false;" />
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="border-bottom: black 2px solid" valign="top">
                    <div class="webservice" id="webService" showprogress="true">
                    </div>
                </td>
            </tr>
            <tr>
                <td style="padding-top: 3px" valign="top"></td>
            </tr>
            <tr>
                <td style="padding-top: 3px" valign="top">
                    <div id="div_visas" style="border-right: black 1px; border-top: black 1px; border-left: black 1px; width: 100%; border-bottom: black 1px; height: 100px">
                        <table style="font-size: 10pt; font-family: Arial" cellspacing="0" bordercolordark="#ffffff"
                            cellpadding="0" bordercolorlight="black" border="1" width="100%">
                            <tr style="color: white; background-color: gray; text-align: center">
                                <td runat="server" meta:resourcekey="td1" class="cellStyle" width="200">Группа
                                </td>
                                <td runat="server" meta:resourcekey="td2" class="cellStyle" width="180">Отметка
                                </td>
                                <td runat="server" meta:resourcekey="td3" class="cellStyle">Исполнитель
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <input id="hid_grpid" style="width: 16px; height: 22px" type="hidden" size="1" runat="server">
        <input id="hid_isselfvisa" style="width: 16px; height: 22px" type="hidden" size="1"
            runat="server">
        <!-- Параметры для визирования -->
        <table style="display: none; z-index: 102; left: 8px; visibility: hidden; position: absolute; top: 672px">
            <tr>
                <td>
                    <input id="__BDATE" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__SYSDATE" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__OURMFO" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__SIGNCC" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__DOCKEY" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__REGNCODE" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__DOCREF" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__INTSIGN" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__VISASIGN" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__SIGNTYPE" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__SIGNLNG" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__SEPNUM" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__VOB2SEP" type="hidden" runat="server">
                </td>
                <td>
                    <input id="__CERTNAME" type="hidden" runat="server">
                </td>
            </tr>
        </table>
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
        <input runat="server" type="hidden" id="Message1" meta:resourcekey="Message1" value="Введите дату(пример 22.11.1984)!" />
        <input runat="server" type="hidden" id="Message2" meta:resourcekey="Message2" value="Введите число!" />
        <input runat="server" type="hidden" id="Message3" meta:resourcekey="Message3" value="Заполните поле!" />
        <input runat="server" type="hidden" id="Message4" meta:resourcekey="Message4" value="Открыть карточку документа" />
        <input runat="server" type="hidden" id="Message5" meta:resourcekey="Message5" value="Сторнирование отменено!" />
        <input runat="server" type="hidden" id="Message6" meta:resourcekey="Message6" value="Документы не отмечены!" />
        <input runat="server" type="hidden" id="Message7" meta:resourcekey="Message7" value="Визировать отмеченные документы?" />
        <input runat="server" type="hidden" id="Message8" meta:resourcekey="Message8" value="Сторнировать отмеченные документы?" />
        <input runat="server" type="hidden" id="Message9" meta:resourcekey="Message9" value="Вернуть на одну визу отмеченные документы?" />
        <input runat="server" type="hidden" id="Message10" meta:resourcekey="Message10" value="Нет документов для визирования!" />
        <input runat="server" type="hidden" id="Message11" meta:resourcekey="Message11" value="на сумму " />
        <input runat="server" type="hidden" id="Message12" meta:resourcekey="Message12" value="документов" />
        <input type="hidden" runat="server" id="titleDocuments" meta:resourcekey="titleDocuments"
            value="Неоплаченые документы на контроле" />
        <script language="javascript" type="text/javascript">
            window.document.title = LocalizedString('titleDocuments');
        </script>
    </form>
</body>
</html>
