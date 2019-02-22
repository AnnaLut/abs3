//function that call confirm window with reason entering
//properties = {
//    title: "window title",
//    maxLength: "reason max length, default is 500",
//    minLength: "reason min length, default is 0",
//    customTemplate: "html code that will be placed before the textarea, default is nothing",
//    additionalData: "js object that will be passed to okFunction, default is {}",
//    okFunc: "function that will execute on OK button click, object that is described lower will always be passed to this function as a first parameter"
//      okData = {
//          reason: "entered reason",
//          userData: "additionalData object"
//      }
//};
function eacForm(properties) {
    properties.maxLength = checkLenParams(properties.maxLength, 500);
    properties.minLength = checkLenParams(properties.minLength, 0);
    properties.customTemplate = properties.customTemplate || "";
    properties.additionalData = properties.additionalData || {};

    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: properties.title || "Введіть коментар та підтвердіть свої дії",
        resizable: false,
        modal: true,
        draggable: true,
        width: "500px",
        height: "auto",
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            $("#reason").focus();
        }
    });

    var totalTemplate = properties.customTemplate + textAreaTemplate(properties.maxLength, properties.minLength) + templateButtons();

    var template = kendo.template(totalTemplate);

    kendoWindow.data("kendoWindow").content(template({})).center().open();

    kendoWindow.find("#btnCancel").click(function () {
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnCancel").keydown(function (e) {
        if (e.which === 9) {
            e.preventDefault();
            kendoWindow.find('#reason').focus();
        }
    });

    kendoWindow.find("#btnSave").click(function () {
        var reason = $("#reason").val().trim();
        if (reason === undefined || reason === null) {
            reason = "";
        }

        if (reason.length < properties.minLength || reason.length > properties.maxLength) {
            bars.ui.alert({ text: "Коментар повинен містити мінімум " + properties.minLength + " і максимум " + properties.maxLength + " символів" });
            return;
        }

        if (properties.okFunc)
            properties.okFunc({
                reason: reason,
                userData: properties.additionalData
            });
        kendoWindow.data("kendoWindow").close();
    }).end();

    kendoWindow.find("#btnSave").keypress(function (e) {
        if (e.which === 13)
            this.click();
    });

    function textAreaTemplate(maxLength, minLength) {
        var minMsg = minLength > 0 ? 'мінімум ' + minLength + ', ' : '';
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <label for="reason">Коментар (' + minMsg + 'максимум ' + maxLength + ' символів):</label>'
            + '     <textarea id="reason" maxlength="' + maxLength + '" class="k-textbox" tabindex="1"/>'
            + ' </div>';
    }

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Скасувати</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="2"><span class="k-icon k-update"></span> Підтвердити</a>'
            + '     </div>'
            + ' </div>';
    }

    function checkLenParams(value, defaultVal) {
        if (!value) return defaultVal;
        if (value < 0) return defaultVal;

        return value;
    }
}

