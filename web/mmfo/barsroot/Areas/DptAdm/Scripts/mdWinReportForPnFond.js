//Маска для поля даты в datePicker 
jQuery(function ($) {
    $("#ReportDate").mask("99/99/9999");
});



//Валидация формы
function reportForPnFondformValidation() {

    var result = true;
    var reportPeriodNumber = document.getElementById("ReportPeriodNumber").value;

    if (reportPeriodNumber === "") {
        addClass(document
            .getElementById("ReportPeriodValidate"),
            "errorStyle");
        document
            .getElementById("ReportPeriodValidate")
            .innerHTML = 'Заповніть будьласка поле "Звiтний перiод/мiс"';
        result = false;

    } else {
        removeClass(document.getElementById("ReportPeriodValidate"), "errorStyle");
        document.getElementById("ReportPeriodValidate").innerHTML = "";
    }



    var reportDateObj = document.getElementById("ReportDate");
    var reportDateArray = document.getElementById("ReportDate").value.split("/"); //date format 'dd/MM/yyyy'
    var reportDate = new Date(reportDateArray[2], parseInt(reportDateArray[1], 10) - 1, reportDateArray[0]);

    if (reportDateObj.value === "") {
        result = false;
        addClass(document.getElementById("ReportDateValidate"), "errorStyle");
        document.getElementById("ReportDateValidate").innerHTML = 'Заповніть поле "Звiтна дата"';
    } else {
        if (checkDate(document.getElementById("ReportDate").value)) {
            removeClass(document.getElementById("ReportDateValidate"), "errorStyle");
            document.getElementById("ReportDateValidate").innerHTML = "";
        } else {
            result = false;
            addClass(document.getElementById("NewDepositStartDateValidate"), "required-star");
            addClass(document.getElementById("ReportDateValidate"), "errorStyle");
            document.getElementById("ReportDateValidate").innerHTML = "Перевірте корректність введеної дати";
        }

    }

    if (!result) {
        return false;
    } else {
        putReportForPnFondFormToDb(
            document.getElementById("ReportPeriodNumber").value,
            document.getElementById("ReportDate").value
        );
        return true;
    }
}

// метод записывает в бд данные формы
function putReportForPnFondFormToDb(reportPeriodNumber, reportDate) {
    var repDate = (changeDateFormat(reportDate)).toISOString();

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/DptAdm/DptAdm/PutReportForPnFondFormToDb"),
        data: {
            repPeriodNum: reportPeriodNumber,
            repDt: repDate
        },
        success: function (data) {
            if (data.message != null) {
                bars.ui.error({
                    text: data.message
                });

            } else {
                bars.ui.success({
                    title: "<b>Формування звiту для ПФ</b>",
                    text: "Формування звіту виконано успішно!"
                });
                window.formReportForPnFond.close();
            }
        }
    });

}

//функція провірки коректності дати
function checkDate(str) {
    var matches = str.match(/(\d{1,2})[- \/](\d{1,2})[- \/](\d{4})/);
    if (!matches) return false;

    // convert pieces to numbers
    // make a date object out of it
    var month = parseInt(matches[2], 10);
    var day = parseInt(matches[1], 10);
    var year = parseInt(matches[3], 10);
    var date = new Date(year, month - 1, day);
    if (!date || !date.getTime()) return false;

    // make sure we didn't have any illegal 
    // month or day values that the date constructor
    // coerced into valid values
    if (date.getMonth() + 1 !== month ||
        date.getFullYear() !== year ||
        date.getDate() !== day) {
        return false;
    }
    return true;
}

// меняет в дате день и месяц местами что бы получилось MM/dd/yyyy
function changeDateFormat(str) {
    var parts = str.split("/");
    var dt = new Date(parseInt(parts[2], 10),
        parseInt(parts[1], 10) - 1,
        parseInt(parts[0], 10));

    return dt;
}