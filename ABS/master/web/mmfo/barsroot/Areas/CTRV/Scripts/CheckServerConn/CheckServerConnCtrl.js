angular.module('BarsWeb.Controllers', [])
.controller('CheckServerConnCtrl', ['$scope', function ($scope) {
    $scope.status = "";
    $scope.getStatus = function (url) {
        $.ajax({
            url: url,
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        $scope.status = data;
                    }
        });
    };
}]);