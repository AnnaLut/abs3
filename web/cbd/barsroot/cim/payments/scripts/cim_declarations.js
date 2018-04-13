var diag = null; // объект всплывающего окна контекстного меню
var diagSendToBank = null;
var diagBindDoc = null;

Sys.Application.add_load(function () {
    curr_module = CIM.declaration_module();
    curr_module.initialize(CIM.args());
});

// Модуль нерозібрані митні декларації
CIM.declaration_module = function () {
    var module = {}; // внутрішній об'єкт модуля 
    var grid_id = null; // id головного гріда
    var contrID = null;
    var direct = null;
    var payFlag = 0; // признак основний \ додатковий
    var selRowData = null; // данные о выделенной строке о платежки 
    var isActBind = false;
    var sysDate = null;
    // фиксированый номер контракта
    var isFixedContract = false;
    var bindWithLink = false;
    var bindAsFantom = false;
    var isFillAllowDate = false;
    var statusDialogTimer; // таймер для показа окна состояния документа
    // объекты-контролы
    var ctrlDirect = $('select[name$="ddBDirect"]'),
        ctrlBType = $('select[name$="ddBActs"]'),
        ctrlDs = $("#tbBindDSum"),
        ctrlCs = $("#tbBindCSum"),
        ctrlRs = $("#tbBindRate"),
        ctrlBAct = $("#btBindAct"),
        ctrlVisaDoc = $("#btVisaDoc"),
        ctrlBackDoc = $("#btBackDoc"),
        ctrlABindStart = $('input[name$="tbABindStart"]'),
        ctrlABindFinish = $('input[name$="tbABindFinish"]'),
        ctrlABindOkpo = $('#tbABindOkpo'),
        ctrlBAllowDate = $("#lbBAllowDate");

    diagBindDoc = $('#dialogBindDecl');

    var BindClass = {
        PaymentType: null, PayFlag: null, Direct: null, DocRef: null,
        SumVP: null, SumComm: null, Rate: null, SumVC: null,
        OpType: null, Comment: null, Subject: null, ServiceCode: null, JContrNum: null, JContrDateS: null, JContrDate: null, JUnbind: false,
        DocKv: null, DocDateVal: null, DocDateValS: null, DocDetails: null, Rnk: null, BenefId: null, IsFantom: false, IsFullBind: false
    };

    //#region  ******** public methods ********
    // ініциалізація форми
    module.initialize = function (args) {
        // отладка
        CIM.setDebug(true);
        // Features 
        if (Features && Features.SendToBankOld)
            $("#btSendToBank").show();
        else
            $("#btSendToBank").hide();
        // установка начальных значений
        grid_id = args[0];
        contrID = args[1];
        isFixedContract = (contrID && contrID.length > 0);
        direct = args[2];
        payFlag = args[3];
        sysDate = args[4];
        isFillAllowDate = args[5] == "1";
        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);

        // Валидация
        $("#aspnetForm").validate();

        if (document.getElementById(grid_id))
            document.getElementById(grid_id).oncontextmenu = function () { return false; };
        diagSendToBank = $('#dialogSendToBank');
        if (diag) diag.dialog("destroy");
        diag = $('#dialogDeclInfo');
        diag.dialog({
            autoOpen: false,
            resizable: false
        });
        // при відведенні курсору з вікна інф. вікна - ховати його по таймауту
        diag.dialog("widget").unbind().hover(function () { clearTimeout(statusDialogTimer); }, hideStatusDialog);

        $("#btBindDecl").button()
            .next().button({
                text: false,
                icons: {
                    primary: "ui-icon-triangle-1-s"
                }
            })
            .click(function () {
                var menu = $(this).parent().next().show().position({
                    my: "left top",
                    at: "left bottom",
                    of: this
                });
                $(document).one("click", function () {
                    menu.hide();
                });
                return false;
            })
            .parent().buttonset().next().hide().menu();

        $(".barsGridView td").mousedown(function (e) {
            if (e.button == 2) {
                e.preventDefault;
                $(this).click();
                showStatusDialog($(this));
                return false;
            }
            else if (e.button == 1)
                hideStatusDialog();
            return true;
        });
        if (isFixedContract) {
            ctrlBAct.show();
        }

        $("#btSelClient").bind("click", selectClient);
        $("#btSelBenef").bind("click", selectBenef);
        $("#btSelBank").bind("click", selectBank);
    };

    module.CallbackSelContract = callbackSelContract;
    module.CallbackAfterLink = callbackAfterLink;
    // привязати документ
    module.DeclBind = declBind;
    module.HideDecl = hideDecl;
    // привязати фантом
    module.ActBind = actBind;
    // повернутися до стану контракту
    module.GoBack = goBack;
    module.AutoBind = autoBind;
    module.PrepareSendToBank = prepareSendToBank;
    module.DeleteAct = deleteAct;
    //#endregion

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

    //#region Выполнение привязки 
    function declBind(obj, mode) {
        if (!getSelected(obj)) return;
        if (selRowData.us <= 0) {
            core$WarningBox("Для даного МД вже виконано прив'язку.", "Прив'язка МД");
            return;
        }
        bindAsFantom = mode == 1;
        // если не фиксированый контракт, всегда выбираем
        if (!isFixedContract)
            core$IframeBox({ url: "/barsroot/cim/contracts/contracts_list.aspx?mode=select&okpo=" + selRowData.cop + "&direct=" + selRowData.di + "&payflag=2", width: 900, height: 550, title: "Вибір контаркту для прив'язки", callback: "curr_module.CallbackSelContract" });
        else
            populateContract(contrID);
    };

    function selectClient() {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail=""&role=wr_metatab&tabname=customer', null,
            "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            $("#tbClientRnk").val(result[0]);
            $("#lbClientNmk").html(result[1]);
        }
    }
    function selectBenef() {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="delete_date is null"&role=wr_metatab&tabname=CIM_BENEFICIARIES', null,
            'dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;');
        if (result) {
            $("#tbBenefId").val(result[0]);
            $("#lbBenefName").html(result[1]);
        }
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

    // collBack из окна выбора контракта    
    function callbackSelContract(res) {
        //CIM.debug("res=", res);
        if (res) {
            contrID = res;
            populateContract(contrID);
        }
    }
    // Вычитка данных по контракту
    function populateContract(contrID) {
        PageMethods.PopulateContract(contrID, onPopulateContract, CIM.onPMFailed);
    }
    function onPopulateContract(res) {
        // Иницализация внутреннего "класса" 
        CIM.ContractClass = res;
        if (res.ContrId >= 0) {
            showBindDialog();
        }
    }

    var ctrlBTypeOtp0 = null;
    function showBindDialog() {
        var fantomRow = null;
        var diagTitleMask = "Прив'язка {0} до контракту #" + contrID;
        //$("#tbPaperDate").val("");
        BindClass.IsFantom = isActBind || bindAsFantom;
        if (!ctrlBTypeOtp0)
            ctrlBTypeOtp0 = ctrlBType.find("option[value='0']");
        else {
            if (ctrlBType.find("option[value='0']").size() == 0)
                ctrlBType.append(ctrlBTypeOtp0);
        }
        if (isActBind || bindAsFantom) {
            fantomRow = {};

            $("#lbBNum").removeAttr("disabled");
            ctrlBType.find("option[value='0']").remove();
            fantomRow.kv = CIM.ContractClass.Kv;
            
            if (bindAsFantom) {
                fantomRow.vmdId = selRowData.rf;
                fantomRow.ald = selRowData.ald;
                fantomRow.dd = selRowData.ald;
                fantomRow.fn = selRowData.fn;
                fantomRow.fd = selRowData.fd;
                fantomRow.us = CIM.formatNum(selRowData.us);
                fantomRow.nm = selRowData.nm;
                fantomRow.vtp = 4;
                fantomRow.kv = selRowData.kv;
            } else {
                fantomRow.vtp = 1;
                ctrlBType.removeAttr("disabled");
            }

            
            fantomRow.rf = "";
            fantomRow.cnm = CIM.ContractClass.ClientInfo.NmkK;
            fantomRow.cop = CIM.ContractClass.ClientInfo.Okpo;
            fantomRow.bnm = CIM.ContractClass.BeneficiarInfo.Name;
            fantomRow.oti = -1;
            fantomRow.ot = "";
            //$("#tdAllowDate1").hide();
            //$("#tdAllowDate2").hide();

            ctrlBAllowDate.removeAttr("disabled").datepicker('enable');
            ctrlBAllowDate.val(fantomRow.ald);
            //$("#tbPaperDate").removeAttr("disabled").datepicker('enable');
            
            $("#tbDocKv").removeAttr("disabled");
            $("#lbHintMax").hide();
            $("#tdUnSum").hide();
            diagTitleMask = diagTitleMask.replace("{0}", 'акту');

            $("#tbDocKv").live("blur", function () { selRowData.kv = $(this).val(); sumEventBind(); });
            isActBind = false;
            //bindAsFantom = false;
        }
        else {
            $("#tdAllowDate1").show();
            $("#tdAllowDate2").show();
            ctrlBType.attr("disabled", "disabled");
            ctrlBType.val(0);
            ctrlBAllowDate.val(selRowData.ald);
            ctrlBAllowDate.attr("disabled", "disabled").datepicker('disable');
            $("#tbDocKv").attr("disabled", "disabled");
            $("#lbHintMax").show();
            $("#tdUnSum").show();
            diagTitleMask = diagTitleMask.replace("{0}", 'МД');

            /*if (isFillAllowDate) {
                $("#tbPaperDate").val(selRowData.ald);
                $("#tbPaperDate").attr("disabled", "disabled").datepicker('disable');
                //$(".ald").hide();
            }*/
        }
        if (!getSelected(fantomRow)) return;
        // платеж
        $("#tbDocKv").val(selRowData.kv);
        ctrlDirect.val((selRowData.di) ? (selRowData.di) : (direct));
        ctrlBType.val(selRowData.vtp);
        $("#lbBRef").html(selRowData.rf);
        $("#lbBNum").val(selRowData.nm);
        $("#lbBCustNmk").html(selRowData.cnm);
        $("#lbBCustOkpo").html(selRowData.cop);
        $("#lbBBenefName").html(selRowData.bnm);
        $("#lbBBenefCountry").html(selRowData.bcn);
        //if (!isFillAllowDate)
        //    $("#tbPaperDate").val(selRowData.dd);

        $("#tbBUnSum").val(CIM.formatNum(selRowData.us));

        //контракт
        $("#lbBConractNum").html(CIM.ContractClass.Num);
        $("#lbBConractId").html(CIM.ContractClass.ContrId);
        $("#lbBContrType").html(CIM.ContractClass.ContrTypeName);
        $("#lbBStatus").html(CIM.ContractClass.StatusName);
        $("#lbBDateOpen").html(CIM.ContractClass.DateOpenS);
        $("#lbBDateClose").html(CIM.ContractClass.DateCloseS);
        $("#lbBCCNmk").html(CIM.ContractClass.ClientInfo.NmkK);
        $("#lbBCCOkpo").html(CIM.ContractClass.ClientInfo.Okpo);
        $("#lbBCBNmk").html(CIM.ContractClass.BeneficiarInfo.Name);
        $("#lbBCBCountry").html(CIM.ContractClass.BeneficiarInfo.CountryName);
        $("#lbBCBAddress").html(CIM.ContractClass.BeneficiarInfo.Address);
        $("#lbBCKv").val(CIM.ContractClass.Kv);
        $("#lbBCSum").val(CIM.formatNum(CIM.ContractClass.Sum));


        $("#tbBindDSum").val(CIM.formatNum(selRowData.us));
        $("#lbBKvC").html(CIM.ContractClass.Kv);
        $("#lbHintMax").html("* < <b>" + CIM.formatNum(selRowData.us) + "</b>");
        $("#tbBindFee").val(CIM.formatNum(0));
        $("#tbBindFee, #tbBindDSum").live("change", sumControl);
        //rate
        sumEventBind();

        diagBindDoc.dialog("destroy");
        diagBindDoc.dialog({
            autoOpen: true,
            modal: true,
            width: 820,
            title: diagTitleMask,
            buttons: {
                "Зберегти та зв'язати МД з платежем": function () {
                    if (checkBinding(true)) $(this).dialog("close");
                },
                "Зберегти": function () {
                    if (checkBinding(false)) $(this).dialog("close");
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
        if (bindAsFantom) {
            $("#tbBComments").focus();
        }
    }
    function sumEventBind() {
        $("#lbBKvP").html(selRowData.kv);
        $("#lbBKvP2").html(selRowData.kv);
        if (selRowData.kv == CIM.ContractClass.Kv) {
            $("#tbBindRate").val(1).attr("disabled", "disabled");
            $("#tbBindCSum").val(CIM.formatNum(selRowData.us)).attr("disabled", "disabled");
        }
        else {
            $("#tbBindRate").val("0.00000000").removeAttr("disabled").live("blur", sumControl);
            $("#tbBindCSum").val("0.00").removeAttr("disabled").live("blur", sumControl);
        }
    }

    // логика проверки суми
    function sumControl() {
        if (ctrlDs.val() > selRowData.us && !bindAsFantom) {
            ctrlDs.val(CIM.formatNum(selRowData.us));
            alert("Сума прив'язки не може бути більше значення " + CIM.formatNum(selRowData.us));
        }
        var s = 0;
        if ($(this).attr("id") === "tbBindCSum") {
            s = ctrlCs.val() / (ctrlDs.val());
            if (!isNaN(s) && isFinite(s))
                ctrlRs.val(CIM.formatNum(s, 8));
        } else {
            s = ctrlDs.val() * ctrlRs.val();
            if (!isNaN(s))
                ctrlCs.val(CIM.formatNum(s));
        }
    }

    // Валидация привязки 
    function bindIsValid() {
        var errMessage = "";
        var flag = false;

        if (ctrlDs.val() <= 0) {
            errMessage += "* Недопустима сума прив'язки<br>";
            flag = true;
        }
        if (flag) ctrlDs.addClass("error").focus();
        else ctrlDs.removeClass("error");
        flag = false;

        if (ctrlCs.val() <= 0) {
            errMessage += "* Недопустима сума прив'язки у валюті контракту<br>";
            flag = true;
        }
        if (flag) ctrlCs.addClass("error").focus();
        else ctrlCs.removeClass("error");
        flag = false;

        if (ctrlRs.val() <= 0) {
            errMessage += "* Недопустимий курс<br>";
            flag = true;
        }
        if (flag) ctrlRs.addClass("error").focus();
        else ctrlRs.removeClass("error");
        flag = false;


        if ($("#tbDocKv").val() <= 0) {
            errMessage += "* Вкажіть валюту акту<br>";
            flag = true;
        }
        if (flag) $("#tbDocKv").addClass("error").focus();
        else $("#tbDocKv").removeClass("error");
        flag = false;

        if ($("#lbBNum").val().length == 0) {
            errMessage += "* Вкажіть номер акту<br>";
            flag = true;
        }
        if (flag) $("#lbBNum").addClass("error").focus();
        else $("#lbBNum").removeClass("error");
        flag = false;

        if (ctrlBAllowDate.val().length == 0 && ctrlBType.val() == 0) {
            flag = true;
            errMessage += "* Вкажіть дату дозволу<br>";
        }
        else {
            try { $.datepicker.parseDate('dd/mm/yy', ctrlBAllowDate.val()); }
            catch (e) { errMessage += "* Невірний формат дати<br>"; flag = true; }
        }
        if (flag) ctrlBAllowDate.addClass("error").focus();
        else ctrlBAllowDate.removeClass("error");
        flag = false;

        /*if ($("#tbPaperDate").val().length == 0 && (bindWithLink || ctrlBType.val() > 0)) {
            flag = true;
            errMessage += "* Вкажіть дату пап. носія<br>";
        } else {
            try {
                $.datepicker.parseDate('dd/mm/yy', $("#tbPaperDate").val());
            } catch (e) {
                errMessage += "* Невірний формат дати<br>";
                flag = true;
            }
        }
        if (flag) $("#tbPaperDate").addClass("error").focus();
        else $("#tbPaperDate").removeClass("error");
        flag = false;*/

        $("#dvBindError").html(errMessage);
        return (errMessage) ? (false) : (true);
    }

    // Сохранение привязки
    function checkBinding(link) {
        bindWithLink = link;
        // Валидация 
        if (bindIsValid()) {
            BindClass.DocKind = 1;
            BindClass.PaymentType = ctrlBType.val();
            BindClass.PayFlag = payFlag;
            BindClass.Direct = ctrlDirect.val();
            BindClass.DocRef = $("#lbBRef").html();
            BindClass.SumVP = ctrlDs.val();
            BindClass.IsFullBind = (selRowData.us == BindClass.SumVP);
            BindClass.SumVC = ctrlCs.val();
            BindClass.SumComm = 0;
            BindClass.Rate = ctrlRs.val();
            BindClass.Comment = $("#tbBComments").val();
            BindClass.AllowDateS = ctrlBAllowDate.val();
            //if (ctrlBType.val() == 1)
            //    BindClass.AllowDateS = $("#tbPaperDate").val();

            BindClass.DocKv = $("#tbDocKv").val();
            BindClass.DocNum = $("#lbBNum").val();
            BindClass.DocDateValS = BindClass.AllowDateS; //$("#tbPaperDate").val();

            if (bindAsFantom) {
                BindClass.FileName = selRowData.fn;
                BindClass.FileDateS = selRowData.fd;
                BindClass.VmdId = selRowData.vmdId;
                bindAsFantom = false;
            }
            //CIM.debug("BindClass=", BindClass);
            PageMethods.CheckBind(CIM.ContractClass, BindClass, onCheckBind, CIM.onPMFailed);
        }
    }

    function onCheckBind(res) {
        if (res.CodeMajor == 1 && res.Message) {
            core$ConfirmBox(res.Message, "Прив'язка МД", function (result) { confirmAction(result, "saveBinding()"); });
        }
        else
            saveBinding();
    }

    function saveBinding() {
        PageMethods.SaveDeclBind(CIM.ContractClass, BindClass, onSaveBind, CIM.onPMFailed);
    }

    function onSaveBind(res) {
        if (res) {
            // линкование 
            if (bindWithLink) {
                core$IframeBox({ url: "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=1&bound_id=" + res + "&direct=" + ctrlDirect.val() + "&type_id=" + ctrlBType.val() + "&back=0", width: 900, height: 550, title: "Лінкування МД", callback: "curr_module.CallbackAfterLink" });
                bindWithLink = false;
            }
            else if (isFixedContract)
                location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
            else
                CIM.reloadPage();
        }
    }

    function callbackAfterLink() {
        if (isFixedContract)
            location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
        else
            CIM.reloadPage();
    }

    function goBack() {
        location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
    }

    //#endregion

    //#region Выполнение привязки акта
    function actBind() {
        isActBind = true;
        populateContract(contrID);
    }
    //#endregion

    //#region Выполнение авто привязки всех МД
    function autoBind() {
        core$ConfirmBox("Виконати спробу автоматичної прив'язку по усім МД за вказаний період?", "Автоматична привязка", function (result) { confirmAction(result, "autoBindCall()"); });
    }

    function autoBindCall() {
        PageMethods.AutoBind(ctrlABindStart.val(), ctrlABindFinish.val(), ctrlABindOkpo.val(), onAutoBindCall, CIM.onPMFailed);
    }

    function onAutoBindCall(res) {
        if (res) {
            core$SuccessBox("Прив'язку успішно виконано.", "Авто-прив'язка МД");
        }
    }
    //#endregion

    // Видалення акту

    function deleteAct(vmdId) {
        PageMethods.DeleteAct(vmdId, CIM.reloadPage, CIM.onPMFailed);
    }

    // 
    function hideDecl(vmdId) {
        core$ConfirmBox("Приховати вказану МД зі списку (наді буде недоступна для для модуля)?", "Сховати МД", function (result) { confirmAction(result, "hideDeclCall(" + vmdId + ")"); });
    }

    function hideDeclCall(vmdId) {
        PageMethods.HideDecl(vmdId, CIM.reloadPage, CIM.onPMFailed);
    }

    //#region Пересылка в другой банк

    function prepareSendToBank(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.vtp != 0) {
            core$WarningBox("Вказана операція для актів недопустима.", "Передача в інший банк");
            return;
        }
        if (selRowData.us <= 0) {
            core$WarningBox("Для даної МД вже виконано прив'язку.", "Передача в інший банк");
            return;
        }
        PageMethods.PrepareForSend(selRowData.rf, selRowData.cop, onPrepareForSend, CIM.onPMFailed);
    }

    function onPrepareForSend(res) {
        if (res) {
            $("#tbClientRnk").val(res.Message);
            $("#lbClientNmk").html(selRowData.cnm);
            $("#tbUnboundSum").val(CIM.formatNum(selRowData.ts - res.DataDec));

            try {
                diagSendToBank.dialog("destroy");
            } catch (e) {
            }
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
    }

    function checkSendToBank() {
        var errMessage = "";
        var flag = false;

        if ($("#tbClientRnk").val() == "") {
            errMessage += "* Вкажіть клієнта (RNK)<br>";
            flag = true;
        }
        if (flag) $("#tbClientRnk").addClass("error").focus();
        else $("#tbClientRnk").removeClass("error");

        if ($("#tbBenefId").val() == "") {
            errMessage += "* Вкажіть бенефіціара<br>";
            flag = true;
        }
        if (flag) $("#tbBenefId").addClass("error").focus();
        else $("#tbJBenefId").removeClass("error");

        var fields = ["tbContrNum", "tbContrDate", "tbSBBankMfo", "tbSBBankName", "tbSBZapNum", "tbSBZapDate", "tbSBDir", "tbSBDirFio", "tbSBPerFio", "tbSBPerTel"];

        $.each(fields, function (i, val) {
            var elem = $("#" + val);
            if (elem.val() == "") {
                errMessage += "* " + elem.attr("title") + "<br>";
                elem.addClass("error").focus();
            }
            else
                elem.removeClass("error");
        });
        if ($("#tbUnboundSum").val() > selRowData.ts) {
            errMessage += "* Сума перевищуе допустиму<br>";
            $("#tbUnboundSum").addClass("error");
        }
        else
            $("#tbUnboundSum").removeClass("error");

        $("#dvSendToBank").html(errMessage);
        return (errMessage) ? (false) : (true);
    }

    function doSendToBank() {
        var BindClass = {};

        BindClass.BenefId = $("#tbBenefId").val();
        BindClass.JContrNum = $("#tbContrNum").val();
        BindClass.JContrDateS = $("#tbContrDate").val();
        BindClass.Rnk = $("#tbClientRnk").val();
        BindClass.SumVC = $("#tbUnboundSum").val();
        BindClass.SBBankMfo = $("#tbSBBankMfo").val();
        BindClass.SBBankName = $("#tbSBBankName").val();
        BindClass.SBZapNum = $("#tbSBZapNum").val();
        BindClass.SBZapDate = $("#tbSBZapDate").val();
        BindClass.SBDir = $("#tbSBDir").val();
        BindClass.SBDirFio = $("#tbSBDirFio").val();
        BindClass.SBPerFio = $("#tbSBPerFio").val();
        BindClass.SBPerTel = $("#tbSBPerTel").val();
        PageMethods.SendToBank(selRowData.rf, BindClass, onSendToBank, CIM.onPMFailed);
    }

    function onSendToBank(result) {
        var fields = ["tbContrNum", "tbContrDate", "tbSBBankMfo", "tbSBBankName", "tbSBZapNum", "tbSBZapDate", "tbSBDir", "tbSBDirFio", "tbSBPerFio", "tbSBPerTel"];
        $.each(fields, function (i, val) {
            $("#" + val).val("");
        });

        if (result.DataStr) {
            $("#ifDownload").remove();
            var fileName = escape("МД_mail" + sysDate + "_" + selRowData.nm.replace(/\//g, '_'));
            var iframe = $("<iframe id='ifDownload' src='/barsroot/cim/handler.ashx?action=download&fname=" + fileName + "&file=" + result.DataStr + "'></iframe>");
            iframe.hide();
            $('body').append(iframe);
        }
    }

    //#endregion

    //#region Панель контекстного меню
    // Ховаємо панель-акселератор
    function hideStatusDialog() {
        statusDialogTimer = setTimeout(function () { diag.dialog('close'); }, 500);
    }

    // Показати панель-акселератор з інформацією про документ
    function showStatusDialog(elem) {
        clearTimeout(statusDialogTimer);
        if (!elem) elem = $(this);
        diag.dialog('option', 'title', jsres$decl_module.action);
        var x = elem.offset().left + elem.outerWidth() - 4;
        var y = elem.offset().top - $(document).scrollTop() + elem.outerHeight() - 4;
        diag.dialog("option", "position", [x, y]);
        // очищаємо попередні властивості
        diag.find("a").css("cursor", "pointer")
                        .removeAttr("disabled")
                        .css("text-decoration", "underline")
                        .removeClass("ui-state-disabled")
                        .unbind('click')
                        .hover(function () { $(this).css("text-decoration", "none"); },
                               function () { $(this).css("text-decoration", "underline"); });
        // Інформація про документ
        var row = elem.parent();
        selRowData = eval('(' + row.attr("rd") + ')');

        var s = new Number(selRowData.ts);
        diag.find("#lbDeclId").html(jsres$decl_module.decl_id.replace("{0}", selRowData.rf));
        diag.find("#lbDeclNum").html(jsres$decl_module.num.replace("{0}", selRowData.nm));
        diag.find("#lbDeslSum").html(jsres$decl_module.sum.replace("{0}", s.toFixed(2)).replace("{1}", selRowData.kv));

        var disabledLinks = new Array();
        // Привязати документ (основний)
        if (selRowData.rf)
            diag.find("#lnBindDecl").click(function () {
                diag.dialog('close');
                declBind(selRowData, 0);
            });
        else
            disabledLinks.push("#lnBindDecl");

        if (selRowData.rf && selRowData.vtp == 0)
            diag.find("#lnBindDeclasFantom").click(function () {
                diag.dialog('close');
                declBind(selRowData, 1);
            });
        else
            disabledLinks.push("#lnBindDeclasFantom");

        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");

        diag.dialog('open');
    }
    //#endregion

    return module;
};