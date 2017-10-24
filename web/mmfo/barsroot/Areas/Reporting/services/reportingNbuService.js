angular.module(globalSettings.modulesAreas)
    .factory('reportingNbuService',
    [
        '$http', '$q',
        function ($http, $q) {
            var factory = {};
            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };

            var _processResponse = function (response) {
                if (response === 'null') {
                    response = null;
                }
                return response;
            }

            var _getFileInfo = function (fileCodeBase64, reportDate, kf, versionId) {
                state.isLoading = true;
                var deferred = $q.defer();

                var url = bars.config.urlContent('/api/reporting/nbu/GetFileInfo');
                $http.get(url, {
                    params: {
                        fileCodeBase64: fileCodeBase64,
                        reportDate: reportDate,
                        kf: kf,
                        versionId: versionId
                    }
                }).success(function (response) {
                    response = _processResponse(response);
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (err) {
                    state.isLoading = false;
                    console.log(err);
                    deferred.reject(err);
                });
                return deferred.promise;
            }

            var _blockFile = function (reportDate, kf, versionId, fileId) {
                state.isLoading = true;
                var deferred = $q.defer();

                $http.post(bars.config.urlContent('/api/reporting/nbu/blockfile'), {
                    fileId: fileId,
                    reportDate: reportDate,
                    kf: kf,
                    versionId: versionId
                }).success(function (response) {
                    response = _processResponse(response);
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (err) {
                    state.isLoading = false;
                    console.log(err);
                    deferred.reject(err);
                });
                return deferred.promise;
            }

            var _startGenerateReport = function (reportDate, fileCodeBase64, schemeCode, fileType, kf) {
                state.isLoading = true;
                var deferred = $q.defer();

                var url = bars.config.urlContent('/api/reporting/nbu/') +
                    '?reportDate=' +
                    reportDate +
                    '&fileCodeBase64=' +
                    fileCodeBase64 +
                    '&schemeCode=' +
                    schemeCode +
                    '&fileType=' +
                    fileType +
                    '&kf=' +
                    kf;
                $http.put(url).success(function (response) {
                    response = _processResponse(response);
                    state.isLoading = false;
                    deferred.resolve(response);
                }).error(function (err) {
                    state.isLoading = false;
                    console.log(err);
                    deferred.reject(err);
                });

                return deferred.promise;
            }

            factory.getFileInfo = _getFileInfo;
            factory.blockFile = _blockFile;
            factory.startGenerateReport = _startGenerateReport;

            return factory;
        }
    ]);