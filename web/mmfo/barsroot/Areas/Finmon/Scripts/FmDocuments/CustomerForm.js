function CustomerForm(func) {
    func = func || function () { };
    var _selectedItem = undefined;
    var gridSelector = '#customerSearchModalGrid';

    var kendoWindow = $('<div id="customerSearchWindow"/>').kendoWindow({
        actions: ["Close"],
        title: 'Оберіть Клієнта',
        resizable: false,
        modal: true,
        draggable: true,
        width: "850px",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function () {
            if (_selectedItem !== undefined) {
                func(_selectedItem);
            }
        },
        activate: function () {
            kendoWindow.find(':input:enabled:visible:first').focus();
            kendoWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    var pageInitalCount = 10;

    var dataSourceObj = {
        requestStart: function () {
            bars.ui.loader($('#customerSearchWindow').parent('.k-widget.k-window'), true);
        },
        requestEnd: function () {
            bars.ui.loader($('#customerSearchWindow').parent('.k-widget.k-window'), false);
        },
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/Finmon/FmDocumentsApi/GetClientsDict"),
                dataType: "json",
                data: function () {
                    var d = {
                        Rnk: $('#customerRnkFilter').val(),
                        Okpo: $('#customerOkpoFilter').val(),
                        Name: $('#customerNameFilter').val()
                    };
                    return d;
                }
            }
        },
        serverPaging: true,
        serverFiltering: true,
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    Rnk: { type: "number" },
                    Name: { type: "string" },
                    Okpo: { type: "string" }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        autoBind: true,
        dataSource: gridDataSource,
        pageable: {
            refresh: false,
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
            {
                field: "Rnk",
                title: "РНК",
                width: 100
            },
            {
                field: "Okpo",
                title: "ОКПО",
                width: 100
            },
            {
                field: "Name",
                title: "Найменування",
                width: 300
            }
        ],
        selectable: "row",
        editable: false,
        scrollable: false,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            kendoWindow.data("kendoWindow").refresh();

            var grid = $(gridSelector).data("kendoGrid");
            var count = grid.dataSource.total();
            if (count > 0)
                kendoWindow.find("#btnSelect").removeClass('invisible');
            else
                kendoWindow.find("#btnSelect").addClass('invisible');
        }
    };

    //kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnCancel").keydown(function (e) {
        if (e.which === 9) {
            e.preventDefault();
            kendoWindow.find(':input:enabled:visible:first').focus();
        }
    });

    kendoWindow.find(gridSelector).on("dblclick", "tr:not(:first)", function (event) {
        var mainGrid = kendoWindow.find(gridSelector).data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        _selectedItem = dataItem;
        kendoWindow.data("kendoWindow").close();
    });

    kendoWindow.find("#btnSelect").click(function () {
        var grid = kendoWindow.find(gridSelector).data("kendoGrid");

        if (grid === undefined) {
            bars.ui.alert({ text: "Для початку здійсніть пошук." });
            return;
        }

        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem === null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        _selectedItem = selectedItem;
        kendoWindow.data("kendoWindow").close();
    }).end();

    $(kendoWindow).on('keypress', function (e) {
        if (e.which === 13) {
            kendoWindow.find("#filter").click();
        }
    });

    kendoWindow.find("#filter").click(function (e) {
        if (!$('#customerRnkFilter').val() && !$('#customerNameFilter').val() && !$('#customerOkpoFilter').val()) {
            bars.ui.alert({ text: 'Для пошуку заповніть параметри !' });
            return;
        }

        kendoWindow.find(":focus:first").blur();

        if (!kendoWindow.find(gridSelector).data('kendoGrid')) {
            kendoWindow.find(gridSelector).kendoGrid(gridOptions);
        } else {
            gridDataSource.read();
        }
    });
    kendoWindow.find('#customerRnkFilter, #customerOkpoFilter').on('keydown', function (e) {
        validateNumber(e);
    });

    kendoWindow.data("kendoWindow").center().open();

    function getTemplate() {
        return filtersTemplate()
            + '<br/><hr class="modal-hr"><div id="customerSearchModalGrid" tabindex="-1"></div><br/>'
            + templateButtons();
    }

    function filtersTemplate() {
        return '<div class="form-group">'
            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="customerRnkFilter">РНК</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="customerRnkFilter" tabindex="101">'
            + '     </div>'

            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="customerOkpoFilter">ОКПО</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="customerOkpoFilter" tabindex="102">'
            + '     </div>'

            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="customerNameFilter">Найменування</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="customerNameFilter" tabindex="103">'
            + '     </div>'

            + ' </div><br/><br/><hr class="modal-hr">'

            + ' <div class="row" style="margin-left:3px;padding-bottom: 0px !important;">'
            + '     <div class="col-md-8">'
            + '         <label class="k-label">Для пошуку заповніть параметри та натисніть "Enter" або кнопку "Пошук".</label>'
            + '     </div>'
            + '     <div class="col-md-3">'
            + '          <div style="text-align:right;">'
            + '               <a class="k-button" title="Пошук клієнта" id="filter" tabindex="-1"><i class="pf-icon pf-16 pf-find"></i> Пошук</a>'
            + '          </div>'
            + '     </div>'
            + ' </div>';
    }

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '<div class="k-edit-buttons k-state-default">'
            + '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '<a id="btnSelect" class="k-button k-button-icontext k-primary k-grid-update modal-buttons invisible" tabindex="104"><span class="k-icon k-update"></span> Вибрати</a>'
            + '</div>'
            + '</div>';
    }
}



