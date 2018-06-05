'use strict';

/**
 * @ngdoc service
 * @name SchemeBuilderService
 * @description Сервіс для роботи зі схемами перекриття
 * @author: sergey.gorobets@unity-bars.com
 * @version: 0.0.1, 2016.07.09
 */

angular.module(globalSettings.modulesAreas)
    .factory('schemeBuilderService',
    ['$http', '$q', 'SchemeBuilderConfig',
        function ($http, $q, config) {

            var apiUrl = bars.config.urlContent(config.baseApiUrl);
            var data = [];

            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };

            var factory = {};

            var getAccount = function (accNum, currId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(apiUrl + 'GetAccount', {
                    params: { accNum: accNum, currId: currId }
                }).success(function (response) {

                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;

                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;
                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var deleteSchemeSideB = function (id) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'deleteSideB',
                    method: 'DELETE',
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

            var deleteSchemeAccount = function (accId) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'deleteSchemeAccount',
                    method: 'DELETE',
                    params: { accId: accId }
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

            var editSchemeAccount = function (model) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'editSchemeAccount',
                    method: 'POST',
                    data: model
                }).success(function (response) {
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;
                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var editSchemeSideB = function (model) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'editSchemeSideB',
                    method: 'POST',
                    data: model
                }).success(function (response) {
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;
                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var batchEditSchemeSideB = function (model) {
                state.isLoading = true;
                var deferred = $q.defer();
                $http({
                    url: apiUrl + 'batchEditSchemeSideB',
                    method: 'POST',
                    data: model
                }).success(function (response) {
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;
                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;

                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var registerCustomer = function () { }

            factory.getAccount = getAccount;
            factory.deleteSchemeSideB = deleteSchemeSideB;
            factory.deleteSchemeAccount = deleteSchemeAccount;

            factory.editSchemeAccount = editSchemeAccount;
            factory.editSchemeSideB = editSchemeSideB;
            factory.batchEditSchemeSideB = batchEditSchemeSideB;

            factory.state = state;
            factory.data = data;

            return factory;
        }
    ]);