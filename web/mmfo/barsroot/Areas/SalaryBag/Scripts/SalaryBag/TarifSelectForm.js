function tsForm(func) {
    func = func || function() { };
    var tsSelectedItem = undefined;


    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Оберіть тариф',
        resizable: false,
        modal: true,
        draggable: false,
        width: "850px",
        refresh: function() {
            this.center();
        },
        //height: "500px",
        animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
        deactivate: function() {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function() {
            if (tsSelectedItem !== undefined) {
                func(tsSelectedItem);
            }
        },
        activate: function() {
            kendoWindow.data("kendoWindow").refresh();
            kendoWindow.find("#tsModalGrid").kendoGrid(tsGridOptions);
        },
        refresh: function() {
            this.center();
        }
    });

    var totalTemplate = getTemplate();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    var pageInitalCount = 10;

    var dataSourceObj = {
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchTarifs"),
                dataType: "json"
            }
        },
        pageSize: pageInitalCount,
        requestStart: function(e) {
            //bars.ui.loader('.k-window:visible > .k-window-content:last', true);
            kendo.ui.progress(kendoWindow, true);
        },
        requestEnd: function(e) {
            //bars.ui.loader('.k-window:visible > .k-window-content:last', false);
            kendo.ui.progress(kendoWindow, false);
            bars.ui.loader(kendoWindow, false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    kod: { type: "number" },
                    kv: { type: "number" },
                    name: { type: "string" },
                    tar: { type: "number" },
                    pr: { type: "number" },
                    tip: { type: "number" }
                }
            }
        }
    };

    var tsGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var tsGridOptions = {
        dataSource: tsGridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        filterable: true,
        columns: [
            //{ field: "id", title: "ID договору", width: "90px" },
            { field: "kod", title: "Код тарифу", width: "100px" },
            { field: "kv", title: "Код валюти", width: "100px" },
            { field: "name", title: "Назва тарифу", width: "300px" },
            { field: "tar", title: "Сума за документ", width: "100px", template: "<div style='text-align:center;'>#=tar + ' грн.'#</div>" },
            { field: "pr", title: "% від суми документа", width: "125px", template: "<div style='text-align:center;'>#=(tip == 1) ? 'до ' + pr + '%' : pr + '%'#</div>" },
            { title: "&#9733;", width: "50px", template: '<a id="show_tarif_details" class="btn btn-primary custom-btn search-btn details-small-btn#=(tip != 1) ? " invisible" : ""#" title="Деталі шкального тарифу" tabindex="-1" onclick="rowDetailsClick(this)"></a>' }
            //   <a id="show_tarif_details" class="btn btn-primary custom-btn search-btn details-btn#=(tip != 1) ? " invisible" : ""#" title="Деталі шкального тарифу" tabindex="-1" onclick="rowDetailsClick(this)"></a>
            //   '<input type="button" class="details-btn#=(tip != 1) ? " invisible" : ""#" title="Деталі шкального тарифу" tabindex="-1" onclick="rowDetailsClick(this)">'
        ],
        selectable: "row",
        editable: false,
        scrollable: false,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function() {
            kendoWindow.data("kendoWindow").refresh();
        }
    };

    //kendoWindow.find("#tsModalGrid").kendoGrid(tsGridOptions);

    kendoWindow.find("#btnCancel").click(function() {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#tsModalGrid").on("dblclick", "tr:not(:first)", function(event) {

        var mainGrid = kendoWindow.find("#tsModalGrid").data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        tsSelectedItem = dataItem;
        kendoWindow.data("kendoWindow").close();
    });

    kendoWindow.find("#btnSave").click(function() {
        var grid = kendoWindow.find("#tsModalGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        tsSelectedItem = selectedItem;
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnSave").keypress(function(e) {
        if (e.which == 13)
            this.click();
    });

    kendoWindow.data("kendoWindow").center().open();
    bars.ui.loader(kendoWindow, true);

    function showDetails(e) {
        e.preventDefault();
        var dataItem = this.dataItem($(e.currentTarget).closest("tr"));
        showTarifDetails(dataItem.kod, dataItem.name);
    }

    function getTemplate() {
        return '<div id="tsModalGrid"></div><br/>'
            + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '<div class="k-edit-buttons k-state-default">'
            + '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '<a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Вибрати</a>'
            + '</div>'
            + '</div>';
    };
};

function rowDetailsClick(args) {
    var mainGrid = $("#tsModalGrid").data("kendoGrid");
    var row = $(args).closest("tr");
    var dataItem = mainGrid.dataItem(row);

    showTarifDetails(dataItem.kod, dataItem.name);
};

function showTarifDetails(tarifKod, tarifName) {
    bars.ui.loader('.k-window:visible > .k-window-content:last', true);

    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetTarifDetails"),
        data: {
            code: tarifKod
        },
        success: function(data) {
            bars.ui.loader('.k-window:visible > .k-window-content:last', false);
            if (!data.length) return;

            showDetailsWindow(data);
        },
        error: function() {
            bars.ui.loader('.k-window:visible > .k-window-content:last', false);
        }
    });

    function showDetailsWindow(data) {
        var kendoWindow = $("<div />").kendoWindow({
            actions: ["Close"],
            title: tarifName + '   (Код тарифу: ' + tarifKod + ')',
            resizable: false,
            modal: true,
            draggable: false,
            width: "850px",
            refresh: function() {
                this.center();
            },
            animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
            deactivate: function() {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function() {
                kendoWindow.data("kendoWindow").refresh();
            }
        });

        var totalTemplate = getTemplate(data);
        var template = kendo.template(totalTemplate);
        kendoWindow.data("kendoWindow").content(template({}));

        kendoWindow.find("#btnCancel").click(function() {
            kendoWindow.data("kendoWindow").close();
        }).end();

        kendoWindow.data("kendoWindow").center().open();
    };

    function getTemplate(data) {
        var tmp = '';
        if (data === undefined || data === null || !data.length || data.length === 0) return '';

        var count = data.length;
        for (var i = 0; i < count; i++) {
            var min = data[i].smin == null ? '-' : data[i].smin + ' грн.';
            var max = data[i].smax == null ? '-' : data[i].smax + ' грн.';
            var percent = data[i].pr == null ? '-' : data[i].pr + ' %';
            var constSum = data[i].sum_tarif == null ? '-' : data[i].sum_tarif + ' грн.';

            var sumLbl = '';
            if (i === count - 1) {
                sumLbl = 'понад ' + data[i - 1].sum_limit + ' грн.'
            } else if (i === 0) {
                sumLbl = 'до ' + data[i].sum_limit + ' грн.'
            } else {
                sumLbl = 'від ' + data[i - 1].sum_limit + ' грн. до ' + data[i].sum_limit + ' грн.';
            }

            tmp += '<div class="row" style="margin-left:3px;">'
                + '<div class="col-md-4 tarif-details-row-div">'
                + '<label class="k-label">' + sumLbl + '</label>'
                + '</div>'
                + '<div class="col-md-1 tarif-details-row-div">'
                + '<label class="k-label" >' + constSum + '</label>'
                + '</div>'
                + '<div class="col-md-1 tarif-details-row-div">'
                + '<label class="k-label">' + percent + '</label>'
                + '</div>'
                + '<div class="col-md-1 tarif-details-row-div">'
                + '<label class="k-label">' + min + '</label>'
                + '</div>'
                + '<div class="col-md-1 tarif-details-row-div">'
                + '<label class="k-label">' + max + '</label>'
                + '</div>'
                + '</div><hr style="margin:5px;"/>';
        }

        return headerTmp() + tmp + templateButtons();
    };

    function headerTmp() {
        return '<div class="row" style="margin-left:3px;">'
            + '<div class="col-md-4">'
            + '<label class="k-label bold-lbl">Сума документу</label>'
            + '</div>'
            + '<div class="col-md-1">'
            + '<label class="k-label bold-lbl">Сума по тарифу</label>'
            + '</div>'
            + '<div class="col-md-1">'
            + '<label class="k-label bold-lbl">Відсоток</label>'
            + '</div>'
            + '<div class="col-md-1">'
            + '<label class="k-label bold-lbl">Мінімум</label>'
            + '</div>'
            + '<div class="col-md-1">'
            + '<label class="k-label bold-lbl">Максимум</label>'
            + '</div>'
            + '</div><hr style="margin-bottom:5px;"/>';
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '<div class="k-edit-buttons k-state-default">'
            + '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '</div>'
            + '</div>';
    };
};


