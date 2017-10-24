angular.module('BarsWeb.Controllers')
.factory('accGroupsService', ['$http', '$q', function ($http, $q) {

    var config = {
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
        }
    };

    var addAgrp = function (model) {
        debugger;
        var deferred = $q.defer();

        var data = $.param({
            grpId: model.grpId,
            acc: model.IssuedAcc
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccGroups/addAgrp');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var delAgrp = function (model) {

        var deferred = $q.defer();

        var data = $.param({
            grpId: model.grpId,
            acc: model.IssuedAcc
        });

        var url = bars.config.urlContent('/AccessToAccounts/AccGroups/delAgrp');

        $http.post(url, data, config)
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    return {

        addAgrp: addAgrp,
        delAgrp: delAgrp
    }
}])