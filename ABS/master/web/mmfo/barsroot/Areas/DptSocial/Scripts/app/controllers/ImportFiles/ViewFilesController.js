angular.module('BarsWeb.Controllers', [])
    .controller('AppController', ['$scope', '$http', function ($scope, $http) {
        var file_type = angular.element("#ddFileType").kendoDropDownList({
            dataTextField: "text",
            dataValueField: "value",
            dataSource: [{ value: 1, text: "Пенсії" }, { value: 2, text: "Соціальні виплати" }]
        });

        var file_date = angular.element("#dpFileDate").kendoDatePicker({ format: "dd/MM/yyyy", value: new Date(), parseFormats: ["dd/MM/yyyy", "dd.MM.yyyy", "dd-MM-yyyy", "dd/MM/yy", "dd.MM.yy", "dd-MM-yy"] });

        $scope.filesGridOptions = {
            autoBind: true,
            dataSource: {
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/dptsocial/importfilesapi/GetImportedFilesGridData'),
                        data: function () {
                            return { file_tp: file_type.data("kendoDropDownList").value(), file_date: kendo.toString(kendo.parseDate(file_date.data("kendoDatePicker").value(), 'yyyy/MM/dd'), 'dd/MM/yyyy') }
                        }
                    }
                },
                requestStart: function () {
                    $("#loader").show();
                },
                requestEnd: function () {
                    $("#loader").hide();
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
                            KF: {
                                type: 'string'
                            },
                            FILE_DT: {
                                type: 'date'
                            },
                            FILE_TP: {
                                type: 'number'
                            },
                            FILE_QTY: {
                                type: 'number'
                            },
                            USR_ID: {
                                type: 'number'
                            }
                        }
                    }
                },
                pageSize: 10
            },
            detailInit: detailInit,
            detailExpand: function (e) {
                this.collapseRow(this.tbody.find('> tr.k-master-row').not(e.masterRow));
                this.tbody.find('tr.k-detail-row.ng-scope > td.k-detail-cell > div').data("kendoGrid").dataSource.read();
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
                    field: "KF",
                    title: "Бранч",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "FILE_DT",
                    title: "Дата файлу",
                    attributes: { style: "text-align:center;" },
                    template: "#= kendo.toString(kendo.parseDate(FILE_DT, 'yyyy/MM/dd'), 'dd/MM/yyyy') #"
                },
                {
                    field: "FILE_TP",
                    title: "Тип файлу",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "FILE_QTY",
                    title: "Кількість файлів",
                    attributes: { style: "text-align:center;" }
                },
                {
                    field: "USR_ID",
                    title: "Ід. користувача",
                    attributes: { style: "text-align:center;" }
                }
            ]
        }

        function detailInit(e) {
            $("<div/>").appendTo(e.detailCell).kendoGrid({
                autoBind: false,
                dataSource: {
                    type: "webapi",
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/dptsocial/importfilesapi/GetImportedFileDetailGridData'),
                            data: function () {
                                return { file_dt: kendo.toString(kendo.parseDate(e.data.FILE_DT, 'yyyy/MM/dd'), 'dd/MM/yyyy'), file_tp: e.data.FILE_TP }
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
                                KF: {
                                    type: 'string'
                                },
                                USR_ID: {
                                    type: 'number'
                                },
                                FILE_DT: {
                                    type: 'date'
                                },
                                FILE_TP: {
                                    type: 'number'
                                },
                                FILE_NM: {
                                    type: 'string'
                                },
                                FILE_SUM: {
                                    type: 'number'
                                },
                                FILE_QTY: {
                                    type: 'number'
                                },
                                FILE_HDR_ID: {
                                    type: 'number'
                                },
                                TOT_AMT: {
                                    type: 'number'
                                },
                                TOT_QTY: {
                                    type: 'number'
                                },
                                PAID_QTY: {
                                    type: 'number'
                                },
                                PAID_AMT: {
                                    type: 'number'
                                },
                                BAD_QTY: {
                                    type: 'number'
                                },
                                CLS_QTY: {
                                    type: 'number'
                                },
                                PYMT_QTY: {
                                    type: 'number'
                                }
                            }
                        }
                    },
                    pageSize: 15
                },
                dataBound: function () {
                    this.tbody.on("dblclick", "tr.k-state-selected", function (e) {
                        var element = $(e.target);
                        var grid = element.closest("[data-role=grid]").data("kendoGrid");
                        var dataItem = grid.dataItem(grid.select());
                        bars.ui.confirm({ text: "Перейти на сторінку обробки та прийому файлу?" }, function () {
                            $("#loader").show();
                            window.location = bars.config.urlContent('/deposit/DepositFile_ext.aspx?') + "filename=" + dataItem.FILE_NM + "&dat=" + kendo.toString(kendo.parseDate(dataItem.FILE_DT, 'yyyy/MM/dd'), 'dd/MM/yyyy') + "&header_id=" + dataItem.FILE_HDR_ID;
                        });
                    });
                },
                scrollable: true,
                sortable: true,
                pageable: true,
                filterable: true,
                columns: [
                    {
                        field: "KF",
                        title: "Бранч",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "USR_ID",
                        title: "Ід.<br>користувача",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "FILE_DT",
                        title: "Дата файлу",
                        attributes: { style: "text-align:center;" },
                        template: "#= kendo.toString(kendo.parseDate(FILE_DT, 'yyyy/MM/dd'), 'dd/MM/yyyy') #",
                        width: "90px"
                    },
                    {
                        field: "FILE_TP",
                        title: "Тип файлу",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "FILE_NM",
                        title: "Ім'я файлу",
                        attributes: { style: "text-align:center;" },
                        width: "130px"
                    },
                    {
                        field: "FILE_SUM",
                        title: "Сума",
                        attributes: { style: "text-align:center;" },
                        width: "110px",
                        format: "{0:n2}"
                    },
                    {
                        field: "FILE_QTY",
                        title: "Кількість<br>стрічок",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "FILE_HDR_ID",
                        title: "Ід.<br>заголовку",
                        attributes: { style: "text-align:center;" },
                        width: "90px"
                    },
                    {
                        field: "TOT_AMT",
                        title: "Загальна<br>сума",
                        attributes: { style: "text-align:center;" },
                        width: "80px",
                        format: "{0:n2}"
                    },
                    {
                        field: "TOT_QTY",
                        title: "Загальна<br>кількість<br>стрічок",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "PAID_QTY",
                        title: "Кількість<br>сплачних",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "PAID_AMT",
                        title: "Сума<br>сплачених",
                        attributes: { style: "text-align:center;" },
                        width: "100px",
                        format: "{0:n2}"
                    },
                    {
                        field: "BAD_QTY",
                        title: "Кількість<br>помилкових",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "CLS_QTY",
                        title: "Кількість<br>закритих",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    },
                    {
                        field: "PYMT_QTY",
                        title: "Кількість<br>помічених<br>для оплати",
                        attributes: { style: "text-align:center;" },
                        width: "80px"
                    }
                ],
                selectable: 'single'
            });
        }
    }]);