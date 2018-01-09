'use strict';

/**
 * @ngdoc service
 * @name searchCustomerService
 * @description Сервіс для пошуку клієнта
 * @author: dev@unity-bars.com
 * @version: 0.0.1, 2015.08.11
 */

angular.module(globalSettings.modulesAreas)
    .factory('searchCustomerService',
        ['$http', '$q',
        function($http, $q) {

            var apiUrl = bars.config.urlContent('/api/v1/clients/customers/');
            var apiCsbUrl = bars.config.urlContent('/api/cdm/CsbSearch/');

            var data = [];

            var state = {
                lastUpdate: null,
                isLoading: false,
                selectedAcct: null,
                error: null
            };

            var factory = {};

            var convertSearchParams = function (searchParams) {
                
                return {
                        customerCode: searchParams.customerCode,
                        firstName: searchParams.firstName,
                        lastName: searchParams.lastName,
                        documentSerial: searchParams.documentSerial,
                        documentNumber: searchParams.documentNumber,
                        //приводимо дату до формату yyyy-MM-dd
                        birthDate: searchParams.birthDate ? kendo.toString(searchParams.birthDate, 'yyyy-MM-dd') : searchParams.birthDate,
                        gcif: searchParams.gcif
                    }
            }

            var searchCustomer = function(searchParams) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(apiUrl, {
                    /*headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },*/
                    params: convertSearchParams(searchParams)
                }).success(function (response) {
                    
                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;
                    //конвертуємо дату
                    for (var i = 0; i < data.length; i++) {
                        data[i].DateOpen = data[i].DateOpen ? new Date(data[i].DateOpen.match(/\d+/)[0] * 1) : data[i].DateOpen;
                        data[i].DateClosed = data[i].DateClosed ? new Date(data[i].DateClosed.match(/\d+/)[0] * 1) : data[i].DateClosed;
                    }

                    deferred.resolve(data);
                }).error(function(err, status, headers, config) {
                    state.isLoading = false;
                    deferred.reject(err);
                });

                return deferred.promise;
            }

            var searchCustomerInCsb = function (searchParams, timeout) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(apiCsbUrl, {
                    /*headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },*/
                    params: convertSearchParams(searchParams),
                    timeout: (timeout ? timeout : 10000)
                }).success(function (response) {

                    state.isLoading = false;
                    state.lastUpdate = new Date();
                    data = response.Data ? response.Data : response;
                    //конвертуємо дату
                    for (var i = 0; i < data.length; i++) {
                        data[i].DateOpen = data[i].DateOpen ? new Date(data[i].DateOpen.match(/\d+/)[0] * 1) : data[i].DateOpen;
                        data[i].DateClosed = data[i].DateClosed ? new Date(data[i].DateClosed.match(/\d+/)[0] * 1) : data[i].DateClosed;
                    }
                    
                    deferred.resolve(data);
                }).error(function (err, status, headers, config) {
                    state.isLoading = false;
                    deferred.reject(err);
                });

                return deferred.promise;
            }

            factory.searchCustomer = searchCustomer;
            factory.searchCustomerInCsb = searchCustomerInCsb;
            factory.state = state;
            factory.data = data;
            factory.convertSearchParams = convertSearchParams;
            
            return factory;
        }
    ]);