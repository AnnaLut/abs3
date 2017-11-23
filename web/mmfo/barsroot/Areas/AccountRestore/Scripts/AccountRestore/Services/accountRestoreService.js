angular.module("BarsWeb.Controllers").factory('accountRestoreService', ['$http', '$q', function ($http, $q) {

    var _loadAccount = function (model) {
        var deferred = $q.defer();
        var request = {
            method: 'GET',
            url: bars.config.urlContent("/api/AccountRestore/AccountRestore/account?Nls=" + model.in_acc + "&Kv=" + model.KV),
        }

        $http(request).success(function (response) {
            deferred.resolve(response);
        }).error(function (error) {
            deferred.reject(error);
        })

        return deferred.promise;
    };

    var _restore = function (in_acc) {

        var deferred = $q.defer();

        var _url = bars.config.urlContent("/api/AccountRestore/AccountRestore/Restore?acc=" + in_acc);

        var request = {
            method: 'POST',
            url: bars.config.urlContent("/api/AccountRestore/AccountRestore/Restore?acc=" + in_acc),
        } 

        $http(request).success(function (response) {
            deferred.resolve(response);
        }).error(function (error) {
            deferred.reject(error);
        })

        return deferred.promise;
    };

    return {
        loadAccount: _loadAccount,
        restore: _restore
    };
}])