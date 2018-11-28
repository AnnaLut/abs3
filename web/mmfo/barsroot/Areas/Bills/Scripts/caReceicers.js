var buildAndSendObj = {};

(function () {
    buildAndSendObj = new rowObject();
})();

// событие обновления
function onRefresh(id) { }

// Получение текстового значения типа личности
function SetUser(cl_type) {
    if (cl_type === 1)
        return "ФО";
    else if (cl_type === 2)
        return "ЮО";
}

// событие изменения
function onChange(e) { }

// формирование выдержки
function sendReceivers() {
    var text = 'Буде сформование витяг з ' + count + ' рішень.';
    bars.ui.confirm({
        title: 'У В А Г А!',
        text: text
    }, function () {
        var url = '/barsroot/api//bills/bills/BillsRequest?method=SendCAReceivers&str=&id=0';
        buildAndSendObj.SendPostJson(url, null, function (result) {
            $(".k-overlay").remove();
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        buildAndSendObj.refreshGrid();
                    }
                });
            }
            else {
                bars.ui.error({
                    text: result.err
                });
            }
            buildAndSendObj.refreshGrid();
        });
    });    
}

// Отправка взыскателя в ДКСУ для отбракования
function Revoke() {
    var grid = $('#careceivers').data('kendoGrid');
    var selected = grid.select();
    if (selected.length > 0) {
        var Id = selected[0].childNodes[1].innerHTML;
        var url = '/barsroot/api//bills/bills/BillsRequest?method=revokerequest&str=&id=' + Id;
        buildAndSendObj.SendPostJson(url, null, function (result) {
            $(".k-overlay").remove();
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        buildAndSendObj.refreshGrid();
                    }
                });
            }
            else {
                bars.ui.error({
                    text: result.err
                });
            }
            buildAndSendObj.refreshGrid();
        });
    }
    else {
        bars.ui.alert({
            text: 'Жодної строки не було вибрано',
            title: 'Увага!'
        });
    }
}

// Предварительный просмотр выдержки (PDF)
function preView() {
    $("<div class='k-overlay'></div>").appendTo($(document.body));
    var win = window.open('/barsroot/bills/bills/ExtractPreView');
    win.focus();
    $(".k-overlay").remove();
    //buildAndSendObj.refreshGrid();
}

// набор стандартных методов
function rowObject() {
    // обновление данных грида
    this.refreshGrid = function () {
        $('#careceivers').data('kendoGrid').dataSource.read();
        $('#careceivers').data('kendoGrid').refresh();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: '/barsroot/api/bills/bills/GetCAReceiversCount',
            success: function (result) {
                count = result;
            },
            error: function (err) { }
        });
    };
    // отправка запроса методом POST
    this.SendPostJson = function (url, data, successFunc) {

        $("<div class='k-overlay'></div>").appendTo($(document.body));
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: JSON.stringify(data),
            success: successFunc,
            beforeSend: function () {
                if (setTimeout) {
                    setTimeout(function () {
                        $("<div class='k-overlay'></div>").appendTo($(document.body));
                    }, 500);
                }
            },
            error: function (result) {
                $(".k-overlay").remove();
                buildAndSendObj.refreshGrid();
            }
        });
    };
}
