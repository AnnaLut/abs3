var previousBankDate,
    filter = {
        form: null,
        filteringData: {
            statuses: [],
            rules: [],
            period: {
                from: null,
                to: null
            },
            formType: null,
            customFilters: '',
            showBlockedOnly: false
        },
        runSelectCommand: function () {
            updateSearchStatus();
            this.getCurrentFiltersString();
            getDocumentsCount();
        },
        clearUserFilters: function () {
            this.filteringData.customFilters = '';
            this.runSelectCommand();
        },
        getGridFilters: function () {
            var a = {
                statuses: this.filteringData.statuses,
                rules: this.filteringData.rules,
                from: this.filteringData.period.from.format(),
                to: this.filteringData.period.to.format(),
                formType: this.filteringData.formType,
                customFilters: this.filteringData.customFilters,
                showBlockedOnly: this.filteringData.showBlockedOnly
            };
            return a;
        },
        getCurrentFiltersString: function () {
            var _rules = $.map(this.filteringData.rules, function (el) {
                return '<b>' + el + '</b>';
            });
            var _statuses = $.map(this.filteringData.statuses, function (el) {
                return '<b>' + el + '</b>';
            });

            var str1 = 'Період відбору документів з <b>' + this.filteringData.period.from.format() + '</b> по <b>' + this.filteringData.period.to.format() + '</b>';
            str1 += _rules.length > 0 ? '</br>Правила ФМ ' + _rules.join(', ') : '';
            str1 += _statuses.length > 0 ? '</br>Статус документів ' + _statuses.join(', ') : '';
            str1 += $('#showBlockedOnly').prop('checked') ? '</br><b>Заблоковані</b>' : '';

            $('#displayFiltersDateRule').html(str1);
        }
    },
    formCfg = {
        mainGridSelector: '#documentsGrid',
        pageInitalCount: 50,
        selectedAll: false,
        reloadGrid: function (clearFilter) {
            var _ds = $(this.mainGridSelector).data("kendoGrid").dataSource;
            if (clearFilter)
                _ds._filter = null;
            _ds.read();
        },
        refreshGrid: function () {
            var grid = $(this.mainGridSelector).data("kendoGrid").refresh();
        },
        searchLbl: undefined
    },
    singleFmRulesEditor = new singleFmRulesEditor();

$(document).ready(function () {
    getGlobalFilterType();
    filter.form = new filtersForm();

    preInitForm(function () {
        filter.getCurrentFiltersString();
        initMainGrid();
        checkAccess();
        filterByRules();
        formCfg.searchLbl = $('#searchStatus');
    });
});

function getRefTemplate(ref) {
    if (!ref) return '';

    return '<a title="Відкрити картку документу ' + ref + '" href="#" ondblclick="openDoc(' + ref + ');">' + ref + '</a>';
}

function initMainGrid() {
    function getToolBar() {
        return [
            { template: '<a class="k-button" title="Перечитати дані" id="btnReload" onclick="toolBarBtnClick(this);" ><i class="pf-icon pf-16 pf-reload_rotate"></i></a>' },
            { template: '<a class="k-button" title="Фільтр по правилам ФМ" id="btnRulesFilter" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-filter2"></i></a>' },
            { template: '<a class="k-button" title="Фільтр по статусам" id="btnStatusesFilter" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-find"></i></a>' },
            { template: '<a class="k-button" title="Інформація по документу" id="btnViewDocumentInformation" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-folder_open"></i></a>' },
            { template: '<a class="buttons-separator"</a>' },
            { template: '<a class="k-button" title="Відправити" id="btnSend" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-visa_back"></i></a>' },
            { template: '<a class="k-button" title="Встановити статус документу &quot;Повідомлено&quot;" id="btnSetStatusReported" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-REPAIR"></i></a>' },
            { template: '<a class="k-button" title="Вилучити" id="btnExculde" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-remove"></i></a>' },
            { template: '<a class="k-button" title="Відкласти" id="btnSetASide" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-arrow_down"></i></a>' },
            { template: '<a class="buttons-separator"</a>' },
            { template: '<a class="k-button" title="Розблокувати" id="btnUnlock" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-lock_delete"></i></a>' },
            { template: '<a class="k-button" title="Перегляд даних з переліку осіб, підозрюваних у тероризмі" id="btnTeroristList" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-report_open"></i></a>' },
            { template: '<a class="k-button" title="Фільтр" id="btnFilter" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-filter-ok"></i></a>' },
            { template: '<a class="k-button" title="Скасувати всі фільтри" id="btnClearAllFilters" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-filter-remove"></i></a>' },
            { template: '<a class="k-button" title="Вивантажити усі сторінки" id="btnExcelExport" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-exel"></i></a>' },
            { template: '<a class="buttons-separator"</a>' },
            { template: '<a class="k-button" title="Параметри фінансового моніторингу" id="btnFmMonitoringParams" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-folder_open-execute"></i></a>' },
            { template: '<a class="k-button" title="Пакетне встановлення параметрів" id="btnBulkParametersSet" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-folder_open-favorite"></i></a>' },
            { template: '<a class="k-button" title="Історія змін" id="btnChangesHistory" onclick="toolBarBtnClick(this);"><i class="pf-icon pf-16 pf-book"></i></a>' },
            { template: '<div title="Показувати тільки заблоковані документи" style="display:inline;margin-left:7px;"><input style="vertical-align: middle;height: 15px;margin: 0px;" type="checkbox" id="showBlockedOnly"><label class="k-label" style="margin-left:7px;" for="showBlockedOnly" >Заблоковані</label></div>' }
        ];
    }

    var dataSourceObj = {
        type: 'webapi',
        transport: {
            read: {
                url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDocuments'),
                dataType: 'json',
                data: function () {
                    var a = filter.getGridFilters();
                    return {
                        _filter: JSON.stringify(a)
                    };
                }
            }
        },
        serverPaging: true,
        serverFiltering: true,
        pageSize: formCfg.pageInitalCount,
        requestStart: function (e) {
            $(formCfg.mainGridSelector).data('kendoGrid').dataSource.data([]);
        },
        requestEnd: function (e) {
            bars.ui.loader('body', false);
            var allCb = $('#cbSelectAll');
            if (allCb.prop('checked')) {
                allCb.trigger('click');
                allCb.prop('checked', false);
            }
        },
        schema: {
            data: 'Data',
            total: 'Total',
            model: {
                fields: {
                    Selected: { type: 'boolean' },
                    Id: { type: 'number' },
                    Ref: { type: 'number' },
                    Tt: { type: 'string' },
                    Nd: { type: 'string' },
                    DateD: { type: 'date' },
                    NlsA: { type: 'string' },
                    Sum: { type: 'number' },
                    SumEquivalent: { type: 'number' },
                    Lcv: { type: 'string' },
                    MfoA: { type: 'string' },
                    Dk: { type: 'number' },
                    NlsB: { type: 'string' },
                    Sum2: { type: 'number' },
                    SumEquivalent2: { type: 'number' },
                    Lcv2: { type: 'string' },
                    MfoB: { type: 'string' },
                    Sk: { type: 'number' },
                    VDate: { type: 'date' },
                    Nazn: { type: 'string' },
                    Status: { type: 'string' },
                    Otm: { type: 'string' },
                    Tobo: { type: 'string' },
                    OprVid2: { type: 'string' },
                    OprVid3: { type: 'string' },
                    Fio: { type: 'string' },
                    InDate: { type: 'date' },
                    Comments: { type: 'string' },
                    Rules: { type: 'string' },
                    StatusName: { type: 'string' },
                    NameA: { type: 'string' },
                    NameB: { type: 'string' },
                    Sos: { type: 'number' },
                    Fv2Agg: { type: 'string' }
                }
            },
            parse: function (data) {
                if (data && data.length) {
                    $.each(data.Data, function (idx, elem) {
                        elem.Selected = false;
                    });
                }
                return data;
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        toolbar: getToolBar(),
        dataSource: gridDataSource,
        autoBind: false,
        serverPaging: true,
        pageable: {
            refresh: false,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSize: formCfg.pageInitalCount,
            pageSizes: [30, 50, 200, 1000, "All"],
            buttonCount: 5
        },
        reorderable: false,
        columns: [
            {
                field: "Selected",
                headerTemplate: '<input type="checkbox" id="cbSelectAll" title="Виділти усі рядки на поточній сторінці" onclick="selectAll(this);"/>',
                template: '<input type="checkbox" class="selectRow" #= Selected || formCfg.selectedAll ? "checked=checked" : "" # onclick="selectionChange(this);"/>',
                width: 35,
                filterable: false,
                sortable: false
            },
            {
                field: 'Rules',
                title: 'Правила',
                width: 100,
                template: '#= singleRowRulesViewTemplate(Rules, Ref) #'
            },
            {
                field: 'Ref',
                title: 'Референс',
                width: 110,
                template: '#= getRefTemplate(Ref) #'
            },
            {
                field: 'StatusName',
                title: 'Статус',
                width: 100,
                template: '#= getStatusTemplate(StatusName) #'
            },
            {
                field: 'Tt',
                title: 'Оп.',
                width: 75
            },
            {
                field: 'Nd',
                title: 'Номер</br>документа',
                width: 125
            },
            {
                field: 'DateD',
                title: 'Дата</br>документа',
                width: 120,
                template: '#= formatDateForGrid(DateD) #'
            },
            {
                field: 'NlsA',
                title: 'Рахунок-А',
                width: 120
            },
            {
                field: 'MfoA',
                title: 'МФО-А',
                width: 110
            },
            {
                field: 'NlsB',
                title: 'Рахунок-Б',
                width: 120
            },
            {
                field: 'MfoB',
                title: 'МФО-Б',
                width: 110
            },
            {
                field: 'Sum',
                title: 'Сума',
                width: 125,
                attributes: {
                    style: 'text-align: right;'
                }
            },
            {
                field: 'SumEquivalent',
                title: 'Сума документа</br>(еквівалент)',
                width: 150,
                attributes: {
                    style: 'text-align: right;'
                }
            },
            {
                field: 'Lcv',
                title: 'Вал-А',
                width: 100
            },
            {
                field: 'OprVid2',
                title: 'Ознака ОМ',
                width: 150
                ///////// ????
            },
            {
                field: 'Fv2Agg',
                title: 'Додаткові коди ОМ',
                width: 170
                ///////// ????
            },
            {
                field: 'OprVid3',
                title: 'Ознака ВМ',
                width: 150
                ///////// ????
            },
            {
                field: 'Sk',
                title: 'СКП',
                width: 100
                ///////// ????
            },
            {
                field: 'Nazn',
                title: 'Призначення',
                width: 450
            },
            {
                field: 'Dk',
                title: 'Д/К',
                width: 75
            },
            {
                field: 'Sum2',
                title: 'Сума-Б',
                width: 125,
                attributes: {
                    style: 'text-align: right;'
                }
            },
            {
                field: 'SumEquivalent2',
                title: 'Сума Б</br>(еквівалент)',
                width: 150,
                attributes: {
                    style: 'text-align: right;'
                }
            },
            {
                field: 'Lcv2',
                title: 'Вал-Б',
                width: 100
            },
            {
                field: 'VDate',
                title: 'Дата</br>валют.',
                width: 150,
                template: '#= formatDateForGrid() #'
            },
            {
                field: 'Tobo',
                title: 'Відділення',
                width: 160
            },
            {
                field: 'Fio',
                title: 'Повідомив',
                width: 150
            },
            {
                field: 'InDate',
                title: 'Дата</br>реєстрації',
                width: 120,
                template: '#= formatDateForGrid(InDate) #'
            },
            {
                field: 'Comments',
                title: 'Коментар',
                width: 300
            },
            {
                field: 'Otm',
                title: '№ особи в</br>переліку осіб',
                width: 130
            },
            {
                field: 'NameA',
                title: 'Клієнт А',
                width: 300
            },
            {
                field: 'NameB',
                title: 'Клієнт Б',
                width: 300
            }
        ],
        selectable: true,
        editable: false,
        scrollable: true,
        filterable: true,
        resizable: true,
        sortable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль, нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            var mainGrid = $(formCfg.mainGridSelector).data("kendoGrid");
            var trInTbodyArr = $(formCfg.mainGridSelector).find("tr");
            if (trInTbodyArr.length <= 1) return;

            for (var i = 0; i < trInTbodyArr.length; i++) {
                var sos = +mainGrid.dataItem(trInTbodyArr[i]).Sos;
                switch (sos) {
                    case -2:
                        $(trInTbodyArr[i]).addClass('text-brown');
                        break;
                    case -1:
                        $(trInTbodyArr[i]).addClass('text-red');
                        break;
                    case 0:
                        $(trInTbodyArr[i]).addClass('text-blue');
                        break;
                    case 1:
                        $(trInTbodyArr[i]).addClass('text-green');
                        break;
                    case 3:
                        $(trInTbodyArr[i]).addClass('text-dark-blue');
                        break;
                }

                var nlsa = mainGrid.dataItem(trInTbodyArr[i]).NlsA;
                var nlsb = mainGrid.dataItem(trInTbodyArr[i]).NlsB;

                if ((nlsa && nlsa.indexOf("3720") === 0 || nlsb && nlsb.indexOf("3720") === 0) && sos !== 5) {
                    $(trInTbodyArr[i]).addClass('text-green');
                }
            }
        }
    };

    $(formCfg.mainGridSelector).kendoGrid(gridOptions);
    changeGridMaxHeight(0.77, formCfg.mainGridSelector);

    $('#showBlockedOnly').on('change', function () {
        filter.filteringData.showBlockedOnly = this.checked;
        filter.runSelectCommand();
    });
}

function showRulesInfoDict(ids, ref) {
    var arrayIds = ids.split(',');
    arrayIds = $.map(arrayIds, function (v) {
        return +v;
    });

    var dict = new dictForm();
    dict.open({
        gridDsUrl: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetRulesList'),
        dsParse: function (data) {
            if (data && data.Data && data.Data.length) {
                var newDs = $.map(data.Data, function (elem) {
                    if (arrayIds.indexOf(elem.Id) !== -1) return elem;
                });
                return { Data: newDs, Total: newDs.length };
            }
        },
        filter: false,
        title: 'Правила відбору по документу реф. <b>' + ref + '</b>',
        fields: { Id: { type: 'string' }, Name: { type: 'string' } },
        columns: [{
            field: "Id", title: "Код", width: "80px",
            attributes: { style: 'text-align: center;' },
            headerAttributes: { style: 'text-align: center' }
        },
        { field: "Name", title: "Найменування" }],
        parent: 'body',
        selectable: false,
        width: '850px'
    });
}

function singleRowRulesViewTemplate(rules, ref) {
    if (rules === undefined || rules === null || rules.trim() === '') return '';

    var onclick = "showRulesInfoDict('" + rules.trim() + "' , '" + ref + "');";
    var title = 'title="Перегляд правил фінансового моніторингу для документу реф. ' + ref + '"';
    return '<a style="min-width: auto; border: none;background: transparent;" class="k-button" ' + title + ' onclick="' + onclick + '"><i class="pf-icon pf-16 pf-book"></i></a>';
}

function getStatusTemplate(status) {
    if (status && status === '-') return '';
    return status;
}

var toolBarClickHandlers = {
    btnReload: function () {
        formCfg.searchLbl.addClass('invisible');
        formCfg.reloadGrid(true);
    },
    btnRulesFilter: filterByRules,
    btnStatusesFilter: filterByStatuses,
    btnViewDocumentInformation: function () {
        checkIfRowsAreSelected(function () {
            openDoc(this.Ref);
        }, false);
    },
    btnSend: function () {
        checkIfRowsAreSelected(function () {
            var count = this.length,
                _this = this;

            bars.ui.confirm({
                text: 'Відправити документи (к-ть. ' + count + ') ?'
            }, function () {
                bars.ui.loader('body', true);
                $.ajax({
                    url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/SendDocuments'),
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(_this),
                    success: function (res) {

                        bars.ui.alert({ text: 'Документи успішно відправлено.' }, function () {
                            formCfg.reloadGrid();
                        });

                        //if (+res > 0) {
                        //    bars.ui.alert({ text: 'Успішно відправлено ' + res + ' документів з ' + count + ' вибраних.' }, function () {
                        //        formCfg.reloadGrid();
                        //    });
                        //} else {
                        //    bars.ui.alert({ text: 'Не відправлено жодного документу.' });
                        //}
                    },
                    complete: function () {
                        bars.ui.loader('body', false);
                    }
                });
            });
        }, true);
    },
    btnSetStatusReported: function () {
        checkIfRowsAreSelected(function () {
            var _this = this, that = [],
                templateHtml = '<p>Коментар до документів з реф. :</p><div class="div-with-refferences">';

            for (var i = 0; i < _this.length; i++) {
                if (strIsNullOrEmpty(_this[i].Status) && strIsNullOrEmpty(_this[i].Otm))
                    that.push(_this[i]);
            }

            if (that.length <= 0) {
                bars.ui.alert({ text: 'Для вибраних документів встановлення статусу "Повідломлено" неможливе.' });
                return;
            } else {
                templateHtml += $.map(that, function (e) { return e.Ref; }).join(', ');
                templateHtml += '</div>';
            }

            eacForm({
                title: 'Коментар до документів',
                minLength: 5,
                customTemplate: templateHtml,
                okFunc: function (e) {
                    bars.ui.loader('body', true);
                    $.ajax({
                        url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/SetStatusReported'),
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ Documents: that, Comment: e.reason }),
                        success: function () {
                            bars.ui.alert({ text: 'Успішно!' }, function () { formCfg.reloadGrid(); });
                        },
                        complete: function () {
                            bars.ui.loader('body', false);
                        }
                    });
                }
            });
        }, true);
    },
    btnExculde: function () {
        checkIfRowsAreSelected(function () {
            var count = this.length;
            changeStatus({
                checkRow: function (row) {
                    return strIsNullOrEmpty(row.Status) || ~["I", "S", "N"].indexOf(row.Status);
                },
                noRowsText: 'Вибрані документи неможливо вилучити',
                confirmText: 'Вилучити документи (к-ть. ' + count + ') ?',
                method: 'ExcludeDocument',
                successMsg: 'Документи успішно вилучено!',
                data: this
            });
        }, true);
    },
    btnSetASide: function () {
        checkIfRowsAreSelected(function () {
            var count = this.length;
            changeStatus({
                checkRow: function (row) {
                    return strIsNullOrEmpty(row.Status) || ~["I", "B", "N"].indexOf(row.Status);
                },
                noRowsText: 'Вибрані документи неможливо відкласти',
                confirmText: 'Відкласти документи (к-ть. ' + count + ') ?',
                method: 'SetASide',
                successMsg: 'Документи успішно відкладено!',
                data: this
            });
        }, true);
    },
    btnUnlock: function () {
        checkIfRowsAreSelected(function () {
            var count = this.length;
            changeStatus({
                checkRow: function (row) {
                    return !isNaN(row.Otm) && +row.Otm !== 0;
                },
                noRowsText: 'Вибрані документи неможливо розблокувати',
                confirmText: 'Розблокувати документи (к-ть. ' + count + ') ?',
                method: 'Unblock',
                successMsg: 'Документи успішно розблоковано!',
                data: this
            });
        }, true);
    },
    btnTeroristList: function () {
        checkIfRowsAreSelected(function () {
            var otm = this.Otm;
            if (strIsNullOrEmpty(otm) || +otm === 0) {
                bars.ui.alert({ text: 'Немає даних для відображення.' });
            } else {
                TerroristsForm(otm);
            }
        }, false);
    },
    btnFilter: function () {
        bars.ui.getFiltersByMetaTable(function (response, success) {
            if (!success) return;

            if (response.length > 0) {
                var params = response.join(' and ');
                filter.filteringData.customFilters = ' and ' + params;

                filter.runSelectCommand();
            }

        }, { tableName: "V_FINMON_QUE_OPER" });
    },
    btnExcelExport: function () {
        window.location = bars.config.urlContent('/api/Finmon/FmDocumentsApi/ExportToExcel?_filter=') + JSON.stringify(filter.getGridFilters());
        bars.ui.notify('Формування файлу розпочато.', 'Завантаження розпочнеться автоматично (Не закривайте браузер).', 'info', {
            autoHideAfter: 2.5 * 1000,
            width: "350px"
        });
    },
    btnClearAllFilters: function () {
        //console.log(this);
        filter.clearUserFilters();
    },
    btnChangesHistory: function () {
        checkIfRowsAreSelected(function () {
            ShowHistoryForm(this.Id, this.Ref);
        }, false);
    },
    btnFmMonitoringParams: function () {
        checkIfRowsAreSelected(function () {
            var $this = this;
            singleFmRulesEditor.open([$this.Ref], false, function (e) {
                $this.OprVid2 = e.Data.OprVid2;
                $this.OprVid3 = e.Data.OprVid3;
                $this.Fv2Agg = e.Vids2;
                $this.Fv3Agg = e.Vids3;
                $this.StatusName = e.Data.StatusName;

                formCfg.refreshGrid();

                $(formCfg.mainGridSelector).data('kendoGrid').tbody.find('tr[data-uid="' + $this.uid + '"]').addClass('k-state-selected');
            });
        }, false);
    },
    btnBulkParametersSet: function () {
        checkIfRowsAreSelected(function () {
            var refs = $.map(this, function (v) {
                return v.Ref;
            });
            singleFmRulesEditor.open(refs, true);
        }, true);
    }
};

function toolBarBtnClick(that) {
    toolBarClickHandlers[that.id].call(that);
}

function changeStatus(properties) {
    properties = properties || {};
    properties = $.extend(true,
        {
            checkRow: function () { return true; },
            data: [],
            noRowsText: '',
            confirmText: '',
            method: '',
            successMsg: 'Успішно!',
            ajaxSuccess: function (e) {
                bars.ui.alert({ text: properties.successMsg }, function () { formCfg.reloadGrid(); });
            }
        },
        properties
    );
    var that = [];

    for (var i = 0; i < properties.data.length; i++) {
        var cur = properties.data[i];
        if (properties.checkRow.call(null, cur))
            that.push(cur);
    }
    if (that.length <= 0) {
        bars.ui.alert({ text: properties.noRowsText });
        return;
    }
    var count = that.length;

    bars.ui.confirm({
        text: properties.confirmText
    }, function () {
        bars.ui.loader('body', true);
        $.ajax({
            url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/' + properties.method),
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(that),
            success: properties.ajaxSuccess,
            complete: function () {
                bars.ui.loader('body', false);
            }
        });
    });
}

function checkIfRowsAreSelected(func, allowMultiply) {
    var grid = $(formCfg.mainGridSelector).data('kendoGrid');
    if (allowMultiply) {
        var cbs = $(formCfg.mainGridSelector + ' input[type="checkbox"].selectRow:checked');
        if (cbs.length) {
            var selectedItems = $.map(cbs, function (cb) {
                return grid.dataItem($(cb).closest('tr'));
            });
            func.apply(selectedItems);
            return;
        }
    } else {
        var selected = grid.select();
        if (selected.length) {
            func.apply(grid.dataItem(selected));
            return;
        }
    }
    bars.ui.alert({ text: "Не вибрано жодного рядка." });
}

function filterByStatuses() {
    filter.form.open({
        func: function (res) {
            filter.filteringData.statuses = res.idArr;
            filter.runSelectCommand();
        },
        showDates: false,
        gridDsUrl: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDocumentStatusesList'),
        gridTitle: 'Статуси',
        pageable: false,
        selectedIdArr: filter.filteringData.statuses
    });
}

function filterByRules() {
    filter.form.open({
        func: function (res) {
            updateSearchStatus();

            filter.filteringData.rules = $.map(res.idArr, function (val) { return +val; });
            filter.filteringData.period.from = res.period.from;
            filter.filteringData.period.to = res.period.to;

            filter.getCurrentFiltersString();

            if (!filter.filteringData.rules || !filter.filteringData.rules.length) {
                getDocumentsCount();
            } else {
                $.ajax({
                    url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/SetRules'),
                    type: 'POST',
                    data: JSON.stringify(filter.getGridFilters()),
                    contentType: "application/json; charset=utf-8",
                    success: function () {
                        getDocumentsCount();
                    }
                });
            }
        },
        dateFrom: filter.filteringData.period.from,
        dateTo: filter.filteringData.period.to,
        gridDsUrl: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetRulesList'),
        gridTitle: 'Правила відбору',
        autoClose: true,
        selectedIdArr: filter.filteringData.rules
    });
}

function getDocumentsCount() {
    $.ajax({
        url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetDocumentsCount'),
        type: 'POST',
        data: JSON.stringify(filter.getGridFilters()),
        contentType: "application/json; charset=utf-8",
        success: function (res) {
            updateSearchStatus(res);
        }
    });
}

function updateSearchStatus(val) {
    formCfg.searchLbl.removeClass('invisible');
    if (isNaN(val)) {
        formCfg.searchLbl.text('Виконується операція відбору');
    } else {
        if (val === 100000) {
            formCfg.searchLbl.html('<label style="color:red;">Увага! Стоїть обмеження на відображення даних (до 100 тис. записів). Для пошуку використовуйте додаткові фільтри</label>');
        } else {
            formCfg.searchLbl.html('Всього відібрано документів: <label style="color:red;">' + +val
                + '</label>. Для відображення списку документів натисніть кнопку "<a onclick="toolBarClickHandlers.btnReload();" style="text-decoration: underline;">Перечитати дані</a>"');
        }
    }
}

function preInitForm(cb) {
    bars.ui.loader('body', true);

    // в Promise.all передаємо масив промісів, котрі необхідно виконати до завантаження даних у гріди на формі (наприклад підгрузка масивів статусів)
    Promise.all([
        GetPreviousBankDate()
    ]).then(
        function (result) {
            bars.ui.loader('body', false);
            if (cb && typeof cb === 'function') {
                cb.apply();
            }
        },
        function (error) {
            var errorText = 'Метод : ' + error.name + '</br>' + error.text;

            showBarsErrorAlert(errorText);
            bars.ui.loader('body', false);
        });
}

function GetPreviousBankDate() {
    var promise = new Promise(
        function (resolve, reject) {
            $.ajax({
                type: "GET",
                global: false,
                url: bars.config.urlContent('/api/Finmon/FmDocumentsApi/GetPreviousBankDate'),
                success: function (data) {
                    previousBankDate = data.toDate();
                    filter.filteringData.period.from = previousBankDate;
                    filter.filteringData.period.to = previousBankDate;
                    resolve(true);
                },
                error: function (xhr) {
                    var text;
                    if (xhr.status === 401)
                        document.location.reload();
                    else if (xhr.status === 403)
                        window.location = $.parseJSON(xhr.responseText).LogOnUrl;
                    else if (xhr.status === 400 || xhr.status === 404 || xhr.status === 500) {
                        if (xhr.responseJSON && xhr.responseJSON.Message) text = parseJsonError(xhr.responseJSON);
                        else text = replaseResponseText(xhr.responseText);
                    } else if (xhr.status === 502)
                        document.location.refresh();

                    reject({
                        text: text,
                        name: 'GetPreviousBankDate'
                    });
                }
            });
        });

    return promise;
}

function formatDateForGrid(_date) {
    if (_date)
        return _date.format();
    return '';
}

function getGlobalFilterType() {
    var type = getUrlParameter('type');
    filter.filteringData.formType = type || 'all';

    switch (type) {
        case 'subdivision':
            $('#title').text('Відбір документів [ДОКУМЕНТИ ПІДРОЗДІЛУ]');
            break;
        case 'user':
            $('#title').text('Відбір документів [СВОЇ ДОКУМЕНТИ]');
            break;
        case 'input':
            $('#title').text('Відбір документів [ВХІДНІ ДОКУМЕНТИ]');
            break;
        default:
            $('#title').text('Відбір документів [ВСІ ДОКУМЕНТИ]');
            break;
    }
}

function checkAccess() {
    var access = getUrlParameter('access');
    if (!access || access !== 'assignee') {
        //enableElem('#btnExculde, #btnUnlock, #btnSend, #btnSetASide, #btnFmMonitoringParams, #btnBulkParametersSet', false);

        $('#btnExculde, #btnUnlock, #btnSend, #btnSetASide, #btnFmMonitoringParams, #btnBulkParametersSet').css('display', 'none');

        // btnFmMonitoringParams , btnBulkParametersSet - ймовірно її також потрібно лочити, це питання ще не вирішено
    }
}

function selectionChange(that) {
    var $this = $(that),
        grid = $this.closest('.k-grid.k-widget').data('kendoGrid'),
        tr = $this.closest('tr'),
        selectedItem = grid.dataItem(tr);

    selectedItem.Selected = $this.prop('checked');
    if (!$this.prop('checked')) {
        $('#cbSelectAll').prop('checked', false);
        formCfg.selectedAll = false;
    }
}
function selectAll(that) {
    var $this = $(that),
        grid = $this.closest('.k-grid.k-widget').data('kendoGrid');

    formCfg.selectedAll = $this.prop('checked');

    $.each(grid.dataSource._data, function (indx, el) {
        el.Selected = $this.prop('checked');
    });
    grid.refresh();
}

