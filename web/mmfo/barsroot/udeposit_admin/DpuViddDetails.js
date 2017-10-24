var dsRates;

$(document).ready(function () {
    //
    $("#tbTypeId").prop("readOnly", true);
    $("#tbTypeId").css("background-color", "gainsboro");
    //
    // $("#tbMinAmount").kendoMaskedDatePicker({});
    $("#ddlTypes").on("change", function () {
        $("#tbTypeId").val($(this).val());
    });
    //
    $("#tbViddId").prop("readOnly", true);
    $("#tbViddId").css("background-color", "gainsboro");
    //
    $("#ddlCurrencies").on("change", function () {
        $("#tbCurrencyId").val($(this).val());
    });
    //
    $("#tbPeriodId").prop("readOnly", true);
    $("#tbPeriodId").css("background-color", "gainsboro");
    //
    $("#ddlPeriods").on("change", function () {
        var s181 = $(this).val()
        if ($("#tbPeriodId").val() != s181) {
            $("#tbPeriodId").val(s181);
            $("#tbNbsDepNum").val("");
            $("#tbNbsIntNum").val("");
            // 
            if (s181 == "1" || s181 == "2") {
                $("#cbIrrevocable").prop('checked', true);
                $("#cbIrrevocable").prop('disabled', true);
            }
            else {
                $("#cbIrrevocable").prop('checked', false);
                $("#cbIrrevocable").prop('disabled', false);
            }
            $("#cbIrrevocable").trigger("change");
            //
            var url = bars.config.urlContent("/api/reference/handbook/V_DPU_NBS?clause=NBS_S181='" + s181 + "'");
            $.get(url, function (request) {
                if (request.Total > 0) {
                    // populate drop down list
                    var ddl = $("#ddlNbsDepName");
                    ddl.empty(); // remove old options
                    ddl.append(new Option("", ""));
                    for (var i = 0; i < request.Data.length; i++) {
                        ddl.append($('<option>').val(request.Data[i].NBS_CODE).text(request.Data[i].NBS_NAME));
                        //ddl.append(new Option(request.Data[i].NBS_NAME, request.Data[i].NBS_CODE.text));
                    }
                }
                else {
                    bars.ui.alert({ text: "Балансовий рахунок для коду строку " + s181 + " не знайдено в довіднику!" });
                }
            })            
        }
    });
    //
    //$("#tbPeriodId").val("");
    $("#ddlPeriods").trigger("change");
    //
    $("#tbNbsDepNum").prop("readOnly", true);
    $("#tbNbsDepNum").css("background-color", "lightgray");
    $("#ddlNbsDepName").on("change", function () {
        $("#tbNbsDepNum").val($(this).val());
        $("#tbNbsIntNum").val($(this).val().substr(0,3)+"8");

    });
    // 
    $("#tbNbsIntNum").prop("readOnly", true);
    $("#tbNbsIntNum").css("background-color", "lightgray");
    $("#tbNbsIntName").prop("disabled", true);
    //
    $("#tbTermMinMonths").on("keydown", doNum);
    $("#tbTermMinDays").on("keydown", doNum);
    $("#tbTermMaxMonths").on("keydown", doNum);
    $("#tbTermMaxDays").on("keydown", doNum);
    //
    $("#tbBaseYId").prop("readOnly", true);
    $("#tbBaseYId").css("background-color", "lightgray");
    $("#ddlBaseY").on("change", function () {
        $("#tbBaseYId").val($(this).val());
    });
    //
    $("#tbClcIntFrqId").prop("readOnly", true);
    $("#tbClcIntFrqId").css("background-color", "lightgray");
    $("#ddlClcIntFrqs").on("change", function () {
        $("#tbClcIntFrqId").val($(this).val());
    });
    //
    $("#tbMethodId").prop("readOnly", true);
    $("#tbMethodId").css("background-color", "lightgray");
    $("#ddlMethods").on("change", function () {
        $("#tbMethodId").val($(this).val());
    });
    //
    $("#tbBaseRateId").prop("readOnly", true);
    $("#tbBaseRateId").css("background-color", "lightgray");
    $("#ddlBaseRates").on("change", function () {
        $("#tbBaseRateId").val($(this).val());
    });
    //
    $("#tbFrequencyId").prop("readOnly", true);
    $("#tbFrequencyId").css("background-color", "lightgray");
    $("#ddlFrequencies").on("change", function () {
        $("#tbFrequencyId").val($(this).val());
    });
    //
    $("#tbPenaltyId").prop("readOnly", true);
    $("#tbPenaltyId").css("background-color", "lightgray");
    $("#ddlPenalties").on("change", function () {
        $("#tbPenaltyId").val($(this).val());
    });
    //
    $("#tbExnMethodId").prop("readOnly", true);
    $("#tbExnMethodId").css("background-color", "lightgray");
    $("#ddlExnMethods").on("change", function () {
        $("#tbExnMethodId").val($(this).val());
    });
    //
    $("#tbTemplateId").prop("readOnly", true);
    $("#tbTemplateId").css("background-color", "lightgray");
    $("#ddlTemplates").on("change", function () {
        $("#tbTemplateId").val($(this).val());
    });
    //
    $("#tbOperationCode").prop("readOnly", true);
    $("#tbOperationCode").css("background-color", "lightgray");
    $("#tbOperationCode").on("change", function () {
        var code = $(this).val().toUpperCase();
        $(this).val(code);
        if (code.length > 0) {
            var url = bars.config.urlContent("/api/reference/handbook/tts?clause=tt='") + code + "'";
            $.get(url, function (request) {
                if (request.Total > 0) {
                    $("#tbOperationName").val(request.Data[0].NAME);
                }
                else {
                    $("#tbOperationName").val("");
                    bars.ui.alert({ text: "Значення " + code + " не знайдено!" });
                }
            })
        }
    });
    $("#tbOperationCode").trigger("change");
    //
    $("#cbComproc").on("change", function () {
        if ($(this).prop("checked")) {
            $("#tbFrequencyId").val("5");
            // $("#tbFrequencyId").prop("disabled", true);
            $("#ddlFrequencies").prop("disabled", true);
            $("#Comproc").val("1");
        }
        else {
            // $("#tbFrequencyId").prop("disabled", false);
            $("#ddlFrequencies").prop("disabled", false);
            $("#Comproc").val("0");
        }
    });
    $("#cbComproc").trigger("change");
    
    //
    $("#cbIrrevocable").on("change", function () {
        if ($(this).prop("checked")) {
            $("#tbPenaltyId").val("-1");
            $("#ddlPenalties").val("-1");
            $("#ddlPenalties").prop("disabled", true);
            $("#Irrevocable").val("1");
        }
        else {
            $("#tbPenaltyId").val("0");
            $("#ddlPenalties").val("0");
            $("#ddlPenalties").prop("disabled", false);
            $("#Irrevocable").val("0");
        }
    });
    $("#cbIrrevocable").trigger("change");
    //
    $("#cbProlongation").on("change", function () {
        if ($(this).prop("checked")) {
            $("#tbExnMethodId").prop("disabled", false);
            $("#ddlExnMethods").prop("disabled", false);
            $("#Prolongation").val("1");
        }
        else {
            $("#tbExnMethodId").val(null);
            $("#tbExnMethodId").prop("disabled", true);
            $("#ddlExnMethods").val("");
            $("#ddlExnMethods").prop("disabled", true);
            $("#Prolongation").val("0");
        }
    });
    $("#cbProlongation").trigger("change");
    
    //
    // kendo
    $("#tabstrip").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    });
    $("#tbMinAmount").kendoNumericTextBox({
        decimals: 2,
        min: 1.00,
        max: 1000000.00,
        step: 100.00
    });
    $("#tbMaxAmount").kendoNumericTextBox({
        decimals: 2,
        min: 100.00,
        max: 1000000000.00,
        step: 100.00
    });
    $("#tbMinAmntReplenishment").kendoNumericTextBox({
        decimals: 2,
        min: 1.00,
        max: 1000000.00,
        step: 10.00
    });
    $("#cbReplenishable").on("change", function () {
        var numerictextbox = $("#tbMinAmntReplenishment").data("kendoNumericTextBox");
        if ($(this).prop("checked")) {
            numerictextbox.enable();
            if (numerictextbox.value() == null) {
                numerictextbox.value(100);
            }
        }
        else {
            numerictextbox.enable(false);
            numerictextbox.value(null);
        }
    });
    $("#cbReplenishable").trigger("change");
    //
    $("#tbFine").kendoNumericTextBox({
        spinners: true,
        decimals: 2,
        min: 0,
        max: 100,
        step: 0.01
    });

    $("#rbTermFixed").on("change", function () {
        if ($(this).prop("checked")) {
            //
            $("#tbTermMaxMonths").val(null);
            $("#tbTermMaxMonths").prop("disabled", true);
            //
            $("#tbTermMaxDays").val(null);
            $("#tbTermMaxDays").prop("disabled", true);
            //
            $("#TermType").val("1");
        }
    });

    $("#rbTermRange").on("change", function () {
        if ($(this).prop("checked")) {
            //
            $("#tbTermMaxMonths").prop("disabled", false);
            //if ($("#tbPeriodId").val() == "1") {
            //    $("#tbTermMinMonths").val("1");
            //    $("#tbTermMaxMonths").val("12");
            //}
            //else {
            //    $("#tbTermMinMonths").val("13");
            //    $("#tbTermMaxMonths").val("36");
            //}
            //
            $("#tbTermMaxDays").prop("disabled", false);
            $("#tbTermMaxDays").val("0");
            //
            $("#TermType").val("2");
        }
    });

    //
    $("#rbTermFixed").trigger("change");

    // База нарахування відсотків для депозитів є константою (Факт/Факт)
    // блокуємо можливість змін даного параметру (погоджено з Мудрик Олександрою)
    $("#ddlBaseY").prop("disabled", true);

    // блокуємо можливість змін Періодичності нарахування выдсотків
    $("#ddlClcIntFrqs").prop("disabled", true);

    //
    var tabStrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
    if ($("#tbViddId").val() == ""){
        tabStrip.enable(tabStrip.tabGroup.children().eq(3), false);
    }
    else {
        var dataSource = new kendo.data.DataSource({
            data: dsRates,
            schema: {
                model: {
                    id: "ID",
                    // configure the fields of the object
                    fields: {
                        // the "title" field is mapped to the text of the "title" XML element
                        RateId: { type: "number", editable: false },
                        TermMonths: { type: "number", editable: false },
                        TermDays: { type: "number", editable: false },
                        TermIncl: { type: "number", editable: false },
                        Amnt: { type: "number", editable: false },
                        AmntIncl: { type: "number", editable: false },
                        Rate: { type: "number", editable: false },
                        RateMax: { type: "number", editable: false }
                    }
                }
            }
        });

        $("#gridRates").kendoGrid({
            dataSource: dataSource,
            columns: [
                 {
                     field: "RateId", hidden: true
                 },
                {
                    field: "TermMonths", title: "Гран.<br>термін<br>(в міс.)", width: "15%",
                    headerAttributes: { style: "text-align: center; vertical-align: middle;" },
                    attributes: { style: "text-align: right; vertical-align: middle;" }
                },
                {
                    field: "TermDays", title: "Гран.<br>термін<br>(в днях)", width: "15%",
                    headerAttributes: { style: "text-align: center;" },
                    attributes: { style: "text-align: right; vertical-align: middle;" }
                },
                {
                    field: "TermIncl", title: "Гран.термін<br>входить в<br>діапазон(=1)", width: "15%",
                    headerAttributes: { style: "text-align: center;" }/*,
                    editor: pnlDropDownEditor, template: "#=PenaltyType.PenaltyTypeName#"*/
                },
                {
                    field: "Amnt", title: "Гран.<br>сума<br>(в коп.)", width: "15%",
                    headerAttributes: { style: "text-align: center;  vertical-align: middle;" },
                    attributes: { style: "text-align: right;" }
                },
                {
                    field: "AmntIncl", title: "Гран.сума<br>входить в<br>діапазон(=1)", width: "15%",
                    headerAttributes: { style: "text-align: center;  vertical-align: middle;" },
                    attributes: { style: "text-align: right;" }
                },
                {
                    field: "Rate", title: "%-ва<br>ставка", width: "10%",
                    headerAttributes: { style: "text-align: center;  vertical-align: middle;" },
                    attributes: { style: "text-align: right;" }
                },
                {
                    field: "RateMax", title: "Макс.<br>допустима<br>%-ва ставка",// width: "110px",
                    headerAttributes: { style: "text-align: center;  vertical-align: middle;" },
                    attributes: { style: "text-align: right;" }
                }
            ],
            //toolbar: [
            //    { name: "create", text: "Додати запис" },

            //],
            editable: false,
            scrollable: true,
            selectable: true,
            resizable: false,
            pageable: false
        });
        tabStrip.enable(tabStrip.tabGroup.children().eq(3), true);
    }

    // Наявні депозитіні договори
    if ($("#HasAgrm").val() == "1") {
        $("#rbTermFixed").prop("disabled", true);
        $("#rbTermRange").prop("disabled", true);
        $("#cbComproc").prop("disabled", true);
        $("#cbProlongation").prop("disabled", true);
    }

    // hide button if form open as dialog
    if (window.location != window.parent.location) {
        $("#btnExit").hide();
    }

});

function closeWindow() {
    if (confirm("Закрити поточну вкладку?")) {
        window.open('', '_parent', '');
        window.close();
    }
}

function validateControls() {
    var errMsg = "";
    var maxMonths = 0;
    var minMonths = 0;
    var maxDays = 0;
    var minDays = 0;

    if ($("#tbTypeId").val() == "") {
        errMsg += "Не вказано тип депозиту<br>";
    }
    if ($("#tbCurrencyId").val() == "") {
        errMsg += "Не вказано валюту депозиту<br>";
    }
    if ($("#tbPeriodId").val() == "") {
        errMsg += "Не вказано строковість депозиту<br>";
    }
    if ($("#tbNbsDepNum").val() == "") {
        errMsg += "Не вказано бал. рахунок депозиту<br>";
    }

    minMonths = ( $("#tbTermMinMonths").val() == "" ? 0 : parseInt($("#tbTermMinMonths").val(), 10) );
    maxMonths = ($("#tbTermMaxMonths").val() == "" ? 0 : parseInt($("#tbTermMaxMonths").val(), 10));

    minDays = ($("#tbTermMinDays").val() == "" ? 0 : parseInt($("#tbTermMinDays").val(), 10));
    maxDays = ($("#tbTermMaxDays").val() == "" ? 0 : parseInt($("#tbTermMaxDays").val(), 10));

    if ($("#rbTermRange").prop("checked")) {
        
        if ( (minMonths + maxMonths) > 0 ) {
            // check months value
            if (minMonths >= maxMonths) {
                errMsg += "Max. к-ть місяців має бути більшою за Min. к-ть місяців<br>";
            }
        }

        if ((minDays + maxDays) > 0) {
            // check days value
            if (minDays >= maxDays) {
                errMsg += "Max. к-ть днів має бути більшою за Min. к-ть днів<br>";
            }
        }

        if ((minMonths + maxMonths + minDays + maxDays) == 0) {
            errMsg += "Не вказано граничні терміни депозиту<br>";
        }
    }

    if ($("#tbOperationCode").val() == "") {
        errMsg += "Не вказано код операції нарахування відсотків<br>";
    }
    if ($("#tbFrequencyId").val() == "") {
        errMsg += "Не вказано періодичність сплати відсотків<br>";
    }
    if ($("#tbPenaltyId").val() == "") {
        errMsg += "Не вказано умови дострокового вилучення депозиту<br>";
    }
    //if ($("#tbTemplateId").val() == "") {
    //    errMsg += "Не вказано шаблон для друку договору<br>";
    //}
    if (errMsg == "") {
        return true;
    }
    else {
        bars.ui.error({ text: errMsg });
        return false;
    }
}

function getNbsDep() {

}

// function AfterPageLoad() {
//     document.getElementById("tbTypeId").attachEvent("onkeydown", doAlpha);
//     document.getElementById("tbTypeId").attachEvent("onkeydown", doNum);
//     document.getElementById("tbCurrencyId").attachEvent("onkeydown", doNum);
// 
//     document.getElementById("tbTemplateId").readOnly = true;
//     document.getElementById("tbTemplateId").style.color = "gray";
// }

// // Ознака резидентності клієнта
// function EnableResident()
// {
//     if (event.srcElement.checked) {
//         document.getElementById('resid_checked').value = "1";
//         document.getElementById('textClientCode').value = "";
//         document.getElementById('textClientCode').readOnly = false;
//         document.getElementById('textClientCode').style.backgroundColor = "";
//         document.getElementById('textClientCode').style.color = "";
//         document.getElementById('listClientCodeType').disabled = false;
//     }
//     else {
//         document.getElementById('resid_checked').value = "0";
//         document.getElementById('textClientCode').value = "000000000";
//         document.getElementById('textClientCode').readOnly = true;
//         // document.getElementById('textClientCode').className = "MyDisabled";
//         document.getElementById('textClientCode').style.backgroundColor = "#E8E8E8";
//         document.getElementById('textClientCode').style.color = "#B5B5B5";
//         document.getElementById('listClientCodeType').disabled = true;
//     }
// }