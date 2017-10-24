angular.module('BarsWeb.Controllers')
.factory('mainService', ['$http', '$q', function ($http, $q) {


    var config = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        }
    };

    var AddAccountGroup = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            AccID: model.Acc,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/AddAccountGroup');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var AddGroupUsers = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            AccGroupID: model.IDGroupServingAccount,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/AddGroupUsers');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var AddUser = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            UserGroupID: model.IDTheGroup,
            ID: model.ID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/AddUser');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var DeleteGroupAccount = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            IDAcc: model.Acc,
            IDAccGroup: model.IDGroupServingAccount
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/DeleteGroupAccount?' + data);

        $http['delete'](url, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var DeleteGroupUser = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            IDAccGroup: model.IDGroupServingAccount,
            IDUserGroup: model.IDTheGroup
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/DeleteGroupUser?' + data);

        $http['delete'](url, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var DeleteUser = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            IDUserGroup: model.IDTheGroup,
            IDUser: model.UserID
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/DeleteUser?' + data);

        $http['delete'](url, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var UpdateUser = function (checkedIds) {

        var deferred = $q.defer();

        var userUpdateArr = [];
        var updateUser = {};
                   
        for (i in checkedIds) {

            updateUser = {
                GroupID: checkedIds[i].GroupID,
                UserID: checkedIds[i].UserID,
                canView: checkedIds[i].canView,
                canCredit: checkedIds[i].canCredit,
                canDebit: checkedIds[i].canDebit
            };

            userUpdateArr.push(updateUser);
        }

        var url = bars.config.urlContent('/AccessToAccounts/AccessToAccountsMain/UpdateUser');

        $http.put(url, userUpdateArr)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    return {
        AddAccountGroup: AddAccountGroup,
        AddGroupUsers: AddGroupUsers,
        AddUser: AddUser,
        DeleteGroupAccount: DeleteGroupAccount,
        DeleteGroupUser: DeleteGroupUser,
        DeleteUser: DeleteUser,
        UpdateUser: UpdateUser
    }

}]);