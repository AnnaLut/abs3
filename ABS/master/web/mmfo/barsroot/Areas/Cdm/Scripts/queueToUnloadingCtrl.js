angular.module('BarsWeb.Controllers')
    .controller('Cdm.queueToUnloadingCtrl',
            ['$scope', '$http',
        function ($scope, $http) {

            var dataSource = {
                url: bars.config.urlContent('/Cdm/QueueToUnloading/ReturnDataToGrid/'),
            };

            $scope.queueToUnloadingGridOptions = {
                animation: true,
                dataSource: {
                    pageSize: 3,
                    transport: {
                        read: {
                            url: dataSource.url,
                            dataType: 'json'
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        model: {
                            fields: {
                                Name_Type: { type: 'string' },
                                Count_RNK: { type: 'number' },
                                Cust_Type: { type: 'string' }
                            }
                        }
                    }
                },
                columns: [
                    {
                        field: "Name_Type",
                        title: "Групи карток до вивантаження",
                        width: "30%",
                    }, {
                        field: "Count_RNK",
                        title: "Кількість карток у черзі",
                        width: "20%"
                    },
                    {
                        title: "Вивантажити",
                        field: "Cust_Type",
                        template: function (data) {
                            if (data.Count_RNK == 0) {
                                return '<button  ng-click="sendCards(\'' + data.Cust_Type + '\')" id="textButton" disabled>Вивантажити до ЕБК</button>';
                            }
                            else if (data.Count_RNK !== 0) {
                                return '<button  ng-click="sendCards(\'' + data.Cust_Type + '\')" id="textButton">Вивантажити до ЕБК</button>';
                            }
                        },
                        width: "50%",
                        sortable: false
                    }
                ],
                sortable: true,
            }


            $scope.sendCards = function (custType) {

                $scope.loading = true;

                $http.get(bars.config.urlContent('/Cdm/QueueToUnloading/SendCards?custType=' + custType)).success(function (data) {

                    bars.ui.alert({ text: data + " карток відправлено" });
                    $scope.queueToUnloadingGrid.dataSource.read();

                })
                .error(function (data) {
                    bars.ui.alert({ text: "Картки не відправлені" });
                })
                ["finally"](function () {
                    $scope.loading = false;
                });

            }

        }]);