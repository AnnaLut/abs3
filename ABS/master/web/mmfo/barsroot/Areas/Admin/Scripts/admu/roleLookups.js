$(document).ready(function () {

    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: false, //several max data amm is 29kb
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/admin/admu/GetRoleLookups")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    ROLE_CODE: { type: "string" },
                    ROLE_NAME: { type: "string" }
                }
            }
        }
    });

    //debugger;
    $("#role-treelist").kendoGrid({
        autoBind: false, // init on btnCreate event
        height: 400,
        dataSource: dataSource,
        sortable: true,
        selectable: "row",
        filterable: {
            mode: "row"
        },
        columns: [
            {
                field: "ROLE_CODE", expandable: true, title: "Код", width: "30%",
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            },
            {
                field: "ROLE_NAME", title: "Назва ролі", width: "30%",
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            },
            {
                field: "ID",
                title: "ID",
                width: "20%",
                filterable: {
                    cell: {
                        template: function (args) {
                            args.element.kendoNumericTextBox({
                                format: "n0",
                                spinners: false
                            });
                        },
                        showOperators: false
                    }
                }
            },
            {
                title: "Доступ",
                template: "<input type='checkbox' class='add-role' data-bind='checked' data-selectrole='#=ID#' />", filterable: false, width: "20%"
            }
        ]
    });

    // Oracle Roles:

    var oraRoles = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/admu/GetOraRolesLookups")
                //data: ""
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ROLE_NAME: { type: "string" }
                }
            }
        }
    });

    var oraRolesGrid = null;

    function getOraRolesGrid() {
        if (oraRolesGrid == null) {
            oraRolesGrid = $("#ora-roles-grid").data("kendoGrid");
        }
        return oraRolesGrid;
    }

    function setDefaultSelectedOraRole() {
        var grid = $("#ora-roles-grid").data("kendoGrid");
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }

    $("#ora-roles-grid").kendoGrid({
        height: 440,
        selectable: "row",
        sortable: true,
        dataSource: oraRoles,
        editable: "popup",
        pageable: {
            refresh: true
        },
        columns: [
            {
                field: "ROLE_NAME",
                title: "ROLE_NROLE_NAMEAME",
                width: "70%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                title: "Use In/Out",
                template: "<input type='checkbox' class='add-role' data-bind='checked' data-oraRole='#=ROLE_NAME#' />",
                width: "30%"
            }
        ],
        filterable: {
            mode: "row"
        },
        dataBound: setDefaultSelectedOraRole
    });

    $("#ora-roles-Window").kendoWindow({
        width: "600px",
        height: "500px",
        title: "Доступні ролі Oracle",
        resizable: false,
        visible: false,
        actions: ["Close"]
    });

    $("#ora-ToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbAddOraRoleToUser' type='button' class='k-button' title='Додати роль Oracle'><i class='pf-icon pf-16 pf-ok'></i></button>" },
            { template: "<button id='pbRefreshOraRoleGrid' type='button' class='k-button' title='Оновити дані таблиці'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" },
            { template: "<button id='pbCloseOraWin' type='button' class='k-button' title='Завершити'><i class='pf-icon pf-16 pf-delete'></i></button>" }
        ]
    });

    $("#pbAddOraRoleToUser").kendoButton({
        click: function() {
            var grid = getOraRolesGrid(),
                checkedList = grid.tbody.find("input:checked"),
                oracleRolesList = [],
                i = 0;

            if (checkedList.length > 0) {
                for (i; i < checkedList.length; i++) {
                    oracleRolesList.push(checkedList[i].getAttribute("data-oraRole"));
                }
                $("#ora-roles").val(oracleRolesList.toString());
            } else {
                $("#ora-roles").val("");
            }
            $("#ora-roles-Window").data("kendoWindow").close();
        }
    });

    $("#pbRefreshOraRoleGrid").kendoButton({
        click: function() {
            $("#ora-roles-grid").data("kendoGrid").dataSource.read();
        }
    });

    $("#pbCloseOraWin").kendoButton({
        click: function() {
            $("#ora-roles-Window").data("kendoWindow").close();
        }
    });

    // Edit Roles treelist:
    function gettUserId() {
        var grid = $("#ADMUGrid").data("kendoGrid"),
            currentRow = grid.dataItem(grid.select());
        if (!!currentRow)
            var userID = currentRow.ID;
        return { userId: userID };
    }

    /*$("#rCode").kendoAutoComplete({
        dataTextField: "ROLE_CODE",
        filter: "contains",
        minLength: 3,
        dataSource: {
            type: "aspnetmvc-ajax",
            serverFiltering: true,
            transport: {
                read: {
                    type: "GET",
                    url: bars.config.urlContent("/admin/admu/GetUserRoles"),
                    data: gettUserId
                }
            }
        }
    });*/

    $('#showWindow').on('click', function () {
        var code = $('#rCode').val();

        var arr = $("#edit-role-grid").data("kendoGrid").table.find('td > span'),
            i = 0;

        bars.ui.loader("#edit-role-grid", true);

        for (i; i < arr.length; i++) {
           
            var el = $(arr[i].parentElement.parentElement).find('td > input[type=checkbox]');

            if (arr[i].innerText.toLowerCase().indexOf(code.toLowerCase()) < 0 && !$(el).is(":checked")) {
                $(arr[i].parentElement.parentElement).hide();
            } else if (arr[i].innerText.toLowerCase().indexOf(code.toLowerCase()) !== -1) {
                $(arr[i].parentElement.parentElement).show();
            }
        }

        bars.ui.loader("#edit-role-grid", false);

        /*var row = $("#edit-role-grid").data("kendoGrid").table.find('td > span[data-roleId="' + code.toUpperCase() + '"]').closest("tr");

        debugger;
        if (row.length !== 0) {
            $("#edit-role-grid div.k-grid-content").scrollTop($(row).position().top); //scroll the content
            $("#edit-role-grid").data("kendoGrid").select(row);
        } else {
            bars.ui.error({ text: "Значення " + code.toUpperCase() + " не знайдено, спробуйте змінити запит." });
        }*/
    });

    $('#clearFilter').on('click', function() {
        var arr = $("#edit-role-grid").data("kendoGrid").table.find('td > span'),
            i = 0;
        for (i; i < arr.length; i++) {
            $(arr[i].parentElement.parentElement).show();
        }
    });

    var userRolesDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        //serverPaging: false,
        //serverFiltering: false,
        //serverSorting: false,
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/admin/admu/GetUserRoles"),
                data: gettUserId
            }
        }
    });

   $("#edit-role-grid").kendoGrid({
        autoBind: false, // init on btnEdit event
        height: 350,
        dataSource: userRolesDataSource,
        selectable: "row",
        columns: [
            {
                field: "ROLE_CODE", expandable: true, title: "Код", width: "35%",
                template: "<span data-roleId='#=ROLE_CODE#'>#=ROLE_CODE#</span>"
            },
            { field: "ROLE_NAME", title: "Назва ролі", width: "30%" },
            //{ field: "ROLE_ID", title: "ID Ролі", width: "10%" },
            {
                field: "IS_GRANTED",
                title: "Доступ",
                template: "<input type='checkbox' data-bind='checked' #= IS_GRANTED === 1 ? checked='checked' : ''# data-selectrole='#=ROLE_ID#' />",
                //template: '<input type="checkbox" #= IS_GRANTED !== 0 ? title="cvhjbkcfg" : "" # data-selectrole="#=ROLE_ID#" /> #console.log(IS_GRANTED)#',
                width: "15%",
                filterable: false
            },
            { field: "IS_APPROVED", title: "Підтверджено", width: "20%", filterable: false }
            
        ],
        sortable: true,
        //filterable: true,
        dataBound: function () {
            //this.dataSource.options.serverSorting = false;
            //this.dataSource.options.serverPaging = false;
            //this.dataSource.options.serverFiltering = false;
        }
    });

    // Edit Ora Roles:
    $("#edit-oraRoles-grid").kendoGrid({
        height: 440,
        selectable: "row",
        sortable: true,
        dataSource: oraRoles,
        editable: "popup",
        pageable: {
            refresh: true
        },
        columns: [
            {
                field: "ROLE_NAME",
                title: "Назва ролі",
                width: "70%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                title: "Use In/Out",
                template: "<input type='checkbox' class='add-role' data-bind='checked' data-oraRole='#=ROLE_NAME#' />",
                width: "30%"
            }
        ],
        filterable: {
            mode: "row"
        }
    });

    $("#edit-oraRoles-Window").kendoWindow({
        width: "600px",
        height: "500px",
        title: "Доступні ролі Oracle",
        resizable: false,
        visible: false,
        actions: ["Close"]
    });

    $("#edit-ora-ToolBar").kendoToolBar({
        items: [
            { template: "<button id='pbEditOraRoleToUser' type='button' class='k-button' title='Додати роль Oracle'><i class='pf-icon pf-16 pf-ok'></i></button>" },
            { template: "<button id='pbEditRefreshOraRoleGrid' type='button' class='k-button' title='Оновити дані таблиці'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" },
            { template: "<button id='pbEditCloseOraWin' type='button' class='k-button' title='Завершити'><i class='pf-icon pf-16 pf-delete'></i></button>" }
        ]
    });

    $("#pbEditOraRoleToUser").kendoButton({
        click: function () {
            var grid = $("#edit-oraRoles-grid").data("kendoGrid"),
                checkedList = grid.tbody.find("input:checked"),
                oracleRolesList = [],
                i = 0;

            if (checkedList.length > 0) {
                for (i; i < checkedList.length; i++) {
                    oracleRolesList.push(checkedList[i].getAttribute("data-oraRole"));
                }
                $("#ed_ora-roles").val(oracleRolesList.toString());
            } else {
                $("#ed_ora-roles").val("");
            }
            $("#edit-oraRoles-Window").data("kendoWindow").close();
        }
    });

    $("#pbEditRefreshOraRoleGrid").kendoButton({
        click: function () {
            $("#edit-oraRoles-grid").data("kendoGrid").dataSource.read();
        }
    });

    $("#pbEditCloseOraWin").kendoButton({
        click: function () {
            $("#edit-oraRoles-Window").data("kendoWindow").close();
        }
    });
});