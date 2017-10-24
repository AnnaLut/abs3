function getFileStatus() {
    var statusDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/pfufilestatus")
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    state: { type: "string" },
                    state_name: { type: "string" }
                }
            }
        }
    });
    var statusSettings = {
        dataSource: statusDataSource,
        dataTextField: "state_name",
        dataValueField: "state"
    };

    $("#searchState").kendoDropDownList(statusSettings);
}

var selectedEnvelopeRow = function () {
    var grid = $('#gridEnvelope').data("kendoGrid");
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
                data: function () { return filterEnvelopesGrid;}
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    id: { type: "number" },
                    name: { type: "string" },
                    date_insert: { type: "date" },
                    count_files: { type: "number" },
                    sum: { type: "number" },
                    state: { type: "string" }
                }
            }
        }
    });

    var searchSettings = {
        autoBind: true,
        resizable: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true
        },
        toolbar: kendo.template($("#envelopeTitle-template").html()),
        columns: [
            {
                field: "id",
                title: "ID",
                width: 90
            },
            {
                field: "name",
                title: "Назва реєстру",
                width: 90
            },
            {
                field: "date_insert",
                title: "Дата<br>створення",
                width: 110,
                template: "<div style='text-align:center;'>#=kendo.toString(date_insert,'dd.MM.yyyy')#</div>"
            },
            {
                field: "count_files",
                title: "Кількість<br>файлів",
                width: 100
            },
            {
                field: "sum",
                title: "Загальна сума",
                width: 150
            },
            {
                field: "state",
                title: "Статус",
                width: 90
            }
        ],
        change: function () {
            if (selectedEnvelopeRow())
                getSearchData({ EnvelopeId: selectedEnvelopeRow().id, State: null, IdCatalog: null, Mfo: null, CatalogDate: null });
            else 
                $('#gridCatalog').empty();
        },
        // dataBinding: searchStates,
        dataBound: function () {
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            grid.select("tr:eq(1)");
            kendo.resize(grid.element);
        },
        dataSource: searchDataSource,
        filterable: true
    };

    $("#gridEnvelope").kendoGrid(searchSettings);
}

var filterFilesGrid = null;
function getSearchData(qv) {
    filterFilesGrid = qv;
    var searchDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
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
                url: bars.config.urlContent("/api/pfu/filesgrid/searchcatalog"),
                data: function () { return filterFilesGrid; }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    file_name: { type: "string" },
                    register_date: { type: "date" },
                    payment_date: { type: "date" },
                    file_lines_count: { type: "number" },
                    file_count_rec: { type: "number" },
                    file_sum: { type: "number" },
                    file_sum_rec: { type: "number" },
                    state: { type: "string" }
                }
            }
        }
    });

    var searchSettings = {
        autoBind: true,
        resizable: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true
        },
        toolbar: kendo.template($("#catalogTitle-template").html()),
        columns: [
            {
                field: "id",
                title: "ID",
                width: 90
            },
            {
                field: "file_name",
                title: "Назва",
                width: 90
            },
            {
                field: "register_date",
                title: "Дата<br>створення",
                width: 110,
                template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "payment_date",
                title: "Дата<br>оплати",
                width: 100,
                template: "<div style='text-align:center;'>#=kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "file_lines_count",
                title: "Кількість<br>рядків",
                width: 100
            },
            {
                field: "file_count_rec",
                title: "Кількість<br>рядків до сплати",
                width: 150
            },
            {
                field: "file_sum",
                title: "Cума",
                width: 90
            },
            {
                field: "file_sum_rec",
                title: "Cума<br>до сплати",
                width: 110
            },
            {
                field: "state",
                title: "Статус",
                width: 90
            }
        ],
        dataBinding: searchStates,
        dataBound: function () {
            kendo.ui.progress($(".search-catalog"), false);
        },
        dataSource: searchDataSource,
        filterable: true
    };

    $("#gridCatalog").kendoGrid(searchSettings);
}

function approveMatching()
{
    var gview = $("#gridEnvelope").data("kendoGrid");
    var selectedEnvelope = gview.dataItem(gview.select());
    if (selectedEnvelope !== null) {
        $.ajax({
            type: "POST",
            contentType: "application/json",
            dataType: "json",
            url: bars.config.urlContent("/api/pfu/filesgrid/readyformatching?id=" + selectedEnvelope.id),
            success: function (data) {
                bars.ui.notify("Зміна статусу", "Реєстр №" + selectedEnvelope.id + " успішно помічено до відправки", 'success')
                gview.dataSource.read();
            }
        });
    } else {
        bars.ui.error({ title: 'Помилка!', text: 'Необхідно вибрати реестр!' });
    }
}       

function searchEnvelop()
{
    var qv = {};
    var creatingDate = $("#searchDate").data("kendoDatePicker").value();
    qv.CreatingDate = kendo.toString(creatingDate, "MM.dd.yyyy");
    qv.Id = NullOrValue($("#searchId").val());
    qv.State = null;//NullOrValue($("#searchState").val());
    getEnvelopeData(qv);
}

$(document).ready(function () {
    $("#searchDate").kendoDatePicker({
        format: "dd.MM.yyyy"
    });
    getFileStatus();
    initEnvelopGrid({ State: null, CreatingDate: null, Id: null});
});