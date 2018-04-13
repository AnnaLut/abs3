var diagLink = null; // объект всплывающего окна контекстного меню
var dialogApe = null;
var diagSendToBank = null;
var dialogRegDate = null;
var refObj = null; // обьєкт для передачи параметром между функциями 

Sys.Application.add_load(function () {
    curr_module = CIM.link_module();
    curr_module.initialize(CIM.args());
});

// Модуль лінкування
CIM.link_module = function () {
    var module = {}; // внутрішній об'єкт модуля 
    var grid_id_unlinked = null;
    var grid_id_linked = null;
    var contrID = null;
    var bound_id = null;
    var bound_sum = null;
    var bounded_sum = null;
    var total_sum = null;
    var direct = null;
    var type_id = null;
    var bankDate = null;
    var clientName = null;
    var mode = null; // 0 - платіж, 1 - ВМД
    var apeServiceCode = null;
    var docKv = null;
    var contrKv = null;
    var contrType = null;
    var maxBoundSum = null;
    var selRowData = null; // данные о выделенной строке о платежки 
    var funcLinkCall = null;
    var params = null;
    var ctrlSum = $("#tbSum"),
        ctrlErr = $("#dvPayError");
    var ctrlApeNum = $("#tbApeNum"),
        ctrlApeKv = $("#tbApeKv"),
        ctrlApeSum = $("#tbApeSum"),
        ctrlApeRate = $("#tbApeRate"),
        ctrlApeSumVK = $("#tbApeSumVK"),
        ctrlApeBeginDate = $("#tbApeBeginDate"),
        ctrlApeEndDate = $("#tbApeEndDate"),
        ctrlApeComment = $("#tbApeComment"),
        ctrlApeErr = $("#dvApeError"),
        ctrlRegDate = $("#tbRegDate");

    //#region  ******** public methods ********
    // ініциалізація форми
    module.initialize = function (args) {
        // отладка
        CIM.setDebug(true);
        // установка начальных значений
        contrID = args[0];
        mode = args[1];
        bound_id = args[2];
        direct = args[3];
        type_id = args[4];
        bound_sum = args[5]; // макс. сума для привязки - s 
        bounded_sum = args[6]; // сумма уже привязаных  - s_doc
        apeServiceCode = args[7];
        docKv = args[8];
        total_sum = args[9];
        params = eval(args[10]);
        bankDate = params.bdate;
        clientName = params.nmk;
        contrKv = params.contrKv;
        contrType = params.contrType;
        

        // Для акта-передача (=2) возможность формировать письма-уведомления
        if (bounded_sum > 0 && type_id == 2) {
            $("#btFormMail").button({ icons: { primary: "ui-icon-print" } }).show().bind("click", prepareSendToBank);
        } else
            $("#btFormMail").hide();

        if (mode == 0 && type_id == 2)
            $("#btFormMailVmd").button({ icons: { primary: "ui-icon-print" } }).show().bind("click", prepareSendToBank);
        else
            $("#btFormMailVmd").hide();

        $("#btCancel").button({ icons: { primary: "ui-icon-circle-arrow-w" } });

        //if (!diagLink) {
        if (diagLink)
            diagLink.dialog('destroy');
        diagLink = $('#dialogLinkInfo');

        diagLink.dialog({
            autoOpen: false,
            resizable: false,
            modal: false,
            buttons: {
                "Зберегти": function () {
                    if (ctrlSum.val().length == 0 || ctrlSum.val() <= 0) {
                        ctrlSum.focus();
                        ctrlSum.select();
                        ctrlErr.html("*Вкажіть не нульову сумму.");
                    }
                    else {
                        ctrlErr.html("");
                        if (eval(funcLinkCall)) $(this).dialog("close");
                    }
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
        //}

        if (mode == 9 || mode == 7) {
            if (!dialogApe) {
                dialogApe = $('#dialogApeInfo');
                dialogApe.dialog({
                    autoOpen: false,
                    resizable: false,
                    modal: false,
                    width: 650,
                    buttons: {
                        "Зберегти": function () {
                            if (saveApe()) $(this).dialog("close");
                        },
                        "Відміна": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }
        }
        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);
        $(".datepick").datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });
    };

    module.LinkPayment = linkPayment;
    module.LinkDecl = linkDecl;
    module.UnLinkPayment = unLinkPayment;
    module.UnLinkDecl = unLinkDecl;

    module.LinkPaymentToConclusion = linkPaymentToConclusion;
    module.UnLinkPaymentToConclusion = unLinkPaymentToConclusion;
    module.LinkConclusionToPayment = linkConclusionToPayment;
    module.UnLinkConclusionToPayment = unLinkConclusionToPayment;


    module.LinkDeclToConclusion = linkDeclToConclusion;
    module.UnLinkDeclToConclusion = unLinkDeclToConclusion;
    module.LinkConclusionToDecl = linkConclusionToDecl;
    module.UnLinkConclusionToDecl = unLinkConclusionToDecl;

    module.LinkPaymentToLicense = linkPaymentToLicense;
    module.UnLinkPaymentToLicense = unLinkPaymentToLicense;
    module.LinkLicenseToPayment = linkLicenseToPayment;
    module.UnLinkLicenseToPayment = unLinkLicenseToPayment;

    module.LinkPaymentToApe = linkPaymentToApe;
    module.UnLinkPaymentToApe = unLinkPaymentToApe;
    module.LinkApeToPayment = linkApeToPayment;
    module.UnLinkApeToPayment = unLinkApeToPayment;

    module.AddApe = addApe;

    module.EditRegDate = editRegDate;

    // повернутися до стану контракту
    module.GoBack = goBack;
    //#endregion

    var ApeClass = {
        ContrId: null, RowId: null, Num: null, Kv: null, ApeId: null, Sum: null, Rate: null, BeginDateS: null, EndDateS: null, SumVK: null, Comment: null
    };

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }
    }
    // взять выделенную строку
    function getSelected(obj) {
        if (obj) selRowData = obj;
        else if ($(".selectedRow"))
            selRowData = eval('(' + $(".selectedRow").attr("rd") + ')');
        else {
            selRowData = null;
            core$WarningBox("Не виділено жодного документу.", "Вибір документу");
        }
        return selRowData;
    }

    //#region SendToBank
    function prepareSendToBank() {
        $("#btSelBank").bind("click", selectBank);
        diagSendToBank = $('#dialogSendToBank');
        try {
            diagSendToBank.dialog("destroy");
        } catch (e) {
        }
        $("#tbUnboundSum").val(CIM.formatNum(total_sum));
        diagSendToBank.dialog({
            autoOpen: true,
            modal: true,
            width: 800,
            title: "Передача в інший банк",
            buttons: {
                "Продовжити": function () {
                    if (checkSendToBank()) {
                        $(this).dialog("close");
                        doSendToBank();
                    }
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
    }
    function selectBank() {
        var filter = '';
        if ($("#tbSBBankMfo").val())
            filter = "mfo like \'%\'||\'" + $("#tbSBBankMfo").val() + "'||\'%\'";
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="' + filter + '"&role=wr_metatab&tabname=banks', null,
            "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            $("#tbSBBankMfo").val(result[0]);
            $("#tbSBBankName").val(result[1]);
        }
    }

    function checkSendToBank() {
        var errMessage = "";

        var fields = ["tbSBBankMfo", "tbSBBankName", "tbSBZapNum", "tbSBZapDate", "tbSBDir", "tbSBDirFio", "tbSBPerFio", "tbSBPerTel"];

        $.each(fields, function (i, val) {
            var elem = $("#" + val);
            if (elem.val() == "") {
                errMessage += "* " + elem.attr("title") + "<br>";
                elem.addClass("error").focus();
            }
            else
                elem.removeClass("error");
        });

        $("#dvSendToBank").html(errMessage);
        return (errMessage) ? (false) : (true);
    }

    function doSendToBank() {
        var BindClass = {};

        BindClass.SBMode = mode;
        BindClass.JContrDateS = $("#tbContrDate").val();
        BindClass.SBBankMfo = $("#tbSBBankMfo").val();
        BindClass.SBBankName = $("#tbSBBankName").val();
        BindClass.SBZapNum = $("#tbSBZapNum").val();
        BindClass.SBZapDate = $("#tbSBZapDate").val();
        BindClass.SBDir = $("#tbSBDir").val();
        BindClass.SBDirFio = $("#tbSBDirFio").val();
        BindClass.SBPerFio = $("#tbSBPerFio").val();
        BindClass.SBPerTel = $("#tbSBPerTel").val();
        PageMethods.FormSendToBankMail(bound_id, BindClass, onFormSendToBankMail, CIM.onPMFailed);
    }

    function onFormSendToBankMail(result) {
        var fields = ["tbSBBankMfo", "tbSBBankName", "tbSBZapNum", "tbSBZapDate", "tbSBDir", "tbSBDirFio", "tbSBPerFio", "tbSBPerTel"];
        $.each(fields, function (i, val) {
            $("#" + val).val("");
        });

        if (result.DataStr) {
            $("#ifDownload").remove();
            var fileName = escape(((mode == 0) ? ("md_mail_") : ("pl_mail_")) + bankDate);
            var iframe = $("<iframe id='ifDownload' src='/barsroot/cim/handler.ashx?action=download&fname=" + fileName + "&file=" + result.DataStr + "'></iframe>");
            iframe.hide();
            $('body').append(iframe);
        }
    }
    //#endregion

    //#region Добавить акт 

    function addApe() {
        // Информация про период
        var title = "Створення акту цінової експертизи";
        dialogApe.dialog('option', 'title', title);
        var rowdata = { ai: null, nm: null, kv: docKv, s: "0.00", rt: "1", svk: "0.00", cm: null, zvk: null, bdt: null, edt: null };
        if (contrKv != docKv) {
            $("#lbContrKv").html("<b>(" + contrKv + ")</b>");
        }
        ctrlApeNum.val(rowdata.nm);
        ctrlApeKv.val(rowdata.kv).live("blur", apeKvFunc);

        ctrlApeSum.val(rowdata.s);
        ctrlApeSum.live("blur", apeSumFunc);
        ctrlApeRate.live("blur", apeSumFunc);
        ctrlApeSumVK.live("blur", apeSumFunc);
        ctrlApeRate.val(rowdata.rt);
        ctrlApeSumVK.val(rowdata.svk);
        ctrlApeComment.val(rowdata.cm);
        ctrlApeBeginDate.val(rowdata.bdt);
        ctrlApeEndDate.val(rowdata.edt);

        ctrlApeErr.html("");
        dialogApe.dialog('open');

        apeKvFunc();
    }

    function apeKvFunc() {
        if (ctrlApeKv.val() == contrKv) {
            ctrlApeRate.val("1.00");
            ctrlApeRate.attr("disabled", "disabled");
        } else {
            ctrlApeRate.removeAttr("disabled");
            ctrlApeRate.val("0.00");
        }
        apeSumFunc();
    }

    function apeSumFunc() {
        var s = 0;
        if ($(this).attr("id") === "tbApeSumVK") {
            if (!ctrlApeRate.is(':disabled')) {
                s = ctrlApeSumVK.val() / ctrlApeSum.val();
                if (!isNaN(s) && isFinite(s))
                    ctrlApeRate.val(CIM.formatNum(s));
                else
                    ctrlApeRate.val("0.00");
            }
            s = ctrlApeSumVK.val() / ctrlApeRate.val();
            if (!isNaN(s))
                ctrlApeSum.val(CIM.formatNum(s));
        } else {
            s = ctrlApeSum.val() * ctrlApeRate.val();
            if (!isNaN(s))
                ctrlApeSumVK.val(CIM.formatNum(s));
        }
    }
    //#region  Сохранение акта цен. экспертизы
    function saveApe() {
        if (apeIsValid()) {
            ApeClass.ContrId = contrID;
            ApeClass.Num = ctrlApeNum.val();
            ApeClass.Kv = ctrlApeKv.val();
            ApeClass.Sum = ctrlApeSum.val();
            ApeClass.SumVK = ctrlApeSumVK.val();
            ApeClass.BeginDateS = ctrlApeBeginDate.val();
            ApeClass.EndDateS = ctrlApeEndDate.val();
            ApeClass.Comment = ctrlApeComment.val();
            ApeClass.Rate = ctrlApeRate.val();
            ApeClass.RowId = null;
            PageMethods.UpdateApe(ApeClass, onUpdateApe, CIM.onPMFailed);
            return true;
        }
        return false;
    }
    function onUpdateApe(res) {
        CIM.reloadAfterCallback();
    }
    //#endregion

    //#region Валидация акта цен. экспертизы
    function apeIsValid() {
        var errMessage = "";
        var flag = false;
        if (ctrlApeBeginDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату початку <br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlApeBeginDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlApeBeginDate.addClass("error").focus();
        else ctrlApeBeginDate.removeClass("error");
        flag = false;

        if (ctrlApeEndDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату закінчення<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlApeEndDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlApeEndDate.addClass("error").focus();
        else ctrlApeEndDate.removeClass("error");

        flag = false;
        if (ctrlApeSum.val().length == 0 || ctrlApeSum.val() <= 0) {
            errMessage += "* Вкажіть суму акту<br>"; flag = true;
        }
        if (flag) ctrlApeSum.addClass("error").focus();
        else ctrlApeSum.removeClass("error");

        flag = false;
        if (ctrlApeRate.val().length == 0 || ctrlApeRate.val() <= 0) {
            errMessage += "* Вкажіть курс<br>"; flag = true;
        }
        if (flag) ctrlApeRate.addClass("error").focus();
        else ctrlApeRate.removeClass("error");

        flag = false;
        if (ctrlApeSumVK.val().length == 0 || ctrlApeSumVK.val() <= 0) {
            errMessage += "* Вкажіть суму у валюті контракту<br>"; flag = true;
        }
        if (flag) ctrlApeSumVK.addClass("error").focus();
        else ctrlApeSumVK.removeClass("error");

        flag = false;
        if (ctrlApeKv.val().length <= 2) {
            errMessage += "* Вкажіть валюту акту<br>"; flag = true;
        }
        if (flag) ctrlApeKv.addClass("error").focus();
        else ctrlApeKv.removeClass("error");

        flag = false;
        if (!ctrlApeNum.val()) {
            errMessage += "* Вкажіть номер<br>"; flag = true;
        }
        if (flag) ctrlApeNum.addClass("error").focus();
        else ctrlApeNum.removeClass("error");

        ctrlApeErr.html(errMessage);
        return (errMessage) ? (false) : (true);
    }
    //#endregion

    //#endregion

    //#region Выполнение линковки  платежа
    function linkPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(selRowData.zsvk, bound_sum - bounded_sum).toFixed(2)).focus(function () {
            this.select();
        });
        diagLink.dialog('option', 'title', "Прив'язка платежу до МД\акту");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkPaymentCall()";
    };

    function linkPaymentCall() {
        //alert("cim_mgr.vmd_link(" + type_id + "," + bound_id + "," + selRowData.ti + "," + selRowData.bi + "," + ctrlSum.val() * 100 + ")");
        PageMethods.LinkDecl(selRowData.ti, selRowData.bi, type_id, bound_id, ctrlSum.val(), CIM.reloadPage, CIM.onPMFailed);
        return true;
    }

    //#endregion

    //#region Выполнение линковки МД 
    function linkDecl(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(selRowData.zvk, bound_sum).toFixed(2)).focus(function () {
            this.select();
        });
        diagLink.dialog('option', 'title', "Прив'язка МД\\акту до платежу");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkDeclCall()";
    };
    function linkDeclCall() {
        //alert("cim_mgr.vmd_link(" + type_id + "," + bound_id + "," + selRowData.ti + "," + selRowData.bi + "," + ctrlSum.val() * 100 + ")");
        PageMethods.LinkDecl(type_id, bound_id, selRowData.ti, selRowData.bi, ctrlSum.val(), onLinkDecl, CIM.onPMFailed);
    }
    function onLinkDecl(res) {
        CIM.reloadPage();
    }
    //#endregion

    //#region Выполнение линковки  платежа к высновку
    function linkPaymentToConclusion(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(bound_sum - bounded_sum, selRowData.svp).toFixed(2)).focus(function () {
            this.select();
        });
        ctrlErr.html("");
        diagLink.dialog('option', 'title', "Прив'язка платежу до висновку");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkPaymentToConclusionCall()";
    };

    function linkPaymentToConclusionCall() {
        var maxSum = (bound_sum - bounded_sum).toFixed(2);
        if (ctrlSum.val() <= maxSum) {
            PageMethods.LinkConclusion(selRowData.ti, selRowData.bi, bound_id, ctrlSum.val(), CIM.reloadPage, CIM.onPMFailed);
            return true;
        }
        else {
            ctrlErr.html("*Сума перевищує допустиму (" + maxSum + ")!");
            return false;
        }
    }
    //#endregion

    //#region Выполнение линковки  высновка к платежу
    function linkConclusionToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(bound_sum - bounded_sum, selRowData.sum).toFixed(2)).focus(function () {
            this.select();
        });
        diagLink.dialog('option', 'title', "Прив'язка висновку до платежу");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkConclusionToPaymentCall()";
    };

    function linkConclusionToPaymentCall() {
        PageMethods.LinkConclusion(type_id, bound_id, selRowData.ri, ctrlSum.val(), CIM.reloadPage, CIM.onPMFailed);
        return true;
    }
    //#endregion


    //#region Выполнение линковки  МД к высновку
    function linkDeclToConclusion(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(bound_sum, selRowData.svt).toFixed(2)).focus(function () {
            this.select();
        });
        ctrlErr.html("");
        diagLink.dialog('option', 'title', "Прив'язка МД до висновку");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkDeclToConclusionCall()";
    };

    function linkDeclToConclusionCall() {
        var maxSum = (bound_sum * 1).toFixed(2);
        if (ctrlSum.val() * 1 <= maxSum) {
            PageMethods.LinkConclusion(selRowData.ti, selRowData.bi, bound_id, ctrlSum.val(), CIM.reloadPage, CIM.onPMFailed);
            return true;
        }
        else {
            ctrlErr.html("*Сума перевищує допустиму (" + maxSum + ")!");
            return false;
        }
    }
    //#endregion

    //#region Выполнение линковки  высновку к МД

    function linkConclusionToDecl(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(bound_sum - bounded_sum, selRowData.sum).toFixed(2)).focus(function () {
            this.select();
        });
        diagLink.dialog('option', 'title', "Прив'язка висновку до МД");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkConclusionToDeclCall()";
    };

    function linkConclusionToDeclCall() {
        PageMethods.LinkConclusion(type_id, bound_id, selRowData.ri, ctrlSum.val(), CIM.reloadPage, CIM.onPMFailed);
        return true;
    }

    //#endregion

    //#region Выполнение линковки  платежа к лицензии
    function linkPaymentToLicense(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(Math.min(bound_sum - bounded_sum, selRowData.svp).toFixed(2)).focus(function () {
            this.select();
        });
        ctrlErr.html("");
        diagLink.dialog('option', 'title', "Прив'язка платежу до ліцензії");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkPaymentToLicenseCall()";
    };

    function linkPaymentToLicenseCall() {
        var maxSum = (bound_sum - bounded_sum).toFixed(2) * 1;
        if (ctrlSum.val() * 1 <= maxSum) {
            PageMethods.LinkLicense(selRowData.ti, selRowData.bi, bound_id, ctrlSum.val(), docKv, bound_sum, CIM.reloadPage, CIM.onPMFailed);
            return true;
        }
        else {
            ctrlErr.html("*Сума перевищує допустиму (" + maxSum + ")!");
            return false;
        }
    }
    //#endregion

    //#region Выполнение линковки  лицензии к платежу
    function linkLicenseToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        maxBoundSum = Math.min(bound_sum - bounded_sum, selRowData.s - selRowData.sd) * 1;
        ctrlSum.val(maxBoundSum.toFixed(2)).focus(function () {
            this.select();
        });
        diagLink.dialog('option', 'title', "Прив'язка ліцензії до платежу");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkLicenseToPaymentCall()";
    };

    function linkLicenseToPaymentCall() {
        //alert(bound_id);
        if (ctrlSum.val() * 1 <= maxBoundSum) {
            PageMethods.LinkLicense(type_id, bound_id, selRowData.li, ctrlSum.val(), docKv, bound_sum, CIM.reloadPage, CIM.onPMFailed);
            return true;
        } else {
            ctrlErr.html("*Сума перевищує допустиму (" + maxBoundSum + ")!");
            return false;
        }
    }

    
    //#endregion

    //#region Выполнение линковки  платежа к акту ценовой экспертизы
    function linkPaymentToApe(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(selRowData.svk.toFixed(2)).attr("disabled", "true");
        ctrlErr.html("");
        diagLink.dialog('option', 'title', "Прив'язка платежу до акту");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkPaymentToApeCall()";
    };

    function linkPaymentToApeCall() {
        PageMethods.LinkApe(selRowData.ti, selRowData.bi, bound_id, ctrlSum.val(), apeServiceCode, CIM.reloadPage, CIM.onPMFailed);
        return true;
    }
    //#endregion

    //#region Выполнение линковки  акта ценовой экспертизы к платежу
    function linkApeToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        ctrlSum.val(bound_sum).attr("disabled", "true");
        diagLink.dialog('option', 'title', "Прив'язка акту цін. експертизи до платежу");
        diagLink.dialog('option', 'position', { my: "left top", at: "right top", of: ctrl });
        diagLink.dialog('open');
        funcLinkCall = "linkApeToPaymentCall()";
    };

    function linkApeToPaymentCall() {
        PageMethods.LinkApe(type_id, bound_id, selRowData.ai, ctrlSum.val(), apeServiceCode, CIM.reloadPage, CIM.onPMFailed);
        return true;
    }
    //#endregion


    //#region Выполнение отлиновки платежа 
    function unLinkPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        var elem = $("<table><tr><td>Причина відв'язки:</td><td><textarea rows='3' cols='45' id='tbUnBoundComment' /></td></tr></table>");
        core$ConfirmBox("Ви дійсно хочете відв'язати платіж? Якщо так, то вкажіть причину", "Відв'язка платежу", function (result) { confirmAction(result, "unLinkPaymentCall()"); }, elem);
    }
    function unLinkPaymentCall() {
        var comment = $("#tbUnBoundComment").val();
        core$DialogBoxClose();
        PageMethods.UnLinkDecl(selRowData.ti, selRowData.bi, type_id, bound_id, comment, CIM.reloadPage, CIM.onPMFailed);
    }

    //#endregion

    //#region Выполнение отлиновки платежа 

    function unLinkDecl(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        var elem = $("<table><tr><td>Причина відв'язки:</td><td><textarea rows='3' cols='45' id='tbUnBoundComment' /></td></tr></table>");
        core$ConfirmBox("Ви дійсно хочете відв'язати платіж? Якщо так, то вкажіть причину", "Відв'язка платежу", function (result) { confirmAction(result, "unLinkDeclCall()"); }, elem);

    }
    function unLinkDeclCall() {
        var comment = $("#tbUnBoundComment").val();
        core$DialogBoxClose();
        PageMethods.UnLinkDecl(type_id, bound_id, selRowData.ti, selRowData.bi, comment, CIM.reloadPage, CIM.onPMFailed);
    };
    //#endregion

    //#region Выполнение отлиновки платежа от высновка 
    function unLinkPaymentToConclusion(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkConclusion(selRowData.ti, selRowData.bi, bound_id, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки МД от высновка 
    function unLinkDeclToConclusion(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkConclusion(selRowData.ti, selRowData.bi, bound_id, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки высновка от МД 
    function unLinkConclusionToDecl(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkConclusion(type_id, bound_id, selRowData.ri, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки высновка от платежа   
    function unLinkConclusionToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkConclusion(type_id, bound_id, selRowData.ri, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки платежа от лицензии 
    function unLinkPaymentToLicense(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkLicense(selRowData.ti, selRowData.bi, bound_id, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки лицензии от платежа   
    function unLinkLicenseToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkLicense(type_id, bound_id, selRowData.li, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки платежа от  акта ценовой экспертизы 
    function unLinkPaymentToApe(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkApe(selRowData.ti, selRowData.bi, bound_id, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region Выполнение отлиновки  акта ценовой экспертизы от платежа   
    function unLinkApeToPayment(ctrl) {
        selRowData = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        PageMethods.UnLinkApe(type_id, bound_id, selRowData.ai, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region  goBack
    function goBack() {
        location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
    }
    //#endregion

    //#region Дата реестрації в журналі

    function editRegDate(paymentType, paymentId, vmdType, vmdId, regDate) {
        refObj = {};
        refObj.paymentType = paymentType;
        refObj.paymentId = paymentId;
        refObj.vmdType = vmdType;
        refObj.vmdId = vmdId;
        ctrlRegDate.val(regDate);
        document.getElementById("tbRegDate").value = regDate;

        dialogRegDate = $('#dialogRegDateInfo');
        try {
            dialogRegDate.dialog("destroy");
        } catch (e) { }
        dialogRegDate.dialog({
            autoOpen: true,
            resizable: false,
            modal: false,
            width: 400,
            title: "Зміна дати реестрації в журналі",
            buttons: {
                "Зберегти": function () {
                    if (saveRegDate()) $(this).dialog("close");
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
    }

    function saveRegDate() {
        var flag = false, errMessage = "";
        var value = document.getElementById("tbRegDate").value;

        if (ctrlRegDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату реестрації<br>";
        } else {
            try {
                $.datepicker.parseDate('dd/mm/yy', ctrlRegDate.val());
            } catch (e) {
                errMessage += "* Невірний формат дати<br>";
                flag = true;
            }
        }
        $("#dvRegDateError").html(errMessage);
        if (flag) {
            ctrlRegDate.addClass("error").focus();
            return false;
        }
        PageMethods.SaveLinkRegDate(refObj.paymentType, refObj.paymentId, refObj.vmdType, refObj.vmdId, ctrlRegDate.val(), onSaveRegDate, CIM.onPMFailed);
    }

    function onSaveRegDate(res) {
        core$WarningBox(res, "Зміна дати реестрації", function () { CIM.reloadPage(); });
    }

    //#endregion



    return module;
};