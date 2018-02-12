function beforeScanForm(selectedItem) {
    var beforeScanWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Завантаження файлів в ЕА',
        resizable: false,
        modal: true,
        draggable: true,
        //width: "350px",
        width: "600px",
        refresh: function() {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function() {
            this.destroy();
        },
        activate: function() {
            beforeScanWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);
    beforeScanWindow.data("kendoWindow").content(template({}));

    beforeScanWindow.find("#btnCancel").click(function() {
        beforeScanWindow.data("kendoWindow").close();
    });

    beforeScanWindow.find('.custom-btn-ea-scan').click(function() {
        if (isIE() == false) {
            bars.ui.alert({ text: 'Дана функція підтримується лише у браузері <b>"Internet Explorer"</b>' });
            return;
        }

        var DialogOptions = 'dialogHeight:700px; dialogWidth:900px; scroll: no';

        var sc = beforeScanWindow.find('#struct_codes').data('kendoDropDownList').value() || 0;

        var result = window.showModalDialog('/barsroot/SalaryScaner/salary_scaner.aspx?'
            + 'sid=' + GUID()
            + '&zpId=' + selectedItem.id
            + '&imageHeight=500'
            + '&ImageWidth=700'
            + '&rnd=' + Math.random()
            + '&structCode=' + sc
            + '&rnk=' + selectedItem.rnk,
            window, DialogOptions);
    });

    beforeScanWindow.data("kendoWindow").center().open();

    initFileUploader();

    beforeScanWindow.find("#struct_codes").kendoDropDownList({
        filter: "contains",
        height: 300,
        dataTextField: "name",
        dataValueField: "id",
        template: '<span style="font-size:12px;white-space:pre-wrap;"><b>#: data.id #</b>  #: data.name #</span>',
        valueTemplate: '<span class="ddl-span" style="font-size:12px;"><b>#: data.id #</b>  #: data.name #</span>',
        dataSource: {
            type: "json",
            transport: {
                read: bars.config.urlContent("/api/SalaryBag/SalaryBag/GetStructCodes")
            }
        }
    });

    function getTemplate() {
        return '<label for="struct_codes" class="k-label lbl-padding">Тип документу</label><br />'
            + ' <input style="width:100% !important;" id="struct_codes">'

            + ' <hr class="modal-hr"/>'

            + ' <div class="inlineBlock" style="margin-top:0px;padding-top:0px;">'
            + '     <div id="fileUploaderDiv" class="inlineBlock" style="margin-left:0px !important;">'
            + '         <input name="testFile" id="import_file_selector" type="file" title="Завантажити говтоий .pdf файл" accept=".pdf" />'
            + '     </div>'
            + '     <div class="inlineBlock" style="width:185px;"></div>'
            + ' </div>'

            + ' <a class="btn custom-btn custom-btn-ea-scan" title="Сканування документів та збереження їх у ЕА">Сканувати</a>'

            + ' <hr class="modal-hr"/>'
            + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="9"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '     </div>'
            + ' </div>';
    };

    function initFileUploader() {
        var kUpload = beforeScanWindow.find("#import_file_selector").kendoUpload({
            multiple: false,
            localization: {
                select: 'Завантажити .pdf файл'
            },
            async: {
                saveUrl: bars.config.urlContent("/api/SalaryBag/SalaryBag/RecieveFileForEa")
            },
            showFileList: false,
            select: function(e) {
                var file = e.files[0];
                if (file == null || file === undefined) {
                    e.preventDefault();
                    return;
                }

                var extension = '.pdf';
                if (file.extension.toLowerCase() != extension) {
                    bars.ui.error({ text: "Некоректний файл!<br />Потрібно вибрати .pdf-файл." });
                    e.preventDefault();
                    return;
                }
            },
            upload: function(e) {
                bars.ui.loader(beforeScanWindow, true);
                e.data = {
                    pId: selectedItem.id,
                    structCode: beforeScanWindow.find('#struct_codes').data('kendoDropDownList').value(),
                    rnk: selectedItem.rnk
                };
            },
            success: function(e) {
                bars.ui.loader(beforeScanWindow, false);
                if (e.response.Result != "OK") {
                    bars.ui.error({ text: "При завантаженні файлу відбулась помилка :<br/>" + e.response.ErrorMsg });
                } else {
                    bars.ui.alert({ text: "Файл успішно завантажено<br />Та поставлено в чергу на відправку в ЕА." });
                }
            },
            error: function(e) {
                bars.ui.loader(beforeScanWindow, false);
            },
            dropZone: false
        });

        var myNav = navigator.userAgent.toLowerCase();
        var browser = (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;

        if (+browser === 8) {
            beforeScanWindow.find('#fileUploaderDiv > div > div').removeClass('k-button').addClass('btn').addClass('custom-btn').addClass('custom-btn-import-add-file');
        } else {
            beforeScanWindow.find('#fileUploaderDiv > div > div > div').removeClass('k-button').addClass('btn').addClass('custom-btn').addClass('custom-btn-import-add-file');
        }
        beforeScanWindow.find('#fileUploaderDiv > div').removeClass('k-header').removeClass('k-upload').removeClass('k-widget');
        beforeScanWindow.find('#fileUploaderDiv > div > div > em').remove();
    };
};

