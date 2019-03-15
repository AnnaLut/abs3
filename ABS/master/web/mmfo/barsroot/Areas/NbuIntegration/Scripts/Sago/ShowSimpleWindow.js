function showSimpleWindow(options) {
    function atata() {
        var a = [
            'up',
            'down',
            'left',
            'right'
        ];

        return {
            animationType: {
                open: a[Math.floor(Math.random() * a.length)],
                close: a[Math.floor(Math.random() * a.length)]
            }
        };
    };

    var simpleWindow = $('<div id="simpleWindow"/>').kendoWindow({
        actions: ["Close"],
        title: options.title || '',
        resizable: false,
        modal: true,
        draggable: true,
        width: "800px",
        refresh: function () {
            this.center();
        },
        //animation: getAnimationForKWindow({ animationType: { open: 'up', close: 'down' } }),
        animation: getAnimationForKWindow(atata()),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            simpleWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);
    simpleWindow.data("kendoWindow").content(template({}));

    simpleWindow.find("#btnCancel").click(function () {
        simpleWindow.data("kendoWindow").close();
    });
    simpleWindow.find('#btnCopyErroText').on('click', function () {
        copy(options.showData);

        simpleWindow.data("kendoWindow").close();
    });

    simpleWindow.find("#someData").html(options.showData);

    simpleWindow.data("kendoWindow").center().open();

    function getTemplate() {
        return '<div id="someData" class="simple-window-content"></div>'
            + ' <hr class="modal-hr"/>'
            + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <button type="button" class="k-button" id="btnCopyErroText" title="Копіювати текст помилки в буфер обміну"><i class="pf-icon pf-16 pf-gears"></i> Копіювати</button>'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span>Закрити</a>'
            + '     </div>'
            + ' </div>';
    };
};