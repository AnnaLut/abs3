'use strict';

/**
 * @ngdoc service
 * @name LoginService
 * @description Сервіс для роботи з Api
 * @author: dev@unity-bars.com
 * @version: 0.0.1, 2015.08.14
 */

angular.module(globalSettings.modulesAreas)
    .factory('accountService',
        ['$http', '$q',
        function($http, $q) {

            var apiUrl = bars.config.urlContent('/securety/login/');

            var data = [];

            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };

            var factory = {};

            var login = function (login, password) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(apiUrl, {
                    /*headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },*/
                    params: {login: login, password: password}
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

            factory.login = login;

            factory.state = state;
            factory.data = data;

            return factory;
        }
    ]);