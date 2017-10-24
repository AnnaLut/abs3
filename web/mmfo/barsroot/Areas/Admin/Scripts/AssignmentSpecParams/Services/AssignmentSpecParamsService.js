angular.module(globalSettings.modulesAreas)
.factory('assignmentSpecParamsService', ['$http', '$q', function ($http, $q) {

    var serviceUrl = bars.config.urlContent('/api/Admin/AssignmentSpecParams');

    var deleteParameters = function (paramsToDelete) {

        var deferred = $q.defer();

        $http({
            method: 'DELETE',
            url: serviceUrl,
            data: paramsToDelete,
                headers: {'Content-Type': 'application/json;charset=utf-8'}
            })
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var addParameters = function (paramsToAdd) {

        var deferred = $q.defer();

        $http({
            method: 'POST',
            url: serviceUrl,
            data: paramsToAdd,
            headers: { 'Content-Type': 'application/json;charset=utf-8' }
        })
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }

    var updateParemeters = function (paramsToUpdate) {

        var deferred = $q.defer();

        $http({
            method: 'PUT',
            url: serviceUrl,
            data: paramsToUpdate,
            headers: { 'Content-Type': 'application/json;charset=utf-8' }
        })
        .success(function (data) {

            deferred.resolve(data);

        }).error(function (data) {

            deferred.reject(data);
        });
        return deferred.promise;
    }


    return {
        deleteParameters: deleteParameters,
        addParameters: addParameters,
        updateParemeters: updateParemeters
    }

}]);