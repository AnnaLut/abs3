$(document).ready(function () {
    

    $("#someList").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "ID",
        dataSource: {
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/editrecord/list")
                }
            }
        }
    });
    var leftDataSource = null;
    var idList = $("#someList").value;

    $("#leftGrid").kendoGrid({
        dataSource: leftDataSource,
        reorderable: true,
        selectable: "single row",
        columnMenu: true,
        groupable: false,
        resizable: true,
        sortable: true,
        filterable: {
            extra: false,
            operators: {
                string: {
                    startswith: "Starts with",
                    eq: "Is equal to",
                    neq: "Is not equal to"
                }
            }
        },
        columns: [
            {
                field: "ACCGRP",
                title: "№ гр. рах.",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Каталог формування файлу",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "FILEMASK",
                title: "Назва групи рахунків",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "GRPDIR",
                title: "Префікс імені файлу",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ]
    });
    $("#someList").change(function () {
        //debugger;
        leftDataSource = new kendo.data.DataSource({
            type: "aspnetmvc-ajax",
            pageSize: 10,
            //serverPaging: true,
            //serverFiltering: true,
            //serverSorting: true,
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/editrecord/leftgrid?id=" + this.value),
                    error: function (xhr, error) {
                        bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці.<br/>" + error });
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
                        ACCGRP: { type: "string" },
                        NAME: { type: "string" },
                        FILEMASK: { type: "string" },
                        GRPDIR: { type: "string" }
                    }
                }
            }
        });

        $("#leftGrid").data("kendoGrid").dataSource.read();
        $("#leftGrid").data("kendoGrid").refresh();
    });
    
    $("#rightGrid").kendoGrid({
        dataSource: {
            //data: mockdata,
            group: {
                field: "a",
                dir: "asc"
            }
        },
        reorderable: true,
        selectable: "single row",
        columnMenu: true,
        groupable: false,
        resizable: true,
        sortable: true,
        filterable: {
            extra: false,
            operators: {
                string: {
                    startswith: "Starts with",
                    eq: "Is equal to",
                    neq: "Is not equal to"
                }
            }
        },
        columns: [
            {
                field: "a",
                title: "Маска чи номер рахунку",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "s",
                title: "Відділення",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "d",
                title: "Валюта (0-всі)",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ]
    });
});