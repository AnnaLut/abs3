var formConfig = {
    formType: 0,
    setFormType: function (val) {
        this.formType = +val;
    },

    outputRequestsOptions: {
        columns: [
            { title: "ІД запиту", field: "Id", width: "70px" },
            { title: "Тип запиту", field: "SendType", width: "50px" },
            { title: "Дата створення", field: "InsDate", template: "<div style='text-align:center;'>#=(InsDate == null) ? ' ' : kendo.toString(InsDate,'dd.MM.yyyy HH:mm:ss')#</div>", width: "50px" },
            { title: "Статус", field: "Status", width: "50px" },
            { title: "Дата виконання", field: "DoneDate", template: "<div style='text-align:center;'>#=(DoneDate == null) ? ' ' : kendo.toString(DoneDate,'dd.MM.yyyy HH:mm:ss')#</div>", width: "50px" },
            { title: "ІД користувача", field: "UserId", width: "50px" },
            { title: "КФ користувача", field: "UserKf", width: "50px" }
        ]
    },

    outputRequestsDS: {
        transport: {
            read: {
                url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchMainOutReqs")
            }
        },
        schema: {
            model: {
                fields: {
                    Id: { type: "string" },
                    SendType: { type: "string" },
                    InsDate: { type: "date" },
                    Status: { type: "string" },
                    DoneDate: { type: "date" },
                    UserId: { type: "number" },
                    UserKf: { type: "string" }
                }
            }
        }
    },

    inputRequestsOptions: {
        columns: [
            { title: "ІД запиту", field: "Id", width: "300px" },
            { title: "Метод запиту", field: "HttpType", width: "100px" },
            { title: "Тип запиту", field: "TypeName", width: "150px" },
            { title: "Опис типу", field: "TypeDesc", width: "150px" },
            { title: "Назва дії при обробці", field: "ReqAction", width: "150px" },
            { title: "Користувач", field: "ReqUser", width: "150px" },
            { title: "ФІО", field: "FullName", width: "200px" },
            { title: "Дата прийняття", field: "InsertTime", width: "150px", template: "<div style='text-align:center;'>#=(InsertTime == null) ? ' ' : kendo.toString(InsertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
            { title: "Дата конвертації", field: "ConvertTime", width: "150px", template: "<div style='text-align:center;'>#=(ConvertTime == null) ? ' ' : kendo.toString(ConvertTime,'dd.MM.yyyy HH:mm:ss')#</div>" },
            { title: "Статус", field: "Status", width: "200px" },
            { title: "Дата закінчення обробки", field: "ProcessedTime", width: "200px", template: "<div style='text-align:center;'>#=(ProcessedTime == null) ? ' ' : kendo.toString(ProcessedTime,'dd.MM.yyyy HH:mm:ss')#</div>" }
        ]
    },

    inputRequestsDS: {
        transport: {
            read: {
                url: bars.config.urlContent("/api/TranspUi/TranspUi/SearchMainInReqs")
            }
        },
        schema: {
            model: {
                fields: {
                    Id: { type: "string" },
                    HttpType: { type: "string" },
                    TypeName: { type: "string" },
                    TypeDesc: { type: "string" },
                    ReqAction: { type: "string" },
                    ReqUser: { type: "string" },
                    FullName: { type: "string" },
                    InsertTime: { type: "date" },
                    ConvertTime: { type: "date" },
                    Status: { type: "string" },
                    ProcessedTime: { type: "date" }
                }
            }
        }
    },

    getCurrentGridOptions: function () {
        switch (this.formType) {
            case 1: return this.outputRequestsOptions;
            case 2: return this.inputRequestsOptions;
            default: return {};
        }
    },

    getCurrentGridDS: function () {
        switch (this.formType) {
            case 1: return this.outputRequestsDS;
            case 2: return this.inputRequestsDS;
            default: return {};
        }
    },

    getTitle: function () {
        switch (this.formType) {
            case 1:
                return "Вихідні запити";
            case 2:
                return "Вхідні запити";
            default: return "";
        }
    }
};

function initMainGrid() {    

    var dataSource = formConfig.getCurrentGridDS();
    dataSource.requestEnd = function () { bars.ui.loader("#gridMain", false); };
    dataSource = new kendo.data.DataSource(DataSourceSettings(dataSource));    
    var gridOptions = formConfig.getCurrentGridOptions();

    gridOptions.toolbar = formConfig.formType === 1
        ? kendo.template($("#outReqToolbarTemplate").html())
        : kendo.template($("#inReqToolbarTemplate").html());
    gridOptions.dataSource = dataSource;

    gridOptions = new GridSettings(gridOptions);

    $("#gridMain").kendoGrid(gridOptions);    
};

function registerButtonsEvents() {
    $("#updateGrid").click(function () {
        updateGrid();
    });

    $("#clearFilters").click(function () {
        clearFilters();
        $("form.k-filter-menu button[type='reset']").trigger("click");
    });

    $("#outReqs, #outQueue, #outTypes, #outLog, #outParams").click(function (event) {
        var type = event.currentTarget.id.substr(3).toLowerCase();

        if (type !== "types" && type !== "params") {
            var grid = $("#gridMain").data("kendoGrid");
            var guid = getSelectedValue(grid, "Id");
            if (!guid)
                return;   
        }                 
        requestsWindow(type, guid);
    });

    $("#inQueue, #inTypes, #inLog, #inResponse, #inResponseParams, #inRequestParams").click(function (event) {
        var type = event.currentTarget.id.substr(2).toLowerCase();

        if (type !== "types" && type !== "params") {
            var grid = $("#gridMain").data("kendoGrid");
            var guid = getSelectedValue(grid, "Id");
            if (!guid)
                return;
        }
        inputRequestsWindow(type, guid);
    });

    $("#clobBtn").click(function (event) {
        var grid = $("#gridMain").data("kendoGrid");
        var url = formConfig.formType === 1 ? "/api/TranspUi/TranspUi/GetMainOutClob" : "/api/TranspUi/TranspUi/GetMainInClob";
        var guid = getSelectedValue(grid, "Id");
        if (!guid)
            return;

        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: bars.config.urlContent(url),
            beforeSend: function () {
                bars.ui.loader("#gridMain", true);
            },
            data: {
                guid: guid
            },
            success: function (data) {
                if (!data) 
                    bars.ui.notify("Повідомлення", "CLOB IS EMPTY", 'info', { autoHideAfter: 5 * 1000 });
                else
                    clobWindow(data);
            },
            complete: function () {
                bars.ui.loader("#gridMain", false);
            }
        });        
    });
};

function updateGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
    }
};

function clearFilters() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) {
        var dataSource = grid.dataSource;
        dataSource.filter({});
        dataSource.sort({});
    }
};

$(document).ready(function () {
    var formType = $("#formType").val();
    formConfig.setFormType(formType);
    $("#title").html(formConfig.getTitle());
    bars.ui.loader("#gridMain", true);
    initMainGrid();
    registerButtonsEvents();
    changeGridMaxHeight();
});