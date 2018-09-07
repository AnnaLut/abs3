'use strict';
angular.module(globalSettings.modulesAreas)
    .factory('CDO.CorpLight.relatedCustomersService',
    ['$http', '$q',
        function ($http, $q) {

            var _url = bars.config.urlContent('/api/cdo/corplight/relatedCustomers/');
            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };
            var factory = {};

            var _getModuleVersion = function() {
                var deferred = $q.defer();
                 
                $http.get(bars.config.urlContent('/cdo/common/version')).success(function (response) {
                    deferred.resolve(response);
                }).error(function (response) {
                    deferred.reject(response);
                });
                return deferred.promise;                
            }

            var mapResponse = function (data) {
                if (data && data.DocDate) {
                    data.DocDate = kendo.parseDate(data.DocDate);
                }
                if (data && data.BirthDate) {
                    data.BirthDate = kendo.parseDate(data.BirthDate);
                }
                return data;
            }

            var _getById = function(id, custId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(_url + 'getById/' + id + '/' + custId).success(function(response) {
                    state.isLoading = false;
                    var result = mapResponse(response);
                    deferred.resolve(result);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };
            var _getByTaxCode = function (custId, taxCode, docSeries, docNumber) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(_url + 'getByTaxCode/' + custId + '/' + (taxCode || null) + '/' + (docSeries || null) + '/' + (docNumber || null)).success(function (response) {
                    state.isLoading = false;
                    var result = mapResponse(response);
                    deferred.resolve(result);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };
            var _getList = function(custId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(_url + custId).success(function(response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };
            var _create = function(relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(_url +'create', relCustomer)
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };
            var _update = function(relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(_url + 'update/' + relCustomer.Id, relCustomer)
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };
            var _remove = function (id) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(_url + id).success(function(response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };

            var _validateOneTimePass = function (phoneNum, code) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(bars.config.urlContent('/api/cdo/corplight/Users/validateOneTimePass/?phoneNumber=' + phoneNum + "&code=" + code))
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }
            var _validateMobilePhone = function (phoneNum) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(bars.config.urlContent('/api/cdo/corplight/Users/validateMobilePhone/?phoneNumber=' + phoneNum))
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            //var _mapCustomer = function(id, custId, signNumber) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.put(_url + 'mapCustomer/' + id + '/' + custId + '/' + signNumber)
            //    .success(function (response) {
            //        state.isLoading = false;
            //        deferred.resolve(response);
            //    }).error(function (response) {
            //        state.isLoading = false;
            //        deferred.reject(response);
            //    });
            //    return deferred.promise;                  
            //}
            var _updateAndMap = function (relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(_url + 'updateAndMap/', relCustomer)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            var _visaMapedCustomer = function(id, custId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(_url + 'visa/' + id + '/' + custId )
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;  
            }

            var _visaExistingUser = function(id, custId, userId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(_url + 'visa/' + id + '/' + custId + '/' + userId )
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;  
            }

            var _requestCertificate = function (relCustId) {
                if (typeof relCustId === 'undefined') {
                    throw new Error('CorpLight.relatedCustomersService.requestCertificate: ' +
                        'peremeter userId (' + relCustId + ') is not valid.');
                }
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(_url + 'requestCertificate/' + relCustId)
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise; 
            }

            var _deleteRequest = function(id, customerId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http['delete'](_url + 'deleteRequest/' + id + '/' + customerId).success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            }

            var _unMapUserCustomer = function(id, customerId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(_url + 'unMapCustomer/' + id + '/' + customerId).success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;                
            }

            factory.getModuleVersion = _getModuleVersion;
            factory.state = state;
            factory.getById = _getById;
            factory.getByTaxCode = _getByTaxCode;
            factory.getList = _getList;
            factory.create = _create;
            factory.update = _update;
            factory.updateAndMap = _updateAndMap;
            factory.remove = _remove;
            //factory.mapCustomer = _mapCustomer;
            factory.visaMapedCustomer = _visaMapedCustomer;
            factory.visaExistingUser = _visaExistingUser;
            factory.validateMobilePhone = _validateMobilePhone;
            factory.validateOneTimePass = _validateOneTimePass;
            factory.requestCertificate = _requestCertificate;

            factory.deleteRequest = _deleteRequest;
            factory.unMapUserCustomer = _unMapUserCustomer;

            return factory;
        }
    ]);