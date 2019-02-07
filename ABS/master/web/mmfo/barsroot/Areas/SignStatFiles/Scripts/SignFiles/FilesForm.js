function FilesForm(types, cb) {
    var gridSelector = '#filesFormGrid', kendoWindow;

    kendoWindow = $('<div id="filesForm"/>').kendoWindow({
        actions: ['Close'],
        title: 'Завантаження файлу',
        resizable: false,
        modal: true,
        draggable: true,
        width: 500,
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            this.refresh();
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
                url: bars.config.urlContent("/api/SignStatFiles/SignFiles/GetFilesForDownload"),
                data: {
                    fileTypes: JSON.stringify(types)
                },
                dataType: 'json'
            }
        },
        pageSize: pageInitalCount,
        requestStart: function (e) {
        },
        requestEnd: function (e) {
            bars.ui.loader(kendoWindow, false);
        },
        schema: {
            data: 'Data',
            total: 'Total',
            model: {
                fields: {
                    Name: { type: 'string' },
                    Date: { type: 'string' },
                    FullPath: { type: 'string' }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: true,
        autoBing: false,
        reorderable: false,
        columns: [
            {
                field: 'Name', title: 'Назва файлу'
            },
            {
                field: 'Date', title: 'Звітна дата'
            }
        ],
        editable: false,
        scrollable: true,
        selectable: 'row',
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            bars.ui.loader(kendoWindow, false);
        }
    };
    kendoWindow.data('kendoWindow').center().open();

    bars.ui.loader(kendoWindow, true);
    kendoWindow.find(gridSelector).kendoGrid(gridOptions);

    // function from common.js
    changeGridMaxHeight(0.7, gridSelector);


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
        var template = '<div id="filesFormGrid"></div><br/>';
        return template + templateButtons();
    }
    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span> Відмінити</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Вибрати</a>'
            + '     </div>'
            + ' </div>';
    }
}
