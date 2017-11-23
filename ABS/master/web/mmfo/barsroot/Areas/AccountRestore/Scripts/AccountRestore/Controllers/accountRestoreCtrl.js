angular.module("BarsWeb.Controllers").controller("AccountRestore.acccountRestoreCtrl", ["$scope", "$http", "$location", "$rootScope", "accountRestoreService", function ($scope, $http, $location, $rootScope, accountRestoreService) {

    var vm = this;
    vm.title = "Header";
    vm.in_currency = 980;                                                                               //UAH is defautl currency

    function ParseDateToStringFormatDMY(date) {
        var day = date.getDate();
        day = day < 10 ? '0' + day : day;
        var month = (date.getMonth()) + 1;
        month = month < 10 ? '0' + month : month;
        return day + '/' + month + '/' + date.getFullYear();
    }

    vm.currencyDropDownOptions = {
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent("/api/AccountRestore/AccountRestore/currency"),
                    type: 'GET',
                    dataType: 'json',
                    cache: false
                }
            }
        },
        dataTextField: 'NAME',
        dataValueField: 'KV',
        valuePrimitive: true,
        autoBind: true,
        filter: 'contains'
    }

    vm.loadAccountGrid = function () {
        accountRestoreService.loadAccount({ in_acc: vm.in_acc, KV: vm.in_currency }).then(
            function (data) {
                vm.acc = data.ACC;
                vm.nls = data.NLS;
                vm.kv = data.KV;
                vm.nms = data.NMS;
                vm.daos = ParseDateToStringFormatDMY(kendo.parseDate(data.DAOS, 'dd/MM/yyyy'));
                vm.dazs = ParseDateToStringFormatDMY(kendo.parseDate(data.DAZS, 'dd/MM/yyyy'));
            }
        );
    }

    vm.restoreAccount = function () {
        accountRestoreService.restore(vm.acc).then(
            function (data) {
                bars.ui.alert({ text: "Рахунок реанімований" });
            }
        )
    }
}]);