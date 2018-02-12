function selectClientForm(zpDealId, func) {
    func = func || function() { };
    var _selectedItem = undefined;
    var gridSelector = '#clientSearchModalGrid';

    var kendoWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'Оберіть Клієнта',
        resizable: false,
        modal: true,
        draggable: false,
        width: "850px",
        refresh: function() {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function() {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function() {
            if (_selectedItem !== undefined) {
                func(_selectedItem);
            }
        },
        activate: function() {
            kendoWindow.find(gridSelector).kendoGrid(gridOptions).end();
            kendoWindow.find(':input:enabled:visible:first').focus();
            kendoWindow.data("kendoWindow").refresh();
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
        requestStart: function() {
            kendo.ui.progress(kendoWindow, true);
        },
        requestEnd: function() {
            kendo.ui.progress(kendoWindow, false);
        },
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchClientsByZpDeal"),
                dataType: "json",
                data: {
                    zpDealId: zpDealId
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
                    okpo: { type: "string" },
                    nmk: { type: "string" },
                    nls: { type: "string" },
                    mfo: { type: "string" }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
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
                field: "nmk",
                title: "ПІБ клієнта",
                width: "280px"
            },
            {
                field: "okpo",
                title: "ІПН",
                width: "120px"
            },
            {
                field: "nls",
                title: "Рахунок",
                width: "100px",
            },
            {
                field: "mfo",
                title: "МФО",
                width: "100px"
            }
        ],
        selectable: "row",
        editable: false,
        scrollable: false,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function() {
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

    kendoWindow.find("#btnCancel").click(function() {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnCancel").keydown(function(e) {
        if (e.which == 9) {
            e.preventDefault();
            kendoWindow.find(':input:enabled:visible:first').focus();
        }
    });

    kendoWindow.find(gridSelector).on("dblclick", "tr:not(:first)", function(event) {
        var mainGrid = kendoWindow.find(gridSelector).data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        _selectedItem = dataItem;
        kendoWindow.data("kendoWindow").close();
    });

    kendoWindow.find("#btnSelect").click(function() {
        var grid = kendoWindow.find(gridSelector).data("kendoGrid");

        if (grid === undefined) {
            bars.ui.alert({ text: "Для початку здійсніть пошук." });
            return;
        }

        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        _selectedItem = selectedItem;
        kendoWindow.data("kendoWindow").close();
    }).end();

    $(kendoWindow).on('keypress', function(e) {
        if (e.which == 13) {
            kendoWindow.find("#filter").click();
        }
    });

    kendoWindow.find("#filter").click(function(e) {
        kendoWindow.find(":focus:first").blur();

        var _nmk = kendoWindow.find("#client_pib_filter").val();
        var _okpo = kendoWindow.find("#client_ipn_filter").val();
        var _nls = kendoWindow.find("#client_nls_filter").val();

        var tmpGrid = kendoWindow.find(gridSelector).data("kendoGrid");

        var filter = { logic: "or", filters: [] };
        if (_okpo !== '')
            filter.filters.push({ field: "okpo", operator: "eq", value: _okpo });
        if (_nmk !== '')
            filter.filters.push({ field: "nmk", operator: "contains", value: _nmk });
        if (_nls !== '')
            filter.filters.push({ field: "nls", operator: "eq", value: _nls });

        gridDataSource.filter(filter);
        gridDataSource.read();
    });

    kendoWindow.data("kendoWindow").center().open();
    bars.ui.loader(kendoWindow, true);

    bindSelectOnFocus();

    function getTemplate() {
        return filtersTemplate()
            + '<br/><hr class="modal-hr"><div id="clientSearchModalGrid" tabindex="-1"></div><br/>'
            + templateButtons();
    };

    function filtersTemplate() {
        return '<div class="form-group">'
            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="client_pib_filter">ПІБ клієнта</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="client_pib_filter" tabindex="101">'
            + '     </div>'

            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="client_ipn_filter">ІПН</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="client_ipn_filter" tabindex="102">'
            + '     </div>'

            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="client_nls_filter">Номер рахунку</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="client_nls_filter" tabindex="103">'
            + '     </div>'

            + ' </div><br/><br/><hr class="modal-hr">'

            + ' <div class="row" style="margin-left:3px;padding-bottom: 0px !important;">'
            + '     <div class="col-md-8">'
            + '         <label class="k-label">Для фільтрування даних заповніть параметри пошуку та натисніть "Enter" або кнопку "Пошук".</label>'
            + '     </div>'
            + '     <div class="col-md-3">'
            + '          <div style="text-align:center;">'
            + '               <input type="button" class="btn btn-primary custom-btn search-btn" style="margin:0px;" title="Пошук клієнта" id="filter" tabindex="-1"></input>'
            + '               <label class="k-label" for="filter" style="margin-left:10px;">Пошук</label>'
            + '          </div>'
            + '     </div>'
            + ' </div>';
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '<div class="k-edit-buttons k-state-default">'
            + '<a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="105"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '<a id="btnSelect" class="k-button k-button-icontext k-primary k-grid-update modal-buttons invisible" tabindex="104"><span class="k-icon k-update"></span> Вибрати</a>'
            + '</div>'
            + '</div>';
    };

    function bindSelectOnFocus() {
        $("input").bind("focus", function() {
            var input = $(this);
            clearTimeout(input.data("selectTimeId"));

            var selectTimeId = setTimeout(function() {
                input.select();
            });

            input.data("selectTimeId", selectTimeId);
        }).blur(function(e) {
            clearTimeout($(this).data("selectTimeId"));
        });
    };
};



