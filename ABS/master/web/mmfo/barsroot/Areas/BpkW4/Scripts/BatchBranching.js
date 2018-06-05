angular.module('BarsWeb.Controllers', ["kendo.directives"])
    .controller('BatchBranchingCtrl', ['$scope', function ($scope) {

    $scope.filesGridOptions = {
        columns: [
            {
                field: "ID",
                title: "Ід.",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "FILE_NAME",
                title: "Ім'я файлу"
            },
            {
                field: "FILE_DATE",
                title: "Дата імпорту файлу",
                template: "#= kendo.toString(kendo.parseDate(FILE_DATE, 'yyyy-MM-dd'), 'dd/MM/yyyy') #"
            },
            {
                field: "FILE_N",
                title: "Кількість документів",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "FILE_STATUS",
                title: "Статус файла"
            },
            {
                field: "ERR_TEXT",
                title: "Помилка"
            }
        ],
        dataSource: {
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/BpkW4/BatchBranchingApi/GetAllFiles")
                }
            },
            pageSize: 5,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { type: 'number' },
                        FILE_NAME: { type: 'string' },
                        FILE_DATE: { type: 'string' },
                        FILE_N: { type: 'number' },
                        FILE_STATUS: { type: 'string' },
                        ERR_TEXT: { type: 'string' }
                    }
                }
            }
        },
        detailExpand: function (e) {
            this.collapseRow(this.tbody.find(' > tr.k-master-row').not(e.masterRow));
        },
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        sortable: true,
        resizable: true,
        filterable: true,
    };

    $scope.fileContentChildGridOptions = function (dataItem) {
        return {
            columns: [
                {
                    field: "ID",
                    title: "Ід. запису",
                    width: "8%",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "FILEID",
                    title: "Ід. файлу",
                    width: "8%",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "IDN",
                    title: "№ рядка у файлі",
                    width: "12%",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "RNK",
                    template: "<a style='color: darkblue;' href='/barsroot/clientregister/registration.aspx?readonly=0&rnk=${RNK}'>${RNK}</a>",
                    title: "Реєстраціний № клієнта",
                    width: "15%",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "NLS",
                    title: "Рахунок",
                    width: "10%"
                },
                {
                    field: "BRANCH",
                    title: "Новий бранч рахунку",
                    width: "18%"

                },
                {
                    field: "STATE",
                    title: "Статус",
                    width: "100px",
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                format: "n0"
                            });
                        }
                    }
                },
                {
                    field: "MSG",
                    title: "Повідомлення"
                }
            ],
            dataSource: {
                type: 'webapi',
                transport: {
                    read: {
                        type: 'GET',
                        url: bars.config.urlContent("/api/BpkW4/BatchBranchingApi/GetFileContent") + "?id=" + dataItem.ID
                    }
                },
                pageSize: 5,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverAggregates: true,
                scrollable: false,
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ID: { type: 'number', format: "{0:c}", attributes: { spinners: false } },
                            FILEID: { type: 'number' },
                            IDN: { type: 'number' },
                            RNK: { type: 'number' },
                            NLS: { type: 'string' },
                            BRANCH: { type: 'string' },
                            STATE: { type: 'number' },
                            MSG: { type: 'string' }
                        }
                    }
                }
            },
            sortable: true,
            resizable: true,
            filterable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            }
        }
    };

    angular.element("#files").kendoUpload({
        multiple: false,
        localization: {
            select: "Вибрати...",
            headerStatusUploading: "Завантаження",
            headerStatusUploaded: "Успішно"
        },
        complete: onComplete,
        async: {
            saveUrl: bars.config.urlContent("/api/BpkW4/BatchBranchingApi/Upload")
        }
    });

    function onComplete() {
        $scope.filesGrid.dataSource.read();
    };
}]);
