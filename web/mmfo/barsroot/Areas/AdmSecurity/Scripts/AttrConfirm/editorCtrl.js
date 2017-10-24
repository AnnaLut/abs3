$(document).ready(function () {
    var datasource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                url: bars.config.urlContent("/admin/confirm/EditorGrid")
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    Id: { type: "number" },
                    Name: { type: "string" },
                    Type: { type: "string" },
                    Value: { type: "string" }
                }
            }
        }
    });

    var editorTypeSwitcher = function (data) {
        //todo init templates:
        var box = $("#EditBox"),
            numberTemplate = kendo.template($("#number").html()),
            stringTemplate = kendo.template($("#string").html()),
            dateTemplate = kendo.template($("#date").html()),
            dropdownTemplate = kendo.template($("#dropdown").html()),
            gridTemplate = kendo.template($("#grid").html());

        switch (data.Type) {
            case "text":
                    box.html(stringTemplate(data));
                break;
            case "number":
                    box.html(numberTemplate(data));
                break;
            case "date":
                    box.html(dateTemplate(data));
                    $("#value").kendoDatePicker({
                        format: "dd/MM/yyyy"
                    });
                    $("#value").closest("span.k-datepicker").width(345);
                break;
            case "dropdown":
                    box.html(dropdownTemplate(data));
                    $("#value").kendoDropDownList({
                        dataSource: {
                            data: ["MB", "Ford", "Kia", "Honda", "Toyota", "Zaz"]
                        },
                        animation: false
                    });
                    $("#value").closest("span.k-dropdown").width(345);
                break;
            case "grid":
                box.html(gridTemplate(data));

                    $("#value").kendoGrid({
                        autoBind: true,
                        selectable: "row",
                        sortable: true,
                        pageable: {
                            refresh: true,
                            buttonCount: 5
                        },
                        columns: [
                            {
                                field: "Id",
                                title: "Id"
                            },
                            {
                                field: "Name",
                                title: "Name"
                            },
                            {
                                field: "Type",
                                title: "Type"
                            },
                            {
                                field: "Value",
                                title: "Value"
                            }
                        ],
                        dataSource: datasource
                    });
                    //$("#value").data("kendoGrid").dataSource.read();
                break;
            default:
                break;
        }
    }

    $("#EditorWindow").kendoWindow({
        title: "Edit Selected Item",
        visible: false,
        width: "400px",
        //height: "300px",
        resizable: false,
        actions: ["Close"]//,
        //open: function () {
        //    var createFormTabs = $("#create-form-tabs").kendoTabStrip().data("kendoTabStrip");
        //    if (createFormTabs) {
        //        createFormTabs.select(0);
        //    }
        //}
    });

    $("#EditorGrid").kendoGrid({
        autoBind: true,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "Id",
                title: "Id"
            },
            {
                field: "Name",
                title: "Name"
            },
            {
                field: "Type",
                title: "Type"
            },
            {
                field: "Value",
                title: "Value"
            },
            {
                field: "EditTypeBtn",
                title: "Edit",
                template: "<button name='editRow' class='btn btn-success'>Edit_Row</button>",
                filterable: false
            }
        ],
        dataSource: datasource,
        dataBound: function() {
            //this.select("tr:eq(1)");
            $("#EditorGrid").data("kendoGrid").tbody.find("button[name='editRow']").click(function (e) {

                // init and open edit window:
                var window = $("#EditorWindow").data("kendoWindow");
                window.center();
                window.open();

                // inir row data:
                var dataItem = $("#EditorGrid").data("kendoGrid").dataItem($(e.currentTarget).closest("tr"));
                
                // init editor type switcher:
                editorTypeSwitcher(dataItem);

                // refresh main grid data:
                //this.dataSource.read();
            });
        }
    });
});