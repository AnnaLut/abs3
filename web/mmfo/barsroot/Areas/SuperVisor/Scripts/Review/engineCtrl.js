$(document).ready(function() {
    $('#date').kendoDatePicker({
        format: "dd.MM.yyyy",
        value: bDate
    });

    $("#nbs").keyup(function () {
        this.value = this.value.replace(/[^0-9/*]/g, '');
    });

    $("#kvDrop").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "kv",
        optionLabel: {
            name: "*",
            kv: "*"
        },
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/supervisor/tabval/get")
                }
            }
        }
    });
    

    $("#btnFilter").kendoButton({
        click: function () {

            //debugger;

            var datepicker = $("#date").data("kendoDatePicker");

            var droplist = $("#kvDrop").data("kendoDropDownList");
            var data = droplist.value();
            
            //debugger;

            bars.ui.loader("body", true);

            var model = {
                bDate: datepicker.value(),
                kv: data,
                nbs: $('#nbs').val()
            };

            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: bars.config.urlContent("/api/supervisor/reviewdata/post"),
                data: JSON.stringify(model)
            }).done(function (result) {
                //debugger;
                if (result.Status === 1) {
                    //debugger;
                    bars.ui.loader("body", false);
                    var grid = $("#grid").data("kendoGrid");
                    grid.dataSource.read();
                } else {
                    //debugger;
                    bars.ui.error({ text: result.Msg });
                    bars.ui.loader("body", false);
                }

            });
        }
    });

    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/supervisor/datagrid/get")
            }
        },
        //emptyMsg: 'This grid is empty',
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    show_date: { type: "date" },
                    kf: { type: "string" },
                    kf_name: { type: "string" },
                    nbs: { type: "string"},
                    kv: { type: "string" },
                    dos: { type: "number" },
                    dosq: { type: "number" },
                    kos: { type: "number" },
                    kosq: { type: "number" },
                    ostd: { type: "number" },
                    ostdq: { type: "number" },
                    ostk: { type: "number" },
                    ostkq: { type: "number" },
                    row_type: { type: "number" }
                }
            }
        },
        aggregate: [
            { field: "kf", aggregate: "count" },
            { field: "dos", aggregate: "sum" },
            { field: "dosq", aggregate: "sum" },
            { field: "kos", aggregate: "sum" },
            { field: "kosq", aggregate: "sum" },
            { field: "ostd", aggregate: "sum" },
            { field: "ostdq", aggregate: "sum" },
            { field: "ostk", aggregate: "sum" },
            { field: "ostkq", aggregate: "sum" }
        ]
    });

    function gridDataBound(e) {
        var grid = e.sender;
        if (grid.dataSource.total() === 0) {
            var colCount = grid.columns.length;
            $(grid.wrapper)
                .find('div[class="k-grid-content"]')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">За обраними параметрами фільтрації записи відсутні.</td></tr>');
        } else {
            $(grid.wrapper)
                .find('tr[class="kendo-data-row"]')
                .remove();
        }
    };

    // функція ініціалізації грідів обраного запису.
    function detailInit(e) {
        var detailRow = e.detailRow;
        var masterRow = e.masterRow;
        var grid = this;
        var rowData = grid.dataItem(masterRow);
        
        var template = kendo.template($("#RegionsGrid").html());
        var box = detailRow.find(".box");
        //box.append("<h3>Перегляд даних по: <b>" + rowData.kf_name + "</b></h3>");
        box.append(template(rowData));
        debugger;

        bars.utilsCtrl.initRegionGrid("#Region_" + rowData.kf, rowData);
    }

    $("#grid").kendoGrid({
        autoBind: false,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: false,
            buttonCount: 5
        },
        columns: [
            {
                field: "show_date",
                title: "ORA_field",
                width: 100,
                hidden: true
            },
            {
                field: "kf",
                title: "МФО",
                width: 100,
                //footerTemplate: "Кіл-ть: #=count#",
                hidden: true
            },
            {
                field: "kf_name",
                title: "Назва РУ",
                footerTemplate: "Всього:",
                width: 125
            },
            {
                field: "nbs",
                title: "Бал.",
                width: 70
            },
            {
                field: "kv",
                title: "Вал.",
                width: 70
            },
            {
                field: "dos",
                title: "об. дебет",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 125
            },
            {
                field: "dosq",
                title: "об. дебет екв.",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 125
            },
            {
                field: "kos",
                title: "об.кредит",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 125
            },
            {
                field: "kosq",
                title: "об.кредит екв.",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 125
            },
            {
                field: "ostd",
                title: "зал.дебет",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes:{ 'class':"text-right" } ,
                width: 125
            },
            {
                field: "ostdq",
                title: "зал.дебет екв.",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes:{ 'class':"text-right" } ,
                width: 125
            },
            {
                field: "ostk",
                title: "зал.кредит",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 125
            },
            {
                field: "ostkq",
                title: "зал.кредит екв.",
                footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>",
                format: "{0:n2}",
                attributes: { 'class': "text-right" },
                width: 130
            }
        ],
        dataSource: dataSource,
        detailTemplate: kendo.template($("#template").html()),
        detailInit: detailInit,
        dataBound: gridDataBound
    });
});