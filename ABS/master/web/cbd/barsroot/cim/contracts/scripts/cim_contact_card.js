var tabsDiv = null; // объект табы

Sys.Application.add_load(function () {
    curr_module = CIM.contract_card_module();
    curr_module.initialize(CIM.args());
});

$(document).ready(function () {
    $.validator.setDefaults({ ignore: "" });
});

CIM.contract_card_module = function () {
    var module = {}; // внутренний объект модуля 
    var actionMode = { CREATE: 0, VIEW: 1, EDIT: 2 };
    var CTYPE = { IMPORT: 0, EXPORT: 1, CREDIT: 2, OTHERS: 3 };
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
    var ctrlCreditBorrower = $('select[name$="ddCreditBorrower"]');
    var ctrlTrDeadline = $('select[name$="ddTrDeadline"]'),
        ctrlTrSpecs = $('select[name$="ddTrSpecs"]'),
        ctrlTrSubjects = $('select[name$="ddTrSubjects"]'),
        ctrlTrComments = $("#tbTrComments"),
        ctrlTrWithoutActs = $("#cbTrWithoutActs"),
        ctrlBranch = $('select[name$="ddBranch"]'),
        ctrlBenefBicCode = $("#tbBenefBicCode");

    var validationRules =
        {
            credit: {
                '#tbCrdNbuPercent': { required: true },
                'select[name$="ddCreditTerm"]': { required: true },
                'select[name$="ddCreditBorrower"]': { required: true },
                'select[name$="ddCreditorType"]': { required: true },
                'select[name$="ddCreditType"]': { required: true },
                'select[name$="ddCreditPrepay"]': { required: true },
                'select[name$="ddCreditPercent"]': { required: true }
            },
            trade: {
                'select[name$="ddTrDeadline"]': { required: true },
                'select[name$="ddTrSpecs"]': { required: true },
                'select[name$="ddTrSubjects"]': { required: true }
            }
        }

    // ******** public methods ********
    module.initialize = function (args) {
        // Инициализация параметров 
        mode = args[0];
        contrID = args[1];
        if (mode == "download") {
            window.close();
        }

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
        //$("#tbDateOpen").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true, onClose: function () { $(this).valid(); } });
        //$("#tbDateClose").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdAgreeDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdIndEndDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbCrdEndingDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbApproveCrdDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });
        $("#tbOldApproveCrdDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: false });
        $("#tbCrdOperDate").datepicker({ changeMonth: true, changeYear: true, showButtonPanel: true });

        // Валидация
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
                //alert(element.html());
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

        $('#btSelClient').bind("click", function () { searchMode = 0; selectClient(); });
        $('#btSelClientByOkpo').bind("click", function () { searchMode = 1; selectClient(); });
        $('#btSelectBenef').bind("click", function () { selectBeneficiar(); });
        $('#btSelectBenefBicCode').bind("click", function () { selectBeneficiarBicCode(); });
        

        ctrlOkpo = $('#tbClientOkpo');
        ctrlOkpo.bind("change", function () { searchMode = 1; getClientInfo(null, $(this).val()); });

        ctrlRnk = $('#tbClientRnk');
        ctrlRnk.bind("blur", function () { searchMode = 0; getClientInfo($(this).val(), null); });

        ctrlBenef = $('#tbBenefId');
        ctrlBenef.bind("blur", function () { getBenefInfo($(this).val()); });

        ctrlBenefBicCode.bind("blur", function () { getBenefBankInfo($(this).val()); });
        

        $('#btRefresh').bind("click", CIM.reloadPage);
        $('#btSave').bind("click", saveContract);
        $('#btCancel').bind("click", cancelContract);
        $('#btApproveNbu').bind("click", approveContract);
        $('#btDiscardNbu').bind("click", discardContract);
        $('#btSetOwner').bind("click", setOwner);
        $('#btChangeBranch').bind("click", setBranch);

        $('#btRefresh').button({ icons: { primary: "ui-icon-refresh" } });
        $('#btSave').button({ icons: { primary: "ui-icon-disk" } });
        $('#btCancel').button({ icons: { primary: "ui-icon-circle-arrow-w" } });

        if (mode == "view")
            populateContract();
        else
            tabsDiv.show();
    }
    // 
    module.AddContract = addContract;
    // ********************************

    // ******** private methods ********
    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }
    }

    // Clasess
    var ContractClass = {
        ContrId: null, ContrType: null, Num: null, SubNum: null, Rnk: null,
        Kv: null, Sum: null, BenefId: null, StatusId: 0,
        StatusName: null, Comments: null, Branch: null, BranchName: null,
        ClientInfo: null, BeneficiarInfo: null, DateOpenS: null, DateCloseS: null, CreditContractInfo: CreditContractClass
    }
    var CreditContractClass = {
        ContrId: null, NbuPercent: null, CrdLimit: null,
        CreditorType: null, CreditType: null, CreditTerm: null,
        CreditPrepay: null, CreditName: null, CreditAddAgree: null,
        CreditPercent: null, CreditNbuInfo: null, CreditAgreeDateS: null, CreditAgreeNum: null,
        CreditDocKey: null, CreditPrevReestrAttr: null, CrdIndEndDateS: null, CreditCrdParentChData: null, CreditEndingDate: null,
        CreditEndingDateS: null, CreditMargin: null, CreditTranshNum: null, CreditTranshSum: null,
        CreditTranshCurr: null, CreditTranshRatName: null, CreditTranshRat: null, CreditOperType: null, CreditOperDateS: null,
        F503_Reason: null, F503_State: null, F503_Note: null
    }
    var TradeContractClass = {
        ContrId: null, SpecId: null, SubjectId: null, WithoutActs: null, Deadline: null, SubjectText: null
    }
    var BeneficiarBankClass = {
        BicCodeId: '', BankB010: '', BankName: '', FetchMoreRows: false
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
        TradeContractClass = res.TradeContractInfo;
        BeneficiarBankClass = res.BeneficiarBankInfo;
        if (res.ContrId) {
            // Тип контракту
            ctrlContType.val(res.ContrType);
            ctrlContType.change();
            ctrlContType.attr("disabled", "disabled");
            // Тип контракту
            $("#tbConractNum").val(res.Num);
            $("#tbConractSubNum").val(res.SubNum);
            //$("#tbConractNum").attr("disabled", "disabled");
            // Внутрішній код контракту  
            $("#lbConractId").text(res.ContrId);
            // Статус контракту 
            $("#lbStatus").text(res.StatusName);
            // Дата відкриття \ закриття  
            $("#tbDateOpen").val(res.DateOpenS);
            $("#tbDateClose").val(res.DateCloseS);
            // коментар
            $("#tbComments").val(res.Comments);
            if (!res.OwnerName) {
                $("#lbOwnerUserId").text("[не задано]");
                $("#lbIOwnerName").text("[не задано]");
            } else {
                $("#lbOwnerUserId").text(res.OwnerUid);
                $("#lbIOwnerName").text(res.OwnerName);
            }

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

            if (res.BeneficiarBankInfo) 
                setBenefBankInfo(res.BeneficiarBankInfo);

            // Отделение
            ctrlBranch.val(res.Branch);

            // Торговий
            if (res.TradeContractInfo && res.TradeContractInfo.ContrId) {
                ctrlTrSpecs.val(res.TradeContractInfo.SpecId);
                ctrlTrSubjects.val(res.TradeContractInfo.SubjectId);
                if (res.TradeContractInfo.SubjectId == "1") {
                    $('#trWithoutActs').show();
                    ctrlTrWithoutActs.prop('checked', res.TradeContractInfo.WithoutActs);
                }
                ctrlTrDeadline.val(res.TradeContractInfo.Deadline);
                ctrlTrComments.val(res.TradeContractInfo.SubjectText);
            }
                // Кредитный контракт
            else if (res.CreditContractInfo && res.CreditContractInfo.ContrId) {
                $('#tbCrdNbuPercent').val(res.CreditContractInfo.NbuPercent);
                //$('#tbCrdDefPercent').val(res.CreditContractInfo.DefPercent);
                $('#tbCrdLimit').val(res.CreditContractInfo.CrdLimit);

                $('select[name$="ddCreditorType"]').val(res.CreditContractInfo.CreditorType);
                $('select[name$="ddCreditType"]').val(res.CreditContractInfo.CreditType);
                //$('select[name$="ddCreditPeriod"]').val(res.CreditContractInfo.CreditPeriod);
                ctrlCreditTerm.val(res.CreditContractInfo.CreditTerm);
                ctrlCreditTerm.change();
                ctrlCreditBorrower.val(res.CreditContractInfo.CreditorBorrower);
                //$('select[name$="ddCreditMethod"]').val(res.CreditContractInfo.CreditMethod);
                $('select[name$="ddCreditPrepay"]').val(res.CreditContractInfo.CreditPrepay);

                $('#tbCrdName').val(CreditContractClass.CreditName);
                $('select[name$="ddCreditPercent"]').val(CreditContractClass.CreditPercent);
                $('#tbCrdAgreeDate').val(CreditContractClass.CreditAgreeDateS);
                $('#tbCrdAgreeNum').val(CreditContractClass.CreditAgreeNum);
                $('#tbCrdPrevReestrAttr').val(CreditContractClass.CreditPrevReestrAttr);
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
                $('#ddF503Reason').val(CreditContractClass.F503_Reason);
                $('#ddF503State').val(CreditContractClass.F503_State);
                $('#tbF503Note').val(CreditContractClass.F503_Note);
                $('#ddF504Reason').val(CreditContractClass.F504_Reason);
                $('#tbF504Note').val(CreditContractClass.F504_Note);
                // Діючий
                if (ContractClass.StatusId == 0) {
                    $('#tbCrdAgreeDate').removeAttr('disabled');
                    $('#tbCrdAgreeNum').removeAttr('disabled');
                    $('#tbCrdDocKey').removeAttr('disabled');
                    $("#pnDiscardNbu").hide();
                    //$(".trApproveNew").hide();
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
        var disTabs = [1, 2, 3, 4, 5];
        var actTabs = [];
        tabsDiv.tabs("option", "disabled", disTabs);
        contrType = $(this).val();
        if (!contrType) return;

        activateRules(validationRules.credit, false);
        activateRules(validationRules.trade, false);
        if (contrType == CTYPE.IMPORT || contrType == CTYPE.EXPORT) {
            actTabs.push(1);
            activateRules(validationRules.trade, true);
            // def value 
            ctrlTrDeadline.val(180);
            ctrlTrSpecs.val(0);
        }
        else if (contrType == CTYPE.CREDIT) {
            actTabs.push(2, 4);
            if (ContractClass.StatusId != 1 && mode != "create")
                actTabs.push(5);

            activateRules(validationRules.credit, true);
            //addRules(creditRules);
            //$('select[name$="ddCreditTerm"]').rules("add", "required");
            //$('select[name$="ddCreditPercent"]').rules("add", "required");
            //isCreditSet = true;
        }
        else {
            if (isCreditSet) {
                removeRules(creditRules);
                $('select[name$="ddCreditTerm"]').rules("remove", "required");
                $('select[name$="ddCreditPercent"]').rules("remove", "required");
                isCreditSet = false;
            }
        }
        for (tab in actTabs)
            tabsDiv.tabs("enable", actTabs[tab]);

    }

    function activateRules(rulesObj, flag) {
        for (var item in rulesObj) {
            if (flag) {
                $(item).rules('add', rulesObj[item]);
            }
            else if ($(item).rules())
                $(item).rules('remove');
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
        $('#tbApproveCrdDate').rules(action, "required");
        $('#tbApproveCrdNum').rules(action, "required");
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

    function setOwner() {
        PageMethods.SetOwner(contrID, CIM.reloadPage, CIM.onPMFailed);
    }
    
    function setBranch() {
        if (ctrlBranch.val() == ContractClass.Branch) {
            core$WarningBox("Вказане віддідення - поточне для даного контракту.", "Зміна відділення");
        } else {
            core$ConfirmBox("Ви дійсно хочете змінити відділення контракту (з " + ContractClass.Branch + " на " + ctrlBranch.val() + ")", "Зміна відділення", function (result) { confirmAction(result, "setBranchCall()"); });
        }
    }
    
    function setBranchCall() {
        PageMethods.SetBranch(contrID, ctrlBranch.val(), CIM.reloadPage, CIM.onPMFailed);
    }

    /// ----------------------------
    /// Клиент - контрагент
    function selectClient() {
        var tail = '';
        if (searchMode == 1)
            tail = "okpo like \'%\'||\'" + ctrlOkpo.val().replace("*", "%") + "'||\'%\'";
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
        //$('#lbNd').text((client) ? (client.Nd) : (""));
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
        $('#lbCountryId').text((benef) ? (benef.CountryId) : (""));
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
    /// Бенефициар - Bic CODE
    function selectBeneficiarBicCode() {
        var tail = '';
        tail = "";//"bic like \'" + ctrlBenefBicCode.val().replace("*", "%") + "'||\'%\'";
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="' + tail + '"&role=wr_metatab&tabname=V_CIM_BANK_CODE', null,
						        "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            ctrlBenefBicCode.val(result[0]);
            getBenefBankInfo(result[0], result[2]);
        }
    }
    function getBenefBankInfo(bicCode, b010) {
        if (bicCode)
            PageMethods.GetBeneficiarBankInfo(bicCode, b010, onGetBeneficiarBankInfo, onFailed);
    }

    function setBenefBankInfo(benefBank) {
        BeneficiarBankClass = benefBank;
        ctrlBenefBicCode.val((benefBank) ? (benefBank.BicCodeId) : (""));
        $('#lbBenefBankName').text((benefBank) ? (benefBank.BankName) : (""));
        $('#lbBenefBankB010').html((benefBank && benefBank.BankB010) ? ("Код НБУ B010 : <b>" + benefBank.BankB010 + "</b>") : (""));
    }

    function onGetBeneficiarBankInfo(res) {
        if (res.FetchMoreRows)
            selectBeneficiarBicCode();
        else
            setBenefBankInfo(res);
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
            core$SuccessBox("Контракт успішно підтверджено.", "Підтвердження контракту", CIM.reloadPage);
        }
    }
    /// ----------------------------
    // Отклонение регистрации контракта
    function discardContract() {
        PageMethods.DiscardNbuContract(ContractClass, onDiscardNbuContract, onFailed);
    }
    function onDiscardNbuContract(res) {
        if (res) {
            core$SuccessBox("Реєстрацію контракту відхилено.", "Відхилення реестрації контракту", CIM.reloadPage);
        }
    }
    /// ----------------------------
    // Сохранение контракта
    function saveContract() {
        // удаляем валидаторы для выгрузки в файл
        ApproveRules("remove");
        ExportRules("remove");
        // Тип кредитора “(ЄБРР)…” допустимий тільки для контрактів у гривні.
        if (ctrlKv.val() != 980) {
            $('select[name$="ddCreditorType"]').rules("add", { range: [1, 10] });
            $('select[name$="ddCreditorType"]').attr("title", "Вказаний тип кредитора допустимий лише для гривні.");
        }
        else {
            $('select[name$="ddCreditorType"]').rules("remove");
        }

        if ($("#aspnetForm").valid()) {
            if (mode == "create") {
                ContractClass.ContrType = ctrlContType.val();
                ContractClass.Rnk = ctrlRnk.val();
                ContractClass.Kv = ctrlKv.val();
                ContractClass.Num = $("#tbConractNum").val();
                ContractClass.SubNum = $("#tbConractSubNum").val();
                ContractClass.BenefId = ctrlBenef.val();
            }
            ContractClass.Num = $("#tbConractNum").val();
            ContractClass.SubNum = $("#tbConractSubNum").val();
            ContractClass.DateOpenS = $("#tbDateOpen").val();
            ContractClass.DateCloseS = $("#tbDateClose").val();
            ContractClass.Sum = fnDelAllWS(ctrlSum.val());
            ContractClass.Comments = $("#tbComments").val();

            if (ctrlContType.val() == 0 || ctrlContType.val() == 1) {
                if (!ContractClass.TradeContractInfo)
                    ContractClass.TradeContractInfo = TradeContractClass;
                ContractClass.TradeContractInfo.SpecId = ctrlTrSpecs.val();
                ContractClass.TradeContractInfo.SubjectId = ctrlTrSubjects.val();
                ContractClass.TradeContractInfo.WithoutActs = (ctrlTrWithoutActs.prop('checked') ? (1):(0));
                ContractClass.TradeContractInfo.Deadline = ctrlTrDeadline.val();
                ContractClass.TradeContractInfo.SubjectText = ctrlTrComments.val();
            }
            if (ctrlContType.val() == 2) {
                if (!ContractClass.CreditContractInfo)
                    ContractClass.CreditContractInfo = CreditContractClass;
                ContractClass.CreditContractInfo.NbuPercent = $('#tbCrdNbuPercent').val();
                //ContractClass.CreditContractInfo.DefPercent = $('#tbCrdNbuPercent').val(); /* поки ховаємо $('#tbCrdDefPercent').val();*/
                ContractClass.CreditContractInfo.CrdLimit = $('#tbCrdLimit').val();
                ContractClass.CreditContractInfo.CreditorType = $('select[name$="ddCreditorType"]').val();
                ContractClass.CreditContractInfo.CreditorBorrower = ctrlCreditBorrower.val();
                ContractClass.CreditContractInfo.CreditType = $('select[name$="ddCreditType"]').val();
                //ContractClass.CreditContractInfo.CreditPeriod = $('select[name$="ddCreditPeriod"]').val();
                ContractClass.CreditContractInfo.CreditTerm = $('select[name$="ddCreditTerm"]').val();
                //ContractClass.CreditContractInfo.CreditMethod = $('select[name$="ddCreditMethod"]').val();
                ContractClass.CreditContractInfo.CreditPrepay = $('select[name$="ddCreditPrepay"]').val();

                ContractClass.CreditContractInfo.CreditName = $('#tbCrdName').val();
                ContractClass.CreditContractInfo.CreditPercent = $('select[name$="ddCreditPercent"]').val();
                ContractClass.CreditContractInfo.CreditAgreeDateS = $('#tbCrdAgreeDate').val();
                ContractClass.CreditContractInfo.CreditAgreeNum = $('#tbCrdAgreeNum').val();
                ContractClass.CreditContractInfo.CreditDocKey = $('#tbCrdDocKey').val();
                ContractClass.CreditContractInfo.CreditAddAgree = $('#tbCrdAddAgree').val();
                ContractClass.CreditContractInfo.CreditPrevReestrAttr = $('#tbCrdPrevReestrAttr').val();
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
                ContractClass.CreditContractInfo.F503_Reason = $('#ddF503Reason').val();
                ContractClass.CreditContractInfo.F503_State = $('#ddF503State').val();
                ContractClass.CreditContractInfo.F503_Note = $('#tbF503Note').val();
                ContractClass.CreditContractInfo.F504_Reason = $('#ddF504Reason').val();
                ContractClass.CreditContractInfo.F504_Note = $('#tbF504Note').val();
            }

            //if (!ContractClass.BeneficiarBankInfo)
            ContractClass.BeneficiarBankInfo = BeneficiarBankClass;
            //ContractClass.BeneficiarBankInfo.BicCodeId = ctrlBenefBicCode.val();

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

    function cancelContract() {
        location.href = "/barsroot/cim/contracts/contracts_list.aspx";
    }

    // ******** callback methods ********

    function onFailed(error, userContext, methodName) {
        if (error !== null) {
            //core$ErrorBox2();
            alert(error.get_message());
        }
    }
    // ********************************

    return module;
};
