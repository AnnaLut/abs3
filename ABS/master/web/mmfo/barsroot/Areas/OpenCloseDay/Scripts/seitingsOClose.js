function getFuncId(e) {
    debugger;
};

$(document).ready(function () {
    $("#dateNewVal").kendoDatePicker({
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        },
        change: function () {
            var newDatep = this.value();
            var pDate = $("#dateOldVal").val().split(".");
            var oldDatep = new Date(pDate[2], pDate[1] - 1, pDate[0]);
            if (oldDatep > newDatep) {
                bars.ui.error({ title: 'Помилка', text: "Дата наступного банківського дня,\n менше за наступну" });
                //if error: set date of the next day
                var tomorrowDate = new Date();
                tomorrowDate.setDate(tomorrowDate.getDate() + 1);
                this.value(tomorrowDate);
            }
        }
    });

    function onClose() {
        $("#funcSeitingsGrid").data('kendoGrid').dataSource.read();
        $("#funcSeitingsGrid").data('kendoGrid').refresh();
    };

    $("#windowInfoSeitings").kendoWindow({
        width: "70%",
        height: "60%",
        title: "Додаткова інформація",
        visible: false,
        actions: [
            "Minimize",
            "Maximize",
            "Close"
        ],
        close: onClose
    }).data("kendoWindow");

    var sessionId = $("#sessionId").html();
    function test() { debugger; };

    var funcSource = new kendo.data.DataSource({
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/gettasklist?session_id=" + $("#sessionId").html())
            }
        },
        schema: {
            model: {
                fields: {
                    TASK_ID: { type: "string", editable: false },
                    SEQUENCE_NUMBER: { type: "string", editable: false },
                    TASK_NAME: { type: "string", editable: false },
                    IS_ON: { type: "string", editable: false },
                    SHOW_BRANCHES: { type: "string", editable: false },
                }
            }
        }
    });
    function testCildFunc() {
        $(".checkbox.text-center.checkbox-inline").on("click", function () {

            var ss = $(this).closest("tr");
            var grid = $("#funcSeitingsChildGrid").data("kendoGrid");
            var record = grid.dataItem(ss);

            if (this.checked) {
                checkUrl = bars.config.urlContent("/api/opencloseday/departmentinfo/enabletaskforbranch?func_id=" + record.TASK_RUN_ID);
            } else {
                checkUrl = bars.config.urlContent("/api/opencloseday/departmentinfo/disabletaskforbranch?func_id=" + record.TASK_RUN_ID);
            }

            $.ajax({
                type: "GET",
                async: false,
                url: checkUrl,
                dateType: "json",
                success: function (data) {

                    $("#funcSeitingsChildGrid").data('kendoGrid').dataSource.read();
                    $("#funcSeitingsChildGrid").data('kendoGrid').refresh();
                }
            })

        });
    };
    function testFunc() {
        $(".btn-info").on("click", function () {

            var ss = $(this).closest("tr");
            var grid = $("#funcSeitingsGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
            var sessionId = $("#sessionId").html();

            var funcCidlSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        dataType: "json",
                        type: "GET",
                        url: bars.config.urlContent("/api/opencloseday/departmentinfo/getbranchtasklist?session_id=" + sessionId + "&func_id=" + record.TASK_ID)
                    }
                },
                schema: {
                    model: {
                        fields: {
                            TASK_RUN_ID: { type: "string", editable: false },
                            BRANCH_CODE: { type: "string", editable: false },
                            BRANCH_NAME: { type: "string", editable: false },
                            IS_ON: { type: "string", editable: false },
                            TASK_RUN_STATE: { type: "string", editable: false },
                        }
                    }
                }
            });
            var funcSeitingsChildGrid = $("#funcSeitingsChildGrid").kendoGrid({
                dataSource: funcCidlSource,
                height: 350,
                sortable: true,
                pageable: false,
                dataBound: testCildFunc,
                columns: [{
                    field: "TASK_RUN_ID",
                    title: "Індентифікатор",
                    width: "10%"
                }, {
                    field: "BRANCH_CODE",
                    title: "Порядковий номер",
                    width: "10%"
                }, {
                    field: "BRANCH_NAME",
                    title: "Назва функції",
                    width: "10%"
                }, {
                    template: '<input type="checkbox" #= (IS_ON == 1) ? \'checked="checked"\' : "" # class="checkbox text-center checkbox-inline" />',
                    field: "IS_ON",
                    title: "Вибір",
                    width: "10%"
                }, {
                    field: "TASK_RUN_STATE",
                    title: "Бранчі",
                    width: "30%"
                }]
            }).data("kendoGrid");

            $("#windowInfoSeitings").data("kendoWindow").center().open();

        });
        $(".checkbox").on("click", function () {
            var ss = $(this).closest("tr");
            var grid = $("#funcSeitingsGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
            var checkUrl = "";
            var sessionId = $("#sessionId").html();

            if (this.checked) {
                checkUrl = bars.config.urlContent("/api/opencloseday/departmentinfo/enabletaskforrun?session_id=" + sessionId + "&func_id=" + record.TASK_ID);
            } else {
                checkUrl = bars.config.urlContent("/api/opencloseday/departmentinfo/disabletaskforrun?session_id=" + sessionId + "&func_id=" + record.TASK_ID);
            }
            $.ajax({
                type: "GET",
                async: false,
                url: checkUrl,
                dateType: "json",
                success: function (data) {
                    $("#funcSeitingsGrid").data('kendoGrid').dataSource.read();
                    $("#funcSeitingsGrid").data('kendoGrid').refresh();
                }
            })

        })
    };

    var funcSeitingsGrid = $("#funcSeitingsGrid").kendoGrid({
        dataSource: funcSource,
        height: 350,
        sortable: true,
        pageable: false,
        dataBound: testFunc,
        columns: [{
            field: "TASK_ID",
            title: "Індентифікатор",
            width: "10%"
        },{
            field: "SEQUENCE_NUMBER",
            title: "Порядковий номер",
            width: "10%"
        },{
            field: "TASK_NAME",
            title: "Назва функції",
            width: "30%"
        }, {
            template: '<input type="checkbox" #= (IS_ON == 1) ? \'checked="checked"\' : "" # class="checkbox text-center" />',
            field: "IS_ON",
            title: "Вибір",
            width: "10%"
        }, {
            template: ' #= (SHOW_BRANCHES == 1) ? \'<button type="button" class="btn btn-info">Додатково</button>\' : "" #',
            field: "SHOW_BRANCHES",
            title: "Бранчі",
            width: "10%"
        }]
    }).data("kendoGrid");

    

    $("#beginMonitoring").click(function () {

        var sessionId = $("#sessionId").html();
        var newDate = $("#dateNewVal").val();

        $.ajax({
            type: "GET",
            async: false,
            url: bars.config.urlContent("/api/opencloseday/departmentinfo/setnewbankdate?run_id=" + sessionId + "&new_date=" + newDate),
            success: function (data) {

                $.ajax({
                    type: "GET",
                    async: false,
                    url: bars.config.urlContent("/api/opencloseday/departmentinfo/startrun?run_id=" + sessionId),
                    dateType: "json",
                    success: function (data) {

                        var redir_href = window.location.href.split("/")[0] + "//"
                            + $(location).attr('href').split("/").slice(2, 4).join("/") +
                            "/opencloseday/openclose/opmonitoring?deploy_id=" + sessionId;

                        window.location.replace(redir_href);
                    }
                });     
            }
        });
        
    });
});
