function AddOrEditForm(selectedItem) {
    selectedItem = selectedItem || {};
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
            kendoWindow.find("#client_pib_editor").val(data.nmk);
            kendoWindow.find("#okpo_editor").val(data.okpo);
            kendoWindow.find("#mfo_editor").val(data.mfo);
            kendoWindow.find("#nls_editor").val(data.nls);
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

    if (selectedItem.id === undefined) {
        //kendoWindow.find('#mfo_editor').on('change', function() {
        //    var _mfo = $(this).val();
        //    if (selectedItem.id === undefined) {

        //        if (_mfo != formCfg.ourMfo) {
        //            kendoWindow.find('#client_pib_editor').val('');
        //            kendoWindow.find('#okpo_editor').val('');
        //        } else {
        //            if (kendoWindow.find('#nls_editor').val() != '') {
        //                getClientByNls();
        //            }
        //        }
        //    }
        //});

        var fireBlur = true;
        kendoWindow.find('#nls_editor').on('blur', function () {
            if (!fireBlur) return;
            fireBlur = false;
            console.log('blur');
            checkNls();
        });
    }
    kendoWindow.find("#sum_editor").kendoNumericTextBox(getNumericOptions());

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
                        kendoWindow.find('#client_pib_editor').val(data.ResultObj.nmk);
                        kendoWindow.find('#okpo_editor').val(data.ResultObj.okpo);
                    }
                }
            },
            error: function (jqXHR, exception) {
                bars.ui.loader(kendoWindow, false);
            }
        });
    };

    function validateAddEditForm() {
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
                Summ: kendoWindow.find("#sum_editor").data("kendoNumericTextBox").value()
            },
            errors: ''
        };

        if (formCfg.ourMfo != result.enteredData.MfoB) {
            if (isEmpty(result.enteredData.OkpoB)) result.errors += '<b>ІПН</b></br>'
            if (isEmpty(result.enteredData.NameB)) result.errors += '<b>ПІБ</b></br>'
            if (isEmpty(result.enteredData.MfoB)) result.errors += '<b>МФО</b></br>'
        }

        if (isEmpty(result.enteredData.NlsB)) result.errors += '<b>Рахунок одержувача</b></br>'
        if (isEmpty(result.enteredData.PaymentPurpose) || result.enteredData.PaymentPurpose.length < 3) result.errors += '<b>Призначення платежу</b> (мінімальна довжина 3 символи)</br>'
        if (+result.enteredData.Summ <= 0) result.errors += '<b>Сума</b></br>'

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