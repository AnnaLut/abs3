$(document).ready(function () {
    
    var homogeneous = new kendo.data.HierarchicalDataSource({
        transport: {
            read: {
                url: bars.config.urlContent("/admin/typicaluser/BranchData"),
                dataType: "json"
            }
        },
        schema: {
            model: {
                id: "BranchId",
                hasChildren: "HasSubBranch"
            }
        }
    });

    // function that gathers IDs of checked nodes
    function checkedNodeIds(nodes, checkedNodes) {
        for (var i = 0; i < nodes.length; i++) {
            if (nodes[i].checked) {
                checkedNodes.push(nodes[i].id);
            }

            if (nodes[i].hasChildren) {
                checkedNodeIds(nodes[i].children.view(), checkedNodes);
            }
        }
        return checkedNodes;
    }
    var viewModel = {
        myClickHandler: function () {
            var checkedNodes = [],
            treeView = $("#treeview").data("kendoTreeView");
            checkedNodeIds(treeView.dataSource.view(), checkedNodes);
            //alert(typeof checkedNodes);
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/admin/typicaluser/CheckedList"),
                dataType: "json",
                data: { chkList: JSON.stringify(checkedNodes) }
            });
        }
    };
    // show checked node IDs on datasource change
    function onCheck() {
        var checkedNodes = [],
            treeView = $("#treeview").data("kendoTreeView"),
            message;

        kendo.bind($("#buttonsContainer"), viewModel);

        checkedNodeIds(treeView.dataSource.view(), checkedNodes);

        if (checkedNodes.length > 0) {
            message = "IDs of checked nodes: " + checkedNodes.join(",");
        } else {
            message = "No nodes checked.";
        }

        $("#result").html(message);
    }

    $("#treeview").kendoTreeView({
        dataSource: homogeneous,
        dataTextField: "BranchName",
        checkboxes: true,
        check: onCheck
    });

    

    


    /*
    var gridDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/typicaluser/GetTypicalUsersData"),
                success: function () {
                    //TODO:
                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці." });
                }
            }
        },
        requestStart: function (e) {
            bars.ui.loader("body", true);
        },
        requestEnd: function (e) {
            bars.ui.loader("body", false);
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });

    function gridsSynchronizer() {
        var grid = $("#TypicalUsersGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        if (!!currentRow) {
            $("#grid1").data("kendoGrid").dataSource.read();
            $("#grid2").data("kendoGrid").dataSource.read();
            $("#grid3").data("kendoGrid").dataSource.read();
            $("#grid4").data("kendoGrid").dataSource.read();
            $("#grid5").data("kendoGrid").dataSource.read();
            $("#grid6").data("kendoGrid").dataSource.read();
            $("#grid7").data("kendoGrid").dataSource.read();
            $("#grid8").data("kendoGrid").dataSource.read();
            $("#grid9").data("kendoGrid").dataSource.read();
            $("#grid10").data("kendoGrid").dataSource.read();
        }
    }

    function defaultRow() {
        var grid = $("#TypicalUsersGrid").data("kendoGrid");
        if (!!grid) {
            grid.select("tr:eq(2)");
        }
    }

    $("#TypicalUsersGrid").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "ID",
                title: "Код #",
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
                field: "NAME",
                title: "Назва",
                width: "90%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: gridDataSource,
        filterable: {
            mode: "row"
        },
        change: gridsSynchronizer,
        dataBound: defaultRow
    });

    // Tab init:
    var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
    tabstrip.select(0);

    // seed param:
    function getCurrentUserId() {
        var grid = $("#TypicalUsersGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow)
            var userID = currentRow.ID;
        return { userID: userID };
    }
    // Grids dataBound:
    function setAPPsRowBackColor() {
        var gridApps = $("#grid1").data("kendoGrid");
        var appRow = gridApps.dataItem(gridApps.select());

        gridApps.tbody.find('>tr').each(function () {
            var dataItem = gridApps.dataItem(this);
            if (dataItem.REVOKED == 1 && dataItem.REVOKED != appRow) {
                $(this).addClass('k-row-isRevoked');
            }
            if (dataItem.APPROVED == 0 && dataItem.APPROVED != appRow) {
                $(this).addClass('k-row-isApproved');
            }
            if (dataItem.DISABLED == 1 && dataItem.DISABLED != appRow) {
                $(this).addClass('k-row-isDisabled');
            }
        });
    }

    function setTTSsRowBackColor() {
        var gridTTs = $("#grid3").data("kendoGrid");
        var ttsRow = gridTTs.dataItem(gridTTs.select());

        gridTTs.tbody.find('>tr').each(function () {
            var dataItem = gridTTs.dataItem(this);
            if (dataItem.REVOKED == 1 && dataItem.REVOKED != ttsRow) {
                $(this).addClass('k-row-isRevoked');
            }
            if (dataItem.APPROVED == 0 && dataItem.APPROVED != ttsRow) {
                $(this).addClass('k-row-isApproved');
            }
            if (dataItem.DISABLED == 1 && dataItem.DISABLED != ttsRow) {
                $(this).addClass('k-row-isDisabled');
            }
        });
    }

    function setCHKGrpsRowBackColor() {
        var gridCHKGrps = $("#grid5").data("kendoGrid");
        var chkgrpRow = gridCHKGrps.dataItem(gridCHKGrps.select());

        gridCHKGrps.tbody.find('>tr').each(function () {
            var dataItem = gridCHKGrps.dataItem(this);
            if (dataItem.REVOKED == 1 && dataItem.REVOKED != chkgrpRow) {
                $(this).addClass('k-row-isRevoked');
            }
            if (dataItem.APPROVED == 0 && dataItem.APPROVED != chkgrpRow) {
                $(this).addClass('k-row-isApproved');
            }
            if (dataItem.DISABLED == 1 && dataItem.DISABLED != chkgrpRow) {
                $(this).addClass('k-row-isDisabled');
            }
        });
    }

    function setNBURepsRowBackColor() {
        var gridNBUReps = $("#grid7").data("kendoGrid");
        var nburepROW = gridNBUReps.dataItem(gridNBUReps.select());

        gridNBUReps.tbody.find('>tr').each(function () {
            var dataItem = gridNBUReps.dataItem(this);
            if (dataItem.REVOKED == 1 && dataItem.REVOKED != nburepROW) {
                $(this).addClass('k-row-isRevoked');
            }
            if (dataItem.APPROVED == 0 && dataItem.APPROVED != nburepROW) {
                $(this).addClass('k-row-isApproved');
            }
            if (dataItem.DISABLED == 1 && dataItem.DISABLED != nburepROW) {
                $(this).addClass('k-row-isDisabled');
            }
        });
    }

    function setUserGrpRowBackColor() {
        var gridUserGrp = $("#grid9").data("kendoGrid");
        var userGrpROW = gridUserGrp.dataItem(gridUserGrp.select());

        gridUserGrp.tbody.find('>tr').each(function () {
            var dataItem = gridUserGrp.dataItem(this);
            if (dataItem.REVOKED == 1 && dataItem.REVOKED != userGrpROW) {
                $(this).addClass('k-row-isRevoked');
            }
            if (dataItem.APPROVED == 0 && dataItem.APPROVED != userGrpROW) {
                $(this).addClass('k-row-isApproved');
            }
            if (dataItem.DISABLED == 1 && dataItem.DISABLED != userGrpROW) {
                $(this).addClass('k-row-isDisabled');
            }
        });

        // *********CheckBoxes

        var gridADMU = $("#ADMUGrid").data("kendoGrid");
        var admuRow = gridADMU.dataItem(gridADMU.select());
        var grid = $("#grid9").data("kendoGrid");

        $(".PR").on("click", function () {
            //var checked = this.checked;
            var row = $(this).closest("tr");
            var dataItem = grid.dataItem(row);

            $.get(chkBoxAction, { userId: admuRow.USER_ID, tabid: dataItem.IDG, pr: $(this).is(":checked"), deb: dataItem.DEB, cre: dataItem.CRE }).done(function () { });
        });
        $(".DEB").on("click", function () {
            var row = $(this).closest("tr");
            var dataItem = grid.dataItem(row);

            $.get(chkBoxAction, { userId: admuRow.USER_ID, tabid: dataItem.IDG, pr: dataItem.PR, deb: $(this).is(":checked"), cre: dataItem.CRE }).done(function () { });
        });
        $(".CRE").on("click", function () {
            var row = $(this).closest("tr");
            var dataItem = grid.dataItem(row);

            $.get(chkBoxAction, { userId: admuRow.USER_ID, tabid: dataItem.IDG, pr: dataItem.PR, deb: dataItem.DEB, cre: $(this).is(":checked") }).done(function () { });
        });
    }

    // APPs:
    var userApps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/APP/GetCurrentUserAPPs"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    CODEAPP: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    var apps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/APP/GetAllAPPsGrid"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    CODEAPP: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    $("#grid1").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: userApps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        columns: [
            {
                field: "CODEAPP",
                title: "Код АРМу",
                width: "40%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва",
                width: "60%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        filterable: {
            mode: "row"
        },
        dataBound: setAPPsRowBackColor
    });
    $("#grid2").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: apps,
        autoBind: false,
        editable: "popup",
        filterable: {
            mode: "row"
        },
        pageable: {
            refresh: true
        },
        columns: [
            {
                field: "CODEAPP",
                title: "Код АРМу",
                width: "30%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва",
                width: "70%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ]
    });

    //TTSs (operations):
    var userTTSs = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/TTS/GetCurrentUserTTS"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    TT: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    var ttss = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/TTS/GetAllTTSGrid"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TT: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    $("#grid3").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: userTTSs,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
            {
                field: "TT",
                title: "Код операції",
                width: "40%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва",
                width: "60%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataBound: setTTSsRowBackColor
    });
    $("#grid4").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: ttss,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
           {
               field: "TT",
               title: "Код операції",
               width: "30%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "NAME",
               title: "Назва",
               width: "70%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           }
        ]
    });

    // CHKGRPS - Check Groups
    var userChkGrps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/CHKGrps/GetCurrentUserCHKGrps"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    CHKID: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    var chkGrps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/CHKGrps/GetAllCHKGrpsGrid"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    CHKID: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    $("#grid5").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: userChkGrps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
            {
                field: "CHKID",
                title: "Код групи",
                width: "40%",
                filterable: {
                    cell: {
                        template: function (args) {
                            args.element.kendoNumericTextBox({
                                format: '#',
                                decimals: 0
                            });
                        }

                    }
                }
            },
            {
                field: "NAME",
                title: "Назва",
                width: "60%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataBound: setCHKGrpsRowBackColor
    });
    $("#grid6").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: chkGrps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
           {
               field: "CHKID",
               title: "Код групи",
               width: "30%",
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
               field: "NAME",
               title: "Назва",
               width: "70%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           }
        ]
    });

    // NBUREPS - NBU Reports
    var userNbuReps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/NBUReps/GetCurrentUserNBUReps"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    KODF: { type: "string" },
                    A017: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    var nbuReps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent("/admin/NBUReps/GetNBURepsGrid"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    KODF: { type: "string" },
                    A017: { type: "string" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    $("#grid7").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: userNbuReps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
            {
                field: "KODF",
                title: "Код звіту",
                width: "20%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "A017",
                title: "Схема",
                width: "20%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва",
                width: "60%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataBound: setNBURepsRowBackColor
    });
    $("#grid8").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: nbuReps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
           {
               field: "KODF",
               title: "Код звіту",
               width: "30%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "A017",
               title: "Схема",
               width: "30%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "NAME",
               title: "Назва",
               width: "40%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           }
        ]
    });

    // UserGrps / Groups of users
    var userGrps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/UserGrp/GetUserGrpsGrid"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            model: {
                fields: {
                    IDG: { type: "number" },
                    NAME: { type: "string" },
                    PR: { type: "boolean" },
                    DEB: { type: "boolean" },
                    CRE: { type: "boolean" }
                }
            }
        }
    });
    var grps = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/UserGrp/GetGrps"),
                data: getCurrentUserId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });
    $("#grid9").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: userGrps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
            {
                field: "IDG",
                title: "Код",
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
                field: "NAME",
                title: "Назва",
                width: "40%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "PR",
                title: "П",
                width: "10%",
                template: "<div style='text-align:center'><input class='PR' name='PR' type='checkbox' data-bind='checked: PR' #= PR ? checked='checked' : '' #/></div>"
            },
            {
                field: "DEB",
                title: "Д",
                width: "10%",
                template: "<div style='text-align:center'><input class='DEB' name='DEB' type='checkbox' data-bind='checked: DEB' #= DEB ? checked='checked' : '' #/></div>"
            },
            {
                field: "CRE",
                title: "К",
                width: "10%",
                template: "<div style='text-align:center'><input class='CRE' name='CRE' type='checkbox' data-bind='checked: CRE' #= CRE ? checked='checked' : '' #/></div>"
            }
        ],
        dataBound: setUserGrpRowBackColor
    });
    $("#grid10").kendoGrid({
        height: 400,
        selectable: "row",
        sortable: true,
        dataSource: grps,
        autoBind: false,
        editable: "popup",
        pageable: {
            refresh: true
        },
        filterable: {
            mode: "row"
        },
        columns: [
           {
               field: "ID",
               title: "Код",
               width: "30%",
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
               field: "NAME",
               title: "Назва",
               width: "40%",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           }
        ]
    });


    */
});