function sdForm(func) {
    func = func || function() { };
    var sdSelectedItem = undefined;

    var kendoWindow = $('<div />').kendoWindow({
        actions: ["Close"],
        title: 'Оберіть Зарплатний договір',
        resizable: false,
        modal: true,
        draggable: false,
        width: "850px",
        refresh: function() {
            this.center();
        },
        //height: "600px",
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function() {
            bars.ui.loader('body', false);
            this.destroy();
        },
        close: function() {
            if (sdSelectedItem !== undefined) {
                func(sdSelectedItem);
            }
        },
        activate: function() {
            kendoWindow.find("#sdModalGrid").kendoGrid(rnkGridOptions);
            kendoWindow.find(':input:enabled:visible:first').focus();
            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function() {
            this.center();
        }
    });

    var totalTemplate = getSdTemplate();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    var pageInitalCount = 10;

    function getData() {

        var nmk = kendoWindow.find("#nmk_filter").val();
        var okpo = kendoWindow.find("#okpo_filter").val();
        var deal_id = kendoWindow.find("#deal_id_filter").val();

        var result = {
            nmk: nmk || '',
            okpo: okpo || '',
            deal_id: deal_id || ''
        }
        return result;
    };

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
                type: "POST",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchDeals"),
                dataType: "json",
                data: getData
            }
        },
        pageSize: pageInitalCount,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    deal_id: { type: "string" },
                    deal_name: { type: "string" },
                    okpo: { type: "string" },
                    nmk: { type: "string" }
                }
            }
        }
    };

    var sdGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var rnkGridOptions = {
        dataSource: sdGridDataSource,
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
                field: "deal_id",
                title: "Код договору",
                width: "100px"
            },
            {
                field: "deal_name",
                title: "Назва",
                width: "200px"
            },
            {
                field: "okpo",
                title: "ЄДРПОУ",
                width: "100px",
            },
            {
                field: "nmk",
                title: "Клієнт",
                width: "200px"
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

            var grid = $("#sdModalGrid").data("kendoGrid");
            var count = grid.dataSource.total();
            if (count > 0)
                kendoWindow.find("#btnSelect").removeClass('invisible');
            else
                kendoWindow.find("#btnSelect").addClass('invisible');
        }
    };

    //kendoWindow.find("#sdModalGrid").kendoGrid(rnkGridOptions).end();

    kendoWindow.find("#btnCancel").click(function() {
        kendoWindow.data("kendoWindow").close();
    }).end();
    kendoWindow.find("#btnCancel").keydown(function(e) {
        if (e.which == 9) {
            e.preventDefault();
            kendoWindow.find(':input:enabled:visible:first').focus();
        }
    });

    kendoWindow.find("#sdModalGrid").on("dblclick", "tr:not(:first)", function(event) {
        var mainGrid = kendoWindow.find("#sdModalGrid").data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        sdSelectedItem = dataItem;
        kendoWindow.data("kendoWindow").close();
    });

    kendoWindow.find("#btnSelect").click(function() {
        var grid = kendoWindow.find("#sdModalGrid").data("kendoGrid");

        if (grid === undefined) {
            bars.ui.alert({ text: "Для початку здійсніть пошук." });
            return;
        }

        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null || selectedItem === undefined) {
            bars.ui.alert({ text: "Не вибрано жодного рядка." });
            return;
        };

        sdSelectedItem = selectedItem;
        kendoWindow.data("kendoWindow").close();
    }).end();

    $(kendoWindow).on('keypress', function(e) {
        if (e.which == 13) {
            kendoWindow.find("#filter").click();
        }
    });

    kendoWindow.find("#filter").click(function(e) {
        kendoWindow.find(":focus:first").blur();

        var tmpGrid = kendoWindow.find("#sdModalGrid").data("kendoGrid");

        //var filter = { logic: "or", filters: [] };

        //if (_rnk !== '')
        //    filter.filters.push({ field: "rnk", operator: "eq", value: +_rnk });
        //if (_okpo !== '')
        //    filter.filters.push({ field: "okpo", operator: "eq", value: _okpo });
        //if (_name !== '')
        //    filter.filters.push({ field: "nmk", operator: "contains", value: _name });

        //rnkGridDataSource.filter(filter);
        //rnkGridDataSource.read();


        if (tmpGrid === undefined) {
            kendoWindow.find("#sdModalGrid").kendoGrid(rnkGridOptions).end();
            kendoWindow.data("kendoWindow").refresh();
        } else {
            tmpGrid.setDataSource(sdGridDataSource);

            tmpGrid.dataSource.read();
            tmpGrid.refresh();
        }
    });

    kendoWindow.find("#rnk_filter").kendoNumericTextBox({
        min: 0,
        spinners: false,
        decimals: 0,
        restrictDecimals: true,
        format: "#"
    });

    kendoWindow.data("kendoWindow").center().open();
    bars.ui.loader(kendoWindow, true);

    bindSelectOnFocus();

    function getSdTemplate() {
        return sdFiltersTemplate()
            + '<br/><hr class="modal-hr"><div id="sdModalGrid" tabindex="-1"></div><br/>'
            + templateButtons();
    };

    function sdFiltersTemplate() {
        return '<div class="form-group">'
            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="nmk_filter">Назва клієнта</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="nmk_filter" tabindex="101">'
            + '     </div>'

            + ' <div class="col-md-3" style="margin:3px;">'
            + '     <label class="k-label" for="okpo_filter">ЄДРПОУ</label><br />'
            + '     <input type="text" class="k-textbox k-input" id="okpo_filter" tabindex="102">'
            + ' </div>'

            + '     <div class="col-md-3" style="margin:3px;">'
            + '         <label class="k-label" for="deal_id_filter">Код зарплатного договору</label><br />'
            + '         <input type="text" class="k-textbox k-input" id="deal_id_filter" tabindex="103">'
            + '     </div>'
            + ' </div><br/><br/><hr class="modal-hr">'

            + ' <div class="row" style="margin-left:3px;padding-bottom: 0px !important;">'
            + '     <div class="col-md-8">'
            + '         <label class="k-label">Для нового пошуку заповніть параметри пошуку та натисніть "Enter" або кнопку "Пошук".</label>'
            + '         <br />'
            + '         <label class="k-label">Для фільтрування результатів використовуйте фільтри у таблиці.</label>'
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



