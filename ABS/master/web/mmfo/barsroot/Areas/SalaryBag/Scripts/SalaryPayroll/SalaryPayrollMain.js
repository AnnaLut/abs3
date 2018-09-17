var formCfg = {
    gridSelector: "#SalarypayrollMainGrid",
    // formType 0 FO(create), else BO(enrollment)
    formType: 0,
    payRollID: 0,
    tarifCode: 0,
    ourMfo: '',
    curPurpose: '',
    salaryDealId: 0,
    curPayrollNumber: '',
    curSos: 3,
    // 0 - add new , 1 - enrollment , 2 - edit , 3 - view 
    mode: 0,
    enoghMoney: 1,
    _curDebt: 0,
    showTooltip: true,

    configurateForm: function (cfg) {
        this.setFormType(cfg.formType);
        this.setPayRollId(cfg.payRollId);
        this.setMode(cfg.mode);
        this.setSalaryDealId(cfg.dealId);
        this.setPayrollNumber(decodeURIComponent(cfg.payrollNumber));
        this.setSos(cfg.sos);
        this.setEnoghMoney(cfg.enoghMoney);
        this.configurateButtons();

        if (cfg.modalView) {
            $('.custom-btn').attr('disabled', 'disabled');
            $('.custom-btn-back').removeAttr('disabled');
            $('.custom-btn-back').off('click', goBackFunc);

            $('.custom-btn-back').on('click', function () {
                window.parent.$('#historyWindow_1').data('kendoWindow').close();
            });

            $(document).on('keyup', function (e) {
                if (e.keyCode == 27) {
                    window.parent.$('#historyWindow_1').data('kendoWindow').close();
                }
            });
        }
    },

    setShowTooltip: function (val) {
        if (val != undefined && val != null)
            this.showTooltip = val;
    },

    setCurrentDebt: function (val) {
        if (+val != NaN) {
            _curDebt = +val;
        }
    },
    getCurrentDebt: function () {
        if (_curDebt < 0)
            return _curDebt * -1;
        return 0;
    },
    setPayrollNumber: function (val) {
        if (val != undefined && val != null)
            this.curPayrollNumber = val;
    },
    setEnoghMoney: function (val) {
        if (val != undefined && val != null)
            this.enoghMoney = val;
    },
    setSos: function (val) {
        if (val != undefined && val != null)
            this.curSos = val;
    },
    setPurpose: function (val) {
        if (val != undefined && val != null)
            this.curPurpose = val;
    },
    setOurMfo: function (val) {
        if (val != undefined && val != null)
            this.ourMfo = val;
    },
    setSalaryDealId: function (val) {
        this.salaryDealId = trashIsZero(val);
    },
    setMode: function (val) {
        this.mode = trashIsZero(val);
    },
    setTarifCode: function (val) {
        this.tarifCode = trashIsZero(val);
    },
    setFormType: function (val) {
        this.formType = trashIsZero(val);
    },
    setPayRollId: function (val) {
        this.payRollID = trashIsZero(val);
    },

    gettitle: function () {
        switch (this.mode) {
            case 0:
                return 'Створення ЗП відомості';
            case 1:
                return 'Зарахування ЗП відомості (№ <b>' + this.curPayrollNumber + '</b>)';
            case 2:
                return 'Редагування ЗП відомості (№ <b>' + this.curPayrollNumber + '</b>)';
            case 3:
                return 'Перегляд ЗП відомості (№ <b>' + this.curPayrollNumber + '</b>)';
        }
    },
    configurateButtons: function () {
        switch (+this.formType) {
            case 1:
                $('.custom-btn-payroll-enrollment, .custom-btn-payroll-reject').removeClass('invisible');
                enableElem('.custom-btn-payroll-enrollment', this.enoghMoney == 1);
                break;
            default:
                $('.custom-btn-accept-payroll, .custom-btn-payroll-ok').removeClass('invisible');
                break;
        }

        switch (+this.mode) {
            case 3:
                $('input').attr('disabled', 'disabled').addClass('k-state-disabled');
                $('#salary_payroll_date').data('kendoDatePicker').enable(false);

                $('#variable_block div:not(#payrollHistoryBtn, #payrollPrintBtn), .custom-btn-accept-payroll, .custom-btn-payroll-ok, #EditablePayrollDetails').remove();
                $('#NotEditablePayrollDetails').removeClass('invisible');

                if (+this.curSos == 5)
                    $('.custom-btn-payroll-enrollment, .custom-btn-payroll-reject').remove();

                break;
            default:
                break;
        }

        switch (+this.curSos) {
            case 1:
                $('.custom-btn-payroll-ok').removeAttr('disabled');
                break;
            case 3:
                $('.custom-btn-print').attr('disabled', 'disabled');
                break;

        }
    },
    updateGrid: function () {
        var grid = $(this.gridSelector).data("kendoGrid");
        if (grid) {
            grid.dataSource.read();
        }
    },
    refreshGrid: function () {
        var grid = $(this.gridSelector).data("kendoGrid");
        grid.refresh();
    },
    showSign: function () {
        switch (this.curSos) {
            case -1:
            case 0:
            case 2:
            case 5:
                return false;
            default:
                return true;
        }
    },
    pageSize: 20
};

function checkIfRowIsSelected(func) {
    // in call back function will be passed selected row as it's context
    func = func || function () { };

    var grid = $(formCfg.gridSelector).data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    if (selectedItem == null || selectedItem === undefined) {
        bars.ui.alert({ text: "Не вибрано жодного рядка." });
        return;
    };
    func.apply(selectedItem);
};

function trashIsZero(val) {
    if (val === undefined || val === null)
        return 0;
    else
        return +val;
};

function initKendoDatePicker() {
    $("#salary_payroll_date").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: new Date(),
        dateInput: true,
        change: function () {
            var value = this.value();
            var today = new Date();

            if (value === undefined || value === null || value === '')
                this.value(today);
        }
    });
};

function initKendoWidgets() {

    var dataSourceObj = {
        type: "webapi",
        transport: {
            read: {
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/SearchPayrollItems?id=" + formCfg.payRollID),
                dataType: "json"
            }
        },
        pageSize: formCfg.pageSize,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    id: { type: "number" },
                    rownum: { type: "number" },
                    namb: { type: "string" },
                    okpob: { type: "string" },
                    mfob: { type: "string" },
                    nlsb: { type: "string" },
                    s: { type: "number" },
                    nazn: { type: "string" },
                    source: { type: "string" },
                    doc_ref: { type: "number" },
                    sos: { type: "number" },
                    signed: { type: "string" },
                    signed_fio: { type: "string" },
                    doc_comment: { type: "string" },
                    passp_serial: { type: "string" },
                    passp_num: { type: "string" },
                    idcard_num: { type: "string" }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [formCfg.pageSize, 30, 50, 100, "All"],
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        filterable: true,
        columns: [
            { field: "signed", title: " ", filterable: false, width: "40px", template: '<div class="signed-cell#= signed == "Y" ? "" : " invisible" #" title="Підписав:&\\#013;#= signed_fio #"></div>', hidden: formCfg.showSign() },
            { field: "rownum", title: "№", width: "65px", filterable: { ui: function (element) { element.kendoNumericTextBox({ format: "#" }); } } },
            { field: "sos", title: "Стан", width: "80px", hidden: formCfg.curSos != 0 && formCfg.curSos != 5 },
            { field: "doc_ref", title: "Референс", width: "110px", hidden: formCfg.curSos != 0 && formCfg.curSos != 5, template: '<a href="\\#" onclick="openDoc(#= doc_ref #);">#= doc_ref == null ? "" : doc_ref #</a>' },
            { field: "namb", title: "ПІБ клієнта", width: "250px" },
            { field: "okpob", title: "ІПН", width: "120px" },
            {
                field: "passp_num", title: "Паспорт/ID-картка", width: "180px",
                template: "#= getPasportTemplate(passp_num , passp_serial, idcard_num) #"
            },
            { field: "mfob", title: "МФО", width: "90px" },
            { field: "nlsb", title: "Рахунок", width: "150px" },
            { field: "s", title: "Сума, &#8372;", width: "120px", template: '<div style="text-align:right;">#= convertToMoneyStr(s) #</div>' },
            { field: "nazn", title: "Призначення платежу", width: "350px" },
            { field: "source", title: "Джерело", width: "150px" },
            { field: "doc_comment", title: "Коментар", width: "350px" }
        ],
        selectable: "multiple, row",
        editable: false,
        scrollable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>На жаль нічого не знайдено ;(</b><hr class="modal-hr"/>'
        },
        dataBound: function () {
            if (formCfg.tarifCode != 0) {
                calcCommission();
            }
            $('#selectedInformation_lbl').html('');
            $('.custom-btn-edit').removeAttr('disabled');
        },
        change: function (e) {
            clearSelection();

            var grid = $(formCfg.gridSelector).data("kendoGrid");
            var selectedItems = this.select();
            var dataSource = grid.dataSource;

            if (formCfg.mode == 0 || formCfg.mode == 2) {
                if (dataSource.view().length > 1) {
                    if (selectedItems.length == 1 && formCfg.showTooltip) {
                        var tooltip = $("<div />").kendoTooltip({
                            autoHide: false,
                            content: 'Для виділення декількох записів - зажміть Ctrl або Shift і оберіть записи лівою клавішою миші.<br />Або виділіть одразу декілька утримуючи ліву клавішу миші.',
                            width: 250,
                            hide: function () {
                                formCfg.setShowTooltip(false);
                            }
                        }).data("kendoTooltip");
                        tooltip.show(selectedItems);
                    }
                }
            }

            if (selectedItems.length > 1) {
                $('.custom-btn-edit').attr('disabled', 'disabled');
            } else {
                $('.custom-btn-edit').removeAttr('disabled');
            }

            if (selectedItems.length > 0) {
                var sCount = selectedItems.length;
                var sSumm = 0;
                for (var i = 0; i < selectedItems.length; i++) {
                    sSumm += +grid.dataItem(selectedItems[i]).s;
                }

                var moneySum = sSumm.toMoneyString();
                $('#selectedInformation_lbl').html('Вибрано рядків: <b>' + sCount + '</b>, на суму <b>' + moneySum + '</b>  &#8372;').attr('title', 'тра-та-та :)');
            } else {
                $('#selectedInformation_lbl').html('');
            }
        }
    };
    $(formCfg.gridSelector).kendoGrid(gridOptions);

    $(formCfg.gridSelector).on("dblclick", "tr:not(:first)", function (event) {
        $('.custom-btn-edit').click();
    });
};

function getPasportTemplate(num, series, idcard) {
    if (idcard) return idcard;
    if (!series && !num) return '';
    return series + ' ' + num;
};

function calcCommission() {
    var grid = $(formCfg.gridSelector).data("kendoGrid");
    var count = grid.dataSource.data().length;
    $("#total_count").text(count);

    var totalSum = 0;
    grid.dataSource.data().forEach(function (element, index) {
        totalSum += +element.s;
    });
    $("#total_sum").html(convertToMoneyStr(+totalSum) + ' &#8372;').attr('data-value', totalSum);

    totalSumm = $("#total_sum").attr('data-value');
    var postData = {
        tarifCode: formCfg.tarifCode,
        nls2909: $('#nls_sum').text(),
        summ: +totalSumm * 100
    };

    if (postData.summ <= 0) return;

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/CalculateComission"),
        data: postData,
        success: function (data) {
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                $('#enrollment_commision').html(convertToMoneyStr(data.ResultObj) + ' &#8372;');
                $('#total_sum_plus_comission').html(convertToMoneyStr(+data.ResultObj + totalSum + formCfg.getCurrentDebt()) + ' &#8372;');
            }
        }
    });
};

function getOurMfo() {
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetOurMfo"),
        success: function (data) {
            if (data.Result == "OK") {
                formCfg.setOurMfo(data.ResultObj);
            }
        }
    });
};

function getNumericOptions(options) {
    if (options === undefined || options == null) options = {};
    options = $.extend(
        {
            min: 0,
            max: 99999999999999,
            spinners: false,
            decimals: 2,
            restrictDecimals: true,
            format: "n2",
            change: function () {
                var value = this.value();
                if (value == null || $.trim(value) == "")
                    this.value(0);
            }
        },
        options
    );
    return options;
};

function goBackFunc() {
    goToSomewhere('SalaryProcessing?formType=' + formCfg.formType);
};

function addEventListenersToButtons() {
    $('.custom-btn-back').on('click', goBackFunc);

    $('.custom-btn-payroll-enrollment').on('click', function () {
        bars.ui.confirm({ text: 'Зарахувати відомість № <b>' + formCfg.payRollID + '</b> на суму <b>' + $('#total_sum').html() + '</b> ?' }, function () {
            signAllPayrollDocuments([formCfg.payRollID], true, function (result) {
                var postData = {
                    records: [result[0]],
                    payrollId: +formCfg.payRollID
                };

                //var time = performance.now();

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/PayPayroll"),
                    data: postData,
                    success: function (data) {
                        //var p = performance.now() - time;
                        //console.log('PayPayroll = ' + p);
                        var isOk = data.Result == "OK";
                        var msg = isOk ? 'Відомість № <b>' + formCfg.payRollID + '</b> успішно зараховано.' : data.ErrorMsg;
                        $signerPopUp.PopUpShowResults(isOk, msg, function () {
                            $('.custom-btn-back').click();
                        });
                    }
                });
            });
        });
    });

    $('.custom-btn-payroll-reject').on('click', function () {
        eacForm({
            title: 'Вкажіть причину відхилення відомості',
            additionalData: {
                payRollID: formCfg.payRollID
            },
            minLength: 5,
            okFunc: function (eacResult) {
                bars.ui.loader('body', true);
                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/RejectPayroll"),
                    data: {
                        pId: +eacResult.userData.payRollID,
                        comment: eacResult.reason
                    },
                    success: function (data) {
                        bars.ui.loader('body', false);
                        if (data.Result != "OK") {
                            showBarsErrorAlert(data.ErrorMsg);
                        } else {
                            bars.ui.alert({
                                text: 'Відомість № <b>' + eacResult.userData.payRollID + '</b> відхилено.',
                                deactivate: function () {
                                    $('.custom-btn-back').click();
                                }
                            });
                        }
                    }
                });
            }
        });
    });

    $(".custom-btn-add").on('click', function () {
        AddOrEditForm();
    });
    $('.custom-btn-edit').on('click', function () {
        checkIfRowIsSelected(function () {
            AddOrEditForm(this);
        });
    });

    $('.custom-btn-delete').on('click', function () {
        var grid = $(formCfg.gridSelector).data("kendoGrid");
        var selectedItems = grid.select();

        if (!selectedItems.length) {
            bars.ui.alert({ text: 'Не вибрано жодного рядка.' });
            return;
        }

        bars.ui.confirm({ text: 'Ви впевнені, що хочете видалити обрані документи ?' }, function () {
            var dataItems = [];
            for (var i = 0; i < selectedItems.length; i++) {
                dataItems.push(grid.dataItem(selectedItems[i]).id);
            }
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/DeletePayRollDocuments"),
                data: {
                    pIds: dataItems
                },
                success: function (data) {
                    if (data.Result != "OK") {
                        showBarsErrorAlert(data.ErrorMsg);
                    } else {
                        bars.ui.alert({ text: 'Готово !' });
                    }
                    formCfg.updateGrid();
                }
            });
        });
    });

    $('.custom-btn-payroll-history').on('click', function () {
        var view;
        if (+formCfg.mode == 0 || +formCfg.mode == 2) {
            view = false;
        } else {
            view = true;
        }

        historyForm(formCfg.salaryDealId, formCfg.payRollID, view, function () {
            formCfg.updateGrid();
        });
    });

    $('.custom-btn-accept-payroll').on('click', function () {
        var postData = {
            Id: formCfg.payRollID,
            PrDate: $('#salary_payroll_date').val(),
            PayrollNum: $('#salary_payroll_number').val(),
            Purpose: $('#payment_purpose').val()
        };

        if (postData.PrDate == '' || postData.PayrollNum == '' || postData.Purpose == '') {
            bars.ui.error({ text: "Не достатньо даних, перевірте, чи усі обов'язкові поля заповнено: <br/><b>Номер ЗП відомості</b><br/><b>Дата</b><br/><b>Призначення платежу</b>" });
            return;
        }

        bars.ui.loader('body', true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/CreatePayRoll"),
            data: postData,
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    formCfg.setPayrollNumber($('#salary_payroll_number').val());
                    $("#title").html(formCfg.gettitle());

                    var grid = $(formCfg.gridSelector).data("kendoGrid");
                    var dataSource = grid.dataSource;
                    var recordsOnCurrentView = dataSource.view().length;
                    if (recordsOnCurrentView > 0) {
                        $('.custom-btn-payroll-ok').removeAttr('disabled');
                    }

                    $('.custom-btn-print').removeAttr('disabled');
                }
            },
            error: function () {
                bars.ui.loader('body', false);
            }
        });
    });

    $('.custom-btn-payroll-ok').on('click', function () {
        bars.ui.confirm({ text: '<b>Увага !</b></br>Буде здійснено підписання внесених документів за допомогою ЕЦП. </br>Після підтвердження, редагування даних у відомості буде не можливим !</br>Продовжити ?', height: "150px" }, function () {
            signAllPayrollDocuments([formCfg.payRollID], false, function (signs) {
                var postData = {
                    records: signs,
                    payrollId: +formCfg.payRollID
                };

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/ApprovePayroll"),
                    data: postData,
                    success: function (data) {
                        var isOk = data.Result == "OK";
                        var msg = isOk ? 'Відомість підтверджена.' : data.ErrorMsg;
                        $signerPopUp.PopUpShowResults(isOk, msg, function () {
                            $('.custom-btn-back').click();
                        });
                    }
                });
            });
        });
    });

    $('.custom-btn-file-import').on('click', function () {
        importForm(formCfg.payRollID, formCfg.curPurpose, function () {
            formCfg.updateGrid();
        });
    });

    $('.custom-btn-print').on('click', function () {
        var pNum = formCfg.mode != 3 ? $('#salary_payroll_number').val() : $('#lbl_salary_payroll_number').text();
        printPayroll({
            payroll_num: pNum,
            nmk: $('#client_name').text(),
            id: formCfg.payRollID
        });
    });
};

function fillDealInfo() {
    bars.ui.loader('body', true);
    getOurMfo();
    $.ajax({
        type: "get",
        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetDealAndPayRollInfo"),
        data: {
            payRollId: +formCfg.payRollID
        },
        success: function (data) {
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                $("#deal_name").text(data.ResultObj.deal_name);
                $("#edrpou_code").text(data.ResultObj.okpo);
                $("#client_name").text(data.ResultObj.nmk);
                $("#code_zp").text(data.ResultObj.deal_id);
                $("#is_premial").html(+data.ResultObj.deal_premium == 1 ? '&#10004;' : '&#10006;');

                $("#ost_2905_lbl").html(convertToMoneyStr(data.ResultObj.ostc_2909) + ' &#8372;');

                $('#nls_sum').text(data.ResultObj.nls_2909);

                if (formCfg.mode != 3) {
                    $('#salary_payroll_date').data('kendoDatePicker').value(data.ResultObj.pr_date || new Date());
                    $('#salary_payroll_number').val(data.ResultObj.payroll_num);
                    $('#payment_purpose').val(data.ResultObj.nazn);
                } else {
                    $('#lbl_salary_payroll_date').text(getDateFromString(data.ResultObj.pr_date));
                    $('#lbl_salary_payroll_number').text(data.ResultObj.payroll_num);
                    $('#lbl_payment_purpose').text(data.ResultObj.nazn);
                }

                //payroll acceptance label
                var acceptanceLbl = $('#acceptanceLbl');
                if (data.ResultObj.signed == "Y") {
                    acceptanceLbl.removeClass('invisible');
                    if (!data.ResultObj.signed_fio)
                        acceptanceLbl.text("Відомість підписана.");
                    else
                        acceptanceLbl.text("Відомість підписана користувачем: " + data.ResultObj.signed_fio + ".");
                }

                formCfg.setCurrentDebt(data.ResultObj.ostc_3570);

                var comissionDebt = +data.ResultObj.ostc_3570;
                if (comissionDebt < 0) {
                    $('.comissionDebtColumn').removeClass('invisible');
                    $('#comission_debt_value_lbl').html(convertToMoneyStr(comissionDebt * -1) + ' &#8372;');
                }


                formCfg.setTarifCode(data.ResultObj.kod_tarif);
                formCfg.setPurpose(data.ResultObj.nazn);

                calcCommission();
            }
            bars.ui.loader('body', false);
        },
        error: function () {
            bars.ui.loader('body', false);
        }
    });
};

function getDateFromString(strVal) {
    var dateResult = new Date();
    if (strVal != null && strVal != undefined) {

        var dateNum = strVal.split('(')[1].split(')')[0];
        var dateNumClear = dateNum.split('+')[0];

        dateResult = new Date(+dateNumClear);
    }
    var year = dateResult.getFullYear();
    var month = dateResult.getMonth() + 1;
    month = month > 9 ? month : '0' + month;
    var day = dateResult.getDate();
    day = day > 9 ? day : '0' + day;

    return day + "." + month + "." + year;
};

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.6);
};

$(document).ready(function () {
    bars.ui.loader('body', true);

    var myNav = navigator.userAgent.toLowerCase();
    var browser = (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
    $('#td_with_logo').addClass(+browser === 8 ? 'logo-td-ie8' : 'logo-td');

    //$(document).on('keyup', onEscKeyUp);

    $('#payment_purpose').on('change', function () {
        formCfg.setPurpose($(this).val());
    });

    var cfg = JSON.parse(decodeURI(getUrlParameter('cfg')));

    initKendoDatePicker();
    addEventListenersToButtons();
    formCfg.configurateForm(cfg);
    initKendoWidgets();

    fillDealInfo();

    $("#title").html(formCfg.gettitle());

    bindSelectOnFocus();
    changeGridMaxHeight();
});