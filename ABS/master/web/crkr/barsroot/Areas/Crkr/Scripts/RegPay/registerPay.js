$(document).ready(function () {
    var funeral = bars.extension.getParamFromUrl("funeral", window.location.toString());

    $(".datepicker").kendoDatePicker({
        value: new Date(),
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });

    var validator = $("#periodForm").kendoValidator().data("kendoValidator");
    $("#periodForm").submit(function (event) {
        if (validator.validate()) {
            event.preventDefault();
            var values = {};
            $.each($('#periodForm').serializeArray(), function(i, field) {
                values[field.name] = field.value;
            });
            if (funeral === "true") {
                values.funeral = true;
            }
            else {
                values.funeral = false;
            }
            $.ajax({
                url: bars.config.urlContent("/api/crkr/pay/getoperactual"),
                type: "GET",
                dataType: "JSON",
                data: values,
                success: function(model) {
                    $("#actualPay").data("kendoGrid").dataSource.data(model);
                },
                error: function() {
                    bars.ui.notify('Увага!', 'Вклад(и) не знайдено. Змініть фільтр.', 'error');
                }
            });
        }
    });
    
    $('#actualPay').kendoGrid({
        resizable: true,
        autobind: true,
        selectable: "row",
        sortable: true,
        filterable: true,
        scrollable: true,

        pageable: {
            buttonCount: 5
        },
        columns: [
            {
                field: "RNK",
                title: "РНК",
                headerAttributes: { style: "white-space: normal" },
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "FIO_CLIENT",
                title: "ПІБ Клієнта",
                width: "14em",
                headerAttributes: { style: "white-space: normal" },
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "SER",
                title: "Серія/ЄДДР",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NUMDOC",
                title: "Номер",
                headerAttributes: { style: "white-space: normal" },
                width: "8em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DBCODE",
                title: "DBCODE",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NLS",
                title: "Номер рахунку<br/>для виплат",
                headerAttributes: { style: "white-space: normal" },
                width: "11em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "COMPEN_ID",
                title: "Ідентифікатор вкладу",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "L_DATE",
                title: "Дата останьої<br/>зміни операції",
                template: "<div>#= kendo.toString(kendo.parseDate(L_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(L_DATE),'dd.MM.yyyy')#</div>",
                headerAttributes: { style: "white-space: normal" },
                width: "10.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "TYPE_OPER_NAME",
                title: "Назва операції",
                headerAttributes: { style: "white-space: normal" },
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "FIO_COMPEN",
                title: "ПІБ вкладу",
                headerAttributes: { style: "white-space: normal" },
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NSC",
                title: "Рахунок вкладу ",
                headerAttributes: { style: "white-space: normal" },
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "USER_ID",
                title: "ID користувача,<br/>що створив операцію",
                headerAttributes: { style: "white-space: normal" },
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "REG_PROCESSED",
                title: "Формування реєстру<br/>при актуалізації",
                headerAttributes: { style: "white-space: normal" },
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }
        ],
        dataSource: {
            type: "webapi",
            pageSize: 10,
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    data: { startDate: "", endDate: "", funeral : funeral === "true" ? true : false},
                    url: bars.config.urlContent("/api/crkr/pay/getoperactual")
                }
            },
            schema: {
                model: {
                    fields: {
                        RNK: { type: "string" },
                        FIO_CLIENT: { type: "string" },
                        SER: { type: "string" },
                        NUMDOC: { type: "string" },
                        DBCODE: { type: "string" },
                        NLS: { type: "string" },
                        BRANCH: { type: "string" },
                        COMPEN_ID: { type: "string" },
                        L_DATE: { type: "string" },
                        TYPE_OPER_NAME: { type: "string" },
                        FIO_COMPEN: { type: "string" },
                        NSC: { type: "string" },
                        USER_ID: { type: "string" },
                        REG_PROCESSED: { type: "string" }
                    }
                }
            }
        }
    });
});