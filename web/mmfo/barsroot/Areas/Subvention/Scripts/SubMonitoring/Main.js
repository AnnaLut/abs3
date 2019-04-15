var cfg = {
    ie8: +isIE() === 8,
    pageInitalCount: 20,
    packagesGridSelector: '#packagesGrid',
    documentsGridSelector: '#documentsGrid',
    updatepackagesGrid: function () {
        this._updateGrid(this.packagesGridSelector);
    },
    updateDcoumentsGrid: function () {
        this._updateGrid(this.documentsGridSelector);
    },
    _updateGrid: function () {
        for (var i = 0; i < arguments.length; i++) {
            var grid = $(arguments[i]).data("kendoGrid");
            if (grid) {
                grid.dataSource.read();
                if (1 !== grid.dataSource.page()) {
                    grid.dataSource.page(1);
                }
            }
        }
    },
    currentFilters: {
        packagesGrid: {
            from: '',
            to: '',
            status: null
        },
        documentsGrid: {
            from: '',
            to: ''
        }
    },
    getPackagesFilteringData: function () {
        return cfg.currentFilters.packagesGrid;
    },
    getdocumentsFilteringData: function () {
        return cfg.currentFilters.documentsGrid;
    },
    PackagestStatusesDs: [
        { value: 1, name: "Очікує обробки" },
        { value: 2, name: "Помилка обробки" },
        { value: 6, name: "Оброблено" }
    ],
    DocumentsStatusesDs: [],
    getStatusObj: function (s) {
        var ds = this.PackagestStatusesDs;
        for (var i = 0; i < ds.length; i++) {
            if (+s === +ds[i].value) return ds[i];
        }
        return undefined;
    }
};

function initPackagesGrid() {
    var options = {
        filterable: true,
        pageable: {
            pageSizes: [10, 20, 50, 200, 1000, "All"]
        },
        columns: [
            {
                field: 'ExternalFileId',
                title: 'Ідентифікатор пакету',
                width: 120
            },
            {
                field: 'SysTime',
                title: 'Дата і час',
                width: 150,
                template: '#= SysTime ? SysTime.format("dd.MM.yyyy hh:mm:ss") : "" #',
                filterable: false
            },
            {
                field: 'StateText',
                title: 'Статус',
                width: 150,
                filterable: false
            }
        ],
        resizable: true,
        change: function (e) {
            grid = e.sender;
            var currentDataItem = grid.dataItem(this.select());
            var filterDdl = $('#filterByPackages').data('kendoDropDownList');
            var filterId = currentDataItem.ExternalFileId;
            filterDdl.value(filterId);
            cfg.updateDcoumentsGrid();
        },
        dataBound: function () {
            var ddl = $('#filterByPackages').data('kendoDropDownList');
            if (ddl) {
                var filterVal = ddl.value();
                selectFilteredRow(filterVal);
            }
        }
    };

    var dataSource = {
        pageSize: 10,
        requestEnd: function (e) {
            if (!e.response || !e.response.Data) return;

            var _pCount = e.response.Data.length;
            $('#packagesCount').text(_pCount);
        },
        transport: {
            read: {
                type: 'GET',
                url: bars.config.urlContent("/api/Subvention/SubMonitoring/SearchPackages"),
                data: cfg.getPackagesFilteringData
            }
        },
        schema: {
            model: {
                fields: {
                    Id: { type: 'number' },
                    UnitTypeId: { type: 'umber' },
                    ExternalFileId: { type: 'string' },
                    ReceiverUrl: { type: 'string' },
                    StateId: { type: 'number' },
                    FailuresCount: { type: 'number' },
                    Kf: { type: 'string' },
                    SysTime: { type: 'date' },
                    StateText: { type: 'string' },
                    State: { type: 'number' }
                }
            }
        },
        change: function () {
            var data = $(cfg.packagesGridSelector).data('kendoGrid').dataSource._data;
            if (data.length && data.length > 0) {
                $('#filterByPackages').closest('.inlineBlock').removeClass('invisible');
                var c = $.map(data, function (e) {
                    return {
                        id: e.ExternalFileId,
                        text: e.SysTime.format('dd.MM.yyyy hh:mm:ss')
                    };
                });

                $('#filterByPackages').kendoDropDownList({
                    dataTextField: 'text',
                    dataValueField: 'id',
                    template: '<span style="font-size:12px;">#:data.text#</span>',
                    valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
                    dataSource: c,
                    optionLabel: {
                        text: "Всі",
                        id: null
                    },
                    change: function (e) {
                        cfg.updateDcoumentsGrid();

                        var filterVal = e.sender.value();
                        selectFilteredRow(filterVal);
                    }
                });
            } else {
                $('#filterByPackages').closest('.inlineBlock').addClass('invisible');
            }
        }
    };
    createGrid(options, dataSource, cfg.packagesGridSelector);

    function selectFilteredRow(filterVal) {
        var a = $(cfg.packagesGridSelector + ' .k-grid-content').find('tr');
        for (var i = 0; i < a.length; i++) {
            var c = $('#packagesGrid').data('kendoGrid').dataItem(a[i]);
            $(a[i])[filterVal === c.ExternalFileId ? 'addClass' : 'removeClass']('k-state-selected');
        }
    }
}
function initDocumentsGrid() {
    var options = {
        excel: {
            fileName: "documents.xlsx",
            allPages: true,
            proxyURL: bars.config.urlContent('/Subvention/SubMonitoring/ConvertBase64ToFile/')
        },
        filterable: false,
        columns: [
            {
                field: 'Ref',
                title: 'Референс',
                width: 160,
                template: '#= getRefTemplate(Ref) #'
            },
            {
                field: 'Err',
                title: 'Опис помилки',
                width: 250
            },
            {
                title: 'Отримувач',
                columns: [
                    {
                        field: 'ReceiverAccNum',
                        title: 'Рахунок',
                        width: 150
                    },
                    {
                        field: 'ReceiverName',
                        title: 'Найменування',
                        width: 300
                    },
                    {
                        field: 'ReceiverIdentCode',
                        title: 'ОКПО',
                        width: 90
                    },
                    {
                        field: 'ReceiverBankCode',
                        title: 'МФО',
                        width: 75
                    },
                    {
                        field: 'ReceiverRnk',
                        title: 'РНК',
                        width: 90
                    }
                ]
            },
            {
                field: 'Amount',
                title: 'Сума грн',
                width: 150,
                template: '#= Amount ? Amount / 100 : "" #'
            },
            {
                field: 'FeeRate',
                title: 'Відсоток комісії',
                template: '#= FeeRate ? FeeRate / 100 : "" #',
                width: 150
            },
            {
                field: 'Purpose',
                title: 'Призначення',
                //width: 450
                width: 250
            },
            {
                title: 'Платник',
                columns: [
                    {
                        field: 'PayerAccNum',
                        title: 'Рахунок',
                        width: 150
                    },
                    {
                        field: 'PayerBankCode',
                        title: 'МФО',
                        width: 150
                    }
                ]
            },
            {
                field: 'SysTime',
                title: 'Дата і час',
                width: 180,
                temlate: '#= SysTime ? SysTime.format("dd.MM.yyyy hh:mm") : "" #'
            }
        ],
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var rowIndex = 2; rowIndex < sheet.rows.length; rowIndex++) {
                var row = sheet.rows[rowIndex];
                row.cells[0].format = "0";
            }
        }
    };
    var dataSource = {
        requestEnd: function (e) {
            if (!e.response || !e.response.Data) return;

            var template = '<labes class="k-label" style="margin-left:7px;">Всього: <label class="k-label lbl-bold">{totalCnt}</label> '
                + ' (<label class="k-label lbl-bold">{totalSum} грн.</label>)'
                + ' Успішно <label class="k-label lbl-bold">{okCnt}</label> (<label class="k-label lbl-bold">{okSum} грн.</label>), '
                + ' Помилки <label class="k-label lbl-bold">{errCnt}</label> (<label class="k-label lbl-bold">{errSum} грн.</label>)</label>';
            var totalSum = 0;
            var okSum = 0;
            var errSum = 0;
            var okCnt = 0;
            var errCnt = 0;
            for (var i = 0; i < e.response.Data.length; i++) {
                var cur = e.response.Data[i];
                totalSum += !cur.Amount ? 0 : cur.Amount / 100;
                if (cur.State === 0) {
                    okSum += !cur.Amount ? 0 : cur.Amount / 100;
                    okCnt++;
                } else {
                    errSum += !cur.Amount ? 0 : cur.Amount / 100;
                    errCnt++;
                }
            }
            template = template.replace('{totalCnt}', e.response.Data.length)
                .replace('{totalSum}', totalSum)
                .replace('{okSum}', okSum)
                .replace('{okCnt}', okCnt)
                .replace('{errSum}', errSum)
                .replace('{errCnt}', errCnt);

            $('#lblDocumentsCount').html(template);
        },
        transport: {
            read: {
                url: bars.config.urlContent("/api/Subvention/SubMonitoring/SearchDocuments"),
                data: function () {
                    var a = cfg.getdocumentsFilteringData();

                    var ddl = $('#filterByPackages').data('kendoDropDownList');
                    a.packageId = ddl ? ddl.value() : null;
                    return a;
                }
            }
        },
        schema: {
            model: {
                fields: {
                    ExtReqId: { type: 'string' },
                    ReceiverAccNum: { type: 'string' },
                    ReceiverName: { type: 'string' },
                    ReceiverIdentCode: { type: 'string' },
                    ReceiverBankCode: { type: 'string' },
                    ReceiverRnk: { type: 'number' },
                    Amount: { type: 'number' },
                    Purpose: { type: 'string' },
                    Signature: { type: 'string' },
                    ExtRowId: { type: 'number' },
                    Ref: { type: 'number' },
                    Err: { type: 'string' },
                    FeeRate: { type: 'number' },
                    PayerAccNum: { type: 'string' },
                    PayerBankCode: { type: 'string' },
                    PayType: { type: 'number' },
                    SysTime: { type: 'date' }
                }
            }
        }
    };
    createGrid(options, dataSource, cfg.documentsGridSelector);
}

function createGrid(options, dataSource, gridSelector) {
    options = $.extend(true, {
        autoBind: true,
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
        serverFiltering: true,
        serverPaging: true,
        serverSorting: true
    }, dataSource);

    var kendoDs = new kendo.data.DataSource(dataSource);
    options.dataSource = kendoDs;

    bars.ui.loader(gridSelector, true);
    $(gridSelector).kendoGrid(options);
}

function initDatePickers() {
    $('#date_from_documentsGrid, #date_from_packagesGrid, #date_to_documentsGrid, #date_to_packagesGrid').kendoDateTimePicker({
        format: "dd.MM.yyyy HH:mm",
        timeFormat: "HH:mm",
        interval: 15
    });

    $('[data-role="datetimepicker"]').attr('disabled', 'disabled');

    $('#date_from_documentsGrid, #date_from_packagesGrid, #date_to_documentsGrid, #date_to_packagesGrid').on('keyup', function (e) {
        if (e.keyCode === 13) {
            var btn = $(this).closest('.grid-title-div').find('button')[0];
            $(btn).trigger('click');
        }
    });
}

function addEventHandlers() {
    $('#btnRunJob').on('click', function () {
        bars.ui.confirm({ text: 'Ви впевнені, що хочете запустити обробку пакетів ?<hr style="margin:7px;"/>Зупинити обробку можна буде лише з бази даних.' }, function () {
            bars.ui.loader('body', true);
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/Subvention/SubMonitoring/RunJob"),
                success: function (data) {
                    var _text = 'Джоб по обробці прийнятих пакетів успішно запущено';
                    if (1 === +data) _text = 'Джоб працює!';

                    bars.ui.alert({ text: _text });
                },
                complete: function () {
                    bars.ui.loader('body', false);
                }
            });
        });
    });

    $('#btnRefresh').on('click', function () {
        cfg._updateGrid(cfg.documentsGridSelector, cfg.packagesGridSelector);
    });

    $('#btnPrintReport').on('click', function () {
        GetReportForm();
    });
}

function setGridsHeights() {
    var docHeight = $(document).height();

    var topGh = docHeight * 0.33 - 130;
    var bottomGh = docHeight * 0.45 - 130;

    $(cfg.packagesGridSelector + ' .k-grid-content').css("max-height", topGh < 100 ? 100 : topGh);
    $(cfg.documentsGridSelector + ' .k-grid-content').css("max-height", bottomGh < 150 ? 150 : bottomGh);
}

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
}

function initFilters() {
    var filters;
    var date = new Date();
    var dateFrom = new Date();
    dateFrom.setDate(dateFrom.getDate() - 1);

    var _filters = {
        from: dateFrom.format('dd.MM.yyyy 00:00:00'),
        to: date.format('dd.MM.yyyy 23:59:00')
    };

    filters = {
        packagesGrid: _filters,
        documentsGrid: Object.assign({}, _filters)
    };
    filters.packagesGrid.status = null;

    cfg.currentFilters = filters;

    $('#date_to_documentsGrid').data('kendoDateTimePicker').value(filters.documentsGrid.to.toString().toDateTime());
    $('#date_to_packagesGrid').data('kendoDateTimePicker').value(filters.packagesGrid.to.toString().toDateTime());

    $('#date_from_documentsGrid').data('kendoDateTimePicker').value(filters.documentsGrid.from.toString().toDateTime());
    $('#date_from_packagesGrid').data('kendoDateTimePicker').value(filters.packagesGrid.from.toString().toDateTime());
}

function downloadExcelFromGrid(id) {
    var grid = $('#' + id).data('kendoGrid');
    if (!grid.dataSource._data || !grid.dataSource._data.length) {
        bars.ui.alert({ text: 'Відсутні дані для вивантаження в excel.' });
    } else {
        grid.saveAsExcel();
    }
}

function filterGrid(gridId) {
    var _from = $('#date_from_' + gridId).data('kendoDateTimePicker').value();
    var _to = $('#date_to_' + gridId).data('kendoDateTimePicker').value();
    if (!validatePeriod(_from, _to)) return;

    cfg.currentFilters[gridId].from = _from.format('dd.MM.yyyy hh:mm:00');
    cfg.currentFilters[gridId].to = _to.format('dd.MM.yyyy hh:mm:00');

    if (gridId === 'documentsGrid') {
        if ($('#filterByPackages').data('kendoDropDownList'))
            $('#filterByPackages').data('kendoDropDownList').value('');
        //$(cfg.packagesGridSelector).data('kendoGrid')
    }

    cfg._updateGrid('#' + gridId);
}
function validatePeriod(_from, _to) {
    if (_from === null || _to === null) {
        bars.ui.error({ text: 'Необхідно заповнити період фільтрації !' });
        return false;
    }

    var from = new Date(_from);
    var to = new Date(_to);

    from.setSeconds(0, 0);
    to.setSeconds(0, 0);

    if (from > to) {
        bars.ui.alert({ text: 'Дата "З" <b>НЕ</b> може бути більшою за дату "По" !' });
        return false;
    }
    return true;
}

$(document).ready(function () {
    $('#title').html('Монетизація субсидій');

    $('#filterPackagesByStatus').kendoDropDownList({
        optionLabel: 'Всі',
        dataTextField: 'name',
        dataValueField: 'value',
        autoClose: true,
        dataSource: cfg.PackagestStatusesDs,
        change: function () {
            var a = $('#filterPackagesByStatus').data('kendoDropDownList').value();

            cfg.currentFilters.packagesGrid.status = a;
        }
    });

    initDatePickers();
    initFilters();

    initPackagesGrid();
    initDocumentsGrid();

    addEventHandlers();

    setGridsHeights();

    //cfg._updateGrid(cfg.documentsGridSelector, cfg.packagesGridSelector);
});