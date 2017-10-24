$(document).ready(function () {
    // MainGridToolBar:
    $("#toolbarLog").kendoToolBar({
        items: [
            { template: "<input class='datepicker' placeholder='Дата видачі' id='bankDate' type='date' pattern='\d{1,2}.\d{1,2}.\d{4}'>" },
            {
                type: "buttonGroup",
                buttons: [
                    { id: "open", text: "При відкритті", togglable: true, group: "func", toggle: buttonClickHandler, selected: true },
                    { id: "close", text: "При закритті", togglable: true, group: "func", toggle: buttonClickHandler },
                    { id: "rout", text: "Регламентні роботи", togglable: true, group: "func", toggle: buttonClickHandler }
                ]
            },
            { template: "<button id='btnHistory' type='button' class='k-button'><i class='pf-icon pf-16 pf-find'></i>Переглянути</button>" }
        ]
    });

    $(".datepicker").kendoDatePicker({
        value: new Date(),
        max: new Date(),
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });

    $("#toolbarLog").css("text-align", "left");

    var date = $("#bankDate").val();
    var dateType = "START_BUSINESSDAY";

    function buttonClickHandler(e) {
        if (e.id == "close")
            dateType = "FINISH_BUSINESSDAY";
        if (e.id == "open")
            dateType = "START_BUSINESSDAY";
        if (e.id == "rout")
            dateType = "ROUTINE_BUSINESSDAY";
    }


    $("#btnHistory").click(function () {
    });


    $("#funcListLog").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        columns: [
            {
                field: "ID_GROUP_LOG",
                title: "ID групи",
                width: "5%"
            },
            {
                field: "BANK_DATE",
                title: "Банківська дата",
                width: "35%"
            },
            {
                field: "START_DATE_GROUP",
                title: "Старт групи",
                width: "20%"
            },
            {
                field: "DURATION_GROUP",
                title: "Проміжок часу",
                width: "25%"
            },
            {
                field: "STATUS_GROUP",
                title: "Статус групи",
                width: "13%"
            },
            {
                field: "TASK_ACTIVE",
                title: "TASK_ACTIVE",
                width: "13%"
            },
            {
                field: "START_DATE_TASK",
                title: "START_DATE_TASK",
                width: "13%"
            },
            {
                field: "DURATION_TASK",
                title: "DURATION_TASK",
                width: "20%"
            },
            {
                field: "STATUS_TASK",
                title: "STATUS_TASK",
                width: "25%"
            },
            {
                field: "ERR_MSG",
                title: "ERR_MSG",
                width: "13%"
            },
            {
                field: "TASK_DESCRIPTION",
                title: "TASK_DESCRIPTION",
                width: "13%"
            },
            {
                field: "TASK_RANK",
                title: "TASK_RANK",
                width: "13%"
            }

        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/opencloseday/dayoper/gethistory/"),
                    data: function() {
                        var param = { date: date, dateType: dateType };
                        return param;
                    }

                }
            },
            schema: {
                parse: function (response) {
                    return response.ListFunc;
                },
                model: {
                    fields: {
                        ID_GROUP_LOG: { type: "number" },
                        BANK_DATE: { type: "string" },
                        START_DATE_GROUP: { type: "string" },
                        DURATION_GROUP: { type: "string" },
                        STATUS_GROUP: { type: "string" },
                        TASK_ACTIVE: { type: "string" },
                        START_DATE_TASK: { type: "string" },
                        DURATION_TASK: { type: "string" },
                        STATUS_TASK: { type: "string" },
                        ERR_MSG: { type: "string" },
                        TASK_DESCRIPTION: { type: "string" },
                        TASK_RANK: { type: "string" }

                    }
                }
            }
        }
    });

});