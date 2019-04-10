$(document).ready(function () {
    var debitAccount = $("#DebitAccount").val();
    var customer = $("#CustomerId").val();
    var currency = $("#CurrencyId").val();

    $('.kendoDate').kendoDatePicker({
        format: 'dd.MM.yyyy',
    });

    $("#DebitAccEditReplenishment").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: debitAccount,
        dataSource: [{
            text: debitAccount,
            value: debitAccount
        }]
    });

    $.ajax({
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        data: {
            customerId: customer,
            currencyId: currency
        },
        url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
        success: function (e) {
            if (!!e.Data && e.Data.length !== 0) {
                for (var i = 0; i < e.Data.length; i++) {
                    if (e.Data[i].Nls == debitAccount) {
                        $('#replenishmentOstc').data('kendoNumericTextBox').value(e.Data[i].Ostc);
                        break;
                    }
                }
            }
        }
    });

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
        content: bars.config.urlContent("/gda/gdaBack/ConfirmReject?processId=") + processId
    }).data("kendoWindow");

    createWindow.center().open();
}

function autorize() {
    var processId = $("#ProcessId").val();
    bars.ui.confirm({ text: 'Ви дійсно хочете авторизувати?' }, function () {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/gda/gda/Autorize?processId=") + processId,
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