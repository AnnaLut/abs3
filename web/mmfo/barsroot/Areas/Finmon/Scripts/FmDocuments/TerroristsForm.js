function TerroristsForm(otm) {
    var kendoWindow = $('<div id="TerroristWindowDiv"/>').kendoWindow({
        actions: ['Close'],
        title: 'Повний перелік назв ЮО/ФО, пов\'язаних зі здійсненням терористичної діяльності',
        resizable: false,
        modal: true,
        draggable: true,
        width: '65%',
        height: 'auto',
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var totalTemplate = mainTemplate() + templateButtons();
    var template = kendo.template(totalTemplate);
    kendoWindow.data("kendoWindow").content(template({})).center().open();

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();
    initGrid();

    function initGrid() {
        bars.ui.loader(kendoWindow, true);
        var dataSourceObj = {
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetTerroristsList'),
                    dataType: 'json',
                    data: { otm: otm }
                }
            },
            serverPaging: true,
            pageSize: 20,
            requestEnd: function (e) {
                bars.ui.loader('body', false);
                bars.ui.loader(kendoWindow, false);
            },
            schema: {
                data: 'Data',
                total: 'Total',
                model: {
                    fields: {
                        Origin: { type: 'string' },
                        C1: { type: 'number' },
                        C2: { type: 'date' },
                        C4: { type: 'numer' },
                        C6: { type: 'string' },
                        C7: { type: 'string' },
                        C8: { type: 'string' },
                        C9: { type: 'string' },
                        C13: { type: 'string' },
                        C34: { type: 'string' },
                        C20: { type: 'string' },
                        C5: { type: 'string' },
                        C37: { type: 'string' },
                        NameHash: { type: 'string' }
                    }
                }
            }
        };

        var gridDataSource = new kendo.data.DataSource(dataSourceObj);

        var gridOptions = {
            dataSource: gridDataSource,
            autoBind: true,
            pageable: {
                refresh: false,
                messages: {
                    empty: "Дані відсутні",
                    allPages: "Всі"
                },
                pageSize: 20,
                pageSizes: [20, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            columns: [
                { field: 'Origin', title: 'Довідник', width: 75 },
                { field: 'C1', title: 'Номер особи</br>в довіднику', width: 110 },
                { field: 'C6', title: 'Прізвище резидента/ім`я 1</br>нерезидента/найменування', width: 200 },
                { field: 'C7', title: 'Ім`я резидента/ім`я 2</br>нерезидента', width: 200 },
                { field: 'C8', title: 'По батькові резидента/ім`я 3</br>нерезидента', width: 200 },
                { field: 'C9', title: 'Ім`я 4</br>нерезидента', width: 200 },
                {
                    field: 'C2', title: 'Дата внесення</br>до Переліку', width: 120,
                    template: '#= C2.format() #'
                },
                { field: 'C13', title: 'Дата народження', width: 120 },
                { field: 'C34', title: 'Адреса', width: 350 },
                { field: 'C20', title: 'Документ', width: 100 },
                { field: 'C4', title: 'Тип особи', width: 100 },
                { field: 'C5', title: 'Джерело, відповідно до якого</br>особу внесено до Переліку', width: 350 },
                { field: 'C37', title: 'Додаткова інформація', width: 650 }
            ],
            reorderable: true,
            selectable: 'row',
            editable: false,
            scrollable: true,
            filterable: false,
            sortable: false,
            noRecords: {
                template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
            },
            dataBound: function () {
                kendoWindow.data("kendoWindow").refresh();
            }
        };


        kendoWindow.find('#terroristsList').kendoGrid(gridOptions);

        changeGridMaxHeight(0.85, '#terroristsList');
    }

    function mainTemplate() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div id="terroristsList"></div>'
            + ' </div>';
    }

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Закрити</a>'
            + '     </div>'
            + ' </div>';
    }

    function checkLenParams(value, defaultVal) {
        if (!value) return defaultVal;
        if (value < 0) return defaultVal;

        return value;
    }
}

