/**
 * Created by serhii.karchavets on 19-Dec-17.
 */

var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("McpErrorCtrl", function ($controller, $scope, $http, kendoService, utilsService) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    $scope.Title = "Перегляд інформаійних рядків з помилками УПСЗН";

    $scope.filterModel = {
        KF_BANK: null,
        FILE_ID: null,
        STATE_ID: null
    };

    var filesGridToolbar = [
        { template: '<a class="k-button" ng-click="onClickToolbarGrid(\'files\', \'excel\')" ng-disabled="disabledToolbarGrid(\'files\', \'excel\')"><i class="pf-icon pf-16 pf-exel"></i>Файли в Excel</a>' }
    ];

    $scope.disabledToolbarGrid = function (id, op){
        var grid = $scope.filesGrid;

        switch (op){
            case 'excel':
                return grid._data === undefined ? true : grid._data.length <= 0;
        }
        return false;
    };

    $scope.onClickToolbarGrid = function (id, op) {
        var grid = $scope.filesGrid;

        switch (op){
            case 'excel':
                grid.saveAsExcel();
                break;
        }
    };

    $scope.stateRegisterDS = {
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/api/Mcp/Mcp/InfoLineStates")
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
            $scope.filterModel.STATE_ID = v;
        }
    };

    var filesDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Mcp/ErrorsRecordsApi/SearchFileRecordsErr"),
            data: function () { return $scope.filterModel; }} },
        schema: {
            model: {
                fields: {
                    ID: { type: 'number' },
                    FILE_ID: { type: 'number' },
                    CHECK_DATE: { type: 'string' },
                    BRANCH_CODE: { type: 'string' },
                    DEPOSIT_ACC: { type: 'number' },
                    FILIA_NUM: { type: 'number' },
                    DEPOSIT_CODE: { type: 'number' },
                    PAY_SUM: { type: 'number' },
                    FULL_NAME: { type: 'string' },
                    NUMIDENT: { type: 'string' },
                    PAY_DAY: { type: 'string' },
                    DISPLACED: { type: 'string' },
                    STATE_ID: { type: 'number' },
                    STATE_NAME: { type: 'string' },
                    BLOCK_TYPE_ID: { type: 'number' },
                    BLOCK_COMMENT: { type: 'string' },
                    ENVELOPE_FILE_ID: { type: 'number' },
                    RECEIVER_MFO: { type: 'number' },
                    KF_BANK: { type: 'string' },
                    ACC_BANK: { type: 'string' },
                    NMK_BANK: { type: 'string' },
                    OKPO_BANK: { type: 'string' },
                    RNK: { type: 'number' }
                }
            }
        }
    });

    $scope.filesGridOptions = $scope.createGridOptions({
        dataSource: filesDataSource,
        height: 400,
        excel: $scope.excelGridOptions(),
        excelExport: $scope.excelExport,
        toolbar: filesGridToolbar,
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
                field: "RECEIVER_MFO",
                title: "МФО<br>УПСЗН",
                width: "7%"
            },
            {
                field: "BRANCH_CODE",
                title: "Відділення",
                width: "8%"
            },
            {
                field: "KF_BANK",
                title: "МФО",
                width: "7%"
            },
            {
                field: "ENVELOPE_FILE_ID",
                title: "ID<br>конверту",
                width: "8%"
            },
            {
                field: "FILE_ID",
                title: "ID<br>реєстру",
                width: "8%"
            },
            {
                field: "ID",
                title: "ID<br>інфо.рядка",
                width: "10%"
            },
            {
                field: "DEPOSIT_ACC",
                title: "Рахунок",
                width: "10%"
            },
            {
                field: "ACC_BANK",
                title: "Рах. АБС",
                width: "10%"
            },
            {
                field: "FULL_NAME",
                title: "ПІБ<br>пенсіонера",
                width: "16%"
            },
            {
                field: "NMK_BANK",
                title: "ПІБ<br>пенсіонера АБС",
                width: "10%"
            },
            {
                field: "NUMIDENT",
                title: "ІПН",
                width: "10%"
            },
            {
                field: "OKPO_BANK",
                title: "ІПН АБС",
                width: "10%"
            },
            {
                field: "RNK",
                title: "РНК<br>пенсіонера",
                width: "10%"
            },
            {
                field: "STATE_ID",
                title: "Статус",
                width: "7%"
            },
            {
                field: "STATE_NAME",
                title: "Опис<br>помилки",
                width: "22%"
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

    $scope.Set2Pay = function () {
        var grid = $scope.filesGrid;
        var checkedArr = kendoService.findCheckedGrid(grid);

        if(checkedArr.length > 0){
            var ids = [];
            for(var i = 0; i < checkedArr.length; i++){ ids.push(checkedArr[i].ID); }
            $http.post(bars.config.urlContent('/api/Mcp/ErrorsRecordsApi/Set2Pay'), ids)
                .success(function (response) {
                    $scope.filesGridAll = false;
                    angular.element(".chkFormolsAll").prop("checked", $scope.filesGridAll);
                    grid.dataSource.read();

                    $scope.resultMulty(response, "Дані успішно оброблено");
                }).error(function (response) {

            });
        }
        else{
            bars.ui.error({ text: "Дані не відмічено" });
        }
    };

    $scope.filesGridAll = false;
    $scope.checkAll = function (e) {
        $scope.filesGridAll = !$scope.filesGridAll;
        var grid = $scope.filesGrid;
        kendoService.setCheckedGrid(grid, $scope.filesGridAll);
    };

    $scope.Search = function () {
        if(!utilsService.isEmptyAll($scope.filterModel)){
            $scope.filesGrid.dataSource.read();
        }
        else{
            bars.ui.error({ text: "Дані не заповнено" });
        }
    };

    $scope.onClick = function(e){ kendoService.setCheckedElemGrid(e); };

});