$(document).ready(function () {
    var debitAccount = $("#DebitAccount").val();
    var returnAccount = $("#ReturnAccount").val();
    //var isProlongation = $("#IsProlongation").val();
    //var applyBonusProlongation = $("#ApplyBonusProlongation").val();
    //var replenishmentTranche = $("#IsReplenishmentTranche").val();
    //var frequencyPayment = $("#FrequencyPayment").val();
    //var isIndividualRate = $("#IsIndividualRate").val();
    //var isCapitalization = $("#IsCapitalization").val();
    //var customer = $("#CustomerId").val();
    //var currency = $("#CurrencyId").val();
    var interestRateCapitalization = $("#InterestRateCapitalization").val();
    var modelStartDate = $("#StartDate").val();

    $('.kendoDate').kendoDatePicker({
        format: 'dd.MM.yyyy',
    });

    $("#DebitAcc").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: debitAccount,
        dataSource: [{
            text: debitAccount,
            value: debitAccount
        }]
    });

    var model = {
        customerId: $("#CustomerId").val(), //customer,
        currencyId: $("#CurrencyId").val() //currency
    };

    $.ajax({
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        data: model,
        url: bars.config.urlContent("/api/gda/gda/getdebitacc"),
        success: function (e) {
            if (!!e.Data && e.Data.length !== 0) {
                for (var i = 0; i < e.Data.length; i++) {
                    if (e.Data[i].Nls == debitAccount) {
                        $('#DebitAccOstc').data('kendoNumericTextBox').value(e.Data[i].Ostc);
                        break;
                    }
                }
            }
        }
    });

    $.ajax({
        type: "GET",
        contentType: "application/json",
        dataType: "json",
        data: {
            startDate: modelStartDate.substring(0, 10),
            currencyId: $("#CurrencyId").val() //currency
        },
        url: bars.config.urlContent("/api/gda/gda/getnumberprolongationlist"),
        success: function (e) {
            if (!!e.Data && e.Data.length !== 0) {
                for (var i = 0; i < e.Data.length; i++) {
                    if (e.Data[i].NUMBERPROLONGATION == $("#NumberProlongation").val()) { //numberProlongation) {
                        $('#applyprologField').val(e.Data[i].NAME_);
                        break;
                    }
                }
            }
        }
    });

    $("#DebitAccReplacement").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: returnAccount,
        dataSource: [{
            text: returnAccount,
            value: returnAccount
        }]
    });

    $("#AutoProlongation").kendoDropDownList({
        //optionLabel: " ",
        dataTextField: "text",
        dataValueField: "value",
        value: $("#IsProlongation").val(),
        dataSource: [{
            text: "Так",
            value: 1
        }, {
            text: "Ні",
            value: 0
        }]
    });

    if ($("#IsProlongation").val() == '0') {
        $('#NumberProlongation').val('');
        $('#applyprologField').val('');
    }

    $("#BonusProlongation").kendoDropDownList({
        optionLabel: "Оберіть значення",
        value: $("#ApplyBonusProlongation").val(), //applyBonusProlongation,
        dataTextField: "item_name",
        dataValueField: "item_id",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/gda/gda/getprolongatiotranchelist"),
                }
            },
            schema: {
                data: "Data",
                total: "Total"
            }
        }
    });

    $("#ReplenishmentTranche").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        value: $("#IsReplenishmentTranche").val(), //replenishmentTranche,
        dataSource: [{
            text: "Так",
            value: 1
        }, {
            text: "Ні",
            value: 0
        }]
    });

    $("#FrequencyPaymentDrp").kendoDropDownList({
        dataTextField: "ITEM_NAME",
        dataValueField: "ITEM_ID",
        value: $("#FrequencyPayment").val(), //frequencyPayment,
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/gda/gda/getpaymenttermtranche")
                }
            },
            schema: {
                data: "Data",
                total: "Total"
            }
        }
    });

    $("#IndividualRate").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        value: $("#IsIndividualRate").val(), //isIndividualRate,
        dataSource: [{
            text: "Так",
            value: 1
        }, {
            text: "Ні",
            value: 0
        }]
    });

    $("#IsCapitalizationSelect").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        value: $("#IsCapitalization").val(), // isCapitalization,
        dataSource: [{
            text: "Так",
            value: 1
        }, {
            text: "Ні",
            value: 0
        }]
    });

    $("#InterestRateCapitalizationSelect").kendoDropDownList({
        dataTextField: "item_name",
        dataValueField: "item_id",
        optionLabel: {
            item_name: "Оберіть значення",
            item_id: null
        },
        value: interestRateCapitalization,
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/gda/gda/GetCapitalizationTrancheList"),
                }
            },
            schema: {
                data: "Data",
                total: "Total"
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
            url: bars.config.urlContent("/api/gda/gda/Autorize?processId=") + processId, // + "&error=" + error,
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

function block() {
    var processId = $("#ProcessId").val();
    $("#ConfirmPopup").append("<div id='createPopup'></div>");
    var createWindow = $("#createPopup").kendoWindow({
        width: "600px",
        height: "315px",
        title: "Підтвердження блокування",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
        },
        content: bars.config.urlContent("/gda/gdaBack/ConfirmBlock?processId=") + processId
    }).data("kendoWindow");

    createWindow.center().open();
}

function unblock() {
    var processId = $("#ProcessId").val();
    $("#ConfirmPopup").append("<div id='createPopup'></div>");
    var createWindow = $("#createPopup").kendoWindow({
        width: "600px",
        height: "280px",
        title: "Підтвердження розблокування",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
        },
        content: bars.config.urlContent("/gda/gdaBack/ConfirmUnblock?processId=") + processId
    }).data("kendoWindow");

    createWindow.center().open();
}

function cancel() {
    window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
}

function showDetailsPercent() {
    $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        url: bars.config.urlContent("/api/gda/gda/countplacementTrancheBack?processId=") + $("#ProcessId").val(),
        success: function (e) {
            var IndividualInterestRate = e.IndividualInterestRate != null ? e.IndividualInterestRate : "0";
            var InterestRateBonus = e.InterestRateBonus != null ? e.InterestRateBonus : "0";
            var InterestRateGeneral = e.InterestRateGeneral != null ? e.InterestRateGeneral : "0";
            var InterestRatePayment = e.InterestRatePayment != null ? e.InterestRatePayment : "0";
            var InterestRateProlongation = e.InterestRateProlongation != null ? e.InterestRateProlongation : "0";
            var InterestRateReplenishment = e.InterestRateReplenishment != null ? e.InterestRateReplenishment : "0";
            var InterestRateCapitalization = e.InterestRateCapitalization != null ? e.InterestRateCapitalization : "0";
            var InterestRateProlongationBonus = e.InterestRateProlongationBonus != null ? e.InterestRateProlongationBonus : "0";

            //var details =
            //    "           1.   Індивідуальна ставка    = " + IndividualInterestRate + 
            //    "<br><br>   2.   Бонусна ставка          = " + InterestRateBonus +
            //    "<br><br>   3.   Базова ставка           = " + InterestRateGeneral +
            //    "<br><br>   4.   Виплата по депозиту     = " + InterestRatePayment +
            //    "<br><br>   5.   Пролонгація             = " + InterestRateProlongation +
            //    "<br><br>   6.   Ставка при поповненні   = " + InterestRateReplenishment +
            //    "<br><br>   7.   Капіталізація           = " + InterestRateCapitalization;

            var details =
                "<ul class='list-group'>" +
                "<li id='IndIntRate' class='list-group-item" + (IndividualInterestRate > 0 || IndividualInterestRate < 0 ? " list-group-item-success' " : "'") +  ">        1.   Індивідуальна ставка    = " + +IndividualInterestRate +
                "</li><li id='IntRateBon' class='list-group-item" + (InterestRateBonus > 0 || InterestRateBonus < 0 ? " list-group-item-success' " : "'") +  ">   2.   Бонусна ставка          = " + +InterestRateBonus +
                "</li><li id='IntRateGen' class='list-group-item" + (InterestRateGeneral > 0 || InterestRateGeneral < 0 ? " list-group-item-success' " : "'") +  ">   3.   Базова ставка           = " + +InterestRateGeneral +
                "</li><li id='IntRatePay'class='list-group-item" + (InterestRatePayment > 0 || InterestRatePayment < 0 ? " list-group-item-success' " : "'") +  ">   4.   Виплата по депозиту     = " + +InterestRatePayment +
                "</li><li id='IntRateProl'class='list-group-item" + (InterestRateProlongation > 0 || InterestRateProlongation < 0 ? " list-group-item-warning' " : "'") +  ">   5.   Пролонгація             = " + +InterestRateProlongation +
                "</li><li id='IntRateRepl'class='list-group-item" + (InterestRateReplenishment > 0 || InterestRateReplenishment < 0 ? " list-group-item-success' " : "'") +  ">   6.   Ставка при поповненні   = " + +InterestRateReplenishment +
                "</li><li id='IntRateCap'class='list-group-item" + (InterestRateCapitalization > 0 || InterestRateCapitalization < 0 ? " list-group-item-success' " : "'") + ">   7.   Капіталізація           = " + +InterestRateCapitalization +
                "</li><li id='IntRateProlBon'class='list-group-item" + (InterestRateProlongationBonus > 0 || InterestRateProlongationBonus < 0 ? " list-group-item-success' " : "'") + ">   8.   Бонусна % ставка при пролонгації           = " + +InterestRateProlongationBonus +
                "</li ></ul>";

            bars.ui.alert({ text: details, title: 'Деталі', width: '256px', height: '357px', winType: '' });
        }
    });

}

//Функция для отображения окна Деталей автопролонгации
function getProlongationDetails() {
    if ($('#AutoProlongation').data("kendoDropDownList").value() === '1') {
        var expiryDate = '';
        var interestRate = '';
        var prolongationNum = '';
        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: bars.config.urlContent("/api/gda/gda/getprolongationdetails?processId=") + $("#ProcessId").val(),
            success: function (result) {
                expiryDate = result.ExpiryDate;
                interestRate = result.InterestRate;
                prolongationNum = result.ProlongationNumber;

                if (expiryDate == '' || expiryDate == null) {
                    bars.ui.alert({ text: "Дані відсутні" });
                    return;
                } else {
                    var details =
                        "<ul class='list-group'>" +
                        "<li class='list-group-item'>        1.   Закінчення пролонгації: " + kendo.toString(kendo.parseDate(expiryDate), 'dd.MM.yyyy') +
                        "</li><li class='list-group-item'>   2.   Бонусна ставка          = " + +interestRate +
                        "</li><li class='list-group-item'>   3.   Порядковий номер пролонгації           = " + +prolongationNum + "</ul>";
                }

                bars.ui.alert({ text: details, title: 'Деталі автопролонгації', width: '290px', height: '150px', winType: '' });
            }
        });        
    } else {
        bars.ui.alert({ text: "Автопролонгація не вибрана" });
        return;
    }

}
