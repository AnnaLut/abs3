var diag = null; // объект всплывающего окна контекстного меню
var diagBindDoc = null; // объект всплывающего окна привязки документа
var diagBindWithJ = null;
var diagDocRels = null;

Sys.Application.add_load(function () {
    curr_module = CIM.pay_module();
    curr_module.initialize(CIM.args());
});

// Модуль нерозібрані платежі
CIM.pay_module = function () {
    var module = {}; // внутрішній об'єкт модуля 
    var grid_id = null; // id головного гріда
    var contrID = null;
    var direct = null;
    var payFlag = 0; // признак основний \ додатковий
    var visaId = 0; // код групы визирования валютного контроля 
    var sysDate = null;
    var bankDate = null;
    var selRowData = null; // данные о выделенной строке о платежки 
    var isFantomBind = false;
    var isPayAsFantomBind = false;
    var isBindWithJ = false;
    // фиксированый номер контракта
    var isFixedContract = false;
    var bindWithLink = false;
    var statusDialogTimer; // таймер для показа окна состояния документа
    var clearLicense = false;
    // объекты-контролы
    var ctrlDirect = $('select[name$="ddBDirect"]'),
        ctrlBType = $('select[name$="ddBType"]'),
        ctrlPayFlag = $('#ddPayFlag'),
        ctrlOpType = $('#ddBOperType'),
        ctrlDs = $("#tbBindDSum"),
        ctrlCs = $("#tbBindCSum"),
        ctrlFs = $("#tbBindFee"),
        ctrlRs = $("#tbBindRate"),
        ctrlBFantom = $("#btBindFantom"),
        ctrlVisaDoc = $("#btVisaDoc"),
        ctrlBackDoc = $("#btBackDoc"),
        ctrlApeServiceCode = $("#tbApeServiceCode"),
        ctrlBNazn = $("#tbBNazn"),
        ctrlBValDate = $("#lbBValDate"),
        ctrlBComments = $("#tbBComments"),
        ctrlDocKv = $("#tbDocKv"),
        ctrlBRef = $("#lbBRef");

    diagBindDoc = $('#dialogBindDoc');
    diagBindWithJ = $('#dialogBindWithJ');
    diagDocRels = $('#dialogDocRels');

    var BindClass = {
        PaymentType: null,
        PayFlag: null,
        Direct: null,
        DocRef: null,
        SumVP: null,
        SumComm: null,
        Rate: null,
        SumVC: null,
        OpType: null,
        Comment: null,
        Subject: null,
        ServiceCode: null,
        JContrNum: null,
        JContrDateS: null,
        JUnbind: false,
        DocKv: null,
        DocDateValS: null,
        DocDetails: null,
        Rnk: null,
        BenefId: null,
        IsFantom: false,
        IsFullBind: false,
        IsForSend: false
    };

    var payFlagArr = ["Основний", "Додатковий", "Тіло", "Проценти", "Комісія", "Пеня", "Інші"];
    //#region  ******** public methods ********
    // ініциалізація форми
    module.initialize = function (args) {
        // отладка
        CIM.setDebug(true);
        // Features 
        if (Features && Features.SendToBankOld)
            $("#liSendToBank").show();
        else
            $("#liSendToBank").hide();

        // установка начальных значений
        grid_id = args[0];
        contrID = args[1];
        isFixedContract = (contrID && contrID.length > 0);
        direct = args[2];
        payFlag = args[3];
        visaId = args[4];
        sysDate = args[5];
        bankDate = args[6];

        $("#btVisaDoc, #btBindPrimary").button()
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

        // Dates
        $.datepicker.setDefaults($.datepicker.regional["uk"]);
        $("#lbBValDate, #tbJContrDate").datepicker({
            showOn: "button",
            buttonImage: "/Common/Images/default/16/calendar.png",
            buttonImageOnly: true
        });

        // Валидация
        $("#aspnetForm").validate();

        if (document.getElementById(grid_id))
            document.getElementById(grid_id).oncontextmenu = function () { return false; };
        if (diag) diag.dialog("destroy");
        diag = $('#dialogDocInfo');
        diag.dialog({
            autoOpen: false,
            resizable: false
        });
        // при відведенні курсору з вікна інф. вікна - ховати його по таймауту
        diag.dialog("widget").unbind().hover(function () { clearTimeout(statusDialogTimer); }, hideStatusDialog);

        $(".barsGridView td").mousedown(function (e) {
            if (e.button == 2) {
                e.preventDefault;
                $(this).click();
                showStatusDialog($(this));
                return false;
            } else if (e.button == 1)
                hideStatusDialog();
            return true;
        });

        ctrlOpType.click(function () {
            showDictionary("CIM_OPERATION_TYPES");
        });
        //
        $("#btJSelClient").bind("click", selectJClient);
        $("#btJSelBenef").bind("click", selectJBenef);
        $("#btSelBank").bind("click", selectBank);
        $("#btCancel").button({ icons: { primary: "ui-icon-circle-arrow-w" } });

        if (isFixedContract) {
            ctrlBFantom.show();
            ctrlVisaDoc.parent().hide();
            ctrlBackDoc.hide();
        } else {
            ctrlVisaDoc.parent().show();
            ctrlBackDoc.show();
        }

        $("#btBindPrimary").parent().show();
        // Основный 
        if (payFlag == "0") {
            $("#btBindSecondary").hide();
        }
        else if (payFlag == "1") {
            $("#btBindPrimary").parent().hide();
        }
        //$(".rbByRef, .rbByDate").bind("change", searchMode);
    };

    module.CallbackSelContract = callbackSelContract;
    module.CallbackSetVisa = callbackSetVisa;
    module.CallbackAfterLink = callbackAfterLink;
    module.CallbackServiceCodes = callbackServiceCodes;
    module.CallbackAfterApeLink = callbackAfterApeLink;
    module.CallbackShowLink = callbackShowLink;

    // картка документу
    module.DocCard = docCard;
    module.ShowRels = showRels;
    // візувати документ
    module.DocSetVisa = docSetVisa;
    module.DocSetVisaWithJ = docSetVisaWithJ;
    module.DocSetVisaWithSend = docSetVisaWithSend;
    module.SetCheckiner = setCheckiner;
    module.SetCheckinerBack = setCheckinerBack;
    module.SetServiceCodes = setServiceCodes;
    module.PrintDoc = printDoc;
    module.EditDocAttr = editDocAttr;

    // сторнувати документ
    module.DocBackVisa = docBackVisa;
    // привязати документ
    module.DocBind = docBind;
    // привязати фантом
    module.FantomBind = fantomBind;
    // повернутися до стану контракту
    module.GoBack = goBack;
    //#endregion

    // ******** private methods ********

    function confirmAction(result, callFunc) {
        if (result) {
            eval(callFunc);
        }
    }

    function showDictionary(tableName) {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail=""&role=wr_metatab&tabname=' + tableName, null,
            'dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;');
        if (result) {
            ctrlOpType.empty();
            ctrlOpType.append($('<option value="' + result[0] + '">' + result[1] + '</option>'));
        }
    }

    function printDoc(ref, tt) {
        PageMethods.GetCorp2Doc(ref, tt, OnGetCorp2Doc, CIM.onPMFailed);
    }
    function OnGetCorp2Doc(result) {
        if (result.Code < 0) {
            core$WarningBox(result.Message, "Друк документу");
        }
        else if (result.DataStr) {
            $("#ifDownload").remove();
            var iframe = $("<iframe id='ifDownload' src='/barsroot/cim/handler.ashx?action=download&fname=" + result.Message + "&fext=rtf&file=" + result.DataStr + "'></iframe>");
            iframe.hide();
            $('body').append(iframe);
        }
    }

    function editDocAttr(ref, tt) {
        window.showModalDialog("/barsroot/docinput/editprops.aspx?ref=" + ref, null, 'dialogWidth:1100px;dialogHeight:700px;center:yes;edge:sunken;help:no;status:no;');
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

    //#region  Картка документу

    function docCard(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.rf && selRowData.pt == 0)
            core$IframeBox({ url: "/barsroot/documentview/default.aspx?ref=" + selRowData.rf, width: 900, height: 500, title: "Картка докумету ref=" + selRowData.rf });
        else
            alert("Картка фантомного платежу тимчасово недоступна");
    }

    //#endregion

    //#region Накладення візи 
    var afterBind = false;
    function docSetVisa(obj, _afterBind) {
        afterBind = _afterBind;
        if (!getSelected(obj)) return;
        if (selRowData.isv > 0) {
            core$WarningBox("Документ вже завізовано.", "Візування документу");
            return;
        }
        if (selRowData.rf && selRowData.pt == 0)
            PageMethods.CheckForVisa(selRowData.rf, null, OnCheckForVisa, CIM.onPMFailed);
        else
            core$WarningBox("Операція візування для фантомів недоступна.", "Візування фантому");
    }

    function OnCheckForVisa(result) {
        if (result.Code > 0) {
            core$WarningBox(result.Message, "Візування документу", function () { checkReload(); });
        } else {
            core$IframeBox({ url: "/barsroot/checkinner/documents.aspx?type=2&grpid=" + visaId, width: 850, height: 400, title: "Візування документу ref=" + selRowData.rf, callback: "curr_module.CallbackSetVisa", afterloadFunc: "curr_module.SetCheckiner" });
        }
    }


    function checkReload() {
        if (afterBind == true) {
            if (isFixedContract)
                location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
            else
                CIM.reloadPage();
            afterBind = false;
        }
    }

    function setCheckiner(iframeDocument) {
        if (iframeDocument && iframeDocument.getElementById("bt_OneStepBack")) {
            iframeDocument.getElementById("bt_OneStepBack").disabled = true;
            iframeDocument.getElementById("bt_Storno").disabled = true;
            iframeDocument.getElementById("bt_Filter").disabled = true;
        }
    }

    function callbackSetVisa(res, win) {
        if (isBindWithJ) {
            isBindWithJ = false;
            PageMethods.BindZeroContract(BindClass, CIM.reloadPage, CIM.onPMFailed);
        }
            // якщо на формі візування не виявилось документів, то пегружаєемо форму
        else if (win && win.returnServiceValue && win.returnServiceValue[3] && win.returnServiceValue[3].text == "0") {
            CIM.reloadPage();
        }
    }

    function emptyFunc() {
    }

    //#endregion

    //#region Привязка с отправкой в банк

    function docSetVisaWithSend(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.pt != 0) {
            core$WarningBox("Вказана операція для фантомів недопустима.", "Візування з відправкою в банк");
            return;
        }
        if (selRowData.us <= 0) {
            core$WarningBox("Для даного документу вже виконано прив'язку. Спробуйте завізувати його вручну.", "Прив'язка документу");
            return;
        }

        $("#tbJClientRnk").val(selRowData.crn);
        $("#lbJClientNmk").html(selRowData.cnm);
        $("#tbJBenefId").val("");
        $("#lbJBenefName").html("");
        $(".hideMode1").show();
        $(".hideMode0").hide();

        $("#tbSBSum71F").val(CIM.formatNum(0));
        $("#tbSBSum32A").val(CIM.formatNum(selRowData.us));

        try {
            diagBindWithJ.dialog("destroy");
        } catch (e) { }
        diagBindWithJ.dialog({
            autoOpen: true,
            modal: true,
            width: 800,
            title: "Передача в інший банк",
            buttons: {
                "Продовжити": function () {
                    if (checkBindingWithJ(true)) {
                        $(this).dialog("close");
                        doBindWithSend();
                    }
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
    }

    function doBindWithSend() {
        if (selRowData.rf && selRowData.pt == 0) {
            BindClass.PaymentType = selRowData.pt;
            BindClass.PayFlag = 0;
            BindClass.Direct = selRowData.di;
            BindClass.DocRef = selRowData.rf;
            BindClass.SumVP = $("#tbSBSum32A").val();
            BindClass.SumVC = $("#tbSBSum32A").val();
            BindClass.Rate = 1;
            BindClass.SumComm = 0;
            BindClass.IsFullBind = true;
            BindClass.Rnk = $("#tbJClientRnk").val();
            BindClass.BenefId = $("#tbJBenefId").val();
            BindClass.SumComm = 0;
            BindClass.JContrNum = $("#tbJContrNum").val();
            BindClass.JContrDateS = $("#tbJContrDate").val();
            BindClass.JUnbind = false;
            BindClass.IsForSend = true;
            BindClass.SBValDate = $("#tbSBValDate").val();
            BindClass.SBSum71F = $("#tbSBSum71F").val();
            BindClass.SBSum32A = $("#tbSBSum32A").val();
            BindClass.SBBankMfo = $("#tbSBBankMfo").val();
            BindClass.SBBankName = $("#tbSBBankName").val();
            BindClass.SBZapNum = $("#tbSBZapNum").val();
            BindClass.SBZapDate = $("#tbSBZapDate").val();
            BindClass.SBDir = $("#tbSBDir").val();
            BindClass.SBDirFio = $("#tbSBDirFio").val();
            BindClass.SBPerFio = $("#tbSBPerFio").val();
            BindClass.SBPerTel = $("#tbSBPerTel").val();

            PageMethods.CheckForVisa(selRowData.rf, BindClass, OnCheckForVisaWithSend, CIM.onPMFailed);
        }
    }
    function OnCheckForVisaWithSend(result) {
        if (result.Message) {
            core$WarningBox(result.Message, "Візування документу");
        } else {
            core$IframeBox({ url: "/barsroot/checkinner/documents.aspx?type=2&grpid=" + visaId, width: 900, height: 500, title: "Візування документу ref=" + selRowData.rf, callback: "curr_module.CallbackSetVisa", afterloadFunc: "curr_module.SetCheckiner" });
        }
        if (result.DataStr) {
            $("#ifDownload").remove();
            var fileName = escape("МВ_" + sysDate + "_" + selRowData.cnm);
            var iframe = $("<iframe id='ifDownload' src='/barsroot/cim/handler.ashx?action=download&fname=" + fileName + "&file=" + result.DataStr + "'></iframe>");
            iframe.hide();
            $('body').append(iframe);
        }
    }

    //#endregion

    //#region Накладення візи з занесенням в журнал
    // Клиент

    function selectJClient() {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail=""&role=wr_metatab&tabname=customer', null,
            "dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;");
        if (result) {
            $("#tbJClientRnk").val(result[0]);
            $("#lbJClientNmk").html(result[1]);
        }
    }

    function selectJBenef() {
        var result = window.showModalDialog('dialog.aspx?type=metatab&tail="delete_date is null"&role=wr_metatab&tabname=CIM_BENEFICIARIES', null,
            'dialogWidth:1000px;dialogHeight:600px;center:yes;edge:sunken;help:no;status:no;');
        if (result) {
            $("#tbJBenefId").val(result[0]);
            $("#lbJBenefName").html(result[1]);
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

    function selectServiceCodes() {
        core$IframeBox({ url: "/barsroot/cim/forms/ape_servicecodes.aspx", width: 900, height: 550, title: "Вибір класифікатора послуг зовнішньоекономічної діяльності", callback: "curr_module.CallbackServiceCodes", afterloadFunc: "curr_module.SetServiceCodes" });
    }

    function setServiceCodes(doc, frame) {
        var buts = frame.dialog("option", "buttons");
        frame.dialog('option', 'buttons', { 'Відмінити': function () { $(this).dialog('close'); } });
        //alert(doc.returnServiceCode);
        frame.find("button");
    }

    function callbackServiceCodes(result) {
        if (result) {
            ctrlApeServiceCode.val(result);
        }
    }

    function docSetVisaWithJ(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.pt != 0) {
            core$WarningBox("Операція візування для фантомів недоступна.", "Візування фантому");
            return;
        }
        if (selRowData.us <= 0) {
            core$WarningBox("Для даного документу вже виконано прив'язку. Спробуйте завізувати його вручну.", "Візування документу");
            return;
        }
        if (selRowData.isv > 0) {
            core$WarningBox("Документ вже завізовано.", "Візування документу");
            return;
        }
        $(".hideMode0").show();
        $(".hideMode1").hide();
        $("#tbJClientRnk").val(selRowData.crn);
        $("#lbJClientNmk").html(selRowData.cnm);
        $("#tbJBenefId").val("");
        $("#lbJBenefName").html("");
        $("#cbJUnBind").removeAttr("checked");

        try {
            diagBindWithJ.dialog("destroy");
        } catch (e) { }
        diagBindWithJ.dialog({
            autoOpen: true,
            modal: true,
            width: 600,
            title: "Прив'язка з занесенням в журнал",
            buttons: {
                "Продовжити": function () {
                    if (checkBindingWithJ()) {
                        $(this).dialog("close");
                        doBindWithJ();
                    }
                },
                "Відміна": function () {
                    $(this).dialog("close");
                }
            }
        });
    }

    function checkBindingWithJ(flagSB) {
        var errMessage = "";
        var flag = false;

        if ($("#tbJClientRnk").val() == "") {
            errMessage += "* Вкажіть клієнта (RNK)<br>";
            flag = true;
        }
        if (flag) $("#tbJClientRnk").addClass("error").focus();
        else $("#tbJClientRnk").removeClass("error");
        flag = false;

        if ($("#tbJBenefId").val() == "") {
            errMessage += "* Вкажіть бенефіціара<br>";
            flag = true;
        }
        if (flag) $("#tbJBenefId").addClass("error").focus();
        else $("#tbJBenefId").removeClass("error");

        if (flagSB) {
            var fields = ["tbJContrNum", "tbJContrDate", "tbSBValDate", "tbSBSum71F", "tbSBSum32A", "tbSBBankMfo", "tbSBBankName", "tbSBZapNum", "tbSBZapDate", "tbSBDir", "tbSBDirFio", "tbSBPerFio", "tbSBPerTel"];

            $.each(fields, function (i, val) {
                var elem = $("#" + val);
                if (elem.val() == "") {
                    errMessage += "* " + elem.attr("title") + "<br>";
                    elem.addClass("error").focus();
                }
                else
                    elem.removeClass("error");
            });
            if ($("#tbSBSum32A").val() && $("#tbSBSum32A").val() > selRowData.val) {
                errMessage += "* Сума перевищуе допустиму<br>";
            }
        }

        $("#dvBindJError").html(errMessage);
        return (errMessage) ? (false) : (true);
    }
    function doBindWithJ() {
        if (selRowData.rf && selRowData.pt == 0) {
            isBindWithJ = true;
            BindClass.PaymentType = selRowData.pt;
            BindClass.PayFlag = 0;
            BindClass.Direct = selRowData.di;
            BindClass.DocRef = selRowData.rf;
            BindClass.SumVP = selRowData.us;
            BindClass.SumVC = selRowData.us;
            BindClass.Rate = 1;
            BindClass.IsFullBind = true;
            BindClass.Rnk = $("#tbJClientRnk").val();
            BindClass.BenefId = $("#tbJBenefId").val();
            BindClass.SumComm = 0;
            BindClass.JContrNum = $("#tbJContrNum").val();
            BindClass.JContrDateS = $("#tbJContrDate").val();
            BindClass.JUnbind = $("#cbJUnBind").prop("checked");
            BindClass.IsForSend = false;
            PageMethods.CheckForVisa(selRowData.rf, BindClass, OnCheckForVisaWithJ, CIM.onPMFailed);
        }
    }

    function OnCheckForVisaWithJ(result) {
        if (result.DataDec && result.DataDec > 0)
            BindClass.BoundId = result.DataDec;
        if (result.Code > 0) {
            core$WarningBox(result.Message, "Візування документу");
            /*if (BindClass.JUnbind) {
                if (result.DataDec && result.DataDec > 0) {
                    BindClass.BoundId = result.DataDec;
                    PageMethods.UnboundPayment(BindClass, emptyFunc, CIM.onPMFailed);
                }
            }*/
        } else {
            core$IframeBox({ url: "/barsroot/checkinner/documents.aspx?type=2&grpid=" + visaId, width: 900, height: 500, title: "Візування документу ref=" + selRowData.rf, callback: "curr_module.CallbackSetVisa", afterloadFunc: "curr_module.SetCheckiner" });
        }
    }

    //#endregion

    //#region Повернення візи 

    function docBackVisa(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.ts - selRowData.us != 0) {
            core$WarningBox("До вказаного документу виконана прив'язка. Повернення не можливе.", "Повернення документу");
            return;
        }
        if (selRowData.rf) {
            if (selRowData.pt == 0 && selRowData.isv == 0) // ще не завызований, можно візувати 
                PageMethods.CheckForBackVisa(selRowData.rf, OnDocBackVisa, CIM.onPMFailed);
            else
                core$ConfirmBox("Ви дійсно хочете вилучити документ\\фантом зі списку нерозібраних ?", "Повернення платежу", function (result) { confirmAction(result, "confirmBackPayment()"); });
        }
    }

    function confirmBackPayment() {
        PageMethods.BackPayment(selRowData.pt, selRowData.rf, CIM.reloadAfterCallback, CIM.onPMFailed);
    }

    function OnDocBackVisa(result) {
        if (result.Code > 0) {
            core$WarningBox(result.Message, "Повернення документу");
        } else {
            core$IframeBox({ url: "/barsroot/checkinner/documents.aspx?type=2&grpid=" + visaId, width: 900, height: 550, title: "Повернення документу ref=" + selRowData.rf, callback: "curr_module.CallbackSetVisa", afterloadFunc: "curr_module.SetCheckinerBack" });
        }
    }

    function setCheckinerBack(iframeDocument) {
        if (iframeDocument) {
            iframeDocument.getElementById("bt_PutVisa").disabled = true;
            iframeDocument.getElementById("bt_Filter").disabled = true;
        }
    }

    //#endregion

    //#region Выполнение привязки 

    function docBind(pFlag, obj) {
        payFlag = pFlag;
        clearLicense = false;
        isPayAsFantomBind = false;
        if (pFlag == 2) {
            isPayAsFantomBind = true;
            payFlag = 0;
        }
        if (!getSelected(obj)) return;
        if (selRowData.us <= 0 || (isPayAsFantomBind && selRowData.us != selRowData.ts)) {
            core$WarningBox("Для даного документу вже виконано прив'язку. Спробуйте завізувати його вручну.", "Прив'язка документу");
            return;
        }
        // если не фиксированый контракт, всегда выбираем
        if (!isFixedContract)
            core$IframeBox({ url: "/barsroot/cim/contracts/contracts_list.aspx?mode=select&okpo=" + selRowData.cop + "&direct=" + selRowData.di + "&payflag=" + payFlag, width: 900, height: 550, title: "Вибір контаркту для прив'язки", callback: "curr_module.CallbackSelContract" });
        else
            populateContract(contrID);
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

    function populateContract(contrid) {
        PageMethods.PopulateContract(contrid, onPopulateContract, CIM.onPMFailed);
    }

    function onPopulateContract(res) {
        // Иницализация внутреннего "класса" 
        CIM.ContractClass = res;
        if (res.ContrId >= 0) {
            showBindDialog();
        }
    }

    function showBindDialog() {
        var fantomRow = null;
        var diagTitleMask = "Прив'язка {0} до контракту #" + contrID;
        BindClass.IsFantom = isFantomBind || isPayAsFantomBind;
        if (BindClass.IsFantom) {
            ctrlBType.removeAttr("disabled");
            ctrlBType.find("option[value='0']").remove();
            if (CIM.ContractClass.ContrType == 2) {
                ctrlBType.find("option[value='2']").remove();
                ctrlBType.find("option[value='3']").remove();
                ctrlBType.find("option[value='4']").remove();
            }

            ctrlBValDate.removeAttr("disabled").datepicker('enable');
            ctrlBNazn.removeAttr("disabled");
            ctrlDocKv.removeAttr("disabled");
            $("#lbHintMax").hide();
            $("#tdUnSum").hide();
            diagTitleMask = diagTitleMask.replace("{0}", 'фантому');

            ctrlDocKv.live("blur", function () {
                selRowData.kv = $(this).val();
                sumEventBind();
            });

            if (isFantomBind) {
                fantomRow = {};
                fantomRow.pt = 1;
                fantomRow.kv = CIM.ContractClass.Kv;
                fantomRow.rf = "";
                fantomRow.cnm = CIM.ContractClass.ClientInfo.NmkK;
                fantomRow.cop = CIM.ContractClass.ClientInfo.Okpo;
                fantomRow.bnm = CIM.ContractClass.BeneficiarInfo.Name;
                fantomRow.oti = -1;
                fantomRow.ot = "";
                isFantomBind = false;
            }
            //isPayAsFantomBind = false;
        } else {
            ctrlBType.attr("disabled", "disabled");
            ctrlBValDate.attr("disabled", "disabled").datepicker('disable');
            ctrlBNazn.attr("disabled", "disabled");
            ctrlDocKv.attr("disabled", "disabled");
            $("#lbHintMax").show();
            $("#tdUnSum").show();
            diagTitleMask = diagTitleMask.replace("{0}", 'платежу');
        }
        if (!getSelected(fantomRow)) return;
        // платеж
        ctrlDocKv.val(selRowData.kv);
        ctrlDirect.val((selRowData.di != null) ? (selRowData.di) : (direct));
        //$("#lbBTypeName").html(selRowData.ptn);
        ctrlBType.val(selRowData.pt);
        if (BindClass.IsFantom)
            ctrlBRef.html("");
        else
            ctrlBRef.html(selRowData.rf);
        $("#lbBCustNmk").html(selRowData.cnm);
        $("#lbBCustOkpo").html(selRowData.cop);
        $("#lbBBenefName").html(selRowData.bnm);
        ctrlBValDate.val(selRowData.vd);
        ctrlBNazn.val(selRowData.nz);
        $("#tbBUnSum").val(CIM.formatNum(selRowData.us));
        ctrlOpType.empty();
        if (selRowData.oti)
            ctrlOpType.append($('<option value="' + selRowData.oti + '">' + selRowData.ot + '</option>'));

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
        $("#tbBindFee").bind("change", sumControl);
        $("#tbBindDSum").bind("change", sumControl);
        //rate
        sumEventBind();
        // payflag
        var arr = [payFlag];
        ctrlPayFlag.empty();
        ctrlPayFlag.removeAttr("disabled");
        // кред. контракти у вихідних основних (2,3) та додаткових (3,4,5)
        if (CIM.ContractClass.ContrType == 2) {
            if (ctrlDirect.val() == 1 && payFlag == 0) {
                arr = [2, 3];
                ctrlPayFlag.bind("change", selectPayFlag);
            } else if (payFlag == 1)
                arr = [4, 5, 6];
            else {
                arr = [2];
                ctrlPayFlag.attr("disabled", "disabled");
            }
        } else
            ctrlPayFlag.attr("disabled", "disabled");
        $.each(arr, function (index, key) {
            ctrlPayFlag.append($("<option></option>").attr("value", key).text(payFlagArr[key]));
        });

        var buts = {};
        if (ctrlDirect.val() == 1) {
            ctrlFs.attr("disabled", "disabled");
            buts["Ліцензії"] = function () {
                if (bindIsValid()) {
                    if (!clearLicense)
                        clearNullLicense();
                    else
                        core$IframeBox({ url: "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=51&bound_id=-1&direct=" + ctrlDirect.val() + "&type_id=" + ctrlBType.val() + "&back=0&bound_type_name=" + $("option:selected", ctrlBType).text() + "&bound_kv=" + ctrlDocKv.val() + "&bound_sum=" + ctrlDs.val() + "&bound_sumvk=" + ctrlCs.val() + "&service_code=" + ctrlApeServiceCode.val() + "&bound_vdat=" + ctrlBValDate.val(), width: 900, height: 550, title: "Лінкування ліцензії" });
                }
            };
        }

        // торгові
        if (CIM.ContractClass.ContrType < 2 && payFlag != "1")
            buts["Зберегти та зв'язати платіж з МД"] = function () { if (checkBinding(true)) $(this).dialog("close"); };
        buts["Зберегти"] = function () { if (checkBinding(false)) $(this).dialog("close"); };
        buts["Відміна"] = function () { $(this).dialog("close"); };

        // Класифікатор послуг зовн.еком. діяльності
        if (ctrlDirect.val() == 1 && CIM.ContractClass.ContrType == 1 && CIM.ContractClass.TradeContractInfo.SubjectId == 1) {
            $("#btShowServiceCodes").bind("click", selectServiceCodes);
            $("#trApeServiceCode").show();
        } else {
            $("#trApeServiceCode").hide();
        }

        try {
            diagBindDoc.dialog('destroy');
        }
        catch (e) { };
        diagBindDoc.dialog({
            autoOpen: false,
            modal: true,
            width: 820,
            title: diagTitleMask,
            buttons: buts
        });
        diagBindDoc.dialog('open');
    }

    function clearNullLicense() {
        PageMethods.ClearNullLicense(CIM.ContractClass.ClientInfo.Okpo, onClearNullLicense, CIM.onPMFailed);
    }

    function onClearNullLicense(res) {
        clearLicense = true;
        core$IframeBox({ url: "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=51&bound_id=-1&direct=" + ctrlDirect.val() + "&type_id=" + ctrlBType.val() + "&back=0&bound_type_name=" + $("option:selected", ctrlBType).text() + "&bound_kv=" + ctrlDocKv.val() + "&bound_sum=" + ctrlDs.val() + "&bound_sumvk=" + ctrlCs.val() + "&service_code=" + ctrlApeServiceCode.val() + "&bound_vdat=" + ctrlBValDate.val(), width: 900, height: 550, title: "Лінкування ліцензії" });
    }

    function selectPayFlag() {
        ctrlFs.val("0.00");
        if (ctrlPayFlag.val() != 3)
            ctrlFs.attr("disabled", "disabled");
        else
            ctrlFs.removeAttr("disabled");
        sumControl();
    }

    function sumEventBind() {
        $("#lbBKvP").html(selRowData.kv);
        $("#lbBKvP2").html(selRowData.kv);
        if (selRowData.kv == CIM.ContractClass.Kv) {
            ctrlRs.val(1).attr("disabled", "disabled");
            ctrlCs.val(CIM.formatNum(selRowData.us)).attr("disabled", "disabled");
        } else {
            ctrlRs.val("0.00000000").removeAttr("disabled").live("blur", sumControl);
            ctrlCs.val("0.00").removeAttr("disabled").live("blur", sumControl);
        }
    }

    // логика проверки суми

    function sumControl() {
        if (ctrlDs.val() > selRowData.us && !BindClass.IsFantom) {
            ctrlDs.val(CIM.formatNum(selRowData.us));
            alert("Сума прив'язки не може бути більше значення " + CIM.formatNum(selRowData.us));
        }
        if (ctrlDs.val() - ctrlFs.val() < 0) {
            ctrlDs.val(CIM.formatNum(selRowData.us));
            ctrlFs.val(CIM.formatNum(0));
            alert("Сума комісії не може бути більша суми платежу");
        }
        //if (!ctrlRs.val() || !ctrlFs.val()) return;
        var s = 0;
        if ($(this).attr("id") === "tbBindCSum") {
            s = ctrlCs.val() / (ctrlDs.val() - (-1 * ctrlFs.val()));
            if (!isNaN(s) && isFinite(s))
                ctrlRs.val(CIM.formatNum(s, 8));
            else
                ctrlRs.val("1.00");
        } else {
            s = (ctrlDs.val() - (-1 * ctrlFs.val())) * ctrlRs.val();
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

        if (ctrlDocKv.val() <= 0) {
            errMessage += "* Вкажіть валюту фантому<br>";
            flag = true;
        }
        if (flag) ctrlDocKv.addClass("error").focus();
        else ctrlDocKv.removeClass("error");
        flag = false;

        if (!ctrlOpType.val() || ctrlOpType.val() < 0) {
            errMessage += "* Вкажіть тип операції<br>";
            flag = true;
        }
        if (flag) ctrlOpType.addClass("error");
        else ctrlOpType.removeClass("error");
        flag = false;

        if (!ctrlBNazn.val()) {
            errMessage += "* Вкажіть призначення.<br>";
            flag = true;
        }
        if (flag) ctrlBNazn.addClass("error");
        else ctrlBNazn.removeClass("error");
        flag = false;

        if (ctrlBValDate.val().length == 0) {
            flag = true;
            errMessage += "* Вкажіть дату валютування<br>";
        } else {
            try {
                $.datepicker.parseDate('dd/mm/yy', ctrlBValDate.val());
            } catch (e) {
                errMessage += "* Невірний формат дати<br>";
                flag = true;
            }
        }
        if (flag) ctrlBValDate.addClass("error").focus();
        else ctrlBValDate.removeClass("error");
        flag = false;

        if ($("#trApeServiceCode").css('display') != "none" && !ctrlApeServiceCode.val()) {
            errMessage += "* Вкажіть класифікатор послуг.<br>";
            flag = true;
        }
        if (flag) ctrlApeServiceCode.addClass("error");
        else ctrlApeServiceCode.removeClass("error");
        flag = false;

        $("#dvBindError").html(errMessage);
        return (errMessage) ? (false) : (true);
    }

    // Сохранение привязки

    function checkBinding(link) {
        bindWithLink = link;
        // Валидация 
        if (bindIsValid()) {
            BindClass.DocKind = 0;
            BindClass.PaymentType = ctrlBType.val(); //selRowData.pt;
            BindClass.PayFlag = ctrlPayFlag.val();
            BindClass.Direct = ctrlDirect.val();
            BindClass.DocRef = ctrlBRef.html();
            BindClass.SumVP = ctrlDs.val();
            BindClass.IsFullBind = (selRowData.us == BindClass.SumVP);
            BindClass.SumVC = ctrlCs.val();
            BindClass.SumComm = ctrlFs.val();
            BindClass.Rate = ctrlRs.val();
            BindClass.OpType = ctrlOpType.val();
            BindClass.Comment = ctrlBComments.val();
            BindClass.DocKv = ctrlDocKv.val();
            BindClass.DocDetails = ctrlBNazn.val();
            BindClass.DocDateValS = ctrlBValDate.val();
            BindClass.IsFantom = ctrlBType.val() > 0;
            BindClass.ServiceCode = ctrlApeServiceCode.val();
            if (CIM.ContractClass.TradeContractInfo)
                BindClass.Subject = CIM.ContractClass.TradeContractInfo.SubjectId;
            //CIM.debug("BindClass=", BindClass);
            PageMethods.CheckBind(CIM.ContractClass, BindClass, onCheckBind, CIM.onPMFailed);
        }
    }

    function onCheckBind(res) {
        if (res.CodeMajor == 1 && res.Message) {
            core$ConfirmBox(res.Message, "Прив'язка платежу", function (result) { confirmAction(result, "onCheckBindContinue(" + res.CodeMinor + ")"); });
        } else
            onCheckBindContinue(res.CodeMinor);
        /*if (res.CodeMinor > 0) {
            if (res.CodeMinor == 1)
                core$WarningBox("Сума контракту перевищує 100000 EUR (в еквіваленті). Перевірте наявніть відповідних актів цінової експертизи.", "Попередження", function () { saveBinding(); });
            else if (res.CodeMinor == 2)
                core$ConfirmBox("Для виконання прив'язки потрібна наявність акту цінової експертизи. Перейти на форму прив'язки актів ?", "Прив'язка акту", function (result) { confirmAction(result, "curr_module.CallbackShowLink()"); });
        } else
            saveBinding();*/
    }

    function onCheckBindContinue(codeMinor) {
        if (codeMinor > 0) {
            if (codeMinor == 1)
                core$WarningBox("Сума контракту перевищує 100000 EUR (в еквіваленті). Перевірте наявніть відповідних актів цінової експертизи.", "Попередження", function () { saveBinding(); });
            else if (codeMinor == 2)
                core$ConfirmBox("Для виконання прив'язки потрібна наявність акту цінової експертизи. Перейти на форму прив'язки актів ?", "Прив'язка акту", function (result) { confirmAction(result, "curr_module.CallbackShowLink()"); });
            else if (codeMinor == 3)
                core$WarningBox("Відсутні оф. курси валют за необхідний період. Здійснить розрахунок суми договору/платежу в ручному режимі. При необхідності виконайте привязки актів цінової до платежу на формі стану контракту.", "Попередження", function () { saveBinding(); });
        } else
            saveBinding();
    }

    function callbackShowLink() {
        core$IframeBox({ url: "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=9&bound_id=-1&direct=" + ctrlDirect.val() + "&type_id=" + ctrlBType.val() + "&back=0&bound_type_name=" + $("option:selected", ctrlBType).text() + "&bound_kv=" + ctrlDocKv.val() + "&bound_sum=" + ctrlDs.val() + "&bound_sumvk=" + ctrlCs.val() + "&service_code=" + ctrlApeServiceCode.val() + "&bound_vdat=" + ctrlBValDate.val(), width: 900, height: 550, title: "Лінкування акту", callback: "curr_module.CallbackAfterApeLink" });
    }

    function callbackAfterApeLink() {
        checkBinding(false);
    }


    function saveBinding() {
        PageMethods.SaveBind(CIM.ContractClass, BindClass, onSaveBind, CIM.onPMFailed);
    }

    function onSaveBind(res) {
        if (res) {
            // линкование 
            if (bindWithLink) {
                core$IframeBox({ url: "/barsroot/cim/payments/link_form.aspx?contr_id=" + contrID + "&mode=0&bound_id=" + res + "&direct=" + ctrlDirect.val() + "&type_id=" + ctrlBType.val() + "&back=0", width: 900, height: 550, title: "Лінкування платежу", callback: "curr_module.CallbackAfterLink" });
                bindWithLink = false;
            }
                // если на полную сумму - то вызываем визирование
            else if (BindClass.IsFullBind && (!BindClass.IsFantom || isPayAsFantomBind)) {
                diagBindDoc.dialog("destroy");
                docSetVisa(selRowData, true);
            }
            else {
                if (isFixedContract)
                    location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
                else
                    CIM.reloadPage();
            }
        }
    }

    function callbackAfterLink() {
        if (BindClass.IsFullBind && (!BindClass.IsFantom || isPayAsFantomBind)) {
            diagBindDoc.dialog("destroy");
            docSetVisa(selRowData);
        }
        else {
            if (isFixedContract)
                location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
            else
                CIM.reloadPage();
        }
    }


    function goBack() {
        location.href = "/barsroot/cim/contracts/contract_state.aspx?contr_id=" + contrID;
    }

    //#endregion

    //#region Выполнение привязки фантома
    function fantomBind() {
        isFantomBind = true;
        populateContract(contrID);
    }
    //#endregion

    //#region Показать связи с контрактом

    function showRels(obj) {
        if (!getSelected(obj)) return;
        if (selRowData.rf)
            PageMethods.GetDocRels(selRowData.rf, selRowData.pt, OnGetDocRels, CIM.onPMFailed);
    }

    function OnGetDocRels(res) {
        if (res) {
            var obj = eval('(' + res + ')');
            $("#tabRels  tbody tr").remove();
            $("#tabDelRels  tbody tr").remove();
            for (var ri in obj.tab) {
                //, subnum, s, open_date, c.contr_id, delete_date
                var row = "<td>" + obj.tab[ri][0] + "</td>"; //num
                row += "<td>" + obj.tab[ri][1] + "</td>";
                row += "<td style='text-align:center'>" + obj.tab[ri][3] + "</td>";
                row += "<td style='text-align:right;font-weight: bold'>" + CIM.formatNum(obj.tab[ri][2]) + "</td>";
                row += "<td>" + obj.tab[ri][4] + "</td>";
                if (obj.tab[ri][5]) {
                    row += "<td style='text-align:center'>" + obj.tab[ri][5] + "</td>";
                    $("#tabDelRels").append('<tr>' + row + '</tr>');
                } else {
                    row += "<td style='text-align:center'>" + obj.tab[ri][6] + "</td>";
                    $("#tabRels").append('<tr>' + row + '</tr>');
                }
            }
            $("#fsDelRels").toggle($("#tabDelRels tr").size() > 1);
            $("#fsRelsVIJ").toggle(obj.jpos > 0);

            $("#cbRelsVIJ").prop('checked', obj.jpos > 0);

            try {
                diagDocRels.dialog('destroy');
            }
            catch (e) { };
            diagDocRels.dialog({
                autoOpen: false,
                modal: false,
                width: 600,
                title: "Зв'язки з контрактами по документу\\фантому ref=" + selRowData.rf
            });
            diagDocRels.dialog('open');

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
        diag.dialog('option', 'title', jsres$pay_module.action);
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

        var typeName = null;
        if (selRowData.pt == 0)
            typeName = jsres$pay_module.real_pay;
        else if (selRowData.pt == 1)
            typeName = jsres$pay_module.unbound_real_pay;
        else if (selRowData.pt == 2)
            typeName = jsres$pay_module.unbound_fantom_pay;
        var s = new Number(selRowData.ts);
        diag.find("#lbDocRef").html(jsres$pay_module.ref.replace("{0}", selRowData.rf));
        diag.find("#lbPayType").html(jsres$pay_module.type.replace("{0}", typeName));
        diag.find("#lbTotalSum").html(jsres$pay_module.sum.replace("{0}", s.toFixed(2)).replace("{1}", selRowData.kv));

        var disabledLinks = new Array();
        // Карточка документу
        if (selRowData.rf)
            diag.find("#lnShowCard").click(function () {
                diag.dialog('close');
                docCard(selRowData);
            });
        else
            disabledLinks.push("#lnShowCard");

        // Завізувати документ
        if (selRowData.rf)
            diag.find("#lnSignDoc").click(function () {
                diag.dialog('close');
                docSetVisa(selRowData);
            });
        else
            disabledLinks.push("#lnSignDoc");

        // Сторнувати документ
        if (selRowData.rf)
            diag.find("#lnKillDoc").click(function () {
                diag.dialog('close');
                docBackVisa(selRowData);
            });
        else
            disabledLinks.push("#lnKillDoc");

        // Привязати документ (основний)
        if (selRowData.rf)
            diag.find("#lnBindDocMain").click(function () {
                diag.dialog('close');
                docBind(0, selRowData);
            });
        else
            disabledLinks.push("#lnBindDocMain");

        // Привязати документ (додатковий)
        if (selRowData.rf)
            diag.find("#lnBindDocAdd").click(function () {
                diag.dialog('close');
                docBind(1, selRowData);
            });
        else
            disabledLinks.push("#lnBindDocAdd");

        // Привязати документ (додатковий)
        if (selRowData.rf)
            diag.find("#lnContrRels").click(function () {
                diag.dialog('close');
                showRels(selRowData);
            });
        else
            disabledLinks.push("#lnBindDocAdd");


        diag.find(disabledLinks.join(",")).attr("disabled", "disabled").addClass("ui-state-disabled").css("text-decoration", "none");

        diag.dialog('open');
    }
    //#endregion

    return module;
};
