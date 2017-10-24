var PensionerTypesNames = [
    { Id: 1, Name: "Запит ЕПП", dbId: "GET_EPP_BATCH_LISTS" },
    { Id: 2, Name: "Запит реєстрів на оплату", dbId: "GET_CONVERT_LISTS" }
    //{ Id: 3, Name: "Запит повідомлень про смерть", dbId: "DEATH_LIST" }
];

function getRequestNameById(Id) {
    return getNameById(Id, PensionerTypesNames, 'Id', 'Name');
}

function getPfuType() {
    fillDropDownList("#pfu_type",
        {
            transport: { read: { url: bars.config.urlContent("/api/pfu/listrequest/PensionerTypes?arm=1") } },
            schema: { model: { fields: { Id: { type: "number" } } } }
        },
        {
            dataTextField: "Id",
            dataValueField: "Id",
            template: '#= getRequestNameById(Id) #',
            valueTemplate: "#= getRequestNameById(Id) #"
        }
    );

}
function Waiting(flag) {
    kendo.ui.progress($("#grid_files"), flag);
    kendo.ui.progress($("#gridConsoleBox"), flag);

}
$(document).ready(function () {

    function statusRequest() {
        debugger;////
        var gview = $("#grid_request").data("kendoGrid");
        var grid_files = $("#grid_files").data("kendoGrid");
        var selectedFile = gview.dataItem(gview.select());
        debugger;
        debugger;
        grid_files.dataSource.filter({ "field": "id", "operator": "eq", "value": selectedFile.id });//startswith selectedFile.id


        var requestLogtDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 12,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/pfu/requestgrid/RequestLog?id=" + selectedFile.id)
                }
            },
            requestStart: function () {
                debugger;
                Waiting(true);
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        id: { type: "number" },
                        request_id: { type: "number" },
                        session_id: { type: "number" },
                        state_code: { type: "string" },
                        state_id: { type: "string" },
                        sys_time: { type: "date" },
                        tracking_comment: { type: "string" }
                    }
                }
            }
        });
        var _grid = $("#gridConsoleBox").data("kendoGrid");
        if (_grid != null) _grid.destroy();

        $("#gridConsoleBox").kendoGrid({
            autoBind: true,
            selectable: "row",
            scrollable: true,
            sortable: true,
            pageable: {
                refresh: true
            },
            toolbar: kendo.template($("#consoleTitle-template").html()),
            columns: [
                {
                    field: "id",
                    title: "ID",
                    width: 110,
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "request_id",
                    title: "Id Запиту",
                    width: 110
                },
                {
                    field: "session_id",
                    title: "Id Сесії",
                    width: 110
                },
                {
                    field: "state_code",
                    title: "Код статусу",
                    width: 120
                },
                {
                    field: "sys_time",
                    title: "Системний час",
                    template: "<div style='text-align:center;'>#=kendo.toString(sys_time,'dd.MM.yyyy hh:mm:ss')#</div>",
                    width: 150
                },
                {
                    field: "tracking_comment",
                    title: "Комент",
                    width: 610,
                    attributes: {
                        style: "text-overflow: ellipsis; white-space: nowrap;"
                    }
                }
            ],
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
            dataSource: requestLogtDataSource,
            filterable: true,
            change: function () {
                debugger;
            },
            dataBound: function () {
                Waiting(false);
            }
        })
    }
    //--------------------------------------------
    //Data query block
    var tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 30);

    var dStrt = $("#dateStart").kendoDatePicker({
        value: new Date(), format: "dd.MM.yyyy"
    });

    var dEnd = $("#dateEnd").kendoDatePicker({
        value: tomorrow, format: "dd.MM.yyyy"
    });

    $("#start").on("click", function (e) {
        var sDate = dStrt.data("kendoDatePicker").value();
        var eDate = $("#dateEnd").data("kendoDatePicker").value();
        var pfuType = NullOrValue($("#pfu_type").val());
        debugger;
        $.ajax({
            type: "POST",
            data: JSON.stringify(
            {
                start_date: kendo.toString(sDate, "dd.MM.yyyy"),
                end_date: kendo.toString(eDate, "dd.MM.yyyy"),
                pfu_type: pfuType
            }),
            contentType: "application/json",
            dataType: "json",
            url: bars.config.urlContent("/api/pfu/listrequest/CallEnvelopeListRequest"),
            success: function (data) {
                $("#grid_request").data("kendoGrid").dataSource.read();
            }
        });
    });
    //--------------------------------------------

    $("#tabstrip").kendoTabStrip({
        animation: {
            open: {
                effects: "fadeIn"
            }
        }
    }).data("kendoTabStrip").select(0);

    //Pfu Session request block
    var requestDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: "application/json",
                url: bars.config.urlContent("/api/pfu/requestgrid/RequestData")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    date_from: { type: "date" },
                    date_to: { type: "date" },
                    state_id: { type: "string" },
                    state_name: { type: "string" },
                    pfu_request_id: { type: "number" },
                    request_time: { type: "date" },
                    type_name: { type: "string" }
                }
            }
        }
    });

    var requests = $("#grid_request").kendoGrid({
        autoBind: true,
        selectable: "row",
        scrollable: true,
        sortable: true,
        pageable: {
            refresh: true
        },
        columns: [
            {
                field: "id",
                title: "ID запиту в ПФУ",
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
                field: "request_time",
                title: "Дата та час відправки в ПФУ",
                template: "<div style='text-align:center;'>#=kendo.toString(request_time,'dd.MM.yyyy  hh:mm:ss')#</div>",
                width: 150
            },
            {
                field: "date_from",
                title: "Початку періоду",
                template: "<div style='text-align:center;'>#=(date_from == null) ? ' ' : kendo.toString(date_from,'dd.MM.yyyy')#</div>",
                width: 110,
                hidden: true
            },
            {
                field: "date_to",
                title: "Завершення періоду",
                template: "<div style='text-align:center;'>#=(date_to == null) ? ' ' : kendo.toString(date_to,'dd.MM.yyyy')#</div>",
                width: 110,
                hidden: true
            },
            {
                field: "pfu_request_id",
                title: "ID відповіді ПФУ",
                width: 80
            },
            {
                field: "type_name",
                title: "Тип запиту",
                width: 90
            },
            {
                field: "state_name",
                title: "Стан запиту",
                width: 110
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: requestDataSource,
        filterable: true,
        change: statusRequest,
        dataBound: function () {

        }
        //, dataBound: setDefaultRow
    });

    //--------------------------------------------

    var envelopeDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 12,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/pfu/filesgrid/envelopedata")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    pfu_envelope_id: { type: "number" },
                    pfu_branch_code: { type: "string" },
                    pfu_branch_name: { type: "string" },
                    register_date: { type: "date" },
                    receiver_mfo: { type: "string" },
                    receiver_branch: { type: "string" },
                    receiver_name: { type: "string" },
                    check_sum: { type: "number" },
                    check_lines_count: { type: "number" },
                    crt_date: { type: "date" },
                    state: { type: "string" },
                    count_files: { type: "number" }
                }
            }
        }
    });

    var envelopeSettings = {
        autoBind: true,
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
                title: "ID запиту<br/>в ПФУ",
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
                field: "pfu_envelope_id",
                title: "ID<br>конверту",
                width: 100
            },
            {
                field: "pfu_branch_code",
                title: "Код обл.<br>управління",
                width: 110
            },
            {
                field: "pfu_branch_name",
                title: "Назва обл.<br>управління ПФУ",
                width: 300,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "register_date",
                title: "Дата<br>створення",
                width: 110,
                template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "receiver_mfo",
                title: "МФО<br>отримувача",
                width: 120
            },
            {
                field: "receiver_branch",
                title: "Код<br>відділення",
                width: 140
            },
            {
                field: "check_sum",
                title: "Сума<br>платежів",
                width: 100
            },
            {
                field: "check_lines_count",
                title: "Кількість<br>рядків",
                width: 100
            },
            {
                field: "crt_date",
                title: "Дата<br>завантаження",
                width: 130,
                template: "<div style='text-align:center;'>#=kendo.toString(register_date,'dd.MM.yyyy')#</div>"
            },
            {
                field: "state",
                title: "Статус",
                width: 130
            },
            {
                field: "count_files",
                title: "Кількість<br>файлів",
                width: 100
            }
        ],
        filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
        dataSource: envelopeDataSource,
        filterable: true,
        dataBound: function () {
            debugger;
            var el = $(".k-grid-filter.filter")
            var els = $(".k-grid-filter.k-state-active")
            el.removeClass("k-state-active");
            el.addClass("filter");

        }
    };

    $("#grid_files").kendoGrid({});
    getEnvelopeData();//init envelope
    //--------------------------------------------

    getPfuType();   // init client types

    var gridFilesLevel = 'envelope';

    function setFilesGrid(Id) {
        var filesDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 12,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/pfu/filesgrid/filesdata?id=" + Id)
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        id: { type: "number" },
                        pfu_envelope_id: { type: "number" },
                        file_name: { type: "string" },
                        payment_date: { type: "date" },
                        file_number: { type: "number" },
                        file_sum: { type: "number" },
                        file_lines_count: { type: "number" },
                        main_request_id: { type: "number" },
                        crt_date: { type: "date" }
                    }
                }
            }
        });

        var filesSettings = {
            autoBind: true,
            selectable: "row",
            scrollable: true,
            sortable: true,
            pageable: {
                refresh: true
            },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },
            toolbar: kendo.template($("#loadFile-template").html()),
            columns: [
                {
                    field: "pfu_envelope_id",
                    title: "ID конверту в ПФУ",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "file_number",
                    title: "Порядковий номер у конверті"
                },
                {
                    field: "id",
                    title: "ID реєстру"
                },

                {
                    field: "file_name",
                    title: "Назва файлу"
                },
                {
                    field: "file_lines_count",
                    title: "Кількість рядків"
                },
                {
                    field: "payment_date",
                    title: "Дата виплати",
                    template: "<div style='text-align:center;'>#=(payment_date == null) ? ' ' : kendo.toString(payment_date,'dd.MM.yyyy')#</div>"
                }



                //{
                //    field: "main_request_id",
                //    title: "ID запиту"
                //},
                //{
                //    field: "crt_date",
                //    title: "Дата",
                //    template: "<div style='text-align:center;'>#=(crt_date == null) ? ' ' : kendo.toString(crt_date,'dd.MM.yyyy')#</div>"
                //},

            ],
            dataSource: filesDataSource,
            filterable: true,
            dataBound: function () {


            }
        };
        $("#grid_files").data("kendoGrid").setOptions(filesSettings);
    }

    function getFileData() {
        var gview = $("#grid_files").data("kendoGrid");
        var item = gview.dataItem(gview.select());
        if (item) {
            setFilesGrid(item.id);
            gridFilesLevel = 'file';
        } else {
            bars.ui.alert({ text: "Ви не обрали конверт, файли якого потрібно відобразити." });
        }
    }

    function getEnvelopeData() {
        $("#grid_files").data("kendoGrid").setOptions(envelopeSettings);
        gridFilesLevel = 'envelope';
    }

    function gridFilesDblclick() {
        if (gridFilesLevel == 'envelope') {
            getFileData();
        }
    }
    $('body').on('click', '#goToFiles', getFileData);
    $('body').on('click', '#backToEnvelope', getEnvelopeData);
    $("#grid_files").on("dblclick", "tbody > tr", gridFilesDblclick);

    //--------------------------------------------

    function loadFile() {
        var gview = $("#grid_files").data("kendoGrid");
        var item = gview.dataItem(gview.select());
        if (item) {
            window.open(bars.config.urlContent("/api/pfu/filesgrid/pfufile?id=" + item.id), "_blank", "");
        } else {
            bars.ui.alert({ text: "Ви не обрали файл, який потрібно завантажити." });
        }
    }

    function loadEnvelope() {
        var gview = $("#grid_files").data("kendoGrid");
        var item = gview.dataItem(gview.select());
        if (item) {
            window.open(bars.config.urlContent("/api/pfu/filesgrid/pfuenvelope?id=" + item.id), "_blank", "");
        } else {
            bars.ui.alert({ text: "Ви не обрали конверт, який потрібно завантажити." });
        }
    }

    $('body').on('click', '#loadFile', loadFile);
    $('body').on('click', '#loadEnvelope', loadEnvelope);

});

