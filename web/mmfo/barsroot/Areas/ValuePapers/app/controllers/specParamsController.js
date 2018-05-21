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

    $scope.mode = 1;
    
    $scope.grid1Options = getGridOptions('GetCP_OB_INITIATOR');
    $scope.grid2Options = getGridOptions('GetCP_OB_MARKET');
    $scope.grid3Options = getGridOptions('GetCP_OB_FORM_CALC');
    $scope.grid4Options = getGridOptions('GetCP_VDOGO');
    $scope.grid5Options = getGridOptions('GetCP_KLCPE');

    $scope.$on('loadChangeBillGrids', function () {
        $scope.mode = document.getElementById('specParamsWindowMode').value;
        if ($scope.mode == 1) {
            $scope.grid1.dataSource.read();
            $scope.grid2.dataSource.read();
        }
        if ($scope.mode == 2) {
            $scope.grid4.dataSource.read();
            $scope.grid5.dataSource.read();
        }
        $scope.grid3.dataSource.read();
    });

    $scope.setSpecparams = function () {
        var COD_I = $scope.mode == 1 ? $scope.grid1.dataItem($scope.grid1.select()).CODE : null,
            COD_M = $scope.mode == 1 ? $scope.grid2.dataItem($scope.grid2.select()).CODE : null,
            COD_F = $scope.grid3.dataItem($scope.grid3.select()).CODE;
        var COD_V = $scope.mode == 2 ? $scope.grid4.dataItem($scope.grid4.select()).CODE : null,
            COD_O = $scope.mode == 2 ? $scope.grid5.dataItem($scope.grid5.select()).CODE : null

        paramsService.setSpecparams(paramsService.model.REF_MAIN || "", COD_I, COD_M, COD_F, COD_V, COD_O).then(function (result) {
            if (result == "") {
                bars.ui.success({ text: "Операцію виконано успішно!" });
                $scope.specParamsWindow.close();
            } else {
                bars.ui.error({ text: result });
            }
        })
    }


}