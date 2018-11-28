var EXP_IDS = [];
var download_url = '/barsroot/bills/bills/DownloadReport/';

// получаем результат необходимости поставить галочку в чекбокс
function onRefresh(id, bill_no) {
    var data = { };
    data.EXP_ID = id;
    data.BILL_NO = bill_no;
    if (EXP_IDS.length > 0 && getIndex(data) > -1)
        return "checked='checked'";
    return '';
}

// событие наполнения/обновления данных грида
function dataBound(e) {
    $(".chk-bills").change(function () {
        var grid = $('#confirmbills').data().kendoGrid;
        var dataItem = grid.dataItem($(this).closest('tr'));
        var data = {};
        data.EXP_ID = dataItem.EXP_ID;
        data.BILL_NO = dataItem.BILL_NO;
        data.SUMM = +dataItem.AMOUNT;
        var totalSumm = +parseFloat($('#summ').html()).toFixed(2);
        if (this.checked) {
            if (getIndex(data) === -1) {
                EXP_IDS.push(data);
                totalSumm += data.SUMM; 
            }
        }
        else {
            var index = getIndex(data);
            if (index > -1) {
                EXP_IDS.splice(index, 1);
                totalSumm -= data.SUMM;
            }
        }
        $("#summ").html(parseFloat(totalSumm).toFixed(2));
        $('#count').html(EXP_IDS.length);
    });
}

// получение индекса выбранного элемента
function getIndex(data) {
    var index = -1;
    for (var i = 0; i < EXP_IDS.length; ++i) {
        if (EXP_IDS[i].EXP_ID === data.EXP_ID && EXP_IDS[i].BILL_NO === data.BILL_NO)
            index = i;
    }
    return index;
}

// подтверждение получения векселей
function confirmBills() {
    if (EXP_IDS.length > 0) {
        var summ = 0;
        for (var i = 0; i < EXP_IDS.length; ++i)
            summ += EXP_IDS[i].SUMM;

        bars.ui.confirm({
            title: 'У В А Г А!',
            text: 'Ви впевнені що бажаєте отримати векселі за цими рішеннями (' + EXP_IDS.length + ' шт. на суму ' + parseFloat(summ).toFixed(2) + ' грн.)?'
        }, function () {
            var url = '/barsroot/api/bills/bills/confirmbills';
            sendPost(url, EXP_IDS);
            EXP_IDS = [];
            $('#count').html('0');
            $('#summ').html('0.00');
        });
    }
    else {
        bars.ui.alert({
            title: 'Увага!',
            text: 'Жодного рішення не було вибрано!'
        });
    }
}

// Загрузка актов
function getact(name) {
    var url = download_url + '0' + '?reportType=' + name;
    var win = window.open(url, '_blank');
    win.focus();
}

// получение списка векселей (регион)
function refreshBills() {
    var url = '/barsroot/api/bills/bills/BillsRequest?method=GetBills&str=&id=0';
    sendPost(url, null);
}

// получение списка векселей (ЦА)
function refresh() {
    var url = '/barsroot/api/bills/bills/BillsRequest?method=GetBillsFromCA&str=&id=0';
    sendPost(url, null);
}

// стандартный метод отправки запросов методом POST
function sendPost(url, data) {
    $("<div class='k-overlay'></div>").appendTo($(document.body));
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: url,
        data: JSON.stringify(data),
        success: function (result) {
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!',
                    close: function (e) {
                        $(".k-overlay").remove();
                        $('#confirmbills').data('kendoGrid').dataSource.read();
                        $('#confirmbills').data('kendoGrid').refresh();
                    }
                });
            }
            else {
                bars.ui.error({
                    text: result.err,
                    close: function (e) {
                        $(".k-overlay").remove();
                        $('#confirmbills').data('kendoGrid').dataSource.read();
                        $('#confirmbills').data('kendoGrid').refresh();
                    }
                });
            }
        },
        error: function (result) {
            $(".k-overlay").remove();
            $('#confirmbills').data('kendoGrid').dataSource.read();
            $('#confirmbills').data('kendoGrid').refresh();
        }
    });
}