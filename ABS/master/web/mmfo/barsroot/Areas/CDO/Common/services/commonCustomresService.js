
'use strict';
angular.module(globalSettings.modulesAreas)
    .factory('CDO.commonCustomersService',
    ['$http', '$q',
        function ($http, $q) {

            //var _url = bars.config.urlContent('/api/corpLight/relatedCustomers/');
            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };
            var factory = {};

            var _getModuleVersion = function () {
                var deferred = $q.defer();
                $http.get(bars.config.urlContent('/cdo/common/version')).success(function (response) {
                    deferred.resolve(response);
                }).error(function (response) {
                    deferred.reject(response);
                });
                return deferred.promise;
            }
            var _getCustomerRelatedCustomers = function (custId) {
                var deferred = $q.defer();

                $http.get(bars.config.urlContent('/api/cdo/common/GetCustomerRelatedCustomers/' + custId))
                    .success(function (response) {
                        deferred.resolve(response);
                    }).error(function (response) {
                        deferred.reject(response);
                    });
                return deferred.promise;
            } 
            var _getFOPData = function (custId) {
                var deferred = $q.defer();

                $http.get(bars.config.urlContent('/api/cdo/common/customers/getfopdata/' + custId))
                    .success(function (response) {
                        deferred.resolve(response);
                    }).error(function (response) {
                        deferred.reject(response);
                    });
                return deferred.promise;
            }      

            var _getDocsType = function () {
                state.isLoading = true;
                var deferred = $q.defer();
                $http.get(bars.config.urlContent('/api/cdo/common/customers/getdocs')).success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });

                return deferred.promise;
            };

            var _getTypeOfCustomer = function (custId) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http.get(bars.config.urlContent('/api/cdo/common/customers/getTypeOfCustomer/' + custId)).success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });

                return deferred.promise;
            };

            factory.getModuleVersion = _getModuleVersion;
            factory.getCustomerRelatedCustomers = _getCustomerRelatedCustomers;
            factory.getFOPData = _getFOPData;
            factory.getDocsType = _getDocsType;

            factory.getTypeOfCustomer = _getTypeOfCustomer;

            return factory;
        }
]);