$(document).ready(function () {

    function setDefaultRow() {
        var grid = $("#ListSetGrid").data("kendoGrid");
        if (grid != null) {
            grid.select("tr:eq(1)");
        }
    }

    function getCurrentSetId() {
        var grid = $("#ListSetGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            return { setId: currentRow.ID };
        }
        return null;
    }

    function refreshGrids() {
        $("#ListSetGrid").data("kendoGrid").dataSource.read();
        $("#ListSetGrid").data("kendoGrid").refresh();
        // need or not?
        //$("#InUse").data("kendoGrid").dataSource.read();
        //$("#InUse").data("kendoGrid").refresh();

        //$("#OutUse").data("kendoGrid").dataSource.read();
        //$("#OutUse").data("kendoGrid").refresh();
    }

    function updateData() {
        var grid = $("#ListSetGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());
        if (!!currentRow) {
            $("#InUse").data("kendoGrid").dataSource.read();
            $("#InUse").data("kendoGrid").refresh();

            $("#OutUse").data("kendoGrid").dataSource.read();
            $("#OutUse").data("kendoGrid").refresh();
        }
    }

    var localListSetDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 5,
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/admin/listset/GetListSetData")
            },
            update: function (e) {
                var item = e.data;
                alert("ID = " + item.ID + " mask = " + item.ACC_MASK);
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "ID",
                fields: {
                    ID: { type: "number", editable: false },
                    NAME: { type: "string", validation: { required: true } },
                    COMMENTS: { type: "string" }
                }
            }
        }
    });

    $("#ListSetGrid").kendoGrid({
        autoBind: true,
        selectable: "row",
        toolbar: kendo.template($("#addSet-template").html()),
        columns: [
            {
                field: "ID",
                title: "Код",
                width: "10%"
            },
            {
                field: "NAME",
                title: "Назва",
                width: "20%"
            },
            {
                field: "COMMENTS",
                title: "Коментар",
                width: "50%"
            },
            {
                command: [ "edit", {
                    name: "Видалити",
                    click: function (e) {  
                        var tr = $(e.target).closest("tr"); 
                        var data = this.dataItem(tr); 

                        bars.ui.confirm({
                            text: "Ви дійсно бажаєте видалити набір: <br/><b>" + data.NAME + "</b> ?"
                        }, function() {
                            $.ajax({
                                type: "POST",
                                url: bars.config.urlContent("/api/admin/listset/DropSet?id=" + data.ID),
                                dataType: "json"
                            }).done(function (result) {
                                bars.ui.alert({ text: result });
                                refreshGrids();
                            });
                        });
                    }
                }],
                title: "Редагування", width: "30%"
            }
        ],
        editable: "inline",
        cancel: function(e) {
            this.refresh();
        },
        save: function (e) {
            var item = e.model;
            var strParam = "id=" + item.ID + "&name=" + item.NAME + "&comm=" + item.COMMENTS;
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/listset/SaveSetChanges?" + strParam),
                dataType: "json"
            }).done(function (result) {
                bars.ui.alert({ text: result });
                refreshGrids();
            });
        },
        filterable: true,
        scrollable: true,
        sortable: true,
        pageable: true,
        dataSource: localListSetDataSource,
        change: updateData,
        dataBound: function () {
            setDefaultRow();
        }
    });



    $("#listSet-tbl").hide();
    var listSetWindow = $("#listSet-window").kendoWindow({
        title: "Додавання нового набору функцій",
        visible: false,
        width: "600px",
        scrollable: false,
        resizable: false,
        modal: true,
        actions: ["Close"]
    });
    function addListSet() {
        var window = listSetWindow.data("kendoWindow");
        window.center().open();
        $("#listSet-tbl").show();

        $("#set-add").unbind( "click" ).on("click", function () {
            var obj = $("#listSet-form").serialize();
            $(":input").val("");
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/admin/listset/CreateSet?" + obj),
                dataType: "json"
            }).done(function (result) {
                bars.ui.alert({ text: result });
                refreshGrids();
            });
            window.close();
        });
    }
    $("#addSetBtn").on("click", addListSet);

    function closeAndClearWindow() {
        $(":input").val("");
        $(this).closest("[data-role=window]").kendoWindow("close");
    }
    $("#set-cencel").on("click", closeAndClearWindow);


    
    var removeOutOperDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        //pageSize: 10, 
        serverPaging: true,
        serverFiltering: true,
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/admin/listset/GetOperlistHandbookData"),
                data: getCurrentSetId
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "CODEOPER",
                fields: {
                    CODEOPER: { type: "number" },
                    NAME: { type: "string" }
                }
            }
        }
    });

    var outUseGrid = $("#OutUse").kendoGrid({
        selectable: "row",
        autoBind: false,
        filterable: true,
        scrollable: true,
        height: 500,
        sortable: true,
        columns: [
            {
                field: "CODEOPER",
                title: "Код",
                width: "20%"
            },
            {
                field: "NAME",
                title: "Назва функції",
                width: "80%"
            }
        ],
        dataSource: removeOutOperDataSource
    }).data("kendoGrid");

    function activityOptions() {
        // checkboxs event
        $(".activity").on("click", function () {
            //var grid = $("#ListSetGrid").data("kendoGrid");
            //var record = grid.dataItem(grid.select());

            var row = $(this).closest("tr");
            var gridProp = $("#InUse").data("kendoGrid");
            var dataItem = gridProp.dataItem(row);

            if (this.checked) {
                dataItem.FUNC_ACTIVITY = 1;
            } else {
                dataItem.FUNC_ACTIVITY = 0;
            }
            alert("ch = " + dataItem.FUNC_ACTIVITY);
            /*$.ajax({
                type: "POST",
                url: bars.config.urlContent(""),
                dataType: "json",
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result });
                $("#InUse").data("kendoGrid").dataSource.read();
                $("#InUse").data("kendoGrid").refresh();
            });*/
        });

        // color row mark
        var grid = $("#InUse").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        grid.tbody.find(">tr").each(function () {
            var dataItem = grid.dataItem(this);
            
            if (dataItem.REC_ID == -1 && dataItem.REC_ID != currentRow) {
                $(this).addClass("k-row-isApproved");
            }
            
        });
    }

    var inUseGrid = $("#InUse").kendoGrid({
        selectable: "row",
        autoBind: false,
        filterable: true,
        scrollable: true,
        height: 500,
        sortable: true,
        //pageable: true,
        columns: [
            /*{
                hidden: true,
                field: "FUNC_ID",
                title: "Код"
            },
            {
                field: "FUNC_POSITION",
                title: "SavedPos",
                width: "10%"
            },*/
            {
                field: "FUNCNAME",
                title: "Назва функції",
                width: "25%"
            },
            {
                field: "FUNC_ACTIVITY",
                title: "V",
                width: "5%",
                filterable: false,
                template: "<input class='activity' name='activity' type='checkbox' #: FUNC_ACTIVITY === 1 ? 'checked=checked' : '' #></input>"
            },
            {
                field: "FUNC_COMMENTS",
                title: "Коментар",
                width: "50%"
            },
            { command: ["edit"], title: "&nbsp;", width: "20%" }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            //pageSize: 10, 
            serverPaging: true,
            serverFiltering: true,
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/admin/listset/GetListfuncsetData"),
                    data: getCurrentSetId
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    id: "FUNC_ID",
                    fields: {
                        FUNC_ID: { type: "number" },
                        FUNCNAME: { type: "string", editable: false },
                        REC_ID: { type: "number" },
                        SET_ID: { type: "number" },
                        FUNC_ACTIVITY: { type: "number", editable: false },
                        FUNC_POSITION: { type: "number", editable: false },
                        FUNC_COMMENTS: { type: "string", editable: true },
                        KF: { type: "string" }
                    }
                }
            }
        },
        editable: "inline", // popup
        dataBound: activityOptions
    }).data("kendoGrid");


    // DragAndDrop inside InUse:
    /*inUseGrid.table.kendoSortable({
        filter: ">tbody >tr",
        hint: $.noop,
        cursor: "move",
        placeholder: function (element) {
            return element.clone().addClass("k-state-hover").css("opacity", 0.65);
        },
        container: "#InUse tbody",
        change: function (e) {

            var oldIndex = e.oldIndex;
            var newIndex = e.newIndex;
            var data = inUseGrid.dataSource.data();
            var dataItem = inUseGrid.dataSource.getByUid(e.item.data("uid"));

            inUseGrid.dataSource.remove(dataItem);
            inUseGrid.dataSource.insert(newIndex, dataItem);
        }
    });*/

    // Grids commands:

    function moveToIn(from, to) {
        var grid = $("#ListSetGrid").data("kendoGrid");
        var currentRow = grid.dataItem(grid.select());

        var selected = from.select();
        if (selected.length > 0) {
            var items = [];
            $.each(selected, function (idx, elem) {
                items.push(from.dataItem(elem));
            });
            $.each(items, function (idx, elem) {
                var obj = "id=" + currentRow.ID + "&funcId=" + elem.CODEOPER;
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/listset/AddToInUse?" + obj),
                    dataType: "json"
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#InUse").data("kendoGrid").dataSource.read();
                    $("#InUse").data("kendoGrid").refresh();
                    $("#OutUse").data("kendoGrid").dataSource.read();
                    $("#OutUse").data("kendoGrid").refresh();
                });
            });
            //toDS.sync();
            //fromDS.sync();
        }
    }

    function moveToOut(from, to) {
        var selected = from.select();
        if (selected.length > 0) {
            var items = [];
            $.each(selected, function (idx, elem) {
                items.push(from.dataItem(elem));
            });
            $.each(items, function (idx, elem) {
                var obj = "id=" + elem.SET_ID + "&funcId=" + elem.FUNC_ID;
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/admin/listset/MoveFromInUse?" + obj),
                    dataType: "json"
                }).done(function (result) {
                    bars.ui.alert({ text: result });
                    $("#InUse").data("kendoGrid").dataSource.read();
                    $("#InUse").data("kendoGrid").refresh();
                    $("#OutUse").data("kendoGrid").dataSource.read();
                    $("#OutUse").data("kendoGrid").refresh();
                });
            });
            //toDS.sync();
            //fromDS.sync();
        }
    }

    $("#copyIn").on("click", function () {
        var gridOuts = $("#OutUse").data("kendoGrid");
        var rowIn = gridOuts.dataItem(gridOuts.select());
        if (rowIn != null) {
            moveToIn(outUseGrid, inUseGrid);
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    });

    $("#copyOut").on("click", function () {
        var gridIns = $("#InUse").data("kendoGrid");
        var rowOut = gridIns.dataItem(gridIns.select());
        if (rowOut != null) {
            moveToOut(inUseGrid, outUseGrid);
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    });

    function up() {
        var gridIns = $("#InUse").data("kendoGrid");
        var dataItem = gridIns.dataItem(gridIns.select());
        
        if (dataItem != null) {
            var index = gridIns.dataSource.indexOf(dataItem);
            var newIndex = Math.max(0, index - 1);

            if (newIndex != index) {
                gridIns.dataSource.remove(dataItem);
                gridIns.dataSource.insert(newIndex, dataItem);
            }
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    }
    $("#up").on("click", function() {
        up();
    });

    function down() {
        var gridIns = $("#InUse").data("kendoGrid");
        var dataItem = gridIns.dataItem(gridIns.select());
        
        if (dataItem != null) {
            var index = gridIns.dataSource.indexOf(dataItem);
            var newIndex = Math.min(gridIns.dataSource.total() - 1, index + 1);

            if (newIndex != index) {
                gridIns.dataSource.remove(dataItem);
                gridIns.dataSource.insert(newIndex, dataItem);
            }
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    }
    $("#down").on("click", function () {
        down();
    });


    /*

    function drop() {
        var gridIns = $("#InUse").data("kendoGrid");
        var dataItem = gridIns.dataItem(gridIns.select());

        if (dataItem != null) {
            //gridIns.dataSource.remove(dataItem);
            // change some status to 0? after drop from grid...
            moveTo(inUseGrid, outUseGrid);
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    }
    $("#drop").on("click", function () {
        drop();
    });

    function add(e) {

        var gridIns = $("#InUse").data("kendoGrid");
        var dataItem = gridIns.dataItem(gridIns.select());

        if (dataItem != null) {
            
            if (dataItem.FUNC_ACTIVITY == 1) {
                dataItem.FUNC_ACTIVITY = 0;
                // get
            } else {
                dataItem.FUNC_ACTIVITY = 1;
                // get
            }
        }
        else {
            bars.ui.alert({ text: 'Не обрано операції!' });
        }
    }
    $("#add").on("click", function (e) {
        add(e);
    });

    */

});