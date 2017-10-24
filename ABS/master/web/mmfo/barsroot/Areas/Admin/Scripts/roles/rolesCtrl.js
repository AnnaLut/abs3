$(document).ready(function () {

    paramObj = { urlParams: '' };

    var rolesDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                contentType: 'application/json',
                url: bars.config.urlContent("/api/admin/roles/"),
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
                error: function(xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці.<br/>" + error });
                }
            }
        },
        requestStart: function() {
            bars.ui.loader("body", true);
        },
        requestEnd: function() {
            bars.ui.loader("body", false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    ROLE_CODE: { type: "string" },
                    ROLE_NAME: { type: "string" },
                    STATE_NAME: { type: "string" }
                }
            }
        }
    });

    function setDefaultSelectedRow() {
        var grid = $("#RolesGrid").data("kendoGrid");
        if (!!grid) {
            grid.select("tr:eq(2)");
        }
    }

    // функція ініціалізації табів та грідів ресурсів для обраної ролі.
    function detailInit(e) {
        var detailRow = e.detailRow;
        var masterRow = e.masterRow;
        var grid = this;
        var rowData = grid.dataItem(masterRow);

        var rolesTabstripDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 20,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/admin/roletabstrip/GetRoleTabsData"),
                    success: function (elem) {

                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: "Сталася помилка при спробі завантажити дані.<br/>" + error });
                    }
                },
                parameterMap: function (data, operation) {
                    debugger;
                    return kendo.stringify(data);
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { type: "number" },
                        RESOURCE_CODE: { type: "string" },
                        RESOURCE_NAME: { type: "string" }
                    }
                }
            }
        });

        detailRow.find(".RolesTabstrip").kendoTabStrip({
            dataTextField: "RESOURCE_NAME",
            dataContentField: "RESOURCE_CODE",
            select: function (e) {
                var data = this.dataSource.at($(e.item).index()),
                    div = $("#roleResourcesTemplate").html(),
                    template = kendo.template(div);

                var obj = {
                    ID: data.ID,
                    RESOURCE_CODE: data.RESOURCE_CODE,
                    RESOURCE_NAME: data.RESOURCE_NAME,
                    ROLE_ID: rowData.ID
                };

                $(e.contentElement).html(template(obj));
                kendo.bind(e.contentElement, obj);

                bars.tabs.initRoleResourceGrid("#RoleResource" + obj.RESOURCE_CODE + obj.ROLE_ID, data.ID, rowData.ID, rowData.ROLE_CODE);
            },
            dataSource: rolesTabstripDataSource
        });
    }

    $("#RolesGrid").kendoGrid({
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "ID",
                title: "Ідентифікатор ролі",
                width: "15%"
            },
            {
                field: "ROLE_CODE",
                title: "Код ролі",
                width: "15%"
            }, 
            {
                field: "ROLE_NAME",
                title: "Назва ролі",
                width: "50%"
            }, 
            {
                field: "STATE_NAME",
                title: "Стан ролі",
                width: "20%"
            }
        ],
        dataSource:  rolesDataSource,
        filterable: {
            mode: "row"
        },
        detailTemplate: kendo.template($("#template").html()),
        detailInit: detailInit,
        dataBound: setDefaultSelectedRow,
        change: function() {
            var grid = $("#RolesGrid").data("kendoGrid");
            var currentRow = grid.dataItem(grid.select());

            if (!!currentRow) {
                $("#pbUnlockUser").data("kendoButton").enable(currentRow.STATE_NAME === "Блокована");
                $("#pblockUser").data("kendoButton").enable(currentRow.STATE_NAME === "Діюча");
            }
        }
    });

    
});