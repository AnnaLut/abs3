//mode :
// 'add' - to add new deal
// 'edit' - to edit existing deal
function addEditForm(mode, dataItem) {
    var dataForTemplate = {
        selectedItem: dataItem ? dataItem : {},
        formOptions: {
            title: '',
            confirmBtnText: 'Ok',
            confirmBtnVisibility: true,
            cancelBtnText: 'Скасувати'
        }
    };

    switch (mode.toUpperCase()) {
        case 'ADD':
            dataForTemplate.formOptions.title = 'Створення нового договору';
            dataForTemplate.formOptions.confirmBtnText = 'Зберегти';
            dataForTemplate.formOptions.confirmBtnVisibility = true;
            break;
        case 'EDIT':
            dataForTemplate.formOptions.title = 'Редагування';
            dataForTemplate.formOptions.confirmBtnText = 'Оновити';
            dataForTemplate.formOptions.confirmBtnVisibility = true;
            break;
        default:
    }

    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: dataForTemplate.formOptions.title,
        resizable: false,
        modal: true,
        draggable: false,
        width: "600px",
        animation: getAnimationForKWindow({ animationType: { open: 'right', close: 'left' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            kendoWindow.find(':input:enabled:visible:first').focus();
            kendoWindow.data("kendoWindow").refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var template = kendo.template($("#AddEditTemplate").html());

    kendoWindow.data("kendoWindow").content(template(dataForTemplate));

    kendoWindow
        .find("#btnCancel")
        .click(function () {
            kendoWindow.data("kendoWindow").close();
        })
        .end();

    kendoWindow.find("#btnCancel").keydown(function (e) {
        if (e.which == 9) {
            e.preventDefault();
            kendoWindow.find(':input:enabled:visible:first').focus();
        }
    });

    if (!dataForTemplate.formOptions.confirmBtnVisibility)
        kendoWindow.find("#btnSave").addClass('k-hidden-button');
    else {
        kendoWindow
            .find("#btnSave")
            .click(function () {
                var v = checkEditForm();
                if (!v.result) {
                    bars.ui.error({ text: v.errorMessage });
                    return;
                } else {
                    var postObj = getDataFromEditForm(dataForTemplate.selectedItem.id);
                    var methodName = "CreateDeal";
                    if (postObj.Id !== "")
                        methodName = "UpdateDeal";

                    bars.ui.loader('.k-window:visible > .k-window-content:last', true);
                    $.ajax({
                        type: "POST",
                        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/" + methodName),
                        data: postObj,
                        success: function (data) {
                            bars.ui.loader('.k-window:visible > .k-window-content:last', false);
                            if (data.Result != "OK") {
                                showBarsErrorAlert(data.ErrorMsg);
                            } else {
                                kendoWindow.data("kendoWindow").close();
                                bars.ui.alert({ text: "Дані успішно збережено !" });
                            }
                            updateMainGrid();
                        }
                    });
                }
            }).end();

        kendoWindow.find("#btnSave").keypress(function (e) {
            if (e.which == 13) {
                this.click();
            }
        });
    }

    kendoWindow.find("#tarif_editor_btn").click(function () {
        tsForm(function (data) {
            kendoWindow.find("#tarif_editor").data("kendoNumericTextBox").value(data.kod);

            kendoWindow.find("#tarif_not_found_lbl").text('');

            kendoWindow.find("#tarifDetails").removeClass('invisible')
            kendoWindow.find("#tarif_name_lbl").text(data.name);
            kendoWindow.find("#tarif_summ_lbl").text(data.tar);
            var perc = data.tip == 1 ? 'до ' + data.pr + '%' : data.pr + '%';
            kendoWindow.find("#tarif_percent_lbl").text(perc);

            if (data.tip == 1) {
                kendoWindow.find("#show_tarif_details").removeClass("invisible");
            } else {
                kendoWindow.find("#show_tarif_details").addClass("invisible");
            }

            kendoWindow.data("kendoWindow").refresh();
        })
    }).end();

    function checkAccounts(rnk) {
        kendoWindow.find("#accSelection, #accComboBoxDiv").addClass('invisible');
        kendoWindow.find('.checkbox-circle')[0].checked = true;

        if (rnk === undefined || rnk === null || rnk === '' || rnk === 0) return;

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetAccounts"),
            data: {
                rnk: rnk
            },
            success: function (data) {
                if (data === undefined || data === null || !data.length) {
                    kendoWindow.find("#accSelection").addClass('invisible');
                    kendoWindow.find('.checkbox-circle')[0].checked = true;
                } else {
                    kendoWindow.find("#accSelection").removeClass('invisible');
                    var dontNeedClick = $('#createNewCb:checked').length > 0;
                    if (!dontNeedClick) {
                        kendoWindow.find('.checkbox-circle')[0].checked = true;
                        kendoWindow.find("#accComboBoxDiv").addClass('invisible');
                    }

                    kendoWindow.find("#selectAccDdl").kendoDropDownList({
                        dataTextField: "nls",
                        dataValueField: "acc",
                        width: "100%",
                        placeholder: " --- Оберіть рахунок --- ",
                        dataSource: data,
                        template: '<span class="k-state-default" style="font-size:12px;">#: data.nms + " ("# <b> #: data.nls + ", залишок " + convertToMoneyStr(data.ostc) # &\\#8372;</b> #: ")" #</span>',
                        valueTemplate: '<span class="k-state-default" style="font-size:12px;">#: data.nms + " ("# <b> #: data.nls + ", залишок " + convertToMoneyStr(data.ostc) # &\\#8372;</b> #: ")" #</span>'
                    });
                }
                kendoWindow.data("kendoWindow").refresh();
            }
        });
    };

    function checkAcc3570(rnk) {
        bars.ui.loader(kendoWindow, true);
        kendoWindow.find(".acc3570_editor").addClass('invisible');

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/SalaryBag/SalaryBag/Get3570Accounts"),
            data: {
                rnk: rnk
            },
            success: function (data) {
                if (data === undefined || data === null || !data.length || data.length <= 1) {

                } else {
                    kendoWindow.find("#selectAcc3570Ddl").kendoDropDownList({
                        dataTextField: "nls",
                        dataValueField: "acc",
                        width: "100%",
                        placeholder: " --- Оберіть рахунок 3570 --- ",
                        dataSource: data,
                        template: '<span class="k-state-default" style="font-size:12px;">#: data.nms + " ("# <b> #: data.nls # </b> #: ")" #</span>',
                        valueTemplate: '<span class="k-state-default" style="font-size:12px;">#: data.nms + " ("# <b> #: data.nls # </b> #: ")" #</span>',
                        value: dataForTemplate.selectedItem.acc_3570,
                        change: function (e) {
                            var ost3570 = +dataForTemplate.selectedItem.ostc_3570;
                            if (ost3570 < 0) {
                                bars.ui.alert({ text: "По поточному рахунку 3570 (<b>" + dataForTemplate.selectedItem.nls_3570 + "</b>) є заборгованість(<b>" + ost3570 * -1 + " грн.</b>), спочатку погасіть її." });
                                kendoWindow.find('#selectAcc3570Ddl').data('kendoDropDownList').value(dataForTemplate.selectedItem.acc_3570);
                            }
                        }
                    });

                    setTimeout(function () {
                        kendoWindow.find(".acc3570_editor").removeClass('invisible');
                    }, 300);
                }
                bars.ui.loader(kendoWindow, false);
                kendoWindow.data("kendoWindow").refresh();
            },
            error: function (jqXHR, exception) {
                bars.ui.loader(kendoWindow, false);
            }
        });
    };

    kendoWindow.find('#branch_editor_ddl').kendoDropDownList({
        dataTextField: "Branch",
        dataValueField: "Branch",
        template: '<span style="font-size:12px;">#:data.Branch#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.Branch#</span>',
        filter: 'contains',
        dataSource: {
            type: "json",
            transport: {
                read: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetBranches")
            }
        },
        value: dataForTemplate.selectedItem.branch
    });

    kendoWindow.find("#rnk_editor_btn").click(function () {
        rnkForm(function (data) {
            kendoWindow.find("#rnk_editor").data("kendoNumericTextBox").value(data.rnk);

            kendoWindow.find("#rnk_not_found_lbl").text('');

            kendoWindow.find("#customerDetails").removeClass('invisible');
            kendoWindow.find("#customer_name_lbl").text(data.nmk);
            kendoWindow.find("#customer_okpo_lbl").text(data.okpo);
            kendoWindow.find("#customer_branch_lbl").text(data.branch);
            kendoWindow.find("#branch_editor_ddl").data("kendoDropDownList").value(data.branch);
            checkAccounts(data.rnk);
            kendoWindow.data("kendoWindow").refresh();
        })
    }).end();

    kendoWindow.find("#show_tarif_details").click(function () {
        showTarifDetails(kendoWindow.find("#tarif_editor").val(), kendoWindow.find("#tarif_name_lbl").text());
    }).end();

    //если договор в статусе - новий (0,2), то возможность редактиврования :
    //название, дату договора,центр,тариф, премиум
    //если договор в статусе - действующий (5,4), то возможность редактиврования :
    //центр,тариф, премиум
    if (mode.toUpperCase() == 'EDIT') {
        kendoWindow.find('.start_date_editor_input_for_add').remove();

        var type = dataForTemplate.selectedItem.sos;
        switch (type) {
            case 0:
            case 2:
                $("#rnk_editor_input").addClass('invisible');
                $("#rnk_editor_lbl").removeClass('invisible');
                break;
            case 4:
            case 5:
            case 7:
                $("#rnk_editor_input, #start_date_editor_input, .deal_name_editor_input").addClass('invisible');
                $("#rnk_editor_lbl, #start_date_editor_lbl, #deal_name_editor_lbl").removeClass('invisible');
                checkAcc3570(dataForTemplate.selectedItem.rnk);
                break;
        }
        $("#additional_info").removeClass('invisible');

        if (~[0, 5].indexOf(type)) {
            $('#branch_editor_input').removeClass('invisible');
            $('#branch_editor_lbl').addClass('invisible');
        }

    } else {
        kendoWindow.find('.start_date_editor_input_for_edit').remove();
    }

    var _start_date = dataForTemplate.selectedItem.start_date;
    kendoWindow.find("#start_date_editor").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: _start_date ? _start_date : new Date(),
        dateInput: true,
        change: function () {
            var value = this.value();
            var today = new Date();

            if (value === undefined || value === null || value === '')
                this.value(today);

            var thisDate = new Date(value);

            if (dateCompare(thisDate, today) == 1)
                this.value(today);
        }
    });

    kendoWindow.find("#tarif_editor").kendoNumericTextBox({
        min: 0,
        spinners: false,
        decimals: 0,
        restrictDecimals: true,
        placeholder: "Введіть код",
        format: "#",
        change: function () {
            var value = this.value();
            if (value === null || value === '') {
                kendoWindow.find("#tarif_editor").data("kendoNumericTextBox").value(null);
                kendoWindow.find("#tarifDetails, #show_tarif_details").addClass('invisible')
            } else {
                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetTarifByCode"),
                    data: {
                        code: value
                    },
                    success: function (data) {
                        if (data === undefined || data === null) {
                            kendoWindow.find("#tarif_not_found_lbl").text('Тариф з кодом "' + value + '" не знайдено !!!');
                            kendoWindow.find("#tarif_editor").data("kendoNumericTextBox").value(null);
                            kendoWindow.find("#tarifDetails, #show_tarif_details").addClass('invisible')
                        } else {
                            kendoWindow.find("#tarif_not_found_lbl").text('');

                            kendoWindow.find("#tarifDetails").removeClass('invisible')
                            kendoWindow.find("#tarif_name_lbl").text(data.name);
                            kendoWindow.find("#tarif_summ_lbl").text(data.tar);

                            var perc = data.tip == 1 ? 'до ' + data.pr + '%' : data.pr + '%';
                            if (data.tip == 1) {
                                kendoWindow.find("#show_tarif_details").removeClass("invisible");
                            } else {
                                kendoWindow.find("#show_tarif_details").addClass("invisible");
                            }

                            kendoWindow.find("#tarif_percent_lbl").text(perc);
                        }
                        kendoWindow.data("kendoWindow").refresh();
                    }
                });
            }
        }
    });

    kendoWindow.find("#rnk_editor").kendoNumericTextBox({
        min: 0,
        spinners: false,
        decimals: 0,
        restrictDecimals: true,
        format: "#",
        placeholder: "Введіть РНК",
        change: function () {
            var value = this.value();
            if (value === null || value === '') {
                kendoWindow.find("#customerDetails").addClass('invisible');
                kendoWindow.find("#accSelection, #accComboBoxDiv").addClass('invisible');
                kendoWindow.find('.checkbox-circle')[0].checked = true;
            } else {
                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetCustomerByRnk"),
                    data: {
                        rnk: value
                    },
                    success: function (data) {
                        if (data === undefined || data === null) {
                            kendoWindow.find("#rnk_not_found_lbl").text('Клієнта з РНК = "' + value + '" не знайдено !!!');
                            kendoWindow.find("#rnk_editor").data("kendoNumericTextBox").value(null);
                            kendoWindow.find("#customerDetails").addClass('invisible');
                        } else {
                            kendoWindow.find("#rnk_not_found_lbl").text('');
                            kendoWindow.find("#customerDetails").removeClass('invisible');
                            kendoWindow.find("#customer_name_lbl").text(data.nmk);
                            kendoWindow.find("#customer_okpo_lbl").text(data.okpo);
                            kendoWindow.find("#customer_branch_lbl").text(data.branch);
                            kendoWindow.find("#branch_editor_ddl").data("kendoDropDownList").value(data.branch);

                            checkAccounts(data.rnk);
                        }
                        kendoWindow.data("kendoWindow").refresh();
                    }
                });
            }
        }
    });

    kendoWindow.find("#deal_premium_editor").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            { text: "Базовий", value: 0 },
            { text: "Преміальний", value: 1 }
        ],
        value: dataForTemplate.selectedItem.deal_premium || 0
    });

    kendoWindow.find("#central_editor").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            { text: "Ні", value: 0 },
            { text: "Так", value: 1 }
        ],
        value: dataForTemplate.selectedItem.central || 0
    });

    kendoWindow.find("#fs_editor").kendoDropDownList({
        dataTextField: "name",
        dataValueField: "id",
        template: '<span style="font-size:12px;">#:data.name#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.name#</span>',
        dataSource: {
            type: "json",
            transport: {
                read: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetFs")
            }
        },
        //open: adjustDropDownWidth,
        value: dataForTemplate.selectedItem.fs || 0
    });

    if (+dataForTemplate.selectedItem.tip === 1) {
        kendoWindow.find("#show_tarif_details").removeClass("invisible");
    } else {
        kendoWindow.find("#show_tarif_details").addClass("invisible");
    }

    kendoWindow.find("#createNewCb").on('change', function () {
        kendoWindow.find("#accComboBoxDiv").toggleClass('invisible');
    });

    kendoWindow.data("kendoWindow").center().open();

    bindSelectOnFocus();
};

//function adjustDropDownWidth(e) {
//    var listContainer = e.sender.list.closest(".k-list-container");
//    listContainer.width(listContainer.width() + kendo.support.scrollbar());
//};

function viewForm(dataItem) {
    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Перегляд договору',
        resizable: false,
        modal: true,
        draggable: true,
        width: "700px",
        //height: "500px",
        animation: getAnimationForKWindow({ animationType: { open: 'right', close: 'left' } }),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            this.refresh();
        },
        refresh: function () {
            this.center();
        }
    });

    var template = kendo.template($("#ViewFormTemplate").html());

    kendoWindow.data("kendoWindow").content(template(dataItem)).center().open();

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#view_tarifs_details").click(function () {
        showTarifDetails(dataItem.kod_tarif, dataItem.tarif_name);
    }).end();
};

function getDataFromEditForm(id) {
    var rnk = $("#rnk_editor").val().trim();
    var dealName = $("#deal_name_editor").val().trim();
    var dealDate = $("#start_date_editor").val();
    var prem = $("#deal_premium_editor").data("kendoDropDownList").value();
    var central = $("#central_editor").data("kendoDropDownList").value();
    var fs = $("#fs_editor").data("kendoDropDownList").value();
    var tarif = $("#tarif_editor").val().trim();

    var isNewAcc = $('#createNewCb:checked').length > 0;
    var acc = isNewAcc ? null : $("#selectAccDdl").data("kendoDropDownList").value();

    var _acc3570 = $('.acc3570_editor').hasClass('invisible') ? '' : $("#selectAcc3570Ddl").data("kendoDropDownList").value();
    var branch = $('#branch_editor_ddl').data('kendoDropDownList').value();

    return {
        Id: id || '',
        Rnk: rnk,
        DealName: dealName,
        StartDate: dealDate,
        Premium: prem,
        Central: central,
        KodTarif: tarif,
        Account: acc,
        Fs: fs,
        acc3570: _acc3570,
        Branch: branch
    }
};

function checkEditForm() {
    var returnRes = {
        errorMessage: "Не усі обов'язкові поля заповнено !<br/>Необхідно ввести наступні дані:<br/>",
        result: true
    }

    var rnk = $("#rnk_editor").val().trim();
    var dealName = $("#deal_name_editor").val().trim();
    var tarif = $("#tarif_editor").val().trim();

    if (rnk === null || rnk === '') {
        returnRes.errorMessage += "<br/><b>РНК</b>";
        returnRes.result = false;
    }
    if (dealName === null || dealName === '') {
        returnRes.errorMessage += "<br/><b>Назва договору</b>";
        returnRes.result = false;
    }
    if (tarif === null || tarif === '') {
        returnRes.errorMessage += "<br/><b>Тариф</b>";
        returnRes.result = false;
    }
    return returnRes;
};