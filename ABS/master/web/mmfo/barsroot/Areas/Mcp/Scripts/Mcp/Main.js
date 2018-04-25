var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("McpCtrl", function ($controller, $scope, $http, $timeout, kendoService, utilsService, 
    validationService, FILES_CONSTS, FILE_STATES) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    $scope.Title = "Перегляд та оплата реєстрів УПСЗН";

    $scope.BLOCK_TYPE_DEFAULT = 5;

    $scope.filterModel = {
        //DateRegister: kendo.toString(kendo.parseDate(new Date()), 'dd/MM/yyyy'),
        DateRegister: null,
        PaymentType: null,
        IDRegister: null,
        FileNameRegister: null,
        ReceiverMFO: null,
        StateRegister: null
    };

    $scope.removeWindowOptions = $scope.window({title: 'Виключення з платежу', height: "480px"});

    var filesGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'excel\')" ng-disabled="disabledToolbarGrid(\'files\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Файли в Excel</a>' },
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'getBalanceRu\')" ng-disabled="disabledToolbarGrid(\'files\', \'getBalanceRu\')"><i class="pf-icon pf-16 pf-bank-account"></i>Запит залишку в РУ</a>' },
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'createPay\')" ng-disabled="disabledToolbarGrid(\'files\', \'createPay\')" ><i class="pf-icon pf-16 pf-money"></i>Створити загальний платіж</a>' },        
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'pay\')" ng-disabled="disabledToolbarGrid(\'files\', \'pay\')" ><i class="pf-icon pf-16 pf-list-ok"></i>Виконати оплату реєстру</a>' }
    ];
    var infoLinesGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'infoLines\', \'excel\')" ng-disabled="disabledToolbarGrid(\'infoLines\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Рядки в Excel</a>' },
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'infoLines\', \'remove\')" ng-disabled="disabledToolbarGrid(\'infoLines\', \'remove\')"><i class="pf-icon pf-16 pf-delete_button_error"></i>Виключити з платежу</a>' },
        {
            template: '<a class="k-button" ng-click="onClickToolbarGrid(\'infoLines\', \'set_file_record_reverted\')" ng-disabled="disabledToolbarGrid(\'infoLines\', \'set_file_record_reverted\')"><i class="pf-icon pf-16 pf-REPLY"></i>Змінити статус на Повернутий</a>'
        },
        {
            template: '<a class="k-button" style="position: absolute;" ng-click="onClickToolbarGrid(\'infoLines\', \'set_file_record_payed\')" ng-disabled="disabledToolbarGrid(\'infoLines\', \'set_file_record_payed\')"><i class="pf-icon pf-16 pf-list-ok"></i>Змінити статус на Оплачений</a>'
            + '<input id="fileRecordsPayedDate" class="form-control" style="visibility: hidden; position: absolute;" kendo-date-picker="" k-options="fileRecordsPayedDateOptions" />'
        }
    ];

    $scope.visibleToolbarGrid = function(id, op){
        var grid = id === "files" ? $scope.filesGrid : $scope.infoLinesGrid;
        var row = grid.dataItem(grid.select());
       // var state = $scope.filterModel.StateRegister;

        switch (op){
            case 'createPay':
                return row !== null && row.STATE_ID === FILE_STATES.CHECKED;

            case 'pay':
                return row !== null && row.STATE_ID === FILE_STATES.CHECKING_PAY;
        }
        return true;
    };
    $scope.fileRecordsPayedDateOptions = {
        max: new Date(),
        change: function (event) {
            var date = this.value();
            bars.ui.loader("body", true);
            var grid = $scope.infoLinesGrid;
            var checkedArr = kendoService.findCheckedGrid(grid);
            var fileRecords = [];
            for (i = 0; i < checkedArr.length; i++) {
                fileRecords.push(checkedArr[i].ID);
            }
            $http.put(bars.config.urlContent('/api/Mcp/Mcp/SetFileRecordsPayed'), { Date: date, FileRecords: fileRecords } )
                .success(function (response) {
                    bars.ui.loader("body", false);
                    grid.dataSource.read();
                    bars.ui.notify("До відома", "Статус інформаційних рядків змінено на Оплачено.",
                        "info", { autoHideAfter: 5 * 1000 });
                }).error(function (response) {
                    bars.ui.loader("body", false);
                });
        }
    };
    var allowedForSelectStatuses = [17, 19, 20];
    $scope.disabledToolbarGrid = function (id, op){
        var grid = id === "files" ? $scope.filesGrid : $scope.infoLinesGrid;
        var row = grid.dataItem(grid.select());
        //var state = $scope.filterModel.StateRegister;

        function _validate(checkState){
            if (checkState !== undefined && row !== null && row.STATE_ID != checkState){
                return true;
            }

            $scope['alertGridFiles_' + op] = "";
            var res = validationService.validateGridRow('files', op, row);            
            if(res > 0){
                $scope['alertGridFiles_' + op] = FILES_CONSTS[op].TEXT[res];
            }
            return res !== 0;
        }
        
        switch (op){
            case 'excel':
                return grid._data === undefined ? true : grid._data.length <= 0;

            case 'set_file_record_payed':
                var checked = kendoService.findCheckedGrid(grid);
                return checked.length === 0 || checked.some(function (el) { return allowedForSelectStatuses.indexOf(el.STATE_ID) == -1 });
            case 'set_file_record_reverted':
            case 'remove':
                return kendoService.findCheckedGrid(grid).length === 0;

            case 'getBalanceRu':
                return _validate();

            case 'pay':
                return _validate(FILE_STATES.CHECKING_PAY);
            case 'createPay':
                return _validate(FILE_STATES.CHECKED);
        }
        return false;
    };

    $scope.onClickToolbarGrid = function (id, op) {
        var grid = id === "files" ? $scope.filesGrid : $scope.infoLinesGrid;
        var selectedRows = grid.select();
        var row = grid.dataItem(selectedRows);

        var data = [];
        var checkedArr = [];
        var i = 0;
        switch (op){
            case 'excel':
                grid.saveAsExcel();
                break;

            case 'remove':
                $scope["removeWindow"].center().open();     //.maximize();
                var g = $scope.infoLinesRemoveGrid;
                data = [];
                checkedArr = kendoService.findCheckedGrid(grid);
                for(i = 0; i < checkedArr.length; i++){
                    data.push({id: checkedArr[i].ID, comment: "", full_name: checkedArr[i].FULL_NAME, block_type: $scope.BLOCK_TYPE_DEFAULT});
                }
                g.dataSource.data(data);
                break;
            case 'set_file_record_reverted':
                bars.ui.loader("body", true);
                var checkedArr = kendoService.findCheckedGrid(grid);
                var fileRecordIds = [];
                for (i = 0; i < checkedArr.length; i++) {
                    fileRecordIds.push(checkedArr[i].ID);
                }
                $http.put(bars.config.urlContent('/api/Mcp/Mcp/SetFileRecordsReverted'), fileRecordIds )
                    .success(function (response) {
                        bars.ui.loader("body", false);
                        grid.dataSource.read();
                        bars.ui.notify("До відома", "Статус інформаційних рядків змінено на Повернутий.",
                            "info", { autoHideAfter: 5 * 1000 });
                    }).error(function (response) {
                        bars.ui.loader("body", false);
                    });
                break;
            case 'set_file_record_payed':
                $("#fileRecordsPayedDate").data("kendoDatePicker").open();
                break;
            case 'pay':
                bars.ui.loader("body", true);
                $http.post(bars.config.urlContent('/api/Mcp/Mcp/Pay'), {id: row.ID})
                .success(function (response) {
                    bars.ui.loader("body", false);
                    grid.dataSource.read();
                    bars.ui.notify("До відома", "Документ " + row.ID + " успішно оплачено",
                        "info", {autoHideAfter: 5*1000});
                }).error(function (response) {
                    bars.ui.loader("body", false);
                });
                break;

            case 'createPay':
                $http.post(bars.config.urlContent('/api/Mcp/Mcp/VerifyFileAndPreparePayment'), {id: row.ID})
                    .success(function (response) {
                        if(response.length > 0){
                            var  p = response[0];
                            if(p['Sum'] === null || p['Sum'] <= 0){
                                bars.ui.error({ title: 'Помилка', text: 'Сума для оплати - нульова, створення платежу неможливе!' });
                            }
                            else {
                                p.Narrative = p.Narrative.replace('{0}', row.ID);
                                bars.ui.dialog({
                                    title: "Створення платежу на загальну суму по реєстру №" + row.ID,
                                    content: {
                                        url: bars.config.urlContent('/docinput/docinput.aspx?tt=' + p.OpCode + "&Id_A=" + p.RecipientCustCode + "&Nls_A=" + p.RecipientAccNum + "&Kv_A=980&Nam_A=" + p.RecipientName + "&Id_B=" + p.SenderCustCode + "&Nls_B=" + p.SenderAccNum + "&Kv_B=980&Nam_B=" + p.SenderName + "&Mfo_B=" + p.SenderBankId + "&SumC_t=" + p.Sum + "&Nazn=" + p.Narrative)
                                    },
                                    iframe: true,
                                    width: '650px',
                                    height: '600px',
                                    buttons: [{
                                        text: 'Закрити',
                                        click: function () {
                                            var win = this;
                                            var windowElement = $("#barsUiAlertDialog");
                                            var iframeDomElement = windowElement.children("iframe")[0];
                                            var iframeWindowObject = iframeDomElement.contentWindow;
                                            var iframeDocumentObject = iframeDomElement.contentDocument;
                                            var OutRef = iframeDocumentObject.getElementById("OutRef");
                                            // если оптата прошла успешно (в окне оплаты получили ref) - меняем статус файла
                                            if (!utilsService.isEmpty(OutRef) && OutRef.value) {
                                                //todo: fix 'stateId: 6'
                                                bars.ui.loader("body", true);
                                                $http.post(bars.config.urlContent('/api/Mcp/Mcp/SetFileState'), {id: row.ID, stateId: 6})
                                                    .success(function (response) {
                                                        win.close();
                                                        bars.ui.loader("body", false);
                                                        grid.dataSource.read();
                                                        bars.ui.notify("До відома", "Платіж " + row.ID + " успішно створено",
                                                            "info", {autoHideAfter: 5*1000});
                                                    }).error(function (response) {
                                                        bars.ui.loader("body", false);
                                                });
                                            }
                                            else {
                                                bars.ui.confirm({ text: 'Документ не оплачено, закрити вікно ?' },
                                                    function () { win.close(); });
                                            }
                                        }
                                    }]
                                });
                                $(".k-widget").find(".k-window-action").css("visibility", "hidden");
                            }
                        }
                        //grid.dataSource.read();
                        //$scope.resultMulty(response, "Запити залишків РУ виконано успішно");
                    }).error(function (response) {

                });
                break;

            case 'getBalanceRu':
                data = [];
                checkedArr = [];
                $(selectedRows).each(function (i, el) { checkedArr.push(grid.dataItem(el)) });
                //checkedArr = [row];
                //checkedArr = kendoService.findCheckedGrid(grid);
                for(i = 0; i < checkedArr.length; i++){
                    data.push({ id: checkedArr[i].ID, accNum2560: checkedArr[i].ACC_NUM_2560, receiverMfo: checkedArr[i].RECEIVER_MFO});
                }
                bars.ui.loader("body", true);
                $http.post(bars.config.urlContent('/api/Mcp/Mcp/BalanceRu'), data)
                    .success(function (response) {
                        bars.ui.loader("body", false);
                        // $scope.filesGridAll = false;
                        // angular.element(".chkFormolsAllFiles").prop("checked", $scope.filesGridAll);
                        grid.dataSource.read();

                        $scope.resultMulty(response, "Запити залишків РУ виконано успішно");

                    }).error(function (response) {
                        bars.ui.loader("body", false);
                });
                break;
        }
    };

    $scope.infoLinesStates = [];
    $http.get(bars.config.urlContent('/api/Mcp/Mcp/InfoLineStates'))
        .success(function (response) {
            $scope.infoLinesStates = response;
        }).error(function (response) {
    });
    $scope.getStateLine = function (STATE_ID) {
        return kendoService.findElInArray($scope.infoLinesStates, 'ID', 'NAME', STATE_ID);
    };

    $scope.infoLinesBlockTypes = [];
    $http.get(bars.config.urlContent('/api/Mcp/Mcp/BlockTypes'))
        .success(function (response) {
            $scope.infoLinesBlockTypes = response;
        }).error(function (response) {
    });
    $scope.getBlockType = function (STATE_ID) {
        return kendoService.findElInArray($scope.infoLinesBlockTypes, 'ID', 'NAME', STATE_ID);
    };

    $scope.stateRegisterDS = {
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/api/Mcp/Mcp/FileStates")
            }
        }
    };

    $scope.stateRegisterOptions = {
        filter: "contains",
        dataSource: $scope.stateRegisterDS,
        dataTextField: "NAME",
        dataValueField: "ID",
        optionLabel: " ",
        change: function (e) {
            var v = this.value();
            if(v === ""){ v = null;}
            $scope.filterModel.StateRegister = v;
            $scope.$apply();
        }
    };

    var filesDataSource = $scope.createDataSource({
            type: "webapi",
            transport: { read: { url: bars.config.urlContent("/api/Mcp/Mcp/SearchFiles"),
                data: function () { return $scope.filterModel; }
            }
            },
            pageSize: 10,
            schema: {
                //data: "Data",
                //total: "Total",
                model: {
                    fields: {
                        ID: { type: 'number' },
                        FILE_PATH: { type: 'string' },
                        PAYMENT_TYPE: { type: 'string' },
                        FILE_NAME: { type: 'string' },
                        COUNT_TO_PAY: { type: 'number' },
                        SUM_TO_PAY: { type: 'number' },
                        BALANCE_2909: { type: 'number' },
                        BALANCE_2560: { type: 'number' },
                        LAST_BALANCE_REQ: { type: 'date' },
                        FACT_PAYMENT_DATE: { type: 'date' },
                        FACT_PAYMENT_SUM: { type: 'string' },
                        RETURN_PAYMENT_SUM: { type: 'string' },
                        FILE_BANK_NUM: { type: 'string' },
                        FILE_FILIA_NUM: { type: 'string' },
                        FILE_PAY_DAY: { type: 'string' },
                        FILE_SEPARATOR: { type: 'string' },
                        FILE_UPSZN_CODE: { type: 'string' },
                        HEADER_LENGHT: { type: 'number' },
                        FILE_DATE: { type: 'string' },
                        FILE_DATETIME: { type: 'date' },
                        REC_COUNT: { type: 'number' },
                        PAYER_MFO: { type: 'number' },
                        PAYER_ACC: { type: 'number' },
                        RECEIVER_MFO: { type: 'number' },
                        RECEIVER_ACC: { type: 'number' },
                        ACC_NUM_2560: { type: 'string' },
                        DEBIT_KREDIT: { type: 'string' },
                        PAY_SUM: { type: 'number' },
                        PAY_TYPE: { type: 'number' },
                        PAY_OPER_NUM: { type: 'string' },
                        ATTACH_FLAG: { type: 'string' },
                        PAYER_NAME: { type: 'string' },
                        RECEIVER_NAME: { type: 'string' },
                        PAYMENT_PURPOSE: { type: 'string' },
                        FILIA_NUM: { type: 'number' },
                        DEPOSIT_CODE: { type: 'number' },
                        PROCESS_MODE: { type: 'string' },
                        CHECKSUM: { type: 'string' },
                        STATE_ID: { type: 'number' },
                        STATE_CODE: { type: 'string' },
                        STATE_NAME: { type: 'string' },
                        ENVELOPE_FILE_ID: { type: 'number' },
                        ENVELOPE_STATE_ID: { type: 'number' },
                        ENVELOPE_STATE_NAME: { type: 'string' },
                        ENVELOPE_FILE_NAME: { type: 'string' },
                        ENVELOPE_FILE_STATE: { type: 'number' },
                        ENVELOPE_COMMENT: { type: 'string' }
                    }
                }
            }
        });

    $scope.filesGridOptions = $scope.createGridOptions({
        dataSource: filesDataSource,
        selectable: 'multiple, row',
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: filesGridToolbar,
        change: function () {
            $timeout(function(){ $scope.$apply(); }, 200);            
        },
        columns: [
            // {
            //     field: "block",
            //     title: "",
            //     filterable: false,
            //     sortable: false,
            //     template: "<input type='checkbox' class='chkFormols' ng-click='onClick($event)' />",
            //     headerTemplate: "<input type='checkbox' class='chkFormolsAllFiles' ng-click='checkAllFiles(this)' title='Всі'/>",
            //     width: "30px"
            // },
            {
                field: "ENVELOPE_FILE_NAME",
                title: "Назва архіву",
                width: "340px"
            },
            {
                field: "ENVELOPE_FILE_ID",
                title: "ID конверту<br>(BARS)",
                width: "115px"
            },
            {
                field: "ID",
                title: "ID<br>реєстру",
                width: "90px"
            },
            {
                field: "PAYMENT_TYPE",
                title: "Тип<br>виплати",
                width: "120px"
            },            
            {
                field: "RECEIVER_MFO",
                title: "МФО",
                width: "90px"
            },
            {
                field: "PAYER_NAME",
                title: "Назва<br>платника",
                width: "120px"
            },
            {
                field: "RECEIVER_ACC",
                title: "Рах.<br>отримувача",
                width: "120px"
            },
            {
                field: "FILE_NAME",
                title: "Назва файлу<br> реєстру",
                width: "120px"
            },
            {
                field: "FILE_DATE",
                title: "Дата<br>створення",
                width: "120px"
            },
            {
                field: "REC_COUNT",
                title: "Кіль-сть<br>рядків<br>у реєстрі",
                width: "120px"
            },
            {
                field: "COUNT_TO_PAY",
                title: "Кількість рядків<br>до сплати",
                width: "120px"
            },
            {
                field: "PAY_SUM",
                title: "Сума<br>реєстру",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "SUM_TO_PAY",
                title: "Сума <br>до сплати",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "BALANCE_2909",
                title: "Залишок коштів<br>РУ на 2909",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "BALANCE_2560",
                title: "Залишок коштів<br>РУ на 2560",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "LAST_BALANCE_REQ",
                title: "Дата/час<br>останнього<br>запиту залишку",
                width: "100px",
                format: "{0:dd.MM.yyyy HH:mm}"
            },
            {
                field: "FACT_PAYMENT_DATE",
                title: "Дата/час<br>фактичної оплати",
                width: "100px",
                format: "{0:dd.MM.yyyy HH:mm}"
            },
            {
                field: "FACT_PAYMENT_SUM",
                title: "Сума фактичного<br>зарахування на<br>рахунки пенсіонерів",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "RETURN_PAYMENT_SUM",
                title: "Сума фактичного<br>повернення",
                width: "120px",
                attributes: { "class": "money" }
            },
            {
                field: "STATE_ID",
                title: "ID статусу<br>реєстру",
                width: "120px"
            },
            {
                field: "STATE_NAME",
                title: "Статус<br>реєстру",
                width: "120px"
            },
            {
                field: "ENVELOPE_STATE_NAME",
                title: "Статус<br>конверту",
                width: "120px"
            }
        ]
        });

    var infoLinesDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/Mcp/SearchInfoLines"),
            data: function () { return { FileId: $scope.filesGridInfo('ID') }; } } },

        schema: {
            model: {
                fields: {
                    ID: { type: 'number' },
                    FILE_ID: { type: 'number' },
                    DEPOSIT_ACC: { type: 'number' },
                    FILIA_NUM: { type: 'number' },
                    DEPOSIT_CODE: { type: 'number' },
                    PAY_SUM: { type: 'number' },
                    FULL_NAME: { type: 'string' },
                    NUMIDENT: { type: 'string' },
                    FACT_PAY_DATE: { type: 'date' },
                    DISPLACED: { type: 'string' },
                    STATE_ID: { type: 'number' },
                    STATE_NAME: { type: 'string' },
                    BLOCK_TYPE_ID: { type: 'number' },
                    BLOCK_COMMENT: { type: 'string' },
                    ENVELOPE_FILE_ID: { type: 'number' }
                }
            }
        }
    });

    $scope.infoLinesGridOptions = $scope.createGridOptions({
        toolbar: infoLinesGridToolbar,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        dataSource: infoLinesDataSource,
        height: 400,
        change: function () {
            $scope.$apply();
        },
        columns: [
            {
                field: "block",
                title: "",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='chkFormols' ng-click='onClick($event)' />",
                headerTemplate: "<input type='checkbox' class='chkFormolsAll' ng-click='checkAll(this)' title='Всі'/>",
                width: "3%"
            },
            {
                field: "ID",
                title: "ID рядка",
                width: "7%"
            },
            {
                field: "DEPOSIT_ACC",
                title: "Номер<br>рахунку",
                width: "10%"
            },
            {
                field: "FILIA_NUM",
                title: "Код МФО",
                width: "7%"
            },
            {
                field: "PAY_SUM",
                title: "Сума",
                width: "7%",
                template: '#=kendo.toString( (PAY_SUM/100).toFixed(2),"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            {
                field: "FULL_NAME",
                title: "ПІБ отримувача",
                width: "15%"
            },
            {
                field: "NUMIDENT",
                title: "ІПН",
                width: "9%"
            },
            {
                field: "FACT_PAY_DATE",
                title: "Дата<br>зарахування",
                width: "7%",
                format: "{0:dd.MM.yyyy HH:mm}"
            },
            {
                field: "STATE_ID",
                title: "Статус",
                width: "6%"
                //template: "{{ getStateLine(dataItem.STATE_ID) }}"
            },
            {
                field: "STATE_NAME",
                title: "Опис<br>помилки",
                width: "20%"
            }
        ]

    });

    $scope.tabStripOptions = {
        animation: false,
        select: function () {
            var tabstrip = this;
            var curTabIndex = tabstrip.select().index();

            if(curTabIndex === 0 && $scope.filesGridInfo('ID') !== null){
                //$scope.$apply();
                $scope.infoLinesGrid.dataSource.read();
            }
        }
    };

    var _getGridValue = function (grid, fieldId) {
        var row = grid.dataItem(grid.select());
        return row !== null ? row[fieldId] : null;
    };

    $scope.filesGridInfo = function (fieldId) {
        var grid = $scope.filesGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.Search = function () {
        if(!utilsService.isEmptyAll($scope.filterModel)){
            $scope.filesGrid.dataSource.read();
        }
        else{
            bars.ui.error({ text: "Дані не заповнено" });
        }
    };

    // check ALL
    $scope.infoLinesGridAll = false;
    //$scope.filesGridAll = false;

    $scope.checkAll = function (e) {
        $scope.infoLinesGridAll = !$scope.infoLinesGridAll;
        var grid = $scope.infoLinesGrid;
        kendoService.setCheckedGrid(grid, $scope.infoLinesGridAll);
    };

    $scope.onClick = function(e){ kendoService.setCheckedElemGrid(e); };

    // $scope.checkAllFiles = function (e) {
    //     $scope.filesGridAll = !$scope.filesGridAll;
    //     var grid = $scope.filesGrid;
    //     kendoService.setCheckedGrid(grid, $scope.filesGridAll);
    // };

    var infoLinesRemoveDataSource = $scope.createDataSource({
        schema: {
            model: {
                fields: {
                    id: { type: "number" },
                    full_name: { type: "string", editable: false },
                    comment: { type: "string", editable: true },
                    block_type: { type: "number", editable: true }
                }
            }
        }
    });
    $scope.infoLinesRemoveGridOptions = $scope.createGridOptions({
        dataSource: infoLinesRemoveDataSource,
        editable: true,
        resizable: true,
        columns: [
            {
                field: "full_name",
                title: "ПІБ Клієнта",
                width: 220,
                attributes: {
                    style: "text-overflow: ellipsis; white-space: nowrap;"
                }
            },
            {
                field: "comment",
                title: "Коментар"
            },
            {
                field: "block_type",
                title: "Тип блокування",
                template: "{{ getBlockType(dataItem.block_type) }}",
                editor: function (container, options) {
                    $('<input required  name="' + options.field + '"/>')
                        .appendTo(container)
                        .kendoDropDownList({
                            dataTextField: "NAME",
                            dataValueField: "ID",
                            dataSource: { data: $scope.infoLinesBlockTypes }
                        });
                }
            }
        ]
    });
    $scope.isRemoveInfoLines = function () {
        var grid = $scope.infoLinesRemoveGrid;
        var data = grid.dataSource.data();

        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            if(utilsService.isEmpty(item.comment)){
                return true;
            }
        }
        return false;
    };
    $scope.onRemoveInfoLines = function () {
        var grid = $scope.infoLinesRemoveGrid;
        var data = grid.dataSource.data();

        var res = [];
        for (var i = 0; i < data.length; i++) {
            var item = data[i];
            res.push({id: item.id, comment: item.comment, block_type: item.block_type});
        }

        bars.ui.loader("body", true);
        $http.post(bars.config.urlContent('/api/Mcp/Mcp/RemoveFromPay'), res)
            .success(function (response) {
                bars.ui.loader("body", false);
                $scope.infoLinesGridAll = false;
                angular.element(".chkFormolsAll").prop("checked", $scope.infoLinesGridAll);
                $scope.infoLinesGrid.dataSource.read();

                $scope["removeWindow"].close();

                $scope.resultMulty(response, "Записи виключено з платежу успішно");

            }).error(function (response) {
            bars.ui.loader("body", false);
        });
    };

    $scope.alertGridFiles_getBalanceRu = "";
    $scope.alertGridFiles_createPay = "";
    $scope.alertGridFiles_pay = "";
});