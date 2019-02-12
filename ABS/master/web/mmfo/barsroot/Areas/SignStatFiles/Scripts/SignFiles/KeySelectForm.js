function KeySelectForm(keysArray, cb) {
    var gridSelector = '#keySelectGrid', kendoWindow;
    var _selectedItem = undefined;

    var keysData = {
        Data: keysArray,
        Total: keysArray.length
    };

    kendoWindow = $('<div id="keySelectForm"/>').kendoWindow({
        actions: ['Close'],
        title: 'Оберіть ключ',
        resizable: false,
        modal: true,
        draggable: true,
        width: 500,
        refresh: function () {
            this.center();
        },
        deactivate: function () {
            //bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            this.refresh();
        },
        close: function () {
            if (!_selectedItem)
                bars.ui.loader('body', false);
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);

    kendoWindow.data('kendoWindow').content(template({}));

    var pageInitalCount = 5;

    var dataSourceObj = {
        data: keysData,
        pageSize: pageInitalCount,
        schema: {
            data: 'Data',
            total: 'Total',
            model: {
                fields: {
                    Name: { type: 'string' },
                    SubjectSN: { type: 'string' }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: true,
        reorderable: false,
        columns: [
            {
                field: 'Name', title: 'Назва'
            },
            {
                field: 'SubjectSN', title: 'Ідентифікатор'
            }
        ],
        editable: false,
        scrollable: true,
        selectable: 'row'
    };
    kendoWindow.data('kendoWindow').center().open();

    kendoWindow.find(gridSelector).kendoGrid(gridOptions);

    kendoWindow.find('#btnCancel').click(function () {
        kendoWindow.data('kendoWindow').close();
    }).end();

    kendoWindow.find("#btnSave").click(function () {
        var grid = kendoWindow.find(gridSelector).data('kendoGrid');
        var selected = grid.select();
        if (!selected) {
            bars.ui.alert({ text: 'Не вибрано жодного рядка!' });
            return;
        }

        _selectedItem = selected;

        if (cb && typeof cb === 'function')
            cb.call(null, grid.dataItem(selected));
        kendoWindow.data('kendoWindow').close();
    }).end();

    kendoWindow.find('#btnSave').keypress(function (e) {
        if (e.which === 13)
            this.click();
    });

    $(gridSelector).on("dblclick", "tr:not(:first)", function (event) {
        kendoWindow.find("#btnSave").click();
    });

    function getTemplate() {
        var template = '<div id="keySelectGrid"></div><br/>';
        return template + templateButtons();
    }
    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel" style="float:right;margin:5px;" tabindex="3"><span class="k-icon k-cancel"></span> Відмінити</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update" style="float:right;margin:5px;" tabindex="2"><span class="k-icon k-update"></span> Вибрати</a>'
            + '     </div>'
            + ' </div>';
    }
}
