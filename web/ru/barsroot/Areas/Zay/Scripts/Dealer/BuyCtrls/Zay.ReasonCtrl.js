angular.module('BarsWeb.Controllers')
    .controller('Zay.ReasonCtrl', [
        '$scope', '$http', 'transport',
        function($scope, $http, transport) {

            $scope.transport = transport;

            $scope.backRequest = function(reason) {

                 
                var item = {
                    Mode: reason.viza,
                    Id: reason.id,
                    IdBack: reason.reasonType,
                    Comment: reason.comment
                };

                var backRequestHttp = $http.post(bars.config.urlContent("/api/zay/backrequest/post"), JSON.stringify(item));
                backRequestHttp.success(function(data) {

                    if (data.Status === "Ok") {
                        bars.ui.alert({
                            text: 'Заявка: ' + reason.id + '.<br/>' +
                                data.Message
                        });
                    } else {
                        bars.ui.error({
                            text: 'Заявка: ' + reason.id + '.<br/>' +
                                data.Message
                        });
                    }

                    transport.btnBackRequestOption = false;

                    if (transport.backBuyWindow)
                        transport.backBuyWindow.close();

                    /*if (transport.backSaleWindow)
                        transport.backSaleWindow.close();*/
                });
            };

            $scope.reasonsDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: "application/json",
                        url: bars.config.urlContent("/api/zay/reason/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            });

            $scope.reasonsOptions = {
                dataSource: $scope.reasonsDataSource,
                dataTextField: "REASON",
                dataValueField: "ID"
            };


        }
    ]);