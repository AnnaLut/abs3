function AddOrEditForm(selectedItem) {
    selectedItem = selectedItem || {};
    var ipnDefault = '0000000000';

    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: selectedItem.id === undefined ? 'Створення документу' : 'Редагування документу',
        resizable: false,
        modal: true,
        draggable: true,
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            kendoWindow.data("kendoWindow").refresh();
            kendoWindow.find('#nls_editor').focus();
        }
    });

    var template = kendo.template($("#AddEditPayRollDocumentTemplate").html());

    kendoWindow.data("kendoWindow").content(template(selectedItem));

    kendoWindow.find("#btnCancel").on('click', function () {
        kendoWindow.data("kendoWindow").close();
    });

    kendoWindow.find("#btnSave").on('click', function () {
        var validation = validateAddEditForm();
        if (validation.res)
            sendEditForm(validation.enteredData);
    });

    kendoWindow.find("#client_pib_editor_btn").on('click', function () {
        selectClientForm(formCfg.salaryDealId, function (data) {
            noIpnCbChange(data.okpo == ipnDefault);

            kendoWindow.find("#client_pib_editor").val(data.nmk);
            kendoWindow.find("#okpo_editor").val(data.okpo);
            kendoWindow.find("#mfo_editor").val(data.mfo);
            kendoWindow.find("#nls_editor").val(data.nls);

            kendoWindow.find('#passportSeries').val(data.PassportSerial);
            kendoWindow.find('#passportNumber').val(data.PassportNumber);
        });
    });

    kendoWindow.find('#mfo_editor, #nls_editor').on('change', function (evt) {
        this.value = this.value.replace(/[^0-9]+/g, '');
    });

    kendoWindow.find('#mfo_editor').on('change', function () {
        if (kendoWindow.find('#nls_editor').val() != '') {
            kendoWindow.find('#nls_editor').val('').focus();
        }
    });

    kendoWindow.find('#mfo_editor').on('blur', function () {
        var _mfo = $(this).val();
        if (_mfo === undefined || _mfo == null || _mfo.length != 6) {
            kendoWindow.find('#nls_editor').attr('disabled', 'disabled');
            var tooltip = $("<div />").kendoTooltip({
                content: 'МФО не може бути пустим і повинно містити 6 цифер !'
            }).data("kendoTooltip");

            tooltip.show($("#mfo_editor"));
            setTimeout(function () { tooltip.hide() }, 2000);

            kendoWindow.find('#mfo_editor').focus();
            return;
        } else {
            kendoWindow.find('#nls_editor').removeAttr('disabled');
        }

        if (selectedItem.id === undefined) {
            if (_mfo != formCfg.ourMfo) {
                kendoWindow.find('#client_pib_editor').val('');
                kendoWindow.find('#okpo_editor').val('');
            } else {
                if (kendoWindow.find('#nls_editor').val() != '') {
                    getClientByNls();
                }
            }
        }
    });

    kendoWindow.find('#okpo_editor').on('change', function () {
        noIpnCbChange($(this).val() == ipnDefault)
    });

    function noIpnCbChange(val) {
        var editor = $('#okpo_editor');
        kendoWindow.find('#no_ipn_cb').prop('checked', val);
        enableElem('#okpo_editor', !val);

        if (!val) {
            $('#passportData').addClass('invisible');
            if (editor.val() == ipnDefault) editor.val('');
        } else {
            $('#passportData').removeClass('invisible');
            editor.val(ipnDefault);
        }
    };

    kendoWindow.find('#passportSeries').on('keypress', function (event) {
        var alphabetAnd = /[A-Za-z]|[А-Яа-я]|[Іі]/g;
        var key = String.fromCharCode(event.which);
        if (event.keyCode == 8 || event.keyCode == 37 || event.keyCode == 39 || alphabetAnd.test(key)) {
            return true;
        }
        return false;
    });
    kendoWindow.find('#passportNumber, #idCardNumber').on('keypress', function (event) {
        var alphabetAnd = /[A-Za-z]|[А-Яа-я]|[Іі]/g;
        var key = String.fromCharCode(event.which);
        if (event.keyCode == 8 || event.keyCode == 37 || event.keyCode == 39 || !alphabetAnd.test(key)) {
            return true;
        }
        return false;
    });

    kendoWindow.find('#no_ipn_cb').on('change', function () {
        noIpnCbChange(this.checked);
    });

    var passpType = 0;
    if (!selectedItem.passp_serial && selectedItem.idcard_num) {
        $('#passpSeriesDiv, #passportNumber').css('display', 'none');
        $('#idCardNumber').css('display', 'inline-block');
        passpType = 1;
    }

    kendoWindow.find('#passportType').kendoDropDownList({
        dataTextField: "txt",
        dataValueField: "val",
        template: '<span style="font-size:12px;">#:data.txt#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.txt#</span>',
        dataSource: [
            { val: 0, txt: 'Паспорт' },
            { val: 1, txt: 'ID-картка' }
        ],
        value: passpType,
        change: function (e) {
            var docType = +e.sender.value();

            if (docType === 1) {
                $('#passpSeriesDiv, #passportNumber').css('display', 'none');
                $('#idCardNumber').css('display', 'inline-block');
            } else {
                $('#passpSeriesDiv, #passportNumber').css('display', 'inline-block');
                $('#idCardNumber').css('display', 'none');
            }
        }
    });
    kendoWindow.find('#passportSeries').on('change', function () {
        this.value = this.value.toUpperCase();
    });

    if (selectedItem.id === undefined) {
        var fireBlur = true;
        kendoWindow.find('#nls_editor').on('blur', function () {
            if (!fireBlur) return;
            fireBlur = false;
            checkNls();
        });
    }
    kendoWindow.find("#sum_editor").kendoNumericTextBox(getNumericOptions());

    if (selectedItem.okpob == ipnDefault) {
        noIpnCbChange(true);
    }

    kendoWindow.data("kendoWindow").center().open();
    bindSelectOnFocus();


    function checkNls() {
        var _nls = kendoWindow.find('#nls_editor').val();
        var _mfo = kendoWindow.find('#mfo_editor').val();

        if (_nls === '') {
            fireBlur = true;
            return;
        }

        var tooltip = $("<div />").kendoTooltip({
            content: 'Невірний контрольний розряд рахунку для МФО ' + kendoWindow.find('#mfo_editor').val()
        }).data("kendoTooltip");

        if (_nls.length < 5) {
            tooltip.show($("#nls_editor"));
            setTimeout(function () { tooltip.hide() }, 2000);

            kendoWindow.find('#nls_editor').focus();
            fireBlur = true;
        } else {
            bars.ui.loader(kendoWindow, true);
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/SalaryBag/SalaryBag/CheckAcc"),
                data: {
                    mfo: _mfo,
                    acc: _nls
                },
                success: function (data) {
                    bars.ui.loader(kendoWindow, false);
                    if (data.Result != "OK") {
                        showBarsErrorAlert(data.ErrorMsg);
                    } else {
                        if (data.ResultMsg != 'true') {
                            tooltip.show($("#nls_editor"));
                            setTimeout(function () { tooltip.hide() }, 2000);
                            kendoWindow.find('#nls_editor').focus();
                        } else {
                            if (_mfo == formCfg.ourMfo) {
                                getClientByNls();
                            }
                        }
                    }
                    fireBlur = true;
                },
                error: function (jqXHR, exception) {
                    bars.ui.loader(kendoWindow, false);
                    fireBlur = true;
                }
            });
        }
    };

    function getClientByNls() {
        var _nls = kendoWindow.find('#nls_editor').val();

        bars.ui.loader(kendoWindow, true);
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetClientInfoByNls"),
            data: {
                nls: _nls
            },
            success: function (data) {
                bars.ui.loader(kendoWindow, false);
                if (data.Result != "OK") {
                    //showBarsErrorAlert(data.ErrorMsg);
                } else {
                    if (data.ResultObj !== undefined && data.ResultObj != null) {
                        noIpnCbChange(data.ResultObj.okpo == ipnDefault);

                        kendoWindow.find('#client_pib_editor').val(data.ResultObj.nmk);
                        kendoWindow.find('#okpo_editor').val(data.ResultObj.okpo);
                        kendoWindow.find('#passportSeries').val(data.ResultObj.PassportSerial);
                        kendoWindow.find('#passportNumber').val(data.ResultObj.PassportNumber);
                    }
                }
            },
            error: function (jqXHR, exception) {
                bars.ui.loader(kendoWindow, false);
            }
        });
    };

    function validateAddEditForm() {
        var noIpn = no_ipn_cb.checked;
        var isIdCard = $('#passportType').data('kendoDropDownList').value() == 1;

        var result = {
            res: true,
            enteredData: {
                DocumentId: kendoWindow.find('#payrollDocumentId').val(),
                payrollId: formCfg.payRollID,
                OkpoB: kendoWindow.find("#okpo_editor").val(),
                NameB: kendoWindow.find("#client_pib_editor").val(),
                MfoB: kendoWindow.find("#mfo_editor").val(),
                NlsB: kendoWindow.find("#nls_editor").val(),
                Source: 1,
                PaymentPurpose: kendoWindow.find("#payment_purpose_editor").val(),
                Summ: kendoWindow.find("#sum_editor").data("kendoNumericTextBox").value(),
                PasspSeries: noIpn ? (isIdCard ? '' : kendoWindow.find('#passportSeries').val()) : '',
                PasspNumber: noIpn ? (isIdCard ? '' : kendoWindow.find('#passportNumber').val()) : '',
                //IdCardNumber: noIpn ? (isIdCard ? kendoWindow.find('#passportNumber').val() : '') : ''
                IdCardNumber: noIpn ? (isIdCard ? kendoWindow.find('#idCardNumber').val() : '') : ''
            },
            errors: ''
        };

        if (formCfg.ourMfo != result.enteredData.MfoB) {
            if (isEmpty(result.enteredData.OkpoB)) result.errors += '<b>ІПН</b></br>';
            if (isEmpty(result.enteredData.NameB)) result.errors += '<b>ПІБ</b></br>';
            if (isEmpty(result.enteredData.MfoB)) result.errors += '<b>МФО</b></br>';
        }

        if (isEmpty(result.enteredData.NlsB)) result.errors += '<b>Рахунок одержувача</b></br>';
        if (isEmpty(result.enteredData.PaymentPurpose) || result.enteredData.PaymentPurpose.length < 3) result.errors += '<b>Призначення платежу</b> (мінімальна довжина 3 символи)</br>';
        if (+result.enteredData.Summ <= 0) result.errors += '<b>Сума</b></br>';

        if (noIpn) {
            if (isIdCard) {
                if (isEmpty(result.enteredData.IdCardNumber)) result.errors += '<b>Номер ID-картки</b></br>';
            } else {
                if (isEmpty(result.enteredData.PasspSeries)) result.errors += '<b>Серія паспорту</b></br>';
                if (isEmpty(result.enteredData.PasspNumber)) result.errors += '<b>Номер паспорту</b></br>';
            }
        }

        if (result.errors != '') {
            result.res = false;
            bars.ui.error({ text: "Недостатньо даних, заповніть обо'вязкові поля :<br/>" + result.errors });
        }

        return result;
    };

    function sendEditForm(data) {
        bars.ui.loader(kendoWindow, true);
        $.ajax({
            type: "POST",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/AddEditPayRollDocument"),
            data: data,
            success: function (data) {
                bars.ui.loader(kendoWindow, false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    formCfg.updateGrid();

                    bars.ui.alert({ text: 'Виконано!' });
                    kendoWindow.data("kendoWindow").close();
                }
            },
            error: function (jqXHR, exception) {
                bars.ui.loader(kendoWindow, false);
                kendoWindow.data("kendoWindow").close();
            }
        });
    };

    function isEmpty(input) {
        if (typeof input === undefined || input == null) return true;
        return input.replace(/\s/g, '').length < 1;
    }
};