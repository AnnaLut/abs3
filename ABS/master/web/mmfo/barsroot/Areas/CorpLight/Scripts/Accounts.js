$(function () {

    function getTypeDropDownEditor() {
        return [
            { TypeId: 'CURRENT', TypeName: 'Розрахункові рахунки' },
            { TypeId: 'CARD', TypeName: 'Карткові рахунки' },
            { TypeId: 'DEPOSIT', TypeName: 'Депозитні рахунки' },
            { TypeId: 'LOAN', TypeName: 'Кредитні рахунки' }
        ];
    };

    function getTypeNameById(id) {
        var data = getTypeDropDownEditor();
        for (var i = 0; i < data.length; i++) {
            if (data[i].TypeId === id) {
                return data[i].TypeName;
            }
        }
        return '';
    };

    function getTransportObject(type) {
        return {
            url: bars.config.urlContent('/api/corplight/accounts'),
            //dataType: 'json',
            type: type,
            success: function () {
                $('#accountsGrid').data('kendoGrid').dataSource.read();
                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
            },
            error: function () {

            },
            complete: function () {
            }
        };
    };

    function addNewNbs() {
        $('#typeId')
            .kendoDropDownList({
                autoBind: false,
                dataSource: getTypeDropDownEditor()
            });
        $("#nameNbs").val(null);
        $("#addNbsWindow").data("kendoWindow").center().open();
    };

    $('#accountsGrid').kendoGrid({
        height: 120,
        editable: "popup",
        autoBind: true,
        selectable: 'single',
        groupable: false,
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        toolbar: [{
            name: "Add",
            template: "<button id='addNbsBtn' class='k-button'>Додати</button>"
        }],
        pageable: {
            refresh: true,
            pageSizes: [10, 20, 50, 100, 200],
            buttonCount: 5
        },
        dataBound: function (e) {
            bars.extension.kendo.grid.noDataRow(e);
        },
        dataSource: new kendo.data.DataSource({
            type: 'webapi',
            pageSize: 10,
            page: 1,
            total: 0,
            serverPaging: false,
            serverSorting: false,
            serverFiltering: false,
            serverGrouping: false,
            serverAggregates: false,
            transport: {
                read: {
                    url: bars.config.urlContent('/api/corplight/accounts'),
                    type: 'GET'
                },
                create: {
                    url: bars.config.urlContent('/api/corplight/accounts'),
                    type: 'POST',
                    success: function () {
                        debugger
                        $('#accountsGrid').data('kendoGrid').dataSource.read();
                        bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                    },
                    error: function () {
                        debugger
                        alert()
                    },
                    coplete: function () {
                        debugger
                        $('#accountsGrid').data('kendoGrid').dataSource.read();
                        bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                    }

                },
                destroy: getTransportObject('DELETE')
            },
            schema: {
                data: function (data) { return data; },
                total: function (data) { return data.length; },
                errors: "Errors",
                model: {
                    id: 'Id',
                    fields: {
                        Id: {
                            type: 'string',
                            editable: false
                        },
                        Nbs: {
                            type: 'string'
                        },
                        TypeId: {
                            type: 'string'
                        },
                        TypeName: {
                            type: 'string',
                            editable: false
                        }
                    }
                }
            }
        }),
        columns: [
            {
                field: 'Nbs',
                title: 'Балансовий рахунок',
                width: '180px'
            },
            {
                field: 'TypeId',
                title: 'Код модуля',
                width: '180px'
            },
            {
                field: 'TypeName',
                title: 'Назва модуля',
                template: function (data) {
                    if (data.TypeName) {
                        return data.TypeName;
                    } else {
                        return getTypeNameById(data.TypeId);
                    }
                },
                filterable: false,
                editable: false,
                width: '180px'
            },
            {
                command: [
                    {
                        name: "Видалити",
                        click: function (e) {  //add a click event listener on the delete button
                            //console.log(e);
                            var grid = $('#accountsGrid').data('kendoGrid');
                            var tr = $(e.target).closest("tr"); //get the row for deletion
                            var data = this.dataItem(tr); //get the row data so it can be referred later
                            bars.ui.confirm({
                                text: 'Ви впевнені, що хочете видатити рахунок ' + data.Nbs,
                                func: function () {
                                    var params = {
                                        url: bars.config.urlContent('/api/corplight/accounts'),
                                        //dataType: 'json',
                                        type: 'DELETE',
                                        data: { Nbs: data.Nbs, TypeId: data.TypeId },
                                        success: function () {
                                            bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                            grid.dataSource.read();
                                        }
                                    };
                                    $.ajax(params);

                                }
                            });
                        }
                    }],
                title: "&nbsp;",
                width: "250px"
            }
        ]
    });

    $("#addNbsBtn").click(function () {
        addNewNbs();
    });

    $("#btnOk").click(function () {
        var accType = new Object();
        accType.Nbs = $("#nameNbs").val(),
        accType.TypeId = $('#typeId').val(),
        accType.TypeName = getTypeNameById($('#typeId').val())
        if (accType.Nbs != "" && accType.Nbs != undefined && accType.TypeId != "" && accType.TypeId != undefined)
        {
            $.ajax({
                method: "POST",
                dataType: "json",
                data: accType,
                async: false,
                url: bars.config.urlContent('/api/corplight/accounts'),
                success: function (response) {
                    $('#accountsGrid').data('kendoGrid').dataSource.read();
                    bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                },
                error: function (response) {
                    bars.ui.notify('Увага', 'Виникла помилка', 'error');
                }
            });
            $("#addNbsWindow").data("kendoWindow").close();
        }
        else
        {
            bars.ui.notify('Увага', 'Не заповнені поля', 'error');
        }
    });

    $("#btnCancel").click(function () {
        $("#addNbsWindow").data("kendoWindow").close();
    });
});
