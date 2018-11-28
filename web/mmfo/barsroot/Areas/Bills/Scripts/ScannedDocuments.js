var buildAndSendObj = {}; // объект для работы со стандартными методами

(function () {
    buildAndSendObj = new rowObject();
    // отлавливание события нажатия на кнопку (отлавливаем нажатие кнопки Esc для закрытия окна)
    $(document).keyup(function (e) {
        if (e.keyCode === 27 && e.target.id !== 'createWindow' && e.target.id !== 'barsUiConfirmDialog' && e.target.id !== 'barsUiErrorDialog' && e.target.id !== 'barsUiAlertDialog') {
            window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
        }
    });

})();

// при выделении строки
function Selected(event) {
    buildAndSendObj.onButtonClickEvent(hideButtons, function (rows) {
        var nodes = rows[0].childNodes;
        var typeCode = nodes[3].innerHTML;
        var status = nodes[4].innerHTML;
        buildAndSendObj.showHideButtons(true, ['#open-file']);
        if (typeCode !== 'Application')
            buildAndSendObj.showHideButtons(true, ['#remove']);
        else
            buildAndSendObj.showHideButtons(false, ['#remove']);
    });
}

// обработка события заполнения/обносления данных в гриде
function DataBound(event) {
    var status = $('#STATUS').val();   
    var grid = $("#documents").data("kendoGrid");
    var count = 0;
    if (grid.tbody[0].childElementCount)
        count = grid.tbody[0].childElementCount;
    else
        count = grid.tbody[0].children.length;
    if (count > 0)
        buildAndSendObj.showHideButtons(true, ['#update-application', '#scann-app']);
    buildAndSendObj.showHideButtons(status !== 'XX', ['#send-files', '#update-application', '#scann-app', '#attach-application', '#scann-new']);

    $('#documents table tr').dblclick(openPdfPreview);
}

// удаление документа
function removeDocument() {
    var ID = buildAndSendObj.getDocumentId();
    if (ID !== 'undefined')
        buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/BillsRequest?method=DeleteScannDoc&str=&id=0' + ID, null, defaultSuccessFuncOnRequest);
    else
        noRowsSelected();
}

// обновление заявления на погашение задолжности
function UpdateApplication() {
    buildAndSendObj.onButtonClickEvent(hideButtons, function (rows) {
        var ID = buildAndSendObj.getExpectedId();
        $("<div class='k-overlay'></div>").appendTo($(document.body));
        buildAndSendObj.downloadPdf('/barsroot/bills/bills/printbillrequest/' + ID);
        buildAndSendObj.refreshGrid();
        buildAndSendObj.HideOverlay();
    });
}

// отправка файлов в ДКСУ
function sendFiles() {
    var url = '/barsroot/api/bills/bills/BillsRequest?method=AttachApplication&str=&id=0' + buildAndSendObj.getExpectedId();
    buildAndSendObj.SendPostRequest(url, null, function (result) {
        if (result.status === 1) {
            bars.ui.alert({
                text: 'Виконано успішно!',
                close: function (e) {
                    window.parent.$('#createWindow').closest(".k-window-content").data("kendoWindow").close();
                }
            });
        }
        else {
            bars.ui.error({
                text: result.err
            });
        }
        $(".k-overlay").remove();
    });
}

// сканирование нового документа (не заявления на погашение задолжности)
function ScannNew() {
    var ID = buildAndSendObj.getExpectedId();
    var url = '/barsroot/api/bills/bills/UploadScannedDocument?id=' + ID + '&docType=Other';
    showScannDialog(url, defaultSuccessFuncOnRequest, buildAndSendObj);
}

// набор стандартных методов
function rowObject() {
    // открытие всплывающего окна
    this.popUp = function (url, title, height, width) {
        $("#windowContainer").append("<div id='createWindow'></div>");
        if (width === undefined)
            width = "800px";
        if (height === undefined)
            height = '450px';
        var createWindow = $("#createWindow").kendoWindow({
            width: width,
            height: height,
            title: title,
            visible: false,
            actions: ["Close"],
            iframe: true,
            modal: true,
            resizable: false,
            deactivate: function () {
                this.destroy();
                buildAndSendObj.refreshGrid();
            },
            content: bars.config.urlContent(url)
        }).data("kendoWindow");

        createWindow.center().open();
    };

    // получение списка выделенных строк
    this.getSelectedRows = function () {
        var grid = $('#documents').data('kendoGrid');
        return grid.select();
    };

    // получение ИД выделенного документа
    this.getDocumentId = function () {
        var rows = this.getSelectedRows();
        if (rows.length > 0)
            return rows[0].childNodes[0].innerHTML;
        else
            return 'undefined';
    };

    // получение ИД взыскателя
    this.getExpectedId = function () {
        return $('#Exp-ID').val();
    };

    // обновление данных грида
    this.refreshGrid = function () {
        $('#documents').data('kendoGrid').dataSource.read();
        $('#documents').data('kendoGrid').refresh();
    };

    // загрузка и открытие pdf в новом окне
    this.downloadPdf = function (url) {
        var win = window.open(url);
        win.focus();
        this.HideOverlay();
    };

    // отправка запроса методом POST
    this.SendPostRequest = function (url, data, successFunc) {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: data,
            success: successFunc,
            error: function (result) {
                $(".k-overlay").remove();
                buildAndSendObj.refreshGrid();
            }
        });
    };

    // обработка события нажатия на кнопку
    this.onButtonClickEvent = function (hideButtonsFunc, successFunc) {
        var rows = this.getSelectedRows();
        if (rows.length > 0)
            successFunc(rows);
        else {
            hideButtonsFunc(false);
            bars.ui.alert({
                text: 'Жодної строки не було вибрано',
                title: 'Увага!'
            });
        }
    };

    // блокировка/разблокировка кнопок
    this.showHideButtons = function (show, arr) {
        for (var i = 0; i < arr.length; ++i) {
            if (show) {
                $(arr[i]).prop('disabled', false);
                $(arr[i]).css('background-color', 'transparent');
            }
            else {
                $(arr[i]).prop('disabled', true);
                $(arr[i]).css('background-color', 'lightgray');
            }
        }
    };

    // показ затемняющего окна
    this.ShowOverlay = function () {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
    };

    // скрытие затемняющего окна
    this.HideOverlay = function () {
        $(".k-overlay").remove();
    };
}

// блокировка/разблокировка кнопок
function hideButtons(show) {
    var btnList = ['#remove', '#update-application', 'open-file'];
    buildAndSendObj.showHideButtons(show, btnList);
}

// сканирование документа заявления на погашение задолжности
function AppScann() {
    var ID = buildAndSendObj.getExpectedId();
    var url = '/barsroot/api/bills/bills/UploadScannedDocument?id=' + ID + '&docType=AppScan';
    showScannDialog(url, defaultSuccessFuncOnRequest, buildAndSendObj);
}

// стандартный метод обработки запросов
function defaultSuccessFuncOnRequest(result) {
    if (result.status === 1) {
        bars.ui.alert({
            text: 'Виконано успішно!',
            close: function (e) {
            }
        });
    }
    else {
        bars.ui.error({
            text: result.err
        });
    }
    $(".k-overlay").remove();
    buildAndSendObj.refreshGrid();
}

// отображение уведомления о не выделенной строке
function noRowsSelected() {
    bars.ui.alert({
        text: 'Жодної строки не було вибрано',
        title: 'Увага!'
    });
    buildAndSendObj.showHideButtons(false, ['#remove']);
}

// отображение файла
function openPdfPreview() {
    buildAndSendObj.onButtonClickEvent(hideButtons, function (rows) {
        var ID = buildAndSendObj.getDocumentId();
        var url = '/barsroot/bills/bills/DownloadPdf/' + ID;
        buildAndSendObj.downloadPdf(url);
    });
}

// сохранение комминтариев
function saveUpdates() {
    var data = $('#documents').data('kendoGrid').dataSource.data();
    var arr = [];
    for (var i = 0; i < data.length; ++i) {
        if (data[i].dirty)
            arr.push(data[i]);
    }
    if (arr.length === 0) {
        bars.ui.alert({
            title: 'Увага!',
            text: 'Жоден коментар до документу не був змінений!'
        });
        return false;
    }
    buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/editdocument', JSON.stringify(arr), defaultSuccessFuncOnRequest);
}

// добавление комминтариев
function AddDescription() {    
    var ID = buildAndSendObj.getDocumentId();
    if (ID === 'undefined') {
        noRowsSelected();
        return;
    }
    var grid = $('#documents').data('kendoGrid');
    var selected = grid.select();
    if (selected[0] !== undefined && selected[0] !== null) {
        var tr = $(selected[0].cells[8]);
        if (tr !== undefined && tr !== null)
            tr.click();
    }
    else
        noRowsSelected();
}

// открытие окна для сохранения файла
function attachDocument() {
    var exp_id = $('#Exp-ID').val();
    buildAndSendObj.popUp('/bills/bills/attachPdf/' + exp_id, 'Збереження файлів', '300px', '600px');
}