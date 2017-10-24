angular.module('BarsWeb.Controllers')
.service('IODataHttpService', ['$http', function($http) {

    this.checkJob = function(job) {
        return $http.post(bars.config.urlContent("/api/iodata/job/post"), JSON.stringify(job));
    };

}]);