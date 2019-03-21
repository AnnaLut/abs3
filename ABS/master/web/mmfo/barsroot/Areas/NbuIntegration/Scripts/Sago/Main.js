var cfg = {
    ie8: +isIE() === 8,
    pageInitalCount: 20,
    importsGridSelector: '#importsGrid',
    receivedDocsGridSelector: '#receivedDocsGrid',
    updateImportsGrid: function () {
        this._updateGrid(this.importsGridSelector);
    },
    updateDcoumentsGrid: function () {
        this._updateGrid(this.receivedDocsGridSelector);
    },
    _updateGrid: function () {
        for (var i = 0; i < arguments.length; i++) {
            var grid = $(arguments[i]).data("kendoGrid");
            if (grid) {
                grid.dataSource.read();
            }
        }
    },
    currentFilters: {
        importsGrid: {
            from: '',
            to: ''
        },
        receivedDocsGrid: {
            from: '',
            to: ''
        }
    },
    getImportsFilteringData: function () {
        return cfg.currentFilters.importsGrid;
    },
    getReceivedDocsFilteringData: function () {
        return cfg.currentFilters.receivedDocsGrid;
    },
    ImportStatusesDs: [],
    DocumentsStatusesDs: [],
    getStatusObj: function (s) {
        var ds = this.ImportStatusesDs;
        for (var i = 0; i < ds.length; i++) {
            if (+s === +ds[i].value) return ds[i];
        }
        return undefined;
    }
};

function getCommentTemplate(comment, data) {
    comment = comment || '';
    if (data) {
        var a = '<a class="error-btn" title="Переглянути деталі"><i class="pf-icon pf-16 pf-help"></i></a>';

        return a + comment;
    }
    return comment || '';
};

function initImportsGrid() {
    var options = {
        pageable: {
            pageSizes: [10, 20, 50, 200, 1000, "All"],
        },
        columns: [
            {
                field: 'Id',
                title: '№',
                width: 120,
                attributes: {
                    style: "text-align: left;"
                },
                headerAttributes: {
                    style: "text-align: left;"
                }
            },
            {
                field: 'CreateDate',
                title: 'Дата і час',
                width: 150,
                template: '#= CreateDate ? CreateDate.format("dd.MM.yyyy hh:mm:ss") : "" #',
                filterable: false,
                attributes: {
                    style: "text-align: center;"
                },
                headerAttributes: {
                    style: "text-align: center;"
                }
            },
            {
                field: 'DocCount',
                title: 'Документів всього',
                width: 250
            },
            {
                field: 'DocCountPayed',
                title: 'Документів створено',
                width: 250
            },
            {
                field: 'UserName',
                title: 'Користувач',
                width: 250
            },
            {
                field: 'State',
                title: 'Статус',
                width: 150,
                template: '#= getStatusTemplate(State) #',
                filterable: {
                    ui: createSelect,
                    extra: false
                }
            },
            {
                field: 'Comment',
                title: 'Примітка',
                width: 500,
                template: '#= getCommentTemplate(Comment, Data) #'
            }
        ],
        resizable: true,
        change: function (e) {
            grid = e.sender;
            var currentDataItem = grid.dataItem(this.select());
            var filterId = null;

            var filterDdl = $('#filterByImports').data('kendoDropDownList');

            if (currentDataItem && currentDataItem.DocCount > 0) {
                filterId = currentDataItem.Id;
                filterDdl.value(filterId);
                cfg.updateDcoumentsGrid();
            } else {
                if (filterDdl.value()) {
                    filterDdl.value(filterId);
                    cfg.updateDcoumentsGrid();
                }
            }
        },
        dataBound: function () {
            var ddl = $('#filterByImports').data('kendoDropDownList');
            if (ddl) {
                var filterVal = ddl.value();
                selectFilteredRow(filterVal);
            }
        }
    };

    function createSelect(element) {
        element.kendoDropDownList({
            optionLabel: '--Оберіть значення--',
            dataTextField: 'name',
            dataValueField: 'value',
            autoClose: true,
            dataSource: cfg.ImportStatusesDs
        });
    }

    var dataSource = {
        pageSize: 10,
        transport: {
            read: {
                url: bars.config.urlContent("/api/NbuIntegration/Sago/SearchImports"),
                data: cfg.getImportsFilteringData
            }
        },
        schema: {
            model: {
                fields: {
                    Id: { type: 'number' },
                    State: { type: 'number' },
                    UserId: { type: 'number' },
                    DocCount: { type: 'number' },
                    DocCountPayed: { type: 'number' },
                    Comment: { type: 'string' },
                    UserName: { type: 'string' },
                    CreateDate: { type: 'date' },
                    Data: { type: 'string' }
                }
            }
        },
        change: function () {
            $('#filterByImports').closest('.inlineBlock').removeClass('invisible');

            var c = $.map($(cfg.importsGridSelector).data('kendoGrid').dataSource._data, function (e) {
                if (e.DocCount > 0 && +e.State < 10)
                    return {
                        id: e.Id,
                        date: e.CreateDate ? e.CreateDate.format("dd.MM.yyyy hh:mm:ss") : ""
                    };
            });

            $('#filterByImports').kendoDropDownList({
                dataTextField: 'date',
                dataValueField: 'id',
                template: '#= "№ <b>" + id + "</b> За дату <b>" + date + "</b>" #',
                valueTemplate: '#= "№  <b>" + id + "</b>" #',

                dataSource: c,
                optionLabel: {
                    date: "Всі",
                    id: null
                },
                change: function (e) {
                    cfg.updateDcoumentsGrid();

                    var filterVal = e.sender.value();
                    selectFilteredRow(filterVal);
                }
            });
        }
    };
    createGrid(options, dataSource, cfg.importsGridSelector);

    $(cfg.importsGridSelector).data('kendoGrid').bind("filterMenuInit", function (e) {
        if (e.field == 'State') {
            e.container.find('.k-filter-help-text').css('text-align', 'center');
            e.container.find('span.k-dropdown:first').remove();
        }
    });

    $(cfg.importsGridSelector).on('click', '.error-btn', function () {
        var grid = $(cfg.importsGridSelector).data('kendoGrid');
        var row = $(this).closest('tr');

        var dataItem = grid.dataItem(row);
        showSimpleWindow({
            title: 'Деталі помилки',
            showData: dataItem.Data
        });
    });

    function selectFilteredRow(filterVal) {
        var a = $('#importsGrid .k-grid-content').find('tr');
        for (var i = 0; i < a.length; i++) {
            var c = $('#importsGrid').data('kendoGrid').dataItem(a[i]);
            $(a[i])[filterVal == c.Id ? 'addClass' : 'removeClass']('k-state-selected');
        }
    };
};
function initReceivedDocsGrid() {
    var options = {
        columns: [
            {
                field: 'Ref',
                title: 'Реф АБС',
                width: 120,
                template: '#= getRefTemplate(Ref) #',
                attributes: {
                    style: "text-align: center;"
                }
            },
            {
                field: 'RefSago',
                title: 'Ід. Операції',
                width: 120
            },
            {
                field: 'OperationCode',
                title: 'Код операції',
                width: 125
            },
            {
                field: 'OperationType',
                title: 'Тип операції',
                width: 150
            },
            {
                field: 'OperationDate',
                title: 'Дата операції',
                width: 150,
                template: '#= OperationDate ? OperationDate.format("dd.MM.yyyy hh:mm:ss") : "" #',
                attributes: {
                    style: "text-align: center;"
                },
                headerAttributes: {
                    style: "text-align: center;"
                }
            },
            {
                field: 'TotalSum',
                title: 'Сума операції(грн)',
                width: 200,
                template: '#= convertToMoneyStr(TotalSum / 100, 2) #',
                attributes: {
                    style: "text-align: right;"
                }
            },
            {
                field: 'RegionId',
                title: 'Код регіону(області)',
                width: 180
            },
            {
                field: 'OperationState',
                title: 'Стан операції',
                width: 200
            },
            {
                field: 'PermissionNumber',
                title: '№ дозволу',
                width: 150
            },
            {
                field: 'PermissionDate',
                title: 'Дата дозволу',
                width: 130,
                template: '#= PermissionDate ? PermissionDate.format("dd.MM.yyyy") : "" #',
                attributes: {
                    style: "text-align: center;"
                }
            },
            {
                field: 'PibReg',
                title: 'П.І.Б.',
                width: 250
            },
            {
                field: 'UserId',
                title: 'AD-ідентифікатор',
                width: 160
            }
        ]
    };
    var dataSource = {
        transport: {
            read: {
                url: bars.config.urlContent('/api/NbuIntegration/Sago/SearchReceivedDocs'),
                data: function () {
                    var a = cfg.getReceivedDocsFilteringData();

                    var ddl = $('#filterByImports').data('kendoDropDownList');
                    a.requestId = ddl ? ddl.value() : null;
                    return a;
                }
            }
        },
        schema: {
            model: {
                fields: {
                    OperationDate: { type: 'date' },
                    PermissionDate: { type: 'date' },
                    TotalSum: { type: 'number' },
                    OperationType: { type: 'number' },
                    RegionId: { type: 'number' },
                    Ref: { type: 'string' },
                    RefSago: { type: 'number' },
                    RequestId: { type: 'number' },
                    Id: { type: 'number' },
                    OperationState: { type: 'string' },
                    PermissionNumber: { type: 'string' },
                    OperationCode: { type: 'string' },
                    PibReg: { type: 'string' },
                    UserId: { type: 'string' }
                }
            }
        }
    };
    createGrid(options, dataSource, cfg.receivedDocsGridSelector);
};

function createGrid(options, dataSource, gridSelector) {
    options = $.extend(true, {
        autoBind: false,
        pageable: {
            refresh: false,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [10, cfg.pageInitalCount, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        selectable: "row",
        editable: false,
        scrollable: true,
        filterable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        change: function () {
        },
        dataBound: function (e) {
            //var grid = e.sender;
            //var newVal = 0 == grid.dataSource.total() ? "hidden" : "auto";
            //grid.wrapper.find('.k-grid-content').css("overflow", newVal);
        }
    }, options);

    var reFunc = function () {
        bars.ui.loader(gridSelector, false);
    };
    if (dataSource.requestEnd && typeof dataSource.requestEnd == 'function') {
        var a = dataSource.requestEnd;
        delete dataSource.requestEnd;

        reFunc = function () {
            a.apply(this, arguments);
            bars.ui.loader(gridSelector, false);
        };
    }

    dataSource = $.extend(true, {
        type: "webapi",
        transport: {
            read: {
                dataType: "json"
            }
        },
        pageSize: cfg.pageInitalCount,
        schema: {
            data: "Data",
            total: "Total"
        },
        requestEnd: reFunc,
        serverFiltering: false,
        serverPaging: false,
        serverSorting: false
    }, dataSource);

    var kendoDs = new kendo.data.DataSource(dataSource);
    options.dataSource = dataSource;

    bars.ui.loader(gridSelector, true);
    $(gridSelector).kendoGrid(options);
}

function initDatePickers() {
    $('#date_from_receivedDocsGrid, #date_from_importsGrid, #date_to_receivedDocsGrid, #date_to_importsGrid').kendoDatePicker({
        format: "dd.MM.yyyy",
        value: '',
        dateInput: true
    });

    $('#date_from_receivedDocsGrid, #date_from_importsGrid, #date_to_receivedDocsGrid, #date_to_importsGrid').on('change', dateChangeFn);
    $('#date_from_receivedDocsGrid, #date_from_importsGrid, #date_to_receivedDocsGrid, #date_to_importsGrid').on('keyup', function (e) {
        if (e.keyCode == 13) {
            var btn = $(this).closest('.grid-title-div').find('button')[0];
            $(btn).trigger('click');
        }
    });
};

function addEventHandlers() {
    $('#btnImportDocuments').on('click', function () {
        dateSelectForm(function (date) {
            var _date = new Date(date);

            bars.ui.loader('body', true);
            $.ajax({
                type: "GET",
                url: bars.config.urlContent('/api/nbuintegration/nbuservice/GetDataFromNbu?date=' + _date.format('yyyyMMdd') + '&userName='),
                //data: {
                //    date: _date.format('yyyyMMdd')
                //},
                success: function (data) {
                    if (!data.ErrMsg) {
                        var _id = data.id;

                        var str = 'Імпорт даних за <b>' + _date.format() + '</b></br>'
                            + 'Всього документів : <b>' + data.CountDocs + '</b></br>'
                            + 'Імпортовано : <b>' + data.CountDocsInserted + '</b></br>'
                            + 'На суму : <b>' + convertToMoneyStr(data.TotalSum / 100) + '</b>';

                        if (data.CountDocs != data.CountDocsInserted) {
                            str += '</br></br>Раніше було імпортовано : <b>' + (data.CountDocs - data.CountDocsInserted) + '</b> документів';
                        }

                        bars.ui.notify('Імпорт даних', str, 'success', { autoHideAfter: 5 * 1000 });
                    } else
                        showBarsErrorAlert(data.ErrMsg);
                },
                complete: function () {
                    bars.ui.loader('body', false);
                    cfg._updateGrid(cfg.receivedDocsGridSelector, cfg.importsGridSelector);
                }
            });
        });
    });

    $('#btnRefresh').on('click', function () {
        cfg._updateGrid(cfg.receivedDocsGridSelector, cfg.importsGridSelector);
    });
};

function setGridsHeights() {
    var docHeight = $(document).height();

    var iGh = docHeight * 0.3 - 130;
    var dGh = docHeight * 0.55 - 130;

    $(cfg.importsGridSelector + ' .k-grid-content').css("max-height", iGh < 100 ? 100 : iGh);
    $(cfg.receivedDocsGridSelector + ' .k-grid-content').css("max-height", dGh < 150 ? 150 : dGh);
};

function getStatusTemplate(status, ddl) {
    ddl = ddl || false;
    var statusObj = cfg.getStatusObj(status);

    //return '<div style="text-align:' + (ddl ? 'left' : 'center') + ';" title="' + statusObj.name + '"><i class="atatat pf-icon pf-16 ' + statusObj.imgClass + '"></i>' + (ddl ? statusObj.name : '') + '</div>';
    return '<div style="text-align:' + (ddl ? 'left' : 'center') + ';" title="' + statusObj.name + '">' + statusObj.name + '</div>';
};

function getRefTemplate(ref) {
    if (!ref) return '';

    var refs = ref.toString().split(',');
    var tmp = [];

    for (var i = 0; i < refs.length; i++) {
        if (refs[i])
            tmp.push('<a class="abs-document-ref" href="#" onclick="openDoc(' + refs[i].trim() + ');return false;">' + refs[i].trim() + '</a>');
    }

    var a = tmp.join('</br>');
    return a;
};

function initFilters() {
    var filters;
    var date = new Date();
    var dateFrom = new Date();
    dateFrom.setDate(dateFrom.getDate() - 7);

    var _filters = {
        from: dateFrom.format(),
        to: date.format()
    }

    filters = {
        importsGrid: _filters,
        receivedDocsGrid: Object.assign({}, _filters)
    }

    cfg.currentFilters = filters;

    $('#date_to_receivedDocsGrid').data('kendoDatePicker').value(filters.receivedDocsGrid.to.toString().toDate());
    $('#date_to_importsGrid').data('kendoDatePicker').value(filters.importsGrid.to.toString().toDate());

    $('#date_from_receivedDocsGrid').data('kendoDatePicker').value(filters.receivedDocsGrid.from.toString().toDate());
    $('#date_from_importsGrid').data('kendoDatePicker').value(filters.importsGrid.from.toString().toDate());
};

function filterGrid(gridId) {
    var _from = $('#date_from_' + gridId).data('kendoDatePicker').value();
    var _to = $('#date_to_' + gridId).data('kendoDatePicker').value();
    if (!validatePeriod(_from, _to)) return;

    cfg.currentFilters[gridId].from = _from.format();
    cfg.currentFilters[gridId].to = _to.format();

    if (gridId == 'receivedDocsGrid') {
        if ($('#filterByImports').data('kendoDropDownList'))
            $('#filterByImports').data('kendoDropDownList').value('');
    }

    cfg._updateGrid('#' + gridId);
};
function validatePeriod(_from, _to) {

    if (_from == null || _to == null) {
        bars.ui.error({ text: 'Необхідно заповнити період фільтрації !' });
        return false;
    }

    var from = new Date(_from);
    var to = new Date(_to);

    from.setHours(0, 0, 0, 0);
    to.setHours(0, 0, 0, 0);

    if (from > to) {
        bars.ui.alert({ text: 'Дата "З" <b>НЕ</b> може бути більшою за дату "По" !' });
        return false;
    }
    return true;
};

function preInitForm(cb) {
    bars.ui.loader('body', true);

    // в Promise.all передаємо масив промісів, котрі необхідно виконати до завантаження даних у гріди на формі (наприклад підгрузка масивів статусів)
    Promise.all([
        getStatusesPromise('ImportStatusesDs')
        //getStatusesPromise('DocumentsStatusesDs')
    ]).then(
        function (result) {
            bars.ui.loader('body', false);
            if (cb && typeof cb == 'function') {
                cb.apply();
            }
        },
        function (error) {
            var errorText = 'Метод : ' + error.name + '</br>' + error.text;

            showBarsErrorAlert(errorText);
            bars.ui.loader('body', false);
        });
};

function getStatusesPromise(dsName) {
    var promise = new Promise(
        function (resolve, reject) {
            $.ajax({
                global: false,
                type: "GET",
                url: bars.config.urlContent("/api/NbuIntegration/Sago/" + dsName),
                success: function (data) {
                    cfg[dsName] = data;
                    resolve(true);
                },
                error: function (xhr) {
                    var text;
                    if (xhr.status == 401)
                        document.location.reload();
                    else if (xhr.status == 403)
                        window.location = $.parseJSON(xhr.responseText).LogOnUrl;
                    else if (xhr.status == 400 || xhr.status == 404 || xhr.status == 500) {
                        if (xhr.responseJSON && xhr.responseJSON.Message) text = parseJsonError(xhr.responseJSON);
                        else text = replaseResponseText(xhr.responseText);
                    } else if (xhr.status == 502)
                        document.location.refresh();

                    reject({
                        text: text,
                        name: dsName
                    });
                }
            });
        });

    return promise;
};

$(document).ready(function () {
    $("#title").html("Реєстр документів САГО");

    initDatePickers();
    initFilters();

    initImportsGrid();
    initReceivedDocsGrid();

    addEventHandlers();

    setGridsHeights();

    preInitForm(function () {
        cfg._updateGrid(cfg.receivedDocsGridSelector, cfg.importsGridSelector);
    });
});