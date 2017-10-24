$(document).ready(function () {
    // інструкція ініціалізації табів та ресурсів арму
    function detailInit(e) {
        var detailRow = e.detailRow;
        var masterRow = e.masterRow;
        var grid = this;
        var rowData = grid.dataItem(masterRow);

        // dataSource for tabs:
        var armTabstripDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 20,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/admin/admtabstrip/GetAdmTabstrip"),
                    data: { id: rowData.ARM_CODE },
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
                        RESOURCE_NAME: { type: "string" },
                        ARM_CODE: { type: "string" }
                    }
                }
            }
        });

        detailRow.find(".AdmTabstrip").kendoTabStrip({
            dataTextField: "RESOURCE_NAME",
            dataContentField: "RESOURCE_CODE",
            select: function (e) {
                var data = this.dataSource.at($(e.item).index()),
                    div = $("#admResourcesTemplate").html(),
                    template = kendo.template(div);

                var obj = {
                    ID: data.ID,
                    RESOURCE_CODE: data.RESOURCE_CODE,
                    RESOURCE_NAME: data.RESOURCE_NAME,
                    ADM_ID: rowData.ID
                };

                $(e.contentElement).html(template(obj));
                kendo.bind(e.contentElement, obj);

                bars.tabs.initAdmResourceGrid("#AdmResource" + obj.RESOURCE_CODE + obj.ADM_ID, data.ID, rowData.ID, rowData.ARM_CODE);
            },
            dataSource: armTabstripDataSource
        });
    }


    var admDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/ADM/GetADMList"),
                success: function () {
                    //
                },
                error: function (xhr, error) {
                    bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці." });
                }
            }
        },
        requestStart: function() {
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
                    APPLICATION_TYPE: { type: "string" },
                    ARM_NAME: { type: "string" },
                    ARM_CODE: { type: "string" }
                }
            }
        }
    });

    $("#ADMGrid").kendoGrid({
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
                title: "Ідентифікатор АРМу",
                width: "15%"
            },
            {
                field: "ARM_CODE",
                title: "Код АРМу",
                width: "20%"
            },
            {
                field: "ARM_NAME",
                title: "Назва АРМу",
                width: "40%"
            },
            {
                field: "APPLICATION_TYPE",
                title: "Тип програми-клієнта",
                width: "25%"
            }
        ],
        dataSource: admDataSource,
        filterable: {
            mode: "row"
        },
        //change: updateGrids,
        detailTemplate: kendo.template($("#admDetailsTabs").html()),
        detailInit: detailInit,
        dataBound: function() {
            var grid = $("#ADMGrid").data("kendoGrid");
            if (grid != null) {
                grid.select("tr:eq(2)");
            }

            var removeBtn = $("#RemoveADM").data("kendoButton");
            debugger;
            var currentRow = grid.dataItem(grid.select());
            if (currentRow) {
                removeBtn.enable(true);
            } else {
                removeBtn.enable(false);
            }
        }
    });

    // TABs GRIDS color mark ********************************************************
    /*
    function setOperRowBackColor() {
        var gridOper = $("#grid1").data("kendoGrid"),
            operRow = gridOper.dataItem(gridOper.select());

        gridOper.tbody.find(">tr").each(function () {
            var dataItem = gridOper.dataItem(this);
            if (dataItem.REVOKED === 1 && dataItem.REVOKED !== operRow) {
                $(this).addClass("k-row-isRevoked");
            }
            if (dataItem.APPROVED === 0 && dataItem.APPROVED !== operRow) {
                $(this).addClass("k-row-isApproved");
            }
            if (dataItem.DISABLED === 1 && dataItem.DISABLED !== operRow) {
                $(this).addClass("k-row-isDisabled");
            }
        });
    }

    function setRefRowBackColor() {
        var gridRef = $("#grid3").data("kendoGrid"),
            refRow = gridRef.dataItem(gridRef.select());

        gridRef.tbody.find(">tr").each(function () {
            var dataItem = gridRef.dataItem(this);
            if (dataItem.REVOKED === 1 && dataItem.REVOKED !== refRow) {
                $(this).addClass("k-row-isRevoked");
            }
            if (dataItem.APPROVED === 0 && dataItem.APPROVED !== refRow) {
                $(this).addClass("k-row-isApproved");
            }
            if (dataItem.DISABLED === 1 && dataItem.DISABLED !== refRow) {
                $(this).addClass("k-row-isDisabled");
            }
        });

        $(".acode").on("click", function () {
            var gridADM = $("#ADMGrid").data("kendoGrid"),
                admRow = gridADM.dataItem(gridADM.select()),
                //checked = this.checked;
                row = $(this).closest("tr"),
                //grid = $("#grid3").data("kendoGrid"),
                dataItem = gridRef.dataItem(row);
            $.get(changeRefMode, { mode: $(this).is(':checked'), codeapp: admRow.CODEAPP, tabid: dataItem.TABID }).done(function () { });
        });
    }

    function setRepRowBackColor() {
        var gridRep = $("#grid5").data("kendoGrid"),
            repRow = gridRep.dataItem(gridRep.select());

        gridRep.tbody.find(">tr").each(function () {
            var dataItem = gridRep.dataItem(this);
            if (dataItem.REVOKED === 1 && dataItem.REVOKED !== repRow) {
                $(this).addClass("k-row-isRevoked");
            }
            if (dataItem.APPROVED === 0 && dataItem.APPROVED !== repRow) {
                $(this).addClass("k-row-isApproved");
            }
            if (dataItem.DISABLED === 1 && dataItem.DISABLED !== repRow) {
                $(this).addClass("k-row-isDisabled");
            }
        });
    }

    // TAB Initialize:

    var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
    tabstrip.select(0);
    */
    // TABs GRIDS. ******************************************************************

    // seed param:
    function getCurrentCodeApp() {
        var gridADM = $("#ADMGrid").data("kendoGrid"),
            currentRow = gridADM.dataItem(gridADM.select());
        if (!!currentRow) var codeApp = currentRow.CODEAPP;
        return { codeApp: codeApp };
    }

   
    // Grids buttons functions. *****************************************************************


    // Toolbar functions. ***************************************************************

    var funcType = "none";

    function openCreateADMForm() {
        funcType = "add";
        var win = $("#AddWindow").data("kendoWindow");
        $("#ARMCode").val("");
        $("#ARMName").val("");
        win.center();
        win.open();
    }

    function openEditADMForm() {
        funcType = "edit";
        var win = $("#AddWindow").data("kendoWindow"),
            gridADM = $("#ADMGrid").data("kendoGrid"),
            currentRowDrop = gridADM.dataItem(gridADM.select()),
            appCode = $("#ARMCode").val(currentRowDrop.CODEAPP),
            appName = $("#ARMName").val(currentRowDrop.NAME),
            frontID = $("#dropdownlist").val(currentRowDrop.FRONTEND);
        win.center();
        win.open();
    }

    function closeADMForm() {
        var win = $("#AddWindow").data("kendoWindow");
        win.close();
    }

    function addADM() {
        var appCode = $("#ARMCode").val(),
            appName = $("#ARMName").val(),
            frontID = $("#dropdownlist").val();

        $.get(createAdmUrl, { appCode: appCode, appName: appName, frontID: frontID }).done(function (result) {
            if (result.data === 1) {
                bars.ui.alert({ text: 'АРМ "' + appName + '" успішно додано!' });

            } else {
                bars.ui.error({ text: 'АРМ "' + appCode + '" не можливо додати!' });
            }
        });
        $("#AddWindow").data("kendoWindow").close();
        $("#ADMGrid").data("kendoGrid").dataSource.read();
    }

    function editADM() {
        var appCode = $("#ARMCode").val(),
            appName = $("#ARMName").val(),
            frontID = $("#dropdownlist").val();
        $.get(editAdmUrl, { appCode: appCode, appName: appName, frontID: frontID }).done(function (result) {
            if (result.data === 1) {
                bars.ui.alert({ text: 'АРМ "' + appName + '" успішно змінено!' });
            } else {
                bars.ui.error({ text: 'До АРМу "' + appCode + '" не можливо додати зміни!' });
            }
        });
        $("#AddWindow").data("kendoWindow").close();
        $("#ADMGrid").data("kendoGrid").dataSource.read();
    }

    function inOrderToFuncType() {
        if (funcType === "add") {
            addADM();
        } else {
            editADM();
        }
    }

    $("#editForm").on("submit", inOrderToFuncType);

    $("#EditADM").click(function () {
        $("#ARMCode").attr("disabled", "disabled");
        $("#ARMCode").removeAttr("required");
    });

    $("#AddADM").click(function () {
        $("#ARMCode").removeAttr("disabled");
        $("#ARMCode").attr("required", "required");
    });

    $("#btnCancel").on("click", closeADMForm);

    function removeADM() {
        var gridADM = $("#ADMGrid").data("kendoGrid"),
            currentRowDrop = gridADM.dataItem(gridADM.select());
        $.get(dropAdmUrl, { appCode: currentRowDrop.CODEAPP }).done(function (result) {
            if (result.data === 1) {
                bars.ui.alert({ text: "АРМ " + currentRowDrop.NAME + " успішно видалено!" });
                $("#ADMGrid").data("kendoGrid").dataSource.read();
            }
            else {
                bars.ui.error({ text: "Виникла помилка при видаленні АРМу : " + currentRowDrop.NAME });
                $("#ADMGrid").data("kendoGrid").dataSource.read();
            }
        });
    }

    $("#AddWindow").kendoWindow({
        title: "Налаштування АРМу",
        visible: false,
        width: "300px",
        resizable: false,
        actions: ["Close"]
        /*deactivate: function () {
            this.destroy();
        }*/
    });

    $("#dropdownlist").kendoDropDownList({
        dataTextField: "text",
        dataValueField: "value",
        dataSource: [
          { text: "Centura Desktop", value: "0" },
          { text: "Web Browser", value: "1" },
          { text: "Mobile Device", value: "2" }
        ]
    });

    $("#dropdownlist").change(function () {
        var listVal = $("#dropdownlist").val();
        $("#ARMFrontIntCode").val(listVal);
    }).change();

    
});