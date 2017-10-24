angular.module('BarsWeb.Controllers')
.factory('changeGroupsService', ['$http', '$q', function ($http, $q) {


    var config = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        }
    };

    var changeUserGroup = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            GroupID: model.GroupID,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsUsers/ChangeUserGroup');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var changeAccountsGroup = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            GroupID: model.GroupID,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsUsers/ChangeAccountsGroup');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    return {
        changeUserGroup: changeUserGroup,
        changeAccountsGroup: changeAccountsGroup
    }
}]);