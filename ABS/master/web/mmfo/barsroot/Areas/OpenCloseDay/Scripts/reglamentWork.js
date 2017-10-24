$(document).ready(function () {
    var flagRout = true;
    var dateTypeRout = "ROUTINE_BUSINESSDAY";


    var showWindowRout = function (template, message) {

        var dfd = new jQuery.Deferred();
        var result = false;

        $("<div id='popupWindow'></div>")
            .appendTo("body")
            .kendoWindow({
                width: "410px",
                height: "200px",
                modal: true,
                title: "Сталася помилка!",
                visible: false,
                close: function (e) {
                    this.destroy();
                    dfd.resolve(result);
                }
            }).data('kendoWindow').content($(template).html()).center().open();


        var errorMsg1 = "Функція: " + message.TASK_DESCRIPTION;
        var errorMsg2 = "Опис помилки: " + message.ERR_MSG;

        $('.popupMessage1').append(errorMsg1);
        $('.popupMessage2').append(errorMsg2);

        $('#popupWindow .confirm_yes').val('Продовжити');
        $('#popupWindow .confirm_no').val('Зупинити');

        $('#popupWindow .confirm_no').click(function () {
            var grpLog = localStorage.getItem("groupLogRout");

            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/stopgroup?grouplog=" + grpLog),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncListRout();



            $('#popupWindow').data('kendoWindow').close();
        });

        $('#popupWindow .confirm_yes').click(function () {
            result = true;

            var grpLog = localStorage.getItem("groupLogRout");
            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/rungroup?grouplog=" + grpLog),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncListRout();
            flag = true;

            $('#popupWindow').data('kendoWindow').close();
        });

        return dfd.promise();
    };

    var showConfirmationWindowRout = function (msg) {
        return showWindowRout('#confirmationTemplate', msg);
    };

    //FINISHED
    var callPeriodFuncListRout = function (errorMsg, status) {
        debugger;

        if (status == "" || status == "IDLE" || status == "FINISHED") {
            flag = false;
            $("#startGroupRout").prop("disabled", false);
        }
        else {
            if (!errorMsg || errorMsg.TASK_DESCRIPTION == null) {
                $("#startGroupRout").prop("disabled", true);
                $("#restoreGroupRout").prop("disabled", true);
                setTimeout(function () {
                    $('#funcListRout').data('kendoGrid').dataSource.read();
                    $('#funcListRout').data('kendoGrid').refresh();
                }, 2000);
            } else {
                showConfirmationWindowRout(errorMsg);
            }
        }

    }

    $("#funcListRout").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        columns: [
            { field: "TASK_ID", hidden: true },
            {
                field: "TASK_RANK",
                title: "Ранг",
                width: "5%"
            },
            {
                field: "TASK_ACTIVE",
                title: "Активні",
                width: "7%",
                template: "<input class='activity text-center' name='activity' type='checkbox' #: TASK_ACTIVE === 'YES' ? 'checked=checked' : '' #></input>",
                filterable: false
            },
            {
                field: "TASK_DESCRIPTION",
                title: "Опис",
                width: "35%"
            },
            {
                field: "STATUS_TASK",
                title: "Статус функції",
                width: "20%"
            },
            {
                field: "START_TIME",
                title: "Час початку",
                width: "25%"
            },
            {
                field: "TAST_DURATION",
                title: "Тривалість",
                width: "13%"
            }

        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/opencloseday/dayoper/getfunclist"),
                    data: { dateType: dateTypeRout }
                }
            },
            schema: {
                parse: function (response) {

                    if (flagRout)
                        callPeriodFuncListRout(response.Error, response.StatusGroup);

                    var groupid = response.IdGroup;
                    localStorage.setItem("idRout", groupid);

                    var groupLog = response.GroupLog;
                    localStorage.setItem("groupLogRout", groupLog);


                    if (response.IdGroup == 3)
                        $("#groupRout").text("Регламентні функції зміни банківського дня");

                    $("#groupRoutOnDate").text(response.StartDate);

                    $("#groupdurationRout").text(response.Duration);

                    $("#statusRout").text(response.StatusGroup);

                    return response.ListFunc;
                },
                model: {
                    fields: {
                        TASK_ID: { type: "number" },
                        TASK_ACTIVE: { type: "string" },
                        TASK_DESCRIPTION: { type: "string" },
                        TASK_RANK: { type: "string" },
                        TASK_TYPE: { type: "string" },
                        START_TIME: { type: "string" },
                        TAST_DURATION: { type: "string" },
                        STATUS_TASK: { type: "string" }

                    }
                }
            }
        },

        dataBound: activityOptions
    });
    // MainGridToolBar:
    $("#toolbarRout").kendoToolBar({
        items: [
            { template: "<button id='startGroupRout' type='button' class='k-button' title='Запуск виконання функцій'><i class='pf-icon pf-16 pf-execute'></i>Запуск</button>" },
            { template: "<button id='restoreGroupRout' type='button' class='k-button' title='Відновити виконання функцій'><i class='pf-icon pf-16 pf-arrow_right'></i>Продовжити</button>" }
        ]
    });

    function activityOptions() {
        // checkboxs event
        $('#funcListRout :checkbox').click(function () {
            var elem = $(this);
            var $selectedRow = $(this).parent("td").parent("tr");
            var selectedIndex = $selectedRow[0].rowIndex-1;

            // $this will contain a reference to the checkbox
            if (elem.is(':checked')) {
                $("#funcListRout").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "YES";
            } else {
                $("#funcListRout").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "NO";
            }
        });
    }

    $("#restoreGroupRout").prop("disabled", true);

    $("#startGroupRout").click(function () {
        var funcList = [];
        var data = $("#funcListRout").data("kendoGrid").dataSource._data;
        for (var i = 0; i < data.length; i++) {
            funcList.push({
                id: data[i].TASK_ID,
                active: data[i].TASK_ACTIVE
            });

        }
        var grpId = localStorage.getItem("idRout");

        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/executefunc?groupid=" + grpId),
            data: JSON.stringify(funcList)
        });
        callPeriodFuncListRout();
        flagRout = true;

        /*$("#startGroupRout").prop("disabled", true);
        $("#restoreGroupRout").prop("disabled", false);*/
    });

    $("#restoreGroupRout").click(function () {
        //RestoreGroupList
        debugger;
        var groupLog = localStorage.getItem("groupLogRout");
        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/restoregrouplist?grouplog=" + groupLog),
            data: JSON.stringify(groupLog)
        });

        callPeriodFuncListRout();
        flagRout = true;
        /*$("#startGroupRout").prop("disabled", false);
        $("#restoreGroupRout").prop("disabled", true);*/
    });
});