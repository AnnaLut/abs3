var isUnpaidGridInit = false;
//var g_isGridRecordsInited = false;
var filterArchivesGrid = null;
var selectedIds = [];
var lastActiveTab = 0;
var tabarchive;

$(document).ready(function () {
    $("#dateFrom").kendoDatePicker({ format: "dd.MM.yyyy" });
    $("#dateTo").kendoDatePicker({ format: "dd.MM.yyyy" });

    tabarchive = $("#tabarchive").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    }).data("kendoTabStrip").select(0);

    $("#dateFrom").change(function () {
        goToArchives();
    });
    $("#dateTo").change(function () {
        goToArchives();
    });

    initPaidArchiveGrid({ filters: [], logic: 'and' });
    initUnpaidArchiveGrid({ filters: [], logic: 'and' });
    getLineData(0);
});

function initPaidArchiveGrid(qv) {
    filterArchivesGrid = qv;
    var dataSource = new kendo.data.DataSource({
        type: "webapi",
        pageSize: 10,
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
                url: bars.config.urlContent("/api/pfu/filesgrid/getpaidarchivedata"),
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: ARCHIVE_GRID_HISTORY_FIELDS }
        },
        filter: filterArchivesGrid
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
            fileName: "Архів оплачених реєстрів.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        excelExport: function (e) { //remove html tags from header
            var row = e.workbook.sheets[0].rows[0];
            for (var ci = 0; ci < row.cells.length; ci++) {
                var cell = row.cells[ci];
                if (cell.value) {
                    cell.value = cell.value.replace(/(<([^>]+)>)/ig, ' ');
                }
            }
        },
        toolbar: ["excel",
            {
                template: kendo.template($("#paidArc-template").html())
            }
        ],
        change: function (e) {
            goToLines(false);

            $("#gridRecords").data("kendoGrid").dataSource.read();
        },
        columns: ARCHIVE_GRID_HISTORY_COLUMNS,
        dataBound: function (e) {
        },
        dataSource: dataSource,
        filterable: true
    };
    var gridPaid = $("#gridPaid").kendoGrid(settings);
}

function initUnpaidArchiveGrid(qv) {
    filterArchivesGrid = qv;
    var dataSource = new kendo.data.DataSource({
        type: "webapi",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        sort: [
            { field: "id", dir: "desc" }
        ],
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/getunpaidarchivedata"),
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: ARCHIVE_GRID_HISTORY_FIELDS }
        },
        filter: filterArchivesGrid
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
            fileName: "Архів неоплачених реєстрів.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/'),
        },
        excelExport: function (e) { //remove html tags from header
            var row = e.workbook.sheets[0].rows[0];
            for (var ci = 0; ci < row.cells.length; ci++) {
                var cell = row.cells[ci];
                if (cell.value) {
                    cell.value = cell.value.replace(/(<([^>]+)>)/ig, ' ');
                }
            }
        },
        toolbar: ["excel",
            {
                template: kendo.template($("#unpaidArc-template").html())
            }
        ],
        change: function (e) {
            var grid = this;
            var selected = grid.dataItem(grid.select());

            if (!selected)
                $('#returnArchiveBtn').prop("disabled", true);
            else
                $('#returnArchiveBtn').prop("disabled", false);

            selectedIds = [];
            grid.select().each(function () {
                selectedIds.push(grid.dataItem(this).id);
            });

            goToLines(false);

            $("#gridRecords").data("kendoGrid").dataSource.read();
        },
        columns: ARCHIVE_GRID_HISTORY_COLUMNS,
        dataBound: function (e) {
            var grid = this;
            var selected = grid.dataItem(grid.select());

            if (!selected)
                $('#returnArchiveBtn').prop("disabled", true);
            else
                $('#returnArchiveBtn').prop("disabled", false);
        },
        dataSource: dataSource,
        filterable: true
    };
    $("#gridUnpaid").kendoGrid(settings);
}

var ARCHIVE_GRID_HISTORY_FIELDS = {
    id: { type: "number" },
    file_name: { type: "string" },
    register_date: { type: "date" },
    arcdate: { type: "date" },
    arcdateuser: { type: "string" },
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
    pfu_branch_name: { type: 'string' },
    acc: { type: 'string' }
};

var ARCHIVE_GRID_HISTORY_COLUMNS = [
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
        title: "Найменування <br/> платника",
        width: "150px"
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
        title: "Дата<br/>створення",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "arcdate",
        title: "Дата додавання<br/>реєстру до архіву",
        width: "160px",
        template: "<div style='text-align:center;'>#=kendo.toString(arcdate,'dd.MM.yyyy')#</div>"
    },
    {
        field: "arcdateuser",
        title: "ПІБ корисувача,<br/>який додав<br/>реєстр до архіву",
        width: "160px",
    },
    {
        field: "payment_date",
        title: "Дата <br/>платіжного<br/>клендаря ПФУ",
        width: "150px",
        template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
    },
    {
        field: "file_lines_count",
        title: "Кількість<br/>рядків у реєстрі",
        attributes: { "class": "text-right" },
        width: "150px"
    },
    {
        field: "file_count_rec",
        title: "Кількість<br/>рядків до сплати",
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
        width: "150px"
    }

];

PrintRestData = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd HH:mm:ss'), 'dd/MM/yyyy  HH:mm:ss')

};
GetSum = function (sum) {
    if (sum == null) {
        return "";
    }
    else
        return kendo.toString(sum, "n")
};
function goToArchives() {
    var dateFrom = $("#dateFrom").data("kendoDatePicker").value();
    var dateTo = $("#dateTo").data("kendoDatePicker").value();

    var dateFromfilter = { field: "register_date", operator: "gte", value: dateFrom}; //gte: "Is after or equal to"
    var dateTofilter = { field: "register_date", operator: "lte", value: dateTo }; //lte: "Is before or equal to"

    var operationfilter = {
        filters: [],
        logic: 'and'
    };

    if (!!dateFrom)
        operationfilter.filters.push(dateFromfilter);
    if (!!dateTo)
        operationfilter.filters.push(dateTofilter);

    var grid;
    if ($("#paid").hasClass("k-state-active"))
        grid = $("#gridPaid").data("kendoGrid");
    else if ($("#unpaid").hasClass("k-state-active")) {
        if (!isUnpaidGridInit) {
            isUnpaidGridInit = true;
            initUnpaidArchiveGrid(operationfilter);
            return;
        }
        else
            grid = $("#gridUnpaid").data().kendoGrid;
    }

    if(grid)
        grid.dataSource.filter(operationfilter);
};

function returnArchive() {
    var gview = $("#gridUnpaid").data("kendoGrid");
    var ids = selectedIds;

    if (ids.length > 0) {
        bars.ui.confirm({ text: 'Повернути вибрані реєстри до переліку реєстрів ПФУ?' },
            function () {
                AJAX({
                    srcSettings: {
                        method: "POST",
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/pfu/filesgrid/movefromarchive"),
                        data: JSON.stringify(ids),
                        success: function (e) {
                            if (e === "")
                                bars.ui.notify("Перенос реєстрy", "Перенос реєстрів id=" + ids + " до переліку реєстрів ПФУ виконано успішно ", 'success');
                            else
                                bars.ui.alert({ text: e });
                            gview.dataSource.read();
                        }
                    }
                });
            });
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}

function goToLines(needSwitchTab) {
    var activeGrid;

    if ($("#paid").hasClass("k-state-active")) {
        activeGrid = $("#gridPaid").data("kendoGrid");
        lastActiveTab = 0;
    }
    else if ($("#unpaid").hasClass("k-state-active")) {
        activeGrid = $("#gridUnpaid").data().kendoGrid;
        lastActiveTab = 1;
    }

    var selectedItem = activeGrid.dataItem(activeGrid.select());
    if (selectedItem !== null) {
        $('#gridRecords').data('kendoGrid').dataSource.transport.options.read.url = bars.config.urlContent("/api/pfu/filesgrid/linecatalog?id=" + selectedItem.id)

        // export to Excel use this url! Hmmm....
        $('#gridRecords').data('kendoGrid').dataSource.options.transport.read.url = bars.config.urlContent("/api/pfu/filesgrid/linecatalog?id=" + selectedItem.id)
        $('#gridRecords').data('kendoGrid').dataSource.page(1);

        if (needSwitchTab)
            $("#details").click();
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
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
                url: bars.config.urlContent("/api/pfu/filesgrid/linecatalog?id=" + FileId) //5846
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
        excelExport: function (e) { //remove html tags from header
            var row = e.workbook.sheets[0].rows[0];
            for (var ci = 0; ci < row.cells.length; ci++) {
                var cell = row.cells[ci];
                if (cell.value) {
                    cell.value = cell.value.replace(/(<([^>]+)>)/ig, ' ');
                }
            }
        },
        change: function (e) {

        },
        toolbar: ["excel",
            {
                template: kendo.template($("#details-template").html())
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
                title: "Дата<br>зарахування",
                width: 100,
                template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
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
                template: '#=kendo.toString(sum_pay,"n")#',
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
                //template: '#= getStatusById(state) #',
                //attributes: {
                //    style: "text-overflow: ellipsis; white-space: nowrap;"
                //}
            },

            {
                field: "state_name",
                title: "Статус",
                width: 120,
                //filterable: {
                //    extra: false,
                //    ui: StateFilter
                //}
            },
            {
                field: "err_mess_trace",
                title: "Опис помилки",
                width: 120

            },

        ],
        dataBound: function () {
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
            template: "<input type='checkbox' class='checkbox' onclick='onCheckChangStatusPayed()' style='margin-left: 26%;' />",
            width: 30
        });
    }

    $("#gridRecords").kendoGrid(settings);
}

function switchTab() {
    tabarchive.select(lastActiveTab);
}