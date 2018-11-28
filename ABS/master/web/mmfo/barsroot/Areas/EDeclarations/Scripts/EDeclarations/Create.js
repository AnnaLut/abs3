/// *** GLOBALS
/// <reference path="~/lib/jquery/dist/jquery.js" />
///***

$(document).ready(function () {
    $("#title").html("Електронна Декларація");

    $body = $("form");

    $(document).on({
        ajaxStart: function () { $body.addClass("loading"); },
        ajaxStop: function () { $body.removeClass("loading"); }
    });

    var validator = $("#eDeclFrom").kendoValidator().data("kendoValidator"),
        status = $(".status");
    $("#eDeclFrom").submit(function (event) {
        event.preventDefault();
        if (validator.validate()) {
            window.parent.$('.k-overlay').css('z-index', '15002');
            var list = $('#eDeclFrom').serializeArray();
            if (!validateDateFrom()) {
                window.parent.$('.k-overlay').css('z-index', '10002');
                bars.ui.error({
                    text: 'Період декларації не може бути більше одного року. Перевірте початкову та кінцеву дату!'
                })
                return;
            }
            else if ($("#Inn").val() === "0000000000") {
                window.parent.$('.k-overlay').css('z-index', '10002');
                bars.ui.error({
                    text: 'ІПН не може містити тільки нулі. Якщо у клієнта немає ІПН здійснюйте пошук по ПІБ!'
                })
                return;
            }
            else if (checkIfDateNotExist($("#DateFrom").val()) || checkIfDateNotExist($("#DateTo").val())) {
                window.parent.$('.k-overlay').css('z-index', '10002');
                bars.ui.error({
                    text: 'Вказана дата не існує. Перевірте початкову та кінцеву дату!'
                })
                return;
            };

            var obj = {};
            for (var i = 0; i < list.length; ++i) {
                var namesArr = ['DateOfBirth', 'DateFrom', 'DateTo'];
                for (var j = 0; j < namesArr.length; ++j){
                    if (namesArr[j] === list[i].name) {
                        var arr = list[i].value.split('.');
                        list[i].value = arr[2] + '-' + arr[1] + '-' + arr[0];
                    }
                }
                if (list[i].name === 'PersonDocSerial')
                    obj[list[i].name] = list[i].value.toUpperCase();
                else
                    obj[list[i].name] = list[i].value;
            }
            var data = JSON.stringify(obj);
            window.parent.createResultWindow(data); 
            return false;
        }
    });
    var today = new Date();
    var maxDate = today.setDate(today.getDate() + 0);
    $("#DateOfBirth").kendoDatePicker(
    );

    $("#PersonDocType").kendoDropDownList({
    });

    $("#Inn").kendoMaskedTextBox({
        mask: "0000000000"
        //,promptChar: " "
    });
    $("#PersonDocNumber").kendoMaskedTextBox();
    $("#PersonDocSerial").kendoMaskedTextBox();

    showComponentsIfHaveInn();

    $("#CheckHaveInn").change(function () {
        if ($(this).is(':checked')) {
            showComponentsIfHaveInn();
        }
        else {
            showComponentsIfDoNotHaveInn();
        }
    });

    function showComponentsIfHaveInn() {
        $("#form-for-inn").css("display", "block");
        $("#form-for-dateOfBirth").css("display", "none");
        $("#form-for-docType").css("display", "none");
        $("#form-for-serial").css("display", "none");
        $("#form-for-docNumber").css("display", "none");

        $("#Inn").attr("placeholder", "Введіть ІПН (10 цифр)");
        $("#DateFrom").attr("placeholder", "дд.мм.рррр");
        $("#DateOfBirth").attr("placeholder", "");
        $("#PersonDocSerial").attr("placeholder", "");
        $("#PersonDocNumber").attr("placeholder", "");

        showPlaceholders();

        $("#Inn").prop('disabled', false);
        $("#Inn").removeClass("k-invalid");
        $("#Inn_validationMessage").empty();

        $("#Inn").prop("required", true);
        $("#DateOfBirth").prop("required", false);
        $("#PersonDocSerial").prop("required", false);
        $("#PersonDocNumber").prop("required", false);
        $("#PersonDocType").prop("required", false);

        $("#DateFrom").removeClass("k-invalid");
        $("#DateFrom_validationMessage").empty();
        $("#DateFrom").prop("required", true);

        $("#DateTo").removeClass("k-invalid");
        $("#DateTo_validationMessage").empty();
        $("#DateTo").prop("required", true);

        $("#DateOfBirth").val("");
        $("#DateOfBirth").prop('disabled', true);
        $("#DateOfBirth").removeClass("k-invalid");
        $("#DateOfBirth_validationMessage").empty();

        $("#PersonDocType").val("");
        $("#PersonDocType").data("kendoDropDownList").enable(false);
        $("#PersonDocType").kendoDropDownList({ optionLabel: " " });
        $("#PersonDocType").removeClass("k-invalid");
        $("#PersonDocType_validationMessage").empty();

        $("#PersonDocSerial").val("");
        $("#PersonDocSerial").prop('disabled', true);
        $("#PersonDocSerial").removeClass("k-invalid");
        $("#PersonDocSerial_validationMessage").empty();

        $("#PersonDocNumber").val("");
        $("#PersonDocNumber").prop('disabled', true);
        $("#PersonDocNumber").removeClass("k-invalid");
        $("#PersonDocNumber_validationMessage").empty();
    }

    function showComponentsIfDoNotHaveInn() {
        $("#form-for-inn").css("display", "none");
        $("#form-for-dateOfBirth").css("display", "block");
        $("#form-for-docType").css("display", "block");
        $("#form-for-serial").css("display", "block");
        $("#form-for-docNumber").css("display", "block");

        $("#Inn").attr("placeholder", "");
        $("#DateOfBirth").attr("placeholder", "дд.мм.рррр");
        $("#PersonDocSerial").attr("placeholder", "Серія документу");
        $("#PersonDocNumber").attr("placeholder", "Номер документу");
        $("#DateFrom").attr("placeholder", "дд.мм.рррр");
        showPlaceholders();

        $("#Inn").val("");
        $("#Inn").prop('disabled', true);
        $("#Inn").prop("required", false);
        $("#Inn").removeClass("k-invalid");
        $("#Inn_validationMessage").empty();

        $("#DateOfBirth").prop("required", true);
        $("#PersonDocSerial").prop("required", true);
        $("#PersonDocNumber").prop("required", true);
        $("#PersonDocType").prop("required", true);
        $("#DateFrom").prop("required", true);
        $("#DateTo").prop("required", true);

        $("#DateFrom").removeClass("k-invalid");
        $("#DateFrom_validationMessage").empty();
        $("#DateFrom").prop("required", true);

        $("#DateTo").removeClass("k-invalid");
        $("#DateTo_validationMessage").empty();
        $("#DateTo").prop("required", true);

        $("#DateOfBirth").prop('disabled', false);
        $("#DateOfBirth").kendoDatePicker(
            {
                format: "dd.MM.yyyy",
                max: new Date(maxDate)
            }
        ).on("focus", onDatePickerFocus);

        $("#PersonDocType").prop('disabled', false);
        $("#PersonDocType").kendoDropDownList({
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/api/edeclarations/edeclarations/PersonDocTypes"),
                        dataType: "json"
                    }
                },
                schema: {
                    data: "Data"
                }
            },
            dataTextField: "Name",
            dataValueField: "Id",
            optionLabel: "Оберіть тип документу...",
            change: personDocTypeChange
        });

        $("#PersonDocSerial").prop('disabled', false);
        $("#PersonDocNumber").prop('disabled', false);
    }

    function showPlaceholders() {
        if (!$.support.placeholder) {
            $("[placeholder]").focus(function () {
                if ($(this).val() == $(this).attr("placeholder")) $(this).val("");
            }).blur(function () {
                if ($(this).val() == "") $(this).val($(this).attr("placeholder"));
            }).blur();
        }
    }

    function getpersonDocTypesData() {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/edeclarations/edeclarations/PersonDocTypes"),
            success: function (data) {
                return data;
            }
        });
    }

    function validateDateFrom() {
        var from = $("#DateFrom").val();
        var to = $("#DateTo").val();
        var fromArr = from.split('.');
        var toArr = to.split('.');
        from = fromArr[2] + '/' + fromArr[1] + '/' + fromArr[0];
        to = toArr[2] + '/' + toArr[1] + '/' + toArr[0];
        var dateFrom = new Date(to);
        dateFrom.setFullYear(dateFrom.getFullYear() - 1);
        dateFrom.setDate(dateFrom.getDate() + 1);
        var tmp = new Date(from);
        var result1 = tmp >= dateFrom && tmp <= new Date(to);
        var result2 = new Date(to) <= new Date();
        return result1 && result2;
    }

    function checkIfDateNotExist(date) {
        var dateArr = date.split('.');
        var day = dateArr[0];
        var month = dateArr[1];
        var year = dateArr[2];

        if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
            return true;
        } else if (month == 2) {
            var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
            if (day > 29 || (day == 29 && !isleap))
                return true;
        }
    }

    function personDocTypeChange(e) {
        var value = this.value();
        $("#PersonDocNumber").data("kendoMaskedTextBox").value(null);
        $("#PersonDocSerial").data("kendoMaskedTextBox").value(null);
        var serial = $('#form-for-serial');
        // 1, 5, 7, 15
        var numberPattern = '';
        var numberMaskObj = { mask: '' };
        var serialPattern = '';
        var serialMaskObj = { mask: '' };
        switch (value) {
            /// Паспорт громадянина України
            case "1":
                numberPattern = '\\d{6}';
                numberMaskObj.mask = '000000';
                serialPattern = '[а-яА-ЯёЁЇїІіЄєҐґ]{2}';
                serialMaskObj.mask = '&&';
                serial.css('display', '');
                $("#PersonDocSerial").prop("required", true);
                break;
            /// Паспорт ID-картка
            case '7':
                numberPattern = '\\d{3} \\d{3} \\d{3}';
                numberMaskObj.mask = '000 000 000';
                serialPattern = '';
                serialMaskObj.mask = '';
                serial.css('display', 'none');
                $("#PersonDocSerial").prop("required", false);
                break;
            /// 5  - Тимчасова посвідка
            case '5':
                numberPattern = '[^=]*';//'(\\S ){0,3}\\d{10,12}';  ((\\S ){0}|(\\S{2} {1}))
                numberMaskObj.mask = '';
                serialPattern = '^.{0,30}$';
                serialMaskObj.mask = '';
                serial.css('display', '');
                $("#PersonDocSerial").prop("required", true);
                break;
            /// 15 - Тимчасове посвідчення особи
            case '15':
                numberPattern = '[^=]*';
                numberMaskObj.mask = '';
                serialPattern = '^.{0,30}$';
                serialMaskObj.mask = '';
                serial.css('display', '');
                $("#PersonDocSerial").prop("required", true);
                break;
            /// 
            default:
                numberPattern = '[^=]*';
                numberMaskObj = { mask: '' };
                serialPattern = '^.{0,30}$';
                serialMaskObj.mask = '';
                serial.css('display', '');
                $("#PersonDocSerial").prop("required", true);
                break;
        }

        $("#PersonDocSerial").attr("pattern", serialPattern);
        $("#PersonDocSerial").data("kendoMaskedTextBox").setOptions(serialMaskObj);
        $("#PersonDocSerial").attr('maxlength', 30);
        $("#PersonDocNumber").attr("pattern", numberPattern);
        $("#PersonDocNumber").data("kendoMaskedTextBox").setOptions(numberMaskObj);
        $("#PersonDocNumber").attr('maxlength', 30);
    }

    function onDatePickerFocus(e) {
        $("#" + e.target.id).data("kendoDatePicker").open();
        var from = $("#DateFrom").data("kendoDatePicker");
        var to = $("#DateTo").data("kendoDatePicker");
        var date = new Date(to.value() - 1);
        date.setFullYear(date.getFullYear() - 1);
        date.setDate(date.getDate() + 1);
        from.min(date);
    }

    function startChange() {
        var startDate = start.value(),
            endDate = end.value();

        if (startDate) {
            startDate = new Date(startDate);
            startDate.setDate(startDate.getDate());
            end.min(startDate);
        } else if (endDate) {
            start.max(new Date(endDate));
        } else {
            endDate = new Date();
            start.max(endDate);
            end.min(endDate);
        }
    }

    function endChange() {
        var endDate = end.value(),
            startDate = start.value();

        if (endDate) {
            endDate = new Date(endDate);
            endDate.setDate(endDate.getDate());
            start.max(endDate);
        } else if (startDate) {
            end.min(new Date(startDate));
        } else {
            endDate = new Date();
            start.max(endDate);
            end.min(endDate);
        }
    }

    var start = $("#DateFrom").kendoDatePicker({
        change: startChange,
        format: "dd.MM.yyyy"
    }).on("focus", onDatePickerFocus)
        .data("kendoDatePicker");

    var end = $("#DateTo").kendoDatePicker({
        change: endChange,
        max: new Date(maxDate),
        value: today,
        format: "dd.MM.yyyy"
    }).on("focus", onDatePickerFocus)
        .data("kendoDatePicker");
    //alert(end.value());
    start.max(end.value());
    //start.min(end.value() - 1);
    end.min(start.value());

});