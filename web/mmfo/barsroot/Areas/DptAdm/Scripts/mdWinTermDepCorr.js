
        //Маски для полей дат в datePicker
        jQuery(function ($) {
            $("#NewDepositStartDate").mask("99/99/9999");
            $("#NewDepositEndDate").mask("99/99/9999");

        });

        //Валидация формы

        function formValidation() {
            var result = true;

            var depositNumber = document.getElementById("DepositNumber").value;
            var numberOfProlongation = document.getElementById("ProlongationNumber").value;

            var regEx = new RegExp("^[0-9]*$");

            if (depositNumber === "") {
                addClass(document
                    .getElementById("DepositNumberValidate"),
                    "required-star");
                document
                    .getElementById("DepositNumberValidate")
                    .innerHTML = "Заповніть будьласка номер депозитного вкладу!";
                result = false;

            } else {
                if (regEx.test(depositNumber)) {
                    removeClass(document.getElementById("DepositNumberValidate"), "required-star");
                    document.getElementById("DepositNumberValidate").innerHTML = "";
                } else {
                    addClass(document
                        .getElementById("DepositNumberValidate"),
                        "required-star");
                    document
                        .getElementById("DepositNumberValidate")
                        .innerHTML = "Номер депозитного вкладу має буте цілим невід'ємним числом";
                    result = false;
                }
            }

            if (numberOfProlongation === "") {
                addClass(document
                    .getElementById("ProlongationNumberValidate"),
                    "required-star");
                document
                    .getElementById("ProlongationNumberValidate")
                    .innerHTML = "Будьласка заповніть кількість пролонгацій!";
                result = false;
            } else {
                if (regEx.test(numberOfProlongation)) {
                    removeClass(document.getElementById("ProlongationNumberValidate"), "required-star");
                    document.getElementById("ProlongationNumberValidate").innerHTML = "";
                } else {
                    addClass(document
                        .getElementById("ProlongationNumberValidate"),
                        "required-star");
                    document
                        .getElementById("ProlongationNumberValidate")
                        .innerHTML = "Кількість пролонгацій має бути додатнім та цілим числом";
                    result = false;
                }
            }


            var startDate = document.getElementById("NewDepositStartDate");
            var endDate = document.getElementById("NewDepositEndDate");
            var startDateArray = document
                .getElementById("NewDepositStartDate")
                .value.split("/"); //date format 'dd/MM/yyyy'
            var startDate1 = new Date(startDateArray[2], parseInt(startDateArray[1], 10) - 1, startDateArray[0]);

            var endDateArray = document.getElementById("NewDepositEndDate").value.split("/"); //date format 'dd/MM/yyyy'
            var endDate1 = new Date(endDateArray[2], parseInt(endDateArray[1], 10) - 1, endDateArray[0]);
            var tmpDate = new Date();
            if (startDate.value === "") {
                result = false;
                addClass(document.getElementById("NewDepositStartDateValidate"), "required-star");
                document.getElementById("NewDepositStartDateValidate").innerHTML = "Заповніть поле 'дата початку'";
            } else {
                if (checkDate(document.getElementById("NewDepositStartDate").value)) {
                    removeClass(document.getElementById("NewDepositStartDateValidate"), "required-star");
                    document.getElementById("NewDepositStartDateValidate").innerHTML = "";
                } else {
                    result = false;
                    addClass(document.getElementById("NewDepositStartDateValidate"), "required-star");
                    document.getElementById("NewDepositStartDateValidate").innerHTML = "Перевірте корректність введеної дати";
                }

            }
            if (endDate.value === "") {
                result = false;
                addClass(document.getElementById("NewDepositEndDateValidate"), "required-star");
                document.getElementById("NewDepositEndDateValidate").innerHTML = "Заповніть поле 'дата закінчення'";
            } else {
                if (checkDate(document.getElementById("NewDepositEndDate").value)) {
                    if (endDate1 < startDate1) {
                        result = false;
                        addClass(document
                            .getElementById("NewDepositEndDateValidate"),
                            "required-star");
                        document
                            .getElementById("NewDepositEndDateValidate")
                            .innerHTML = "Дата закінчення має буте більша за дату початку";
                    } else {
                        removeClass(endDate, "required-star");
                        document.getElementById("NewDepositStartDateValidate").innerHTML = "";
                        document.getElementById("NewDepositEndDateValidate").innerHTML = "";
                    }
                } else {
                    result = false;
                    addClass(document.getElementById("NewDepositEndDateValidate"), "required-star");
                    document.getElementById("NewDepositEndDateValidate").innerHTML = "Перевірте корректність введеної дати";
                }


            }

            if (!result) {

                return false;
            } else {
        putFormToDb(
            document.getElementById("DepositNumber").value,
            document.getElementById("DepositStartDate").value,
            document.getElementById("DepositEndDate").value,
            document.getElementById("NewDepositStartDate").value,
            document.getElementById("NewDepositEndDate").value,
            document.getElementById("ProlongationNumber").value
        );
                return true;
            }


        };


        //функція додавання класу до елемента аналог JQuery.addClass()
        function addClass(o, c) {
            var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
            if (re.test(o.className)) return;
            o.className = (o.className + " " + c).replace(/\s+/g, " ").replace(/(^ | $)/g, "");
        }

        //функція віднімання класу від елемента аналог JQuery.removeClass()
        function removeClass(o, c) {
            var re = new RegExp("(^|\\s)" + c + "(\\s|$)", "g");
            o.className = o.className.replace(re, "$1").replace(/\s+/g, " ").replace(/(^ | $)/g, "");
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

// запрос из бд вытягивает дату и записывает в два поля datePicker ("Дата початку:" / "Дата закінчення:")
function getDates(id) {

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/DptAdm/DptAdm/GetDepostiStartAndEndDates"),
        data: { depositId: id },
        success: function(data) {

            if (data.message != null || data.data.length === 0) {
                $("#DepositNumber").data("kendoNumericTextBox").value("");
                $("#DepositStartDate").data("kendoDatePicker").value("");
                $("#DepositEndDate").data("kendoDatePicker").value("");

                bars.ui.error({
                    text: "Данний № Вкладу: незнайдений"
                });

            } else {
                var depositStartDate = kendo.parseDate(data.data[0].DAT_BEGIN, "dd/MM/yyyy");
                var depositEndDate = kendo.parseDate(data.data[0].DAT_END, "dd/MM/yyyy");
                $("#DepositStartDate").data("kendoDatePicker").value(depositStartDate);
                $("#DepositEndDate").data("kendoDatePicker").value(depositEndDate);
            }
        }
    });
}

// Включает поддержку .toISOString() для IE8
if (!Date.prototype.toISOString) {
    (function() {
        function pad(number) {
            var r = String(number);
            if (r.length === 1) {
                r = '0' + r;
            }
            return r;
        }

        Date.prototype.toISOString = function() {
            return this.getUTCFullYear() +
                '-' +
                pad(this.getUTCMonth() + 1) +
                '-' +
                pad(this.getUTCDate()) +
                'T' +
                pad(this.getUTCHours()) +
                ':' +
                pad(this.getUTCMinutes()) +
                ':' +
                pad(this.getUTCSeconds()) +
                '.' +
                String((this.getUTCMilliseconds() / 1000).toFixed(3)).slice(2, 5) +
                'Z';
        };
    }());
};


// метод записывает в бд данные формы
function putFormToDb(depositNumber,
    depositStartDate,
    depositEndDate,
    newDepositStartDate,
    newDepositEndDate,
    prolongationNumber) {

    var depStartDate = (changeDateFormat(depositStartDate)).toISOString();
    var depEndDate = (changeDateFormat(depositEndDate)).toISOString();
    var newDepStartDate = (changeDateFormat(newDepositStartDate)).toISOString();
    var newDepEndDate = (changeDateFormat(newDepositEndDate)).toISOString();


    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/DptAdm/DptAdm/PutTermDepCorrForm"),
        data: {
            depositNm: depositNumber,
            depositStartDt: depStartDate,
            depositEndDt: depEndDate,
            newDepositStartDt: newDepStartDate,
            newDepositEndDt: newDepEndDate,
            prolongationNm: prolongationNumber
        },
        success: function(data) {
            if (data.message != null) {
                bars.ui.error({
                    text: data.message
                });

            } else {
                bars.ui.success({
                    title: "<b>Данні успішно збережені!</b>",
                    text: "№ Депозитного вкладу: " +
                        "<b>" +
                        depositNumber +
                        "</b></br>" +
                        "Дата початку: " +
                        "<b>" +
                        newDepositStartDate +
                        "</b></br>" +
                        "Дата закінчення: " +
                        "<b>" +
                        newDepositEndDate +
                        "</b></br>" +
                        "К-сть пролонгацій: " +
                        "<b>" +
                        prolongationNumber +
                        "</b>"
                });

                window.modalWinTermDepCorr.center().close();
            }
        }
    });

    // меняет в дате день и месяц местами что бы получилось MM/dd/yyyy
    function changeDateFormat(str) {
        var parts = str.split("/");
        var dt = new Date(parseInt(parts[2], 10),
            parseInt(parts[1], 10) - 1,
            parseInt(parts[0], 10));

        return dt;
    }
}