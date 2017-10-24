$(document).ready(function () {
    var flag = true;
    var dateTypeEnd = "FINISH_BUSINESSDAY";
    debugger;
    var showWindow = function (template, message) {

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
            var grpLog = localStorage.getItem("groupLog");

            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/stopgroup/"),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncList();
            $('#popupWindow').data('kendoWindow').close();
        });

        $('#popupWindow .confirm_yes').click(function () {
            result = true;

            var grpLog = localStorage.getItem("groupLog");
            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/rungroup/"),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncList();
            flag = true;

            $('#popupWindow').data('kendoWindow').close();
        });

        return dfd.promise();
    };

    var showConfirmationWindow = function (msg) {
        return showWindow('#confirmationTemplate', msg);
    };

    //FINISHED
    var callPeriodFuncList = function (errorMsg, status) {
        debugger;

        if (status == "" || status == "IDLE" || status == "FINISHED") {
            flag = false;
            $("#startGroupEnd").prop("disabled", false);
        } else {
            if (!errorMsg || errorMsg.TASK_DESCRIPTION == null) {
                $("#startGroupEnd").prop("disabled", true);
                $("#restoreGroupEnd").prop("disabled", true);
                setTimeout(function () {
                    $('#funcListEnd').data('kendoGrid').dataSource.read();
                    $('#funcListEnd').data('kendoGrid').refresh();
                }, 2000);
            } else {
                $("#restoreGroupEnd").prop("disabled", false);
                showConfirmationWindow(errorMsg);
            }
        }

    }

    $("#funcListEnd").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: false,
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
                    data: { dateType: dateTypeEnd }
            }
            },
            schema: {
                parse: function (response) {
                    debugger;
                    if (flag)
                        callPeriodFuncList(response.Error, response.StatusGroup);

                    var groupid = response.IdGroup;
                    localStorage.setItem("id", groupid);

                    var groupLog = response.GroupLog;
                    localStorage.setItem("groupLog", groupLog);


                    if (response.IdGroup == 1)
                        $("#groupEnd").text("Функції фінішу банківського дня");

                    $("#groupEndOnDate").text(response.StartDate);

                    $("#groupdurationEnd").text(response.Duration);

                    $("#statusEnd").text(response.StatusGroup);

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
    $("#toolbar").kendoToolBar({
        items: [
            { template: "<button id='startGroupEnd' type='button' class='k-button' title='Запуск виконання функцій'><i class='pf-icon pf-16 pf-execute'></i>Запуск</button>" },
            { template: "<button id='restoreGroupEnd' type='button' class='k-button' title='Відновити виконання функцій'><i class='pf-icon pf-16 pf-arrow_right'></i>Продовжити</button>" }
        ]
    });

    function activityOptions() {
        // checkboxs event
        $('#funcListEnd :checkbox').click(function () {
            var elem = $(this);
            var $selectedRow = $(this).parent("td").parent("tr");
            var selectedIndex = $selectedRow[0].rowIndex - 1;

            // $this will contain a reference to the checkbox
           
            if (elem.is(':checked')) {
                $("#funcListEnd").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "YES";
            } else {
                $("#funcListEnd").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "NO";
            }
        });
    }

    $("#restoreGroupEnd").prop("disabled", true);

    $("#startGroupEnd").click(function () {
        debugger;
        $(".hidden-label").removeClass("hidden-label");

        var funcList = [];
        var data = $("#funcListEnd").data("kendoGrid").dataSource._data;
        for (var i = 0; i < data.length; i++) {
            funcList.push({
                id: data[i].TASK_ID,
                active: data[i].TASK_ACTIVE
            });

        }
        var grpId = localStorage.getItem("id");

        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/executefunc?groupid=" +grpId),
            data: JSON.stringify(funcList)
        });
        callPeriodFuncList();
        flag = true;

        /*$("#startGroupEnd").prop("disabled", true);
        $("#restoreGroupEnd").prop("disabled", false);*/
    });

    $("#restoreGroupEnd").click(function () {
        //RestoreGroupList
        debugger;
        var groupLog = localStorage.getItem("groupLog");
        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/restoregrouplist/"),
            data: JSON.stringify(groupLog)
        });

        callPeriodFuncList();
        flag = true;
        /*$("#startGroupEnd").prop("disabled", false);
        $("#restoreGroupEnd").prop("disabled", true);*/
    });
});