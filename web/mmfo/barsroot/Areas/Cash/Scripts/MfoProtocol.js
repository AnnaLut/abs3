﻿angular.module('BarsWeb.Controllers').controller('MfoProtocolCtrl', ['$scope', '$http', function ($scope, $http) {
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
                            url: bars.config.urlContent("/cash/limitsdistribution/GetMfoProtocolData/") + "?id=" + id
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
                                KF: { type: 'string', editable: false },
                                NAME_KF: { type: 'string', editable: false },
                                KV: { type: 'number', editable: false },
                                LIM_CURRENT: { type: 'number', editable: false },
                                LIM_MAX: { type: 'number', editable: false },
                                STATUS: { type: 'number', editable: false },
                                ERROR: { type: 'string', editable: false },
                            }
                        }
                    }
            },
            dataBound: function dataBound(e) {
                var columns = e.sender.columns;
                var columnIndex = this.wrapper.find(".k-grid-header [data-field=" + "LIM_CURRENT" + "]").index();
                var columnIndex1 = this.wrapper.find(".k-grid-header [data-field=" + "LIM_MAX" + "]").index();
                var dataItems = e.sender.dataSource.view();
                for (var j = 0; j < dataItems.length; j++) {
                    var LIM_CURRENT = dataItems[j].get("LIM_CURRENT");
                    var LIM_MAX = dataItems[j].get("LIM_MAX");

                    var row = e.sender.tbody.find("[data-uid='" + dataItems[j].uid + "']");

                    var cell = row.children().eq(columnIndex);
                    cell.addClass(getUnitsInStockClass(LIM_CURRENT));

                    var cell1 = row.children().eq(columnIndex1);
                    cell1.addClass(getUnitsInStockClass(LIM_MAX));
                }
            },
            columns: [
                {
                    field: "KF",
                    title: "МФО",
                },
                {
                    field: "NAME_KF",
                    title: "Назва Ру",
                },
                {
                    field: "KV",
                    title: "Код валюти",
                },
                {
                    field: "LIM_CURRENT",
                    title: "Поточний ліміт",
                },
                {
                    field: "LIM_MAX",
                    title: "Максимальний ліміт",
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
            },
        }
    };

    function getUnitsInStockClass(units) {
        if (units < 0) {
            return "critical";
        }
    }
}]);