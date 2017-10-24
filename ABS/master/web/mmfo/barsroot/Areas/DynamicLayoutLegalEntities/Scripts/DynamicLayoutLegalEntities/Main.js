///*** GLOBALS
var urlParamData = "";
///***

function updateMainGrid() {
    var grid = $("#gridMain").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}

function initMainGrid() {
    var selectFilter = {};

    var searchMethodName = "SearchMain";
    if (urlParamData != undefined && urlParamData != null && urlParamData != "") {
        searchMethodName = "SearchMainJuridicalOnly";
    }

    var dataSourceObj = {
        //type: "aspnetmvc-ajax",
        type: "webapi",
        transport: {
            read: {
                //type: "GET",
                url: bars.config.urlContent('/api/DynamicLayoutLegalEntities/DynamicLayoutLegalEntities/' + searchMethodName),
                dataType: "json"
            }
        },
        requestStart: function (e) {
            bars.ui.loader('body', true);
        },
        requestEnd: function (e) {
            bars.ui.loader('body', false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: 'number' },
                    DK: { type: 'number' },
                    NAME: { type: 'string' },
                    NLS: { type: 'string' },
                    BS: { type: 'string' },
                    OB: { type: 'string' },
                    NAZN: { type: 'string' },
                    DATP: { type: 'date' },
                    ALG: { type: 'number' },
                    GRP: { type: 'number' }
                }
            }
        },
        sort: ([
        {
            field: "GRP", dir: "asc", compare: function (a, b) {
                if (a.GRP === undefined || a.GRP == null) return -1;
                if (b.GRP === undefined || b.GRP == null) return 1;

                return a.GRP === b.GRP ? 0 : ((Math.abs(a.GRP) > Math.abs(b.GRP)) ? 1 : -1);
            }
        }
        ])
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        dataSource: mainGridDataSource,
        pageable: {
            info: false,
            refresh: false,
            pageSizes: false,
            previousNext: false,
            numeric: false,
            refresh: true
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        toolbar: [
            {
                template: '<div class="btn-group" style="height:30px;">'
                            + '<a class="btn btn-primary k-grid-excel"><span><img src="/common/images/default/16/export_excel.png"/></span>  Вивантажити в Exel</a>'
                            + '<a class="btn btn-primary k-grid-custom-calculate"><span><img src="/common/images/default/16/open.png"/></span> Виконати розрахунок по макету </a>'
                        + '</div>'
                        + '<div class="btn-group" style="height:30px;">'
                            + '<a id="filterBox" title="Фільтр по групам."/>'
                        + '</div>'
                        + '<div class="btn-group" style="height:30px;">'
                            + '<a id="btnApplyFilter" disabled class="btn btn-primary" title="Застосувати фільтр"><span><img src="/common/images/default/16/ok.png"/></span></a>'
                            + '<a id="btnClearFilter" disabled class="btn btn-primary" title="Очистити фільтр"><span><img src="/common/images/default/16/cancel_blue.png"/></span></a>'
                        + '</div>'
            }
        ],
        excel: {
            fileName: "table.xlsx",
            allPages: true,
            proxyURL: bars.config.urlContent('/DynamicLayoutLegalEntities/DynamicLayoutLegalEntities/ConvertBase64ToFile/')
        },
        columns: [
            {
                field: "DK",
                title: "ДК",
                width: "50px",
                filterable: false,
                sortable: false
            },
            {
                field: "GRP",
                title: "№ грп",
                width: "75px",
                type: 'number'
            },
            {
                field: "ID",
                title: "№ макету",
                width: "100px",
                filterable: false,
                sortable: false
            },
            {
                field: "NAME",
                title: "Назва макету",
                width: "300px",
                filterable: false,
                sortable: false
            },
            {
                field: "NLS",
                title: "Рахунок А",
                width: "150px",
                filterable: false,
                sortable: false
            },
            {
                field: "BS",
                title: "БалР Б",
                width: "65px",
                filterable: false,
                sortable: false
            },
            {
                field: "OB",
                title: "ОБ22 Б",
                width: "65px",
                filterable: false,
                sortable: false
            },
            {
                field: "NAZN",
                title: "Попереднє призначення платежу",
                filterable: false,
                width: "30%",
                sortable: false
            },
            {
                template: "<div style='text-align:center;'>#=(DATP == null) ? ' ' : kendo.toString(DATP,'dd.MM.yyyy')#</div>",
                field: "DATP",
                title: "Дата поперед. виконання",
                width: "175px",
                filterable: false,
                sortable: false
            },
            {
                field: "ALG",
                title: "№ алг",
                width: "60px",
                filterable: false,
                sortable: false
            }
        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        dataBound: function () {
            var filterSource = [];
            var data = mainGridDataSource.data();
            for (i = 0; i < data.length; i++) {
                if (data[i].GRP != null)
                    filterSource.push(+data[i].GRP);
                else {
                    filterSource.push("без номера");
                }
            }
            filterSource = getUniqueArrValues(filterSource);

            selectFilter.setDataSource(new kendo.data.DataSource({ data: filterSource }));
        }
    };

    $("#gridMain").kendoGrid(mainGridOptions);

    $(".k-grid-custom-calculate").click(function () {
        var grid = $("#gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem == undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };
        goToCalculatePage(selectedItem);
    });

    selectFilter = $("#filterBox").kendoMultiSelect({
        dataSource: [],
        placeholder: "Фільтр по групам",
        autoClose: false,
        change: function () {
            var values = this.value();

            if (values === undefined || values == null || values == [] || $.trim(values) == "") {
                $("#btnClearFilter, #btnApplyFilter").attr('disabled', 'disabled');
            } else {
                $("#btnClearFilter, #btnApplyFilter").removeAttr("disabled");
            }

            var previous = this._savedOld;

            var current = this.value();
            var diff = [];
            if (previous) {
                diff = $(previous).not(current).get();
            }
            this._savedOld = current.slice(0);
            if (diff.length > 0) {
                $("#btnApplyFilter").trigger("click");
            }
        }
    }).data("kendoMultiSelect");

    $("#btnClearFilter").click(function () {
        selectFilter.value([]);
        selectFilter._savedOld = undefined;
        mainGridDataSource.filter({});
        mainGridDataSource.read();
        $("#btnClearFilter, #btnApplyFilter").attr('disabled', 'disabled');
    });

    $("#btnApplyFilter").click(function () {
        var filter = { logic: "or", filters: [] };
        var values = selectFilter.value();
        $.each(values, function (i, v) {
            var val = v.toString().toUpperCase() == "БЕЗ НОМЕРА" ? null : +v;
            filter.filters.push({ field: "GRP", operator: "eq", value: val });
        });
        mainGridDataSource.filter(filter);
        mainGridDataSource.read();
        $("#btnApplyFilter").attr('disabled', 'disabled');
    });

    //$($("#gridMain").data("kendoGrid").tbody).on("dblclick", "tr", openCalcPageWithRowDblClick);
    $("#gridMain").on("dblclick", "tr", openCalcPageWithRowDblClick);

    changeGridMaxHeight();
}

function changeGridMaxHeight() {
    var gridContent = $(".k-grid-content");
    if (gridContent === undefined) return;

    var a1 = gridContent.height();
    var a2 = gridContent.offset();
    if (a2 === undefined) return;
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    gridContent.css("max-height", a4 * 0.9);
};

function getUniqueArrValues(inputArr) {
    var a = inputArr;
    var b = {};
    for (var c = 0; c < a.length; c++) {
        if (a[c] != null)
            b[a[c]] = b[a[c]] ? (b[a[c]] + 1) : 1;
    }

    var res = [];
    for (var key in b) {
        res.push(key);
    }
    return res;
};

function openCalcPageWithRowDblClick() {
    var mainGrid = $("#gridMain").data("kendoGrid");
    var row = $(this).closest("tr");
    var dataItem = mainGrid.dataItem(row);

    goToCalculatePage(dataItem);
};

function goToCalculatePage(selectedItem) {
    var nls = selectedItem.NLS == null ? "" : selectedItem.NLS;

    var mode;
    if (nls == "") {
        mode = 4;
    } else {
        mode = 1;
    }

    var selectedRowData = {
        pMode: mode,
        pDk: selectedItem.DK,
        name: selectedItem.NAME,
        pNls: nls,
        pOb: selectedItem.OB,
        pBs: selectedItem.BS,
        nazn: selectedItem.NAZN,
        pGrp: selectedItem.GRP,
        indexParam: urlParamData
    };

    var urlPart = encodeURIComponent(JSON.stringify(selectedRowData));

    window.location.href = 'calculateStatic?params=' + urlPart;
};

function getUrlParameter(param) {
    var PageURL = window.location.search.substring(1);
    var URLVariables = PageURL.split('&');
    for (var i = 0; i < URLVariables.length; i++) {
        var ParameterName = URLVariables[i].split('=');
        if (ParameterName[0].toUpperCase() == param.toUpperCase()) {
            return ParameterName[1];
        }
    }
};

$(document).ready(function () {
    $("#title").html("Макети Юридичних осіб");

    urlParamData = getUrlParameter("filter");
    if (urlParamData === undefined || urlParamData == null) urlParamData = "";

    initMainGrid();
});