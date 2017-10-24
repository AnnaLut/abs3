$(document).ready(function () {
    debugger;
    var flagStart = true;
       var showWindowStart = function (template, message) {
           debugger;
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
                    debugger;
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
            var grpLog = localStorage.getItem("groupLogStart");
            debugger;
            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/stopgroup?grouplog=" + grpLog),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncListOnStart();
            $('#popupWindow').data('kendoWindow').close();
        });

        $('#popupWindow .confirm_yes').click(function () {
            result = true;
            debugger;
            var grpLog = localStorage.getItem("groupLogStart");
            $.ajax({
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                url: bars.config.urlContent("/api/opencloseday/dayoper/rungroup?grouplog=" + grpLog),
                data: JSON.stringify(grpLog)
            });
            callPeriodFuncListOnStart();
            flagStart = true;

            $('#popupWindow').data('kendoWindow').close();
        });

        return dfd.promise();
    };

       var showConfirmationWindowStart = function (msg) {
           debugger;
        return showWindowStart('#confirmationTemplate', msg);
    };
    
    //FINISHED
       var callPeriodFuncListOnStart = function (errorMsg, status) {
           debugger;
           if (status == "" || status == "IDLE" || status == "FINISHED") {
               flagStart = false;
               $("#startGroupStart").prop("disabled", false);
           }
           else {
               if (!errorMsg || errorMsg.TASK_DESCRIPTION == null) {

                   $("#startGroupStart").prop("disabled", true);
                   $("#restoreGroupStart").prop("disabled", true);
                setTimeout(function () {
                    debugger;
                    $('#funcListStart').data('kendoGrid').dataSource.read();
                    $('#funcListStart').data('kendoGrid').refresh();
                }, 2000);
            } else {
                showConfirmationWindowStart(errorMsg);
            }
        }

    }

    var dateTypeStart = "START_BUSINESSDAY";

    $("#funcListStart").kendoGrid({
        autoBind: true,
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
                    data: { dateType: dateTypeStart }
                }
            },
            schema: {
                
                parse: function (response) {
                    debugger;
                    if (flagStart)
                        callPeriodFuncListOnStart(response.Error, response.StatusGroup);
                    
                    var groupid = response.IdGroup;
                    localStorage.setItem("idStart", groupid);

                    var groupLog = response.GroupLog;
                    localStorage.setItem("groupLogStart", groupLog);
                    debugger;
                    
                    if (response.IdGroup == 2)
                        $("#groupStart").text("Функції старту банківського дня");

                    $("#groupStartOnDate").text(response.StartDate);

                    $("#groupdurationStart").text(response.Duration);

                    $("#statusStart").text(response.StatusGroup);
                    
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
    $("#toolbarStart").kendoToolBar({
        items: [
            { template: "<button id='startGroupStart' type='button' class='k-button' title='Запуск виконання функцій'><i class='pf-icon pf-16 pf-execute'></i>Запуск</button>" },
            { template: "<button id='restoreGroupStart' type='button' class='k-button' title='Відновити виконання функцій'><i class='pf-icon pf-16 pf-arrow_right'></i>Продовжити</button>" }
        ]
    });

    function activityOptions() {
        debugger;
        // checkboxs event
        $('#funcListStart :checkbox').click(function () {
            debugger;
            var elem = $(this);
            var $selectedRow = $(this).parent("td").parent("tr");
            var selectedIndex = $selectedRow[0].rowIndex - 1;

            // $this will contain a reference to the checkbox
            if (elem.is(':checked')) {
                $("#funcListStart").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "YES";
            } else {
                $("#funcListStart").data("kendoGrid").dataSource._data[selectedIndex].TASK_ACTIVE = "NO";
            }
        });
    }


    $("#restoreGroupStart").prop("disabled", true);

    $("#startGroupStart").click(function () {
        debugger;
        var funcList = [];
        var data = $("#funcListStart").data("kendoGrid").dataSource._data;
        for (var i = 0; i < data.length; i++) {
            funcList.push({
                id: data[i].TASK_ID,
                active: data[i].TASK_ACTIVE
            });

        }
        var grpId = localStorage.getItem("idStart");

        debugger;

        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/executefunc?groupid=" +grpId),
            data: JSON.stringify(funcList)
        });

        
        callPeriodFuncListOnStart();
        flagStart = true;
        /*$("#startGroupStart").prop("disabled", true);
        $("#restoreGroupStart").prop("disabled", false);*/
    });

    $("#restoreGroupStart").click(function () {
        debugger;
        var groupLog = localStorage.getItem("groupLogStart");
        $.ajax({
            type: "POST",
            contentType: 'application/json',
            dataType: "json",
            url: bars.config.urlContent("/api/opencloseday/dayoper/restoregrouplist/"),
            data: JSON.stringify(groupLog)
        });

        callPeriodFuncListOnStart();
        flagStart = true;

        /*$("#startGroupStart").prop("disabled", false);
        $("#restoreGroupStart").prop("disabled", true);*/
    });
    
});