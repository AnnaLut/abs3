'use strict';
angular.module(globalSettings.modulesAreas)
    .factory('CDO.Corp2.ProfileSignService',
        ['$http', '$q',
        function ($http, $q) {

            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };
            var factory = {};

            var secret = VegaCrypto("ЦСК АТ", false, false, "");

            var signData = function (data) {
                var pkcs7 = secret.signData("",
                                            "",
                                            data,
                                            false);

                if (pkcs7 === 'canceled') {
                    return '';
                }
                return pkcs7;
            }
                 
            var coSignData = function (pkcs7, base64) {
                var pkcs10 = secret.coSingData(
                            "",
                            "",
                            pkcs7,
                            base64,
                            false);

                if (pkcs10 === 'canceled') {
                    return '';
                }
                return pkcs10;
            }

            var _getProfileSignBuffer = function (relCustId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.get(bars.config.urlContent('/api/cdo/corp2/ProfileSign/signBuffer/') + relCustId)
                .success(function (response) {
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (response) {
                    state.isLoading = false;
                    deferred.reject(response);
                });
                return deferred.promise;
            }

            var _setProfileSign = function (relCustId, visaId, signedData) {
                state.isLoading = true;

                var signObject = {
                    VisaId: visaId,
                    Signature: signedData,
                    UserId: relCustId
                };

                var deferred = $q.defer();
                $http.post(bars.config.urlContent('/api/cdo/corp2/ProfileSign/'), signObject)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            factory.getProfileSignBuffer = _getProfileSignBuffer;
            factory.setProfileSign = _setProfileSign;
            factory.signData = signData;
            factory.coSignData = coSignData;

            return factory;
        }
        ]);