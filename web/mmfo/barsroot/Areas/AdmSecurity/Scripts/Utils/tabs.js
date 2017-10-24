if (!("bars" in window)) window["bars"] = {};
bars.tabs = bars.tabs || {
    loadTemplate: function (path) {
        $.get(path).success(function (result) {
            $("body").append(result);
        }).error(function (result) {
            alert("Помилка завантаження шаблону!");
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
                    //template: "<div>#=kendo.toString(ACTION_TIME,'dd/MM/yyyy HH:mm:ss')#</div>",
                    format: "{0:dd/MM/yyyy HH:mm:ss tt}",
                    width: 200,
                    filterable: {
                        operators: {
                            date: {
                                gt: "Після дати",
                                lt: "До дати"
                            }
                        }
                    }
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
                        url: bars.config.urlContent('/admsecurity/confirm/GetConfirmResources'),
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