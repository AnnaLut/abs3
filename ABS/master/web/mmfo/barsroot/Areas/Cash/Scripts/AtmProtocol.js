angular.module('BarsWeb.Controllers').controller('AtmProtocolCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.gridOptions = function (id) {
        return {
            dataSource: {
                pageSize: 15,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                type: 'aspnetmvc-ajax',
                transport: {
                    read:
                        {
                            url: bars.config.urlContent("/cash/limitsdistribution/GetAtmProtocolData/") + "?id=" + id
                        }
                },
                schema:
                {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: 'MFO',
                        fields: {
                            ID_ATM: { type: 'string', editable: false },
                            LIM_MAX: { type: 'number', editable: false },
                            NAME_RU: { type: 'string', editable: false },
                            NAME_ACC: { type: 'string', editable: false },
                            STATUS: { type: 'string', editable: false },
                            ERROR: { type: 'string', editable: false }
                        }
                    }
                }
            },
            dataBound: function dataBound(e) {
                var columns = e.sender.columns;
                var columnIndex1 = this.wrapper.find(".k-grid-header [data-field=" + "LIM_MAX" + "]").index();
                var dataItems = e.sender.dataSource.view();
                for (var j = 0; j < dataItems.length; j++) {
                    var LIM_MAX = dataItems[j].get("LIM_MAX");

                    var row = e.sender.tbody.find("[data-uid='" + dataItems[j].uid + "']");

                    var cell1 = row.children().eq(columnIndex1);
                    cell1.addClass(getUnitsInStockClass(LIM_MAX));
                }
            },
            columns: [
                {
                    field: "ID_ATM",
                    title: "Код банкомату",
                },
                {
                    field: "LIM_MAX",
                    title: "Максимальний ліміт",
                },
                {
                    field: "NAME_RU",
                    title: "Назва РУ",
                },
                {
                    field: "NAME_ACC",
                    title: "Рахунок",
                },
                {
                    field: "STATUS",
                    title: "Статус",
                },
                {
                    field: "ERROR",
                    title: "Помилка",
                }
            ],
            filterable: true,
            sortable: true,
            selectable: "row",
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            }
        };
    };
    function getUnitsInStockClass(units) {
        if (units < 1) {
            return "critical";
        }
    }
}]);