if (!("bars" in window)) window["bars"] = {};
bars.utilsCtrl = bars.utilsCtrl || {
    loadGridTemplate: function(path) {
        $.get(path).success(function (result) {
            $("body").append(result);
        }).error(function (result) {
            alert("Помилка завантаження шаблону!");
        });
    },
    initRegionGrid: function (selector, row) {

        // функція ініціалізації грідів обраного регіону.
        function currentDetailInit(e) {
            var detRow = e.detailRow;
            var masRow = e.masterRow;
            var rGrid = $(selector).data("kendoGrid");
            var rData = rGrid.dataItem(masRow);

            var obj = {
                rKF: rData.kf,
                rNBS: rData.nbs,
                gridName: rData.kf + "_" + rData.nbs
            }

            var temp = kendo.template($("#CurrentRegionGrid").html());
            var rBox = detRow.find(".region-box");
            //rBox.append("<h3>" + obj.rNBS + "</h3>");
            debugger;
            rBox.append(temp(obj));
            debugger;
            bars.utilsCtrl.initNbsDataGrid("#Region_" + obj.gridName, obj);
        }

        var regionDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 10,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/supervisor/datagrid/get"),
                    data: { kf: row.kf }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        show_date: { type: "date" },
                        kf: { type: "string" },
                        kf_name: { type: "string" },
                        nbs: { type: "string" },
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
            }/*,
            aggregate: [
                { field: "dos", aggregate: "sum" },
                { field: "dosq", aggregate: "sum" },
                { field: "kos", aggregate: "sum" },
                { field: "kosq", aggregate: "sum" },
                { field: "ostd", aggregate: "sum" },
                { field: "ostdq", aggregate: "sum" },
                { field: "ostk", aggregate: "sum" },
                { field: "ostkq", aggregate: "sum" }
            ]*/
        });

        $(selector).kendoGrid({
            autoBind: true,
            selectable: "row",
            sortable: true,
            scrollable: false,
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
                    //footerTemplate: "Всього:",
                    width: 200,
                    hidden: true
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
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 117
                },
                {
                    field: "dosq",
                    title: "об. дебет екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "kos",
                    title: "об.кредит",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "kosq",
                    title: "об.кредит екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostd",
                    title: "зал.дебет",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostdq",
                    title: "зал.дебет екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostk",
                    title: "зал.кредит",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostkq",
                    title: "зал.кредит екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    template: "<div style='margin-right: 10px;'>#=kendo.toString(ostkq, 'N')#</div>",
                    width: 125
                }
            ],
            dataSource: regionDataSource,
            detailTemplate: kendo.template($("#region-template").html()),
            detailInit: currentDetailInit
            //dataBound: gridRegionDataBound
        });

        $(selector + " .k-grid-content").css({
            "overflow-y": "scroll"
        });

        $(selector + " .k-grid-content").css({
            "overflow-y": "hidden"
        });
    },
    initNbsDataGrid: function (selector, obj) {
        debugger;
        var nbsDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 10,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/supervisor/datagrid/get"),
                    data: { kf: obj.rKF, nbs: obj.rNBS }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        show_date: { type: "date" },
                        kf: { type: "string" },
                        kf_name: { type: "string" },
                        nbs: { type: "string" },
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
            }/*,
            aggregate: [
                { field: "dos", aggregate: "sum" },
                { field: "dosq", aggregate: "sum" },
                { field: "kos", aggregate: "sum" },
                { field: "kosq", aggregate: "sum" },
                { field: "ostd", aggregate: "sum" },
                { field: "ostdq", aggregate: "sum" },
                { field: "ostk", aggregate: "sum" },
                { field: "ostkq", aggregate: "sum" }
            ]*/
        });
        
        $(selector).kendoGrid({
            autoBind: true,
            selectable: "row",
            sortable: true,
            scrollable: false,
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
                    //footerTemplate: "Всього:",
                    width: 200,
                    hidden: true
                },
                {
                    field: "nbs",
                    title: "Бал.",
                    width: 100,
                    hidden: true
                },
                {
                    field: "kv",
                    title: "Вал.",
                    width: 70
                },
                {
                    field: "dos",
                    title: "об. дебет",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 115
                },
                {
                    field: "dosq",
                    title: "об. дебет екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "kos",
                    title: "об.кредит",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "kosq",
                    title: "об.кредит екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostd",
                    title: "зал.дебет",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostdq",
                    title: "зал.дебет екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostk",
                    title: "зал.кредит",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    width: 125
                },
                {
                    field: "ostkq",
                    title: "зал.кредит екв.",
                    //footerTemplate: "#=kendo.toString(sum, 'N')#",
                    format: "{0:n2}",
                    attributes: { 'class': "text-right" },
                    template: "<div style='margin-right: 5px;'>#=kendo.toString(ostkq, 'N')#</div>",
                    width: 125
                }
            ],
            dataSource: nbsDataSource
        });

        
        $(selector + " .k-grid-content").css({
            "overflow-y": "scroll"
        });

        $(selector + " .k-grid-content").css({
            "overflow-y": "hidden"
        });
    }
}