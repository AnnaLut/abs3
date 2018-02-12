// input object have to containe next properties : 
//  options.payroll_num  
//  options.nmk          juridical person name
//  options.id           payroll id
function printPayroll(options) {
    var ppWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: 'Друк відомості № <b>' + options.payroll_num + '</b>',
        resizable: false,
        modal: true,
        draggable: true,
        width: "320px",
        refresh: function () {
            this.center();
        },
        animation: getAnimationForKWindow({ animationType: { open: 'left', close: 'right' } }),
        deactivate: function () {
            this.destroy();
        },
        activate: function () {
            ppWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);
    ppWindow.data("kendoWindow").content(template({}));

    ppWindow.find("#btnCancel").click(function () {
        ppWindow.data("kendoWindow").close();
    });

    ppWindow.find("#btnSave").click(function () {
        var template = 'vidomist.frx';
        var ddl = ppWindow.find('#payrollFileFormat').data('kendoDropDownList');
        var index = ddl.select();
        var formatDataItem = ddl.dataItem(index);
        var fileName = options.nmk + ' Відомість № ' + options.payroll_num + formatDataItem.extension;


        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/SalaryBag/SalaryBag/ReportExport"),
            data: {
                template: template,
                fileName: encodeURIComponent(fileName),
                type: formatDataItem.value,
                payRollId: options.id
            },
            success: function (response, status, request) {
                if (response.Result == "OK") {
                    DownloadFileFromBase64(response.ResultMsg, fileName);
                } else {
                    showBarsErrorAlert(response.ResultMsg);
                }
            }
        });

        bars.ui.notify('Формування файлу розпочато.', 'Завантаження розпочнеться автоматично.', 'info', {
            autoHideAfter: 2.5 * 1000,
            width: "350px"
        });

        ppWindow.data("kendoWindow").close();
    });

    ppWindow.find("#payrollFileFormat").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        height: "auto",
        template: '<span style="font-size:12px;">#:data.text#</span>',
        valueTemplate: '<span style="font-size:12px;">#:data.text#</span>',
        dataSource: [
            { text: "Excel", value: 2, extension: ".xlsx" },
            { text: "Pdf", value: 7, extension: ".pdf" },
            { text: "Word", value: 11, extension: ".docx" }
        ],
        value: 7
    });

    ppWindow.data("kendoWindow").center().open();

    function getTemplate() {
        return '<table>'
            + '	    <tbody>'
            + '	    	<tr>'
            + '	    		<td style="padding-right:5px;"><label class="k-lable"> Оберіть тип файлу </label></td>'
            + '	    		<td><input id="payrollFileFormat" /></td>'
            + '	    	</tr>'
            + '	    </tbody>'
            + ' </table>'
            + ' <hr class="modal-hr"/>'
            + templateButtons();
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="9"><span class="k-icon k-cancel"></span> Відмінити</a>'
            + '         <a id="btnSave" class="k-button k-button-icontext k-primary k-grid-update modal-buttons" tabindex="8"><span class="k-icon k-update"></span> Ок</a>'
            + '     </div>'
            + ' </div>';
    };
};

