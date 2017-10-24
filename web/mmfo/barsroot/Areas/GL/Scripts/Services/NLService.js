'use strict';

angular.module(globalSettings.modulesAreas)
	.factory('NLService', 
		['$http', '$q', 'NLConfig', 
			function($http, $q, config) {
				var apiUrl = bars.config.urlContent(config.baseApiUrl);

				var factory = {};

				var removeDocument = function (id) {
                    var deferred = $q.defer();
	                $http({
	                    url: apiUrl + 'deleteDocument',
	                    method: 'DELETE',
	                    params: { id: id }
	                }).success(function (response) {
	                    //data = response.Data ? response.Data : response;
	                    deferred.resolve(response);
	                }).error(function (err, status, headers, config) {	                    
	                    deferred.reject(err);
	                });
	                return deferred.promise;
	            };

				// pull to factory object all methods:
				factory.removeDocument = removeDocument;

				return factory;
			}
		]);