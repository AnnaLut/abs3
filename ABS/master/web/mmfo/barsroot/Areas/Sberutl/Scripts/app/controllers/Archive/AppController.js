angular.module('BarsWeb.Controllers', [])
    .controller('AppController', ['$scope', '$http', function ($scope, $http) {
        $scope.onInit = function (id) {
            $scope.id = id;
        };

        $scope.gridOptions = {
            autoBind: true,
            toolbar: ["excel"],
            excel: {
                fileName: "Журнал імпортованих файлів.xlsx",
                allPages: true,
                filterable: true,
                proxyURL: bars.config.urlContent('/sberutl/archive/ConvertBase64ToFile/')
            },
            dataSource: {
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/sberutl/archiveapi/getgriddata'),
                        data: function () {
                            return { param: $scope.id };
                        }
                    }
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        fields: {
                            FILE_ID: {
                                type: 'number'
                            },
                            FILE_NAME: {
                                type: 'string'
                            },
                            CRT_DATE: {
                                type: 'date'
                            },
                            REF: {
                                type: 'number'
                            },
                            NLS: {
                                type: 'string'
                            },
                            FIO: {
                                type: 'string'
                            },
                            INN: {
                                type: 'string'
                            },
                            SUMMA: {
                                type: 'number'
                            },
                            STATUS: {
                                type: 'string'
                            },
                            ERROR: {
                                type: 'string'
                            },
                            LINK: {
                                type: 'string'
                            }
                        }
                    }
                },
                pageSize: 5
            },
            dataBound: function () {
            },
            selectable: 'single',
            groupable: false,
            sortable: {
                mode: "single",
                allowUnsort: true
            },
            resizable: true,
            reorderable: true,
            filterable: true,
            scrollable: true,
            pageable: {
                refresh: true,
                pageSizes: [5, 10, 20, 50],
                buttonCount: 5
            },
            columns: [
                {
                    field: "FILE_ID",
                    title: "Ід. файлу",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "FILE_NAME",
                    title: "Ім'я файлу",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "CRT_DATE",
                    title: "Дата",
                    attributes: { style: "text-align:center;" },
                    template: "#= kendo.toString(kendo.parseDate(CRT_DATE, 'yyyy/MM/dd'), 'dd/MM/yyyy') #"
                },
                {
                    field: "REF",
                    title: "Реф.",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "FIO",
                    title: "ФІО",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "INN",
                    title: "ОКПО",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "SUMMA",
                    title: "Сума",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "STATUS",
                    title: "Статус",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "ERROR",
                    title: "Помилка",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "LINK",
                    title: "Посилання",
                    attributes: { style: "text-align:center;" },
                    template: "<a ng-click='DocInput(${NLS})'>#=LINK == null ? '' : LINK#</a>"
                }
            ]
        };

        $scope.DocInput = function (nls)
        {
            bars.ui.dialog({
                content: bars.config.urlContent('/docinput/docinput.aspx?tt=310&nls_b=') + nls,
                iframe: true,
                height: document.documentElement.offsetHeight * 0.8,
                width: document.documentElement.offsetWidth * 0.8
            });
        }
    }]);