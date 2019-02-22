function filtersForm() {
    this.open = function (properties) {
        bars.ui.loader('body', true);
        extendProperties(properties);
        initWindow();
    };

    this.selector = '#filtersWindow';
    this.closeWindow = function () {
        if (kendoWindow)
            kendoWindow.data('kendoWindow').close();
    };

    var kendoWindow, properties;

    function initWindow() {
        kendoWindow = $('<div id="filtersWindow"/>').kendoWindow({
            actions: ['Close'],
            title: 'Фільтр',
            resizable: false,
            modal: true,
            draggable: true,
            width: '850px',
            refresh: function () {
                this.center();
            },
            animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
            deactivate: function () {
                bars.ui.loader('body', false);
                this.destroy();
            },
            activate: function () {
                this.refresh();
                var a = kendoWindow.find('input');
                if (a.length)
                    $(a[0]).focus();
            }
        });

        var totalTemplate = getTemplate();
        var template = kendo.template(totalTemplate);

        kendoWindow.data('kendoWindow').content(template({}));

        var pageInitalCount = 10;

        var dataSourceObj = {
            type: 'webapi',
            transport: {
                read: {
                    url: properties.gridDsUrl,
                    dataType: 'json'
                }
            },
            pageSize: pageInitalCount,
            serverPaging: false,
            requestStart: function (e) {
            },
            requestEnd: function (e) {
                bars.ui.loader(kendoWindow, false);
                bars.ui.loader('body', false);
                kendoWindow.find('#filtersFormCbSelectAll').prop('checked', false);
            },
            schema: {
                data: 'Data',
                total: 'Total',
                model: {
                    fields: {
                        Selected: { type: 'boolean' },
                        Id: { type: 'string' },
                        Name: { type: 'string' }
                    }
                },
                parse: function (data) {
                    if (data && data.Data && data.Data.length) {
                        $.each(data.Data, function (idx, elem) {
                            elem.Selected = !!~properties.selectedIdArr.indexOf(elem.Id);
                        });
                    }
                    return data;
                }
            }
        };

        var gridDataSource = new kendo.data.DataSource(dataSourceObj);

        var gridOptions = {
            dataSource: gridDataSource,
            pageable: properties.pageable,
            reorderable: false,
            columns: [
                {
                    field: "Selected",
                    headerTemplate: '<input type="checkbox" id="filtersFormCbSelectAll" title="Виділти усі рядки" onclick="filtersForm.selectAll(this);"/>',
                    headerAttributes: {
                        style: 'text-align: center'
                    },
                    attributes: {
                        style: 'text-align: center;'
                    },
                    template: '<input type="checkbox" #= Selected ? "checked=checked" : "" # onclick="filtersForm.selectionChange(this);"/>',
                    width: 35
                },
                {
                    field: "Id", title: "Код", width: "80px",
                    attributes: {
                        style: 'text-align: center;'
                    },
                    headerAttributes: {
                        style: 'text-align: center'
                    }
                },
                { field: "Name", title: "Найменування" }
            ],
            selectable: false,
            editable: false,
            scrollable: false,
            noRecords: {
                template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
            },
            dataBound: function () {
                kendoWindow.data('kendoWindow').refresh();

                var mainGrid = $('#kendoWindowGrid').data('kendoGrid');
                var trInTbodyArr = $('#kendoWindowGrid').find('tr');
                if (trInTbodyArr.length <= 1) return;

                for (var i = 0; i < trInTbodyArr.length; i++) {
                    var selected = mainGrid.dataItem(trInTbodyArr[i]).Selected;
                    if (selected) $(trInTbodyArr[i]).addClass('k-state-selected');
                }

                var data = mainGrid.dataSource._data,
                    all = true;
                for (i = 0; i < data.length; i++) {
                    if (!data[i].Selected) {
                        all = false;
                        break;
                    }
                }
                kendoWindow.find('#filtersFormCbSelectAll').prop('checked', all);
                kendoWindow.data('kendoWindow').center().open();
            }
        };

        kendoWindow.find('#kendoWindowGrid').kendoGrid(gridOptions);

        if (properties.showDates) {
            $('#filtersWindowDateFrom, #filtersWindowDateTo').kendoDatePicker({
                format: "dd.MM.yyyy",
                dateInput: true,
                change: function () {
                    var value = this.value();
                    var today = new Date();

                    if (value === undefined || value === null || value === '')
                        this.value(today);
                }
            });

            $('#filtersWindowDateFrom').data('kendoDatePicker').value(properties.dateFrom);
            $('#filtersWindowDateTo').data('kendoDatePicker').value(properties.dateTo);
            $('#filtersWindowDateFrom, #filtersWindowDateTo').on('keyup', function (e) {
                if (e.keyCode === 13) {
                    kendoWindow.find("#btnSave").click();
                }
            });
        }

        kendoWindow.find('#btnCancel').click(function () {
            kendoWindow.data('kendoWindow').close();
        }).end();

        kendoWindow.find("#btnSave").click(function () {
            var results = [];

            var grid = kendoWindow.find('#kendoWindowGrid').data('kendoGrid');
            var data = grid.dataSource.data();
            for (var i = 0; i < data.length; i++) {
                if (data[i].Selected) results.push(data[i].Id);
            }

            var result = {
                idArr: results
            };
            if (properties.showDates) {
                result.period = {
                    from: $("#filtersWindowDateFrom").data("kendoDatePicker").value(),
                    to: $("#filtersWindowDateTo").data("kendoDatePicker").value()
                };
            }

            properties.func.call(null, result);
            if (properties.autoClose)
                kendoWindow.data('kendoWindow').close();
        }).end();

        kendoWindow.find('#btnSave').keypress(function (e) {
            if (e.which === 13)
                this.click();
        });

        kendoWindow.find('#filtersWindowGridTitle').text(properties.gridTitle);
    }

    function extendProperties(_properties) {
        _properties = _properties || {};
        properties = $.extend(true,
            {
                func: function () { },
                dateFrom: new Date(),
                dateTo: new Date(),
                showDates: true,
                gridDsUrl: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetRulesList'),
                gridTitle: '',
                pageable: {
                    refresh: true,
                    messages: {
                        empty: 'Дані відсутні',
                        allPages: 'Всі'
                    },
                    buttonCount: 5
                },
                autoClose: true,
                selectedIdArr: []
            },
            _properties
        );
    }
    function getTemplate() {
        var template = '<h1 id="filtersWindowGridTitle"></h1><div id="kendoWindowGrid"></div><br/>';
        if (properties.showDates)
            template = '<label for="filtersWindowDateFrom" style="margin:5px;">З</label><input id="filtersWindowDateFrom"/> <label for="filtersWindowDateTo" style="margin:5px;">По</label><input id="filtersWindowDateTo"/><hr style="margin:5px;"/>'
                + template;
        return template + templateButtons();
    }
    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Застосувати</a>'
            + '     </div>'
            + ' </div>';
    }
}


filtersForm.selectionChange = function (that) {
    var $this = $(that),
        grid = $this.closest('.k-grid.k-widget').data('kendoGrid'),
        tr = $this.closest('tr'),
        selectedItem = grid.dataItem(tr);

    selectedItem.Selected = $this.prop('checked');
    tr.toggleClass('k-state-selected');
    if (!$this.prop('checked')) {
        $('#filtersFormCbSelectAll').prop('checked', false);
    }
};
filtersForm.selectAll = function (that) {
    var $this = $(that),
        grid = $this.closest('.k-grid.k-widget').data('kendoGrid');

    $.each(grid.dataSource._data, function (indx, el) {
        el.Selected = $this.prop('checked');
    });
    grid.refresh();
};
