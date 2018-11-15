function showViewEADocsForm(selectedItem) {

    var viewDocsWindow = $('<div id="viewEaDocsWindow"/>').kendoWindow({
        actions: ["Close"],
        title: 'Перегляд документів',
        resizable: false,
        modal: true,
        draggable: true,
        refresh: function () {
            this.center();
        },
        width: "60%",
        height: "60%",
        deactivate: function () {
            bars.ui.loader('body', false);
            this.destroy();
        },
        activate: function () {
            viewDocsWindow.data("kendoWindow").refresh();
        }
    });

    var totalTemplate = getTemplate();
    var template = kendo.template(totalTemplate);

    viewDocsWindow.data("kendoWindow").content(template({}));

    viewDocsWindow.find("#btnCancel").click(function () {
        viewDocsWindow.data("kendoWindow").close();
    }).end();

    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/Way4Bpk/Way4Bpk/GetDocumentsFromEA?rnk=" + selectedItem.rnk),
        success: function (data) {
            bars.ui.loader('body', false);

            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
                viewDocsWindow.data("kendoWindow").close();
            } else {
                var tBody = viewDocsWindow.find('#eaViewTable_body');
                var separator = '<tr><td colspan="2"><hr style="margin:2px;"/></td><td></td></tr>';

                if (data.ResultObj.length > 0) {
                    for (var i = 0; i < data.ResultObj.length; i++) {
                        //if (data.ResultObj[i].doc_link != null && data.ResultObj[i].doc_link != undefined && data.ResultObj[i].doc_link != '') {
                        var linkTemplate = '<tr>'
                            + '                 <td>'
                            + '                     <a class="k-button" title="Переглянути документ &#013;&#8220;' + data.ResultObj[i].struct_name + '&#8221;" target="_blank" href="' + data.ResultObj[i].doc_link
                            + '"><i class="pf-icon pf-16 pf-info"></i></a>   '
                            + '                 </td >'
                            + '                 <td>'
                            + '                     Код: <b>' + data.ResultObj[i].struct_code + '</b> Назва: <b>&#8220;' + data.ResultObj[i].struct_name + '&#8221;</b>'
                            + '                 </td>'
                            + '             </tr>';
                        tBody.append(linkTemplate + separator);
                        tBody.find('#noRecordsTr').remove();
                        ////<a class="k-button" onclick="onClickBtn(this)" title="Додаткова картка школяра" id="btnSchoolboy" ><i class="pf-icon pf-16 pf-link-info"></i></a>
                    }
                    tBody.find('hr:last').remove();

                    viewDocsWindow.data("kendoWindow").center().open();
                } else {
                    bars.ui.alert({ text: 'По даному договору документів не знайдено.' });
                }
            }
        },
        error: function (jqXHR, exception) {
            bars.ui.loader('body', false);
        }
    });


    function getTemplate() {
        return headerTmp() + templateButtons();
    };

    function headerTmp() {
        return '<h1 class="eaViewTitle">Документи в ЕА</h1>'
            + ' <div class="eaViewFormContainer" style="overflow: auto;height:80%;">'
            + '     <table id="eaViewTable">'
            + '         <tbody id="eaViewTable_body">'
            + '             <tr id="noRecordsTr"><td style="width:100%;text-align:center;font-size:18px;">Документів не знайдено !</td></tr>'
            + '         </tbody>'
            + '     </table>'
            + ' </div>';
    };

    function templateButtons() {
        return '<div class="row" style="margin:5px 5px 5px 5px;">'
            + '     <div class="k-edit-buttons k-state-default">'
            + '         <a id="btnCancel" class="k-button k-button-icontext k-grid-cancel modal-buttons" tabindex="3"><span class="k-icon k-cancel"></span> Закрити</a>'
            + '     </div>'
            + ' </div>';
    };
};

function showBarsErrorAlert(message, func) {
    func = func || function () { };
    bars.ui.error(
        {
            text: message.replace("ы", "і"),
            deactivate: func
        });
};