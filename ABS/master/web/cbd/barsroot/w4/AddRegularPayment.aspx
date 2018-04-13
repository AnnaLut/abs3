<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddRegularPayment.aspx.cs" Inherits="w4_AddRegularPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.common.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/kendo.dataviz.bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/Themes/Kendo/Styles.css" rel="stylesheet" />
    <link href="../Content/images/PureFlat/pf-icons.css" rel="stylesheet" />
    <script src="../Scripts/jquery/jquery.js"></script>
    <script src="../Scripts/bootstrap/bootstrap.min.js"></script>
    <script src="../Scripts/jquery/jquery.bars.ui.js"></script>
    <script src="../Scripts/kendo/kendo.all.min.js"></script>
    <script src="../Scripts/kendo/kendo.aspnetmvc.min.js"></script>
    <script src="../Scripts/kendo/kendo.timezones.min.js"></script>

    <script src="../Scripts/kendo/cultures/kendo.culture.uk.min.js"></script>
    <script src="../Scripts/kendo/cultures/kendo.culture.uk-UA.min.js"></script>
    <script src="../Scripts/kendo/messages/kendo.messages.uk-UA.min.js"></script>

    <%:Scripts.Render("~/bundles/bars")%>
</head>
<body>
    <div>
        <h1>Реєстрація договорів на виконання регулярних платежів</h1>
        <form id="AddRegularPaymentForm" runat="server" >
            <div id="saveResult" runat="server"></div>
            <style>
                #AddRegularPaymentForm table tr td {
                    padding: 1px;
                }

                .validate-message {
                    border-bottom: 1px solid gray;
                    margin-bottom: 5px;
                }
            </style>

            <div style="padding-left: 15px;">
                <table border="0">
                    <tr>
                        <td>
                            <span id="lbNlsA" runat="server" title="Рахунок відправника" class="k-label">Рахунок відправника
                            </span>
                        </td>
                        <td>
                            <input id="tbNlsA" type="text" runat="server" class="k-textbox" maxlength="14" title="Номер рахунку" tabindex="1" readonly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbNmkA" runat="server" title="Назва клієнта-платника" class="k-label" style="width: 300px">Назва клієнта-платника
                            </span>
                        </td>
                        <td>
                            <input id="tbNmkA" runat="server" type="text" class="k-textbox"
                                maxlength="35" title="Назва клієнта" tabindex="2" style="width: 300px" readonly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbNumb" runat="server" title="Номер платіжної інструкції" class="k-label">Номер
                            </span>
                        </td>
                        <td>
                            <input id="tbNumb" type="text" runat="server" class="k-textbox" title="Номер платіжної інструкції" tabindex="3" readonly="true" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbMfoB" runat="server" class="k-label">МФО отримувача</span>
                        </td>
                        <td>
                            <input id="tbMfoB" runat="server" type="text" class="k-textbox"
                                maxlength="12" title="МФО отримувача" tabindex="4" onblur="showReferIco()" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbNlsB" runat="server" title="Номер особового рахунку отримувача" class="k-label">Рахунок отримувача
                            </span>
                        </td>
                        <td>
                            <input type="text" class="k-textbox" id="tbNlsB" runat="server" maxlength="14" tabindex="5" />
                            <a class="k-button" onclick='showAccountsReferen(); return false;' id="icoNlsB">
                                <i class="pf-icon pf-16 pf-book"></i>
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbOkpoB" runat="server" class="k-label">Код ЄДРПОУ отримувача</span>
                        </td>
                        <td>
                            <input id="tbOkpoB" runat="server" type="text" class="k-textbox"
                                maxlength="10" title="Код ОКПО" tabindex="6" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbNmkB" runat="server" class="k-label">Назва клієнта-отримувача</span>
                        </td>
                        <td>
                            <input id="tbNmkB" runat="server" type="text" class="k-textbox"
                                maxlength="38" title="Назва клієнта-отримувача" tabindex="7" style="width: 300px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbSum" runat="server" class="k-label">Сума</span>
                        </td>
                        <td>
                            <input id="tbSum" type="text" runat="server" class="k-textbox" title="Сума" tabindex="8" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbNazn" runat="server" class="k-label">Призначення платежу</span>
                        </td>
                        <td>
                            <textarea id="taNazn" rows="4" tabindex="9" style="width: 300px" class="k-textbox" runat="server" title="Призначення платежу" maxlength="160"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbStartDate" runat="server" class="k-label">Дата з</span>
                        </td>
                        <td>
                            <input id="StartDate" type="text" tabindex="10" runat="server" class="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbEndDate" runat="server" class="k-label">Дата по</span>
                        </td>
                        <td>
                            <input id="EndDate" type="text" tabindex="11" runat="server" class="" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbPeriod" runat="server" class="k-label">Періодичність виконання</span>
                        </td>
                        <td>
                            <select id="Period" runat="server" tabindex="12" class="k-dropdown k-textbox"></select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span id="lbPrior" runat="server" class="k-label">Прiоритет виконання</span>
                        </td>
                        <td>
                            <select id="Prior" runat="server" tabindex="13" class="k-dropdown k-textbox"></select>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 10px;">
                            <a id="btReg" onclick="savePayment(); return false;" tabindex="14" data-role="button" class="k-primary k-button k-button-icontext" role="button" aria-disabled="false" tabindex="0">
                                <span class="k-sprite k-icon k-i-tick"></span>
                                Зберегти
                            </a>
                            <input id="btPrint" onclick="printDocum(); return false;" tabindex="15" type="button" value="Друк" runat="server" class="k-button" />
                        </td>
                    </tr>
                </table>
            </div>
        </form>
        <span id="popupError" style="display: none;"></span>
      <script>
            $(function () {
                $.ajaxSetup({
                    // Disable caching of AJAX responses
                    cache: false
                });

                $('#StartDate,#EndDate').kendoMaskedTextBox({
                    mask: "99/99/9999"
                }).kendoDatePicker({
                    culture: "uk-UA",
                    format: "dd/MM/yyyy"
                }).removeClass('k-textbox').parent().parent().removeClass('k-textbox');

                $("#popupError").kendoNotification({
                    stacking: "down",
                    show: onShowPopupError,
                    autoHideAfter: 40000,
                    width: '350px',
                    templates: [{
                        type: "error",
                        template: '<div style="padding:10px;">\
                     <div class="k-notification-wrap"><h3 style="margin-top:0"><span class="k-icon k-i-note">error</span> #= title #</h3><span class="k-icon k-i-close">Hide</span></div>\
                        <p>#= message #</p>\
                    </div>'
                    }],
                    button: true
                });

                $("#tbNlsB,#tbMfoB,#tbOkpoB").keyup(function (event) {
                    if (event.keyCode != 37 && event.keyCode != 39 && event.keyCode != 46 && event.keyCode != 8 && event.keyCode <= 96 && event.keyCode >= 105 && event.keyCode != 35 && event.keyCode != 36) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    }
                });
                $("#tbSum").keyup(function (event) {
                    if (event.keyCode != 37 && event.keyCode != 39 && event.keyCode != 46 && event.keyCode != 8 && event.keyCode <= 96 && event.keyCode >= 105 && event.keyCode != 35 && event.keyCode != 36) {
                        this.value = this.value.replace(/[^0-9\.]/g, '');
                    }
                });

                $("#icoNlsB").hide();
            });

            function savePayment() {
                var valid = formAddPaymentValid();
                if (valid.status == 'ok') {
                    //kendo.ui.progress($("#AddRegularPaymentForm"), true);
                    $('form').submit();
                } else if (valid.status == 'error') {
                    bars.ui.error({ text: valid.message })
                    /*$('#popupError').data("kendoNotification").show({
                        title: "Помилка",
                        message: valid.message
                    }, "error");*/
                }

            }
            function formAddPaymentValid() {
                var result = { status: 'ok', message: '' }

                var idd = $('#tbNumb').val();
                if (idd != "" && idd != "0") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Платіж № ' + idd + ' вже зареєстровано.</div>';
                }
                if ($('#tbNlsB').val() == "") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не вибрано рахунок отримувача.</div>';
                }
                var countNazn = $.trim($('#taNazn').val());
                $('#taNazn').val(countNazn);
                if (countNazn.length < 3) {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Призначення платежу має бути більше 3-ох символів.</div>';
                }
                var countNmkB = $.trim($('#tbNmkB').val());
                $('#tbNmkB').val(countNmkB);
                if (countNmkB.length < 3) {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Назва клієнта-отримувача має бути більше 3-ох символів.</div>';
                }
                if ($('#tbMfoB').val() == "") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не заповнено МФО отримувача.</div>';
                }
                else {
                    if (bars.utils.checkNlsCtrlDigit($('#tbMfoB').val(), $('#tbNlsB').val()) == false) {
                        result.status = 'error';
                        result.message += '<div class="validate-message">Невірний контрольний розряд рахунку.</div>';
                    }
                    else {
                        var blk = 0;
                        $.ajax({
                            async: false,
                            url: bars.config.urlContent('/api/kernel/Bank/?mfo=' + $("#tbMfoB").val()),
                            success: function (request) {
                               // alert(request);
                                if (request != null) {
                                    blk = request.Blk;
                                }
                            }
                        });
                        if (blk == 1) {
                            result.status = 'error';
                            result.message += '<div class="validate-message">МФО не існує.</div>';
                        }
                    }
                }
                if ($('#tbOkpoB').val() == "") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не заповнено ОКПО отримувача.</div>';
                }
                if ($('#tbSum').val() == "") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не заповнено суму платежу.</div>';
                }
                if ($('#StartDate').val() == "") {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не заповнено дату початку.</div>';
                }
                var startDate = new Date($('#StartDate').data('kendoDatePicker').value());
                var endDate = new Date($('#EndDate').data('kendoDatePicker').value());

                if (endDate < startDate || endDate == startDate) {
                    result.status = 'error';
                    result.message += '<div class="validate-message">Не коректно вказаний період</div>';
                }
                else {

                    var bankDate = new Date();
                    $.ajax({
                        async: false,
                        url: bars.config.urlContent('/api/kernel/BankDates/'),
                        success: function (request) { bankDate = new Date(request.Date.match(/\d+/)[0] * 1) }
                    });

                    if (startDate < bankDate) {
                        result.status = 'error';
                        result.message += '<div class="validate-message">Дата не може бути меньшою за банківську дату</div>';
                    }
                }
                
                return result;
            }

            function onShowPopupError(e) {
                if (!$("." + e.sender._guid)[1]) {
                    var element = e.element.parent(),
                        eWidth = element.width(),
                        eHeight = element.height(),
                        wWidth = $(window).width(),
                        wHeight = $(window).height(),
                        newTop, newLeft;

                    newLeft = Math.floor(wWidth / 2 - eWidth / 2);
                    newTop = Math.floor(wHeight / 2 - eHeight / 2);

                    e.element.parent().css({ top: newTop, left: newLeft });
                }
            }
            function printDocum() {
                var idd = $('#tbNumb').val();
                if (idd == "" || idd == "0") {
                    $('#popupError').data("kendoNotification").show({
                        title: "Помилка",
                        message: '<div>Документ не зареєстрований, друк не можливий.</div>'
                    }, "error");
                } else {
                    document.location.href = document.location.href + '&idd=' + idd + '&type=print';
                }
            }

            function showAccountsReferen() {
                bars.ui.handBook('V_ACCCUST', function (data) {
                    $("#tbNlsB").val($(data).map(function () {
                        $("#tbNmkB").val(this.NMK);
                        $("#tbMfoB").
                            val(this.KF);
                        $("#tbOkpoB").val(this.OKPO);
                        return this.NLS;
                    }).get());
                    //$apply();
                },
                {
                    multiSelect: false,
                    clause: "nls like '" + $("#tbNlsB").val() + "%' and rnk in (select rnk from customer where custtype = 3)",
                    columns: "RNK,NLS,NMS",
                    width: "80%"
                });
            }
            function showReferIco() {
                var ourMfo;
                $.ajax({
                    async: false,
                    url: bars.config.urlContent('/api/kernel/Params/MFO'),
                    success: function (request) {
                        ourMfo = request.Value;
                        if (ourMfo == $("#tbMfoB").val()) {
                            $("#icoNlsB").show();
                        }
                        else {
                            $("#icoNlsB").hide();
                        }
                    }
                })
            }
      </script>
    </div>
</body>
</html>
