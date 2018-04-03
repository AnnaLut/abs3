var tabsDiv = null; // объект табы

Sys.Application.add_load(function () {
    curr_module = CIM.contract_card_module();
    curr_module.initialize(CIM.args());
});

$(document).ready(function () {

});

CIM.contract_card_module = function () {
    var module = {}; // внутренний объект модуля 
    var actionMode = { CREATE: 0, VIEW: 1, EDIT: 2 };
    var mode = null;
    var contrID = null;
    var contrType = 0;
    var contrCreditTerm = 0;
    var searchMode = 0;
    var ctrlOkpo = null;
    var ctrlKv = null;
    var ctrlSum = null;
    var ctrlContType = null;
    var ctrlRnk = null;
    var ctrlBenef = null;
    var ctrlCreditTerm = null;

    // ******** public methods ********
    module.initialize = function (args) {
        // Инициализация параметров 
        mode = args[0];
        contrID = args[1];

        // инициализация табов
        tabsDiv = $('#tabs').tabs();

        // Закриваємо 
        $('#tbCrdAgreeDate').attr("disabled", "disabled");
        $('#tbCrdAgreeNum').attr("disabled", "disabled");
        $('#tbCrdDocKey').attr("disabled", "disabled");

        ctrlContType = $('select[name$="ddContrType"]');
        ctrlContType.bind("change", checkContrType);
        ctrlContType.change();

        ctrlKv = $('select[name$="ddKv"]');
        ctrlSum = $('input[name$="tbSum"]');
        ctrlCreditTerm = $('select[name$="ddCreditTerm"]');
        ctrlCreditTerm.bind("change", checkCreditType);
        ctrlCreditTerm.change();

        $('input[name$="btFormFile"]').bind('click', checkDownloadReq);
        $('#cbOldBankConract').bind('click', showOldBankReq);
        $('#cbOldDepConract').bind('click', showOldDepReq);
        $('#pnOldBankConract').hide();
        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);
        $("#tbDateOpen").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true, onClose: function () { $(this).valid(); } });
        $("#tbDateClose").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdAgreeDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdIndEndDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdEndingDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbApproveCrdDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdOperDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });

        // Валидация
        $.validator.setDefaults({ ignore: "" });
        $('form').validate({
            errorLabelContainer: $("div.error"),
            wrapper: "li",
            invalidHandler: function (form, validator) {
                var errors = validator.numberOfInvalids();
                if (errors) {
                    var invalidPanels = $(validator.invalidElements()).closest(".ui-tabs-panel", form);
                    if (invalidPanels.size() > 0) {
                        $.each($.unique(invalidPanels.get()), function () {
                            $(this).siblings(".ui-tabs-nav")
                              .find("a[href='#" + this.id + "']").parent().not(".ui-tabs-selected")
                                .addClass("ui-state-error")
                                .show("pulsate", { times: 4 });
                        });
                    }
                }
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass(errorClass);
                $(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
                var $panel = $(element).closest(".ui-tabs-panel", element.form);
                if ($panel.size() > 0) {
                    if ($panel.find("." + errorClass + ":visible").size() == 0) {
                        $panel.siblings(".ui-tabs-nav").find("a[href='#" + $panel[0].id + "']")
                          .parent().removeClass("ui-state-error");
                    }
                }
            }
        });
        // иницализация всех числовых контролов
        $('.numeric').numeric();

        $('#btSelClient').bind("click", function () { searchMode = 0; selectClient(); });
        $('#btSelClientByOkpo').bind("click", function () { searchMode = 1; selectClient(); });
        $('#btSelectBenef').bind("click", function () { selectBeneficiar(); });

        ctrlOkpo = $('#tbClientOkpo');
        ctrlOkpo.bind("change", function () { searchMode = 1; getClientInfo(null, $(this).val()); });

        ctrlRnk = $('#tbClientRnk');
        ctrlRnk.bind("change", function () { searchMode = 0; getClientInfo($(this).val(), null); });

        ctrlBenef = $('#tbBenefId');
        ctrlBenef.bind("change", function () { getBenefInfo($(this).val()); });

        $('#btRefresh').bind("click", reloadCallback);
        $('#btSave').bind("click", saveContract);
        $('#btCancel').bind("click", cancelContract);
        $('#btApproveNbu').bind("click", approveContract);
        $('#btDiscardNbu').bind("click", discardContract);

        if (mode == "view")
            populateContract();
        else
            tabsDiv.show();
    }
    // 
    module.AddContract = addContract;
    // ********************************

    // ******** private methods ********
    // Clasess
    var ContractClass = {
        ContrId: null, ContrType: null, Num: null, Rnk: null,
        Kv: null, Sum: null, BenefId: null, StatusId: 0,
        StatusName: null, Comments: null, Branch: null, BranchName: null,
        ClientInfo: null, BeneficiarInfo: null, DateOpenS: null, DateCloseS: null, CreditContractInfo: CreditContractClass
    }
    var CreditContractClass = {
        ContrId: null, NbuPercent: null, DefPercent: null, CrdLimit: null,
        CreditorType: null, CreditType: null, CreditPeriod: null, CreditTerm: null,
        CreditMethod: null, CreditPrepay: null, CreditName: null, CreditAddAgree: null,
        CreditPercent: null, CreditNbuInfo: null, CreditAgreeDateS: null, CreditAgreeNum: null,
        CreditDocKey: null, CrdIndEndDateS: null, CreditCrdParentChData: null, CreditEndingDate: null,
        CreditEndingDateS: null, CreditMargin: null, CreditTranshNum: null, CreditTranshSum: null,
        CreditTranshCurr: null, CreditTranshRatName: null, CreditTranshRat: null, CreditOperType: null, CreditOperDateS: null
    }

    function checkDownloadReq() {
        ExportRules("remove");
        ExportRules("add");

        return $("#aspnetForm").valid();
    }

    function showOldDepReq() {
        if ($(this).prop("checked")) {
            $('#pnOldBankConract').show();
            $('#trLetterDoc').show();
            $('#trOldBankMfo').hide();
            $('#trOldOblCode').hide();
            $("#cbOldBankConract").removeAttr("checked");
        }
        else {
            $('#pnOldBankConract').hide();
        }
    }

    function showOldBankReq() {
        if ($(this).prop("checked")) {
            $('#pnOldBankConract').show();
            $('#trLetterDoc').hide();
            $('#trOldBankMfo').show();
            $('#trOldOblCode').show();
            $("#cbOldDepConract").removeAttr("checked");
        }
        else {
            $('#pnOldBankConract').hide();
        }
    }

    // Вычитка данных по контракту
    function populateContract() {
        if (contrID)
            PageMethods.PopulateContract(contrID, onPopulateContract, onFailed);
    }
    function onPopulateContract(res) {
        // Иницализация внутреннего "класса" 
        ContractClass = res;
        CreditContractClass = res.CreditContractInfo;
        if (res.ContrId) {
            // Тип контракту
            ctrlContType.val(res.ContrType);
            ctrlContType.change();
            ctrlContType.attr("disabled", "disabled");
            // Тип контракту
            $("#tbConractNum").val(res.Num);
            $("#tbConractNum").attr("disabled", "disabled");
            // Внутрішній код контракту  
            $("#lbConractId").text(res.ContrId);
            // Статус контракту 
            $("#lbStatus").text(res.StatusName);
            // Дата відкриття \ закриття  
            $("#tbDateOpen").val(res.DateOpenS);
            $("#tbDateClose").val(res.DateCloseS);
            // коментар
            $("#tbComments").val(res.Comments);
            // Валюта контракту 
            ctrlKv.val(res.Kv);
            ctrlKv.attr("disabled", "disabled");
            // Сума контракту 
            ctrlSum.val(res.Sum);
            // Контрагент 
            setClientInfo(res.ClientInfo);
            ctrlOkpo.attr("disabled", "disabled");
            ctrlRnk.attr("disabled", "disabled");
            $('#btSelClient').hide();
            $('#btSelClientByOkpo').hide();
            // Бенефіціар
            setBenefInfo(res.BeneficiarInfo);
            ctrlBenef.attr("disabled", "disabled");
            $('#btSelectBenef').hide();

            /////// Кредитный контракт
            if (res.CreditContractInfo && res.CreditContractInfo.ContrId) {
                $('#tbCrdNbuPercent').val(res.CreditContractInfo.NbuPercent);
                $('#tbCrdDefPercent').val(res.CreditContractInfo.DefPercent);
                $('#tbCrdLimit').val(res.CreditContractInfo.CrdLimit);

                $('select[name$="ddCreditorType"]').val(res.CreditContractInfo.CreditorType);
                $('select[name$="ddCreditType"]').val(res.CreditContractInfo.CreditType);
                $('select[name$="ddCreditPeriod"]').val(res.CreditContractInfo.CreditPeriod);
                ctrlCreditTerm.val(res.CreditContractInfo.CreditTerm);
                ctrlCreditTerm.change();
                $('select[name$="ddCreditMethod"]').val(res.CreditContractInfo.CreditMethod);
                $('select[name$="ddCreditPrepay"]').val(res.CreditContractInfo.CreditPrepay);

                $('#tbCrdName').val(CreditContractClass.CreditName);
                $('select[name$="ddCreditPercent"]').val(CreditContractClass.CreditPercent);
                $('#tbCrdAgreeDate').val(CreditContractClass.CreditAgreeDateS);
                $('#tbCrdAgreeNum').val(CreditContractClass.CreditAgreeNum);
                $('#tbCrdDocKey').val(CreditContractClass.CreditDocKey);
                $('#tbCrdAddAgree').val(CreditContractClass.CreditAddAgree);
                $('#tbPencentNbuInfo').val(CreditContractClass.CreditNbuInfo);
                $('#tbCrdIndEndDate').val(CreditContractClass.CrdIndEndDateS);
                $('#tbCrdParentChData').val(CreditContractClass.CreditCrdParentChData);
                $('#tbCrdEndingDate').val(CreditContractClass.CreditEndingDateS);
                $('select[name$="ddCreditOperType"]').val(CreditContractClass.CreditOperType);
                $('#tbCrdMargin').val(CreditContractClass.CreditMargin);
                $('#tbCrdTranshNum').val(CreditContractClass.CreditTranshNum);
                $('#tbCrdTranshSum').val(CreditContractClass.CreditTranshSum);
                $('select[name$="ddCrdTranshCurr"]').val(CreditContractClass.CreditTranshCurr);
                $('#tbCrdTranshRatName').val(CreditContractClass.CreditTranshRatName);
                $('#tbCrdTranshRat').val(CreditContractClass.CreditTranshRat);
                $('#tbCrdOperDate').val(CreditContractClass.CreditOperDateS);

                // Діючий
                if (ContractClass.StatusId == 0) {
                    $('#tbCrdAgreeDate').removeAttr('disabled');
                    $('#tbCrdAgreeNum').removeAttr('disabled');
                    $('#tbCrdDocKey').removeAttr('disabled');
                    $("#pnDiscardNbu").hide();
                    $(".trApproveNew").hide();
                    $("#trOldBankConract").hide();
                }
                else {
                    // якщо закритий
                    if (ContractClass.StatusId == 1) {
                        $("#btSave").hide();
                        $("input:text").attr("disabled", "disabled");
                        $("textarea").attr("disabled", "disabled");
                        $("select").attr("disabled", "disabled");
                    }
                    else {
                        // Если статус контракта - 10 (Реєструється в НБУ)
                        if (ContractClass.StatusId == 10) {
                            $("#divApproveNbu").show();
                            $("#divPrepareNbu").hide();
                        }
                        else {
                            $("#divApproveNbu").hide();
                            $("#divPrepareNbu").show();
                        }
                    }
                }
            }
            // показ табов 
            tabsDiv.show();
        }
        else {
            core$WarningBox("Контракту з вказаним кодом не знайдено.", "Перегляд контракту");
        }
    }

    function checkContrType() {
        contrType = $(this).val();
        tabsDiv.tabs({ disabled: false });
        var disTabs = [1, 2, 3, 4];
        // для кредитних 
        if (contrType != 2)
            disTabs.push(5, 6);
        else {
            if (ContractClass.StatusId == 1)
                disTabs.push(6);
            if (mode == "create")
                disTabs.push(6);
        }
        if (contrType) disTabs.splice(contrType, 1);
        tabsDiv.tabs("option", "disabled", disTabs);

        if (contrType == 2) {
            addRules(creditRules);
            $('select[name$="ddCreditPeriod"]').rules("add", "required");
            $('select[name$="ddCreditTerm"]').rules("add", "required");
            $('select[name$="ddCreditMethod"]').rules("add", "required");
            $('select[name$="ddCreditPercent"]').rules("add", "required");
            //if (contrCreditTerm > 1)
            //    $('select[name$="ddCreditOperType"]').rules("add", "required");
            isCreditSet = true;
        }
        else {
            if (isCreditSet) {
                removeRules(creditRules);
                $('select[name$="ddCreditPeriod"]').rules("remove", "required");
                $('select[name$="ddCreditTerm"]').rules("remove", "required");
                $('select[name$="ddCreditMethod"]').rules("remove", "required");
                $('select[name$="ddCreditPercent"]').rules("remove", "required");
                //if (contrCreditTerm > 1)
                //    $('select[name$="ddCreditOperType"]').rules("remove", "required");
                isCreditSet = false;
            }
        }
    }

    function checkCreditType() {
        contrCreditTerm = $(this).val();
        $("#pnShortTermAgree").hide();
        //$("#pnLongTermAgree").hide();
        if (isCreditSet) {
            // пишем в hidden поле строковость кредита (нужно для имени файла)
            $('input[name$="hCreditTerm"]').val(contrCreditTerm);
            // Довгострокові
            if (contrCreditTerm == 1) {
                $("#pnLongTermAgree").show();
                $("#pnAddFiles").show();
                //$('select[name$="ddCreditOperType"]').rules("remove", "required");

            }
            else if (contrCreditTerm == 2 || contrCreditTerm == 3) {
                //$("#pnShortTermAgree").show();
                $("#pnAddFiles").show();
                //$('select[name$="ddCreditOperType"]').rules("add", "required");
            }
        }
    }

    /// Validation rules
    function ApproveRules(action) {
        $('#tbApproveCrdDocKey').rules(action, "required");
        if (ContractClass.StatusId == 10) {
            $('#tbApproveCrdDate').rules(action, "required");
            $('#tbApproveCrdNum').rules(action, "required");
        }
    }

    function ExportRules(action) {
        if (contrCreditTerm > 0 || action == "remove") {
            $('input[name$="fuAgreeDoc"]').rules(action, "required");
            if ($("#cbOldBankConract").prop("checked") || $("#cbOldDepConract").prop("checked")) {
                if ($("#cbOldDepConract").prop("checked") || action == "remove")
                    $('input[name$="fuLetterDoc"]').rules(action, "required");
                if ($("#cbOldBankConract").prop("checked") || action == "remove") {
                    $('input[name$="tbOldBankMfo"]').rules(action, "required");
                    $('input[name$="tbOldOblCode"]').rules(action, "required");
                }
                $('input[name$="tbOldBankCode"]').rules(action, "required");
                $('input[name$="tbOldBankOblCode"]').rules(action, "required");
            }
        }
    }

    var isCreditSet = false;

    var creditRules = {
        tbCrdNbuPercent: { required: true }
        /*,tbCrdDefPercent: { required: true }*/
    };

    function addRules(rulesObj) {
        for (var item in rulesObj) {
            $('#' + item).rules('add', rulesObj[item]);
        }
    }

    function removeRules(rulesObj) {
        for (var item in rulesObj) {
            if ($('#' + item).rules())
                $('#' + item).rules('remove');
        }
    }

    function addContract() {
    }

    /// ----------------------------
    /// Клиент - контрагент
    function selectClient() {
        var tail = '';
        if (searchMode == 1)
            tail = "okpo like \'" + ctrlOkpo.val() + "%\'";
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="' + tail + '"&role=wr_metatab&tabname=customer', null,
						        "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            ctrlRnk.val(result[0]);
            getClientInfo(result[0], result[2]);
        }
    }
    // Получаем информацию о клиенте
    function getClientInfo(rnk, okpo) {
        if (rnk || okpo)
            PageMethods.GetClientInfo(rnk, okpo, onGetClientInfo, onFailed);
    }

    function setClientInfo(client) {
        ctrlRnk.val((client) ? (client.Rnk) : (""));
        ctrlRnk.valid();
        ctrlOkpo.val((client) ? (client.Okpo) : (""));
        ctrlOkpo.valid();
        $('#lbNd').text((client) ? (client.Nd) : (""));
        $('#lbNmk').text((client) ? (client.Nmk) : (""));
        $('#lbNmkK').text((client) ? (client.NmkK) : (""));
        $('#lbVedName').text((client) ? (client.VedName) : (""));
    }

    function onGetClientInfo(res) {
        if (res.Rnk > 0) {
            setClientInfo(res);
        }
        else if (res.Rnk < 0) {
            selectClient();
        }
        else {
            if (searchMode == 0) {
                core$WarningBox("Контрагента з вказаним кодом [rnk=" + ctrlRnk.val() + "] не знайдено.", "Пошук контрагента");
                ctrlRnk.val("").focus();
            }
            else if (searchMode == 1) {
                core$WarningBox("Контрагента з вказаним кодом [okpo=" + ctrlOkpo.val() + "] не знайдено.", "Пошук контрагента");
                ctrlOkpo.val("").focus();
            }
            setClientInfo(null);
        }
    }
    /// ----------------------------

    /// ----------------------------
    /// Бенефициар
    function selectBeneficiar() {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="delete_date is null"&role=wr_metatab&tabname=CIM_BENEFICIARIES', null,
                                            'dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;');
        if (result) {
            $('#tbBenefId').val(result[0]);
            getBenefInfo(result[0]);
        }
    }
    function getBenefInfo(benefId) {
        if (benefId)
            PageMethods.GetBeneficiarInfo(benefId, onGetBeneficiarInfo, onFailed);
    }
    function setBenefInfo(benef) {
        $('#tbBenefId').val((benef) ? (benef.BenefId) : (""));
        $('#tbBenefId').valid();
        $('#lbBenefName').text((benef) ? (benef.Name) : (""));
        $('#lbCountryName').text((benef) ? (benef.CountryName) : (""));
        $('#lbBenefAddress').text((benef) ? (benef.Address) : (""));
        $('#lbBenefComment').text((benef) ? (benef.Comment) : (""));
    }

    function onGetBeneficiarInfo(res) {
        if (res.BenefId)
            setBenefInfo(res);
        else {
            core$WarningBox("Бенефіціара з вказаним кодом не знайдено.", "Пошук бенефіціара");
            $('#tbBenefId').val("").focus();
            setBenefInfo(null);
        }
    }
    /// ----------------------------
    // Подтверждение контракта
    function approveContract() {
        ExportRules("remove");
        ApproveRules("add");
        if ($("#aspnetForm").valid()) {
            ContractClass.CreditContractInfo.CreditAgreeDateS = $('#tbApproveCrdDate').val();
            ContractClass.CreditContractInfo.CreditAgreeNum = $('#tbApproveCrdNum').val();
            ContractClass.CreditContractInfo.CreditDocKey = $('#tbApproveCrdDocKey').val();
            PageMethods.ApproveNbuContract(ContractClass, onApproveNbuContract, onFailed);
        }
    }
    function onApproveNbuContract(res) {
        if (res) {
            core$SuccessBox("Контракт успішно підтверджено.", "Підтвердження контракту", reloadCallback);
        }
    }
    /// ----------------------------
    // Отклонение регистрации контракта
    function discardContract() {
        PageMethods.DiscardNbuContract(ContractClass, onDiscardNbuContract, onFailed);
    }
    function onDiscardNbuContract(res) {
        if (res) {
            core$SuccessBox("Реєстрацію контракту відхилено.", "Відхилення реестрації контракту", reloadCallback);
        }
    }
    /// ----------------------------
    // Сохранение контракта
    function saveContract() {
        // удаляем валидаторы для выгрузки в файл
        ApproveRules("remove");
        ExportRules("remove");
        if ($("#aspnetForm").valid()) {
            if (mode == "create") {
                ContractClass.ContrType = ctrlContType.val();
                ContractClass.Rnk = ctrlRnk.val();
                ContractClass.Kv = ctrlKv.val();
                ContractClass.Num = $("#tbConractNum").val();
                ContractClass.BenefId = ctrlBenef.val();
            }
            ContractClass.DateOpenS = $("#tbDateOpen").val();
            ContractClass.DateCloseS = $("#tbDateClose").val();
            ContractClass.Sum = fnDelAllWS(ctrlSum.val());
            ContractClass.Comments = $("#tbComments").val();

            if (ctrlContType.val() == 2) {
                if (!ContractClass.CreditContractInfo)
                    ContractClass.CreditContractInfo = CreditContractClass;
                ContractClass.CreditContractInfo.NbuPercent = $('#tbCrdNbuPercent').val();
                ContractClass.CreditContractInfo.DefPercent = $('#tbCrdNbuPercent').val(); /* поки ховаємо $('#tbCrdDefPercent').val();*/
                ContractClass.CreditContractInfo.CrdLimit = $('#tbCrdLimit').val();
                ContractClass.CreditContractInfo.CreditorType = $('select[name$="ddCreditorType"]').val();
                ContractClass.CreditContractInfo.CreditType = $('select[name$="ddCreditType"]').val();
                ContractClass.CreditContractInfo.CreditPeriod = $('select[name$="ddCreditPeriod"]').val();
                ContractClass.CreditContractInfo.CreditTerm = $('select[name$="ddCreditTerm"]').val();
                ContractClass.CreditContractInfo.CreditMethod = $('select[name$="ddCreditMethod"]').val();
                ContractClass.CreditContractInfo.CreditPrepay = $('select[name$="ddCreditPrepay"]').val();

                ContractClass.CreditContractInfo.CreditName = $('#tbCrdName').val();
                ContractClass.CreditContractInfo.CreditPercent = $('select[name$="ddCreditPercent"]').val();
                ContractClass.CreditContractInfo.CreditAgreeDateS = $('#tbCrdAgreeDate').val();
                ContractClass.CreditContractInfo.CreditAgreeNum = $('#tbCrdAgreeNum').val();
                ContractClass.CreditContractInfo.CreditDocKey = $('#tbCrdDocKey').val();
                ContractClass.CreditContractInfo.CreditAddAgree = $('#tbCrdAddAgree').val();
                ContractClass.CreditContractInfo.CreditNbuInfo = $('#tbPencentNbuInfo').val();
                ContractClass.CreditContractInfo.CrdIndEndDateS = $('#tbCrdIndEndDate').val();
                ContractClass.CreditContractInfo.CreditCrdParentChData = $('#tbCrdParentChData').val();
                ContractClass.CreditContractInfo.CreditEndingDateS = $('#tbCrdEndingDate').val();
                ContractClass.CreditContractInfo.CreditOperType = $('select[name$="ddCreditOperType"]').val();
                ContractClass.CreditContractInfo.CreditOperDateS = $('#tbCrdOperDate').val();
                ContractClass.CreditContractInfo.CreditMargin = $('#tbCrdMargin').val();
                ContractClass.CreditContractInfo.CreditTranshNum = $('#tbCrdTranshNum').val();
                ContractClass.CreditContractInfo.CreditTranshSum = $('#tbCrdTranshSum').val();
                ContractClass.CreditContractInfo.CreditTranshCurr = $('select[name$="ddCrdTranshCurr"]').val();
                ContractClass.CreditContractInfo.CreditTranshRatName = $('#tbCrdTranshRatName').val();
                ContractClass.CreditContractInfo.CreditTranshRat = $('#tbCrdTranshRat').val();
            }
            PageMethods.SaveContract(ContractClass, onSaveContract, onFailed);
        }
    }
    function onSaveContract(res) {
        if (res) {
            contrID = res;
            core$SuccessBox("Контракт успішно збережений.", "Редагування контракту", refreshCallback);
        }
    }

    function refreshCallback(result) {
        if (mode == "create" && contrID)
            location.href = "contract_card.aspx?mode=view&contr_id=" + contrID;
    }

    function reloadCallback(result) {
        location.href = location.href;
    }

    function cancelContract() {
        location.href = "/barsroot/cim/contracts/contracts_list.aspx";
    }

    // ******** callback methods ********

    function onFailed(error, userContext, methodName) {
        if (error !== null) {
            alert(error.get_message());
        }
    }
    // ********************************

    return module;
};
