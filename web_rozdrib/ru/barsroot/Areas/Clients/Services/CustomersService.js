'use strict';

/**
 * @ngdoc service
 * @name CustomersService
 * @description Сервіс для роботи з Api
 * @author: dev@unity-bars.com
 * @version: 0.0.1, 2015.08.14
 */

angular.module(globalSettings.modulesAreas)
    .factory('customersService',
        ['$http', '$q',
        function($http, $q) {

            var apiUrl = bars.config.urlContent('/api/v1/clients/customers/');

            var data = [];

            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };

            var factory = {};

            var getCustomer = function (id) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(apiUrl, {
                    /*headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },*/
                    params: {id: id}
                }).success(function (response) {
                    
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;

                    deferred.resolve(data);
                }).error(function(err, status, headers, config) {
                    state.isLoading = false;
                    console.log(err);

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var closeCustomer = function(id) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl,
                    method: 'DELETE',
                    /*headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },*/
                    params: { id: id }
                }).success(function (response) {

                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;

                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;
                    console.log(err);

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var restoreCustomer = function(id) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'restore/',
                    method: 'POST',
                    params: { id: id }
                }).success(function (response) {
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;

                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;
                    console.log(err);

                    deferred.reject(err);
                });

                return deferred.promise;
            }
            var registerCustomer = function() { }

            factory.getCustomer = getCustomer;
            factory.closeCustomer = closeCustomer;
            factory.restoreCustomer = restoreCustomer;
            factory.registerCustomer = registerCustomer;
            factory.state = state;
            factory.data = data;

            return factory;
        }
    ]);