$(document).ready(function () {

    // Clean all inputs:
    function cleanUp() {
        $(":input").val(""); 
    }

    $("#RolesToolbar").kendoToolBar({
        items: [
            { template: "<button id='pbCreateRole' type='button' class='k-button' title='Додати роль'><i class='pf-icon pf-16 pf-add_button'></i></button>" },
            { template: "<button id='pbEditRole' type='button' class='k-button' title='Редагувати роль'><i class='pf-icon pf-16 pf-tool_pencil'></i></button>" },
            { template: "<button id='pbUnlockUser' type='button' class='k-button' title='Активація ролі'><i class='pf-icon pf-16 pf-security_unlock'></i></button>" },
            { template: "<button id='pblockUser' type='button' class='k-button' title='Деактивація ролі'><i class='pf-icon pf-16 pf-security_lock'></i></button>" },
            { template: "<button id='deleteUser' type='button' class='k-button' title='Видалення ролі'><i class='pf-icon pf-16 pf-delete_button_error'></i></button>" },
            { template: "<button id='pbFilter' type='button' class='k-button' title='Складний фільтр'><i class='pf-icon pf-16 pf-filter-ok'></i></button>" },
           { template: "<button id='pbRefresh' type='button' class='k-button' title='Оновити грід'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" }
        ]
    });

    // Create Role Start
    $("#CreateRole-Window").kendoWindow({
        title: "Створення нової ролі",
        visible: false,
        width: "400px",
        resizable: false,
        actions: ["Close"]
    });

    $("#pbCreateRole").kendoButton({
        click: function () {
            cleanUp();

            var window = $("#CreateRole-Window").data("kendoWindow");
            window.center();
            window.open();
        },
        enable: true
    });

    // Edit Role Start
    function getEditRoleData() {
        var grid = $("#RolesGrid").data("kendoGrid"),
                currentRow = grid.dataItem(grid.select()),
                id = currentRow.ID,
                roleCode = currentRow.ROLE_CODE,
                roleName = currentRow.ROLE_NAME,
                stateName = currentRow.STATE_NAME;
        return {
            ID: id,
            ROLE_CODE: roleCode,
            ROLE_NAME: roleName,
            STATE_NAME: stateName
        }
    }

    $("#EditRole-Window").kendoWindow({
        title: "Редагування ролі",
        visible: false,
        width: "400px",
        resizable: false,
        actions: ["Close"]
    });

    $("#pbEditRole").kendoButton({
        click: function () {
            var editModel = getEditRoleData(),
                template = kendo.template($("#Edit").html()),
                window = $("#EditRole-Window").data("kendoWindow"),
                editBox = $("#EditBox");
            editBox.html(template(editModel));

            window.center();
            window.open();
        },
        enable: true
    });

    $("#pbFilter").kendoButton({
        click: function () {
            bars.ui.getFiltersByMetaTable(function (response) {
                if (response.length > 0) {
                    var grid = $("#RolesGrid").data("kendoGrid");

                    paramObj.urlParams = response.join(' and ');
                    //localStorage.setItem('paramObj', JSON.stringify(paramObj));

                    grid.dataSource.read({
                        parameters: paramObj.urlParams
                    });
                }
            }, { tableName: "V_STAFF_ROLE_ADM" });
        }
    });

    $("#pbRefresh").kendoButton({
        click: function () {
            paramObj.urlParams = '';
            $("#RolesGrid").data("kendoGrid").dataSource.read({
                parameters: paramObj.urlParams
            });
        }
    });

    // Unlock role:
    $("#pbUnlockUser").kendoButton({
        click: function () {
            var role = getEditRoleData();
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/admin/roles/UnlockRole"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({ roleCode: role.ROLE_CODE }),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result.message });
                $("#EditRole-Window").data("kendoWindow").close();
                $("#RolesGrid").data("kendoGrid").dataSource.read();
            });
        },
        enable: false
    });

    // Lock role:
    $("#pblockUser").kendoButton({
        click: function () {
            var role = getEditRoleData();
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/admin/roles/LockRole"),
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify({ roleCode: role.ROLE_CODE }),
                traditional: true
            }).done(function (result) {
                bars.ui.alert({ text: result.message });
                $("#EditRole-Window").data("kendoWindow").close();
                $("#RolesGrid").data("kendoGrid").dataSource.read();
            });
        },
        enable: false
    });

    // Delete role:
    $("#deleteUser").kendoButton({
        click: function () {
            var role = getEditRoleData();
            bars.ui.confirm({
                text: role.ROLE_NAME + ' буде видалено'
            }, function () {
                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/admin/roles/DeleteRole"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify({ roleCode: role.ROLE_CODE }),
                    traditional: true
                }).done(function (result) {
                    bars.ui.alert({ text: result.message });
                    $("#RolesGrid").data("kendoGrid").dataSource.read();
                });
            });
           
        }
    });

});