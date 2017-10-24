if (!("bars" in window)) window["bars"] = {};
bars.tabs = bars.tabs || {
    roleGrid: $("#RolesGrid").data("kendoGrid"),
    loadTemplate: function (path) {
        $.get(path).success(function (result) {
            $("body").append(result);
        }).error(function (result) {
            alert("Помилка завантаження шаблону!");
        });
    },
    resourceModel: function(roleId, resCode) {
        return {
            id: roleId,
            code: resCode
        }
    },
    admModel: function (admId, admCode) {
        return {
            id: admId,
            code: admCode
        }
    },
    initRoleResourceGrid: function(selector, tabResourceCode, roleId, roleCode) {
        var self = bars.tabs,
            resModel = self.resourceModel(roleId, tabResourceCode);

        $(selector).kendoGrid({
            selectable: "row",
            autoBind: true,
            editable: true,
            columns: [
                {
                    hidden: true,
                    field: "ROLE_ID",
                    title: "Ідентифікатор ролі",
                    width: 100
                }, {
                    hidden: true,
                    field: "RESOURCE_TYPE_NAME",
                    title: "Назва типу ресурсу",
                    width: 100
                }, {
                    hidden: true,
                    field: "RESOURCE_TYPE_ID",
                    title: "Ідентифікатор типу ресурсу",
                    width: 100
                }, {
                    field: "RESOURCE_NAME",
                    title: "Назва ресурсу",
                    width: "50%"
                }, {
                    hidden: true,
                    field: "RESOURCE_ID",
                    title: "Ідентифікатор ресурсу",
                    width: 100
                }, {
                    field: "RESOURCE_CODE",
                    title: "Код ресурсу",
                    width: "20%"
                }, {
                    hidden: true,
                    field: "IS_GRANTED",
                    title: "Код access",
                    width: 100
                }, {
                    field: "IS_GRANTED_NAME",
                    filterable: false,
                    title: "Доступ",
                    editor: function (container) {
                        var input = $('<input id="ACCESS_MODE_ID" name="ACCESS_MODE_NAME">');
                        input.appendTo(container);
                        // initialize a dropdownlist
                        input.kendoDropDownList({
                            dataTextField: "ACCESS_MODE_NAME",
                            dataValueField: "ACCESS_MODE_ID",
                            optionLabel: "Змінити на...",
                            dataSource: {
                            transport: {
                                        read: {
                                            type: "GET",
                                            dataType: 'json',
                                            contentType: 'application/json',
                                            url: bars.config.urlContent('/api/admin/RoleResourceAccess/'),
                                            data: { id: tabResourceCode }
                                        }
                                },
                                schema: {
                                    data: "Data"
                                }
                            },
                            change: function (e) {
                                var accessTypeModeId = this.value(),
                                    grid = $(selector).data("kendoGrid"),
                                    row = grid.dataItem(grid.select());

                                var accessModel = {
                                    roleCode: roleCode,
                                    resourceTypeId: row.RESOURCE_TYPE_ID,
                                    resourceId: row.RESOURCE_ID,
                                    accessModeId: accessTypeModeId
                                };

                                $.ajax({
                                    type: 'GET',
                                    url: bars.config.urlContent("/admin/roles/SetResourceAccessMode"),
                                    contentType: 'application/json',
                                    dataType: 'json',
                                    data: accessModel,
                                    success: function (result) {
                                        bars.ui.alert({ text: result.message });
                                        $(selector).data("kendoGrid").dataSource.read();
                                    },
                                    error: function (result) {
                                        bars.ui.error({ text: result.message });
                                        $(selector).data("kendoGrid").dataSource.read();
                                    }
                                });
                            } 
                        }).appendTo(container);
                    },
                    width: "15%"
                }, {
                    field: "IS_APPROVED",
                    filterable: false,
                    title: "Підтверджений",
                    editable: false,
                    width: "15%"
                }
            ],
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },
            filterable: {
                mode: "row"
            },
            dataSource: {
                type: "aspnetmvc-ajax",
                sort: {
                    field: "ROLE_ID",
                    dir: "asc"
                },
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: 'application/json',
                        url: bars.config.urlContent('/api/admin/roleresources/'),
                        data: resModel
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ROLE_ID: { type: "number", editable: false },
                            RESOURCE_TYPE_NAME: { type: "string", editable: false },
                            RESOURCE_TYPE_ID: { type: "number", editable: false },
                            RESOURCE_NAME: { type: "string", editable: false },
                            RESOURCE_ID: { type: "number", editable: false },
                            RESOURCE_CODE: { type: "string", editable: false },
                            IS_GRANTED_NAME: { type: "string" },
                            IS_GRANTED: { type: "number" },
                            IS_APPROVED: { type: "number", editable: false }
                        }
                    }
                },
                serverPaging: false,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10
            }
        });
    },
    initAdmResourceGrid: function (selector, tabResourceCode, admId, admCode) {
        var self = bars.tabs,
            admModel = self.admModel(admId, tabResourceCode);

        $(selector).kendoGrid({
            selectable: "row",
            autoBind: true,
            editable: true,
            columns: [
                {
                    hidden: true,
                    field: "ARM_ID",
                    title: "Ідентифікатор АРМу",
                    width: 100
                }, {
                    hidden: true,
                    field: "RESOURCE_TYPE_NAME",
                    title: "Назва типу ресурсу",
                    width: 100
                }, {
                    hidden: true,
                    field: "RESOURCE_TYPE_ID",
                    title: "Ідентифікатор типу ресурсу",
                    width: 100
                }, {
                    field: "RESOURCE_NAME",
                    title: "Назва ресурсу",
                    width: "50%"
                }, {
                    hidden: true,
                    field: "RESOURCE_ID",
                    title: "Ідентифікатор ресурсу",
                    width: 100
                }, {
                    field: "RESOURCE_CODE",
                    title: "Код ресурсу",
                    width: "20%"
                }, {
                    hidden: true,
                    field: "IS_GRANTED",
                    title: "Код access",
                    width: 100
                }, {
                    field: "IS_GRANTED_NAME",
                    filterable: false,
                    title: "Доступ",
                    editor: function (container) {
                        var input = $('<input id="ACCESS_MODE_ID" name="ACCESS_MODE_NAME">');
                        input.appendTo(container);
                        // initialize a dropdownlist
                        input.kendoDropDownList({
                            dataTextField: "ACCESS_MODE_NAME",
                            dataValueField: "ACCESS_MODE_ID",
                            optionLabel: "Змінити на...",
                            dataSource: {
                                transport: {
                                    read: {
                                        type: "GET",
                                        dataType: 'json',
                                        contentType: 'application/json',
                                        url: bars.config.urlContent('/api/admin/admresourceaccess/'),
                                        data: { id: tabResourceCode, code: admCode }
                                    }
                                },
                                schema: {
                                    data: "Data"
                                }
                            },
                            change: function (e) {
                                var accessTypeModeId = this.value(),
                                    grid = $(selector).data("kendoGrid"),
                                    row = grid.dataItem(grid.select());

                                var accessModel = {
                                    admCode: admCode,
                                    resourceTypeId: row.RESOURCE_TYPE_ID,
                                    resourceId: row.RESOURCE_ID,
                                    accessModeId: accessTypeModeId
                                };

                                $.ajax({
                                    type: 'GET',
                                    url: bars.config.urlContent("/admin/adm/SetAdmResourceAccessMode"),
                                    contentType: 'application/json',
                                    dataType: 'json',
                                    data: accessModel,
                                    success: function (result) {
                                        bars.ui.alert({ text: result.message });
                                        $(selector).data("kendoGrid").dataSource.read();
                                    },
                                    error: function (result) {
                                        bars.ui.error({ text: result.message });
                                        $(selector).data("kendoGrid").dataSource.read();
                                    }
                                });
                            }
                        }).appendTo(container);
                    },
                    width: "15%"
                }, {
                    field: "IS_APPROVED",
                    filterable: false,
                    title: "Підтверджений",
                    editable: false,
                    width: "15%"
                }
            ],
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },
            filterable: {
                mode: "row"
            },
            dataSource: {
                type: "aspnetmvc-ajax",
                sort: {
                    field: "ARM_ID",
                    dir: "asc"
                },
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: 'application/json',
                        url: bars.config.urlContent('/api/admin/admresources/'),
                        data: admModel
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ARM_ID: { type: "number", editable: false },
                            RESOURCE_TYPE_NAME: { type: "string", editable: false },
                            RESOURCE_TYPE_ID: { type: "number", editable: false },
                            RESOURCE_NAME: { type: "string", editable: false },
                            RESOURCE_ID: { type: "number", editable: false },
                            RESOURCE_CODE: { type: "string", editable: false },
                            IS_GRANTED_NAME: { type: "string" },
                            IS_GRANTED: { type: "number" },
                            IS_APPROVED: { type: "number", editable: false }
                        }
                    }
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10
            }
        });
    },
    initConfirmResourceGrid: function (selector, tabResourceCode) {
        var tmp = kendo.template($("#gridToolbar").html()),
            tmpData = { tabCode: tabResourceCode };

        $(selector).kendoGrid({
            selectable: "row",
            autoBind: true,
            editable: false,
            toolbar: tmp(tmpData),
            dataBound: function () {

                var grid = $(selector).data('kendoGrid');
                if (grid.dataSource._data.length > 0) {
                    $("#SaveTab_" + tabResourceCode).removeClass("btn btn-default").addClass("btn btn-success");
                    $("#SaveTab_" + tabResourceCode).prop('disabled', false);
                } else {
                    $("#SaveTab_" + tabResourceCode).removeClass("btn btn-success").addClass("btn btn-default");
                    $("#SaveTab_" + tabResourceCode).prop('disabled', true);
                }


                $('.approve').change(function () {
                    var grid = $(selector).data('kendoGrid'),
                        row = $(this).closest("tr"),
                        checked = this.checked;

                    if (checked) {
                        row.find(".reject").attr("disabled", true);
                    } else {
                        row.find(".reject").removeAttr("disabled");
                    }
                });

                $('.reject').change(function () {
                    var grid = $(selector).data('kendoGrid'),
                        row = $(this).closest("tr"),
                        checked = this.checked;

                    if (checked) {
                        row.find(".approve").attr("disabled", true);
                    } else {
                        row.find(".approve").removeAttr("disabled");
                    }
                });
            },
            columns: [
                {
                    hidden: true,
                    field: "ID",
                    title: "Ідентифікатор<br/>дії над<br/>ресурсом",
                    width: 150
                }, {

                    field: "GRANTEE_NAME",
                    title: "Назва<br/>отримувача",
                    width: 150
                }, {
                    field: "GRANTEE_CODE",
                    title: "Код<br/>отримувача",
                    width: 150
                }, {
                    
                    field: "RESOURCE_TYPE_NAME",
                    title: "Тип<br/>ресурсу",
                    width: 150
                }, {
                    
                    field: "RESOURCE_NAME",
                    title: "Назва<br/>ресурсу",
                    width: 150
                }, {
                    field: "RESOURCE_CODE",
                    title: "Код<br/>ресурсу",
                    width: 150
                }, {
                    
                    field: "NEW_ACCESS_MODE",
                    title: "Новий<br/>режим<br/>доступу",
                    width: 150
                }, {
                    hidden: true,
                    field: "GRANTEE_TYPE_ID",
                    title: "Ідентифікатор<br/>типу об'єкту,<br/>якому<br/>надаються права",
                    width: 150
                }, {
                    field: "CURRENT_ACCESS_MODE",
                    title: "Поточний<br/>режим<br/>доступу",
                    width: 150
                }, {
                    field: "ACTION_USER",
                    title: "Користувач, що<br/>вніс зміни",
                    width: 150
                }, {
                    field: "ACTION_TIME",
                    title: "Час<br/>внесення змін",
                    template: "<div>#=kendo.toString(ACTION_TIME,'dd/MM/yyyy')#</div>",
                    width: 150
                }, {
                    title: "Підтвердити<br/>доступ",
                    //headerTemplate: '<input type="checkbox" id="check-all" onclick="checkAll(this)"/><label for="check-all">Check All</label>',
                    template: "<input type='checkbox' class='approve' data-bind='checked' data-approveId='#=ID#'/>",
                    width: 100
                }, {
                    title: "Відхилити<br/>доступ",
                    //headerTemplate: '<input type="checkbox" id="check-all" onclick="checkAll(this)"/><label for="check-all">Check All</label>',
                    template: "<input type='checkbox' class='reject' data-bind='checked' data-rejectId='#=ID#'/>",
                    width: 100
                }
            ],
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: false/*,
                buttonCount: 5*/
            },
            filterable: {
                mode: "row"
            },
            dataSource: {
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        type: "GET",
                        dataType: 'json',
                        contentType: 'application/json',
                        url: bars.config.urlContent('/admin/confirm/GetConfirmResources'),
                        data: { type: tabResourceCode }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            RESOURCE_TYPE_NAME: { type: "string" },
                            RESOURCE_NAME: { type: "string" },
                            RESOURCE_CODE: { type: "string" },
                            NEW_ACCESS_MODE: { type: "string" },
                            ID: { type: "number" },
                            GRANTEE_TYPE_ID: { type: "number" },
                            GRANTEE_NAME: { type: "string" },
                            GRANTEE_CODE: { type: "string" },
                            CURRENT_ACCESS_MODE: { type: "string" },
                            ACTION_USER: { type: "string" },
                            ACTION_TIME: { type: "date" }
                        }
                    }
                },
                serverPaging: false,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 10
            }
        });
    }
}