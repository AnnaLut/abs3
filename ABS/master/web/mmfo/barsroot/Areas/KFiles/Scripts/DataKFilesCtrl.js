angular.module("BarsWeb.Areas", []).controller("KFiles.DataKFilesCtrl", ["$scope", function ($scope, $element) {
    $scope.Title = 'Перегляд даних';

    var data = angular.element('#dataview').val() == "" ? {} : eval("(" + angular.element('#dataview').val() + ")");

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
        nazn: null
    };
    
    $scope.model.nd = data.ND;
    $scope.model.vidd = data.VOB;
    $scope.model.time = data.T_DOC;
    $scope.model.record = data.ND;
    $scope.model.curr = data.KV;
    $scope.model.operation = data.TT;
    $scope.model.mfopayer = data.MFOA;
    $scope.model.bankpayer = data.NAMBA;
    $scope.model.accountpayer = data.NLSA;
    $scope.model.currpayer = data.KVA;
    $scope.model.edrpoupayer = data.OKPOA;
    $scope.model.namepayer = data.NAMA;
    $scope.model.mforeceiver = data.MFOB;
    $scope.model.bankreceiver = data.NAMBB;
    $scope.model.accountreceiver = data.NLSB;
    $scope.model.currreceiver = data.KVB;
    $scope.model.edrpoureceiver = data.OKPOB;
    $scope.model.namereceiver = data.NAMB;
    $scope.model.sum = data.S;
    $scope.model.sumua = data.SQ;
    $scope.model.nazn = data.NAZN;

}]);