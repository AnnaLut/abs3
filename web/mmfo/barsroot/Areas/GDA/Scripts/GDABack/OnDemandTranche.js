$(document).ready(function () {
    var debitAccount = $("#DebitAccount").val();
    var returnAccount = $("#ReturnAccount").val();
    var isIndividualRate = $("#IsIndividualRate").val();
    var frequencyPaymentId = $("#FrequencyPayment").val();
    var calculationTypeId = $("#CalculationType").val();
    var customerId = $("#CustomerId").val();
    var currencyId = $("#CurrencyId").val();

    $('.kendoDate').kendoDatePicker({
        format: 'dd.MM.yyyy',
    });

    $("#DebitAccDepositDemand").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: debitAccount,
        dataSource: [{
            text: debitAccount,
            value: debitAccount
        }]
    });

    $("#DebitAccReturnDepositDemand").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: returnAccount,
        dataSource: [{
            text: returnAccount,
            value: returnAccount
        }]
    });

    $("#IndividualRate").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        value: isIndividualRate,
        dataSource: [{
            text: "Так",
            value: 1
        }, {
            text: "Ні",
            value: 0
        }]
    });

    //----Варіанти виплати %
    var dataSourceFrequency = [{
        text: "Щомісячно",
        value: 1
    }, {
        text: "Щоквартально",
        value: 2
    }];

    for (var i = 0; i < dataSourceFrequency.length; i++) {
        if (dataSourceFrequency[i].value == frequencyPaymentId) {
            $('#FrequencyPaymentSelect').val(dataSourceFrequency[i].text);
            break;
        }
    } //------------------

    $("#editCalculationTypeDropDownList").kendoDropDownList({
        dataTextField: "item_name",
        dataValueField: "item_id",
        value: calculationTypeId,
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/gda/gda/getcalculationtype")
                }
            }
        }
    });

    //$.ajax({
    //    type: "GET",
    //    contentType: "application/json",
    //    dataType: "json",
    //    data: {
    //        customerId: customerId,
    //        currencyId: currencyId
    //    },
    //    url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
    //    success: function (e) {
    //        if (!!e.Data && e.Data.length !== 0) {
    //            for (var i = 0; i < e.Data.length; i++) {
    //                if (e.Data[i].Nls == debitAccount) {
    //                    $('#DebitAccDepositDemandOstc').data('kendoNumericTextBox').value(e.Data[i].Ostc);
    //                    break;
    //                }
    //            }
    //        }
    //    }
    //});

    $.ajax({
        type: "GET",
        contentType: "application/json",
        url: bars.config.urlContent("/api/gda/gda/GetOperatorControllerInfo?processId=") + $("#ProcessId").val(),
        success: function (result) {
            $('#operator').val(result.OperatorFullName);
            $('#operatorDate').val(formatDate(result.OperatorSysTime));
            $('#controller').val(result.ControllerFullName);
            $('#controllerDate').val(formatDate(result.ControllerSysTime));
        }
    });
});

function formatDate(date) {
    if (date === "")
        return "";

    var dateArr = date.split("T");
    var d = dateArr[0].split("-");
    var newdate = [d[2], d[1], d[0]].join('.')
    return newdate;
}

function reject() {
    var processId = $("#ProcessId").val();
    var type = $("#Type").val();
    $("#ConfirmPopup").append("<div id='createPopup'></div>");
    var createWindow = $("#createPopup").kendoWindow({
        width: "600px",
        height: "280px",
        title: "Підтвердження відхилення",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
        },
        content: bars.config.urlContent("/gda/gdaBack/ConfirmRejectOnDemand?processId=") + processId + "&type=" + type,
    }).data("kendoWindow");

    createWindow.center().open();
}

function autorize() {
    var processId = $("#ProcessId").val();
    var type = $("#Type").val();
    bars.ui.confirm({ text: 'Ви дійсно хочете авторизувати?' }, function () {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/gda/gda/AutorizeOnDemand?processId=") + processId + "&type=" + type,
            success: function (result) {
                if (!result || result === "null" || result === "") {
                    window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                    window.parent.bars.ui.success({
                        text: "Операцію виконано успішно!",
                    });
                }
                else {
                    window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                    window.parent.bars.ui.error({
                        text: result,
                    });
                }
            }
        });
    });
}