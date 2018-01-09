$(document).ready(function () {
    $("#tabstrip").kendoTabStrip().data("kendoTabStrip").select(0);

    var admuGrid = null;
    var admGrid = null;

    function initADMU() {
        if (admuGrid == null) {
            admuGrid = $('#admu').data('kendoGrid');
        }
        return admuGrid;
    }
    function initADM() {
        if (admGrid == null) {
            admGrid = $('#adm').data('kendoGrid');
        }
        return admGrid;
    }

    function executeUserApproveConfirm(logname, userId, resId, obj) {
        bars.ui.confirm({
            text: 'Ви дійсно бажаєте підтвердити виконання операції для користувача ' + logname + ' ?'
        }, function () {
            $.get(urlUserApproveConfirm, { userId: userId, resId: resId, obj: obj }).done(function (data) {
                bars.ui.alert({ text: data.message });
            });
        });
    }
    function executeUserRevokeConfirm(logname, userId, resId, obj) {
        bars.ui.confirm({
            text: 'Ви дійсно бажаєте підтвердити виконання операції для користувача ' + logname + ' ?'
        }, function () {
            $.get(urlUserRevokeConfirm, { userId: userId, resId: resId, obj: obj }).done(function (data) {
                bars.ui.alert({ text: data.message });
            });
        });
    }

    function executeAppApproveConfirm(name, description, id, codeapp, obj) {
        bars.ui.confirm({
            text: "Ви дійсно бажаєте підтвердити виконання " + description + " ?"
        }, function () {
            $.get(urlAppApproveConfirm, { id: id, codeapp: codeapp, obj: obj }).done(function (data) {
                bars.ui.alert({ text: data.message });
            });
        });
    }
    function executeAppRevokeConfirm(name, description, id, codeapp, obj) {
        bars.ui.confirm({
            text: "Ви дійсно бажаєте підтвердити виконання " + description + " ?"
        }, function () {
            $.get(urlAppRevokeConfirm, { id: id, codeapp: codeapp, obj: obj }).done(function (data) {
                bars.ui.alert({ text: data.message });
            });
        });
    }

    $('#admu').kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            /*{
                field: "OBJ",
                title: "OBJ",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },*/
            {
                field: "ID",
                title: "Код користувача",
                width: "10%",
                filterable: {
                    cell: {
                        template: function (args) {
                            args.element.kendoNumericTextBox({
                                format: '#',
                                decimals: 0
                            });
                        }

                    }
                }
            },
            {
                field: "LOGNAME",
                title: "Логін користувача",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "FIO",
                title: "ПІБ",
                width: "20%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "ID_RES",
                title: "Код ресурсу",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Опис дії",
                width: "40%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            { 
                field: "STATUS",
                title: "Тип дії",
                width: "10%",
                template: "<button name='confirmBtn' #=STATUS == '+' ? 'class=\"btn btn-success\"' : 'class=\"btn btn-danger\"'#>#= STATUS == '+' ? 'Додати' : 'Видалити' #</button>",
                filterable: false
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/admin/Confirm/GetUserConfirmGrid'), 
                    success: function () {
                        //
                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: 'Сталася помилка при спробі завантажити дані таблиці.' });
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        OBJ: { type: "string" },
                        NAME: { type: "string" },
                        LOGNAME: { type: "string" },
                        ID_RES: { type: "string" },
                        ID: { type: "number" },
                        FIO: { type: "string" }
                    }
                }
            }
        },
        filterable: {
            mode: "row"
        },
        dataBound: function(e) {
            $('#admu').data('kendoGrid').tbody.find('button[name="confirmBtn"]').click(function (e) {
                grid = initADMU();
                dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                if (dataItem.STATUS == "+") { executeUserApproveConfirm(dataItem.LOGNAME, dataItem.ID, dataItem.ID_RES, dataItem.OBJ); }
                else if (dataItem.STATUS == "-") { executeUserRevokeConfirm(dataItem.LOGNAME, dataItem.ID, dataItem.ID_RES, dataItem.OBJ); }
                grid.dataSource.read();
                grid.refresh();
        });
    }
    });

    $('#adm').kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            /*{
                field: "OBJ",
                title: "OBJ",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },*/
            {
                field: "CODEAPP",
                title: "Код АРМу",
                width: "10%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NAME",
                title: "Назва АРМу",
                width: "30%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "ID_RES",
                title: "Код ресурсу",
                width: "10%",
                filterable: {
                    cell: {
                        template: function (args) {
                            args.element.kendoNumericTextBox({
                                format: '#',
                                decimals: 0
                            });
                        }

                    }
                }
            },
            {
                field: "DESCRIPTION",
                title: "Опис дії",
                width: "50%",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            { 
                field: "STATUS",
                title: "Тип дії",
                width: "10%",
                template: "<button name='confirmBtn' #=STATUS == '+' ? 'class=\"btn btn-success\"' : 'class=\"btn btn-danger\"'#>#= STATUS == '+' ? 'Додати' : 'Видалити' #</button>",
                filterable: false
            }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/admin/Confirm/GetAppConfirmGrid'),
                    success: function () {
                        // 
                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: 'Сталася помилка при спробі завантажити дані таблиці.' });
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        OBJ: { type: "string" },
                        NAME: { type: "string" },
                        CODEAPP: { type: "string" },
                        ID_RES: { type: "number" },
                        DESCRIPTION: { type: "string" }
                    }
                }
            }
        },
        filterable: {
            mode: "row"
        },
        dataBound: function (e) {
            $('#adm').data('kendoGrid').tbody.find('button[name="confirmBtn"]').click(function (e) {
                grid = initADM();
                dataItem = grid.dataItem($(e.currentTarget).closest("tr"));
                if (dataItem.STATUS == "+") { executeAppApproveConfirm(dataItem.NAME, dataItem.DESCRIPTION, dataItem.ID_RES, dataItem.CODEAPP, dataItem.OBJ); }
                else if (dataItem.STATUS == "-") { executeAppRevokeConfirm(dataItem.NAME, dataItem.DESCRIPTION, dataItem.ID_RES, dataItem.CODEAPP, dataItem.OBJ); }
                grid.dataSource.read();
                grid.refresh();
            });
        }
    });
})