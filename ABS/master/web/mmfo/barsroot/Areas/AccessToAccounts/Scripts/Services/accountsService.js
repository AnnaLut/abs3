angular.module('BarsWeb.Controllers')
.factory('accountsService', ['$http', '$q', function ($http, $q) {

    var config = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        }
    };

    var changeLeftUser = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            AccountID: model.AccountID,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccounts/ChangeLeftUser');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var changeRightUser = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            AccountID: model.AccountID,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccounts/ChangeRightUser');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    return {
        changeLeftUser: changeLeftUser,
        changeRightUser: changeRightUser
    }


}])