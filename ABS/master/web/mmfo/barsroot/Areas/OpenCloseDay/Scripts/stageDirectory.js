var GetTypeName = function (value) {
    var tmp = value;
    if (!isNaN(value))
        switch (value) {
            case 1:
                return "Виконання банківських операцій";
            case 2:
                return "Операційна активність завершена";
        };
    return value;
};
$(document).ready(function () {

    
    function actionWrap() {
        $(".k-dropdown-wrap").on("click", function () {

            var ss = $(this).closest("tr");
            var grid = $("#stageDirectoryGrid").data("kendoGrid");
            var record = grid.dataItem(ss);
        });
    };

    $("#confirmButton").on("click", function () {
        var c_list = [];
        var changes = $(".panel-body").find(".k-dirty-cell").parent();
        for (var i = 0; i < changes.length; i++) {
            var item = changes[i];
            //var row = item.closest("tr");
            var grid = $("#stageDirectoryGrid").data("kendoGrid");
            var record = grid.dataItem(item);
            c_list.push(record);
        };
        for (var i = 0; i < c_list.length; i++) {
            var def_item = c_list[i];
            $.ajax({
                type: "GET",
                async: false,
                url: bars.config.urlContent("/api/opencloseday/departmentinfo/setsinglebranchstage?branch_code=" + def_item.BRANCH + "&stage_id=" + def_item.STAGE_NAME),
                success: function (data) {

                    $("#stageDirectoryGrid").data('kendoGrid').dataSource.read();
                    $("#stageDirectoryGrid").data('kendoGrid').refresh();
                            
                }
            });
        }
        
    })

    $("#stageDirectoryGrid").kendoGrid({
        dataSource: {
            //type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/opencloseday/departmentinfo/getbranchstages/")
                }
            },
            schema: {
                model: {
                    fields: {
                        BRANCH: { type: "string", editable: false },
                        BRANCH_NAME: { type: "string", editable: false },
                        STAGE_NAME: { defaultValue: { LIST_ITEM_ID: 1, LIST_ITEM_NAME: "Виконання банківських операцій" } },
                        STAGE_TIME: { type: "string", editable: false },
                        STAGE_USER: { type: "string", editable: false },
                        IS_READY: { type: "string", editable: false }
                    }
                }
            }
        },
        height: 350,
        editable: true,
        sortable: true,
        pageable: false,
        dataBound: actionWrap,
        serverPaging: false,
        serverSorting: false,
        serverFiltering: false,
        columns: [{
            field: "BRANCH",
            title: "Бранч",
            width: "10%"
        }, {
            field: "BRANCH_NAME",
            title: "Відділення"
        }, {
            field: "STAGE_NAME",
            editor: categoryDropDownEditor, template: "#=STAGE_NAME#",
            title: "Режим операцыйної діяльності",
            width: "30%",
            template: '<div class="droplist" >#: GetTypeName(STAGE_NAME) #</div>'
        }, {
            template: "#= (STAGE_TIME == null) ? ' ' : kendo.toString(kendo.parseDate(STAGE_TIME), 'dd MMM yyyy hh:mm') #",
            field: "STAGE_TIME",
            title: "Час"
        }, {
            field: "STAGE_USER",
            title: "Користувач"
        }, {
            field: "IS_READY",
            title: "Готовність",
            hidden: true
        }]
    });
    function categoryDropDownEditor(container, options) {
        $('<input required name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                autoBind: false,
                dataTextField: "LIST_ITEM_NAME",
                dataValueField: "LIST_ITEM_ID",
                dataSource: {
                    transport: {
                        read: {
                            dataType: "json",
                            type: "GET",
                            url: bars.config.urlContent("/api/opencloseday/departmentinfo/getbranchstagedirectory/")
                        }
                    }
                }
            });
    };
    
});