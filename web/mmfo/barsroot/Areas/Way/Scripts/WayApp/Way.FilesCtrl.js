angular.module("BarsWeb.Controllers")
    .controller("Way.FilesCtrl", function ($scope, $http, $location, $window) {
        $scope.filesGridOptions = {
            scrollable: true,
            height: '300px',
            dataSource: {
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/way/file/getfilelist'),
                        dataType: 'json'
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        fields: {
                            fileName: { type: 'string' },
                            selected: { type: 'bool' }
                        }
                    }
                }
            },
            columns: [
                {
                    title: " ",
                    template: '<input ng-model = "dataItem.selected" type="checkbox"></input>',
                    width: "30px"
                },
                {
                    field: "fileName",
                    title: "Ім'я файлу"
                }
            ]
        };
        $scope.uploadFiles = function () {
            var selectedFiles = $scope.filesGrid.dataSource.data()
                .filter(function (x) { return x.selected })
                .map(function (x) { return x.fileName });
            if (selectedFiles.length == 0) {                
                bars.ui.alert({ text: "Файли не обрано!" },close);
                //window.parent.$("#barsUiAlertDialog").data("kendoWindow").close();              
                return;
            }
            var data = JSON.stringify(selectedFiles);

            var url = bars.config.urlContent('/api/way/file/uploadFiles');
            bars.ui.loader('body', true);
            $http.post(url, data).success(function (result) {
                bars.ui.loader('body', false);
                $scope.filesGrid.dataSource.read();
                bars.ui.alert({ text: result.Message });                
            });

        }
        $scope.selectAll = function () {
            var data = $scope.filesGrid.dataSource.data();
            $scope.filesGrid.dataSource.data(data.map(function (x) { x.selected = $scope.allSelected; return x }));
        };
    });
