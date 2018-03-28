/**
 * Created by serhii.karchavets on 22-Dec-17.
 */

var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("McpPayAcceptCtrl", function ($controller, $scope, $http, kendoService, 
    utilsService, signService) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    //var Token_Id = 'iit';
    var KVIT_1 = 1;
    var KVIT_2 = 2;

    $scope.Title = "Підтвердження відправки даних в УПСЗН";

    $scope.kvitId = KVIT_1;

    var filesGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'excel\')" ng-disabled="disabledToolbarGrid(\'files\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Конверти в Excel</a>' },
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'ok\')" ng-disabled="disabledToolbarGrid(\'files\', \'ok\')"><i class="pf-icon pf-16 pf-ok"></i>Виконати відправку</a>' }
    ];
    var filesHistoryGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'filesHistory\', \'excel\')" ng-disabled="disabledToolbarGrid(\'filesHistory\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Відправлені конверти в Excel</a>' },
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'filesHistory\', \'ok\')" ng-disabled="disabledToolbarGrid(\'filesHistory\', \'ok\')"><i class="pf-icon pf-16 pf-ok"></i>Виконати відправку</a>' }
    ];
    var registryGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'registry\', \'excel\')" ng-disabled="disabledToolbarGrid(\'registry\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Реєстри в Excel</a>' }
    ];
    var infoLinesreRistryGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'infoLinesreRistry\', \'excel\')" ng-disabled="disabledToolbarGrid(\'infoLinesreRistry\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Інфо.рядки реєстру в Excel</a>' }
    ];

    var getGrid = function(id){
        var grid = $scope.filesGrid;
        if(id === 'filesHistory'){
            grid = $scope.filesHistoryGrid;
        }
        else if(id === 'registry'){
            grid = $scope.registryGrid;
        }
        else if(id === 'infoLinesreRistry'){
            grid = $scope.infoLinesreRistryGrid;
        }
        return grid;
    };

    $scope.disabledToolbarGrid = function (id, op){
        var grid = getGrid(id);

        switch (op){
            case 'excel':
                return grid._data === undefined ? true : grid._data.length <= 0;

            case 'ok':
                return kendoService.findCheckedGrid(grid).length === 0;
        }
        return false;
    };

    $scope.onClickToolbarGrid = function (id, op) {
        var grid = getGrid(id);

        switch (op){
            case 'excel':
                grid.saveAsExcel();
                break;

            case 'ok':
                var checkedArr = kendoService.findCheckedGrid(grid);
                var data = [];
                for(i = 0; i < checkedArr.length; i++){
                    data.push({id: checkedArr[i].ID, kvitId: $scope.kvitId});
                }
                bars.ui.loader("body", true);
                $http.post(bars.config.urlContent('/api/Mcp/PayAcceptApi/Send'), data)
                    .success(function (response) {
                        bars.ui.loader("body", false);
                        // $scope.filesGridAll = false;
                        // angular.element(".chkFormolsAllFiles").prop("checked", $scope.filesGridAll);
                        grid.dataSource.read();

                        $scope.resultMulty(response, "Відправку виконано успішно");

                    }).error(function (response) {
                    bars.ui.loader("body", false);
                });


                // signService.Init(Token_Id, Token_Id, function(){
                //     signService.GetKeys(Token_Id, Token_Id, function(keysArray){
                //         var signId = keysArray[0].Id;
                //         var count = checkedArr.length;
                //         var finalized = [];
                //         function checkFinalize(ID, Error){
                //             finalized.push({id: ID, error: Error});

                //             if(finalized.length === count){                                
                //                 var err = {Errors: []};
                //                 for(var j = 0; j < count; j++){
                //                     if(finalized[j].error !== null){
                //                         err.Errors.push(finalized[j].id + " : " + finalized[j].error);
                //                     }
                //                 }
                //                 $scope.filesGridAll = false;
                //                 angular.element(".chkFormolsAll").prop("checked", $scope.filesGridAll);
                //                 $scope.infoLinesGridAll = false;
                //                 angular.element(".chkFormolsAllHistory").prop("checked", $scope.infoLinesGridAll);

                //                 grid.dataSource.read();
                //                 $scope.resultMulty(err, "Всі дані успішно оброблено");
                //             }
                //         }
                        
                //         for(var i = 0; i < count; i++){ 
                //             var ID = checkedArr[i].ID;
                //             $http.post(bars.config.urlContent('/api/Mcp/PayAcceptApi/GetBuffer'), {id: ID, kvitId: $scope.kvitId, type: 1, sign: ""})
                //                 .success(function (response) {
                //                     //var buffer = "74657374";
                //                     var buffer = JSON.parse(response);
                //                     if(utilsService.isEmpty(buffer)){
                //                         checkFinalize(ID, "Помилка створення буферу");
                //                     }
                //                     else{
                //                         signService.Sign(Token_Id, signId, buffer, function(sign){
                //                         $http.post(bars.config.urlContent('/api/Mcp/PayAcceptApi/SaveSign'), {id: ID, kvitId: $scope.kvitId, type: 1, sign: sign})
                //                         .success(function (_r) {
                //                             checkFinalize(ID, null);
                //                         }).error(function (error0) {
                //                             checkFinalize(ID, error0);
                //                         });
                //                         }, function(error1){
                //                             checkFinalize(ID, error1);
                //                         });
                //                     }                                    
                //                 }).error(function (error2) {
                //                     checkFinalize(ID, error2);
                //                 });
                //         }
                //     }, function(error){
                //         bars.ui.error({ text: error });
                //     });
                // }, function(error){
                //     bars.ui.error({ text: error });
                // });
                break;
        }
    };

    $scope.kvitTypeOptions = {
        dataSource: [
            {ID: KVIT_1, NAME: "Квит №1"},
            {ID: KVIT_2, NAME: "Квит №2"}
        ],
        dataTextField: "NAME",
        dataValueField: "ID",
        change: function (e) {
            $scope.kvitId = this.value();
            $scope.filesGrid.dataSource.read();
            $scope.filesHistoryGrid.dataSource.read();
            $scope.registryGrid.dataSource.read();
            $scope.infoLinesreRistryGrid.dataSource.read();
        }
    };

    var filesDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/PayAcceptApi/SearchPayAccept"),
            data: function () { return {kvitId: $scope.kvitId}; }} },
        schema: {
            model: {
                fields: {
                    ID: { type: 'number' },
                    ID_MSP_ENV: { type: 'number' },
                    CODE: { type: 'string' },
                    SENDER: { type: 'string' },
                    RECIPIENT: { type: 'string' },
                    PARTNUMBER: { type: 'number' },
                    PARTTOTAL: { type: 'number' },
                    COMM: { type: 'string' },
                    CREATE_DATE: { type: 'date' },
                    TOTAL_SUM: { type: 'string' },
                    TOTAL_SUM_TO_PAY: { type: 'string' },
                    STATE_ID: { type: 'number' },
                    STATE_NAME: { type: 'string' },
                    STATE_CODE: { type: 'string' }
                }
            }
        }
    });

    $scope.filesGridOptions = $scope.createGridOptions({
        dataSource: filesDataSource,
        height: 230,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: filesGridToolbar,
        change: function () {
            $scope.registryGrid.dataSource.read();
        },
        // dataBound: function () {
        //     $scope.registryGrid.dataSource.read();
        // },
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
                title: "ID конверту<br>(BARS)",
                width: "10%"
            },
            {
                field: "ID_MSP_ENV",
                title: "ID конверту<br>(УПСЗН)",
                width: "10%"
            },
            {
                field: "PARTNUMBER",
                title: "Кількість<br>реєстрів",
                width: "10%"
            },
            {
                template: "<div style='text-align:center;'>#=(CREATE_DATE == null) ? ' ' : kendo.toString(CREATE_DATE,'dd.MM.yyyy')#</div>",
                field: "CREATE_DATE",
                title: "Дата створення",
                width: "10%"
            },
            {
                field: "TOTAL_SUM",
                title: "Загальна сума",
                width: "10%"
            },
            {
                field: "TOTAL_SUM_TO_PAY",
                title: "Загальна сума<br>на зарахування",
                width: "10%"
            },
            {
                field: "STATE_ID",
                title: "Стутус ID",
                width: "10%"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: "20%"
            }
        ]
    });

    var filesHistoryDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/PayAcceptApi/SearchEnvelopes"),
            data: function () { return {kvitId: $scope.kvitId}; }} },
        schema: {
            model: {
                fields: {
                    ID: { type: 'number' },
                    ID_MSP_ENV: { type: 'number' },
                    CODE: { type: 'string' },
                    SENDER: { type: 'string' },
                    RECIPIENT: { type: 'string' },
                    PARTNUMBER: { type: 'number' },
                    PARTTOTAL: { type: 'number' },
                    COMM: { type: 'string' },
                    CREATE_DATE: { type: 'date' },
                    TOTAL_SUM: { type: 'string' },
                    TOTAL_SUM_TO_PAY: { type: 'string' },
                    STATE_ID: { type: 'number' },
                    STATE_NAME: { type: 'string' },
                    STATE_CODE: { type: 'string' }
                }
            }
        }
    });

    $scope.filesHistoryGridOptions = $scope.createGridOptions({
        dataSource: filesHistoryDataSource,
        height: 230,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: filesHistoryGridToolbar,
        change: function () {
            $scope.registryGrid.dataSource.read();
        },
        // dataBound: function () {
        //     $scope.registryGrid.dataSource.read();
        // },
        columns: [
            {
                field: "block",
                title: "",
                filterable: false,
                sortable: false,
                template: "<input type='checkbox' class='chkFormols' ng-click='onClick($event)' />",
                headerTemplate: "<input type='checkbox' class='chkFormolsAllHistory' ng-click='checkAllHistory(this)' title='Всі'/>",
                width: "3%"
            },
            {
                field: "ID",
                title: "ID конверту<br>(BARS)",
                width: "10%"
            },
            {
                field: "ID_MSP_ENV",
                title: "ID конверту<br>(УПСЗН)",
                width: "10%"
            },
            {
                field: "PARTNUMBER",
                title: "Кількість<br>реєстрів",
                width: "10%"
            },
            {
                template: "<div style='text-align:center;'>#=(CREATE_DATE == null) ? ' ' : kendo.toString(CREATE_DATE,'dd.MM.yyyy')#</div>",
                field: "CREATE_DATE",
                title: "Дата створення",
                width: "10%"
            },
            {
                field: "TOTAL_SUM",
                title: "Загальна сума",
                width: "10%"
            },
            {
                field: "TOTAL_SUM_TO_PAY",
                title: "Загальна сума<br>на зарахування",
                width: "10%"
            },
            {
                field: "STATE_ID",
                title: "Стутус ID",
                width: "10%"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: "10%"
            }
        ]
    });

    var registryGridDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/PayAcceptApi/SearchFileForMatch"),
            data: function () {
                var curTabIndex = $scope.tabStrip.select().index();

                var envelopeFileId = null;
                if(curTabIndex === 0){
                    envelopeFileId = $scope.filesGridInfo("ID");
                }
                else{
                    envelopeFileId = $scope.filesHistoryGridInfo("ID");
                }
                return {envelopeFileId: envelopeFileId};
        }
        } },
        schema: {
            model: {
                fields: {
					ID: { type: 'number' },
					PAYMENT_TYPE: { type: 'string' },
					FILE_PATH: { type: 'string' },
					FILE_NAME: { type: 'string' },
					FILE_BANK_NUM: { type: 'string' },
					FILE_FILIA_NUM: { type: 'string' },
					FILE_PAY_DAY: { type: 'string' },
					FILE_SEPARATOR: { type: 'string' },
					FILE_UPSZN_CODE: { type: 'string' },
					HEADER_LENGHT: { type: 'number' },
					FILE_DATE: { type: 'string' },
					REC_COUNT: { type: 'number' },
					PAYER_MFO: { type: 'number' },
					PAYER_ACC: { type: 'number' },
					RECEIVER_MFO: { type: 'number' },
					RECEIVER_ACC: { type: 'number' },
					DEBIT_KREDIT: { type: 'string' },
					PAY_SUM: { type: 'number' },
					SUM_TO_PAY: { type: 'number' },
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
					ENVELOPE_FILE_NAME: { type: 'string' },
					ENVELOPE_FILE_STATE: { type: 'number' },
					ENVELOPE_COMMENT: { type: 'string' }
                }
            }
        }
    });

    $scope.registryGridOptions = $scope.createGridOptions({
        dataSource: registryGridDataSource,
        height: 230,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: registryGridToolbar,
        columns: [
            {
                field: "ID",
                title: "ID<br>реєстру",
                width: "10%"
            },
            {
                field: "FILE_NAME",
                title: "Назва файлу<br>реєстру",
                width: "10%"
            },
            {
                field: "FILE_DATE",
                title: "Дата<br>створення",
                width: "10%"
            },
            {
                field: "REC_COUNT",
                title: "Кількість рядків<br>у реєстрі",
                width: "10%"
            },
            {
                field: "RECEIVER_MFO",
                title: "МФО",
                width: "10%"
            },
            {
                field: "PAY_SUM",
                title: "Сума<br>реєстру",
                width: "10%"
            },
            {
                field: "SUM_TO_PAY",
                title: "Сума<br>дос сплати",
                width: "10%"
            },
            {
                field: "STATE_ID",
                title: "Статус ID",
                width: "10%"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: "10%"
            }
        ]
    });

    var infoLinesreRistryDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/PayAcceptApi/SearchFileRecForMatch"),
            data: function () { return {fileId: $scope.registryGridInfo('ID') }; }} },
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

    $scope.infoLinesreRistryGridOptions = $scope.createGridOptions({
        dataSource: infoLinesreRistryDataSource,
        height: 230,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: infoLinesreRistryGridToolbar,
        columns: [
            {
                field: "ID",
                title: "ID",
                width: "10%"
            },
            {
                field: "PAY_SUM",
                title: "Сума",
                width: "10%"
            },
            {
                field: "FULL_NAME",
                title: "ПІБ<br>отримувача",
                width: "10%"
            },
            {
                field: "NUMIDENT",
                title: "ІПН",
                width: "10%"
            },
            {
                field: "FACT_PAY_DATE",
                title: "Дата<br>зарахування",
                width: "10%",
                format: "{0:dd.MM.yyyy HH:mm}"
            },
            {
                field: "STATE_ID",
                title: "Статус ID",
                width: "10%"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: "25%"
            }
        ]
    });

    var _getGridValue = function (grid, fieldId) {
        var row = grid.dataItem(grid.select());
        return row !== null ? row[fieldId] : null;
    };

    $scope.filesGridInfo = function (fieldId) {
        var grid = $scope.filesGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.registryGridInfo = function (fieldId) {
        var grid = $scope.registryGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.filesHistoryGridInfo = function (fieldId) {
        var grid = $scope.filesHistoryGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.Set2Pay = function () {
        var grid = $scope.filesGrid;
        var checkedArr = kendoService.findCheckedGrid(grid);

        if(checkedArr.length > 0){
            var ids = [];
            for(var i = 0; i < checkedArr.length; i++){ ids.push(checkedArr[i].ID); }
            bars.ui.loader("body", true);
            $http.post(bars.config.urlContent('/api/Mcp/PayAcceptApi/Set2Pay'), ids)
                .success(function (response) {
                    bars.ui.loader("body", false);
                    $scope.filesGridAll = false;
                    angular.element(".chkFormolsAll").prop("checked", $scope.filesGridAll);
                    grid.dataSource.read();

                    $scope.resultMulty(response, "Дані успішно оброблено");
                }).error(function (response) {
                bars.ui.loader("body", false);
            });
        }
        else{
            bars.ui.error({ text: "Дані не відмічено" });
        }
    };

    $scope.tabStripOptions = {
        animation: false,
        select: function () {
            var tabstrip = this;
            var curTabIndex = tabstrip.select().index();

            if(curTabIndex === 0){
                $scope.filesHistoryGrid.dataSource.read();
            }
            else {
                $scope.filesGrid.dataSource.read();
            }
        }
    };

    $scope.registryTabStripOptions = {
        animation: false,
        select: function () {
            var tabstrip = this;
            var curTabIndex = tabstrip.select().index();

            if(curTabIndex === 0 && $scope.registryGridInfo('ID') !== null){
                $scope.infoLinesreRistryGrid.dataSource.read();
            }
        }
    };

    // check ALL
    $scope.infoLinesGridAll = false;
    $scope.filesGridAll = false;

    $scope.checkAll = function (e) {
        $scope.filesGridAll = !$scope.filesGridAll;
        var grid = $scope.filesGrid;
        kendoService.setCheckedGrid(grid, $scope.filesGridAll);
    };

    $scope.checkAllHistory = function(e){
        $scope.infoLinesGridAll = !$scope.infoLinesGridAll;
        var grid = $scope.filesHistoryGrid;
        kendoService.setCheckedGrid(grid, $scope.infoLinesGridAll);
    };

    $scope.onClick = function(e){ kendoService.setCheckedElemGrid(e); };

});