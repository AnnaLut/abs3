app.controller("specParamsController", ['$scope', 'paramsService', specParamsController]);

function specParamsController($scope, paramsService) {

    $scope.lock = [];

    var getGridOptions = function (method) {
        return {
            autoBind: false,
            selectable: "row",
            height: 300,
            columns: [
            { field: "CODE", title: "Код", width: 50},
            { field: "TXT", title: "Найменування"}

            ],
            dataSource: {
                type: "webapi",
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        url: bars.config.urlContent('/api/valuepapers/generalfolder/' + method)
                    }
                },
                serverPaging: true,
                serverFiltering: true,
                serverSorting: true,
                pageSize: 10,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                        }
                    }
                }
            },
            pageable: true,
            dataBound: function () {
                var index = $scope.lock.indexOf(method);
                if (index != -1) {
                    $scope.lock.splice(index, 1);
                    $scope.$apply();
                }
                    
            },
            change: function () {
                var index = $scope.lock.indexOf(method);
                if (index == -1) {
                    $scope.lock.push(method);
                    $scope.$apply();
                }
                    
            }
        };
    }

    $scope.grid1Options = getGridOptions('GetCP_OB_INITIATOR');
    $scope.grid2Options = getGridOptions('GetCP_OB_MARKET');

    $scope.$on('loadChangeBillGrids', function () {
        $scope.grid1.dataSource.read();
        $scope.grid2.dataSource.read();
    });

    $scope.setSpecparams = function () {
        var COD_I = $scope.grid1.dataItem($scope.grid1.select()).CODE,
            COD_M = $scope.grid2.dataItem($scope.grid2.select()).CODE;
        paramsService.setSpecparams(paramsService.model.REF_MAIN || "", COD_I, COD_M).then(function (result) {
            if (result == "") {
                bars.ui.success({ text: "Операцію виконано успішно!" });
                $scope.specParamsWindow.close();
            } else {
                bars.ui.error({ text: result });
            }
        })
    }


}