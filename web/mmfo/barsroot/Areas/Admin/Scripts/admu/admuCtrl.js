$(document).ready(function () {

    paramObj = { urlParams: '' };

    var admuDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",

                //TODO: change url after

                url: bars.config.urlContent("/admin/ADMU/GetADMUList"),
                data: {
                    parameters:
                        function () {
                            debugger;
                            return paramObj.urlParams || '';
                        }
                },
                success: function () { 
                    //
                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці.<br/>" + error });
                }
            }
        },
        requestStart: function (e) {
            //kendo.ui.progress($("#grid-container"), true);
            bars.ui.loader("body", true);
        },
        requestEnd: function (e) {
            //kendo.ui.progress($("#grid-container"), false);
            bars.ui.loader("body", false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    LOGIN_NAME: { type: "string" },
                    USER_NAME: { type: "string" },
                    BRANCH_CODE: { type: "string" },
                    AUTHENTICATION_MODE_ID: { type: "string" },
                    AUTHENTICATION_MODE_NAME: { type: "string" },
                    STATE_ID: { type: "number" },
                    STATE_NAME: { type: "string" }
                }
            }
        }
    });

    function setDefaultSelectedRow() {
        var grid = $("#ADMUGrid").data("kendoGrid");
        if (!!grid) {
            grid.select("tr:eq(2)");

            // color mark for ADMU data:
            //grid.tbody.find(">tr").each(function () {
            //    var dataItem = grid.dataItem(this);
            //    var d = new Date();

            //    if (dataItem.USER_ACTIVE == 0) {
            //        $(this).addClass("k-row-isNotActive");
            //    } else if (kendo.parseDate(dataItem.USER_RDATE2, "dd/MM/yyyy") >= d) {
            //        $(this).addClass("k-row-isDisable");
            //    }
            //});
        }
    }

    function setContextAndRefreshAllGrids() {
        var grid = $("#ADMUGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        if (!!currentRow) {
            //$("#pbUnblockUser").data("kendoButton").enable(currentRow.STATE_ID !== 2);
            //$("#pbBlockUser").data("kendoButton").enable(currentRow.STATE_ID === 2);
            //$("#pbDropUser").data("kendoButton").enable(currentRow.STATE_ID !== 4);
        }
    }

    $("#ADMUGrid").kendoGrid({
        autoBind: true,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5,
            pageSizes: [10, 50, 100, 1000]
        },
        columns: [
            {
                field: "ID",
                title: "ID",
                width: "10%",
                filterable: {
                    cell: {
                        template: function (args) {
                            args.element.kendoNumericTextBox({
                                format: "#",
                                decimals: 0
                            });
                        }

                    }
                }
            },
            {
                field: "LOGIN_NAME",
                title: "Логін",
                width: "15%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "USER_NAME",
                title: "Ім'я користувача",
                width: "20%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "BRANCH_CODE",
                title: "Відділення",
                width: "15%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "AUTHENTICATION_MODE_NAME",
                title: "Режим автентифікації",
                width: "15%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "STATE_NAME",
                title: "Стан",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "ADM_COMMENTS",
                title: "Додаткова інформація",
                width: "15%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: admuDataSource,
        filterable: {
            mode: "row"
        },
        change: setContextAndRefreshAllGrids,
        dataBound: setDefaultSelectedRow
    });
});