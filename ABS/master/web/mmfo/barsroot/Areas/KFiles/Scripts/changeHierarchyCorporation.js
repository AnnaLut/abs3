angular.module('BarsWeb.Controllers')
    .controller('KFiles.changeHierarchyCorporationCtrl', ['$scope', '$http', '$rootScope',
        function ($scope, $http, $rootScope) {


            $scope.$on('changeHierarchyCorporation', function (event, data) {

                $scope.corporationDataSource = {
                    transport: {
                        read: {
                            type: "GET",
                            url: '/barsroot/kfiles/kfiles/GetCorporationsForChangeHierarchy?ID=' + data.id
                        }
                    }
                };
                $scope.parentId = data.parentId;
            });

            $scope.closeFormChangeHierarchyCorporation = function () {

                $rootScope.windowChangeHierarchyCorporation.close();
            }

            $scope.changeLevel = function () {

                var id = parseInt($scope.ID);
                var parentId = parseInt($scope.selectedParentId);

                var data = $.param({
                    ID: id,
                    PARENT_ID: parentId,
                });

                $http.post('/barsroot/KFiles/KFiles/ChangeHierarchy', data, $rootScope.config)
                    .success(function (data) {
                        if (data.Status == "ERROR") {

                            bars.ui.error({ text: "Не вдалось змінити ієрархію підрозділу " + $scope.CORPORATION_NAME });

                        }
                        if (data.Status == "OK") {

                            bars.ui.alert({ text: "Ієрархію підрозділу " + $scope.CORPORATION_NAME + " змінено " });

                        }
                    })
                   .error(function (status) {
                       bars.ui.error({ text: "Не вдалось змінити ієрархію підрозділу " + $scope.CORPORATION_NAME });
                   })
                    ["finally"](function () {
                        $scope.windowChangeHierarchyCorporation.close();
                        $rootScope.dataSourceGridCorporations.read();
                    });
            }

        }]);