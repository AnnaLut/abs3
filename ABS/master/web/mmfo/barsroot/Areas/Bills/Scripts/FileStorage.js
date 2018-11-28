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
    //buildAndSendObj.onButtonClickEvent(hideButtons, function (rows) {
    //    var nodes = rows[0].childNodes;
    //});
}

// обработка события заполнения/обносления данных в гриде
function DataBound(event) {
    //var grid = $("#documents").data("kendoGrid");
    $('#documents table tr').dblclick(openPdfPreview);
}

// удаление документа
function removeDocument() {
    var ID = buildAndSendObj.getDocumentId();
    
    if (ID !== 'undefined') {
        var name = buildAndSendObj.getSelectedRows()[0].childNodes[3].innerHTML;
        bars.ui.confirm({
            title: 'У В А Г А!',
            text: 'Видалити файл \'' + name + '\'?'
        }, function () {
            buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/RemoveStorageFile/' + ID, null, defaultSuccessFuncOnRequest);
        });
    }
    else
        noRowsSelected();
}

// сканирование нового документа (не заявления на погашение задолжности)
function ScannNew() {
    var url = '/bills/bills/FileStorageScann';
    buildAndSendObj.popUp(url,'Сканування файлів', '350px', '550px');
    //showScannDialog(url, defaultSuccessFuncOnRequest, buildAndSendObj);
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
                $(this.element).empty();
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
            cache: false,
            success: successFunc,
            error: function (result) {
                $(".k-overlay").remove();
                buildAndSendObj.refreshGrid();
            }
        });
    };

    // обработка события нажатия на кнопку
    // показ затемняющего окна
    this.ShowOverlay = function () {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
    };

    // скрытие затемняющего окна
    this.HideOverlay = function () {
        $(".k-overlay").remove();
    };
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
}

// отображение файла
function openPdfPreview() {
    var ID = buildAndSendObj.getDocumentId();
    openPreview(ID);
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
    buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/EditStorageFile', JSON.stringify(arr), defaultSuccessFuncOnRequest);
}

// добавление комминтариев
function AddDescription(type) {
    var ID = buildAndSendObj.getDocumentId();
    if (ID === 'undefined') {
        noRowsSelected();
        return;
    }
    var grid = $('#documents').data('kendoGrid');
    var selected = grid.select();
    if (selected[0] !== undefined && selected[0] !== null) {

        var tr = type === 'description' ? $(selected[0].cells[4]) : $(selected[0].cells[3]);
        if (tr !== undefined && tr !== null)
            tr.click();
    }
    else
        noRowsSelected();
}

// открытие окна для сохранения файла
function attachDocument() {
    buildAndSendObj.popUp('/bills/bills/AttachStorageFile', 'Збереження файлів', '350px', '550px');
}

// Формирование кнопки для загрузки 
function previewButton(id) {
    return '<button class="k-button open-pdf" title="Переглянути файл" onclick="openPreview(' + id + '); return false;"><span class="glyphicon glyphicon-download-alt"></span></button>';
}

// отображение файла
function openPreview(id) {
    var url = '/barsroot/bills/bills/GerStorageFile/' + id;
    buildAndSendObj.downloadPdf(url);
}

// открытие окна для создания отчетов
function generateReport() {
    buildAndSendObj.popUp('/bills/report/reports', 'Створення звітів', '500px', '600px');
}

// Отправка отчета в ДКСУ
function sendReport() {
    var grid = $('#documents').data('kendoGrid');
    var selected = grid.select();
    if (selected[0] !== undefined && selected[0] !== null) {
        bars.ui.error({
            title: 'ПОМИЛКА',
            text: 'Сервіс для прийому звітів в ДКСУ не налаштовано, звіт не буде надіслано!'
        });
    }
    else
        noRowsSelected();
}
