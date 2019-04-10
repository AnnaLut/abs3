var firstLoad = true;
var selectedStatuses = [];
var modalWindow

$(document).ready(function () {
    $("#gridBack").kendoGrid({
        dataSource: {
            type: 'aspnetmvc-ajax',
            transport: {
                read: {
                    url: bars.config.urlContent('/gda/gdaback/Get_Data'),
                    dataType: "json",
                    cache: false,
                    data: function () { }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    id: "UniqueId",
                    fields: {
                        PROCESS_ID: { type: "number" }, //0
                        PROCESS_CODE: { type: "string" }, //1
                        DEPOSIT_ID: { type: "number" }, //2
                        PROCESS_STATE_CODE: { type: "string" }, //3
                        OBJECT_STATE_CODE: { type: "string" }, //4
                        RNK: { type: "string" }, //5
                        CONTRACT_NUMBER: { type: "string" }, //6
                        CUSTOMER_NAME: { type: "string" }, //7
                        OKPO: { type: "string" }, //8
                        TRANSACTION_TYPE: { type: "string" }, //9
                        SYS_TIME: { type: "date" }, //10
                        STATE_NAME: { type: "string" }, //11
                        LCV: { type: "string" }, //12
                        ACCOUNT_NUMBER: { type: "string" }, //13
                        AMOUNT_DEPOSIT: { type: "number" }, //14
                        INTEREST_RATE: { type: "string" }, //15
                        TOTAL_AMOUNT_DEPOSIT: { type: "number" }, //16
                        FREQUENCY_PAYMENT_NAME: { type: "string" }, //17
                        EXPIRY_DATE: { type: "date" }, //18
                        BRANCH_ID: { type: "string" }, //19
                        FIO: { type: "string" }, //20
                        IS_EXPIRED_AND_BLOCKED: { type: "number" } //21
                    }
                }
            },
            pageSize: 10,
            page: 1,
            take: 10,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            filter: getStatusFilters(["RUNNING"], [], false)
        },
        dataBound: function (e) {

            var grid = e.sender;
            var dataItems = grid.dataSource.data();
            grid.tbody.find("tr").dblclick(function (e) {
                viewOperation();
            });

            if (firstLoad) {
                //ShowOnAuthorization();
                $("#rnkNum").val('');
                $("#dbo").val('');
                $("#edrpouNum").val('');

                $(".btn-filter").prop('disabled', false);
                $(".btn-filter").removeClass('btn-primary');
                $(".btn-filter").removeClass('selected');
                $(".btn-filter").addClass('btn-default');
                $("#OnAuthorization").prop('disabled', true);
                $("#OnAuthorization").addClass('btn-primary');
                $("#OnAuthorization").addClass('selected');

                //showHideColumns(0);
                firstLoad = false;
            };

            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("STATE_NAME") == "створено" || dataItem.get("STATE_NAME") == "редагування") {
                    row.addClass("classCreated");
                } else if (dataItem.get("STATE_NAME") == "активна") {
                    row.addClass("classAuthorized");
                } else if (dataItem.get("STATE_NAME") == "на авторизації") {
                    row.addClass("classOnAuthorizing");
                } else if (dataItem.get("STATE_NAME") == "авторизовано") {
                    row.addClass("classAuthorized");
                } else if (dataItem.get("STATE_NAME") == "авторизовано з помилкою") {
                    row.addClass("classAuthCellError");
                } else if (dataItem.get("STATE_NAME") == "закрита") {
                    row.addClass("classClose");
                } else if (dataItem.get("STATE_NAME") == "анульовано") {
                    row.addClass("classCanceled");
                }

                if (dataItem.get("IS_EXPIRED_AND_BLOCKED") == 1) {
                    row.addClass("classExpiredAndBlocked");
                }
                if (dataItem.get("PROCESS_CODE") == "REPLENISH_TRANCHE" && dataItem.get("STATE_NAME") == "на авторизації") {
                    var cell = $("td:nth-child(15)", row);
                    cell.addClass("classAuthSuccess");
                }

            }
        },
        dataBinding: function (e) {
        },
        change: Selected, 
        autoBind: true,
        selectable: 'single',
        groupable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        resizable: true,
        reorderable: true,
        scrollable: true,
        filterable: true,
        excelExport: excelExport,
        pageable: {
            refresh: true,
            pageSizes: [5, 10, 20, 50, 100, 'All'],
            buttonCount: 5,
            messages: {
                empty: 'Немає даних',
                allPages: 'Всі'
            },
            change: function (e) {
            }
        },
        excel: {
            allPages: true,
            fileName: "Бек-офіс.xlsx",
            filterable: false,
            proxyURL: bars.config.urlContent('/GDA/GDA/ConvertBase64ToFile/'),
        },
        toolbar: [
            'excel'
            //{
            //    template: ''/*'<a class="k-button" id="leftbtn" href="\\#" onclick="return ShowLeftColumns()" disabled><<</a>'*/
            //},  "excel", {
            //    template: ''/*'<a class="k-button" id="rightbtn" href="\\#" onclick="return ShowRightColumns()" style="float: right;">>></a>'*/
            //}
        ],
        columns: [
            {
                field: "PROCESS_ID", //0
                hidden: true
            },
            {
                field: "PROCESS_CODE", //1
                hidden: true
            },
            {
                field: "DEPOSIT_ID", //2
                hidden: true
            },
            {
                field: "PROCESS_STATE_CODE", //3
                hidden: true
            },
            {
                field: "OBJECT_STATE_CODE", //4
                hidden: true
            },
            {
                field: "RNK", //5
                title: "РНК",
                width: 108,
                attributes: { style: "text-align:center;" }
            },
            {
                field: "CONTRACT_NUMBER", //6
                hidden: true
                //title: "ДБО",
                //attributes: { style: "white-space: normal" }
            },
            {
                field: "CUSTOMER_NAME", //7
                title: "Назва клієнта",
                width: 160,
                attributes: { style: "white-space: normal" },
                headerAttributes: { style: "white-space: normal" }
            },
            {
                field: "OKPO", //8
                title: "ЄДРПОУ",
                width: 108,
                attributes: { style: "white-space: normal" }
            },
            {
                field: "TRANSACTION_TYPE", //9
                title: "Тип операції",
                width: 208,
                attributes: { style: "white-space: normal" }
            },
            {
                field: "SYS_TIME", //10
                title: "Дата операції",
                width: 100,
                template: "#=formatSysDateOperationTemplate(data)#",
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "white-space: normal" }
            },
            {
                field: "STATE_NAME", //11
                title: "Статус операції",
                width: 190,
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "white-space: normal" }
            },
            {
                field: "LCV", //12
                title: "Валюта",
                width: 96
            },
            {
                field: "ACCOUNT_NUMBER", //13
                title: "№ рахунку",
                width: 140
            },
            {
                field: "AMOUNT_DEPOSIT", //14
                title: "Сума траншу",
                width: 110,
                format: "{0:0.00}",
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "text-align: right;" }
            },
            {
                field: "INTEREST_RATE", //15
                title: "Процентна ставка",
                width: 114,
                headerAttributes: { style: "white-space: normal; text-align:center;" },
                attributes: { style: "text-align:center;" }
            },
            {
                field: "TOTAL_AMOUNT_DEPOSIT", //16
                title: "Загальна сума на деп. рахунку",
                width: 144,
                format: "{0:0.00}",
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "text-align: right;" }
            },
            {
                field: "FREQUENCY_PAYMENT_NAME", //17
                title: "Періодичність погашення %%",
                width: 140,
                attributes: { style: "white-space: normal" },
                headerAttributes: { style: "white-space: normal" }
            },
            {
                field: "EXPIRY_DATE", //18
                title: "Дата повернення траншу",
                width: 152,
                template: "#=formatExpDateOperationTemplate(data)#",
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "white-space: normal" }
            },
            {
                field: "BRANCH_ID", //19
                title: "Код відділення",
                width: 180,
                attributes: { style: "white-space: normal" }
            },
            {
                field: "FIO", //20
                title: "Виконавець (оператор)",
                width: 120,
                headerAttributes: { style: "white-space: normal" },
                attributes: { style: "white-space: normal" }
            },
            {
                field: "IS_EXPIRED_AND_BLOCKED", //21
                hidden: true
            }
        ],
        height: '70%'
    });
});

function formatSysDateOperationTemplate(item) {
    if (!item.SYS_TIME)
        return "";

    var month = item.SYS_TIME.getMonth() + 1;
    month = month.toString().length > 1 ? month : '0' + month;

    var day = item.SYS_TIME.getDate().toString();
    day = day.length > 1 ? day : '0' + day;

    return day + "." + month + "." + item.SYS_TIME.getFullYear();
}

function formatExpDateOperationTemplate(item) {
    if (!item.EXPIRY_DATE)
        return "";

    var month = item.EXPIRY_DATE.getMonth() + 1;
    month = month.toString().length > 1 ? month : '0' + month;

    var day = item.EXPIRY_DATE.getDate().toString();
    day = day.length > 1 ? day : '0' + day;

    return day + "." + month + "." + item.EXPIRY_DATE.getFullYear();
}

function Selected() {
    var process = getProcessInfo();
    if (process === 'undefined')
        return;

    if (process.stateCode === 'DONE' && process.processCode === 'NEW_TRANCHE' && process.objectStateCode === 'ACTIVE') { //авторизировано, розміщення, не заблоковано(активне)
        setBtnEnabled("#block-btn");
        setBtnDisabled("#unblock-btn");
    }
    else if (process.stateCode === 'DONE' && process.processCode === 'NEW_TRANCHE' && process.objectStateCode === 'BLOCKED') { //авторизировано, розміщення, заблоковано
        setBtnDisabled("#block-btn");
        setBtnEnabled("#unblock-btn");
    }
    else {
        setBtnDisabled("#block-btn");
        setBtnDisabled("#unblock-btn");
    }
}

function setBtnDisabled(btnId) {
    $(btnId).addClass("k-state-disabled");
}

function setBtnEnabled(btnId) {
    $(btnId).removeClass("k-state-disabled");
}

function getProcessInfo() {
    var rows = this.getSelectedRows();
    if (rows.length < 1)
        return 'undefined';
    else {
        var processInfo = {
            processId: rows[0].childNodes[0].innerHTML,
            processCode: rows[0].childNodes[1].innerHTML,
            trancheId: rows[0].childNodes[2].innerHTML,
            stateCode: rows[0].childNodes[3].innerHTML,
            objectStateCode: rows[0].childNodes[4].innerHTML,
            Rnk: rows[0].childNodes[5].innerHTML,
            dboNumber: rows[0].childNodes[6].innerHTML,
            Name: rows[0].childNodes[7].innerHTML,
            Okpo: rows[0].childNodes[8].innerHTML,
            dboDate: rows[0].childNodes[10].innerHTML,
            stateName: rows[0].childNodes[11].innerHTML
        };
        return processInfo;
    }
}

function getSelectedRows() {
    var grid = $('#gridBack').data('kendoGrid');
    return grid.select();
}

function refreshGrid() {
    $('#gridBack').data('kendoGrid').dataSource.read();
    $('#gridBack').data('kendoGrid').refresh();
}

function viewOperation() {
    var process = getProcessInfo();
	if (process === 'undefined') {
        noRowsSelected();
    } else if (process.processCode === 'NEW_TRANCHE') {
        var url = bars.config.urlContent("/gda/gdaBack/PlacementTranche?processId=") + process.processId + "&stateCode=" + process.stateCode + "&stateName=" + process.stateName + "&okpo=" + process.Okpo + "&nmk=" + process.Name; // + "&processCode=" + process.processCode;
        var title = "Розміщення траншу №ДБО " + process.dboNumber + " від " + process.dboDate;
        createNewWindow(url, title, "981px", "870px");
    } else if (process.processCode === 'REPLENISH_TRANCHE') {
        var url = bars.config.urlContent("/gda/gdaBack/ReplenishTranche?processId=") + process.processId + "&trancheId=" + process.trancheId + "&stateCode=" + process.stateCode + "&stateName=" + process.stateName;
        var title = "Поповнення траншу №ДБО " + process.dboNumber + " від " + process.dboDate;
        createNewWindow(url, title, "970px", "480px");
	} else if (process.processCode === 'EARLY_RETURN_TRANCHE') {
        var url = bars.config.urlContent("/gda/gdaBack/EarlyRepaymentTranche?processId=") + process.processId + "&trancheId=" + process.trancheId + "&stateCode=" + process.stateCode + "&stateName=" + process.stateName;
		var title = "Дострокове повернення траншу №ДБО " + process.dboNumber + " від " + process.dboDate;
		createNewWindow(url, title, "970px", "800px");
    } else if (process.processCode === 'NEW_ON_DEMAND') {

        var model = {
            ProcessId: process.processId,
            StateCode: process.stateCode,
            Dbo: process.dboNumber,
            DboDate: process.dboDate,
            Rnk: process.Rnk,
            Okpo: process.Okpo,
            Name: process.Name.replace(/'/g, '\\_//'),
            Type: process.processCode,
            StateName: process.stateName.replace(/'/g, '\\_//')
        };
        var data = JSON.stringify(model);
        //var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?processId=") + process.processId + "&trancheId=" + process.trancheId + "&stateCode=" + process.stateCode;
        var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?depositInfo=") + encodeURI(data);
        var title = "Відкриття вкладу на вимогу №ДБО " + process.dboNumber + " від " + process.dboDate;
        createNewWindow(url, title, "970px", "788px");
    } else if (process.processCode === 'CLOSE_ON_DEMAND') {
        var model = {
            ProcessId: process.processId,
            StateCode: process.stateCode,
            Dbo: process.dboNumber,
            DboDate: process.dboDate,
            Rnk: process.Rnk,
            Okpo: process.Okpo,
            Name: process.Name.replace(/'/g, '\\_//'),
            Type: process.processCode,
            StateName: process.stateName.replace(/'/g, '\\_//')
        };
        var data = JSON.stringify(model);

        //var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?processId=") + process.processId + "&trancheId=" + process.trancheId + "&stateCode=" + process.stateCode;
        var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?depositInfo=") + encodeURI(data);
        var title = "Закриття вкладу на вимогу №ДБО " + process.dboNumber + " від " + process.dboDate;
        createNewWindow(url, title, "970px", "788px");
    } else if (process.processCode === 'CHANGE_CALCULATION_TYPE') {
        var model = {
            ProcessId: process.processId,
            StateCode: process.stateCode,
            Dbo: process.dboNumber,
            DboDate: process.dboDate,
            Rnk: process.Rnk,
            Okpo: process.Okpo,
            Name: process.Name.replace(/'/g, '\\_//'),
            Type: process.processCode,
            StateName: process.stateName.replace(/'/g, '\\_//')
        };
        var data = JSON.stringify(model);

        //var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?processId=") + process.processId + "&trancheId=" + process.trancheId + "&stateCode=" + process.stateCode;
        var url = bars.config.urlContent("/gda/gdaBack/OnDemandTranche?depositInfo=") + encodeURI(data);
        var title = "Зміна методу нарахування відсотків №ДБО " + process.dboNumber + " від " + process.dboDate;
        createNewWindow(url, title, "970px", "788px");
    }
}

function noRowsSelected() {
    bars.ui.alert({
        text: 'Жодної строки не було вибрано',
        title: 'Увага!'
    });
}

function createNewWindow(url, title, width, height) {
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
            refreshGrid();
        },
        content: url
    }).data("kendoWindow");

    createWindow.center().open();
}

function searchOperation() {
    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');

    var dbo = $("#dbo").val();
    var rnk = $("#rnkNum").val();
    var edrpou = $("#edrpouNum").val();

    var dbofilter = { field: "CONTRACT_NUMBER", operator: "contains", value: dbo };   //startswith eq
    var rnkfilter = { field: "CUSTOMER_ID", operator: "eq", value: rnk };
    var edrpoufilter = { field: "OKPO", operator: "contains", value: edrpou };
    var operationfilter = {
        filters: [],
        logic: 'and'
    };
    if (!!dbo && dbo.length > 0)
        operationfilter.filters.push(dbofilter);

    if (!!rnk && rnk.length > 0)
        operationfilter.filters.push(rnkfilter);

    if (!!edrpou && edrpou.length > 0)
        operationfilter.filters.push(edrpoufilter);

    var grid = $('#gridBack').data().kendoGrid;
    grid.dataSource.filter(operationfilter);
}

function opHistory() {
    var url = bars.config.urlContent("/gda/gdaBack/History");
    var title = "Історія змін операцій";
    createNewWindow(url, title, "1280px", "615px");
}

/// Отображение и загрузка документов из ЕА
function viewEA() {
    var grid = $("#gridBack").data('kendoGrid');
    var selectedItem = grid.dataItem(grid.select());
    if (!selectedItem) {
        noRowsSelected();
        return;
    }
    //var Url = '/barsroot/api/gda/gda/GetDocumentsFromEA?rnk=' + rnk;
    var Url = '/barsroot/gda/gdaback/geteafiles?rnk=' + selectedItem.RNK + '&nls=' + selectedItem.ACCOUNT_NUMBER;
    //var Url = '/barsroot/UserControls/dialogs/EADocsView.aspx?eas_id=1&rnk=' + rnk;
    createNewWindow(Url, 'Перегляд документів', '650px', '450px');
}

function blockTranche() {
    var process = getProcessInfo();
    if (process === 'undefined') {
        noRowsSelected();
    }

    if (process === 'undefined' || process.stateCode !== 'DONE' || process.processCode !== 'NEW_TRANCHE' || process.objectStateCode !== 'ACTIVE') {
        return;
    }
    var url = bars.config.urlContent("/gda/gdaBack/BlockPlacementTranche?processId=") + process.processId + "&stateCode=" + process.stateCode + "&stateName=" + process.stateName + "&okpo=" + process.Okpo + "&nmk=" + process.Name;
    var title = "Розміщення траншу №ДБО " + process.dboNumber + " від " + process.dboDate;
    createNewWindow(url, title, "981px", "870px");
}

function unblockTranche() {
    var process = getProcessInfo();
    if (process === 'undefined') {
        noRowsSelected();
    }

    if (process === 'undefined' || process.stateCode !== 'DONE' || process.processCode !== 'NEW_TRANCHE' || process.objectStateCode !== 'BLOCKED') {
        return;
    }

    var url = bars.config.urlContent("/gda/gdaBack/UnblockPlacementTranche?processId=") + process.processId + "&stateCode=" + process.stateCode + "&stateName=" + process.stateName + "&okpo=" + process.Okpo + "&nmk=" + process.Name;
    var title = "Розміщення траншу №ДБО " + process.dboNumber + " від " + process.dboDate;
    createNewWindow(url, title, "981px", "870px");
}

function showHistory() {
    var process = getProcessInfo();
    if (process === 'undefined') {
        noRowsSelected();
        return;
    }

    var url = bars.config.urlContent("/gda/gdaBack/TrancheHistory?trancheId=") + process.trancheId;
    var title = "Історія змін операцій по траншу №" + process.trancheId;
    createNewWindow(url, title, "1280px", "615px");
}

function ShowAll() {
    $("#rnkNum").val('');
    $("#dbo").val('');
    $("#edrpouNum").val('');

    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").addClass('btn-default');
    $("#All").prop('disabled', true);
    $("#All").addClass('btn-primary');
    $("#All").addClass('selected');

    setFilters([], [], null);
}

function ShowOnAuthorization() {
    $("#rnkNum").val('');
    $("#dbo").val('');
    $("#edrpouNum").val('');

    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#OnAuthorization").prop('disabled', true);
    $("#OnAuthorization").addClass('btn-primary');
    $("#OnAuthorization").addClass('selected');

    setFilters(["RUNNING"], [], false); //setFilters(["RQ", "RJ"]);
}

function ShowAuthorised() {
    $("#rnkNum").val('');
    $("#dbo").val('');
    $("#edrpouNum").val('');

    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Authorised").prop('disabled', true);
    $("#Authorised").addClass('btn-primary');
    $("#Authorised").addClass('selected');

    setFilters(["DONE"], [], false); //setFilters(["RQ", "RJ"]);
}

function ShowBlocked() {
    $("#rnkNum").val('');
    $("#dbo").val('');
    $("#edrpouNum").val('');

    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Blocked").prop('disabled', true);
    $("#Blocked").addClass('btn-primary');
    $("#Blocked").addClass('selected');

    setFilters([], [], true); //setFilters(["RQ", "RJ"]);
}

function ShowFailed() {
    $("#rnkNum").val('');
    $("#dbo").val('');
    $("#edrpouNum").val('');

    $(".btn-filter").prop('disabled', false);
    $(".btn-filter").removeClass('btn-primary');
    $(".btn-filter").removeClass('selected');
    $(".btn-filter").addClass('btn-default');
    $("#Failed").prop('disabled', true);
    $("#Failed").addClass('btn-primary');
    $("#Failed").addClass('selected');

    setFilters(["FAILED"], [], false); //setFilters(["RQ", "RJ"]);
}

function getStatusFilters(statusesEqual, statusesNotEqual, isBlocked) {
    var main_filter = [];
    var status_equals_filter = { logic: "or", filters: [] };
    var status_notEqual_filter = { logic: "and", filters: [] };
    var objectState_filter = { logic: "or", filters: [] };


    if (isBlocked) {
        var new_filter = { field: "OBJECT_STATE_CODE", operator: "eq", value: "BLOCKED" };
        objectState_filter.filters.push(new_filter);
        main_filter.push(objectState_filter);
    }
    else if (isBlocked !== null) {
        var new_filter = { field: "OBJECT_STATE_CODE", operator: "neq", value: "BLOCKED" };
        objectState_filter.filters.push(new_filter);
        main_filter.push(objectState_filter);
    }

    if (!!statusesEqual && statusesEqual.length > 0) {
        $.each(statusesEqual, function (index, value) {
            var new_filter = { field: "PROCESS_STATE_CODE", operator: "eq", value: value };
            status_equals_filter.filters.push(new_filter);
        });
        main_filter.push(status_equals_filter);
    }
    if (!!statusesNotEqual && statusesNotEqual.length > 0) {
        $.each(statusesNotEqual, function (index, value) {
            var new_filter = { field: "PROCESS_STATE_CODE", operator: "neq", value: value };
            status_notEqual_filter.filters.push(new_filter);
        });
        main_filter.push(status_notEqual_filter);
    }

    return main_filter;
}

function setFilters(statusesEqual, statusesNotEqual, isBlocked) {
    var grid = $('#gridBack').data().kendoGrid;
    var filters = getStatusFilters(statusesEqual, statusesNotEqual, isBlocked);
    grid.dataSource.filter(filters);
}

var indexOfFirstColumn = 0;
var countOfVisibleColumns = 10;
var columns = [5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20];

function showHideColumns(indexOfFirstColumn) {
    var grid = $("#gridBack").data("kendoGrid");
    $.each(columns, function (key, value) {
        if (key >= indexOfFirstColumn && key < indexOfFirstColumn + countOfVisibleColumns)
            grid.showColumn(value);
        else
            grid.hideColumn(value);
    });
}

function ShowLeftColumns() {
    if (indexOfFirstColumn <= 0)
        return;

    indexOfFirstColumn = 0;
    showHideColumns(indexOfFirstColumn);

    if (indexOfFirstColumn == 0)
        $("#leftbtn").attr("disabled", "disabled");
    else
        $("#leftbtn").removeAttr("disabled"); 

    if (indexOfFirstColumn + countOfVisibleColumns == 15)
        $("#rightbtn").attr("disabled", "disabled");
    else
        $("#rightbtn").removeAttr("disabled"); 
}

function ShowRightColumns() {
    if (indexOfFirstColumn + countOfVisibleColumns >= 15)
        return;

    indexOfFirstColumn = indexOfFirstColumn + 5;
    showHideColumns(indexOfFirstColumn);

    if (indexOfFirstColumn + countOfVisibleColumns == 15)
        $("#rightbtn").attr("disabled", "disabled");
    else
        $("#rightbtn").removeAttr("disabled");

    if (indexOfFirstColumn == 0)
        $("#leftbtn").attr("disabled", "disabled");
    else
        $("#leftbtn").removeAttr("disabled"); 
}

var exportFlag = false;
function excelExport(e) {
    if (!exportFlag) {
        $.each(columns, function (key, value) {
            e.sender.showColumn(value);
        });

        e.preventDefault();
        exportFlag = true;
        setTimeout(function () {
            e.sender.saveAsExcel();
        });
    } else {
        $.each(columns, function (key, value) {
            if (key < indexOfFirstColumn || key >= indexOfFirstColumn + countOfVisibleColumns)
                e.sender.hideColumn(value);
        });
        exportFlag = false;
    }
}

function showClientCard(id) {
    var url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);

    window.parent.$("#clientContainer").append("<div id='createCardWindow'></div>");
    var createWindow = window.parent.$("#createCardWindow").kendoWindow({
        width: "97%",
        height: "95%",
        title: "",
        visible: false,
        actions: ["Close"],
        iframe: true,
        modal: true,
        resizable: false,
        deactivate: function () {
            this.destroy();
        },
        content: url
    }).data("kendoWindow");

    createWindow.center().open();
}

//function createModalWindow(url, width, height, onClose) {
//    $("#clientContainer").append("<div id='createWindow'></div>");
//    if (!width) width = '90%';
//    if (!height) height = '90%';

//    modalWindow = $("#createWindow").kendoWindow({
//        width: width,
//        height: height,
//        title: "",
//        visible: false,
//        actions: ["Close"],
//        iframe: true,
//        modal: true,
//        resizable: false,
//        deactivate: function () {
//            if (onClose && typeof (onClose) == 'function')
//                onClose();            
//            this.destroy();
//            modalWindow = {};
//        },
//        content: url
//    }).data("kendoWindow");

//    modalWindow.center().open();
//}