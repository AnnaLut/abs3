if (!('bars' in window)) window['bars'] = {};
bars.utils = bars.utils || {};
bars.utils.sto = bars.utils.sto || {};

//функция устнавливает доступность кендо кнопки с иконкой класса pureFlat внутри
bars.utils.sto.enableStoButton = function(buttonId, enabled) {
    if (typeof (enabled) === 'undefined') {
        enabled = true;
    }
    var $button = $('#' + buttonId);
    $button.data('kendoButton').enable(enabled);
    if (enabled) {
        $button.find('i').removeClass("pf-disabled");
    } else {
        $button.find('i').addClass("pf-disabled");
    }
};

//рефрешим поля сбон ордера, устанавливаем видимость и обязательность
bars.utils.sto.refreshFiled = function refreshFiled(filedLiId, enabled, required) {
    if (typeof (required) === 'undefined') required = false;
    var $fieldLi = $('#' + filedLiId);
    if (enabled) {
        $fieldLi.css("display", "list-item");
    } else {
        $fieldLi.css("display", "none");
    }

    if (required) {
        $fieldLi.find('.required-star').css("display", "inline");
        $fieldLi.find('.k-input, .k-textbox').attr('required');
        $fieldLi.find('.k-input, .k-textbox').prop('required', true);
    } else {
        $fieldLi.find('.required-star').css("display", "none");
        $fieldLi.find('.k-input, .k-textbox').removeAttr('required');
        //потушим сообщения об обязательности более не обязательных полей
        $fieldLi.find("span.k-tooltip-validation").hide();
    }
};

bars.utils.sto.selectedCustomer = null;

bars.utils.sto.getCustomerId = function () {
    return {
        custId: bars.utils.sto.selectedCustomer
    };
};

bars.utils.sto.custAccountsDS = new kendo.data.DataSource({
    transport: {
        read: {
            url: bars.config.urlContent("/Payreg/Payreg/GetCustomerAccounts"),
            data: bars.utils.sto.getCustomerId
        }
    }
});

bars.utils.sto.selectCustomer = function () {
    var data = this.dataItem(this.select());
    bars.utils.sto.selectedCustomer = data.id;
    if (bars.utils.sto.selectedCustomer == null) {
        $("#add_sep_order").attr("disabled", "disabled");
        $("#add_sbon_order").attr("disabled", "disabled");
        $("#cust_info").text("Не вибрано клієнта");
    } else {
        $("#add_sep_order").removeAttr("disabled");
        $("#add_sbon_order").removeAttr("disabled");
        $("#cust_info").text("РНК = " + bars.utils.sto.selectedCustomer);
    }

    bars.utils.sto.custAccountsDS.read();
    var ordersDs = $('#cust_orders').data("kendoGrid").dataSource;
    ordersDs.read({
        done: window.setTimeout(function () {
            if (ordersDs.total() > 0) {
                var tabStrip = $("#pages_panel").data("kendoTabStrip");
                tabStrip.select(1);
            }
        }, 400)
    });

};

bars.utils.sto.onSbonProviderSelect = function(extraData) {
    var data = this.dataItem(this.select());
    var currentSbonWorkMode = data.WORK_MODE_ID;
    bars.utils.sto.refreshSbonForm(currentSbonWorkMode);
    bars.utils.sto.loadSbonExtFields(data.ID, extraData);
};

bars.utils.sto.refreshSbonForm = function(workMode) {
    switch (workMode) {
    case 1:
        bars.utils.sto.refreshFiled('sbonPersonalAccountLi', false);
        bars.utils.sto.refreshFiled('sbonRegularAmountLi', true, true);
        bars.utils.sto.refreshFiled('sbonCeilingAmountLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverMfoLi', true, true);
        bars.utils.sto.refreshFiled('sbonReceiverAccountLi', true, true);
        bars.utils.sto.refreshFiled('sbonReceiverNameLi', true, true);
        bars.utils.sto.refreshFiled('sbonReceiverEdrpouLi', true, true);
        bars.utils.sto.refreshFiled('sbonpurposeLi', true, true);
        break;
    case 2:
        bars.utils.sto.refreshFiled('sbonPersonalAccountLi', true, true);
        bars.utils.sto.refreshFiled('sbonRegularAmountLi', true, false);
        bars.utils.sto.refreshFiled('sbonCeilingAmountLi', true, false);
        bars.utils.sto.refreshFiled('sbonReceiverMfoLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverAccountLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverNameLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverEdrpouLi', false);
        bars.utils.sto.refreshFiled('sbonpurposeLi', false);
        break;
    case 3:
        bars.utils.sto.refreshFiled('sbonPersonalAccountLi', true, false);
        bars.utils.sto.refreshFiled('sbonRegularAmountLi', true, true);
        bars.utils.sto.refreshFiled('sbonCeilingAmountLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverMfoLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverAccountLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverNameLi', false);
        bars.utils.sto.refreshFiled('sbonReceiverEdrpouLi', false);
        bars.utils.sto.refreshFiled('sbonpurposeLi', false);
        break;
    }
};

bars.utils.sto.loadSbonExtFields = function(providerId, extraData) {
    function expandData(data, exData) {
        for (var i = 0; i < data.length; i++) {
            var extraItem = $.grep(exData, function (exItem) {
                return exItem.Code === data[i].Code;
            });
            if (extraItem && extraItem.length > 0) {
                data[i].ExtraVal = extraItem[0].Value;
            }
        };
    };

    var $extraFieldsContainer = $('#sbonExtraFields');
    var $errorContainer = $('#sbonExtraError');
    $.get(bars.config.urlContent('/Payreg/Payreg/GetProviderExtraFiledsMeta'), { provId: providerId }).done(function(data) {
        if (data.status == 'ok') {
            $('#sbonButtonPanel').show();
            $errorContainer.hide();
            $errorContainer.html('');
            if (extraData) {
                expandData(data.data, extraData);
            }
            if (data.data.length > 0) {
                $extraFieldsContainer.show();
                var template = kendo.template($("#sbonExtraFieldTmpl").html());
                $extraFieldsContainer.html(template(data.data));
                for (var i = 0; i < data.data.length; i++) {
                    var attrName = data.data[i].Code;
                    var inputId = '#sbon' + attrName;
                    if (data.data[i].Type === "date") {
                        $(inputId).kendoDatePicker({ culture: "uk-UA" });
                    } else if (data.data[i].Type === "money") {
                        $(inputId).kendoNumericTextBox({
                            format: "#.00"
                        });
                    } else if (data.data[i].Type === "integer") {
                        $(inputId).kendoNumericTextBox({ format: "#" });
                    }
                }
            } else {
                $extraFieldsContainer.hide();
                $extraFieldsContainer.find('ul').empty();
            }
        } else {
            $extraFieldsContainer.hide();
            $extraFieldsContainer.find('ul').empty();
            $errorContainer.show();
            $errorContainer.html(data.message);
            $('#sbonButtonPanel').hide();
        }
    });
};

bars.utils.sto.getCurrentSbonWorkMode = function() {
    var sbonProvaiderList = $('#sbonProvaiderId').data('kendoDropDownList');
    return sbonProvaiderList.dataItems()[sbonProvaiderList.selectedIndex].WORK_MODE_ID;
};

bars.utils.sto.getActualSbonActionName = function() {
    switch (bars.utils.sto.getCurrentSbonWorkMode()) {
    case 1:
        return 'AddNewSbonFreeOrder';
    case 2:
        return 'AddNewSbonWithContractOrder';
    case 3:
        return 'AddNewSbonWithoutContractOrder';
    default:
        return '';
    }
};

bars.utils.sto.saveSbonOrder = function () {
    var validator = $("#frmSbonOrder").data("kendoValidator");
    if (validator.validate()) {
        $.ajax({
            type: "POST",
            url: '/barsroot/Payreg/Payreg/' + bars.utils.sto.getActualSbonActionName(),
            data: bars.utils.sto.getSbonData(),
            success: function (data) {
                if (data.error) {
                    bars.utils.sto.showModalWindow(data.error);
                } else {
                    $('#cust_orders').data("kendoGrid").dataSource.read();
                    bars.utils.sto.closeSbonOrderWindow();
                }
            },
            error: bars.utils.sto.errorFunc
        });
    }
};

bars.utils.sto.getSepData = function () {
    var $sepFrm = $('#frmSepOrder');
    var $ddAccList = $sepFrm.find('#sepAccountId').data("kendoDropDownList");
    return {
        Id: $sepFrm.find('#sepOrderId').val(),
        PayerAccountId: $ddAccList.dataSource.data()[$ddAccList.selectedIndex].ACC,
        StartDate: $sepFrm.find('#sepStartDate').val(),
        StopDate: $sepFrm.find('#sepStopDate').val(),
        PaymentFrequency: $sepFrm.find('#sepPaymentFrequency').val(),
        RegularAmount: $sepFrm.find('#sepRegularAmount').val(),
        ReceiverMfo: $sepFrm.find('#sepReceiverMfo').val(),
        ReceiverAccount: $sepFrm.find('#sepReceiverAccount').val(),
        ReceiverName: $sepFrm.find('#sepReceiverName').val(),
        ReceiverEdrpou: $sepFrm.find('#sepReceiverEdrpou').val(),
        Purpose: $sepFrm.find('#sepPurpose').val(),
        HolidayShift: $sepFrm.find('input[name=sepShiftHolidayRadio]:checked').val()
    }
};

bars.utils.sto.getSbonData = function () {
    function extraParam(code, value, type) {
        this.Code = code;
        this.Value = value;
    }

    var $extParams = $('#sbonExtraFields input[id]');
    var extParams = [];
    $.each($extParams, function (index) {
        extParams[index] = new extraParam(this.name, this.value);
    });

    var $sbonFrm = $('#frmSbonOrder');
    var $provDList = $sbonFrm.find('#sbonProvaiderId').data("kendoDropDownList");
    var $ddAccList = $sbonFrm.find('#sbonAccountId').data("kendoDropDownList");

    return {
        Id: $sbonFrm.find('#sbonOrderId').val(),
        PayerAccountId: $ddAccList.dataSource.data()[$ddAccList.selectedIndex].ACC,
        StartDate: $sbonFrm.find('#sbonStartDate').val(),
        StopDate: $sbonFrm.find('#sbonStopDate').val(),
        PaymentFrequency: $sbonFrm.find('#sbonPaymentFrequency').val(),
        ProviderId: $provDList.value() == "" ? $provDList.dataSource.data()[0].ID : $provDList.value(),
        PersonalAccount: $sbonFrm.find('#sbonPersonalAccount').val(),
        RegularAmount: $sbonFrm.find('#sbonRegularAmount').val(),
        CeilingAmount: $sbonFrm.find('#sbonCeilingAmount').val(),
        HolidayShift: $sbonFrm.find('input[name=sbonShiftHolidayRadio]:checked').val(),
        ReceiverMfo: $sbonFrm.find('#sbonReceiverMfo').val(),
        ReceiverAccount: $sbonFrm.find('#sbonReceiverAccount').val(),
        ReceiverName: $sbonFrm.find('#sbonReceiverName').val(),
        ReceiverEdrpou: $sbonFrm.find('#sbonReceiverEdrpou').val(),
        Purpose: $sbonFrm.find('#sbonPurpose').val(),
        ExtraAttributes: JSON.stringify(extParams)
    }
};

bars.utils.sto.closeSepOrderWindow = function () {
    $('#wnd_sep_order').data('kendoWindow').close();
};

bars.utils.sto.closeSbonOrderWindow = function () {
    $('#wnd_sbon_order').data('kendoWindow').close();
};

bars.utils.sto.showModalWindow = function (content) {
    var wnd = $("#errorWnd").data("kendoWindow");
    wnd.content(content);
    wnd.center().open();
};

bars.utils.sto.errorFunc = function () {
    bars.utils.sto.showModalWindow('<b>Помилка виконання запиту!</b>');
};

bars.utils.sto.saveSepOrder = function () {
    var validator = $("#frmSepOrder").data("kendoValidator");
    if (validator.validate()) {
        $.ajax({
            type: "POST",
            url: bars.config.urlContent('/Payreg/Payreg/AddNewSepOrder'),
            data: bars.utils.sto.getSepData(),
            success: function (data) {
                if (data.error) {
                    bars.utils.sto.showModalWindow(data.error);
                } else {
                    $('#cust_orders').data("kendoGrid").dataSource.read();
                    bars.utils.sto.closeSepOrderWindow();
                }
            },
            error: bars.utils.sto.errorFunc
        });
    }
};


bars.utils.sto.closeOrder = function (id) {
    bars.ui.confirm({ text: 'Ви дійсно бажаєте закрити обраний ордер?' },
        function () {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent('/Payreg/Payreg/CloseOrder'),
                data: { orderId: id },
                success: function (data) {
                    if (data.error) {
                        bars.utils.sto.showModalWindow(data.error);
                    } else {
                        $('#cust_orders').data("kendoGrid").dataSource.read();
                    }
                },
                error: bars.utils.sto.errorFunc
            });
        });
};

bars.utils.sto.refreshOrdersToolbar = function () {
    var grid = $('#cust_orders').data('kendoGrid');
    var row = grid.dataItem(grid.select());
    bars.utils.sto.enableStoButton("edit_order", row);
    bars.utils.sto.enableStoButton("printF190", row);
}


bars.utils.sto.getCustFilter = function () {
    return {
        csp: $('#custSearchForm').serializeObject()
    }
};

$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

bars.utils.sto.searchCustomer =  function () {
    var $custGridDs = $('#searched_customers').data("kendoGrid").dataSource;
    $custGridDs.read();
    return false;
};


bars.utils.sto.upPriority = function (id) {
    bars.utils.sto.ShiftPriority(id, -1);
};

bars.utils.sto.ShiftPriority = function (id, direction) {
    $.ajax({
        type: "POST",
        url: bars.config.urlContent('/Payreg/Payreg/ShiftPriority'),
        data: { orderId: id, direction: direction },
        success: function (data) {
            if (data.error) {
                bars.utils.sto.showModalWindow(data.error);
            } else {
                $('#cust_orders').data("kendoGrid").dataSource.read();
            }
        },
        error: bars.utils.sto.errorFunc
    });
}

bars.utils.sto.downPriority = function (id) {
    bars.utils.sto.ShiftPriority(id, 1);
}

bars.utils.sto.printF190 = function()
{
    var grid = $('#cust_orders').data('kendoGrid');
    var row = grid.dataItem(grid.select());
    window.location = bars.config.urlContent('/Payreg/Payreg/PrintF190') + '?orderId=' + row.ID;
}