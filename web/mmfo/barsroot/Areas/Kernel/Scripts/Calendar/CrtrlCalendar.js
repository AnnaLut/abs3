$(document).ready(function () {
    kendo.culture("uk-UA");
    $("#confirm").prop("disabled", true);

    var selectedday, selecteddays = [];

    $("#yearpicker, #kv").change(function () {
        reload();
    });
    $("#yearpicker").val(new Date().getFullYear());
    $("#kv").val(980);

    MakeDaysRed = function () {
        var arr = $("div[class='disabledDay']");
        $.each(arr, function (i, v) {
            var tds = arr[i].parentElement.parentElement;
            if (tds.className == "k-other-month k-weekend" || tds.className == "k-other-month")
                tds.className = "k-other-month"
            else
                tds.className = "k-weekend";
        });
    }

    DropSelectedDays = function (selectedday) {
        var selecteddays = $(".k-state-selected");
        if (selectedday) {
            var focus = $("k-state-focused");
            $.each(selecteddays, function (i, v) {
                //if (td.className != "k-state-h +new Date("3/13/2017"),over k-state-selected k-state-focused" && td.className != "k-weekend k-state-hover k-state-selected k-state-focused" && td.className != "k-weekend k-state-selected")
                //td.className = "";
                if (selecteddays[i].className.indexOf("k-weekend") == -1 && selecteddays[i].className.indexOf("k-state-focused") == -1)
                    selecteddays[i].className = "";
            });
            focus.className = "k-state-selected k-state-focused"
        }
        else {
            $.each(selecteddays, function (i, v) {
                selecteddays[i].className = "";
            });
        }

    }

    parseJsonDate = function (jsonDate) {
        var fullDate = new Date(parseInt(jsonDate.substr(6)));
        var y1 = fullDate.getFullYear();
        var y2 = fullDate.getYear();
        var twoDigitMonth = (fullDate.getMonth() + 1) + ""; if (twoDigitMonth.length == 1) twoDigitMonth = "0" + twoDigitMonth;
        var twoDigitDate = fullDate.getDate() + ""; if (twoDigitDate.length == 1) twoDigitDate = "0" + twoDigitDate;
        var currentDate = twoDigitMonth + "/" + twoDigitDate + "/" + fullDate.getFullYear();
        return currentDate;
    };

    InitHolidays = function () {
        bars.ui.confirm({ text: 'Заповнити річний календар вихідними днями?' }, function () {
            var year = $("#yearpicker").val();
            var kv = $("#kv").val();
            $.ajax({
                method: "POST",
                dataType: "json",
                async: false,
                url: bars.config.urlContent("/api/kernel/Calendar/InitHolidays") + "?year=" + year + "&kv=" + kv,
                success: function (data) {

                }
            });
        });
    }

    SaveCalendar = function () {
        debugger;
        var if_all = $("#kv_all")[0].checked;
        var year = $("#yearpicker").val();
        var kv = $("#kv").val();
        if (if_all)
            kv = -1;//всі валюти
            $.ajax({
                method: "POST",
                dataType: "json",
                async: false,
                url: bars.config.urlContent("/api/kernel/Calendar/SaveCalendar"),
                data: JSON.stringify({ year: year, kv: kv, holiday: selecteddays }),

                contentType: "application/json",
                complete: function (data) {
                    bars.ui.success({ text: "Дати збережені!" });
                }
            });
    }

    DaysOff = function () {
        var year = $("#yearpicker").val();
        var kv = $("#kv").val();
        disabledDays = [];
        $.ajax({
            method: "GET",
            dataType: "json",
            async: false,
            url: bars.config.urlContent("/api/kernel/Calendar/GetHolidays") + "?year=" + year + "&kv=" + kv,
            success: function (data) {
                $.each(data, function (i, v) {
                    disabledDays.push(+new Date(parseJsonDate(v.holiday)));
                });
            }
        });
        return disabledDays;

    }
    AlertNotifyError = function () {
        var popupNotification = $("#popupNotification").kendoNotification({
            height: 45,
            position: {
                pinned: true,
                top: 10,
                right: 50,
            },
        }).data("kendoNotification");
        popupNotification.show("Оновлено", "info");
    }
    reload = function () {
        var MounthIDs = ["#jan", "#feb", "#mar", "#apr", "#may", "#jun", "#jul", "#aug", "#sep", "#oct", "#nov", "#dec"];
        $.each(MounthIDs, function (i, v) {
            $(MounthIDs[i]).data("kendoCalendar").destroy();
            $(MounthIDs[i] + "> table").remove();
            $(MounthIDs[i] + " > div").remove();
            $(MounthIDs[i]).removeAttr("data-role");
            $(MounthIDs[i]).removeAttr("class");
        });
         
        InitByMounth();
        AlertNotifyError();
    }

    InitByMounth = function () {
        $("#save").prop("disabled", true);
        MounthIDs = ["#jan", "#feb", "#mar", "#apr", "#may", "#jun", "#jul", "#aug", "#sep", "#oct", "#nov", "#dec"];
        var disabledDays = DaysOff();//get holidays for hole year
        $.each(MounthIDs, function (i, v) {
            $(MounthIDs[i]).kendoCalendar({
                value: new Date($("#yearpicker").val(), i, 1),
                dates: disabledDays,
                month: {
                    content: '# if ($.inArray(+data.date, data.dates) != -1) { #' +
                    '<div class="disabledDay">#= data.value #</div>' +
                    '# } else { #' +
                    '#= data.value #' +
                    '# } #'
                },
                change: function (e) {
                    $("#confirm").prop("disabled", false);
                    selectedday = this.value();
                    CreateSelectedArr(selectedday);
                    var daysel = $(".k-state-selected")
                     
                    if (daysel[0].className.indexOf("k-weekend")!=-1)
                        daysel[0].className = ""
                    else
                        daysel[0].className = "k-weekend"
                    DropSelectedDays(selectedday);
                }
            });
            DropSelectedDays();
        });
        MakeDaysRed();
    }

    InitByMounth();

    CreateSelectedArr = function (day) {
         
        var contain = false;
        var index = 0;
        if (selecteddays.length == 0) {
            selecteddays.push(day);
            $("#save").prop("disabled", false);
            return false;
        }
        $.each(selecteddays, function (i, v) {
             
            var d = selecteddays[i];
            if (kendo.toString(kendo.parseDate(d, 'yyyy-MM-dd'), 'dd/MM/yyyy') === kendo.toString(kendo.parseDate(day, 'yyyy-MM-dd'), 'dd/MM/yyyy')) {
                index = i;
                contain = true;
            }
        });
        if (contain) {
            selecteddays.splice(index, 1);
        }
        else {
            selecteddays.push(day);
        }
         
        if (selecteddays.length > 0)
            $("#save").prop("disabled", false);
        else
            $("#save").prop("disabled", true);
        return selecteddays;
    }


    CloseConfirmWin = function () { $("#winCalendarConfirm").data("kendoWindow").close(); }
    GetStrSelectedDay = function (selectedday) {
        var dd = selectedday.getDate();
        var mm = selectedday.getMonth() + 1; //January is 0!
        var yyyy = selectedday.getFullYear();
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        return mm + '/' + dd + '/' + yyyy;;
    }

    SetDayState = function () {
        var daysel = $(".k-state-selected")
        if (daysel[0].className == "k-weekend k-state-selected") {
            daysel[0].className = ""
        }
        else {
            daysel[0].className = "k-weekend"
        }
        CloseConfirmWin();
    }

    OpenConfirmWin = function () {

        $("#winCalendarConfirm").data("kendoWindow").center().open();
        $("#dayforOFF").text(GetStrSelectedDay(selectedday));
        var daysel = $(".k-state-selected")
        if (daysel[0].className == "k-weekend k-state-selected") {
            $("#dayname").text("робочий");
        }
        else {
            $("#dayname").text("вихідний");
        }
    }

    $("#winCalendarConfirm").kendoWindow();
});