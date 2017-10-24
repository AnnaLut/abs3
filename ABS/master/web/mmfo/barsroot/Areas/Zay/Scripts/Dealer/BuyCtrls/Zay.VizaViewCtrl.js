angular.module('BarsWeb.Controllers')
    .controller('Zay.VizaViewCtrl', [
        '$scope', '$http', 'transport',
        function ($scope, $http, transport) {

            $scope.transport = transport;
            
            var dataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                pageSize: 10,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                transport: {
                    read: {
                        type: 'GET',
                        url: bars.config.urlContent('/api/zay/vizaview/get/'),
                        data: {
                            id: function () {
                                //debugger;
                                return transport.vizaView.id;
                            }
                        }
                    }
                },
                requestEnd: function() {
                    
                },
                requestStart: function() {
                    
                },
                schema: {
                    data: 'Data',
                    total: 'Total',
                    model: {
                        fields : {
                            ID: { type: 'number' },
                            TrackId: { type: 'number' },
                            ChangeTime: { type: 'date' },
                            FIO: { type: 'string' },
                            Viza: { type: 'number' },
                            StatusName: { type: 'string' }
                        }
                    }
                }
            });

            $scope.gridVizaViewOptions = {
                autoBind: false,
                dataSource: dataSource,
                filterable: true,
                sortable: true,
                selectable: "row",
                pageable: {
                    refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "ID",
                        title: "ID заявки"
                    },{
                        field: "TrackId",
                        title: "",
                        hidden: true
                    }, {
                        field: "ChangeTime",
                        template: "<div>#=kendo.toString(kendo.parseDate(ChangeTime),'dd/MM/yyyy hh:mm:ss') === null ? '-' : kendo.toString(kendo.parseDate(ChangeTime),'dd/MM/yyyy hh:mm:ss')#</div>",
                        title: "Дата зміни"
                    }, {
                        field: "FIO",
                        title: "Виконавець"
                    }, {
                        field: "Viza",
                        title: "",
                        hidden: true
                    }, {
                        field: "StatusName",
                        title: "Статус"
                    }
                ]
            };

            //debugger;
            transport.vizaViewGridOptions = $scope.gridVizaViewOptions;
        }
    ]);