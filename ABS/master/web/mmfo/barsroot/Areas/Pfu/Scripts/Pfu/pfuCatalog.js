// Constans

var STATE_CHECKED = "CHECKED";
var DEFAULT_BLOCK_TYPE = 4;

var g_isGridRecordsInited = false;
var g_isGridFilesInited = false;

var g_recordStatusData = null;

function getGridRecordsUrl(ID) {
    var arr_statenames = [];
    var v_arr_statenames = [];
    return bars.config.urlContent("/api/pfu/filesgrid/linecatalog?id=" + ID);
}

var FILES_GRID_FIELDS = {
    id: { type: "number" },
    file_name: { type: "string" },
    register_date: { type: "date" },
    payment_date: { type: "date" },
    file_lines_count: { type: "number" },
    file_count_rec: { type: "number" },
    file_sum: { type: "number" },
    file_sum_rec: { type: "number" },
    state: { type: "string" },
    rest_date: { type: "date" },
    rest: { type: "number" },
    acc: { type: "string" }
};
var FILES_GRID_HISTORY_FIELDS = {
    id: { type: "number" },
    file_name: { type: "string" },
    register_date: { type: "date" },
    payment_date: { type: "date" },
    file_lines_count: { type: "number" },
    file_count_rec: { type: "number" },
    file_sum: { type: "number" },
    file_sum_rec: { type: "number" },
    state: { type: "string" },
    rest_date: { type: "date" },
    rest: { type: "number" },
    rest_2909: { type: "number" },
    acc: { type: "string" },
    env_id: { type: "number" },
    date_env_crt: { type: "date" },
    payed_sum: { type: "number" },
    payback_sum: { type: "number" },
    pay_date: { type: "date" },
    receiver_mfo: { type: "number" },
    pfu_branch_name: { type: 'string' }
};

var FILES_GRID_COLUMNS = [

    {
        field: "id",
        title: "ID<br/>реєстру",
        width: "100px",
        filterable: {
            ui: function (element) {
                element.kendoNumericTextBox({
                    format: "n0"
                });
            }
        }
    },
    {
        field: "file_name",
        title: "Назва файлу<br/>реєстру",
        width: "150px"
    },
    {
        field: "register_date",
        title: "Дата<br>створення",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "payment_date",
        title: "Дата <br/>платіжного<br/>клендаря ПФУ",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "file_lines_count",
        title: "Кількість<br>рядків у реєстрі",
        attributes: { "class": "text-right" },
        width: "150px"
    },
    {
        field: "file_count_rec",
        title: "Кількість<br>рядків до сплати",
        attributes: { "class": "text-right" },
        width: "150px"
    },
    {
        field: "file_sum",
        title: "Cума реєстру",
        template: '#=kendo.toString(file_sum,"n")#',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },
    {
        field: "file_sum_rec",
        title: "Cума до сплати",
        template: '#=kendo.toString(file_sum_rec,"n")#',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },
    {
        field: "rest_2909",
        title: "Залишок коштів<br/>РУ на 2909",
        template: '#: GetSum(rest_2909) #',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px",
        hidden: true
    },
    {
        field: "rest",
        title: "Сума залишку",
        template: '#: GetSum(rest) #',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px",
        hidden: true
    },

    {
        field: "restdate",
        title: "Дата/час<br/>останнього<br/>запиту залишку",//"Дата/час залишку",
        width: "150px",
        template: "#: PrintRestData(restdate) #",
        hidden: true
    },
    {
        field: "state_name",
        title: "Статус",
        width: "150px"
    },
    {
        field: "acc",
        title: "ACC",
        width: "100px",
        hidden: true
    }
];

var FILES_GRID_HISTORY_COLUMNS = [
    {
        field: "env_id",
        title: "ID конверту",//"Дата/час залишку",
        width: "150px",
        filterable: {
            ui: function (element) {
                element.kendoNumericTextBox({
                    format: "n0"
                });
            }
        }
    },
    {
        field: "date_env_crt",
        title: "Дата конверту",//"Дата/час залишку",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(date_env_crt,'dd.MM.yyyy')#</div>"
    },
    {
        field: "id",
        title: "ID<br/>реєстру",
        width: "100px",
        filterable: {
            ui: function (element) {
                element.kendoNumericTextBox({
                    format: "n0"
                });
            }
        }
    },
    {
        field: "receiver_mfo",
        title: "МФО",
        width: "150px"
    },
    {
        field: "pfu_branch_name",
        title: "Найменування платника",
        width: 350
    },
    {
        field: "acc",
        title: "Рахунок <br/> одержувача",
        width: "150px"
    },
    {
        field: "file_name",
        title: "Назва файлу<br/>реєстру",
        width: "150px"
    },
    {
        field: "register_date",
        title: "Дата<br>створення",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "payment_date",
        title: "Дата <br/>платіжного<br/>клендаря ПФУ",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "file_lines_count",
        title: "Кількість<br>рядків у реєстрі",
        attributes: { "class": "text-right" },
        width: "150px"
    },
    {
        field: "file_count_rec",
        title: "Кількість<br>рядків до сплати",
        attributes: { "class": "text-right" },
        width: "150px"
    },
    {
        field: "file_sum",
        title: "Cума реєстру",
        template: '#=kendo.toString(file_sum,"n")#',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },
    {
        field: "file_sum_rec",
        title: "Cума до сплати",
        template: '#=kendo.toString(file_sum_rec,"n")#',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },
    {
        field: "rest_2909",
        title: "Залишок коштів<br/>РУ на 2909",
        template: '#: GetSum(rest_2909) #',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },
    {
        field: "rest",
        title: "Сума залишку<br/>2560 РУ",
        template: '#: GetSum(rest) #',
        format: '{0:n}',
        attributes: { "class": "money" },
        width: "150px"
    },

    {
        field: "restdate",
        title: "Дата/час<br/>останнього<br/>запиту залишку",//"Дата/час залишку",
        width: "150px",
        template: "#: PrintRestData(restdate) #"
    },
    {

        field: "pay_date",
        title: "Дата/час<br/>фактичної<br/>оплати",//"Дата/час залишку",
        width: "150px",
        template: "#: PrintRestData(pay_date) #"
    },
    {
        field: "payed_sum",
        title: "Сума<br/>фактична<br/>зарахування на<br/>рахунки пенсіонерів",//"Дата/час залишку",
        width: "150px"
    },
    {
        field: "payback_sum",
        title: "Сума фактична<br/>повернення в ПФУ",
        width: "150px"
    },
    {
        field: "state_name",
        title: "Статус",
        width: 250
    }

];

var drop_el = "";
var fileType = '';

GetSum = function (sum) {
    if (sum == null) {
        return "";
    }
    else
        return kendo.toString(sum, "n");
};

var g_dropDownData = null;        // global variable: list for all block types
var selectedRow = null;
var tabStrip = null;
var tabstripConverts = null;
var gridFiles = null;
var arr_statenames = [];
var v_arr_statenames = [];

function getStatusById(state) {
    var namestate = getNameById(state, g_recordStatusData, 'STATE', 'STATE_NAME');
    fillStatesName(namestate, state);
    return namestate;
}

function fillStatesName(state, svalue) {
    //  
    flag = true;
    if (v_arr_statenames.length === 0) {
        v_arr_statenames.push(svalue)
        arr_statenames.push({
            name: state,
            value: svalue
        });
    }
    for (var i = 0; i < arr_statenames.length; i++) {
        if (v_arr_statenames[i] === svalue)
            flag = false;
    }
    if (flag) {
        arr_statenames.push({
            name: state,
            value: svalue
        });
        v_arr_statenames.push(svalue);
    }
}
// население грида с строками реестра
function getLineData(FileId) {
    Waiting(true);

    $('#lineFileId').html(" №" + FileId);
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: getGridRecordsUrl(FileId)
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    full_name: { type: "string" },
                    numident: { type: "string" },
                    payment_date: { type: "date" },
                    date_enr: { type: "string" },
                    date_income: { type: "date" },
                    num_acc: { type: "string" },
                    mfo: { type: "string" },
                    sum_pay: { type: "number" },
                    Ref: { type: "number" },
                    state: { type: "string" },
                    state_name: { type: "string" },
                    err_mess_trace: { type: "string" }
                }
            }
        }
    });

    var type = bars.extension.getParamFromUrl('type');
    var settings = {
        autoBind: true,
        resizable: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        excel: {
            allPages: true,
            fileName: "Інформаційні рядки реєстру.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        //excel: {
        //    allPages: true,
        //    proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        //},
        //excel: {
        //    fileName: "Northwind Product List.xlsx",
        //    allPages: true,
        //    filterable: true
        //},
        //excelExport: function (e) {
        //    var sheet = e.workbook.sheets[0];
        //    var header = sheet.rows[0];
        //    for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
        //        var headerColl = header.cells[headerCellIndex];
        //        headerColl.value = headerColl.value.replace(/<br>/g, ' ');
        //    }
        //},
        toolbar: ["excel",
            {
                template: kendo.template($("#lineTitle-template").html())
            }
        ],
        columns: [
            {
                field: "id",
                title: "ID інформаційного рядка",
                width: 90,
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "full_name",
                title: "ПІБ отримувача",
                width: 150,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "numident",
                title: "ІПН",
                width: 100
            },
            {
                field: "payment_date",
                title: "Дата зарахування",
                width: 125,
                template: "<div style='text-align:center;'>#= payment_date ? kendo.toString(payment_date,'dd.MM.yyyy') : '' #</div>"
            },
            {
                field: "num_acc",
                title: "Номер рахунку",
                width: 150
            },
            {
                field: "mfo",
                title: "Код МФО",
                width: 100
            },
            {
                field: "sum_pay",
                title: "Сума",
                template: '#= sum_pay ? kendo.toString(sum_pay,"n") : "" #',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: "5%"
            },
            {
                field: "state",
                title: "Статус",
                width: 250,
                hidden: true,
                filterable: {
                    extra: false
                    //ui: function (element) {
                    //    var _grid = $("#gridRecords").data("kendoGrid")
                    //    var filterMenu = _grid.thead.find("th:not(.k-hierarchy-cell,.k-group-cell):last").data("kendoFilterMenu");
                    //    $("div.k-filter-help-text").css("display", "none");
                    //    filterMenu.form.find("span.k-dropdown:first").css("display", "none");
                    //    $("span.k-widget k-dropdown k-header").css("display", "none");
                    //    drop_el = element
                    //    //element.kendoDropDownList({
                    //    //    dataSource: new kendo.data.DataSource({
                    //    //        data: arr_statenames
                    //    //    }),
                    //    //    dataTextField: "name",
                    //    //    dataValueField: "value",
                    //    //    open: function (e) {
                    //    //        //  
                    //    //        var objData = e.sender.dataSource._data;
                    //    //        objData = arr_statenames;
                    //    //        e.sender.dataSource.read();
                    //    //    },
                    //    //    dataBound: function (e) {
                    //    //    }
                    //    //});
                    //    return 1;
                    //}
                },
                template: '#= getStatusById(state) #',
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },

            {
                field: "state_name",
                title: "Статус",
                width: 300,
                filterable: {
                    extra: false,
                    ui: StateFilter
                }
            },
            {
                field: "err_mess_trace",
                title: "Опис помилки",
                width: 300

            }
        ],
        dataBound: function () {
            Waiting(false);
            v_arr_statenames = [];
            arr_statenames = [];
            if (type !== "envelop") {
                $("#removeFromPayBtn").show();
            }
            grid = this;
            data = grid._data;
            var state = "";
            var namestate = "";
            for (var i = 0; i < data.length; i++) {

                state = data[i].state;
                namestate = getNameById(state, g_recordStatusData, 'STATE', 'STATE_NAME');
                flag = true;
                if (v_arr_statenames.length === 0) {
                    v_arr_statenames.push(state);
                    arr_statenames.push({
                        name: namestate,
                        value: state
                    });
                }
                for (var j = 0; j < v_arr_statenames.length; j++) {
                    if (v_arr_statenames[j] === state)
                        flag = false;
                }
                if (flag) {
                    arr_statenames.push({
                        name: namestate,
                        value: state
                    });
                    v_arr_statenames.push(state);
                }
            }
        },
        dataSource: dataSource,
        filterable: true
    };

    if (type !== "envelop") {
        settings.columns.unshift({
            field: "block",
            title: " ",
            filterable: false,
            sortable: false,
            template: "<input type='checkbox' class='checkbox' style='margin-left: 26%;' />",
            width: 30
        });
    }

    $("#gridRecords").kendoGrid(settings);
}
var StateDrop = 0
var selectedline = 0
function StateFilter(element) {

    StateDrop = element;
    var gview = $("#gridFiles").data("kendoGrid");
    selectedline = gview.dataItem(gview.select());
    console.log("rl", StateDrop);

    element.kendoDropDownList({
        dataSource: {
            transport: {
                async: false,
                read: {
                    url: bars.config.urlContent("/api/pfu/filesgrid/GetStatesFromLine"),
                    data: function () {
                        return { id: selectedline.id }
                    }
                }
            },

            schema: { data: "Data", model: { fields: { state: { type: "number" }, state_name: { type: "string" } } } }
        },
        dataTextField: "state_name", dataValueField: "state_name", open: onOpenStateFilter,
        filter: "contains"
    });

}

function onOpenStateFilter() {

    console.log(">>>");
    var gview = $("#gridFiles").data("kendoGrid");
    selectedline = gview.dataItem(gview.select());
    console.log("el", StateDrop);
    StateDrop.data("kendoDropDownList").dataSource.read();

}
var filterFilesGrid = null;
// население грида с реестрами
function initFilesGrid(qv) {

    //  
    filterFilesGrid = qv;
    var dataSource = new kendo.data.DataSource({
        type: "webapi",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        sort: [
            { field: "id", dir: "desc" }
        ],
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/searchcatalog"),
                data: function () { return filterFilesGrid; }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: FILES_GRID_FIELDS }
        }
    });
    var settings = {
        autoBind: true,
        resizable: true,
        selectable: "multiple",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        excel: {
            allPages: true,
            fileName: "Перелік реєстрів.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        toolbar: ["excel",
            {
                template: kendo.template($("#fileTitle-template").html())
            }
        ],
        change: function (e) {
            goToLines(false);
             
            $("#gridRecords").data("kendoGrid").dataSource.read();
        },
        columns: FILES_GRID_COLUMNS,
        dataBound: function (e) {
            Waiting(false);
            var grid = this;
            $("#payFileBtn").hide();
            $('#balanceReq').hide();
            $("#payCommonBtn").hide();
            $("#payBtn").hide();
            var state = NullOrValue($("#searchState").val());
            if (state == STATE_CHECKED) {
                //$("#payCommonBtn").show();
                $("#payBtn").show();
            }
            else if (state == "CHECKING_PAY") {
                $("#payFileBtn").show();
            }
        },
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: dataSource,
        filterable: true
    };
    gridFiles = $("#gridFiles").kendoGrid(settings);
}


function initFiles(qv) {
    //  
    filterFilesGrid = qv;
    var dataSource = new kendo.data.DataSource({
        type: "webapi",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        sort: [
            { field: "id", dir: "desc" }
        ],
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/searchcatalog"),
                data: function () { return filterFilesGrid; }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: FILES_GRID_HISTORY_FIELDS }
        }
    });
    var settings = {
        autoBind: true,
        resizable: true,
        selectable: "multiple",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        excel: {
            allPages: true,
            fileName: "Перелік реєстрів.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        toolbar: ["excel",
            {
                template: kendo.template($("#fileTitle-template").html())
            }
        ],
        change: function (e) {
            goToLines(false);
            grid = this;
            var info = [];
            selected = grid.dataItem(grid.select());
            debugger;
            if (selected.file_sum_rec > selected.rest_2909 && selected.state == "CHECKING_PAY") {
                info.push("Виконати оплату реєстра неможливо. Залишоку коштів на 2909 недостатньо для здійснення операції.");
                AlertNotifyError(info);
                $("#payFileBtn").show();
                $("#payFileBtn").prop("disabled", true);
            }
            else if (selected.file_sum_rec <= selected.rest_2909 && selected.state == "CHECKING_PAY") {
                $("#payFileBtn").prop("disabled", false);
            }
            $("#gridRecords").data("kendoGrid").dataSource.read();
        },
        columns: FILES_GRID_HISTORY_COLUMNS,
        dataBound: function (e) {
            Waiting(false);
            var grid = this;
            $("#payFileBtn").hide();
            $('#balanceReq').hide();
            $("#payCommonBtn").hide();
            $("#payBtn").hide();
            var state = NullOrValue($("#searchState").val());
            if (state == STATE_CHECKED) {
                //$("#payCommonBtn").show();
                $("#payBtn").show();
            }
            else if (state == "CHECKING_PAY")
                $("#payFileBtn").show();
        },
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: dataSource,
        filterable: true
    };
    gridFiles = $("#gridFiles").kendoGrid(settings);
}

function getSearchData(qv) {

    filterFilesGrid = qv;
    var grid = $("#gridFiles").data("kendoGrid");
    if (grid)
        grid.dataSource.fetch();
}

function getRecordStatus() {
    if (g_recordStatusData == null) {
        var dataSource = CreateKendoDataSource({
            transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/recordstatus") } },
            schema: { model: { fields: { STATE: { type: "number" }, STATE_NAME: { type: "string" } } } }
        });
        dataSource.fetch(function () {
            g_recordStatusData = this.data();
        });
    }
}

function onDataBound(e) {
    //e.sender.dataSource.add({ "state_name": "Joe", "state": "Joe" });

    $("#searchState").getKendoDropDownList().dataSource.insert({
        state_name: "John",
        state: "John"
    })

}

function getFileStatus() {
    fillDropDownList("#searchState", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/pfufilestatus") } },
        schema: { model: { fields: { state: { type: "string" }, state_name: { type: "string" } } } }
    }, {
            dataBound: function () {
                var dataSource = this.dataSource;
                var data = dataSource.data();

                if (!this._adding) {
                    this._adding = true;

                    data.splice(0, 0, {
                        "state": "null",
                        "state_name": "Всі"
                    });

                    this._adding = false;
                    var dropdownlist = this;
                    dropdownlist.value("null");
                }

            },
            //value: "null",
            dataTextField: "state_name",
            dataValueField: "state"
        });
    //  
    fillDropDownList("#searchFileType", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/GetFileTypes") } },
        schema: { model: { fields: { Id: { type: "string" }, Name: { type: "string" } } } }
    },
        {
            dataBound: function () {
                var dataSource = this.dataSource;
                var data = dataSource.data();

                var dropdownlist = this;
                dropdownlist.value(data[0].Id);
            },
            dataTextField: "Name",
            dataValueField: "Id"
        });
}

function getEnvelopState() {
    fillDropDownList("#searchStateEnvelop", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/pfuenvelopstate") } },
        schema: { model: { fields: { Id: { type: "string" }, Name: { type: "string" } } } }
    }, {
            value: STATE_CHECKED,
            dataTextField: "Name",
            dataValueField: "Id"
        });
}

// делаем кнопку "Запит залишку в РУ" disabled или abled
function CheckBalancePaymentBtn(selectedCatalog) {
    //  
    var info = [];
    info.push();
    var now = new Date();

    var restdate = kendo.parseDate(selectedCatalog.restdate, 'yyyy-MM-dd');
    var diff = (now - restdate) / 1000;
    debugger;
    if (selectedCatalog.state_name === "Очікує оплати") {
        $('#payFileBtn').show();
    }
    else
        $('#payFileBtn').hide();

    if (selectedCatalog.state_name === "Перевірено") {
        //  
        $('#balanceReq').show();
        $('#payCommonBtn').show();
        if (selectedCatalog.file_sum_rec === 0) {
            info.push("Запит залишку неможливий. Сума до сплати = 0");
            info.push("Створити загальний платіж неможливо. Сума до сплати = 0");
            $('#balanceReq').prop("disabled", true);
            $('#payCommonBtn').prop("disabled", true);
        }
        if (selectedCatalog.file_sum_rec > 0 && selectedCatalog.rest === null && diff < 3600) {//diff> 3600 $('#balanceReq').prop("disabled", false);
            info.push("Повторний запит залишку неможливий. Запит залишку вже відправлено в РУ, очікуйте появи залишку.");
            info.push("Створити загальний платіж неможливо.  Залишок по рахунку 2560 відсутній");
            $('#balanceReq').prop("disabled", true);
            $('#payCommonBtn').prop("disabled", true);
        }
        if (selectedCatalog.file_sum_rec > 0 && selectedCatalog.rest < selectedCatalog.file_sum_rec && diff < 3600) {

            info.push("Створити загальний платіж неможливо.  Залишок по рахунку 2560 не достатній для оплати");
            $('#balanceReq').prop("disabled", false);
            $('#payCommonBtn').prop("disabled", true);
        }
        if (selectedCatalog.file_sum_rec > 0 && selectedCatalog.rest === null && (selectedCatalog.restdate === null || diff > 3600)) {
            info.push("Створити загальний платіж неможливо.  Залишок по рахунку 2560 відсутній!!");
            $('#balanceReq').prop("disabled", false);
            $('#payCommonBtn').prop("disabled", true);
        }
        if (selectedCatalog.file_sum_rec > 0 && diff > 3600) {
            info.push("Створити загальний платіж неможливо.  Залишок по рахунку 2560 відсутній!!!");
            $('#balanceReq').prop("disabled", false);
            $('#payCommonBtn').prop("disabled", true);
        }
        if (selectedCatalog.file_sum_rec > 0 && selectedCatalog.rest >= selectedCatalog.file_sum_rec && diff < 3600) {
            info.push("Повторний запит залишку неможливий. Залишок на 2560 є актуальним.");
            $('#balanceReq').prop("disabled", true);
            $('#payCommonBtn').prop("disabled", false);

        }
        var type = bars.extension.getParamFromUrl('type');
        if (type == "envelop") {
            $('#balanceReq').hide();
            $('#payCommonBtn').hide();
        }

    }
    else {
        $('#balanceReq').hide();
        $('#payCommonBtn').hide();
    }
    AlertNotifyError(info);
}
AlertNotifyError = function (info) {
    var configurable = $("#popupNotification").kendoNotification().data("kendoNotification");
    var popupNotification = $("#popupNotification").kendoNotification({
        position: {
            top: 10,
            right: 150
        }
    }).data("kendoNotification");
    popupNotification.setOptions({
        stacking: "down",
        autoHideAfter: 3000
    });
    popupNotification.hide();
    var d = new Date();
    for (var i = 0; i < info.length; i++) {
        popupNotification.show(kendo.toString(info[i]), "error");
    }
}
PrintData = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd'), 'dd.MM.yyyy')

};
PrintRestData = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd HH:mm:ss'), 'dd/MM/yyyy  HH:mm:ss')

};

// детализация реестра
function goToLines(needSwitchTab) {
    //  
    grid = $("#gridRecords");

    if (grid.data("kendoGrid"))
        $("#gridRecords").data("kendoGrid").dataSource.filter([]);
    var gview = $("#gridFiles").data("kendoGrid");
    var selectedCatalog = gview.dataItem(gview.select());
    if (selectedCatalog !== null) {
        CheckBalancePaymentBtn(selectedCatalog);
        if (!g_isGridRecordsInited) {
            g_isGridRecordsInited = true;
            getLineData(selectedCatalog.id);
        }
        else {
            getGridRecordsUrl(selectedCatalog.id);
            $('#gridRecords').data('kendoGrid').dataSource.transport.options.read.url = getGridRecordsUrl(selectedCatalog.id);

            // export to Excel use this url! Hmmm....
            $('#gridRecords').data('kendoGrid').dataSource.options.transport.read.url = getGridRecordsUrl(selectedCatalog.id);
            $('#gridRecords').data('kendoGrid').dataSource.page(1);
        }

        if (needSwitchTab)
            switchTab(1);   // todo: why?

    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}

function payFile() {
    var gview = $("#gridFiles").data("kendoGrid");
    var selectedCatalog = gview.dataItem(gview.select());
    if (selectedCatalog !== null) {
        AJAX({
            srcSettings: {
                url: bars.config.urlContent("/api/pfu/filesgrid/readyforsign?id=" + selectedCatalog.id),
                success: function (data) {
                    bars.ui.notify("Зміна статусу", "Файл №" + selectedCatalog.id + " успішно помічено до оплати", 'success');
                    gview.dataSource.read();
                }
            }
        });
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}

function onRemoveFromPayBtn() {
    openGridWindow({
        srcGridID: "#gridRecords",
        windowGridID: "#gridRemoveFromPay",
        windowID: "#dialogRemoveFromPay",
        grabData: [
            { key: 'block_type', defaultValue: DEFAULT_BLOCK_TYPE },
            { key: 'id', defaultValue: null },
            { key: 'full_name', defaultValue: null }],
        srcDataSource: {
            schema: {
                model: {
                    fields: {
                        id: { type: "number" },
                        full_name: { type: "string", editable: false },
                        comment: { type: "string", editable: true },
                        block_type: { type: "number", editable: true }
                    }
                }
            }
        },
        srcSettings: {
            columns: [
                {
                    field: "full_name",
                    title: "ПІБ Клієнта",
                    width: 220,
                    attributes: {
                        style: "text-overflow: ellipsis; white-space: nowrap;"
                    }
                },
                {
                    field: "comment",
                    title: "Коментар"
                },
                {
                    field: "block_type",
                    title: "Тип блокування",
                    editor: renderDropDown,
                    template: "#= getBlockName(block_type) #"
                }
            ]
        }
    });
}

function confirmRemoveFromPayBtn() {
    confirmGridWindow({
        windowGridID: "#gridRemoveFromPay",
        windowID: '#dialogRemoveFromPay',
        srcGridID: '#gridRecords',
        srcSettings: { url: bars.config.urlContent("/api/pfu/filesgrid/removefrompaypensioner") },
        grabData: [{ key: "id" }, { key: "comment" }, { key: "block_type" }],
        successFunc: function () {
            getSearchData(filterFilesGrid);     // update main grid
        }
    });
}

function getBlockName(value) {
    return getNameById(value, g_dropDownData, 'block_type', 'BlockName');
}

// get list for all block types (dropdown 'Тип блокування')
function GetDropDownData() {
    if (g_dropDownData == null) {
        var dataSource = CreateKendoDataSource({
            transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/blocktypes") } },
            schema: { model: { fields: { block_type: { type: "number" }, BlockName: { type: "string" } } } }
        });
        dataSource.fetch(function () {
            g_dropDownData = this.data();
        });
    }
}

// (fill data for dropdown 'Тип блокування')
function renderDropDown(container, options) {
    $('<input required  name="' + options.field + '"/>')
        .appendTo(container)
        .kendoDropDownList({
            dataTextField: "BlockName",
            dataValueField: "block_type",
            dataSource: { data: g_dropDownData }
        });
}
openPayWindowdow = function () {
    var gview = $("#gridFiles").data("kendoGrid");
    selectedRow = gview.dataItem(gview.select());
    if (selectedRow !== null) {
        if (selectedRow.state === STATE_CHECKED) {
            kendo.ui.progress($("#gridFiles"), true);
            AJAX({
                srcSettings: {
                    url: bars.config.urlContent("/api/pfu/filesgrid/VerifyFile?id=" + selectedRow.id),
                    success: function (data) {
                        kendo.ui.progress($("#gridFiles"), false);
                        showDocInputWindow(data);
                    }
                }
            });
        }
        else
            bars.ui.error({ title: 'Помилка!', text: 'Недопустимий статус реєстру!' });
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}
// оплата на общую сумму реестра (кнопка "Створити загальний платіж")
function payCommon() {

    bars.ui.alert({
        text: "До проведення оплати необхідно здійснити відправлення Квитанції 1 в ПФУ.<br />" +
            "Відправлення Квитанції 1 здійснюється в функції \"Підтвердження відправлення даних в ПФУ\".", title: "Увага!"
    }, openPayWindowdow);

}

// окно оплаты на общую сумму реестра
function showDocInputWindow(data) {
    data.Sum = data.Sum || 0;
    if (data.Sum === 0) {
        bars.ui.error({ title: 'Помилка', text: 'Сума для оплати - нульова, створення платежу неможливе!' });
        return;
    }
    data.Narrative = data.Narrative.replace('{0}', selectedRow.id);
    bars.ui.dialog({
        title: "Створення платежу на загальну суму по реєстру №" + selectedRow.id,
        content: {
            url: bars.config.urlContent('/docinput/docinput.aspx?tt=' + data.OpCode + "&Id_A=" + data.RecipientCustCode + "&Nls_A=" + data.RecipientAccNum + "&Kv_A=980&Nam_A=" + data.RecipientName + "&Id_B=" + data.SenderCustCode + "&Nls_B=" + data.SenderAccNum + "&Kv_B=980&Nam_B=" + data.SenderName + "&Mfo_B=" + data.SenderBankId + "&SumC_t=" + data.Sum + "&Nazn=" + data.Narrative)
        },
        iframe: true,
        width: '650px',
        height: '600px',
        buttons: [{
            text: 'Закрити',
            click: function () {
                var win = this;
                var windowElement = $("#barsUiAlertDialog");
                var iframeDomElement = windowElement.children("iframe")[0];
                var iframeWindowObject = iframeDomElement.contentWindow;
                var iframeDocumentObject = iframeDomElement.contentDocument;
                var ref = iframeDocumentObject.getElementById("OutRef").value;
                // если оптата прошла успешно (в окне оплаты получили ref) - меняем статус файла
                if (ref) {
                    AJAX({
                        srcSettings: {
                            url: bars.config.urlContent("/api/pfu/filesgrid/SetCheckingPayStatus?id=" + selectedRow.id + '&docref=' + ref),
                            success: function (data) {
                                $("#gridFiles").data("kendoGrid").dataSource.read();
                                win.close();
                            }
                        }
                    });
                }
                else {
                    bars.ui.confirm({ text: 'Документ не оплачено, закрити вікно ?' },
                        function () { win.close(); });
                }
            }
        }]
    });
    $(".k-widget").find(".k-window-action").css("visibility", "hidden");
}

function goToCatalogs() {

    var qv = {};
    //  
    var catalogDate = $("#searchDate").data("kendoDatePicker").value();
    var PayDate = $("#searchPayDate").data("kendoDatePicker").value();

    qv.CatalogDate = kendo.toString(catalogDate, "MM.dd.yyyy");
    qv.IdCatalog = NullOrValue($("#searchId").val());
    qv.Mfo = NullOrValue($("#searchMfo").val());
    qv.State = NullOrValue($("#searchState").val());
    qv.PayDate = kendo.toString(PayDate, "MM.dd.yyyy");
    qv.EnvelopeId = null;
    qv.fileType = NullOrValue($("#searchFileType").val());

    getSearchData(qv);
    tabStrip.select(0);
}

function switchTab(index) {

    tabStrip.select(index);
}

//**************************
//Sent cnverts grid 
//**************************

function initSentConvertsgrid() {

    //filterSentConvertsgrid = qv;
    $("#SentConvertsgrid").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/filesgrid/GetSentConvert")
                    //data: function () {
                    //    return filterSentConvertsgrid;
                    //}
                }
            },
            schema: {
                data: "Data", total: "Total",
                model: {
                    fields: {
                        ID: { type: "number" },
                        PFU_ENVELOP_ID: { type: "number" },
                        REGISTER_DATE: { type: "date" },
                        CRT_DATE: { type: "date" },
                        SENT_DATE: { type: "date" },
                        REG_CNT: { type: "number" },
                        CHECK_SUM: { type: "number" },
                        STATE_NAME: { type: "string" }
                    }
                }
            }
        },
        toolbar: kendo.template($("#sentconvert-template").html()),
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function () {
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            grid.select("tr:eq(1)");
        },
        change: function () {
            if (selectedSentConvertRow())
                getSearchData({ EnvelopeId: selectedSentConvertRow().ID, State: null, IdCatalog: null, Mfo: null, CatalogDate: null, PayDate: null, fileType: null });
        },

        columns: [
            {
                field: "ID",
                title: "ID запиту"
            },
            {
                field: "PFU_ENVELOP_ID",
                title: " ID конверту",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "REGISTER_DATE",
                title: " Дата отримання",
                template: "#: PrintData(REGISTER_DATE) #"
            },
            {
                field: "CRT_DATE",
                title: " Дата створення",
                template: "#: PrintData(CRT_DATE) #"
            },
            {
                field: "SENT_DATE",
                title: "Дата відправки в ПФУ",
                template: "#: PrintData(SENT_DATE) #"
            },
            {
                field: "REG_CNT",
                title: "Кількість реєстрів"
            },
            {
                field: "CHECK_SUM",
                title: "Загальна сума"
            },
            {
                field: "STATE_NAME",
                title: "Статус конверту"
            }
        ]
    });
}
//**************************
//Envelop logic
//**************************

function RemoveSharp(name) {
    if (name)
        return name.replace("#", '');
}
var selectedEnvelopeRow = function () {

    var grid = $('#gridEnvelope').data("kendoGrid");
    if (grid)
        return grid.dataItem(grid.select());
};
var selectedSentConvertRow = function () {

    var grid = $('#SentConvertsgrid').data("kendoGrid");
    if (grid)
        return grid.dataItem(grid.select());
};


var filterEnvelopesGrid = null;
function getEnvelopeData(qv) {
    filterEnvelopesGrid = qv;
    $("#gridEnvelope").data("kendoGrid").dataSource.fetch();
}

function initEnvelopGrid(qv) {
    filterEnvelopesGrid = qv;
    var searchDataSource = new kendo.data.DataSource({
        type: "webapi",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        sort: [
            { field: "id", dir: "desc" }
        ],
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/searchenvelop"),
                data: function () { return filterEnvelopesGrid; }
            }
        },
        schema: {
            total: "Total", data: "Data",
            model: {
                fields: {
                    id: { type: "number" },
                    name: { type: "string" },
                    date_insert: { type: "date" },
                    count_files: { type: "number" },
                    sum: { type: "number" },
                    state_name: { type: "string" },
                    username: { type: "string" }
                }
            }
        }
    });

    var searchSettings = {
        autoBind: true,
        resizable: true,
        selectable: "multiple",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        toolbar: kendo.template($("#envelopeTitle-template").html()),
        columns: [
            {
                field: "id",
                title: "ID запиту",
                width: 90
            },
            {
                field: "name",
                title: "ID конверту",
                width: 90,
                template: "#=RemoveSharp(name)#",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "date_insert",
                title: "Дата<br>створення",
                width: 110,
                template: "<div style='text-align:center;'>#=kendo.toString(date_insert,'dd.MM.yyyy')#</div>"
            },
            {
                field: "count_files",
                title: "Кількість<br>реєстрів",
                width: 100
            },
            {
                field: "sum",
                title: "Загальна сума",
                template: '#=kendo.toString(sum,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" },
                width: 150
            },
            {
                field: "username",
                title: "Відповідальний<br>виконавець",
                width: "10%",
                hidden: true
            },
            {
                field: "state_name",
                title: "Статус<br/>конверту",
                width: "10%"
            }
            // ,{
            //     field: "state_name",
            //     title: "Статус",
            //     width: 90
            // }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        change: function () {
            if (selectedEnvelopeRow())
                getSearchData({ EnvelopeId: selectedEnvelopeRow().id, State: null, IdCatalog: null, Mfo: null, CatalogDate: null, PayDate: null, fileType: null });
            //else
            //    $('#gridCatalog').empty();
        },
        // dataBinding: searchStates,
        dataBound: function () {
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            grid.select("tr:eq(1)");

            if (selectedEnvelopeRow()) {
                if (!g_isGridFilesInited) {
                    Waiting(true);
                    g_isGridFilesInited = true;
                    initFilesGrid({ State: null, IdCatalog: null, Mfo: null, CatalogDate: null, EnvelopeId: selectedEnvelopeRow().id, PayDate: null, fileType: null });
                }
                else {
                    //getSearchData({ State: null, IdCatalog: null, Mfo: null, CatalogDate: null, EnvelopeId: selectedEnvelopeRow().id });
                }
            }
            else {
                $("#gridFiles").empty();
            }

            kendo.resize(grid.element);
        },
        dataSource: searchDataSource,
        filterable: true
    };

    $("#gridEnvelope").kendoGrid(searchSettings);
}

// get all signID keys from BarsCryptor (used only first elem in keyResponse.Keys !!!)
function approveMatching() {
    //$('#approveMatching').prop("disabled", true);
    debugger;
    var tabStrip = $(".k-state-active");
    var namegrid = "";
    if (tabStrip[0].innerText === "Перелік конвертів ПФУ")
        namegrid = "#gridEnvelope"
    else
        namegrid = "#SentConvertsgrid"
    $('#approveMatching').attr("disabled", "disabled");
    $('#approveMatchingConvert').attr("disabled", "disabled");

    var gview = $(namegrid).data("kendoGrid");
    var selectedEnvelope = gview.dataItem(gview.select());
    selected_ids = []
    for (var i = 0; i < gview.select().length; i++) {
        id = (gview.dataItem(gview.select()[i])).id
        selected_ids.push(id);
    }
    if (selectedEnvelope === null) {
        $('#approveMatching').removeAttr("disabled");
        $('#approveMatchingConvert').removeAttr("disabled");
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реєстр!' });
        return;
    }
    initSign(selected_ids, 1, namegrid);


}

function searchEnvelop() {
    var qv = {};

    var creatingDate = $("#searchDateEnvelop").data("kendoDatePicker").value();
    qv.CreatingDate = kendo.toString(creatingDate, "MM.dd.yyyy");
    qv.Id = NullOrValue($("#searchIdEnvelop").val());
    qv.State = NullOrValue($("#searchStateEnvelop").val());
    getEnvelopeData(qv);
}
//**************************
//End Envelop logic
//**************************
function initHistoryGrid() {
    fillKendoGrid("#gridHistory", {
        type: "webapi",
        sort: [{ field: "id", dir: "desc" }],
        transport: { read: { url: bars.config.urlContent("/api/pfu/filesgrid/searchcataloghistory") } },
        schema: { model: { fields: FILES_GRID_HISTORY_FIELDS } }
    }, {
            columns: FILES_GRID_HISTORY_COLUMNS
        }, "#historyTitle-template");
}

function LoadRegExel() {

    var grid = $("#gridFiles").data("kendoGrid");
    grid.saveAsExcel();
}



function LoadInfExel(e) {


    //id: { type: "number" },
    //full_name: { type: "string" },
    //numident: { type: "string" },
    //payment_date: { type: "date" },
    //date_enr: { type: "string" },
    //date_income: { type: "date" },
    //num_acc: { type: "string" },
    //mfo: { type: "string" },
    //sum_pay: { type: "number" },
    //Ref: { type: "number" },
    //state: { type: "string" }
    var grid = $("#gridRecords").getKendoGrid();
    var rows = [{
        cells: [
            { value: "ID" },
            { value: "ПіБ отримувача" },
            { value: "ІПн" },
            { value: "Дата зарахування" },
            { value: "Номер рахунку" },
            { value: "Код МФО" },
            { value: "Сума" },
            { value: "Статус" }
        ]
    }];
    var trs = $("#gridRecords").find('tr');
    for (var i = 0; i < trs.length; i++) {

        var dataItem = grid.dataItem(trs[i]);
        rows.push({
            cells: [
                { value: dataItem.id },
                { value: dataItem.full_name },
                { value: dataItem.numident },
                { value: dataItem.date_enr },
                { value: dataItem.num_acc },
                { value: dataItem.mfo },
                { value: dataItem.sum_pay },
                { value: getStatusById(dataItem.state) }
            ]
        })

    }
    excelExport(rows);
    // 

}
function excelExport(rows) {

    var workbook = new kendo.ooxml.Workbook({
        sheets: [
            {
                columns: [
                    { autoWidth: '150px' },
                    { autoWidth: '150px' }
                ],
                title: "Інформаційні рядки реєстру",
                rows: rows
            }
        ]
    });
    $("#gridRecords").getKendoGrid().saveAsExcel();
    kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Інформаційні рядки реєстру.xlsx" });

}

function BalanceRequest() {
    //  

    var grid = $('#gridFiles').data("kendoGrid");
    if (grid) {
        debugger;
        rows = grid.select();
        var selected = []

        $.each(rows, function (index, row) {
            var selectedItem = grid.dataItem(row);
            selected.push(selectedItem);
        })
        /*if (selected.file_sum_rec === 0) {
            bars.ui.error({ title: 'Сумма до сплати!', text: "Проведення запиту залишку в РУ неможливе, так як сума реєстру до сплати 0!" });
        }*/
        debugger;
        for (var i = 0; i < selected.length; i++) {
            debugger;
            Waiting(true);
            AJAX({
                srcSettings: {
                    async: false,
                    url: bars.config.urlContent("/api/pfu/filesgrid/BalanceRequest?acc=" + selected[i].acc + '&id=' + selected[i].id + '&p_kf=' + selected[i].receiver_mfo),
                    complete: function () {
                        Waiting(false);
                    },
                    success: function (data) {
                    }
                }
            });
            $("#gridFiles").data("kendoGrid").dataSource.read();
        }
    }
}

$(document).ready(function () {
    GetDropDownData();


    var type = bars.extension.getParamFromUrl('type');

    // init tabs
    tabStrip = $("#tabstrip").kendoTabStrip({
        animation: false
    }).data("kendoTabStrip").select(0);

    tabstripConverts = $("#tabstripConverts").kendoTabStrip({
        animation: false
    }).data("kendoTabStrip").select(0);

    getRecordStatus();

    if (type === "envelop") {

        $('#ttab3').hide();
        $('#tab3').hide();

        tabStrip.disable(tabStrip.tabGroup.children().eq(2));   // hide 'history' tab for envelop page
        $("#dialogRemoveFromPay").hide();
        $("#title").html("Підтвердження відправки даних в ПФУ");
        $("#dvEnvelop").show();
        // $("#searchDateEnvelop").kendoDatePicker({ format: "dd.MM.yyyy" });
        $("#dvFilesFilter").hide();
        // getEnvelopState();
        initEnvelopGrid({ State: "PARSED", CreatingDate: null, Id: null });

        initSentConvertsgrid();

        $('#SelectFiles').click(function () {
            var value = $('#ddlViewBy').val();
            window.location.href = GetKvitHref(value);
        });

        $("#ddlViewBy").change(function () {

            var value = $('#ddlViewBy').val();
            window.location.href = GetKvitHref(value);

        });
    }
    else {

        initHistoryGrid();

        $('#selectReceipt').hide();
        $('#ttab3').hide();
        $('#tab3').hide();

        $("#title").html("Перегляд та оплата реєстрів ПФУ");
        getFileStatus();
        //$("#searchState").data("kendoDropDownList").dataSource.add({ "state": "new Item", "state_name": 1000 });
        initFiles({ State: null, IdCatalog: null, Mfo: null, CatalogDate: null, EnvelopeId: null, PayDate: null, fileType: null });
        $("#searchDate").kendoDatePicker({ format: "dd.MM.yyyy" });
        $("#searchPayDate").kendoDatePicker({ format: "dd.MM.yyyy" });
        $('#SearchFiles').click(goToCatalogs);

        InitGridWindow({ windowID: "#dialogRemoveFromPay", srcSettings: { title: "Виключення з платежу" } });
        //  

        $('body').on('click', '#balanceReq', BalanceRequest);

        $('body').on('click', '#LoadInfExelBtn', LoadInfExel);
        $('body').on('click', '#LoadRegExelBtn', LoadRegExel);
        $('body').on('click', '#confirmBlock', confirmRemoveFromPayBtn);
        $('body').on('click', '#payFileBtn', payFile);
        $('body').on('click', '#payCommonBtn', payCommon);
        $('body').on('click', '#removeFromPayBtn', onRemoveFromPayBtn);


        $("#LoadInfExelBtn").on('click', function (e) {

            var grid = $("#gridRecords").data("kendoGrid");
            grid.saveAsExcel();
        });

        $('textarea').keyup(function (e) {
            if (e.keyCode == 13) {
                goToCatalogs();
            }
        });

        //debugger;
        //fileType = bars.extension.getParamFromUrl('fileType', window.location.href);

        $("#searchState, #searchMfo, #searchId, #searchDate, #searchPayDate, #searchFileType").change(function () {
            goToCatalogs();
        });
    }
});
