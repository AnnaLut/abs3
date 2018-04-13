var diagLicense = null;

Sys.Application.add_load(function () {
    curr_module = CIM.license_module();
    curr_module.initialize(CIM.args());
});

CIM.license_module = function () {

    var module = {}; // внутренний объект модуля 
    var okpo = null;
    var contrID = null;
    var ctrlLicenseError = $("#dvLicenseErr");
    var ctrlLicSum = $("#tbLicenseSum"),
        ctrlLicNum = $("#tbLicenseNum"),
        ctrlLicType = $('select[name$="ddLicenseType"]'),
        ctrlLicKv = $("#tbLicenseKv"),
        ctrlLicBeginDate = $("#tbBeginDate"),
        ctrlLicEndDate = $("#tbEndDate"),
        ctrlLicComment = $("#tbLicenseComment");
    //#region ******** public methods ********
    module.initialize = function (args) {
        // Инициализация параметров 
        contrID = args[0];
        okpo = args[1];
        CIM.setDebug(true);

        $("#btAddLicense").button({ icons: { primary: "ui-icon-plusthick" } });

        if (!diagLicense) {
            diagLicense = $('#dialogLicenseInfo');
            diagLicense.dialog({
                autoOpen: false,
                resizable: false,
                modal: false,
                width: 500,
                buttons: {
                    "Зберегти": function () {
                        if (saveLicense()) $(this).dialog("close");
                    },
                    "Відміна": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }

        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);
        $(".datepick").datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });
    }
    // 
    module.EditLicense = editLicense;
    module.DeleteLicense = deleteLicense;
    module.LinkLicense = linkLicense;
    module.GoBack = goBack;

    //#endregion

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) eval(callFunc);
    }
    //#region Clasess
    var LicenseClass = {
        LicenseId: null, Num: null, Okpo: null, Num: null, LicType: null,
        Kv: null, Sum: null, SumDoc: null, BeginDateS: null, EndDateS: null,
        Comment: null
    }
    var LicenseRow = { li: null, okpo: null, nm: null, tp: null, kv: null, s: "0.00", sd: null, bd: null, ed: null, com: null };
    //#endregion

    function linkLicense(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        location.href = "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=4&bound_id=" + rowdata.li + "&type_id=0";
    }

    //#region Редактирование\создание лицензии
    function editLicense(elem, insert) {
        // Інформація про платіж
        ctrlLicenseError.html("");
        var title = (insert) ? ("Створення ліцензії") : ("Редагування ліцензії");
        diagLicense.dialog('option', 'title', title);
        diagLicense.dialog('option', 'position', { my: "left top", at: "right top", of: elem });
        var rowdata = LicenseRow;

        if (!insert) 
            rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');

        ctrlLicSum.val(rowdata.s).removeClass("error");
        ctrlLicNum.val(rowdata.nm).removeClass("error");
        ctrlLicType.val(rowdata.tp).removeClass("error");
        ctrlLicKv.val(rowdata.kv).removeClass("error");
        ctrlLicBeginDate.val(rowdata.bd).removeClass("error");
        ctrlLicEndDate.val(rowdata.ed).removeClass("error");
        ctrlLicComment.val(rowdata.com).removeClass("error");

        LicenseClass.LicenseId = rowdata.li;
        diagLicense.dialog('open');
    }
    //#endregion

    //#region  Удаление платежа
    function deleteLicense(elem) {
        var rowdata = eval('(' + elem.parent().parent().attr("rd") + ')');
        var message = "Ви дійсно хочете видалити ліцензію ?";
        core$ConfirmBox(message, "Видалення ліцензії", function (result) { confirmAction(result, "deleteLicenseCall('" + rowdata.li + "')"); });
    }

    function deleteLicenseCall(rowid) {
        if (rowid)
            PageMethods.DeleteLicense(rowid, CIM.reloadPage, onFailed);
    }
    //#endregion

    //#region  Сохранение платежа 
    function saveLicense() {
        if (licenseIsValid()) {
            LicenseClass.Num = ctrlLicNum.val();
            LicenseClass.Sum = ctrlLicSum.val();
            LicenseClass.BeginDateS = ctrlLicBeginDate.val();
            LicenseClass.EndDateS = ctrlLicEndDate.val();
            LicenseClass.Kv = ctrlLicKv.val();
            LicenseClass.LicType = ctrlLicType.val();
            LicenseClass.Okpo = okpo;
            LicenseClass.Comment = ctrlLicComment.val();
            //CIM.debug("LicenseClass=", LicenseClass);
            PageMethods.UpdateLicense(LicenseClass, CIM.reloadPage, onFailed);
            return true;
        }
        return false;
    }
    //#endregion

    //#region Валидация платежа
    function licenseIsValid() {
        var errMessage = "";
        var flag = false;
        if (ctrlLicNum.val().length == 0) {
            errMessage += "* Вкажіть номер ліцензії<br>";
            flag = true;
        }
        if (flag) ctrlLicNum.addClass("error").focus();
        else ctrlLicNum.removeClass("error");
        flag = false;

        if (ctrlLicKv.val().length != 3) {
            errMessage += "* Вкажіть код валюти ліцензії<br>";
            flag = true;
        }
        if (flag) ctrlLicKv.addClass("error").focus();
        else ctrlLicKv.removeClass("error");
        flag = false;

        if (ctrlLicBeginDate.val().length == 0) {
            errMessage += "* Вкажіть дату ліцензії<br>";
            flag = true;
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlLicBeginDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlLicBeginDate.addClass("error").focus();
        else ctrlLicBeginDate.removeClass("error");
        flag = false;

        if (ctrlLicEndDate.val().length == 0) {
            errMessage += "* Вкажіть дату закінчення ліцензії<br>";
            flag = true;
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlLicEndDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlLicEndDate.addClass("error").focus();
        else ctrlLicEndDate.removeClass("error");
        flag = false;

        if (ctrlLicSum.val().length == 0 || ctrlLicSum.val() == 0) {
            errMessage += "* Вкажіть суму ліцензії<br>";
            flag = true;
        }

        if (flag) ctrlLicSum.addClass("error").focus();
        else ctrlLicSum.removeClass("error");

        ctrlLicenseError.html(errMessage);
        return (errMessage) ? (false) : (true);
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
        location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
    }
    //#endregion
    return module;
};
