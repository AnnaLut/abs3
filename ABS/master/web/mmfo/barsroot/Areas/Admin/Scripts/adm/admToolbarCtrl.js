$(document).ready(function () {

    // ініціалізація kendoToolBar:
    $("#ADMToolBar").kendoToolBar({
        items:
        [
            { template: "<button id='AddADM' type='button' class='k-button' title='Додати АРМ'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='EditADM' type='button' class='k-button' title='Редагувати АРМ'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { template: "<button id='RemoveADM' type='button' class='k-button' title='Видалити АРМ'><i class='pf-icon pf-16 pf-table_row-delete2'></i></button>" }
            //{ template: "<button id='RefreshADMGrid' type='button' class='k-button' title='Оновити дані таблиці АРМів'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" }
        ]
    });

    // Clean all inputs:
    function cleanUp() {
        $(":input").val("");
    }

    var appTypeDropdownDataSource = [
        { NAME: "Web Browser", ID: 1 },
        { NAME: "Centura Desktop", ID: 0 }
    ];

    // TODO: !!!!!!!!
    var appTypeDataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 20,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/admin/../..") // TODO: action
            }
        }
    });

    // опис функцій кнопок kendoToolBar-у:
    // create ADM.
    $("#CreateAdm-Window").kendoWindow({
        title: "Створення нового АРМу",
        visible: false,
        width: "400px",
        resizable: false,
        actions: ["Close"]
    });

    function createAdm() {
        cleanUp();

        $("#admAppType").kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            //optionLabel: "Обрати...",
            index: 0,
            dataSource: appTypeDropdownDataSource
        });

        var window = $("#CreateAdm-Window").data("kendoWindow");
        window.center();
        window.open();
    }

    $("#admCode").keyup(function () {
        this.value = this.value.replace(/[\u0400-\u04FF]/gi, "");
        this.value = this.value.replace(/[\\~#%&*,_+={}/:<>.?|\"-]/gi, "");
        this.value = this.value.toUpperCase();
    });

    // edit ADM.
    $("#EditAdm-Window").kendoWindow({
        title: "Редагування АРМу",
        visible: false,
        width: "400px",
        resizable: false,
        actions: ["Close"]
    });

    function getEditAdmData() {
        var grid = $("#ADMGrid").data("kendoGrid"),
            currentRow = grid.dataItem(grid.select());
        return {
            ARM_CODE: currentRow.ARM_CODE,
            ARM_NAME: currentRow.ARM_NAME,
            APPLICATION_TYPE: currentRow.APPLICATION_TYPE
        }
    }

    function editAdm() {
        var editModel = getEditAdmData(),
               template = kendo.template($("#EditAdm").html()),
               window = $("#EditAdm-Window").data("kendoWindow"),
               editBox = $("#EditBoxAdm");
        editBox.html(template(editModel));

        $("#admAppTypeEdit").kendoDropDownList({
            dataTextField: "NAME",
            dataValueField: "ID",
            dataSource: appTypeDropdownDataSource
        });

        window.center();
        window.open();
    }

    // ініціалізація кнопок kendoToolBar-у:
    $("#AddADM").kendoButton({
        click: createAdm,
        enable: true
    });

    $("#EditADM").kendoButton({
        click: editAdm,
        enable: true
    });

    /* --- Remove ADM --- */

    function admRemoveRequest(code, parentObj) {
        $.get(bars.config.urlContent("/api/admin/admremove/get"), { armCode: code }).done(function(result) {
            if (result.Data === 1) {
                bars.ui.alert({ text: "АРМ \"" + code + "\" успішно видалено!" });
                parentObj.dataSource.read();
                return true;
            }
            else {
                bars.ui.error({
                    text: "Помилка видалення \"" + code + "\"!" +
                        result.Msg
                });
                parentObj.dataSource.read();
                return false;
            }
        });
    }

    function removeAdm() {
        debugger;
        var grid = $("#ADMGrid").data("kendoGrid"),
            currentRow = grid.dataItem(grid.select());
       
        bars.ui.confirm({ text: "Арм \"" + currentRow.ARM_CODE + "\" буде видалено, продовжити?" }, function () {
            // check app resource list:
            debugger;
            $.get(bars.config.urlContent("/api/admin/admcheckresources/get"), { armCode: currentRow.ARM_CODE }).done(function (result) {
                if (result.Data === 1) {
                    bars.ui.confirm({ text: "АРМ \"" + currentRow.ARM_CODE + "\" має ресурси!<br/>Анулювати ресурси та продовжити видалення АРМу?" }, function () {
                        debugger;
                        admRemoveRequest(currentRow.ARM_CODE, grid);
                    });
                }
                else if (result.Data === 0) {
                    debugger;
                    admRemoveRequest(currentRow.ARM_CODE, grid);
                } else {
                    bars.ui.error({ text: result.Msg });
                }
            });
        });
    }

    $("#RemoveADM").kendoButton({
        click: removeAdm,
        enable: false
    });
    //$("#RefreshADMGrid").kendoButton({
    //    //click: function () {
    //    //    $("#ADMGrid").data("kendoGrid").dataSource.read();
    //    //},
    //    enable: false
    //});
});