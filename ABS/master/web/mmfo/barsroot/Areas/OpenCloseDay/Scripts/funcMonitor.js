function arrParce(item) {
    var line = "";
    if (item[0] == 1) { line += '<button type="button" class="btn btn-info mon-info" style="width:100px;">Інформація</button>'; }
    if (item[1] == 1) { line += '<button type="button" class="btn btn-info mon-start" style="width:100px;">Запустити зараз</button>'; }
    if (item[2] == 1) { line += '<button type="button" class="btn btn-info mon-terminate" style="width:100px;">Перервати виконання</button>'; }
    if (item[3] == 1) { line += '<button type="button" class="btn btn-info mon-disable" style="width:100px;">Відмінити</button>'; }
    if (item[4] == 1) { line += '<button type="button" class="btn btn-info mon-repeat" style="width:100px;">Повторити виконання</button>'; }
    return line;
};

$(document).ready(function () {
    var interval;
    var sessionId = $("#sessionId").html();

    $("#toolbar").kendoToolBar({
        items: [
            { template: "<button id='btn_refresh' type='button' class='k-button' title='Обновити статус'><i class='pf-icon pf-16 pf-database-arrow_right'></i></button>" }
            //{ template: 'Минула дата<input type="text" id="dateOldM" class="k-textbox text-center" readonly>' },
            //{ template: 'Теперішня дата<input type="text" id="dateNewM" class="k-textbox text-center" readonly>' },
            //{ template: 'Статус<input type="text" id="monitorStatus" class="k-textbox text-center" readonly>' }
        ]
    });

    var fMonSource = new kendo.data.DataSource({
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/gettaskmonitor?deploy_run_id=" + sessionId)
            }
        },
        pageSize: 10,
        schema: {
            parse: function (response) {

                $("#dateOldM").val(kendo.toString(kendo.parseDate(response.P_CURRENT_DATE), 'dd.MM.yyyy'));
                $("#dateNewM").val(kendo.toString(kendo.parseDate(response.P_NEW_DATE), 'dd.MM.yyyy'));
                
                var state = response.P_RUN_STATE_ID;
                if (!(state == 2 || state == 5)) {
                    clearInterval(interval);
                }

                $("#monitorStatus").val(response.P_RUN_STATE_NAME);
                

                switch (state) {
                    case 1:
                        $("#monitorStatus").css('background-color', '#b3f0ff'); break;
                    case 2:
                        $("#monitorStatus").css('background-color', '#ccf5ff'); break;
                    case 3:
                        $("#monitorStatus").css('background-color', '#00cc00'); break;
                    case 4:
                        $("#monitorStatus").css('background-color', '#cc2900'); break;
                    case 5:
                        $("#monitorStatus").css('background-color', '#c2c2d6'); break;
                }
   
                return response.P_TASK_DATA;
            },
            model: {
                fields: {
                    ID: { type: "string", editable: false },
                    SEQUENCE_NUMBER: { type: "string", editable: false },
                    TASK_NAME: { type: "string", editable: false },
                    BRANCH_CODE: { type: "string", editable: false },
                    BRANCH_NAME: { type: "string", editable: false },
                    START_TIME: { type: "string", editable: false },
                    FINISH_TIME: { type: "string", editable: false },
                    TASK_RUN_STATE: { type: "string", editable: false },
                    BUTTON_FLAGS: { type: "array", editable: false }
                }
            }
        }
    });

    function procInfo() {
        $(".mon-info").on("click", function () {
            
            var ss = $(this).closest("tr");
            var grid = $("#monitorGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
     
            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/gettaskrunreportdata?mon_id=" + record.ID),
                success: function (data) {
            
                    $("#sessionId").text(data);

                    var message = data.MESSAGE_INFO.split("ORA-").join("ORA-");
                    $("#extext").text(message);
                }
            });

            $("#extraInfo").data("kendoWindow").center().open();
            

        });
        $(".mon-start").on("click", function () {
            var ss = $(this).closest("tr");
            var grid = $("#monitorGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
 
            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/monitorstarttaskrun?mon_id=" + record.ID),
                success: function (data) {
                   
                }
            });
        });
        $(".mon-terminate").on("click", function () {
            var ss = $(this).closest("tr");
            var grid = $("#monitorGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
       
            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/monitorterminatetaskrun?mon_id=" + record.ID),
                success: function (data) {
              
                }
            });

        });
        $(".mon-disable").on("click", function () {
            var ss = $(this).closest("tr");
            var grid = $("#monitorGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
 
            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/monitordisabletaskrun?mon_id=" + record.ID),
                success: function (data) {
      
                }
            });

        });
        $(".mon-repeat").on("click", function () {
            var ss = $(this).closest("tr");
            var grid = $("#monitorGrid").data("kendoGrid");
            var record = grid.dataItem(ss);

            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/monitorrepeattaskrun?mon_id=" + record.ID),
                success: function (data) {

                }
            });

        });
    };

    var monitorGrid = $("#monitorGrid").kendoGrid({
        dataSource: fMonSource,
        sortable: true,
        pageable: false,
        dataBound: procInfo,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [{
            field: "ID",
            title: "ID",
            width: "5%"

        }, {
            field: "SEQUENCE_NUMBER",
            title: "П.П.",
            width: "4%"
        }, {
            field: "TASK_NAME",
            title: "Назва Функції",
            width: "20%"
        }, {
            field: "BRANCH_CODE",
            title: "Код Бранча",
        }, {
            field: "BRANCH_NAME",
            title: "Назва Бранча",
        }, {
            template: "#= (START_TIME == null) ? ' ' : kendo.toString(kendo.parseDate(START_TIME), 'dd.MM.yyyy HH:mm:ss') #",
            field: "START_TIME",
            title: "Час Старту",
        }, {
            template: "#= (FINISH_TIME == null) ? ' ' : kendo.toString(kendo.parseDate(FINISH_TIME), 'dd.MM.yyyy HH:mm:ss') #",
            field: "FINISH_TIME",
            title: "Час Фінішу",
        }, {
            field: "TASK_RUN_STATE",
            title: "Статус Задачі",
        }, {
            template: "#= arrParce(BUTTON_FLAGS) #",
            field: "BUTTON_FLAGS",
            title: "Інформація",
            width: "8%"
        }]
    }).data("kendoGrid");

    //var interval = setInterval(monitorGridState, 18000);
    function monitorGridState() {
        debugger;
        //$("#monitorGrid").data("kendoGrid").dataSource.empty();
        //$("#monitorGrid").data("kendoGrid").dataSource.data([]);
        $("#monitorGrid").data('kendoGrid').dataSource.read();
        $("#monitorGrid").data('kendoGrid').refresh();

    };

    $("#btn_refresh").click(function () {
        monitorGridState();
    });

    $("#extraInfo").kendoWindow({
        width: "50%",
        height: "40%",
        title: "Додаткова інформація",
        visible: false,
        actions: [
            "Minimize",
            "Maximize",
            "Close"
        ]
    
    }).data("kendoWindow");
});