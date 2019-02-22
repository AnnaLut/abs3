function dictForm() {
    var gridSelector = '#dictWindowGrid';
    this.selector = '#dictsWindow';
    var kendoWindow, properties;

    this.open = function (props) {
        extendProperties(props);
        initWindow();
        if (!properties.selectable) kendoWindow.find('#btnSave').css('display', 'none');
    };

    this.closeWindow = function () {
        if (kendoWindow)
            kendoWindow.data('kendoWindow').close();
    };

    function initWindow() {
        kendoWindow = $('<div id="dictsWindow"/>').kendoWindow({
            actions: ['Close'],
            title: properties.title,
            resizable: false,
            modal: true,
            draggable: true,
            width: properties.width,
            height: properties.height,
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
                    url: properties.dictName ? properties.gridDsUrl + '?dictName=' + properties.dictName + '&Code=' : properties.gridDsUrl,
                    dataType: 'json'
                }
            },
            pageSize: pageInitalCount,
            serverPaging: properties.serverPaging,
            serverFiltering: properties.serverFiltering,
            serverSorting: properties.serverSorting,
            requestStart: function (e) {
            },
            requestEnd: function (e) {
                bars.ui.loader(kendoWindow, false);
            },
            schema: {
                data: 'Data',
                total: 'Total',
                model: {
                    fields: properties.fields
                },
                parse: properties.dsParse || function (e) { return e; }
            }
        };

        var gridDataSource = new kendo.data.DataSource(dataSourceObj);

        var gridOptions = {
            dataSource: gridDataSource,
            pageable: properties.pageable,
            autoBing: false,
            reorderable: false,
            columns: properties.columns,
            editable: false,
            scrollable: true,
            sortable: true,
            filterable: true,
            selectable: 'row',
            noRecords: {
                template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
            },
            dataBound: function () {
                bars.ui.loader(properties.parent, false);
                kendoWindow.data('kendoWindow').center().open();
            }
        };

        bars.ui.loader(properties.parent, true);
        kendoWindow.find(gridSelector).kendoGrid(gridOptions);

        // function from common.js
        changeGridMaxHeight(0.7, gridSelector);

        if (properties.filter) {
            kendoWindow.find('#dictFilters').removeClass('invisible');
        }

        kendoWindow.find('#btnCancel').click(function () {
            kendoWindow.data('kendoWindow').close();
        }).end();

        kendoWindow.find("#btnSave").click(function () {
            if (!properties.selectable) return;

            var grid = kendoWindow.find(gridSelector).data('kendoGrid');
            var selected = grid.select();
            if (!selected) {
                bars.ui.alert({ text: 'Не вибрано жодного рядка!' });
                return;
            }
            properties.func.call(null, grid.dataItem(selected));
            kendoWindow.data('kendoWindow').close();
        }).end();

        kendoWindow.find('#btnSave').keypress(function (e) {
            if (e.which === 13)
                this.click();
        });

        $(gridSelector).on("dblclick", "tr:not(:first)", function (event) {
            kendoWindow.find("#btnSave").click();
        });
    }

    function extendProperties(_properties) {
        _properties = _properties || {};
        properties = $.extend(true,
            {
                func: function () { },
                gridDsUrl: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDict'),
                dictName: '',
                filter: false,
                title: 'Довідник',
                pageable: {
                    refresh: false,
                    messages: {
                        empty: 'Дані відсутні',
                        allPages: 'Всі'
                    },
                    buttonCount: 5,
                    numeric: true
                },
                serverPaging: false,
                serverFiltering: false,
                serverSorting: false,
                width: '70%',
                fields: {
                    Code: { type: 'string' },
                    Name: { type: 'string' }
                },
                columns: [
                    { field: "Code", title: "Код", width: 80 },
                    { field: "Name", title: "Найменування" }
                ],
                parent: 'body',
                selectable: true
            },
            _properties
        );
    }
    function getTemplate() {
        var template = '<div id="dictWindowGrid"></div><br/>';
        if (properties.filter)
            template = '<div id="dictFilters" class="invisible">'
                + '         <label for="dictCodeFilter">Код</label>'
                + '         <input type="text" class="k-textbox" id="dictCodeFilter"/>'
                + '         <label for="dictNameFilter">Найменування</label>'
                + '         <input type="text" class="k-textbox" id="dictNameFilter"/>'
                + '         <hr/> '
                + '     </div>' + template;
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
