angular.module(globalSettings.modulesAreas)
    .factory('clearAddressService',
        ['$http', '$q', function ($http, $q) {

            var apiUrl = bars.config.urlContent('/api/v1/clients/clearAddress/');

            var factory = {};

            var getClearAddress = function (rnk) {

                var deferred = $q.defer();

                $http({
                    url: apiUrl,
                    method: "GET",
                    params: { rnk: rnk }
                }).success(function (response) {

                    deferred.resolve(response);

                }).error(function (err) {

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var saveClearAddress = function (clearAddress) {
                
                var deferred = $q.defer();

                $http.post(apiUrl, clearAddress).success(function (response) {

                    deferred.resolve(response);

                }).error(function (err) {

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            factory.getClearAddress = getClearAddress;
            factory.saveClearAddress = saveClearAddress;

            return factory;


        }]);