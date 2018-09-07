'use strict';
angular.module(globalSettings.modulesAreas)
    .factory('CDO.Corp2.relatedCustomersService',
    ['$http', '$q',
        function ($http, $q) {

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

            var mapResponse = function (data) {
                if (data && data.DocDate) {
                    data.DocDate = new Date(data.DocDate.match(/\d+/)[0] * 1);
                }
                if (data && data.BirthDate) {
                    data.BirthDate = new Date(data.BirthDate.match(/\d+/)[0] * 1);
                }
                return data;
            }

            var _getByTaxCode = function (custId, taxCode, docSeries, docNumber) {
                state.isLoading = true;
                var deferred = $q.defer();

                var url = 'api/cdo/corp2/getbytaxcode/' + custId + '/'+ (taxCode || null) + '/' + (docSeries || null) + '/' + (docNumber || null);
                $http.get(bars.config.urlContent(url)).success(function (response) {
                    state.isLoading = false;
                    var result = mapResponse(response);
                    deferred.resolve(result);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            };

            var _isCanSign = function (custId, taxCode) {
                state.isLoading = true;
                var deferred = $q.defer();

                var url = 'api/cdo/corp2/isCanSign/' + custId + '/' + taxCode;
                $http.get(bars.config.urlContent(url)).success(function (response) {
                    state.isLoading = false;
                    var result = mapResponse(response);
                    deferred.resolve(result);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            }

            var _create = function (relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(bars.config.urlContent('/api/cdo/corp2/RelatedCustomers/create/'), relCustomer)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            };

            var _update = function (relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(bars.config.urlContent('/api/cdo/corp2/RelatedCustomers/update/'), relCustomer)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            };
            var _updateAndMap = function (relCustomer) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(bars.config.urlContent('/api/cdo/corp2/RelatedCustomers/updateAndMap/'), relCustomer)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            };
            var _visaMapedCustomer = function (id, custId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(bars.config.urlContent('api/cdo/corp2/RelatedCustomers/visa/') + id + '/' + custId)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            var _deleteRequest = function (id, customerId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http['delete'](bars.config.urlContent('/api/cdo/corp2/RelatedCustomers/deleteRequest/') + id + '/' + customerId)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            //var _unblockUser = function (userId) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.put(bars.config.urlContent('/api/cdo/corp2/unblockUser/') + userId)
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            //var _blockUser = function (userId) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.put(bars.config.urlContent('/api/cdo/corp2/blockUser/') + userId)
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            var _unloadCustomerAccountsToCorp2 = function (accIdList) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.put(bars.config.urlContent('/api/cdo/corp2/unloadAccsToCorp2/'), accIdList)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }
            ////////////Corp2 Customer Account Visa Setting///////////////
            //var _saveAccountVisaQuantity = function (acc) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.post(bars.config.urlContent('/api/cdo/corp2/savecustomeraccount/'), acc)
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            //var _deleteVisa = function (item) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.post(bars.config.urlContent('/api/cdo/corp2/deletevisa/'), item)
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            //var _addEditVisa = function (item) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();
            //    var url;
            //    if (item.Id) url = bars.config.urlContent('/api/cdo/corp2/editvisa/');
            //    else url = bars.config.urlContent('/api/cdo/corp2/addvisa/');
            //    $http.post(url, item)
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}

            ////////////Corp2 User Coonection Parameters Setting////////////////
            var _getUserLimit = function (userId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(bars.config.urlContent('/api/cdo/corp2/getuserlimit/' + userId))
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }
            var _getLimitDictionary = function () {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(bars.config.urlContent('/api/cdo/corp2/getlimitdictionary'))
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }
            //var _getAvailableFuncs = function (userId) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.get(bars.config.urlContent('/api/cdo/corp2/getavailablefuncs/' + userId))
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            //var _getUserFuncs = function (userId) {
            //    state.isLoading = true;
            //    var deferred = $q.defer();

            //    $http.get(bars.config.urlContent('/api/cdo/corp2/getuserfuncs/' + userId))
            //        .success(function (response) {
            //            state.isLoading = false;
            //            deferred.resolve(response);
            //        }).error(function (response) {
            //            state.isLoading = false;
            //            deferred.reject(response);
            //        });
            //    return deferred.promise;
            //}
            var _saveUserConnectionParamsWindow = function (userModel, limitModel, modules, /*funcs,*/ accs) {
                state.isLoading = true;
                var deferred = $q.defer();
                var url = bars.config.urlContent('/api/cdo/corp2/saveuserconnparams/');
                $http.post(url, {
                    User: userModel,
                    UserLimit: limitModel,
                    UserModules: modules,
                    //UserFuncs: funcs,
                    UserAccs: accs
                })
                    .success(function (response) {
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

            factory.getByTaxCode = _getByTaxCode;
            factory.isCanSign = _isCanSign;
            factory.create = _create;

            factory.update = _update;
            factory.updateAndMap = _updateAndMap;
            factory.visaMapedCustomer = _visaMapedCustomer;
            factory.deleteRequest = _deleteRequest;

            //factory.blockUser = _blockUser;
            //factory.unblockUser = _unblockUser;
            factory.unloadCustomerAccountsToCorp2 = _unloadCustomerAccountsToCorp2;
            //factory.saveAccountVisaQuantity = _saveAccountVisaQuantity;
            //factory.deleteVisa = _deleteVisa;
            //factory.addEditVisa = _addEditVisa;

            factory.getUserLimit = _getUserLimit;
            factory.getLimitDictionary = _getLimitDictionary;
            //factory.getAvailableFuncs = _getAvailableFuncs;
            //factory.getUserFuncs = _getUserFuncs;
            factory.saveUserConnectionParamsWindow = _saveUserConnectionParamsWindow;
            return factory;
        }
    ]);