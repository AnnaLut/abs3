<%@ Page Language="c#" Inherits="BarsWeb.CheckInner.Documents" EnableViewState="False"
    CodeFile="documents.aspx.cs" CodeFileBaseClass="Bars.BarsPage" %>

<%@ Register Assembly="Bars.Web.Controls, Version=1.0.0.4, Culture=neutral, PublicKeyToken=464dd68da967e56c"
    Namespace="Bars.Web.Controls" TagPrefix="bars" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>Неоплаченые документы на контроле</title>
    <link href="CSS/AppStyles.css" type="text/css" rel="stylesheet">
    <script language="javascript" type="text/javascript" src="/Common/WebGrid/Grid2005.js?v1.0.1"></script>
    <script language="javascript" type="text/javascript" src="/Common/Script/Localization.js"></script>
    <link href="/Common/WebGrid/Grid.css" type="text/css" rel="stylesheet">
    <link href="../Areas/Teller/Css/atm.min.css" rel="stylesheet" />
    <script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.min.js"></script>
    <script language="javascript" type="text/javascript" src="/Common/jquery/jquery-ui.js"></script>
	<script type="text/javascript" src="/barsroot/Scripts/jquery/jquery.iecors.js"></script>
    <script type="text/javascript" src="/barsroot/Scripts/json3.min.js"></script>
    <script language="javascript" type="text/javascript" src="JScript/additionalFuncs.js?v=1.1"></script>
    <script language="javascript" type="text/javascript" src="JScript/Script_Documents.js?v=1.10"></script>
    <script language="JavaScript" type="text/javascript" src="/Common/Script/Sign.js?v=1.1"></script>
    <script type="text/javascript" src="/barsroot/Scripts/json3.min.js"></script>
    <script type="text/javascript" src="/barsroot/Areas/Teller/Scripts/TellerScript.js"></script>
    <script type="text/javascript" src="/Common/Script/BarsIe.js?v1.2"></script>

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

         .dispNone{
                display:none;
            }
         
        a.selected {
            background-color: #1F75CC;
            color: white;
            z-index: 100;
            display: block;
        }

        .messagepop {
            background-color: #FFFFFF;
            border: 1px solid #d9edf7;
            position: absolute;
            cursor: pointer;
            display: none;
            width: 220px;
            height: 90px;
            /*margin-top: 15px;
                position:absolute;
                text-align:left;
                z-index:50;
                padding: 25px 25px 20px;*/
        }

        .lab {
            margin-bottom: 3px;
            padding-left: 15px;
            text-indent: -15px;
        }

        .messagepop p, .messagepop.div {
            border-bottom: 1px solid #000000;
            background: #d9edf7;
            margin: 8px 0;
            padding-bottom: 8px;
        }


        td.resizing {
            cursor: col-resize;
        }

        #teller_button_container img{
            border: gray 1px double;
            padding: 2px;
            width: 20px;
            cursor: pointer;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var ShowDocDialog = 0;
        var key = false;
        var intervalObj = false;

        function showToolTip(evt, ctrlID, p_nd, p_datd, p_namea, p_mfoa, p_ida, p_nlsa, p_nameb, p_mfob, p_nb_b, p_idb, p_nlsb, p_s, p_kv, p_nazn, ref) {
            return;

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

        function getCookie(par) {
            var pageCookie = document.cookie;
            var pos = pageCookie.indexOf(par + '=');
            if (pos != -1) {
                var start = pos + par.length + 1;
                var end = pageCookie.indexOf(';', start);
                if (end == -1) end = pageCookie.length;
                var value = pageCookie.substring(start, end);
                value = unescape(value);
                return value;
            }
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

            Resize();

            InitAlert('modalDialog');
            HideProgress();


            /*******************************/
            /*для друку документів*/
            var port = (location.port != "") ? (":" + location.port) : ("");
            document.all.webService.useService(location.protocol + "//" + location.hostname + port + "/barsroot/docinput/DocService.asmx?wsdl", "Doc");
            var printTrnModel = getCookie("prnModel");
            if (printTrnModel) {
                document.getElementById("cbPrintTrnModel").checked = (printTrnModel == 1) ? (true) : (false);
            }

            $(window).resize(function () {
                onWindowResize();
            });

        });

        var prevStyles = {};
        //За v_row_style бегите в файл Grid2005.js!!!
        function SelectRow(val, id, mode) {
            if (mode != "" || mode != null) acces_mode = mode;
            if (selectedRow != null)
                selectedRow.style.backgroundColor = v_row_style;

            var el = document.getElementById('r_' + id);            
            v_row_style = el.style.backgroundColor;

            if (selectedRow != null) {
                selectedRow.style.color = prevStyles['color'];
                selectedRow.style.backgroundColor = prevStyles['bg'];
            }
            //Зберігаємо попередній стиль вибраного рядка
            prevStyles = { color: el.style.color, bg: el.style.backgroundColor };
            el.style.backgroundColor = '#778899';
            el.style.color = '#ffffff';

            selectedRow = el;
            row_id = id;
            selectedRowId = val;
            document.getElementById("row_id").value = val;
            if (v_FuncOnSelect != null) eval(v_FuncOnSelect + '()');
        }

        //Функція для зміни ширини гріда на основному вікні
        var Resize = function () {
            var pressed = false;
            var start = undefined;
            var startX, startWidth;

            $("td").mousedown(function (e) {
                start = $(this);
                pressed = true;
                startX = e.pageX;
                startWidth = $(this).width();
                $(start).addClass("resizing");
            });

            $(document).mousemove(function (e) {
                if (pressed) {
                    $(start).width(startWidth + (e.pageX - startX));
                }
            });

            $(document).mouseup(function () {
                if (pressed) {
                    $(start).removeClass("resizing");
                    pressed = false;
                }
            });
        };



        function ChangeColumn(parametr) {
            var MIN_W = 50;
            var MAX_W = 500;

            function c(p, obj) {
                var w = parseInt(col.width) + MIN_W * p;
                w = Math.max(w, MIN_W);
                w = Math.min(w, MAX_W);
                obj.width = w;
            };
            var tab = document.getElementById("tab");
            var col = {};
            for (var i = 1; i < tab.rows.length; i++) {
                col = tab.rows[i].cells.NAZNACHEN;
                c(parametr, col);
            }
            var th = document.getElementById("TH_NAZN");                    
            c(parametr, th);
        }

        




        var arrayForPrint = new Array();//масив з референсами відмічених документів
        function addCheckbox() {
            arrayForPrint.splice(0, arrayForPrint.length);
        }

        function editArrayForPrint(ref, elem) {

            if ($(elem).prop('checked') && getIndexRef(ref) === -1) {
                arrayForPrint.push(ref);
            }
            else if (!$(elem).prop('checked') && getIndexRef(ref) !== -1) {
                $('#mainChBox').removeAttr('checked');
                arrayForPrint.splice(getIndexRef(ref), 1);
            }
            if (arrayForPrint.length === 0) {
            }
        }

        function getIndexRef(ref) {
            var index = -1;
            for (var i = 0; i < arrayForPrint.length; i++) {
                if (arrayForPrint[i] === ref) {
                    return index = i;
                }
            }
            return index;
        }

        function selAllCheckbox(elem) {
            arrayForPrint.splice(0, arrayForPrint.length);
            if ($(elem).prop('checked')) {
                var allChBox = $('#oTable tr td input[type="checkbox"]');
                allChBox.each(function (index, elem) {
                    if (elem.id.indexOf("ch_stp") == -1) { //skip STP
                        elem.checked = true;
                        if (index > 0) {
                            var ref = $(elem).attr('id');
                            if (ref) arrayForPrint.push(ref.replace("chkb_",""));
                        }
                    }
                });
            }
            else {
                $('#oTable tr td input[type="checkbox"]').removeAttr('checked');
            }
        }
        function printSelDocum() {
            //todo: remove arrayForPrint !!!!!

            var docs4Print = [];
            var allChBox = $('#oTable tr td input[type="checkbox"]');
            allChBox.each(function (index, elem) {
                if (index > 0 && elem.checked && elem.id.indexOf("ch_stp") === -1){
                    var ref = $(elem).attr('id');
                    if (ref)
                        docs4Print.push(ref.replace("chkb_", ""));
                }
            });

            if (docs4Print.length > 0)
                getTicketFile(docs4Print);
            else
            {
                var msg = escape(LocalizedString('Message6')/*'Документы не отмечены!'*/);
                window.showModalDialog("dialog.aspx?type=1&message=" + msg, window, 'center:{yes};dialogheight:160px;dialogwidth:320px');
                return;
            }
            return false;
        }
        function getTicketFile(ref) {
            if ("" != ref)
                document.all.webService.Doc.callService(onPrint, "GetArrayFileForPrint", ref, document.getElementById("cbPrintTrnModel").checked);
            return false;
        }
        function onPrint(result) {
            if (!getError(result)) return;
            var arrPatch = result.value.split('~~$$~~');
            for (var i = 0; i < arrPatch.length; i++) {
                barsie$print(arrPatch[i]);
            }
        }
        function getError(result, modal) {
            if (result.error) {
                if (window.dialogArguments || parent.frames.length == 0 || modal) {
                    window.showModalDialog("dialog.aspx?type=err", "", "dialogWidth:800px;center:yes;edge:sunken;help:no;status:no;");
                }
                else
                    location.replace("dialog.aspx?type=err");
                return false;
            }
            return true;
        }

        function ddlSelectClick() {
            if (getEl('ddlGroupList').options.length > 0) {
                GetDocsList(getEl('lstb_Visa').item(getEl('lstb_Visa').selectedIndex).value)
            }
            else {
                alert(LocalizedString('Message0'));
            }
        }

        function changeGroup(){
            location.replace('/barsroot/checkinner/default.aspx?type=2');
        }

        ////========================== Teller ===========================////

        function GetRef() {
            var chks = $('input[name=cnkbox][type=checkbox]');
            if (!getSelectedCount(chks))
                return;
            var element = getSelectedObject(chks);
            if (!element) {
                showNotification("", 'error');
                return;
            }
            var first = $(element).parent().parent();
            var list = $(first).children();
            var ref = $(list[3]).text();
            if (!ref) {
                showNotification("", 'error');
                return;
            }
            return ref;
        }

        function GetSWI() {
            return '0';
        }

        function Restore(currentSum, status) {
            if (currentSum == '-1')
                return;
            var dif = +parseFloat($("#atm-sum-dif").val()).toFixed(2);
            var operSum = +parseFloat($('#atm-sum-txt').text()).toFixed(2);
            $('#atm-in-out-sum').text(currentSum);
            var difSum = +parseFloat(operSum - currentSum).toFixed(2);
            $("#atm-sum-dif").val(difSum);
            if (difSum < 0) {
                difSum *= -1;
                $('#atm-tempo-in-out-info').text('видати з темпокаси');
                if (status == 'OUT')
                    $('#atm-tempo-in-out-info').text('внести в темпокасу');
                else if (status == 'IN')
                    $('#atm-tempo-in-out-info').text('видати з темпокаси');
            }
            $('#atm-sum-tempo').text(difSum);
        }

        function getSelectedObject(elements) {
            var obj = null;
            for (var i = 0; i < elements.length; ++i) {
                if (elements[i].checked) {
                    obj = elements[i];
                    break;
                }
            }
            return obj;
        }

        function getSelectedCount(elements) {
            var count = 0;
            for (var i = 0; i < elements.length; ++i)
                if (elements[i].checked)
                    ++count;
            if (count === 0) {
                showNotification('Жодної строки не було вибрано!');
                return false;
            }
            else if (count > 1) {
                showNotification('Вибрано забагато строк!');
                return false;
            }
            return true;
        }

        $('document').ready(function () {
            if (zElementIndex) {
                zElementIndex.down = 390;
                zElementIndex.middle = 395;
                zElementIndex.up = 401;
                showHide = new ElementsVisibility();
                intervalObj = new StatusInterval();
            }
            $(window).resize(function () {
                onWindowResize();
            });
        });

    </script>
</head>
<body>
    <div id="preloader">
    <div id="preloader-background"></div>
        <div class="preloader-container">
            <div class="preloader-text" id="preloader-text">
                <h1 id="text-oper" class="preloader-text-header animated flash">Зачекайте, виконується операція</h1>
            </div>
            <div class="preloader-image-container">
                <img src="/barsroot/Content/spinners/loader.gif" alt="image/gif" id="teller-preloader-image" />
            </div>
        </div>
    </div>
    <div id="teller-notification-window" style="display: none;">
        <div id="atm-header">
            <label class="teller-head-txt" id="teller-notify-head-text">Інформація</label>
        </div>
        <div id="teller-notofication-txt"> Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест Тест</div>
        <div id="atm-notify-button-area">
            <a class="atm-button atm-color-green atm-confirm-button-width" onclick="notificationClose()">ОК</a>
        </div>
    </div>
    <div id="atm-window-container"></div>

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
            <tr style="height:20px;">
                <td style="border-bottom: black 2px solid" valign="middle">
                    <table cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td class="simpleTextStyle" nowrap>[<a class="greenText" id="lb_GroupName" runat="server"></a>]&nbsp;
                                [<span class="greenText" id="lbAggs" title="[кількість|сума]"></span>]
                                [<span class="greenText" id="lblSumm" runat="server"></span>]
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
                            <td  style="padding-right: 5px; width: 1px">
                                <bars:imagetextbutton meta:resourcekey="tellerProc" runat="server" class="outset" id="tellerProc" title="Виконати операцію з Теллером" 
                                    onclientclick="TellerWindow();return false;" align="top" style="visibility: visible;" Text="Теллер"
                                    imageurl="/barsroot/Content/images/PureFlat/16/Hot/money_banknote-server.png" tooltip="Виконати операцію з Теллером"/>
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
                            <td style=" padding-left:5px; padding-right: 5px; width: 1px">
                                <bars:imagetextbutton id="bt_Storno" meta:resourcekey="bt_Storno" runat="server"
                                    text="Сторно" tooltip="Сторнировать" imageurl="/Common/Images/default/16/visa_storno.png"
                                    onclientclick="StornoButtonPressed();return false;" />
                            </td>
			    <td style="padding-right: 5px; width: 1px">
                                <input class="buttonCheckStyle" runat="server" id="bt_select" meta:resourcekey="bt_select" type="button" value="Вибір групи контролю" onclick="changeGroup()"/>
                            </td>
                            <TD width="100%" align="left" style="PADDING-LEFT: 10px; WIDTH: 100%">
                                             <div id="printPanel">
                                                <button id="bt_Print" title="Друк відмічених документів" onclick="printSelDocum();">
                                                    <img alt="" title="Друк відмічених документів" src="/common/images/default/16/print.png" />
                                                    <span>друк</span>
                                                </button>
                                                <input type="checkbox" id="cbPrintTrnModel" />
                                                <label for="cbPrintTrnModel" style="font-size:12px;">друкувати бухмодель</label>
                                            </div>
                                        </TD>
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
                    <input id="__SSP" type="hidden" runat="server">
                    <input id="__CERTNAME" type="hidden" runat="server">
                    <input id="__SIGN_MIXED_MODE" type="hidden" runat="server" />
                    <input id="__USER_SIGN_TYPE" type="hidden" runat="server" />
                    <input id="__USER_KEYID" type="hidden" runat="server" />
                    <input id="__USER_KEYHASH" type="hidden" runat="server" />
                    <input id="__CRYPTO_USE_VEGA2" type="hidden" runat="server" />
                    <input id="__CRYPTO_CA_KEY" type="hidden" runat="server" />
                    <input id="__ISTELLERACTIVE" type="hidden" runat="server" />
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
    <script type="text/javascript">
        var currSum = 0;


    function arrayContains(element, arr) {
        var i = arr.length;
        element = element.substring(0, element.length - 1);
        while (i--) {
            var el = arr[i];
            if (i == arr.length-1)
                el = el.substring(0, el.length - 1);
            el = el.replace(/\s/g, '');
            element = element.replace(/\s/g, '');
            if (el === element) {
                return true;
            }
        }
        return false;
    }

    function ManualKalkulateGrid(colmn_num) {
        //getting grid info
        // 
        var gridInfo = [];
        for (var i = 1; i < 1000; i++) {
            var elements = $("#r_" + i).children();
            if (elements.length <= 0)
                break;
            var innerGrid = [];
            for (var j = 1; j < elements.length-1; j++) {
                innerGrid.push(elements[j].innerHTML)
            }
            gridInfo.push(innerGrid);
        }
         
        //select All
        var allSelectedItems = "";
        if (window.getSelection) {  // all browsers, except IE before version 9
            var allSelectedItems = window.getSelection();
        }
        else {
            if (document.selection.createRange) { // Internet Explorer
                var allSelectedItems = document.selection.createRange();
            }
        }
         
        allSelectedItems = allSelectedItems.text.split("\n");

        for (var i = 0; i < allSelectedItems.length; i++) {
            allSelectedItems[i] = allSelectedItems[i].replace(/^\s+|\s+$/gm, '').replace(" ", "");
            if (i < allSelectedItems.length - 1) {
                allSelectedItems[i] = allSelectedItems[i].substring(0, allSelectedItems[i].length - 1);
            }
        }
         
        var selectedObjects = [];
        for (var i = 0; i < gridInfo.length; i++) {
            var str = gridInfo[i].join("").replace(" ", "");
            if (arrayContains(RemoveSyms(str), allSelectedItems)) {
                selectedObjects.push(gridInfo[i]);
            }
        }
         
        if (selectedObjects.length > 1) {
            var tittles = $("tr[align=center]").children()[colmn_num].innerHTML;
            var my_sum = 0;
            var col = colmn_num-1;
             
            if (isNaN(parseFloat(selectedObjects[0][col])) || selectedObjects[0][col].indexOf('.') < 0 || selectedObjects[0][col].split(".").length > 2) {
                return { "comn": tittles, "sum": "Поле неможливо просумувати" };
            }
            for (var i = 0; i < selectedObjects.length; i++) {
                if (selectedObjects[i][col] == '')
                    continue;
                my_sum += parseFloat(selectedObjects[i][col].replace(/\D/g, '')) / 100;
            }
            return { "comn": tittles, "sum": my_sum.toFixed(2).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ') };
        } else {
            return "none";
        }
         
        var identifier = parseFloat(selectedObjects);
        if (parseFloat)
            selectedObjects;

    }

    function RemoveSyms(str) {
        var s2 = str.replace(/<.*">/, '')
        s3 = s2.replace(/<.*>/, '')
        return s3;

    }

    $(document).on("click", function () { summSumm(); additemToPopup(); });

    function summSumm() {

        var lblSumm = document.getElementById('lblSumm');

        var grpId = document.getElementById('hid_grpid').value;
        var chkbList = document.getElementsByName('cnkbox');
        var chkbListChecked = new Array();
     
        var idx = 0;
        for (i = 0; i < chkbList.length; i++) {
            if (chkbList[i].checked) {
                chkbListChecked[idx] = chkbList[i].id.substring(5);
                idx++;
            }
        }

        var summ = 0;
        for (i = 0; i < chkbListChecked.length; i++) {
            var summObj = document.getElementById('sum_' + chkbListChecked[i]);
            var summText = summObj.innerText;
            summText = summText.replace(/ /g, '');

            var summFloat = (summText == '' ? 0 : parseFloat(summText));
            summ += summFloat;
        }

        if (currSum != summ) {
            currSum = summ;
            lblSumm.innerText = 'Вибрано: ' + chkbListChecked.length + '; Сума: ' + currSum.toFixed(2);
            //alert(summ);
        }
        



        //$("input:checked").each(function () {
        //    // Use $(this) here
        //    sum += parseFloat(elem[10].html(), 10);
        //    // Always use the optional radix to parseInt() -----^^^^^
        //});
        //---------------------------<
    }


    function additemToPopup() {
        for (var i = 1; i < 1000; i++) {
            var elements = $("#r_" + i).children();
            if (elements.length <= 0) {
                deselect($('#contact'));
                $("#popupsum").hide();
                $('.pop').css({ top: 100, left: 10000000 }).hide();
                break;
            }

            for (var j = 1; j < elements.length -1; j++) {              
                eval(
                    "elements[j].onmouseover =  function () {" +
                    "var res = ManualKalkulateGrid(" + j + ");" +
                    "if (res === 'none') {" +
                    "    deselect($('#contact')); " +
                    "    return;" +
                    "} else {" +
                     "    $('#cust_colm_Name')[0].innerHTML = res.comn;" +
                     "    $('#cust_colm_Sum')[0].innerHTML = res.sum;}" +
                    "    if ($(this).hasClass('selected')) { deselect($(this)); } else { $(this).addClass('selected'); $('.pop').slideFadeToggle(); }" +
                    "    $('#popupsum').show();" +
                    "    $('.pop').css({ top: window.event.clientY+15, left: window.event.clientX }).show(); " +
                    "    return false;" +
                    "};");

                elements[j].onmouseout = function () {
                     
                    deselect($('#contact'));
                    //$("#popupsum").hide();
                    //hide window in right part out of screen
                    //Ie8 solution
                   $('.pop').css({ top: 100, left: 10000000 }).hide();
                    return false;
                };
            }
        }
    }




    function deselect(e) {
        $('.pop').slideFadeToggle(function () {
            e.removeClass('selected');
        });
    }
    $.fn.slideFadeToggle = function (easing, callback) {
        return this.animate({ opacity: 'toggle', height: 'toggle' }, 0, easing, callback);
    };


</script>
<div id="popupsum" class="messagepop pop">
    <div id="cust_colm_Name"></div>
    <div id="cust_colm_Sum"></div>
</div>
</html>
