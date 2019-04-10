var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("depositDemand", function ($controller, $scope, $timeout, $http,
    settingsService, modelService, validationService, saveDataService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    var ts = settingsService.settings().TrancheStates;

    $scope.Title = "Оформлення вкладу на вимогу";

    $scope.depositDemand = modelService.initFormData("depositDemand");

    //todo: get from client card
    $scope.depositDemand.dbo = 12345;
    $scope.depositDemand.dboDate = kendo.toString(kendo.parseDate(new Date()), 'dd.MM.yyyy');
    $scope.depositDemand.clientRnk = 97412501;       // todo:
    $scope.depositDemand.clientOkpo = "0000000000";       // todo:
    $scope.depositDemand.clientName = "Іванов Іван Іванович";       // todo:

    $scope.toolbarDepositDemandOptions = { items: settingsService.settings().toolbars.depositDemandOptions.items };

    $scope.onClickDisabled = function (formId, op) {
        return $scope.onClickDisabledBase(formId, op);
    };
});
