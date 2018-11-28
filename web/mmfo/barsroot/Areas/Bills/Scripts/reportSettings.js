var paramUrl = '/bills/report/AddUpdateReportParam';
var parametersTypes = [];

//button class="k-button" style="color: forestgreen; margin-left: 10px;"
// формирование кномок на форме списка отчетов
function getReportEditButtons(id, type, active) {
    var url = '/bills/report/actionwithreport?id=' + id + '&actionType=' + type;
    var buttons = '<button title=\'Редагувати звіт\' class=\'k-button\' style=\'width: 35px; min-width: 35px;\' onclick=\'popUp("' + url + '", "Редагування звіту", "400px", "750px", "reportlist", null)\'><span class=\'fa fa-pencil-square-o\'></psan></button>';
    var activeText = active === 1 ? 'Деактивувати звіт' : 'Активувати звіт';
    var activateUrl = '/barsroot/bills/report/ActivateDeactivateReport?id=' + id + '&active=' + active;
    var icon = active === 0 ? 'glyphicon-ok' : 'glyphicon-remove';
    buttons += '<button title=\'' + activeText + '\' class=\'k-button\' style=\'width: 35px; min-width: 35px;\' onclick=\'sendPostRequest("' + activateUrl + '", null, defaultOnReportSuccess)\'><span class=\'glyphicon ' + icon + '\'></psan></button>';
    return buttons;
}

// создание и открытие всплывающего окна
function popUp(url, title, height, width, grid, func) {
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
            if (grid !== null && $('#' + grid).length) {
                refreshGrid(grid);                
            }
            if (func !== null && typeof func === "function")
                func();
            this.destroy();
        },
        content: bars.config.urlContent(url)
    }).data("kendoWindow");

    createWindow.center().open();
}

// отправка запросов методом POST
function sendPostRequest(url, data, successFunc) {
    showOverlay();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8;",
        url: url,
        data: data,
        success: successFunc,
        error: function (result) {
            var errText = '';
            if (result.responseJSON && result.responseJSON.ExceptionMessage)
                errText = result.responseJSON.ExceptionMessage;
            else if (result.responseText)
                errText = result.responseText;
            else
                errText = 'Виникла помилка при виконанні оперіції';
            bars.ui.error({
                text: errText,
                title: 'П О М И Л К А'
            });
            hideOverlay();
        }
    });
}

// обновление данных грида по его ИД
function refreshGrid(gridId) {
    if ($('#' + gridId).length && $('#' + gridId).data('kendoGrid') !== undefined && $('#' + gridId).data('kendoGrid') !== 'undefined') {
        $('#' + gridId).data('kendoGrid').dataSource.read();
        //$('#' + gridId).data('kendoGrid').refresh();
    }
}

// отображение затемняющего заднего фона
function showOverlay() {
    $("<div class='k-overlay'></div>").appendTo($(document.body));
}

// скрытие затемняющего заднего фона
function hideOverlay() {
    $(".k-overlay").remove();
}

// Функция по умолчанию для обработки POST запросов
function defaultOnReportSuccess(result) {
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
    refreshGrid('reportlist');
}

// открытие файла Pdf
function downloadPdf(url, func) {
    var win = window.open(url, '_blank');
    win.focus();
    func();
}

// событие изменения отчета для отображения параметров
function onReportParamChange(e) {
    var reportID = +$('#REPORTSETTINGS').val();
    $('#data-container').html('');
    if (!isNaN(reportID)) {
        $.post('/barsroot/bills/report/ReportParamsEditSettings/' + reportID, function (data) {
            $('#data-param-container').html(data);
            $('#id').val(reportID);
        });
    }
}

// событие заполнения списка отчетов для отображения параметров
function onReportParamDataBound(e) {
    onReportParamChange(e);
}

// Окно редактирования параметров отчета
function editParameter(paramId, reportId) {
    var url = paramUrl + '?reportId=' + reportId + '&id=' + paramId;
    popUp(url, 'Редагування параметру', '450px', '750px', null, function () {
        onReportParamChange();
    });
}

// удаление параметра отчета
function removeParameter(paramId, reportId) {
    var url = '/barsroot/bills/report/RemoveReportParameter/' + paramId;
    sendPostRequest(url, null, function (result) {
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
        onReportParamChange();
    });
}

// Окно создания параметра отчета
function createParam() {
    var reportId = $('#REPORTSETTINGS').val();
    var url = paramUrl + '?reportId=' + reportId;
    popUp(url, 'Створення параметру', '450px', '750px', null, function () {
        onReportParamChange();
    });
}

// открытие окна для выбора значения параметра
function OpenSelectWindow(paramCode, values, title, vtype) {
    var url = '/bills/report/SelectParameterValue?paramCode=' + paramCode + '&values=' + values + '&vtype=' + vtype;
    var popUpTitle = 'Вибір параметрів для \'' + title + '\'';
    popUp(url, popUpTitle, '250px', '500px', null, null);
}

// Заполнение поля параметра
function fillFields(val, id, text, vtype) {
    if (vtype === 'number' || vtype === 'varchar2')
        $('#' + id).val(text);
    else if (vtype === 'date') {
        var datepicker = $('#' + id).data("kendoDatePicker");
        datepicker.value(text);
    }
    $('#createWindow').closest(".k-window-content").data("kendoWindow").close();
}

// Обработка события изменения tab
function onSelect(e) {
    var index = +e.contentElement.id[e.contentElement.id.length - 1];
    if (index === 1 && $('#reportlist').data('kendoGrid') !== undefined && $('#reportlist').data('kendoGrid') !== 'undefined')
        $('#reportlist').data('kendoGrid').refresh();
    else if (index === 2) {
        if ($('#REPORTSETTINGS').length)
            $('#REPORTSETTINGS').data('kendoDropDownList').dataSource.read();//refresh(); //
        onReportParamChange(null);
    }
    else if (index === 3) {
        if ($('#reportitems').length) {
            $('#reportitems').data('kendoDropDownList').dataSource.read();
            isReportsLoaded = false;
            isParametersLoaded = false;
            onReportItemsChange(null);
        }
    }
    else if (index === 4 && typeof (onChange) !== 'undefined') {
        if ($('#REPORT').length)
            $('#REPORT').data('kendoDropDownList').dataSource.read();
        onChange(null);
    }
    
}

// Событие изменения отчета
function onReportItemsChange(e) {
    var id = +$('#reportitems').val();
    if (!isNaN(id)) {
        var url = '/barsroot/bills/report/GetReportParametersList?id=' + id;
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: null,
            success: function (result) {
                var reportParamsDropDownList = $('#reportparams').data("kendoDropDownList");
                reportParamsDropDownList.setDataSource(result);
                reportParamsDropDownList.select(0);
                $('#parameter-type-label').text('');
                if (typeof (result) === "object" && result.length > 0) {
                    var type = result[0].PARAM_TYPE;
                    showParameterType(type);
                    parametersTypes = [];
                    for (var i = 0; i < result.length; ++i) {
                        var paramID = result[i].PARAM_ID;
                        parametersTypes[paramID] = result[i].PARAM_TYPE;
                    }
                    onReportParameterChange(e);
                }
                
            },
            error: function (result) {
                
            }
        });
    }
}

// Отображение типа выбранного параметра
function showParameterType(type) {
    switch (type) {
        case "NUMBER":
            $('#parameter-type-label').text('Числове значення');
            break;
        case "DATE":
            $('#parameter-type-label').text('Дата');
            break;
        case "VARCHAR2":
            $('#parameter-type-label').text('Текстове значення');
            break;
    }
}

// Событие формирования списка отчетов
function onReportItemsDataBound(e) {
    var id = +$('#reportitems').val();
    if (!isNaN(id) && !isReportsLoaded) {
        isParametersLoaded = false;
        onReportItemsChange(e);
        isReportsLoaded = true;        
    }
}

// Событие изменения параметра
function onReportParameterChange(e) {
    var id = $('#reportparams').val();
    var type = parametersTypes[id];
    if (id !== '' && type !== 'undefined') {
        showParameterType(type);
        $('#parameter-value-container').html('');
        var url = '/barsroot/bills/report/parametervalueslist?id=' + id;
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: url,
            data: null,
            success: function (result) {
                $('#parameter-value-container').html(result);
            },
            error: function (result) {

            }
        });
    }
}

// Событие формирования списка параметров
function onReportParameterDataBound(e) {
    var id = +$('#reportparams').val();
    if (!isNaN(id) && !isParametersLoaded) {
        onReportParameterChange(e);
        isParametersLoaded = true;
    }
}

// открытие формы для создания значения параметра отчета
function createParamValue() {
    var parameterId = +$('#reportparams').val();
    if (!isNaN(parameterId)) {
        var url = '/bills/report/AddUpdateParameterDefaultValue?id=0&parameterId=' + parameterId;
        popUp(url, 'Створення значення параметру', '300px', '500px', null, function (result) {
            onReportParameterChange(null);
        });
    }
    else {
        bars.ui.error({
            text: 'Неможливо отримати або відсутні параметри для звіту'
        });
    }
}

// Редактирование значения параметра
function editParameterValue(parameterId, valueId) {
    if (!isNaN(+parameterId) && !isNaN(+valueId)) {
        var url = '/bills/report/AddUpdateParameterDefaultValue?id=' + valueId + '&parameterId=' + parameterId;
        popUp(url, 'Створення значення параметру', '300px', '500px', null, function (result) {
            onReportParameterChange(null);
        });
    }
    else {
        bars.ui.error({
            text: 'Неможливо отримати або відсутні параметри для звіту'
        });
    }
}

// Удаление значения параметра
function removeParameterValue(parameterId, valueId) {
    var url = '/barsroot/bills/report/RemoveParameterValue?valueId=' + valueId + '&parameterId=' + parameterId;
    sendPostRequest(url, null, function (result) {
        if (result.status && result.status === 1)
            onReportParameterChange(null);
        else {
            bars.ui.error({
                text: result.err
            });
        }
        hideOverlay();
    });
}

