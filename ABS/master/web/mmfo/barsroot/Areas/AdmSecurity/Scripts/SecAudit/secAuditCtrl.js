$(document).ready(function () {
    // Dates params
    
    $("#start").kendoDateTimePicker({
        format: "dd/MM/yyyy hh:mm",
        culture: "uk-UA",
        value: kendo.toString(kendo.parseDate(new Date(new Date().setDate(new Date().getDate() - 30)), 'dd/MM/yyyy hh:mm')),
        min: new Date(new Date().setMonth(new Date().getMonth() - 6)),
        max: new Date(new Date().setDate(new Date().getDate() - 1)),
        change: function () {
            var start = $("#start").data("kendoDateTimePicker");
            var end = $("#end").data("kendoDateTimePicker");
            var startDate = start.value(),
            endDate = end.value();

            if (startDate) {
                startDate = new Date(startDate);
                startDate.setDate(startDate.getDate());
                end.min(startDate);
            } else if (endDate) {
                start.max(new Date(endDate));
            } else {
                endDate = new Date();
                start.max(endDate);
                end.min(endDate);
            }

            var value = this.value();
            //console.log(value);
        }
    });


    $("#end").kendoDateTimePicker({
        format: "dd/MM/yyyy hh:mm",
        value: kendo.toString(kendo.parseDate(new Date(), 'dd/MM/yyyy hh:mm')),
        max: new Date(),
        culture: "uk-UA",
        change: function () {
            var start = $("#start").data("kendoDateTimePicker");
            var end = $("#end").data("kendoDateTimePicker");
            var endDate = end.value(),
            startDate = start.value();

            if (endDate) {
                endDate = new Date(endDate);
                endDate.setDate(endDate.getDate());
                start.max(endDate);
            } else if (startDate) {
                end.min(new Date(startDate));
            } else {
                endDate = new Date();
                start.max(endDate);
                end.min(endDate);
            }

            var value = this.value();
            //console.log(value);
        }
    });
    

    $('#toolbar-filter').kendoToolBar({
        items: [
            {
                template: '<label>Date filtering:<label/>'
            },
            {
                template: '<input type="date" id="sDate" />'
            },
            {
                type: 'separator'
            },
            {
                template: '<button id="UsePeriod" class="btn btn-success"> Задати період </button>'
            }
        ]
    });


    

    

    // Grid DataSource
    var secAuditDatasource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/admsecurity/secaudit/GetAuditData"),
                data: {
                    startDate: '10.10.2015', //$("#start").data("kendoDateTimePicker").value(),
                    endDate: '10.01.2016'//$("#end").data("kendoDateTimePicker").value()
                },
                //emptyMsg: 'This grid is empty',
                success: function (elem) {
                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані.<br/>" + error });
                }
            }
        },
        requestEnd: function(e) {
            var response = e.response;
            var type = e.type;
            if (response.Total === 0 && response.Errors != null) {
                bars.ui.error({ text: response.Errors.message });
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    REC_ID: { type: "number" },
                    REC_UID: { type: "number" },
                    REC_UNAME: { type: "string" },
                    REC_UPROXY: { type: "string" },
                    REC_DATE: { type: "date" },
                    REC_BDATE: { type: "date" },
                    REC_TYPE: { type: "string" },
                    REC_MODULE: { type: "string" },
                    REC_MESSAGE: { type: "string" },
                    MACHINE: { type: "string" },
                    REC_OBJECT: { type: "string" },
                    REC_USERID: { type: "number" },
                    BRANCH: { type: "string" },
                    REC_STACK: { type: "string" },
                    CLIENT_IDENTIFIER: { type: "string" }
                }
            }
        }
    });

    // Btn options
    $("#UsePeriod").on("click", function() {
        var start = $("#start").data("kendoDateTimePicker"),
            end = $("#end").data("kendoDateTimePicker"),
            startDate = start.value(),
            endDate = end.value();

        if (startDate != null && endDate != null) {
            var grid = $("#AuditGrid").data("kendoGrid");
            grid.dataSource.read({ startDate: startDate, endDate: endDate });
            //grid.dataSource.read();
        } else {
            bars.ui.alert({ text: "Не задано період для перегляду журналу аудиту!" });
        }
    });

    // Grid init
    $("#AuditGrid").kendoGrid({
        autoBind: false,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        filterable: {
            mode: "row"
        },
        scrollable: true,
        columns: [
            {
                field: "REC_ID",
                title: "Код запису",
                width: 150
            },{
                field: "REC_UID",
                title: "Код користовача",
                width: 150
            },{
                field: "REC_UNAME",
                title: "Логін користувача",
                width: 150
            },{
                field: "REC_UPROXY",
                title: "Проксі",
                width: 150
            },{
                field: "REC_DATE",
                title: "Системна дата",
                template: "<div>#=kendo.toString(REC_DATE,'dd/MM/yyyy hh:mm')#</div>",
                width: 150
            }, {
                field: "REC_BDATE",
                title: "Банківська дата",
                template: "<div>#=kendo.toString(REC_BDATE,'dd/MM/yyyy hh:mm')#</div>",
                width: 150
            }, {
                field: "REC_TYPE",
                title: "Тип повідомлення",
                width: 150
            }, {
                field: "REC_MODULE",
                title: "Тип інтерфейсу",
                width: 150
            }, {
                field: "REC_MESSAGE",
                title: "Повідомлення",
                width: 550
            }, {
                field: "MACHINE",
                title: "IP Адреса",
                width: 150
            }, {
                field: "REC_OBJECT",
                title: "Об'єкт",
                width: 100
            }, {
                field: "REC_USERID",
                title: "Код сесії",
                width: 150
            }, {
                field: "BRANCH",
                title: "Відділення",
                width: 200
            }, {
                field: "REC_STACK",
                title: "Стек",
                width: 150
            }, {
                field: "CLIENT_IDENTIFIER",
                title: "Код сесії користовача",
                width: 220
            }
        ],
        dataSource: secAuditDatasource
    });
});

