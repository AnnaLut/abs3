var formCfg = {
    // formType 0 FO, else BO
    formType: 0,
    currentGridName: 'accepted',
    currentGridSelector: '#accepted_grid',
    accepted_gridOptions: {},
    processed_gridOptions: {},
    draft_gridOptions: {},
    showTooltip: true,

    setShowTooltip: function (val) {
        if (val != undefined && val != null)
            this.showTooltip = val;
    },
    setFormType: function (val) {
        if (val === undefined || val === null)
            this.formType = 0;
        else
            this.formType = +val;
    },
    getTitle: function () {
        switch (this.formType) {
            case 0:
                return 'Обробка ЗП відомостей (менеджер ФО)'
            default:
                return 'Обробка ЗП відомостей (менеджер БО)'
        }
    },
    configurateButtons: function () {
        switch (this.formType) {
            case 0:
                $(".custom-btn-payroll-view, .custom-btn-payroll-edit, .custom-btn-payroll-delete, .custom-btn-payroll-create, .custom-btn-payroll-ok").removeClass('invisible');
                break;
            default:
                $(".custom-btn-payroll-view, .custom-btn-payroll-enrollment, .custom-btn-payroll-reject, .custom-btn-separated-watch-archive").removeClass('invisible');
                break;
        }
    },
    getMainGridFilter: function () {
        switch (this.formType) {
            case 0:
                return {
                    accepted: ' where sos in (1,2)',
                    processed: ' where sos in (-1,0,5)',
                    draft: ' where sos in (3)'
                }
            default:
                return {
                    accepted: ' where sos in (2)',
                    processed: ' where sos in (0,5)',
                    draft: ''
                }
        }
    },
    getSosFilterDataSource: function () {
        switch (this.formType) {
            case 0:
                return {
                    accepted: [
                        { sos: 1, sosName: 'Прийнята' },
                        { sos: 2, sosName: 'Очікує підтвердження БО' }
                    ],
                    processed: [
                        { sos: -1, sosName: 'Відхилена' },
                        { sos: 0, sosName: 'Документи введені' },
                        { sos: 5, sosName: 'Оплачена' }
                    ],
                    draft: null
                    //draft: [ { sos: 3, sosName: 'Чернетка' } ]
                }
            default:
                return {
                    //accepted: [ { sos: 2, sosName: 'Очікує підтвердження БО' } ],
                    accepted: null,
                    processed: [
                        { sos: 0, sosName: 'Документи введені' },
                        { sos: 5, sosName: 'Оплачена' }
                    ],
                    draft: null
                }
        }
    },
    initGridOptions: function () {
        var filtersDs = formCfg.getSosFilterDataSource();

        this.processed_gridOptions = getGridOptions({}, {
            transport: {
                read: {
                    data: {
                        _filter: this.getMainGridFilter()['processed']
                    }
                }
            },
            filter: {
                logic: "and",
                filters: [
                    { field: "pr_date", operator: "gte", value: getFilterFromValue() },
                    { field: "pr_date", operator: "lte", value: getFilterToValue() }
                ]
            }
        }, true, filtersDs.processed);
        this.accepted_gridOptions = getGridOptions({
            selectable: this.formType == 0 ? 'row' : 'multiple, row',
        }, {
                transport: {
                    read: {
                        data: {
                            _filter: this.getMainGridFilter()['accepted']
                        }
                    }
                }
            }, false, filtersDs.accepted);
        this.draft_gridOptions = getGridOptions({
            selectable: 'multiple, row'
        }, {
                transport: {
                    read: {
                        data: {
                            _filter: this.getMainGridFilter()['draft']
                        }
                    }
                }
            }, false, filtersDs.draft);
    },
    getCurrentGridOptions: function () {
        switch (this.currentGridName) {
            case 'accepted': return this.accepted_gridOptions;
            case 'processed': return this.processed_gridOptions;
            case 'draft': return this.draft_gridOptions;
            default: return {};
        }
    },
    setCurrentGrid: function (_val) {
        this.currentGridSelector = '#' + _val + '_grid';
        this.currentGridName = _val;
    },
    updateCurrentGrid: function () {
        var grid = $(this.currentGridSelector).data("kendoGrid");
        if (grid) {
            grid.dataSource.read();
        }
    },
    refreshGrid: function () {
        var grid = $(this.currentGridSelector).data("kendoGrid");
        grid.refresh();
    }
};

function getGridOptions(options, dataSourse, showSign, sosFilterDs) {
    if (options === undefined || options == null) options = {};
    if (dataSourse === undefined || dataSourse == null) dataSourse = {};
    var toShow = true;

    options = $.extend(true,
        {
            autoBind: false,
            pageable: {
                refresh: true,
                messages: {
                    empty: "Дані відсутні",
                    allPages: "Всі"
                },
                pageSizes: [20, 30, 50, 100, "All"],
                buttonCount: 5
            },
            reorderable: false,
            sortable: {
                mode: "single",
                allowUnsort: true
            },
            filterable: true,
            columns: [
                { field: "signed", title: " ", filterable: false, width: "35px", template: '<div class="signed-cell#= signed == "Y" ? "" : " invisible" #" title="Підписав:&\\#013;#= signed_fio #"></div>', hidden: !showSign },
                { field: "pr_date", title: "Дата відомості", width: "100px", template: "<div style='text-align:center;'>#= kendo.toString(pr_date,'dd.MM.yyyy') || '' #</div>" },
                { field: "cnt", title: "Кількість", width: "80px" },
                { field: "s", title: "Загальна сума, &#8372;", width: "130px", template: '<div style="text-align:right;">#= convertToMoneyStr(s) #</div>' },
                { field: "cms", title: "Сума комісії, &#8372;", width: "120px", template: '<div style="text-align:right;">#= convertToMoneyStr(cms) #</div>' },

                { field: "ostc_2909", title: "Залишок на рахунку, &#8372;", width: "130px", template: '<div style="text-align:right;" class="#= getOstClass(sos, not_enogh_money) #" title="#= getOstTitle(not_enogh_money, not_enogh_sum) #">#= convertToMoneyStr(ostc_2909) #</div>' },

                { field: "payroll_num", title: "№ відомості", width: "150px", template: "<div style='text-align:center;'>#= payroll_num == null ? '' : payroll_num #</div>" },
                { field: "zp_deal_id", title: "№ ЗП договору", width: "150px" },
                { field: "nmk", title: "Назва ЮО", width: "250px" },
                { field: "rnk", title: "РНК", width: "80px" },
                {
                    field: "sos", title: "Статус", width: "190px",
                    template: "#= sos_name #",
                    filterable: sosFilterDs ? {
                        ui: function (element) {
                            element.kendoDropDownList({
                                dataSource: sosFilterDs,
                                optionLabel: '--Оберіть значення--',
                                dataTextField: 'sosName',
                                dataValueField: 'sos'
                            });
                        }
                    } : false
                },
                {
                    field: "src", title: "Джерело надходження", width: "150px",
                    template: "#= src_name #",
                    filterable: {
                        ui: function (element) {
                            element.kendoDropDownList({
                                dataSource: [
                                    { value: 1, name: 'Ручне введення' },
                                    { value: 2, name: 'Імпорт файлу' },
                                    { value: 3, name: 'Ручне введення' },
                                    { value: 4, name: 'Змішаний тип' },
                                    { value: 5, name: 'Інтернет банк' }
                                ],
                                optionLabel: '--Оберіть значення--',
                                dataTextField: 'name',
                                dataValueField: 'value'
                            });
                        }

                    }
                },
                { field: "comm_reject", title: "Коментар", width: "300px" },
                {
                    field: "fio", title: "Менеджер", width: "250px",
                    template: "#= fio #</br>#= imp_date ? kendo.toString(imp_date, 'dd.MM.yyyy HH:mm:ss') : '' #"
                }
            ],
            selectable: "row",
            editable: false,
            scrollable: true,
            noRecords: {
                template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
            },
            change: function () {
                mainGridChangeEventHandler.apply(this);
            }
        },
        options
    );

    dataSourse = $.extend(true,
        {
            transport: {
                read: {
                    type: "GET",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchPayrolls"),
                    dataType: "json"
                }
            },
            dataBinding: function () {
                bars.ui.loader(formCfg.currentGridSelector, true);
            },
            dataBound: function () {
                bars.ui.loader(formCfg.currentGridSelector, false);
            },
            type: "webapi",
            pageSize: 20,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        id: { type: "number" },
                        zp_id: { type: "number" },
                        zp_deal_id: { type: "string" },
                        pr_date: { type: "date" },
                        cnt: { type: "number" },
                        s: { type: "number" },
                        cms: { type: "number" },
                        src_name: { type: "string" },
                        src: { type: "number" },
                        sos_name: { type: "string" },
                        deal_name: { type: "string" },
                        sos: { type: "number" },
                        comm_reject: { type: "string" },
                        rnk: { type: "number" },
                        //enogh_money: { type: "number" },
                        not_enogh_money: { type: "number" },
                        not_enogh_sum: { type: "number" },
                        payroll_num: { type: "string" },
                        nmk: { type: "string" },
                        fio: { type: "string" },
                        signed: { type: "string" },
                        sined_fio: { type: "string" },
                        ostc_2909: { type: "number" },
                        imp_date: { type: "date" }
                    }
                }
            },
            serverFiltering: true,
            serverPaging: true,
            serverSorting: true,
            requestEnd: function () {
                enableElem('.btn.custom-btn', true);
            }
        },
        dataSourse
    );
    var kendoDataSrc = new kendo.data.DataSource(dataSourse);
    options.dataSource = kendoDataSrc;

    return options;
};


function mainGridChangeEventHandler() {
    clearSelection();

    var grid = $(formCfg.currentGridSelector).data("kendoGrid");
    var dataSource = grid.dataSource;

    var selectedItems = this.select();
    if (((formCfg.currentGridName == 'accepted' && formCfg.formType != 0) || formCfg.currentGridName == 'draft') && dataSource.view().length > 1) {
        if (selectedItems.length == 1 && formCfg.showTooltip) {
            var tooltip = $("<div />").kendoTooltip({
                autoHide: false,
                content: 'Для виділення декількох записів - зажміть Ctrl або Shift і оберіть записи лівою клавішою миші, або виділіть одразу декілька утримуючи ліву клавішу миші.',
                width: 250,
                hide: function () {
                    formCfg.setShowTooltip(false);
                }
            }).data("kendoTooltip");
            tooltip.show(selectedItems);
        }
    }

    if (selectedItems.length > 1) {
        enableElem('.custom-btn-payroll-view, .custom-btn-print, .custom-btn-payroll-reject, .custom-btn-payroll-edit, .custom-btn-payroll-ok, .custom-btn-ea-view', false);
        enableElem('.custom-btn-payroll-enrollment', true);

        if (formCfg.currentGridName == 'accepted') {
            for (var i = 0; i < selectedItems.length; i++) {
                var item = selectedItems[i];
                var money = +this.dataItem(item).not_enogh_money;

                if (money != 1) {
                    $(item).removeClass('k-state-selected');
                }
            }
            if (this.select().length <= 0)
                enableElem('.custom-btn:not(.custom-btn-payroll-filter):not(.custom-btn-clear-filter)', true);
        }
        selectedItems = this.select();
    } else if (selectedItems.length > 0) {
        enableElem('.custom-btn-payroll-delete, .custom-btn-payroll-edit, .custom-btn-payroll-view, .custom-btn-payroll-ok, .custom-btn-print, .custom-btn-ea-view', true);
        var sos = +this.dataItem(this.select()).sos;
        var src = +this.dataItem(this.select()).src;

        var money = +this.dataItem(this.select()).not_enogh_money;

        if (formCfg.formType == 0) {
            enableElem('.custom-btn-payroll-ok', (sos == 1 || sos == -1) && src != 5);
            enableElem('.custom-btn-payroll-edit, .custom-btn-payroll-delete', (sos == 1 || sos == -1 || sos == 3) && src != 5);
        } else {
            if (formCfg.currentGridName == 'accepted') {
                enableElem('.custom-btn-payroll-enrollment', money == 1);
                enableElem('.custom-btn-payroll-reject', true);
            }
            if (formCfg.currentGridName == 'processed') {
                enableElem('.custom-btn-payroll-enrollment, .custom-btn-payroll-reject', false);
            }
        }
    } else {
        enableElem('.custom-btn:not(.custom-btn-payroll-filter):not(.custom-btn-clear-filter)', true);
    }
}

function getOstClass(_sos, enoghMoney) {
    switch (_sos) {
        case -1:
        case 0:
        case 1:
        case 2:
            return +enoghMoney == 1 ? '' : 'red-text';
        default:
            return '';
    }
};
function getOstTitle(enoghMoney, summ) {
    if (+enoghMoney == 1 || formCfg.currentGridName != 'accepted') return '';
    var sumStr = convertToMoneyStr(summ);
    var title = 'Для оплати відомості недостатньо коштів &#013;Не вистачає  ' + sumStr + ' &#8372;';
    return title;

    //return 'На рахунку недостатньо коштів !';
};

function getFilterFromValue() {
    var date = new Date;
    date.setHours(0, 0, 0, 0);
    date.setDate(date.getDate() - 7);

    return date;
};

function getFilterToValue() {
    var date = new Date;
    date.setHours(0, 0, 0, 0);

    return date;
};

function checkIfRowIsSelected(func) {
    // in call back function will be passed selected row as it's context
    func = func || function () { };

    var grid = $(formCfg.currentGridSelector).data("kendoGrid");
    var selected = grid.select();
    var selectedItem = {};

    if (selected == null || selected === undefined || selected.length <= 0) {
        bars.ui.alert({ text: "Не вибрано жодного рядка." });
        return;
    };

    if (selected.length > 1) {
        var tmpRes = [];

        for (var i = 0; i < selected.length; i++) {
            tmpRes.push(grid.dataItem(selected[i]));
        }

        selectedItem = tmpRes;
    } else {
        selectedItem = [grid.dataItem(selected)];
    }

    func.apply(selectedItem);
};

function addEventListenersToButtons() {
    $('.custom-btn-payroll-create').on('click', function () {
        sdForm(function (selectedDeal) {
            bars.ui.loader('body', true);
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetNextId"),
                data: {
                    zpId: selectedDeal.id
                },
                success: function (data) {
                    bars.ui.loader('body', false);
                    if (data.Result != "OK") {
                        showBarsErrorAlert(data.ErrorMsg);
                    } else {
                        goToSalarypayrollPage({
                            formType: formCfg.formType,
                            mode: 0,
                            dealId: selectedDeal.id,
                            payRollId: data.ResultObj
                        });
                    }
                }
            });
        });
    });

    $('.custom-btn-payroll-enrollment').on('click', function () {
        checkIfRowIsSelected(function () {
            var rows = this;
            var totalSumm = 0;

            for (var i = 0; i < rows.length; i++) {
                totalSumm += +rows[i].s;
            }

            var arrayOfIds = rows.map(function (item) { return item.id; });

            //bars.ui.confirm({ text: 'Зарахувати ' + rows.length + ' відомостей на загальну суму <b>' + convertToMoneyStr(totalSumm) + ' &#8372;</b> ?' }, function() {
            bars.ui.confirm({ text: 'Зарахувати обрані відомості ?<br />Кількість : <b>' + rows.length + '</b><br />Загальна сумма : <b>' + convertToMoneyStr(totalSumm) + ' &#8372;</b>' }, function () {
                signAllPayrollDocuments(arrayOfIds, true, function (result) {

                    var pArr = [];

                    for (var i = 0; i < result.length; i++) {
                        pArr.push(funcPromiseEnrollPayroll(result[i]));
                    }

                    Promise.all(pArr).then(
                        function (result) {
                            //  isOk, data.ErrorMsg
                            var sCount = 0;
                            var errCount = 0;
                            var errors = '<br />Відбулись наступні помилки :<br />';

                            for (var i = 0; i < result.length; i++) {
                                if (result[i].Result != 'OK') {
                                    errCount++;
                                    errors += result[i].ErrorMsg + '<br />';
                                } else {
                                    sCount++;
                                }
                            }

                            var msg = 'Відомостей успішно зараховано : ' + sCount + ' з ' + result.length;
                            msg += errCount == 0 ? '' : errors;

                            $signerPopUp.PopUpShowResults(!errCount, msg, function () {
                                formCfg.updateCurrentGrid();
                            });
                        },
                        function (error) {
                            $signerPopUp.PopUpShowResults(false, "Помилка при зарахуванні : " + error.message);
                        }
                    );
                });
            });
        });
    });

    $('.custom-btn-payroll-reject').on('click', function () {
        checkIfRowIsSelected(function () {
            eacForm({
                title: 'Вкажіть причину відхилення відомості',
                minLength: 5,
                additionalData: this[0],
                okFunc: function (eacResult) {
                    bars.ui.loader('body', true);
                    $.ajax({
                        type: "GET",
                        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/RejectPayroll"),
                        data: {
                            pId: +eacResult.userData.id,
                            comment: eacResult.reason
                        },
                        success: function (data) {
                            bars.ui.loader('body', false);
                            if (data.Result != "OK") {
                                showBarsErrorAlert(data.ErrorMsg);
                            } else {
                                bars.ui.alert({ text: 'Відомість № <b>' + eacResult.userData.id + '</b> відхилено.' });
                                formCfg.updateCurrentGrid();
                            }
                        }
                    });
                }
            });
        });
    });

    $('.custom-btn-payroll-edit').on('click', function () {
        checkIfRowIsSelected(function () {
            //mode = 2 means edit form, for now it changes nothing
            var _this = this[0];
            goToSalarypayrollPage({
                formType: formCfg.formType,
                mode: 2,
                dealId: _this.zp_id,
                payRollId: _this.id,
                payrollNumber: _this.payroll_num,
                sos: _this.sos,
                enoghMoney: _this.not_enogh_money
            });
        });
    });

    $('.custom-btn-payroll-view').on('click', function () {
        checkIfRowIsSelected(function () {
            var _this = this[0];
            goToSalarypayrollPage({
                formType: formCfg.formType,
                mode: 3,
                dealId: _this.zp_id,
                payRollId: _this.id,
                payrollNumber: _this.payroll_num,
                sos: _this.sos,
                enoghMoney: _this.not_enogh_money
            });
        });
    });

    $('#accepted_grid, #draft_grid, #processed_grid').on('dblclick', 'tr:not(:first)', function () {
        checkIfRowIsSelected(function () {
            var sos = this[0].sos;
            if (+sos == -1 || +sos == 1 || +sos == 3) {
                $('.custom-btn-payroll-edit').click();
            } else {
                $('.custom-btn-payroll-view').click();
            }
        });
    });

    $('#date_from, #date_to').on('change', dateChangeFn);

    $('.custom-btn-payroll-filter').on('click', function () {
        var _from = $("#date_from").data("kendoDatePicker").value();
        var _to = $("#date_to").data("kendoDatePicker").value();

        if (_from == null || _to == null) {
            bars.ui.error({ text: 'Необхідно заповнити період фільтрації !' });
            return;
        }

        var from = new Date(_from);
        var to = new Date(_to);

        from.setHours(0, 0, 0, 0);
        to.setHours(0, 0, 0, 0);

        if (from > to) {
            bars.ui.alert({ text: 'Дата "З" <b>не</b> може бути більшою за дату "По" !' });
            return;
        }

        var grid = $(formCfg.currentGridSelector).data('kendoGrid');

        var filter = {
            logic: "and", filters: [
                { field: "pr_date", operator: "gte", value: from },
                { field: "pr_date", operator: "lte", value: to }
            ]
        };

        grid.dataSource.filter(filter);
        grid.dataSource.read();

        $('.custom-btn-clear-filter').removeAttr('disabled');
    });

    $('.custom-btn-clear-filter').on('click', function () {
        var grid = $(formCfg.currentGridSelector).data('kendoGrid');
        grid.dataSource.filter({});
        grid.dataSource.read();

        $('.custom-btn-clear-filter').attr('disabled', 'disabled');
    });

    $('.custom-btn-payroll-ok').on('click', function () {
        approveOrDeletePayroll(1);
    });

    $('.custom-btn-payroll-delete').on('click', function () {
        if (formCfg.currentGridName == 'draft') {
            deleteSelectedDrafts();
        } else {
            approveOrDeletePayroll(-1);
        }
    });

    $('.custom-btn-print').on('click', function () {
        checkIfRowIsSelected(function () {
            printPayroll(this[0]);
        });
    });

    $('.custom-btn-ea-view').on('click', function () {
        checkIfRowIsSelected(function () {
            var zpId = this[0].zp_id;
            var rnk = this[0].rnk;

            for (var i = 0; i < this.length; i++) {
                if (zpId != this[i].zp_id) {
                    bars.ui.error({ text: 'Не можливо показати документи ЕА по відомостям з різних ЗП договорів.' });
                    return;
                }
            }

            showViewEADocsForm({ id: zpId, rnk: rnk }, ['001030001']);
        });
    });
};

function dateChangeFn() {
    var _value = $(this).val();

    _value = _value.replace(/ |,|-|\//g, '.');

    var regex = /^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$/;
    if (!_value.match(regex)) {
        $(this).val('');
    } else {
        $(this).val(_value);
    }
};

function deleteSelectedDrafts() {
    var ids = [];
    var grid = $(formCfg.currentGridSelector).data("kendoGrid");
    var selectedItems = grid.select();

    if (!selectedItems.length) {
        bars.ui.alert({ text: 'Не вибрано жодного рядка.' });
        return;
    }

    for (var i = 0; i < selectedItems.length; i++) {
        ids.push(grid.dataItem(selectedItems[i]).id);
    }

    bars.ui.confirm({ text: 'Видалити обрані чернетки ?' }, function () {
        bars.ui.loader('body', true);
        deleteAllDrafts(ids);
    });
};

function deleteAllDrafts(selctedIds) {
    var arr = [];
    for (var i = 0; i < selctedIds.length; i++) {
        arr.push(promiseToDeleteOneDraft(selctedIds[i]));
    }

    Promise.all(arr).then(
        function (result) {
            var count = 0;
            for (var i = 0; i < result.length; i++) {
                count += +result[i];
            }
            bars.ui.alert({ text: 'Видалено ' + count + ' чернеток.' });
            formCfg.updateCurrentGrid();
            bars.ui.loader('body', false);
        },
        function (error) { bars.ui.loader('body', false); }
    );
};

function promiseToDeleteOneDraft(id) {
    return new Promise(function (resolve, reject) {
        var _data = {
            payrollId: +id
        };

        $.ajax({
            type: 'GET',
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/DeletePayroll"),
            data: _data,
            success: function (data) {
                resolve(data.Result == "OK" ? 1 : 0);
            },
            error: function (e) {
                resolve(0);
            }
        });
    });
};

function funcPromiseEnrollPayroll(result, id) {
    return new Promise(function (resolve, reject) {
        var postData = {
            records: [result],
            payrollId: +result.id
        };

        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/PayPayroll"),
            data: postData,
            success: function (data) {
                var isOk = data.Result == "OK";
                $signerPopUp.incrementPayrollsReadyCount();
                resolve(data);
            },
            error: function (e) {
                resolve(e);
            }
        });
    });
};

function goToSalarypayrollPage(options) {
    var info = {
        formType: options.formType || 0,
        mode: options.mode || 0,
        dealId: options.dealId || 0,
        payRollId: options.payRollId || 0,
        payrollNumber: encodeURIComponent(options.payrollNumber || ''),
        sos: options.sos === undefined ? 3 : options.sos,
        modalView: options.modalView || false,
        enoghMoney: options.enoghMoney
    };

    var strInfo = encodeURI(JSON.stringify(info));

    goToSomewhere('Salarypayroll?cfg=' + strInfo);
};

function approveOrDeletePayroll(type) {
    // type = 1 - approve, else - delete
    checkIfRowIsSelected(function () {
        var row = this[0];
        switch (+type) {
            case 1:
                bars.ui.confirm({ text: '<b>Увага !</b></br>Буде здійснено підписання внесених документів за допомогою ЕЦП. </br>Після підтвердження, редагування даних у відомості буде не можливим !</br>Продовжити ?', height: "150px" }, function () {
                    signAllPayrollDocuments([row.id], false, function (signs) {
                        executeApproveDelete('підписано та підтверджено', 'ApprovePayroll', row, signs);
                    });
                });
                break;
            default:
                bars.ui.confirm({ text: '<b>Увага !</b></br>Відомість буде видалено !</br>Продовжити ?' }, function () {
                    executeApproveDelete('видалено', 'DeletePayroll', row);
                });
                break;
        }
    });
};

function executeApproveDelete(actionOkStr, apiFunction, selectedItem, signs) {
    signs = signs || '';
    var requestType, postData;
    if (apiFunction == 'ApprovePayroll') {
        postData = {
            records: signs,
            payrollId: +selectedItem.id
        };
        requestType = 'POST';
    } else {
        bars.ui.loader('body', true);
        postData = {
            payrollId: +selectedItem.id
        };
        requestType = 'GET';
    }

    //var time = performance.now();

    $.ajax({
        type: requestType,
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/" + apiFunction),
        data: postData,
        success: function (data) {
            //var p = performance.now() - time;
            //console.log(apiFunction + ' = ' + p);
            if (apiFunction == 'ApprovePayroll') {
                var isOk = data.Result == "OK";
                var msg = isOk ? 'Відомість ' + actionOkStr + '.' : data.ErrorMsg;
                $signerPopUp.PopUpShowResults(isOk, msg, function () {
                    formCfg.updateCurrentGrid();
                });
            } else {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    bars.ui.alert({ text: 'Відомість ' + actionOkStr + '.' });
                    formCfg.updateCurrentGrid();
                }
            }
        }
    });
};

function initDatePickers() {
    var today = new Date();

    $("#date_from, #date_to").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: '',
        dateInput: true
    });
};

function initTabStrip() {
    function tabAnimations() {
        var myNav = navigator.userAgent.toLowerCase();
        var browser = (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
        if (+browser === 8) {
            return {
                open: {
                    effects: "fade:in",
                    duration: 1
                },
                close: {
                    effects: "fade:in",
                    reverse: true,
                    duration: 1
                }
            }
        } else {
            return {
                open: {
                    effects: "fade:in",
                    duration: 300
                },
                close: {
                    effects: "fade:in",
                    reverse: true,
                    duration: 300
                }
            }
        }
    };

    var tabstrip = $("#sp_tabstrip").kendoTabStrip({
        animation: tabAnimations(),
        activate: function () {
            formCfg.refreshGrid();
            //formCfg.updateCurrentGrid();
        },
        select: function (e) {
            $('.custom-btn-payroll-edit, .custom-btn-payroll-delete, .custom-btn-payroll-ok, .custom-btn-payroll-enrollment').removeAttr('disabled');

            var a = $(e.contentElement).attr('data-type');

            //if (formCfg.formType != 0 && a != 'accepted')
            //    enableElem('.custom-btn-payroll-enrollment, .custom-btn-payroll-reject', false);
            //else
            //    enableElem('.custom-btn-payroll-enrollment, .custom-btn-payroll-reject', true);

            if (a != 'draft')
                $('.custom-btn-print').removeAttr('disabled');
            else
                $('.custom-btn-print').attr('disabled', 'disabled');

            formCfg.setCurrentGrid(a);
            formCfg.updateCurrentGrid();

            var grid = $(formCfg.currentGridSelector).data("kendoGrid");
            if (grid === undefined || grid === null) {
                $('.custom-btn-clear-filter').attr('disabled', 'disabled');
                grid = $(formCfg.currentGridSelector).kendoGrid(formCfg.getCurrentGridOptions()).data("kendoGrid");
                //grid.dataSource.read();
            }

            var _f = grid.dataSource.filter();
            if (_f === undefined || _f === null || _f === {}) {
                $('.custom-btn-clear-filter').attr('disabled', 'disabled');
                $('#date_from').data('kendoDatePicker').value('');
                $('#date_to').data('kendoDatePicker').value('');
            } else {
                $('.custom-btn-clear-filter').removeAttr('disabled');

                for (var i = 0; i < _f.filters.length; i++) {
                    if (_f.filters[i].operator == "gte") {
                        $('#date_from').data('kendoDatePicker').value(new Date(_f.filters[i].value));
                    } else {
                        $('#date_to').data('kendoDatePicker').value(new Date(_f.filters[i].value));
                    }
                }
            }

            createCookie('Bars_SalaryProcessingSelectedTab', a, 30);
        }
    }).data("kendoTabStrip");

    tabstrip.select(tabNameToInt(readCookie('Bars_SalaryProcessingSelectedTab', 'accepted')));
    //console.log(tabstrip);
    //tabstrip.activateTab('accepted');
};

function tabNameToInt(tabName) {
    switch (tabName) {
        case "accepted": return 0;
        case "processed": return 1;
        case "draft":
            if (formCfg.formType == 0)
                return 2;
            else
                return 0;
        default: return 0;
    }
};

function initKendoWidgets() {
    $('#accepted_grid').kendoGrid(formCfg.accepted_gridOptions);
    $('#processed_grid').kendoGrid(formCfg.processed_gridOptions);

    if (formCfg.formType == 0) {
        $('#draft_grid').kendoGrid(formCfg.draft_gridOptions);
    } else {
        $('#draft').remove();
    }

    initDatePickers();
    initTabStrip();
};

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.7);
};

$(document).ready(function () {
    formCfg.setFormType(getUrlParameter('formType'));

    $("#title").html(formCfg.getTitle());
    formCfg.configurateButtons();
    formCfg.initGridOptions();

    initKendoWidgets();
    addEventListenersToButtons();
    bindSelectOnFocus();
    changeGridMaxHeight();
});