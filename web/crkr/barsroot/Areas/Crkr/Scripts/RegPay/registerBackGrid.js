var registerGrids = registerGrids || {};

registerGrids.initGrid = function () {
    $("#backActual").kendoGrid({
        resizable: true,
        autobind: true,
        selectable: "row",
        sortable: true,
        filterable: true,
        scrollable: true,
        detailInit: detailInit,
        toolbar: [
            { text: "Інформація", className: "k-grid-addEmail" },
            "excel",
            { text: "Розблокувати для виплат", className: "k-grid-unblockPay" },
            { text: "Заблокувати для виплат", className: "k-grid-blockPay" },
            { template: "<input type='checkbox' id='showall' class='k-checkbox' style='margin-left: 10px; margin-top: 5px;' checked><label class='k-checkbox-label' for='showall' style='left: 20px; margin-left:5px'>Тільки планові (у тому числі невдалі спроби відправки)</label>" }
            ],
        excel: {
            fileName: $(".container-fluid > h1").text() + ".xlsx",
            allPages: true,
            proxyURL: bars.config.urlContent("/crkr/regpay/xmlproxy")
        },
        pageable: {
            //refresh: true,
            buttonCount: 5
        },
        columns: [
             {
                 headerTemplate: "<input type='checkbox' id='checkAll' class='checkbox' name='checkRow'/>",
                 filterable: false,
                 template: '<input type="checkbox" class="checkbox" name="checkRow"/>',
                 width: "2em"
             },
            {
                field: "ID",
                title: "ID",
                headerAttributes: { style: "white-space: normal" },
                width: "6em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DATE_VAL_REG",
                title: "Дата валютування",
                template: "<div>#= kendo.toString(kendo.parseDate(DATE_VAL_REG),'dd.MM.yyyy') == null || kendo.toString(kendo.parseDate(DATE_VAL_REG),'dd.MM.yyyy') == '01.01.0001' ? '' : kendo.toString(kendo.parseDate(DATE_VAL_REG),'dd.MM.yyyy')#</div>",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "FIO_COMPEN",
                title: "ПІБ вкладу",
                width: "14em",
                headerAttributes: { style: "white-space: normal" },
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
                field: "DOCSERIAL",
                title: "Серія",
                headerAttributes: { style: "white-space: normal" },
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DOCNUMBER",
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
                field: "MFO",
                title: "МФО",
                headerAttributes: { style: "white-space: normal" },
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NLS",
                title: "Номер рахунку",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "AMOUNT",
                title: "Сума",
                headerAttributes: { style: "white-space: normal" },
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "REGDATE",
                title: "Дата реєстрації",
                headerAttributes: { style: "white-space: normal" },
                width: "16em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "CHANGEDATE",
                title: "Дата зміни",
                headerAttributes: { style: "white-space: normal" },
                width: "16em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "BRANCH",
                title: "Бранч",
                headerAttributes: { style: "white-space: normal" },
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                headerAttributes: { style: "white-space: normal" },
                width: "18em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "MSG",
                title: "Повідомлення",
                headerAttributes: { style: "white-space: normal" },
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "REF_OPER",
                title: "Референс операції",
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
            pageSize: 10,
            schema: {
                model: {
                    fields: {
                        ID: { type: "string" },
                        DATE_VAL_REG: { type: "string" },
                        FIO_COMPEN: { type: "string" },
                        FIO_CLIENT: { type: "string" },
                        DOCSERIAL: { type: "string" },
                        DOCNUMBER: { type: "string" },
                        MFO: { type: "string" },
                        NLS: { type: "string" },
                        AMOUNT: { type: "string" },
                        REGDATE: { type: "string" },
                        CHANGEDATE: { type: "string" },
                        BRANCH: { type: "string" },
                        STATE_NAME: { type: "string" },
                        MSG: { type: "string" },
                        REF_OPER: { type: "string" }
                    }
                }
            }
        }
    });

    function detailInit(e) {
        $("<div/>").appendTo(e.detailCell).kendoGrid({
            dataSource: {
                dataType: "json",
                type: "GET",
                transport: {
                    read: bars.config.urlContent("/api/crkr/pay/operway?regid=" + e.data.ID)
                },
                pageSize: 10
            },
            scrollable: false,
            sortable: true,
            pageable: true,
            columns: [
                {
                    field: "FIO",
                    title: "ПІБ Клієнта",
                    width: "140px"
                },{
                    field: "OST",
                    title: "Залишок",
                    width: "70px"
                },{
                    field: " AMOUNT",
                    title: "Сума",
                    width: "80px"
                }
            ]
        });
    }
}