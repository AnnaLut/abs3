function showDocsCreationForm(selectedItem) {
    var extCookieName = "SalaryBagDocumentExtension";
    var totalFreeSpace = 0;
    var fileTypeId = 7;

    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Формування документів по договору №<b>' + selectedItem.deal_id + '</b>',
        resizable: false,
        width: '750px',
        modal: true,
        draggable: true,
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'down', close: 'up' } }),
        deactivate: function () {
            createCookie(extCookieName, fileTypeId, 30);
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

    //kendoWindow.find(".custom-btn-report-show").click(function () {
    //    kendoWindow.find("#_report").empty();
    //    bars.ui.loader('#_report', true);

    //    var ddl = kendoWindow.find('#docTemplate').data('kendoDropDownList');
    //    var index = ddl.select();
    //    var docDataItem = ddl.dataItem(index);

    //    var dates = getDates();

    //    $.ajax({
    //        type: "GET",
    //        url: bars.config.urlContent("/api/SalaryBag/SalaryBag/ReportHtml"),
    //        data: {
    //            template: docDataItem.value,
    //            rnk: selectedItem.rnk,
    //            dateFrom: dates.dateFrom,
    //            dateTo: dates.dateTo
    //        },
    //        success: function (data) {
    //            bars.ui.loader('#_report', false);

    //            var someCount = data.ResultMsg.split('<td').length - 1;
    //            if (someCount > 1) {
    //                kendoWindow.find("#_report").append(data.ResultMsg);
    //                var contentLen = $("#_report").find("table:first").width();
    //                var lrSpace = (totalFreeSpace - contentLen) * docDataItem.multiplier;
    //                $("#_report").css("padding-left", lrSpace);
    //            } else {
    //                kendoWindow.find("#_report").append('<br/><h1><u> Дані відсутні. </u></h1>');
    //                $("#_report").css("padding-left", "0px");
    //            }
    //        },
    //        error: function (jqXHR, exception) {
    //            bars.ui.loader('#_report', false);
    //        }
    //    });
    //}).end();

    //kendoWindow.find(".custom-btn-report-download").click(function () {
    kendoWindow.find("#btnSave").click(function () {
        var template = kendoWindow.find("#docTemplate").data("kendoDropDownList").value();
        var ddl = kendoWindow.find('#fileFormat').data('kendoDropDownList');
        var index = ddl.select();
        var formatDataItem = ddl.dataItem(index);
        var dates = getDates();
        //FILE NAME !!!

        var fileName = selectedItem.deal_id + '_' + template.split('.')[0] + formatDataItem.extension;

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/SalaryBag/SalaryBag/ReportExport"),
            data: {
                template: template,
                rnk: selectedItem.rnk,
                fileName: encodeURIComponent(fileName),
                type: fileTypeId,
                dateFrom: dates.dateFrom,
                dateTo: dates.dateTo
            },
            success: function (response, status, request) {
                if (response.Result == "OK") {
                    DownloadFileFromBase64(response.ResultMsg, fileName);
                    kendoWindow.data("kendoWindow").close();
                } else {
                    showBarsErrorAlert(response.ResultMsg);
                }
            }
        });

        bars.ui.notify('Формування файлу розпочато.', 'Завантаження розпочнеться автоматично.', 'info', {
            autoHideAfter: 2.5 * 1000,
            width: "350px"
        });
    }).end();

    kendoWindow.find("#docTemplate").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        height: "auto",
        dataSource: [
            { text: "Договір між банком та організацією про надання послуг по ЗП", value: "DOG_ZP.frx", dates: false, multiplier: 0.45 },
            { text: "Додаток 7 до порядку обслуговування платіжних карток", value: "DOD7.frx", dates: false, multiplier: 0.45 },
            { text: "Додаток 8 до порядку обслуговування платіжних карток", value: "DOD8.frx", dates: false, multiplier: 0.45 },
            { text: "Рахунок на сплату банківських послуг за період", value: "rahunk1.frx", dates: true, multiplier: 0.45 },
            { text: "Рахунок загальний", value: "rahunok.frx", dates: false, multiplier: 0.45 },
            { text: "Акт виконаних робіт", value: "AKT1.frx", dates: true, multiplier: 0.45 }
        ],
        change: function () {
            var ddl = kendoWindow.find('#docTemplate').data('kendoDropDownList');
            var index = ddl.select();
            var formatDataItem = ddl.dataItem(index);

            if (formatDataItem.dates)
                kendoWindow.find("#datesFromTo").removeClass("invisible");
            else
                kendoWindow.find("#datesFromTo").addClass("invisible");

            kendoWindow.data("kendoWindow").refresh();
        }
    });

    kendoWindow.find("#fileFormat").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        height: "auto",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            //{ text: "Csv", value: 0, extension: ".csv" },
            { text: "Excel2007", value: 2, extension: ".xlsx" },
            //{ text: "Html", value: 3, extension: ".html" },
            { text: "Pdf", value: 7, extension: ".pdf" },
            { text: "Rtf", value: 9, extension: ".rtf" },
            //{ text: "Text", value: 10, extension: ".txt" },
            { text: "Word2007", value: 11, extension: ".docx" }
        ],
        value: +readCookie(extCookieName, fileTypeId),
        change: function () {
            fileTypeId = kendoWindow.find('#fileFormat').data('kendoDropDownList').value();
        }
    });

    kendoWindow.find("#dateFrom, #dateTo").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: new Date(),
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

    kendoWindow.data("kendoWindow").center().open();
    totalFreeSpace = $("#_report").width();

    function getDates() {
        var ddl = kendoWindow.find('#docTemplate').data('kendoDropDownList');
        var index = ddl.select();
        var formatDataItem = ddl.dataItem(index);

        var dateFrom = '';
        var dateTo = '';
        if (formatDataItem.dates) {
            dateFrom = kendoWindow.find("#dateFrom").val();
            dateTo = kendoWindow.find("#dateTo").val();
        }

        return {
            dateFrom: dateFrom,
            dateTo: dateTo
        }
    };

    function getTemplate() {
        return headerTmp() + templateButtons();
    };

    function headerTmp() {
        return '<div class="row" style="margin-left:3px;">'
            + '     <label for="docTemplate" class="k-label bold-lbl" style="margin-left:7px;width:70px;">Документ :</label>'
            + '     <input id="docTemplate" style="width:400px;">'
            + '     <label for="fileFormat" class="k-label bold-lbl" style="margin-left:7px;">Формат :</label>'
            + '     <input id="fileFormat">'
            + ' <br/>'
            + '     <div class="invisible" id="datesFromTo" style="width:100%;">'
            + '         <hr class="modal-hr"/>'
            + '         <label for="dateFrom" class="k-label bold-lbl" style="margin-left:7px;width:70px;">Дата З :</label>'
            + '         <input id="dateFrom">'
            + '         <label for="dateTo" class="k-label bold-lbl" style="margin-left:7px;">Дата По :</label>'
            + '         <input id="dateTo">'
            + '     </div>'
            + ' </div>'
            //+ ' <br/>'
            //+ ' <hr class="modal-hr"/>'
            //+ ' <div class="row" style="margin-left:3px;">'
            //+ '     <a class="btn custom-btn custom-btn-back modal-back" title="Повернутись назад до портфелю угод">Назад</a>'
            //+ '     <a class="btn custom-btn custom-btn-report-show">Сформувати документ</a>'
            //+ '     <a class="btn custom-btn custom-btn-report-download">Завантажити</a>'
            //+ ' </div>'
            //+ ' <hr class="modal-hr"/>'
            //+ ' <div id="_report"></div>'
            + ' <hr class="modal-hr"/>';
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="8"><span class="k-icon k-update"></span> Ок</a>'
            + '     </div>'
            + ' </div>';
    };
};