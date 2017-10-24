$(document).ready(function () {
    var vallBtn = null;

    $("#branchWindow").kendoWindow({
        width: "900px",
        title: "Відділення",
        resizable: false,
        visible: false,
        modal: true,
        actions: [
            "Close"
        ],
        close: onClose
    });

    function onClose() {
    };

    $(".callBranchWindow").click(function (e) {
        vallBtn = this.id;
        $("#branchWindow").data("kendoWindow").center().open();
    });
    $("#branches").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "BRANCH",
                title: "Бранч",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Ім'я",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }

        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/crkr/rebdata/branches")
                }
            },
            schema: {
                model: {
                    fields: {
                        BRANCH: { type: "string" },
                        NAME: { type: "string" }
                    }
                }
            }
        }
    });

    var insertBranch = function () {
        var grid = $("#branches").data("kendoGrid");
        var row = grid.dataItem(grid.select());
        if (vallBtn === "from") {
            $("#frombranch").val(row.BRANCH);
        }
        if (vallBtn === "to") {
            $("#tobranch").val(row.BRANCH);
        }
        $("#branchWindow").data("kendoWindow").close();
    }

    $("#rebranch").submit(function (event) {
        event.preventDefault();
        var values = {};
        $.each($('#rebranch').serializeArray(), function (i, field) {
            values[field.name] = field.value;
        });
        bars.ui.loader("body", true);
        $.ajax({
            url: bars.config.urlContent("/api/crkr/rebdata/change"),
            type: "POST",
            dataType: "JSON",
            data: values,
            success: function (model) {
            	bars.ui.loader("body", false);
                $("#result").text(model);
                //bars.ui.alert({ title: "Результат", text: model });
            },
            error: function (result) {
            	bars.ui.loader("body", false);
                bars.ui.notify('Увага!', 'Сталася помилка' + result, 'error');
            }
        });

    });
    $("#branches").on("dblclick", "tbody > tr", insertBranch);

});