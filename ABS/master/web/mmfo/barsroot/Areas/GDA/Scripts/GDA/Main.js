var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("GDACtrl", function ($controller, $scope, $timeout, $http,
                                        saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    //$scope.placementTranche.nd = bars.extension.getParamFromUrl('nd');
    $scope.nd = 12345;
    $scope.dateNd = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');

    $scope.isShowClosedTranches = false;
    $scope.Title = "Генеральний депозитний договір";
    $scope.placementTranche = modelService.initFormData("placementTranche");
    $scope.replacementTranche = modelService.initFormData("replacementTranche");
    $scope.earlyRepaymentTranche = modelService.initFormData("earlyRepaymentTranche");

    $scope.toolbarMainOptions = { items: settingsService.settings().toolbars.MainOptions.items };
    $scope.toolbarPlacementTrancheOptions = { items: settingsService.settings().toolbars.PlacementTrancheOptions.items };
    $scope.toolbarReplacementTrancheOptions = { items: settingsService.settings().toolbars.ReplacementTrancheOptions.items };
    $scope.toolbarEarlyReplacementTrancheOptions = { items: settingsService.settings().toolbars.EarlyReplacementTrancheOptions.items };

    $scope.onClickMain = function (formId) {
        var trancheId = $scope.curTrancheInfo('TRANCHE_ID');
        if(formId === 'removeTranche'){
            bars.ui.confirm({ text: "Видалити відмічений транш " + trancheId + " ?" }, function () {
                $http.post(bars.config.urlContent("/api/gda/gda/removetranche"), JSON.stringify({
                    Acc: $scope.curAccInfo('Acc'), TrancheId: trancheId
                })).then(function (request) {
                    bars.ui.notify('Транш № ' + trancheId + ' видалено', '', 'success', {autoHideAfter: 5000});
                    $scope.tranchesGrid.dataSource.read();
                    $scope.tranchesGrid.refresh();
                    //bars.ui.loader('body', false);
                }, function (error) {

                });
            });
        }
        else {
            var trancheDate = $scope.curTrancheInfo('start_date');
            var form = settingsService.settings().formWindows[formId];
            var scopeFormId = formId === 'editTranche' ? 'placementTranche' : formId;

            $scope[form].center().open();     //.maximize();
            $scope[form].title(settingsService.settings().getFormTitle(formId, $scope.nd, $scope.dateNd));

            if(formId !== 'editTranche'){
                $scope[scopeFormId] = modelService.initFormData(scopeFormId);
            }
            if(formId === 'placementTranche' || formId === 'editTranche'){
                $scope[scopeFormId].clientRnk = 97412502221;       // todo:
                $scope[scopeFormId].clientOkpo = "0000000000";       // todo:
                $scope[scopeFormId].clientName = "Клієнт RNK=97412501С";       // todo:
            }
            if(formId === 'placementTranche'){
                $scope[scopeFormId].OperatorName = $scope.userInfo.FIO;
                $scope[scopeFormId].OperatorDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');

                $scope[scopeFormId].acc = $scope.curAccInfo('Acc');
                $scope[scopeFormId].currency = $scope.curAccInfo('Kv');
            }
            else{
                $scope[scopeFormId].State = $scope.curTrancheInfo('State');
                $scope[scopeFormId].OperatorName = $scope.curTrancheInfo('OperatorName');
                $scope[scopeFormId].ControllerName = $scope.curTrancheInfo('ControllerName');
                $scope[scopeFormId].OperatorDate = kendo.toString($scope.curTrancheInfo('OperatorDate'), 'dd.MM.yyyy');
                $scope[scopeFormId].ControllerDate = kendo.toString($scope.curTrancheInfo('ControllerDate'), 'dd.MM.yyyy');

                $scope[scopeFormId].kontractPlacement = $scope.curTrancheInfo('Number');
                $scope[scopeFormId].dateKontractPlacement = kendo.toString($scope.curTrancheInfo('DateKontr'), 'dd.MM.yyyy');
                $scope[scopeFormId].acc = $scope.curAccInfo('Acc');
                $scope[scopeFormId].currency = $scope.curAccInfo('Kv');

                if(formId === 'replacementTranche'){
                    $scope[scopeFormId].sumValueMin = 10;       //todo:
                    $scope[scopeFormId].sumValueMax = 100;      //todo:
                    $scope[scopeFormId].sumValue = $scope[scopeFormId].sumValueMin;
                }
                else if(formId === 'earlyRepaymentTranche'){
                    $scope[scopeFormId].sumValue = 1234;        //todo
                    $scope[scopeFormId].period = 24;        //todo
                }
            }
        }
    };

    $scope.onClickDisabledMain = function (op) {
        var trancheState = $scope.curTrancheInfo('Status');

        if(validationService.indexOff(["earlyRepaymentTranche", "editTranche", "replacementTranche"], op) !== -1){
            return trancheState === null;
        }

        var ts = settingsService.settings().TrancheStates;
        var ur = settingsService.settings().UserRoles;

        if(op === "removeTranche"){
            if(trancheState === null || $scope.userInfo.ROLE !== ur.OPERATOR){
                return true;
            }
            return validationService.indexOff([ts.TS_CREATED, ts.TS_EDITING], trancheState) === -1;
        }
        else{   //placementTranche
            return $scope.userInfo.ROLE !== ur.OPERATOR;
        }
    };

    var _getGridValue = function (grid, fieldId) {
        var row = grid.dataItem(grid.select());
        return row !== null ? row[fieldId] : null;
    };

    $scope.curAccInfo = function (fieldId) {
        var grid = $scope.accountsGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.curTrancheInfo = function (fieldId) {
        var grid = $scope.tranchesGrid;
        return _getGridValue(grid, fieldId);
    };

    $scope.placementTrancheWindowOptions = $scope.window({title: 'Розміщення траншу', height: "1024px"});
    $scope.replenishmentTrancheWindowOptions = $scope.window({title: 'Поповнення траншу', height: "480px"});
    $scope.earlyRepaymentTrancheWindowOptions = $scope.window({title: 'Дострокове повернення траншу', height: "980px"});

    var accountsDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/gda/gda/searchaccounts"),
            data: function () { return {nd: $scope.placementTranche.nd}; } } },
        schema: {
            model: {
                fields: {
                    Acc: { type: 'number' },
                    Kv: { type: 'string' },
                    DateOpen: { type: 'date' },
                    Balance: { type: 'number' }
                }
            }
        }
    });
    var tranchesDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/gda/gda/searchtranches"),
            data: function () {
                return { nd: $scope.placementTranche.nd, acc: $scope.curAccInfo('Acc'), isShowClosedTranches: $scope.isShowClosedTranches };
            }
        }
        },
        schema: {
            model: {
                fields: {
                    Number: { type: 'number' },
                    DateKontr: { type: 'date' },
                    DateReturn: { type: 'date' },
                    ReplenishmentTranche: { type: 'number' },
                    SumValue: { type: 'number' },
                    State: { type: 'number' },
                    OperatorDate: { type: 'date' },
                    ControllerDate: { type: 'date' },
                    OperatorId: { type: 'number' },
                    ControllerId: { type: 'number' },
                    OperatorName: { type: 'string' },
                    ControllerName: { type: 'string' }
                }
            }
        }
    });

    $scope.accountsGridOptions = $scope.createGridOptions({
        dataSource: accountsDataSource,
        height: 300,
        columns: [
            {
                field: "Acc",
                title: "Депозитний рахунок",
                width: "10%"
            },
            {
                field: "Kv",
                title: "Валюта",
                width: "10%"
            },
            {
                field: "Balance",
                title: "Залишок коштів",
                width: "10%",
                template: '#=kendo.toString(Balance,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            {
                field: "DateOpen",
                title: "Дата відкриття",
                width: "10%",
                template: "<div style='text-align:center;'>#=(DateOpen == null) ? ' ' : kendo.toString(DateOpen,'dd.MM.yyyy')#</div>"
            }
        ]

    });
    $scope.tranchesGridOptions = $scope.createGridOptions({
        dataSource: tranchesDataSource,
        height: 300,
        change: function () {
            $scope.$apply();
        },
        columns: [
            {
                field: "Number",
                title: "№ заяви <br>про розміщення траншу",
                width: "10%"
            },
            {
                field: "DateKontr",
                title: "Дата заяви <br>про траншу",
                width: "10%",
                template: "<div style='text-align:center;'>#=(DateKontr == null) ? ' ' : kendo.toString(DateKontr,'dd.MM.yyyy')#</div>"
            },
            {
                field: "SumValue",
                title: "Сума",
                width: "10%",
                template: '#=kendo.toString(SumValue,"n")#',
                format: '{0:n}',
                attributes: { "class": "money" }
            },
            {
                field: "ReplenishmentTranche",
                title: "З поповненням",
                width: "10%",
                template: "{{ getReplenishmentTranche(dataItem.ReplenishmentTranche) }}"
            },
            {
                field: "DateReturn",
                title: "Дата повернення",
                width: "10%",
                template: "<div style='text-align:center;'>#=(DateReturn == null) ? ' ' : kendo.toString(DateReturn,'dd.MM.yyyy')#</div>"
            },
            {
                field: "State",
                title: "Статус",
                width: "10%",
                template: "{{ getStateTranche(dataItem.State) }}"
            }
        ]

    });

    $scope.getReplenishmentTranche = function (replenishmentTranche) { return replenishmentTranche ? "Так" : "Ні"; };

    $scope.tabStripOptions = {
        animation: false,
        select: function () {
            var tabstrip = this;
            var curTabIndex = tabstrip.select().index();
            if(curTabIndex === 0 && $scope.curAccInfo('Acc') !== null){
                $scope.$apply();
                $scope.tranchesGrid.dataSource.read();
            }
        }
    };

    $scope.onShowClosedTranches = function () {
        if($scope.curAccInfo('Acc') !== null){ $timeout(function () { $scope.tranchesGrid.dataSource.read(); }, 1000); }
    };
});
