var filterFilesGrid = null;
var selectedRegistryId = null;
function initRegistersGrid(qv) {
    var REGISTERS_GRID_FIELDS = {
        id: { type: "number" },
        file_name: { type: "string" },
        register_date: { type: "date" },
        payment_date: { type: "date" },
        file_lines_count: { type: "number" },
        file_count_rec: { type: "number" },
        file_sum: { type: "number" },
        file_sum_rec: { type: "number" },
        receiver_mfo: { type: "number" }
    };
    var REGISTERS_GRID_COLUMNS = [
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
            width: "100px"
        },
        {
            field: "file_name",
            title: "Назва файлу<br/>реєстру",
            width: "130px"
        },
        {
            field: "register_date",
            title: "Дата<br>створення",
            width: "120px",
            template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
        },
        {
            field: "payment_date",
            title: "Дата <br/>платіжного<br/>клендаря ПФУ",
            width: "120px",
            template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
        },
        {
            field: "file_lines_count",
            title: "Кількість<br>рядків у<br>реєстрі",
            attributes: { "class": "text-right" },
            width: "100px"
        },
        {
            field: "file_count_rec",
            title: "Кількість<br>рядків до<br>сплати",
            attributes: { "class": "text-right" },
            width: "100px"
        },
        {
            field: "file_sum",
            title: "Cума реєстру",
            template: '#=kendo.toString(file_sum,"n")#',
            format: '{0:n}',
            attributes: { "class": "money" },
            width: "130px"
        },
        {
            field: "file_sum_rec",
            title: "Cума до сплати",
            template: '#=kendo.toString(file_sum_rec,"n")#',
            format: '{0:n}',
            attributes: { "class": "money" },
            width: "130px"
        },       
        {
            field: "state_name",
            title: "Статус",
            width: "130px"
        }
    ];
    Waiting(true);
    filterFilesGrid = qv;
    var registersDataSource = new kendo.data.DataSource({
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
                url: bars.config.urlContent("/api/pfu/filesgrid/searchcataloginpay"),
                data: function () { return filterFilesGrid; }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: { fields: REGISTERS_GRID_FIELDS }
        }
    });
    var registersSettings = {
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
            loadRecords();
            var grid = this;
            var selected = grid.dataItem(grid.select());
            $("#processRegistresBtn").prop("disabled", !selected);
            $("#toRecordsBtn").prop("disabled", !selected);
        },
        columns: REGISTERS_GRID_COLUMNS,
        dataBound: function (e) {
            Waiting(false);
            $("#processRegistresBtn").prop("disabled", true);
            $("#toRecordsBtn").prop("disabled", true);
            $('#label_records').html('');
        },
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: registersDataSource,
        filterable: true
    };
    $("#grid_registers").kendoGrid(registersSettings);
}
function initRecordsGrid() {
    var RECORDS_GRID_FIELDS = {
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
    };
    var RECORDS_GRID_COLUMNS = [
        {
            field: "id",
            title: "ID інфор-<br>маційного<br>рядка",
            width: 80,
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
            width: 200,
            attributes: {
                style: "text-overflow: ellipsis; white-space: nowrap;"
            }
        },
        {
            field: "numident",
            title: "ІПН",
            width: 80
        },
        {
            field: "payment_date",
            title: "Дата<br>зарахування",
            width: 90,
            template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
        },
        {
            field: "num_acc",
            title: "Номер рахунку",
            width: 110
        },
        {
            field: "mfo",
            title: "Код<br>МФО",
            width: 70
        },
        {
            field: "sum_pay",
            title: "Сума",
            template: '#=kendo.toString(sum_pay,"n")#',
            format: '{0:n}',
            attributes: { "class": "money" },
            width: 100
        },
        {
            field: "state_name",
            title: "Статус",
            width: 110
        },
        {
            field: "err_mess_trace",
            title: "Опис помилки",
            width: 110
        },
    ];
    Waiting(true);
    var recordsDataSource = new kendo.data.DataSource({
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
                type: "GET",
                dataType: "json",
                url: //bars.config.urlContent("/api/pfu/filesgrid/linecataloginpay")
                bars.config.urlContent("/api/pfu/filesgrid/linecataloginpay"),
                data: function () { return { id: selectedRegistryId }; }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: RECORDS_GRID_FIELDS
            }
        }
    });
    var recordsSettings = {
        autoBind: false,
        resizable: true,
        selectable: "multiple",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 50, 200, 1000, "Всі"],
            buttonCount: 5
        },
        columns: RECORDS_GRID_COLUMNS,
        excel: {
            allPages: true,
            fileName: "Інформаційні рядки реєстру.xlsx",
            proxyURL: bars.config.urlContent('/Pfu/Pfu/ConvertBase64ToFile/')
        },
        toolbar: ["excel",
            {
                template: kendo.template($("#lineTitle-template").html())
            }
        ],
        change: function (e) {
            var grid = this;
            var selected = grid.dataItem(grid.select());
            $("#acceptedRecordsBtn").prop("disabled", !selected);
            $("#returnedPFURecordsBtn").prop("disabled", !selected);
            //$("#grid_records").data("kendoGrid").dataSource.read();
        },
        // dataBinding: searchStates,
        dataBound: function () {
            Waiting(false);
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            grid.select("tr:eq(1)");
            kendo.resize(grid.element);
            $("#acceptedRecordsBtn").prop("disabled", true);
            $("#returnedPFURecordsBtn").prop("disabled", true);
        },
        dataSource: recordsDataSource,
        filterable: true
    };
    $("#grid_records").kendoGrid(recordsSettings);
}
function loadRegisters() {
    var catalogDate = $("#searchDate").data("kendoDatePicker").value();
    var PayDate = $("#searchPayDate").data("kendoDatePicker").value();

    filterFilesGrid.CatalogDate = kendo.toString(catalogDate, "MM.dd.yyyy");
    filterFilesGrid.IdCatalog = NullOrValue($("#searchId").val());
    filterFilesGrid.Mfo = NullOrValue($("#searchMfo").val());
    filterFilesGrid.PayDate = kendo.toString(PayDate, "MM.dd.yyyy");

    var grid = $("#grid_registers").data("kendoGrid");
    if (grid) grid.dataSource.fetch();

    //$("#tabstrip").kendoTabStrip().data("kendoTabStrip").select(0);

    $("#grid_records").data("kendoGrid").dataSource.data([]);
    $("#acceptedRecordsBtn").prop("disabled", true);
    $("#returnedPFURecordsBtn").prop("disabled", true);
}
function loadRecords() {
    var gridRegisters = $("#grid_registers").data("kendoGrid");
    var selectedCatalog = gridRegisters.dataItem(gridRegisters.select());
    if (selectedCatalog) {
        selectedRegistryId = selectedCatalog.id;
        $('#label_records').html('Інформаційні рядки Реєстру №' + selectedRegistryId);
        $('#grid_records').data('kendoGrid').dataSource.read();
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}
function processRegistres() {
    var gridRegisters = $("#grid_registers").data("kendoGrid");
    var selectedRegisters = gridRegisters.select();
    var selectedRegistersIds = [];
    for (var i = 0; i < selectedRegisters.length; i++) {
        selectedRegistersIds.push(gridRegisters.dataItem(selectedRegisters[i]).id);
    }
    kendo.ui.progress($("#grid_registers"), true);
    AJAX({
        srcSettings: {
            method: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/pfu/filesgrid/ProcessRegistres"),
            data: JSON.stringify(selectedRegistersIds),
            complete: function () {
                kendo.ui.progress($("#grid_registers"), false);
                gridRegisters.dataSource.read();
            }
        }
    });
}
function processRecords(stateName) {
    var gridRecords = $("#grid_records").data("kendoGrid");
    var selectedRecords = gridRecords.select();
    var selectedRecordsIds = [];
    for (var i = 0; i < selectedRecords.length; i++) {
        selectedRecordsIds.push(gridRecords.dataItem(selectedRecords[i]).id);
    }
    kendo.ui.progress($("#grid_records"), true);
    AJAX({
        srcSettings: {
            method: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/pfu/filesgrid/ProcessRecords"),
            data: JSON.stringify({ ids: selectedRecordsIds, stateName: stateName }),
            complete: function () {
                kendo.ui.progress($("#grid_records"), false);
                gridRecords.dataSource.read();
            }
        }
    });
}
function acceptedRecords() {
    processRecords('Зараховано');
}
function returnedPFURecords() {
    processRecords('Повернуто ПФУ');
}
$(document).ready(function () {
    var tabStrip = $("#tabstrip").kendoTabStrip({
        animation: false
    }).data("kendoTabStrip").select(0);

    initRegistersGrid({ IdCatalog: null, Mfo: null, CatalogDate: null, PayDate: null });
    initRecordsGrid();

    $("#searchDate").kendoDatePicker({ format: "dd.MM.yyyy" });
    $("#searchPayDate").kendoDatePicker({ format: "dd.MM.yyyy" });
    
    $('body').on('click', '#processRegistresBtn', processRegistres);
    $('body').on('click', '#acceptedRecordsBtn', acceptedRecords);
    $('body').on('click', '#returnedPFURecordsBtn', returnedPFURecords);
    $('body').on('click', '#toRegistersBtn', function () { tabStrip.select(0); });
    $('body').on('click', '#toRecordsBtn', function () { /*loadRecords();*/ tabStrip.select(1); });

    $("#searchMfo").change(loadRegisters);
    $("#searchId").change(loadRegisters);
    $("#searchDate").change(loadRegisters);
    $("#searchPayDate").change(loadRegisters);
});