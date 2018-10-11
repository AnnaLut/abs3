var tabsDiv = null; // объект табы
var tabsTrade = null;
var diagPayment = null;
var diagPeriod = null;
var diagConclusion = null;
var dialogApe = null;
var dialogBorgReason = null;
var dialogRegDate = null;
var activeTab = 0;
var refObj = null; // обьєкт для передачи параметром между функциями 

Sys.Application.add_load(function () {
    curr_module = CIM.contract_state_module();
    curr_module.initialize(CIM.args());
});

$(document).ready(function () {
});

CIM.contract_state_module = function () {

    var module = {}; // внутренний объект модуля 
    var mode = null;
    var contrID = null;
    var selRowData = null; // данные о выделенной строке о платежки 
    // контролы
    // Платежи
    var ctrlPayDate = $("#tbPaymentDat");
    var ctrlPaySum = $("#tbSum");
    var ctrlPayFlag = $('select[name$="ddPayFlag"]');
    var ctrlPayError = $("#dvPayError");
    // Периоды
    var ctrlPerDate = $("#tbEndDate");
    var ctrlPerZ = $("#tbZ");
    var ctrlPerCrMethod = $('select[name$="ddCreditMethod"]');
    var ctrlPerPayPeriod = $('select[name$="ddPaymentPeriod"]');
    var ctrlPaymentDay = $("#tbPaymentDay");
    var ctrlPercentDay = $("#tbPercentDay");
    var ctrlPerCrAdaptive = $('select[name$="ddCreditAdaptive"]');
    var ctrlPeriodPercent = $("#tbPeriodPercent");
    var ctrlPeriodPercentNbu = $("#tbPeriodPercentNbu");
    var ctrlPerCrBase = $('select[name$="ddCreditBase"]');
    var ctrlPerPercentPeriod = $('select[name$="ddPercentPeriod"]');
    var ctrlBorgReason = $('select[name$="ddBorgReason"]');
    var ctrlPerGetDay = $('select[name$="ddGetDay"]');
    var ctrlPerPayDay = $('select[name$="ddPayDay"]');
    var ctrlPaymentDelay = $("#tbPaymentDelay");
    var ctrlRegDate = $("#tbRegDate");
    var ctrlPercentDelay = $("#tbPercentDelay");
    var ctrlConclNum = $("#tbConclNum"),
        ctrlConclOutDat = $("#tbConclOutDat"),
        ctrlConclOrgan = $('select[name$="ddConclOrgan"]'),
        ctrlConclKv = $("#tbConclKv"),
        ctrlConclSum = $("#tbConclSum"),
        ctrlConclBeginDat = $("#tbConclBeginDat"),
        ctrlConclEndDat = $("#tbConclEndDat"),
        ctrlConclErr = $("#dvConclErr");
    var ctrlApeNum = $("#tbApeNum"),
        ctrlApeKv = $("#tbApeKv"),
        ctrlApeSum = $("#tbApeSum"),
        ctrlApeRate = $("#tbApeRate"),
        ctrlApeSumVK = $("#tbApeSumVK"),
        ctrlApeBeginDate = $("#tbApeBeginDate"),
        ctrlApeEndDate = $("#tbApeEndDate"),
        ctrlApeComment = $("#tbApeComment"),
        ctrlApeErr = $("#dvApeError"),
        imgEa = $("#imgEa");

    var ctrlPerError = $("#dvPerError");

    //#region ******** public methods ********
    module.initialize = function (args) {
        // Инициализация параметров 
        contrID = args[0];
        CreditPaymentsClass.ContrId = contrID;
        CreditPeriodClass.ContrId = contrID;
        ConclusionClass.ContrId = contrID;
        // инициализация табов
        tabsDiv = $('#tabs').tabs({ select: function (event, ui) { $.cookies.set('tabind' + contrID, ui.index); } });
        tabsTrade = $('#tabsTrade').tabs({ select: function (event, ui) { $.cookies.set('tabindt' + contrID, ui.index); } });

        // fixed columns

        if (!diagPayment) {
            diagPayment = $('#dialogPaymentInfo');
            diagPayment.dialog({
                autoOpen: false,
                resizable: false,
                modal: false,
                width: 450,
                buttons: {
                    "Зберегти": function () {
                        if (savePayment()) $(this).dialog("close");
                    },
                    "Відміна": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }
        if (!diagPeriod) {
            diagPeriod = $('#dialogPeriodInfo');
            diagPeriod.dialog({
                autoOpen: false,
                resizable: false,
                modal: false,
                width: 650,
                buttons: {
                    "Зберегти": function () {
                        if (savePeriod()) $(this).dialog("close");
                    },
                    "Відміна": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }
        if (!diagConclusion) {
            diagConclusion = $('#dialogConclusionInfo');
            diagConclusion.dialog({
                autoOpen: false,
                resizable: false,
                modal: false,
                width: 650,
                buttons: {
                    "Зберегти": function () {
                        if (saveConclusion()) $(this).dialog("close");
                    },
                    "Відміна": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

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

        if (!dialogBorgReason) {
            dialogBorgReason = $('#dialogBorgReasonInfo');
            dialogBorgReason.dialog({
                autoOpen: false,
                resizable: false,
                modal: false,
                width: 700,
                buttons: {
                    "Зберегти": function () {
                        if (saveBorgReason()) $(this).dialog("close");
                    },
                    "Відміна": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

        dialogRegDate = $('#dialogRegDateInfo');

        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);
        ctrlPayDate.datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });
        ctrlPerDate.datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });
        $(".datepick").datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });
        $("#btCancel").button({ icons: { primary: "ui-icon-circle-arrow-w" } });
        // вычитка данных по контракту
        populateContract();


        /*$("#jtab").jqGrid({
            url: '/barsroot/cim/controls/metahandler.ashx',
            datatype: 'json',
            postData: { action: 'fill', method: 'BuildCredGraph', contrId: contrID },
            height: 'auto',
            colNames: ['Ідентифікатор', 'Найменування', 'Країна', 'Aдреса', 'Коментар'],
            colModel: [
           		        { name: 'BENEF_ID', width: 60, sortable: true, key: true },
           		        { name: 'BENEF_NAME', width: 200, sortable: true, editable: true },
           		        { name: 'COUNTRY_NAME', width: 200, sortable: true, editable: true },
                        { name: 'BENEF_ADR', width: 200, sortable: true, editable: true },
                        { name: 'COMMENTS', width: 200, sortable: true, editable: true }
                    ],
            rowNum: 10,
            rowList: [10, 20, 30],
            pager: '#jpager',
            gridview: true,
            jsonReader: { cell: "", search: "isSearch" },
            viewrecords: true,
            sortorder: 'asc',
            caption: "Довідник бенефіціарів"
        });*/
    }
    // 
    module.EditPayment = editPayment;
    module.DeletePayment = deletePayment;
    module.EditPeriod = editPeriod;
    module.DeletePeriod = deletePeriod;
    module.ShowGraph = showGraph;
    module.BoundInPayment = boundInPayment;
    module.BoundOutPayment = boundOutPayment;
    module.UnBoundPayment = unBoundPayment;
    module.BoundPrimPay = boundPrimPay;
    module.LinkPrimPay = linkPrimPay;
    module.BoundPrimVMD = boundPrimVMD;
    module.LinkPrimVMD = linkPrimVMD;
    module.BoundSecondPay = boundSecondPay;
    module.BoundSecondVMD = boundSecondVMD;
    module.LinkSecondPay = linkSecondPay;
    module.LinkSecondVMD = linkSecondVMD;
    module.UnBoundPrimVMD = unBoundSecondVMD;
    module.UnBoundSecondVMD = unBoundSecondVMD;
    module.UnBoundSecondPay = unBoundSecondPay;
    module.UnBoundPrimPay = unBoundSecondPay;
    module.EditConclusion = editConclusion;
    module.DeleteConclusion = deleteConclusion;
    module.UnBoundConclusion = unBoundConclusion;
    module.LinkConclusion = linkConclusion;
    module.LinkPrimLicensePay = linkPrimLicensePay;
    module.LinkPrimConclusionPay = linkPrimConclusionPay;
    module.LinkPrimVMDConclusion = linkPrimVMDConclusion;
    module.LinkPrimApePay = linkPrimApePay;
    module.ShowLicenses = showLicenses;
    module.EditBorgReason = editBorgReason;
    module.EditRegDate = editRegDate;

    module.EditApe = editApe;
    module.DeleteApe = deleteApe;
    module.LinkApe = linkApe;

    // повернутися до стану контракту
    module.GoBack = goBack;
    //#endregion

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) eval(callFunc);
    }

    //#region Clasess
    var ContractClass = {
        ContrId: null, ContrType: null, ContrTypeName: null, Num: null, Rnk: null,
        Kv: null, Sum: null, BenefId: null, StatusId: 0,
        StatusName: null, Comments: null, Branch: null, BranchName: null,
        ClientInfo: null, BeneficiarInfo: null, DateOpenS: null, DateCloseS: null
    };
    var CreditPaymentsClass = {
        ContrId: null, RowId: null, Date: null, Sum: null, PayFlag: null
    };
    var CreditPeriodClass = {
        ContrId: null, RowId: null, EndDate: null, Z: null, CrMethodId: null, CrPaymentPeriodId: null,
        AdaptiveId: null, Percent: null, PercentNbu: null, PercentBaseId: null, PercentPeriodId: null,
        GetDayId: null, PayDayId: null, HolidayId: null, PaymentDelay: null, PercentDelay: null
    };
    var ConclusionClass = {
        ContrId: null, RowId: null, Kv: null, ConclId: null, OrgId: null, OutNum: null, OutDateS: null, EndDateS: null, Sum: null
    };
    var ApeClass = {
        ContrId: null, RowId: null, Num: null, Kv: null, ApeId: null, Sum: null, Rate: null, BeginDateS: null, EndDateS: null, SumVK: null, Comment: null
    };

    //#endregion

    //#region  Вычитка данных по контракту
    function populateContract() {
        if (contrID)
            PageMethods.PopulateContract(contrID, onPopulateContract, onFailed);
    }
    function onPopulateContract(res) {
        // Иницализация внутреннего "класса" 
        ContractClass = res;
        // показ табов 
        var disTabs = [1, 2, 3, 4, 5];
        var actTabs = [];
        var defSelect = 1;
        //tabsDiv.tabs({ disabled: [0,1] });
        tabsDiv.tabs("option", "disabled", disTabs);
        imgEa.show().bind("click", function () {
            window.open(res.EaUrl);
        });
        // для все, кроме кредитных прячем график
        if (ContractClass.ContrType == 2) {
            actTabs.push(1, 2, 3, 5);
            defSelect = 1;
            $(".imgApeLink").hide();
        }
            //tabsDiv.tabs("option", "disabled", [4]);
        else if (ContractClass.ContrType == 0 || ContractClass.ContrType == 1) {
            //tabsDiv.tabs("option", "disabled", [0, 1, 2]);
            actTabs.push(4, 5);
            defSelect = 4;
            $("#btBoundPrimPay").toggle(ContractClass.ContrType == 1);
            $("#btBoundPrimVMD").toggle(ContractClass.ContrType == 0);
            $("#btBoundSecondPay").toggle(ContractClass.ContrType == 0);
            $("#btBoundSecondVMD").toggle(ContractClass.ContrType == 1);
            tabsTrade.show();
            // для импортних по товарах - прячем акты ценовой экспертизы
            if (ContractClass.ContrType == 1 && ContractClass.TradeContractInfo.SubjectId == 0 || ContractClass.ContrType == 0) {
                $("#tabLinkApes").hide();
                $(".imgApeLink").hide();
            }
        }
        else if (ContractClass.ContrType == 3) {
            actTabs.push(1, 5);
            $(".imgApeLink").hide();
        }
        else if (ContractClass.ContrType == 4) {
            actTabs.push(1); 
            $(".imgApeLink").hide();
            $("#btLicenses").hide();
        }
        else
            actTabs.push(1, 2, 3);
        //tabsDiv.tabs("option", "disabled", [1, 2, 4]);
        tabsDiv.show();

        //tabsDiv.tabs("option", "disabled", [0,1]);
        for (tab in actTabs)
            tabsDiv.tabs("enable", actTabs[tab]);

        if ($.cookies.get('tabind' + contrID))
            defSelect = Number($.cookies.get('tabind' + contrID));

        tabsDiv.tabs("select", defSelect);
        //tabsDiv.tabs("option", "active", defSelect);

        if ($.cookies.get('tabindt' + contrID))
            //tabsTrade.tabs("option", "active", Number($.cookies.get('tabindt' + contrID)));
            tabsTrade.tabs("select", Number($.cookies.get('tabindt' + contrID)));
    }
    //#endregion

    //#region Редактирование\создание платежа
    function editPayment(elem, insert) {
        // Інформація про платіж
        var title = (insert) ? ("Створення платежу") : ("Редагування платежу");
        diagPayment.dialog('option', 'title', title);
        diagPayment.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        var rowdata = { dat: "", sum: 0, fi: 2, ri: "" };

        if (!insert)
            rowdata = eval('(' + elem.parent().parent().attr("rowdata") + ')');
        ctrlPayDate.val(rowdata.dat).removeClass("error");
        ctrlPaySum.val(rowdata.sum).removeClass("error");
        ctrlPayFlag.val(rowdata.fi);
        CreditPaymentsClass.RowId = rowdata.ri;
        // очищаем валидаторы
        ctrlPayError.html("");
        diagPayment.dialog('open');
    }
    //#endregion

    //#region  Удаление платежа
    function deletePayment(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rowdata") + ')');
        var message = "Ви дійсно хочете видалити платіж ?";
        core$ConfirmBox(message, "Видалення платежу", function (result) { confirmAction(result, "deletePaymentCall('" + rowdata.ri + "')"); });
    }

    function deletePaymentCall(rowid) {
        if (rowid)
            PageMethods.DeletePayment(contrID, rowid, CIM.reloadPage, onFailed);
    }

    //#endregion

    //#region  Сохранение платежа 
    function savePayment() {
        if (paymentIsValid()) {
            CreditPaymentsClass.Date = ctrlPayDate.val();
            CreditPaymentsClass.Sum = ctrlPaySum.val();
            CreditPaymentsClass.PayFlag = ctrlPayFlag.val();
            PageMethods.UpdatePayment(CreditPaymentsClass, CIM.reloadPage, onFailed);
            return true;
        }
        return false;
    }
    //#endregion

    //#region Валидация платежа
    function paymentIsValid() {
        var errMessage = "";
        var flag = false;
        if (ctrlPayDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату платежу<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlPayDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlPayDate.addClass("error").focus();
        else ctrlPayDate.removeClass("error");
        flag = false;

        if (ctrlPaySum.val().length == 0 || ctrlPaySum.val() == 0) {
            errMessage += "* Вкажіть суму платежу<br>";
            flag = true;
        }
        // для класификаторов отличных от "тіло" - только отриц. сумма
        if (ctrlPayFlag.val() != 2 && ctrlPaySum.val() > 0) {
            errMessage += "* Для даного класифікатору допустимий лише вихідний платіж (<0)<br>";
            flag = true;
        }

        if (flag) ctrlPaySum.addClass("error").focus();
        else ctrlPaySum.removeClass("error");

        ctrlPayError.html(errMessage);
        return (errMessage) ? (false) : (true);
    }
    //#endregion

    //#region Редактирование\создание периода
    function editPeriod(elem, insert) {
        // Информация про период
        var title = (insert) ? ("Створення періоду") : ("Редагування періоду");
        diagPeriod.dialog('option', 'title', title);
        diagPeriod.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        var rowdata = { ed: "", cmi: null, papi: null, z: 0, ai: null, p: null, pn: ContractClass.CreditContractInfo.NbuPercent, pbi: null, peid: null, gdi: null, pdi: null, hi: null };

        if (!insert)
            rowdata = eval('(' + elem.parent().parent().attr("rowdata") + ')');
        ctrlPerDate.val(rowdata.ed).removeClass("error");
        ctrlPerCrMethod.val(rowdata.cmi);
        ctrlPerPayPeriod.val(rowdata.papi).removeClass("error");
        ctrlPerZ.val(rowdata.z);
        ctrlPaymentDay.val(rowdata.patd);
        ctrlPercentDay.val(rowdata.perd);
        ctrlPeriodPercent.val(rowdata.p).removeClass("error");
        ctrlPeriodPercentNbu.val(rowdata.pn).removeClass("error");
        ctrlPerCrBase.val(rowdata.pbi);
        ctrlPerPercentPeriod.val(rowdata.peid).removeClass("error");
        if (insert) {
            ctrlPerGetDay.val(1);
            ctrlPaymentDelay.val(0);
            ctrlPercentDelay.val(0);
        }
        else {
            ctrlPerGetDay.val(rowdata.gdi);
            ctrlPaymentDelay.val(rowdata.pad);
            ctrlPercentDelay.val(rowdata.ped);
        }
        ctrlPerPayDay.val(rowdata.pdi);
        //ctrlPerHoliday.val(rowdata.hi);
        CreditPeriodClass.RowId = rowdata.ri;
        // очищаем валидаторы
        ctrlPerError.html("");
        diagPeriod.dialog('open');
    }
    //#endregion

    //#region  Удаление периода
    function deletePeriod(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rowdata") + ')');
        var message = "Ви дійсно хочете видалити період ?";
        core$ConfirmBox(message, "Видалення періоду", function (result) { confirmAction(result, "deletePeriodCall('" + rowdata.ri + "')"); });
    }

    function deletePeriodCall(rowid) {
        if (rowid)
            PageMethods.DeletePeriod(contrID, rowid, CIM.reloadPage, onFailed);
    }
    //#endregion

    //#region  Сохранение периода
    function savePeriod() {
        if (periodIsValid()) {
            CreditPeriodClass.EndDate = ctrlPerDate.val();
            CreditPeriodClass.Z = ctrlPerZ.val();
            CreditPeriodClass.CrMethodId = ctrlPerCrMethod.val();
            CreditPeriodClass.CrPaymentPeriodId = ctrlPerPayPeriod.val();
            CreditPeriodClass.AdaptiveId = ctrlPerCrAdaptive.val();
            CreditPeriodClass.Percent = ctrlPeriodPercent.val();
            CreditPeriodClass.PercentNbu = ctrlPeriodPercentNbu.val();
            CreditPeriodClass.PercentBaseId = ctrlPerCrBase.val();
            CreditPeriodClass.PercentPeriodId = ctrlPerPercentPeriod.val();
            CreditPeriodClass.PaymentDelay = ctrlPaymentDelay.val();
            CreditPeriodClass.PercentDelay = ctrlPercentDelay.val();
            CreditPeriodClass.GetDayId = ctrlPerGetDay.val();
            CreditPeriodClass.PayDayId = ctrlPerPayDay.val();
            CreditPeriodClass.PaymentDay = ctrlPaymentDay.val();
            CreditPeriodClass.PercentDay = ctrlPercentDay.val();
            PageMethods.UpdatePeriod(CreditPeriodClass, CIM.reloadPage, onFailed);
            return true;
        }
        return false;
    }
    //#endregion

    //#region Валидация периода
    function periodIsValid() {
        var errMessage = "";
        var flag = false;
        if (ctrlPerDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату закінчення періоду<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlPerDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlPerDate.addClass("error").focus();
        else ctrlPerDate.removeClass("error");
        flag = false;

        if (ctrlPerZ.val().length == 0 || ctrlPerZ.val() < 0) {
            errMessage += "* Вкажіть залишок тіла платежу<br>"; flag = true;
        }
        if (flag) ctrlPerZ.addClass("error").focus();
        else ctrlPerZ.removeClass("error");

        flag = false;
        if (ctrlPerPayPeriod.val().length == 0) {
            errMessage += "* Вкажіть періодичність погашення тіла<br>"; flag = true;
        }
        if (flag) ctrlPerPayPeriod.addClass("error").focus();
        else ctrlPerPayPeriod.removeClass("error");

        flag = false;
        if (ctrlPeriodPercent.val().length == 0 || ctrlPeriodPercent.val() < 0) {
            errMessage += "* Вкажіть процентну ставку<br>"; flag = true;
        }
        if (flag) ctrlPeriodPercent.addClass("error").focus();
        else ctrlPeriodPercent.removeClass("error");

        flag = false;
        if (ctrlPeriodPercentNbu.val().length == 0 || ctrlPeriodPercentNbu.val() < 0) {
            errMessage += "* Вкажіть процентну ставку НБУ<br>"; flag = true;
        }
        if (flag) ctrlPeriodPercentNbu.addClass("error").focus();
        else ctrlPeriodPercentNbu.removeClass("error");

        flag = false;
        if (ctrlPerPercentPeriod.val().length == 0) {
            errMessage += "* Вкажіть періодичність погашення відсотків<br>"; flag = true;
        }
        if (flag) ctrlPerPercentPeriod.addClass("error").focus();
        else ctrlPerPercentPeriod.removeClass("error");

        ctrlPerError.html(errMessage);
        return (errMessage) ? (false) : (true);
    }
    //#endregion

    //#region Редактирование\создание высновка
    function editConclusion(elem, insert) {
        // Информация про период
        var title = (insert) ? ("Створення висновку") : ("Редагування висновку");
        diagConclusion.dialog('option', 'title', title);
        diagConclusion.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        var rowdata = { ri: null, ori: null, onm: null, edt: null, bdt: null, odt: null, sum: "0.00", kv: null }
        if (!insert)
            rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        selRowData = rowdata;
        ctrlConclNum.val(rowdata.onm);
        ctrlConclOutDat.val(rowdata.odt);
        ctrlConclOrgan.val(rowdata.ori);
        ctrlConclSum.val(rowdata.sum);
        ctrlConclKv.val(ContractClass.Kv);
        ctrlConclBeginDat.val(rowdata.bdt);
        ctrlConclEndDat.val(rowdata.edt);
        ctrlConclErr.html("");
        ConclusionClass.RowId = rowdata.ri;
        ctrlConclErr.html("");
        diagConclusion.dialog('open');
    }
    //#endregion

    //#region  Удаление высновка
    function deleteConclusion(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        var message = "Ви дійсно хочете видалити висновок ?";
        core$ConfirmBox(message, "Видалення висновку", function (result) { confirmAction(result, "deleteConclusionCall('" + rowdata.ri + "')"); });
    }

    function deleteConclusionCall(rowid) {
        if (rowid)
            PageMethods.DeleteConclusion(rowid, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

    //#region  Сохранение высновка
    function saveConclusion() {
        if (conclusionIsValid()) {
            ConclusionClass.OutNum = ctrlConclNum.val();
            ConclusionClass.OutDateS = ctrlConclOutDat.val();
            ConclusionClass.OrgId = ctrlConclOrgan.val();
            ConclusionClass.Sum = ctrlConclSum.val();
            ConclusionClass.BeginDateS = ctrlConclBeginDat.val();
            ConclusionClass.EndDateS = ctrlConclEndDat.val();
            ConclusionClass.Kv = ctrlConclKv.val();

            CIM.debug("ConclusionClass=", ConclusionClass);
            PageMethods.UpdateConclusion(ConclusionClass, CIM.reloadPage, CIM.onPMFailed);
            return true;
        }
        return false;
    }
    //#endregion

    //#region Валидация высновка
    function conclusionIsValid() {
        var errMessage = "";
        var flag = false;
        if (ctrlConclBeginDat.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату початку строку<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlConclBeginDat.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlConclBeginDat.addClass("error").focus();
        else ctrlConclBeginDat.removeClass("error");
        flag = false;

        if (ctrlConclEndDat.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату закінчення строку<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlConclEndDat.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlConclEndDat.addClass("error").focus();
        else ctrlConclEndDat.removeClass("error");
        flag = false;

        if (ctrlConclSum.val().length == 0 || ctrlConclSum.val() <= 0) {
            errMessage += "* Вкажіть суму висновку<br>"; flag = true;
        }
        if (flag) ctrlConclSum.addClass("error").focus();
        else ctrlConclSum.removeClass("error");

        flag = false;
        if (ctrlConclKv.val().length <= 2) {
            errMessage += "* Вкажіть валюту висновку<br>"; flag = true;
        }
        if (flag) ctrlConclKv.addClass("error").focus();
        else ctrlConclKv.removeClass("error");

        flag = false;
        if (!ctrlConclOrgan.val() || ctrlConclOrgan.val() < 0) {
            errMessage += "* Вкажіть орган<br>"; flag = true;
        }
        if (flag) ctrlConclOrgan.addClass("error").focus();
        else ctrlConclOrgan.removeClass("error");

        ctrlConclErr.html(errMessage);
        return (errMessage) ? (false) : (true);
    }
    //#endregion


    //#region Редактирование\создание акта цен. экспертизы
    function editApe(elem, insert) {
        // Информация про период
        var title = (insert) ? ("Створення акту цінової експертизи") : ("Редагування акту цінової експертизи");
        dialogApe.dialog('option', 'title', title);
        dialogApe.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        var rowdata = { ai: null, nm: null, kv: ContractClass.Kv, s: "0.00", rt: "1", svk: "0.00", cm: null, zvk: null, bdt: null, edt: null };

        if (!insert)
            rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
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
        ApeClass.RowId = rowdata.ai;
        ctrlApeErr.html("");
        dialogApe.dialog('open');

        apeKvFunc();
    }

    function apeKvFunc() {
        if (ctrlApeKv.val() == ContractClass.Kv) {
            ctrlApeRate.val("1.00");
            ctrlApeRate.attr("disabled", "disabled");
        } else
            ctrlApeRate.removeAttr("disabled");
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
                    ctrlApeRate.val("1.00");
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

    //#endregion

    //#region  Удаление акта цен. экспертизы
    function deleteApe(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        var message = "Ви дійсно хочете видалити акт ?";
        core$ConfirmBox(message, "Видалення акту цінової експертизи", function (result) { confirmAction(result, "deleteApeCall('" + rowdata.ai + "')"); });
    }

    function deleteApeCall(rowid) {
        if (rowid)
            PageMethods.DeleteApe(rowid, CIM.reloadPage, CIM.onPMFailed);
    }
    //#endregion

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

            PageMethods.UpdateApe(ApeClass, CIM.reloadPage, CIM.onPMFailed);
            return true;
        }
        return false;
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



    //#region Вычитка данных по контракту
    function showGraph() {
        if (contrID)
            PageMethods.ShowGraph(contrID, onShowGraph, onFailed);
    }
    function onShowGraph(res) {

    }
    //#endregion

    //#region Отв'язка платежа
    function unBoundPayment(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        var elem = $("<table><tr><td>Причина відв'язки:</td><td><textarea rows='3' cols='55' id='tbUnBoundComment' /></td></tr></table>");
        core$ConfirmBox("Ви дійсно хочете відв'язати платіж? Якщо так, то вкажіть причину", "Відв'язка платежу", function (result) { confirmAction(result, "unBoundPaymentCall(" + rd.bi + "," + rd.ti + ")"); }, elem);
    }
    function unBoundPaymentCall(boundId, typePayment) {
        var comment = $("#tbUnBoundComment").val();
        if (comment) {
            core$DialogBoxClose();
            PageMethods.UnboundPayment(boundId, typePayment, comment, CIM.reloadPage, CIM.onPMFailed);
        }
        else
            $("#tbUnBoundComment").addClass("reqField");
    }
    //#endregion

    //#region Отв'язка ВМД
    function unBoundSecondVMD(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        var elem = $("<table><tr><td>Причина відв'язки:</td><td><textarea rows='3' cols='55' id='tbUnBoundComment' /></td></tr></table>");
        core$ConfirmBox("Ви дійсно хочете відв'язати МД? Якщо так, то вкажіть причину", "Відв'язка МД", function (result) { confirmAction(result, "unBoundSecondVMDCall(" + rd.bi + "," + rd.ti + ")"); }, elem);
    }
    function unBoundSecondVMDCall(boundId, typeDecl) {
        var comment = $("#tbUnBoundComment").val();
        if (comment) {
            core$DialogBoxClose();
            PageMethods.UnboundDecl(boundId, typeDecl, comment, CIM.reloadPage, CIM.onPMFailed);
        }
        else
            $("#tbUnBoundComment").addClass("reqField");
    }
    //#endregion

    //#region Отв'язка платежа
    function unBoundSecondPay(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        var elem = $("<table><tr><td>Причина відв'язки:</td><td><textarea rows='3' cols='55' id='tbUnBoundComment' /></td></tr></table>");
        core$ConfirmBox("Ви дійсно хочете відв'язати платіж? Якщо так, то вкажіть причину", "Відв'язка платежу", function (result) { confirmAction(result, "unBoundSecondPayCall(" + rd.bi + "," + rd.ti + ")"); }, elem);
    }
    function unBoundSecondPayCall(boundId, typeDecl) {
        var comment = $("#tbUnBoundComment").val();
        if (comment) {
            core$DialogBoxClose();
            PageMethods.UnboundPayment(boundId, typeDecl, comment, CIM.reloadPage, CIM.onPMFailed);
        }
        else
            $("#tbUnBoundComment").addClass("reqField");
    }
    //#endregion

    //#region Отв'язка висновків
    function unBoundConclusion() {

    }

    //#endregion

    //#region Привязка платежей
    // входящие
    function boundInPayment(payflag) {
        //core$IframeBox({ url: "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&" + Math.random(), width: 1200, height: 800, title: "Нерозібрані вхідні платежі" }); 
        location.href = "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&direct=0&rnk=" + ContractClass.Rnk + "&payflag=" + payflag;
    }
    // исходящие
    function boundOutPayment(payflag) {
        //core$IframeBox({ url: "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&" + Math.random(), width: 1200, height: 800, title: "Нерозібрані вихідні платежі" });
        location.href = "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&direct=1&rnk=" + ContractClass.Rnk + "&payflag=" + payflag;
    }

    //#endregion

    //#region Привязка торговых платежей
    function boundPrimPay() {
        location.href = "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&direct=1&rnk=" + ContractClass.Rnk + "&payflag=0&contr_type=" + ContractClass.ContrType;
    }
    function boundPrimVMD() {
        location.href = "/barsroot/cim/payments/unbound_declarations.aspx?contr_id=" + contrID + "&direct=1&rnk=" + ContractClass.Rnk + "&okpo=" + ContractClass.ClientInfo.Okpo + "&payflag=0&contr_type=" + ContractClass.ContrType;
    }
    function boundSecondPay() {
        location.href = "/barsroot/cim/payments/unbound_payments.aspx?contr_id=" + contrID + "&direct=0&rnk=" + ContractClass.Rnk + "&payflag=0&contr_type=" + ContractClass.ContrType;
    }
    function boundSecondVMD() {
        location.href = "/barsroot/cim/payments/unbound_declarations.aspx?contr_id=" + contrID + "&direct=1&rnk=" + ContractClass.Rnk + "&okpo=" + ContractClass.ClientInfo.Okpo + "&payflag=0&contr_type=" + ContractClass.ContrType;
    }
    //#endregion

    //#region линковка торговых платежей

    function linkPrimPay(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=0&bound_id=" + rd.bi + "&direct=" + rd.di + "&type_id=" + rd.ti;
    }

    var vmdRow = null;
    var vmdMode = null;
    function linkPrimVMD(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        vmdRow = rd;
        vmdMode = 1;
        if (rd.dd != rd.ad || !rd.ad) {
            var elem = $("<table><tr><td>Дата парерового носія:</td><td><input type='text' id='tbVMDPaperDate' name='tbVMDPaperDate' style='text-align: center; width: 80px' /></td></tr><tr><td id='tdErrMsg' colspan='2'></td></tr></table>");
            core$ConfirmBox("Дата паперового носія відсутня або відрізняється від дати дозволу.", "Необхідно заповнити", function (result) { confirmAction(result, "setDeclPaperDate(" + rd.vi + ", '" + rd.ad + "')"); }, elem);
            $("#tbVMDPaperDate").datepicker({
                changeMonth: true,
                changeYear: true,
                buttonImageOnly: true,
                buttonImage: "/Common/Images/default/16/calendar.png ",
                showButtonPanel: true,
                showOn: "button"
            });
            return;
        }
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=1&bound_id=" + rd.bi + "&direct=" + rd.di + "&type_id=" + rd.ti;
    }

    function setDeclPaperDate(vmd_id, allow_dat) {
        var errMessage = "";
        var dat = $('#tbVMDPaperDate').val();
        if (!dat)
            errMessage = "* Вкажіть дату";
        else if (dat != allow_dat)
            errMessage = "* Дата відрізняється від дати дозволу - " + allow_dat;

        if (errMessage) {
            $("#tdErrMsg").html("<div style='color:red'>" + errMessage + "</div>");
            $("#tbVMDPaperDate").addClass("reqField");
        } else {
            $("#tdErrMsg").html("");
            core$DialogBoxClose();
            PageMethods.SetDeclPaperDate(vmd_id, dat, onSetDeclPaperDate, CIM.onPMFailed);
        }
    }

    function onSetDeclPaperDate(res) {
        if (res) {
            location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=" + vmdMode + "&bound_id=" + vmdRow.bi + "&direct=" + vmdRow.di + "&type_id=" + vmdRow.ti;
        }
    }

    function linkSecondPay(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=0&bound_id=" + rd.bi + "&direct=" + rd.di + "&type_id=" + rd.ti;
    }
    function linkSecondVMD(ctrl) {

        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        vmdRow = rd;
        vmdMode = 1;
        if (rd.ti == 0 && (rd.dd != rd.ad || !rd.ad)) {
            var elem = $("<table><tr><td>Дата парерового носія:</td><td><input type='text' id='tbVMDPaperDate' name='tbVMDPaperDate' style='text-align: center; width: 80px' /></td></tr><tr><td id='tdErrMsg' colspan='2'></td></tr></table>");
            core$ConfirmBox("Дата паперового носія відсутня або відрізняється від дати дозволу.", "Необхідно заповнити", function (result) { confirmAction(result, "setDeclPaperDate(" + rd.vi + ", '" + rd.ad + "')"); }, elem);
            $("#tbVMDPaperDate").datepicker({
                changeMonth: true,
                changeYear: true,
                buttonImageOnly: true,
                buttonImage: "/Common/Images/default/16/calendar.png ",
                showButtonPanel: true,
                showOn: "button"
            });
            return;
        }
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=1&bound_id=" + rd.bi + "&direct=" + rd.di + "&type_id=" + rd.ti;
    }
    function linkConclusion(ctrl, idMD) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=2" + ((idMD) ? ("1") : ("")) + "&bound_id=" + rd.ri + "&type_id=0";
    }
    function linkApe(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=6&bound_id=" + rd.ai + "&type_id=0";
    }

    function linkPrimConclusionPay(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=3&bound_id=" + rd.bi + "&type_id=" + rd.ti;
    }
    function linkPrimLicensePay(ctrl, flag) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=5&bound_id=" + rd.bi + "&type_id=" + rd.ti + ((flag) ? ("&addpay=1") : (""));
    }
    function linkPrimApePay(ctrl, flag) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=7&bound_id=" + rd.bi + "&type_id=" + rd.ti + ((flag) ? ("&addpay=1") : (""));
    }
    function linkPrimVMDConclusion(ctrl) {
        var rd = eval('(' + ctrl.parent().parent().attr("rd") + ')');
        vmdRow = rd;
        vmdMode = 11;
        if (rd.dd != rd.ad || !rd.ad) {
            var elem = $("<table><tr><td>Дата парерового носія:</td><td><input type='text' id='tbVMDPaperDate' name='tbVMDPaperDate' style='text-align: center; width: 80px' /></td></tr><tr><td id='tdErrMsg' colspan='2'></td></tr></table>");
            core$ConfirmBox("Дата паперового носія відсутня або відрізняється від дати дозволу.", "Необхідно заповнити", function (result) { confirmAction(result, "setDeclPaperDate(" + rd.vi + ", '" + rd.ad + "','11')"); }, elem);
            $("#tbVMDPaperDate").datepicker({
                changeMonth: true,
                changeYear: true,
                buttonImageOnly: true,
                buttonImage: "/Common/Images/default/16/calendar.png ",
                showButtonPanel: true,
                showOn: "button"
            });
            return;
        }
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=11&bound_id=" + rd.bi + "&type_id=" + rd.ti;
    }

    //#endregion

    //#region Ліцензії

    function showLicenses() {
        $(location).attr('href', 'licenses.aspx?contr_id=' + contrID + "&taxcode=" + ContractClass.ClientInfo.Okpo);
    }

    //#endregion

    //#region Причина заборгованости

    function editBorgReason(boundType, boundId, docType) {
        refObj = {};
        refObj.boundType = boundType;
        refObj.boundId = boundId;
        refObj.docType = docType;
        dialogBorgReason.dialog('option', 'title', 'Редагування причини заборгованості');
        dialogBorgReason.dialog('open');
    }

    function saveBorgReason() {
        PageMethods.SaveBorgReason(refObj.boundType, refObj.boundId, refObj.docType, ctrlBorgReason.val(), CIM.reloadPage, CIM.onPMFailed);
    }

    //#region Дата реестрації в журналі

    function editRegDate(boundType, boundId, docType, docId, regDate) {
        refObj = {};
        refObj.boundType = boundType;
        refObj.boundId = boundId;
        refObj.docType = docType;
        refObj.docId = docId;
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
        PageMethods.SaveRegDate(ContractClass.ContrType, refObj.boundType, refObj.boundId, refObj.docType, refObj.docId, ctrlRegDate.val(), onSaveRegDate, CIM.onPMFailed);
    }

    function onSaveRegDate(res) {
        core$WarningBox(res, "Зміна дати реестрації", function () { CIM.reloadPage(); });
    }

    //#endregion



    //#region ******** callback methods ********
    function refreshCallback(result) {
        if (mode == "create" && contrID)
            location.href = "contract_card.aspx?mode=view&contr_id=" + contrID;
    }

    function onFailed(error, userContext, methodName) {
        if (error !== null) {
            alert(error.get_message());
        }
    }
    //#endregion
    //#region  goBack
    function goBack() {
        location.href = "/barsroot/cim/contracts/contracts_list.aspx";
    }

    return module;
};
