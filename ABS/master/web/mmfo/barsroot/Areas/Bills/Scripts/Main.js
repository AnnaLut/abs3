var buildAndSendObj = {}; // объект для работы с универсальными методами
var requestValues = { 'printBill': 'print' , 'updateBill': 'update' , 'getResolution': 'get' , 'setRecRecReq': 'req' };
var showOnlyBranch = false, firstLoad = true;
var currentBranch = '';
var signId = 0;
var signBaseUrl = '/barsroot/api/bills/bills/';

(function () {
    buildAndSendObj = new rowObject();
    $('#CL_TYPE').data("kendoDropDownList"); // приводим тег к контролу выпадающего списка
})();

// открытие окна для поиска взыскателя по дате и номеру решения
function SearchReceiver() {
    var url = "/bills/bills/search";
    buildAndSendObj.popUp(url, 'Пошук', "450px", '750px');
    return false;
}

// редактирование данных взыскателя по решению
function ShowEditReceiver() {
    var id = buildAndSendObj.getExpectedId(); // получаем ID взыскателя из выбранной строки
    if (id !== 'undefined')
        EditReceiver(id); // если взыскатель выбран - открываем окно
    else
        noRowsSelected(); // если строка не выбрана - выводим соответствующее сообщение
}

// отктытие окна для редактирования данных по взыскателю
function EditReceiver(id) {
    var url = '/bills/bills/EditReceiver/' + id;
    buildAndSendObj.popUp(url, 'Редагування', "90%", '80%');
    return false;
}

// регистрируем взыскателя в ДКСУ за банком (так же идет передача измененных данных в дксу) 
function createRequest() {
    buildAndSendObj.onButtonClickEvent(hideCreateRequestButton, function (rows) {
        var EXP_ID = rows[0].childNodes[3].innerHTML;
        var status = rows[0].childNodes[2].innerHTML;
        var statusRes = status === 'IN';
        hideCreateRequestButton(statusRes);
        if (statusRes) {
            checkRequiredFields(EXP_ID);
        }
    });
}

// Проверка обязательных полей
function checkRequiredFields(EXP_ID) {
    var selected = buildAndSendObj.getSelectedRows()[0];
    var inn = selected.childNodes[8].innerHTML;
    var acc = selected.childNodes[23].innerHTML;
    // Проверка на не пустое поле
    if (inn.length === 0) {
        bars.ui.error({
            text: 'Поле "ІПН/ЄДРПОУ" є обов\'язковим для заповнення'
        });
        return;
    }
    if (acc.length === 0) {
        bars.ui.error({
            text: 'Поле "Рахунок для перерахування" не заповнене'
        });
        return;
    }
    // отправка запроса для регистрации взыскателя за банком
    SendCreateRequest(EXP_ID, 'CreateRq');
}

// подпись измененных данных
function onSign() {
    $('.k-overlay').css('z-index', '10005');
    if (signId === null || signId === undefined || signId === 0) {
        hideButtonsFunc(false);
        bars.ui.alert({
            text: 'Жодної строки не було вибрано',
            title: 'Увага!'
        });
        return false;
    }
    var url = signBaseUrl + 'SaveCreateRequestSign';
    var iframe = $('#createWindow iframe')[0];
    var tokenIndex = $(iframe).contents().find('#ddSecDeviceType')[0].options.selectedIndex;
    var keyIndex = $(iframe).contents().find('#ddSecFiles')[0].options.selectedIndex;
    buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/getbuffer/' + signId, null, function (result) {
        if (result.buffer !== null && result.buffer !== undefined && result.buffer.length > 0) {
            var data = window.$sign.getSignData(tokenIndex, keyIndex, result.buffer, result.buffer);
            window.$sign.signer.Sign(data, function (item) {
                if (item.State === 'OK') {
                    var oper = JSON.parse(data).IdOper;
                    var obj = { EXP_ID: signId, SIGNATURE: item.Sign, SIGNER: oper };
                    buildAndSendObj.SendPostRequest(url, JSON.stringify(obj), function (result) {
                        $($('.k-window')[0]).fadeOut();
                        buildAndSendObj.HideOverlay();
                        if (result.status === 1) {
                            bars.ui.alert({
                                text: 'Виконано успішно!'
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
            });
        }
    });
}

// Выполнение операций с решением или получателем (в зависимости от передаваемого поля action)
function SendRequest(action) {
    buildAndSendObj.onButtonClickEvent(hideShowButtons, function (rows) {
        var EXP_ID = rows[0].childNodes[3].innerHTML;
        var status = rows[0].childNodes[2].innerHTML === "RQ" || rows[0].childNodes[2].innerHTML === 'RJ';
        if (status) {
            SendCreateRequest(EXP_ID, action);
        }
    });
}

// блокирование/разблокирование кнопок при выделении строки
function Selected() {
    buildAndSendObj.onButtonClickEvent(hideCreateRequestButton, function (rows) {
        var node = rows[0].childNodes[2];
        var status = node.innerHTML;
        hideCreateRequestButton(status === 'IN');
        hideShowButtons(status === 'RQ' || status === 'RJ');
        buildAndSendObj.showHideButtons(status === 'IN' || status === 'RQ', ['comments']);
        var applReady = rows[0].childNodes[4].innerHTML;
        buildAndSendObj.showHideButtons(applReady === '1' && status === 'RQ' || applReady === '1' && status === 'RJ', ['download-application']);
        buildAndSendObj.showHideButtons(status !== 'IN', ["upload-scan-doc", 'attach-application', 'scan-doc']);
    });
}

// Выполнение операций с решением или получателем (в зависимости от передаваемого поля action)
function SendCreateRequest(id, action) {
    $("<div class='k-overlay'></div>").appendTo($(document.body));

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: '/barsroot/api/bills/bills/BillsRequest?method=CreateRequest&str=' + action + '&id=' + id,
        success: function (result) {
            $('.k-overlay').css('z-index', '10002');
            if (result.status === 1) {
                bars.ui.alert({
                    text: 'Виконано успішно!'
                });
            }
            else {
                bars.ui.error({
                    text: result.err
                });
            }
            buildAndSendObj.refreshGrid();
        },
        error: function (result) {
            $(".k-overlay").remove();
            buildAndSendObj.refreshGrid();
        }
    });
}

// разблокировка/блокировка кнопок, в зависибости от события (изменение выделенного поля, смена статуса...)
function hideCreateRequestButton(show) {
    buildAndSendObj.showHideButtons(show, ['create-request-button']);
    var rows = buildAndSendObj.getSelectedRows();
    if (rows.length < 1)
        buildAndSendObj.showHideButtons(false, ['download-application', 'scan-doc', 'print-bill', 'update-bill', 'set-req-rec', 'upload-scan-doc', 'attach-application']);
}

// разблокировка/блокировка кнопок, в зависибости от события (изменение выделенного поля, смена статуса...)
function hideShowButtons(show) {
    var Ids = ['print-bill', 'update-bill', 'set-req-rec', 'attach-application'];
    buildAndSendObj.showHideButtons(show, Ids);

    var rows = buildAndSendObj.getSelectedRows();
    if (rows.length > 0) {
        var status = rows[0].childNodes[2].innerHTML;
        var applReady = rows[0].childNodes[4].innerHTML;
        buildAndSendObj.showHideButtons(applReady === '1' && status === 'RQ', ['download-application']);
        buildAndSendObj.showHideButtons(status !== 'IN', ["upload-scan-doc", 'scan-doc']);
    }
    else
        buildAndSendObj.showHideButtons(false, ['download-application', 'scan-doc', 'upload-scan-doc', 'attach-application']);
}

// зпгрузка файла заявления на погашение задолжности из ДКСУ (если value = printBill)
// в противном случае - отправка взыскателя в ЦА для формирования выдержки
function billRequest(value) {
    buildAndSendObj.onButtonClickEvent(hideShowButtons, function (rows) {
        var ID = rows[0].childNodes[3].innerHTML;
        $("<div class='k-overlay'></div>").appendTo($(document.body));
        if (value === 'printBill') {
            buildAndSendObj.downloadPdf('/barsroot/bills/bills/printbillrequest/' + ID);
            buildAndSendObj.refreshGrid();
            buildAndSendObj.HideOverlay();
            return false;
        }
        var url = '/barsroot/api/bills/bills/BillsRequest?method=' + value + '&str=&id=' + ID;
        bars.ui.confirm({
            title: 'У В А Г А!',
            text: 'Ви впевнені що бажаете змінити статус?   Після підтвердження будь які зміни будуть неможливі!!'
        }, function () {
            buildAndSendObj.SendPostRequest(url, null, defaultSuccessFuncOnRequest);
        });
    });
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
        var grid = $('#grid').data('kendoGrid');
        return grid.select();
    };

    // получение ИД взыскателя из выделенной строки
    this.getExpectedId = function () {
        var rows = this.getSelectedRows();
        if (rows.length > 0)
            return rows[0].childNodes[3].innerHTML;
        else
            return 'undefined';
    };

    // обновление данных грида
    this.refreshGrid = function () {
        $('#grid').data('kendoGrid').dataSource.read();
        $('#grid').data('kendoGrid').refresh();
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
                $('#' + arr[i]).prop('disabled', false);
                $('#' + arr[i]).css('background-color', 'transparent');
            }
            else {
                $('#' + arr[i]).prop('disabled', true);
                $('#' + arr[i]).css('background-color', 'lightgray');
            }
        }
    };

    // отправка запроса методом POST
    this.SendPostRequest = function (url, data, successFunc) {

        $("<div class='k-overlay'></div>").appendTo($(document.body));
        $.ajax({
            type: "POST",
            contentType: "application/json; charset='utf-8'",
            url: url,
            data: data,
            success: successFunc,
            error: function (result) {
                $(".k-overlay").remove();
                buildAndSendObj.refreshGrid();
            }
        });
    };

    // показ затемняющего окна
    this.ShowOverlay = function () {
        $("<div class='k-overlay'></div>").appendTo($(document.body));
    };

    // скрытие затемняющего окна
    this.HideOverlay = function () {
        $(".k-overlay").remove();
    };

    // загрузка и открытие файла pdf
    this.downloadPdf = function (url) {
        var win = window.open(url);
        win.focus();
        this.HideOverlay();
    };
}

// стандартный метод обработки запросов
function defaultSuccessFuncOnRequest(result) {
    if (result.status === 1) {
        bars.ui.alert({
            text: 'Виконано успішно!'
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

// открытие окна для сканирования файлов
function showDialogScanPhoto() {
    var ID = buildAndSendObj.getExpectedId();    
    if (ID !== 'undefined') {
        var url = '/barsroot/api/bills/bills/UploadScannedDocument?id=' + ID + '&docType=AppScan';
        showScannDialog(url, defaultSuccessFuncOnRequest, buildAndSendObj);
    }
    else
        noRowsSelected();
}

// загрузка сохраненного заявления на погашение
function downloadApplication() {
    Selected();
    var ID = buildAndSendObj.getExpectedId();
    if (ID !== 'undefined')
        buildAndSendObj.downloadPdf('/barsroot/bills/bills/DownloadApplication/' + ID);
    else
        noRowsSelected();
}

// открытие окна для редактирования, загрузки, сохраниния и отправки файлов в ДКСУ
function uploadScanDocs() {
    var ID = buildAndSendObj.getExpectedId();    
    if (ID !== 'undefined') {
        var rows = $('#grid').data('kendoGrid').select();
        var status = rows[0].childNodes[2].innerHTML;
        buildAndSendObj.popUp('/bills/bills/scanneddocuments/' + ID + '?status=' + status, 'Відправка сканкопій документів', '85%', '90%');
    }
    else
        noRowsSelected();
}

// событие успешной загрузки/обновления данных в гриде
function DataBound() {
    $('#grid table tr').dblclick(function () {
        var id = buildAndSendObj.getExpectedId();
        EditReceiver(id);
    });

    var grid = $("#grid").data("kendoGrid");
    var gridData = grid.dataSource.view();
    for (var i = 0; i < gridData.length; i++) {
        if (gridData[i].STATUS) {
            grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("row-color-" + gridData[i].STATUS);
        }
    }
    if (currentBranch === '' && gridData.length !== 0)
        currentBranch = gridData[0].USER_BRANCH;

    if (firstLoad) {
        if (currentBranch !== '/300465/') {
            ShowOnlyBranch();
        }
        else
            ShowAll();
        firstLoad = false;
    }
}

// тип клиента для отображения в гриде
function SetUser(cl_type) {
    if (cl_type === 1)
        return "ФО";
    else if (cl_type === 2)
        return "ЮО";
}

// мтандартный метод вывода сообщения об не выделенной строке
function noRowsSelected() {
    bars.ui.alert({
        text: 'Жодної строки не було вибрано',
        title: 'Увага!'
    });
    buildAndSendObj.showHideButtons(false, ['download-application', 'scan-doc', 'print-bill', 'update-bill', 'set-req-rec', 'upload-scan-doc', 'create-request-button', 'comments', 'attach-application']);
}

// удаление взыскателя
function removeReceiver() {
    var ID = buildAndSendObj.getExpectedId();    

    if (ID !== 'undefined') {
        var rows = buildAndSendObj.getSelectedRows();
        var name = rows[0].childNodes[6].innerHTML;
        var text = 'Ви впевнені що бажаете видалити отримувача (' + name + ') ';
        bars.ui.confirm({
            title: 'У В А Г А!',
            text: text + '?'
        }, function () {
            var url = '/barsroot/api/bills/bills/BillsRequest?method=deletereceiver&str=&id=' + ID;
            buildAndSendObj.SendPostRequest(url, null, defaultSuccessFuncOnRequest);
        });
    }
    else
        noRowsSelected();
}

// обновление статусов из дксу
function updateStatuses() {
    buildAndSendObj.SendPostRequest('/barsroot/api/bills/bills/BillsRequest?method=UpdateStatuses&str=&id=1', null, defaultSuccessFuncOnRequest);
}

// фильтр - показать все
function ShowAll() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").addClass('btn-default');
    $("#All").prop('disabled', true);
    $("#All").addClass('btn-primary');
    $("#All").addClass('selected');
    $("#Urgent > span").css('color', 'red');

    setFilters([], ["VH"], false); 
}

// фильтр - не подтвержденные
function ShowNotConfirmed() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#NotConfirmed").prop('disabled', true);
    $("#NotConfirmed").addClass('btn-primary');
    $("#NotConfirmed").addClass('selected');
    $("#Urgent > span").css('color', 'red');

    setFilters(["RQ"], [], false);
}

// фильтр - отбракованные
function ShowDismissed() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Dismissed").prop('disabled', true);
    $("#Dismissed").addClass('btn-primary');
    $("#Dismissed").addClass('selected');
    $("#Urgent > span").css('color', 'red');

    setFilters(["RJ"], [], false); 
}

// фильтр - срочные
function ShowUrgent() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Urgent").prop('disabled', true);
    $("#Urgent").addClass('btn-primary');
    $("#Urgent").addClass('selected');
    $("#Urgent > span").css('color', 'white');

    setFilters(null, null, true);
}

// фильтр - отбракованные
function ShowExtradited() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Extradited").prop('disabled', true);
    $("#Extradited").addClass('btn-primary');
    $("#Extradited").addClass('selected');
    $("#Urgent > span").css('color', 'red');

    setFilters(["VH"], [], false);
}

// приминение фильтра
function setFilters(statusesEqual, statusesNotEqual, isUrgent) {
    var grid = $('#grid').data().kendoGrid;

    var main_filter = [];
    var status_filter = { logic: "or", filters: [] };
    var status_notEqual_filter = { logic: "and", filters: [] };
    var branch_filter = { logic: "and", filters: [] };

    if (isUrgent) {
        var new_filter = { field: "IMPORTANT_FLAG", operator: "eq", value: "1" };
        status_filter.filters.push(new_filter);
        main_filter.push(status_filter);
    }
    else {
        if (!!statusesEqual && statusesEqual.length > 0) {
            $.each(statusesEqual, function (index, value) {
                var new_filter = { field: "STATUS", operator: "eq", value: value };
                status_filter.filters.push(new_filter);
            });
            main_filter.push(status_filter);
        }
        if (!!statusesNotEqual && statusesNotEqual.length > 0) {
            $.each(statusesNotEqual, function (index, value) {
                var new_filter = { field: "STATUS", operator: "neq", value: value };
                status_notEqual_filter.filters.push(new_filter);
            });
            main_filter.push(status_notEqual_filter);
        }
    }

    if (showOnlyBranch) {
        new_filter = { field: "BRANCH", operator: "eq", value: currentBranch };

        branch_filter.filters.push(new_filter);
        main_filter.push(branch_filter);
    }

    grid.dataSource.filter(main_filter);
}

// фильтр - показать взыскателей введенных только в текущем бранче
function ShowOnlyBranch() {
    showOnlyBranch = !showOnlyBranch;

    if (showOnlyBranch) {
        $("#branch").css("background-color", "#a29bcc"); //#7266ba
        $("#branch").css("border-color", "#a29bcc");
        $("#branch").children().css("color", "#ffffff");
    }
    else {
        $("#branch").css("background-color", "#ffffff");
        $("#branch").css("border-color", "#cccccc");
        $("#branch").children().css("color", "#000000");
    }

    var idSelectedFilter = $(".selected").attr('id');
    $("#" + idSelectedFilter).click();
}

// добавление флага на выделенную кнопку
function importantFlagTemplate(item) {
    var template = "";

    if (item.IMPORTANT_FLAG === 1) {
        template = template + "<div";

        if (item.IMPORTANT_TXT !== null)
            template = template + " title='" + item.IMPORTANT_TXT + "'";

        template = template + "><span class='glyphicon glyphicon-exclamation-sign'></span></div > ";
    }
    return template;
}

// отображение списка найденных в дксу взыскателей по введенным данным
function createResultWindow(count, searchStr, sqlType) {
    $("#windowContainerCustomers").append("<div id='createCustomersWindow'></div>");

    var createWindow = $("#createCustomersWindow").kendoWindow({
        width: "1080px",
        height: "490px",
        title: "Знайдено: " + count,
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
        },
        content: bars.config.urlContent("/bills/bills/clients?param=" + searchStr + '&sqlType=' + sqlType + '&count=' + count)
    }).data("kendoWindow");

    createWindow.center().open();
}

// получение и приминение выбранных данных в окно редактирования взыскателя
function fillClientFields(rnk) {
    $.ajax({
        type: "GET",
        contentType: "application/json",
        url: '/barsroot/api/bills/bills/GetClient?rnk=' + rnk,
        success: function (result) {
            $('.k-overlay').css('z-index', '10002');
            var contents = $("iframe[title=Редагування]").contents();

            checkRequiredFieldsOnEditPopUp('INN', result.OKPO);
            contents.find("#INN").val(result.OKPO);

            checkRequiredFieldsOnEditPopUp('NAME', result.NMK);
            contents.find("#NAME").val(result.NMK);

            checkRequiredFieldsOnEditPopUp('DOC_WHO', result.ORGAN);
            contents.find("#DOC_WHO").val(result.ORGAN);

            checkRequiredFieldsOnEditPopUp('PHONE', result.PHONE);
            contents.find("#PHONE").val(result.PHONE);

            checkRequiredFieldsOnEditPopUp('ADDRESS', result.ADDRESS);
            contents.find("#ADDRESS").val(result.ADR);

            checkRequiredFieldsOnEditPopUp('RNK', result.RNK);
            contents.find("#RNK").val(result.RNK);

            if (!!result.SER || !!result.NUMDOC) {
                contents.find("#DOC_NO").val(result.SER + result.NUMDOC);
                checkRequiredFieldsOnEditPopUp('DOC_NO', result.SER + result.NUMDOC);
            }
            else {
                contents.find("#DOC_NO").val("");
                checkRequiredFieldsOnEditPopUp('DOC_NO', '');
            }

            if (!!result.PDATE) {
                var date = new Date(parseInt(result.PDATE.substr(6)));
                var month = ('0' + (date.getMonth() + 1)).slice(-2);
                var day = ('0' + (date.getDate() + 1)).slice(-2);
                result.PDATE = day + "." + month + "." + date.getFullYear();
            }
            checkRequiredFieldsOnEditPopUp('DOC_NO', result.PDATE);
            contents.find("#DOC_DATE").val(result.PDATE);

            if (result.ACCOUNTS.length > 0)
                $("iframe[title=Редагування]")[0].contentWindow.changeAccounts(result.ACCOUNTS);
            else
                $("iframe[title=Редагування]")[0].contentWindow.changeAccounts(null);
            var ctype = result.CUSTTYPE === 2 ? 2 : 1;
            var frame = $("iframe[title=Редагування]")[0];
            frame.contentWindow.setClientType(ctype);
            frame.contentWindow.ChechFieldsOnEdited();
        }
    });
}

// Проверка полей для заполнения в окне для редактирования
function checkRequiredFieldsOnEditPopUp(name, text) {
    var contents = $("iframe[title=Редагування]").contents();
    if (contents.find('#' + name).css('border-color') === 'red' || contents.find('#' + name).css('border-color') === 'rgb(255, 0, 0)') {
        if (text && text.length > 0) {
            contents.find('#' + name).css('border-color', '#ccc');
            if (name === 'DOC_DATE')
                contents.find('.k-picker-wrap').css('border-color', '#ccc');
        }
    }
}

// показ окна активностей сделанных по текущему взыскателю
function ShowActionProtocol() {
    var id = buildAndSendObj.getExpectedId();
    if (id !== 'undefined')
        showLog(id);
    else
        noRowsSelected();
}

// отображение окна активностей сделанных по текущему взыскателю
function showLog(id) {
    var url = '/bills/bills/ReceiverLogs/' + id;
    buildAndSendObj.popUp(url, 'Перегляд дій користувача', "530px", "80%");
    return false;
}

// открытие окна для сохранения файлов
function attachDocument() {
    var exp_id = buildAndSendObj.getExpectedId();
    if (exp_id === 'undefined') {
        bars.ui.alert({
            text: 'Жодної строки не було вибрано',
            title: 'Увага!'
        });
    }
    else
        buildAndSendObj.popUp('/bills/bills/attachPdf/' + exp_id, 'Збереження документів', '300px', '600px');
}

// Загрузка файла на погашение
function DownloadAcceptance(type) {
    var id = buildAndSendObj.getExpectedId();
    if (id !== 'undefined') {
        var url = '/barsroot/bills/bills/DownloadReport/' + id + '?reportType=';
        url += type === 'acc' ? 'acceptancereceiverfrombank' : 'act';
        downloadPdf(url);
    }
    else
        noRowsSelected();
}

// Загрузка файла PDF
function downloadPdf(url) {
    var win = window.open(url, '_blank');
    win.focus();
}