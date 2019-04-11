function GetReportForm() {
    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Оберіть період',
        resizable: false,
        width: 500,
        modal: true,
        draggable: true,
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            kendoWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({}));

    kendoWindow.find("#btnCancel, .custom-btn-back").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#accNumber").kendoDropDownList({
        dataTextField: "AccountNumber",
        dataValueField: "AccountNumber",
        template: '#= getAccDdlTemplate(data.AccountNumber, data.AccountName, true) #',
        valueTemplate: '#= getAccDdlTemplate(data.AccountNumber, data.AccountName, false) #',
        //template: '<span style="font-size:12px;"><b>#: data.AccountNumber #</b><br/>#: " (" + data.AccountName + ")"#</span>',
        //valueTemplate: '<span style="font-size:12px;"><b>#: data.AccountNumber #</b>#: " (" + data.AccountName + ")"#</span>',
        dataSource: {
            type: "json",
            transport: {
                read: bars.config.urlContent('/api/Subvention/SubMonitoring/GetAccountsForReport')
            }
        }
    });

    kendoWindow.find("#btnSave").click(function () {
        var d = getDates();
        var accNum = kendoWindow.find("#accNumber").data('kendoDropDownList').value();

        if (d.dateFrom.toDate() > d.dateTo.toDate()) {
            bars.ui.error({ text: 'Значення "<b>Дата З</b>" не може бути більшим ніж "<b>Дата По</b>" !' });
            return;
        } else if (!accNum) {
            bars.ui.error({ text: 'Значення поля "<b>Рахунок списання</b>" не може бути пустим !<br/>Якщо відсутні значення для вибору, потрібно перейти на рівень <b>ЦА(/300465/)</b> або <b>слеш(/)</b>.' });
            return;
        }

        var url = bars.config.urlContent('/api/Subvention/SubMonitoring/GetReport?dateFrom=' + d.dateFrom + '&dateTo=' + d.dateTo + '&accNumber=' + accNum);
        document.location.href = url;

        bars.ui.notify('Формування файлу розпочато.', 'Завантаження розпочнеться автоматично.<br/>Не закривайте браузер.', 'info', {
            autoHideAfter: 3 * 1000,
            width: "350px"
        });

        kendoWindow.data('kendoWindow').close();
    }).end();

    kendoWindow.find("#dateFrom, #dateTo").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: new Date(),
        dateInput: true
    });

    kendoWindow.data("kendoWindow").center().open();

    function getDates() {
        var dateFrom = kendoWindow.find("#dateFrom").val();
        var dateTo = kendoWindow.find("#dateTo").val();

        return {
            dateFrom: dateFrom,
            dateTo: dateTo
        };
    }
    kendoWindow.find("#dateFrom, #dateTo").on('change', dateChangeFn);
    function dateChangeFn() {
        var _value = $(this).val();

        _value = _value.replace(/ |,|-|\//g, '.');
        var regex = /^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$/;
        if (!_value.match(regex)) {
            var today = new Date();
            today = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 0, 0, 0, 0);
            $(this).data('kendoDatePicker').value(today);

        } else {
            $(this).val(_value);
        }
    }

    function getTemplate() {
        return headerTmp() + templateButtons();
    }

    function headerTmp() {
        return '<div style="width:100%;text-align: center;">'
            + '     <hr style="margin: 7px;"/>'
            + '     <label for="dateFrom" class="k-label bold-lbl" style="margin-left:7px; font-weight: bold; white-space: pre-wrap;">Дата З :</label>'
            + '     <input id="dateFrom">'
            + '     <label for="dateTo" class="k-label" style="margin-left:7px; font-weight: bold; white-space: pre-wrap;">Дата По :</label>'
            + '     <input id="dateTo">'
            + '     <hr style="margin: 7px;"/>'
            + '     <label for="accNumber" class="k-label" style="margin-left:7px; font-weight: bold; white-space: pre-wrap;">Рахунок списання :</label>'
            + '     <input id="accNumber" style="width: 60%;">'
            + ' </div>'
            + ' <hr class="modal-hr"/>';
    }

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel" style="float: right; margin: 5px;" tabindex="3"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update" style="float: right; margin: 5px;" tabindex="8"><span class="k-icon k-update"></span> Ок</a>'
            + '     </div>'
            + ' </div>';
    }
}

function getAccDdlTemplate(acc, accName, twoeLines) {
    var br = twoeLines ? '<br/>' : '';
    if (!acc) return '';

    return '<span style="font-size:12px;"><b>' + acc + '</b>' + br + ' (' + accName + ')</span>';
}