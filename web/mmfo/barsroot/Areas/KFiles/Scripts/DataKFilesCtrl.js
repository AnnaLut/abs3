angular.module("BarsWeb.Areas").controller("kfiles.DataKFilesCtrl", ["$scope", "$http", "$location", "$element", function ($scope, $http, $location, $element) {
    $scope.Title = 'Перегляд даних';
    var localUrl = $location.absUrl();
       
    $scope.model = {
        nd: null,  
        vidd: null,
        time: null,       
        record: null,
        curr: {},
        operation: null,
        mfopayer: null,
        bankpayer: null,
        accountpayer: null,
        currpayer: {},
        edrpoupayer: null,
        namepayer: null,
        mforeceiver: null,
        bankreceiver: null,
        accountreceiver: null,
        currreceiver: {},
        edrpoureceiver: null,
        namereceiver: null,
        sum: null,
        sumua: null,
        sumfull: null
    };

    $scope.model.nd = bars.extension.getParamFromUrl('nd', localUrl);
    $scope.model.vidd = bars.extension.getParamFromUrl('vid', localUrl);
    $scope.model.time = bars.extension.getParamFromUrl('tm', localUrl);
    $scope.model.record = bars.extension.getParamFromUrl('dk', localUrl);
    $scope.model.curr = bars.extension.getParamFromUrl('kv', localUrl);
    $scope.model.operation = bars.extension.getParamFromUrl('tt', localUrl);
    $scope.model.mfopayer = bars.extension.getParamFromUrl('mfoa', localUrl);
    $scope.model.bankpayer = bars.extension.getParamFromUrl('mfonama', localUrl);
    $scope.model.accountpayer = bars.extension.getParamFromUrl('nlsa', localUrl);
    $scope.model.currpayer = bars.extension.getParamFromUrl('kva', localUrl);
    $scope.model.edrpoupayer = bars.extension.getParamFromUrl('okpoa', localUrl);
    $scope.model.namepayer = bars.extension.getParamFromUrl('nama', localUrl);
    $scope.model.mforeceiver = bars.extension.getParamFromUrl('mfob', localUrl);
    $scope.model.bankreceiver = bars.extension.getParamFromUrl('mfonamb', localUrl);
    $scope.model.accountreceiver = bars.extension.getParamFromUrl('nlsb', localUrl);
    $scope.model.currreceiver = bars.extension.getParamFromUrl('okpob', localUrl);
    $scope.model.edrpoureceiver = bars.extension.getParamFromUrl('namb', localUrl);
    $scope.model.namereceiver = bars.extension.getParamFromUrl('sum', localUrl);
    $scope.model.sum = bars.extension.getParamFromUrl('sum', localUrl);
    $scope.model.sumua = bars.extension.getParamFromUrl('sumq', localUrl);
    $scope.model.sumfull = bars.extension.getParamFromUrl('nazn', localUrl);

}]);