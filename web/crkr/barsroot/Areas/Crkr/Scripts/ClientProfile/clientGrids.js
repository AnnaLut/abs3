var clientGrids = clientGrids || {};

function onChange() {
    $("#addAttorney").prop("disabled", false);
}
function readBenef() {
    $("#delAttorneyWills").prop("disabled", false);
}
function showActualState() {
    var grid = $("#clientProfileGrid").data("kendoGrid");

    grid.tbody.find(">tr").each(function () {
        var dataItem = grid.dataItem(this);
        if (dataItem.STATUS === 91) {
            $(this).addClass("blocked");
        }
    });
};

$("#clientProfileGrid, #depoOnFuneral").find("#checkAll").on("change", function (e) {
    e.preventDefault();

    var selector = $(this)
        .parents()[6].id;
    var grid = $("#" + selector);
    var checkedRows = grid.find('input[type="checkbox"][name="checkRow"]');
    var $this = $(this);
    if ($this.is(":checked")) {
        checkedRows.prop("checked", true);
    } else {
        checkedRows.removeAttr("checked");
    }
});

clientGrids.burial = bars.extension.getParamFromUrl('burial', window.location.toString());
clientGrids.funeral = bars.extension.getParamFromUrl('funeral', window.location.toString());
clientGrids.back = bars.extension.getParamFromUrl('button', window.location.toString()); //при вході через функція бекофісу

clientGrids.clientDepo = function (rnk) {    
    $("#clientProfileGrid").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        change: onChange,
        pageable: {
            refresh: true,
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
                 title: "Номер вкладу",
                 template: "<a class='link-color' href='/barsroot/Crkr/DepositProfile/DepositInventory?depoId=${ID}&flag=1&burial=" + (clientGrids.burial ? "true" : "false") + "&funeral=" + (clientGrids.funeral ? "true" : "false") + "&back=" + (clientGrids.back === "true" ? "true" : "false") + "'>${ID}</a>",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "FIO",
                 title: "Ім'я на вкладі",
                 width: "14em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "KKNAME",
                 title: "Назва вкладу",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "STATUS_NAME",
                 title: "Статус",
                 width: "10.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "NSC",
                 title: "Номер рахунку<br/>АСВО",
                 width: "10.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "OST",
                 title: "Сумма<br/>вкладу",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "LCV",
                 title: "Валюта",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "REGISTRYDATE",
                 title: "Дата заключення<br/>договору",
                 template: "<div>#= kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy') #</div>",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DATO",
                 title: "Дата відкриття<br/>вкладу",
                 template: "<div>#= kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy') #</div>",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DATN",
                 title: "Дата нарахування<br/>процентів",
                 template: "<div>#= kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy')#</div>",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "SUM",
                 title: "Сумма<br/>внесків",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "REASON_CHANGE_STATUS",
                 title: "Причина<br/>блокування",
                 width: "16em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "RNK",
                 title: "РНК",
                 width: "7em",
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
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/getcompen"),
                    data: { rnk: rnk }
                }
            },
            schema: {
                model: {
                    fields: {
                        ID: { type: "number" },
                        KKNAME: { type: "string" },
                        FIO: { type: "string" },
                        NSC: { type: "string" },
                        LCV: { type: "string" },
                        REGISTRYDATE: { type: "string" },
                        DATO: { type: "string" },
                        DATN: { type: "string" },
                        SUM: { type: "string" },
                        OST: { type: "string" },
                        STATUS: { hidden: true },
                        REASON_CHANGE_STATUS: { type: "string" },
                        RNK: { type: "string" },
                        STATUS_NAME: { type: "string" }
                    }
                }
            }
        },
        dataBound: showActualState
    });
}
clientGrids.attorney = function (rnk) {
    $("#powerOfAttorneyGrid").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        change: readBenef,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
             { field: "ID", hidden: true },
             {
                 field: "RNK",
                 title: "РНК",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "KKNAME",
                 title: "Назва вкладу",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CODE",
                 title: "Код<br/>бенефіціара",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "FIOB",
                 title: "ПІБ",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "NAME",
                 title: "Країна",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "FULLADDRESSB",
                 title: "Повна адреса",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "ICODB",
                 title: "Код<br/>ОКПО",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCTYPEB",
                 title: "Вид<br/>документу",
                 width: "9em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCSERIALB",
                 title: "Серія<br/>документу",
                 width: "8.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "EDDR_ID",
                 title: "ЄДДР",
                 width: "8.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCNUMBERB",
                 title: "Номер<br/>документу",
                 width: "8.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCORGB",
                 title: "Орган, що<br/>видав документ",
                 width: "11.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCDATEB",
                 title: "Дата видачі<br/>документа",
                 template: "<div>#= kendo.toString(kendo.parseDate(DOCDATEB),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DOCDATEB),'dd.MM.yyyy')#</div>",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CLIENTBDATEB",
                 title: "Дата<br/>народження",
                 template: "<div>#= kendo.toString(kendo.parseDate(CLIENTBDATEB),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CLIENTBDATEB),'dd.MM.yyyy')#</div>",
                 width: "9.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "SEX",
                 title: "Стать",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CLIENTPHONEB",
                 title: "Телефон",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "PERCENT",
                 title: "Відсоток<br/>спадщини %",
                 template: "<div>#= PERCENT * 100#</div>",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "REGDATE",
                 title: "Дата реєстрації",
                 template: "<div>#= kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy HH:mm:ss')#</div>",
                 width: "15em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "IDB", hidden: true
             }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/getbenef"),
                    data: { rnk: rnk, code: 'D' }
                }
            },
            schema: {
                model: {
                    fields: {
                        RNK: { type: "string" },
                        ID: { type: "string" },
                        KKNAME: { type: "string" },
                        CODE: { type: "string" },
                        FIOB: { type: "string" },
                        NAME: { type: "string" },
                        FULLADDRESSB: { type: "string" },
                        ICODB: { type: "string" },
                        DOCTYPEB: { type: "string" },
                        EDDR_ID: { type: "string" },
                        DOCSERIALB: { type: "string" },
                        DOCNUMBERB: { type: "string" },
                        DOCORGB: { type: "string" },
                        DOCDATEB: { type: "string" },
                        CLIENTBFATEB: { type: "string" },
                        SEX: { type: "string" },
                        CLIENTPHONEB: { type: "string" },
                        PERCENT: { type: "number" }
                    }
                }
            }
        }
    });
}
clientGrids.testamentary = function (rnk) {
    $("#testamentaryDisposition").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        change: readBenef,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
             { field: "ID", hidden: true },
             {
                 field: "RNK",
                 title: "РНК",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "KKNAME",
                 title: "Назва вкладу",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CODE",
                 title: "Код<br/>бенефіціара",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "FIOB",
                 title: "ПІБ",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "NAME",
                 title: "Країна",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "FULLADDRESSB",
                 title: "Повна адреса",
                 width: "12em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "ICODB",
                 title: "Код<br/>ОКПО",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCTYPEB",
                 title: "Вид<br/>документу",
                 width: "9em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCSERIALB",
                 title: "Серія<br/>документу",
                 width: "8.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCNUMBERB",
                 title: "Номер<br/>документу",
                 width: "8.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCORGB",
                 title: "Орган, що<br/>видав документ",
                 width: "11.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "DOCDATEB",
                 title: "Дата видачі<br/>документа",
                 template: "<div>#= kendo.toString(kendo.parseDate(DOCDATEB),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DOCDATEB),'dd.MM.yyyy')#</div>",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CLIENTBDATEB",
                 title: "Дата<br/>народження",
                 template: "<div>#= kendo.toString(kendo.parseDate(CLIENTBDATEB),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CLIENTBDATEB),'dd.MM.yyyy')#</div>",
                 width: "9.5em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "SEX",
                 title: "Стать",
                 width: "7em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "CLIENTPHONEB",
                 title: "Телефон",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "PERCENT",
                 title: "Відсоток<br/>спадщини %",
                 template: "<div>#= PERCENT * 100#</div>",
                 width: "10em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "REGDATE",
                 title: "Дата реєстрації",
                 template: "<div>#= kendo.toString(kendo.parseDate(REGDATE),'dd.MM.yyyy HH:mm:ss')#</div>",
                 width: "15em",
                 filterable: {
                     cell: {
                         operator: "contains"
                     }
                 }
             }, {
                 field: "IDB", hidden: true
             }
        ],
        dataSource: {
            type: "aspnetmvc-ajax",
            pageSize: 10,
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/getbenef"),
                    data: { rnk: rnk, code: 'N' }
                }
            },
            schema: {
                model: {
                    fields: {
                        RNK: { type: "string" },
                        ID: { type: "string" },
                        KKNAME: { type: "string" },
                        CODE: { type: "string" },
                        FIOB: { type: "string" },
                        NAME: { type: "string" },
                        FULLADDRESSB: { type: "string" },
                        ICODB: { type: "string" },
                        DOCTYPEB: { type: "string" },
                        DOCSERIALB: { type: "string" },
                        DOCNUMBERB: { type: "string" },
                        DOCORGB: { type: "string" },
                        DOCDATEB: { type: "string" },
                        CLIENTBFATEB: { type: "string" },
                        SEX: { type: "string" },
                        CLIENTPHONEB: { type: "string" },
                        PERCENT: { type: "number" }
                    }
                }
            }
        }
    });
}
clientGrids.depoOnFuneral = function (rnk) {
    $("#depoOnFuneral").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        change: readBenef,
        pageable: {
            refresh: true,
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
                title: "Номер вкладу",
                template: "<a class='link-color' href='/barsroot/Crkr/DepositProfile/DepositInventory?depoId=${ID}&flag=1&burial=" + (clientGrids.burial ? "true" : "false") + "&funeral=" + (clientGrids.funeral ? "true" : "false") + "'>${ID}</a>",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "KKNAME",
                title: "Назва вкладу",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NSC",
                title: "Номер рахунку<br/>АСВО",
                width: "10.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OST",
                title: "Сумма<br/>вкладу",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "LCV",
                title: "Валюта",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "REGISTRYDATE",
                title: "Дата заключення<br/>договору",
                template: "<div>#= kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy') #</div>",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DATO",
                title: "Дата відкриття<br/>вкладу",
                template: "<div>#= kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy') #</div>",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DATN",
                title: "Дата нарахування<br/>процентів",
                template: "<div>#= kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy')#</div>",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "SUM",
                title: "Сумма<br/>внесків",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OST",
                title: "Залишок",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STATUS_NAME",
                title: "Статус",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "REASON_CHANGE_STATUS",
                title: "Причина<br/>блокування",
                width: "16em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "RNK",
                title: "РНК",
                width: "7em",
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
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/depoonfuneral"),
                    data: { rnk: rnk}
                }
            },
            schema: {
                model: {
                    fields: {
                        ID: { type: "number" },
                        KKNAME: { type: "string" },
                        NSC: { type: "string" },
                        LCV: { type: "string" },
                        REGISTRYDATE: { type: "string" },
                        DATO: { type: "string" },
                        DATN: { type: "string" },
                        SUM: { type: "string" },
                        OST: { type: "string" },
                        RNK: { type: "string" },
                        REASON_CHANGE_STATUS: { type: "string" },
                        STATUS_NAME: { type: "string" }
                    }
                }
            }
        }
    });

   
}
