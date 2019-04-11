function dateSelectForm(callBack) {
    var dateSelectWindow = $('<div id="sagoDateSelectForm"/>').kendoWindow({
        actions: ["Close"],
        title: 'Вибір дати',
        resizable: false,
        modal: true,
        draggable: true,
        width: "450px",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            dateSelectWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);
    dateSelectWindow.data("kendoWindow").content(template({}));

    dateSelectWindow.find("#btnCancel").click(function () {
        dateSelectWindow.data("kendoWindow").close();
    });
    dateSelectWindow.find("#documentsImportDate").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: new Date(),
        dateInput: true,
        max: new Date()
    });
    dateSelectWindow.find("#documentsImportDate").on('change', function () {
        dateChangeFn.call(this);

        var _value = $(this).val().toString().toDate();
        var today = new Date();
        today = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 0, 0, 0, 0);

        if (_value > today)
            $(this).val(today.format());
    });

    dateSelectWindow.find('#btnOk').on('click', function () {
        if (callBack && typeof callBack === 'function') {
            callBack.call(null, +$('#documentsImportDate').data('kendoDatePicker').value());
        }
        dateSelectWindow.data("kendoWindow").close();
    });

    $(dateSelectWindow).on('keyup', function (e) {
        if (e.keyCode == 13)
            dateSelectWindow.find('#btnOk').trigger('click');
    });

    dateSelectWindow.data("kendoWindow").center().open();

    function getTemplate() {
        return '<table style="width:100%;">'
            + '     <tr style="width:100%;">'
            + '         <td style="width:50%;text-align:right;padding-right:10px;">'
            + '             <label class="k-label" for="documentsImportDate">Документи за дату</label>'
            + '         </td>'
            + '         <td style="width:50%;text-align:left;padding-left:10px;">'
            + '             <input id="documentsImportDate" maxlength="10" />'
            + '         </td>'
            + '     </tr>'
            + ' </table>'
            + ' <hr class="modal-hr"/>'
            + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '         <a id="btnOk" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Імпортувати</a>'
            + '     </div>'
            + ' </div>';
    };
};

