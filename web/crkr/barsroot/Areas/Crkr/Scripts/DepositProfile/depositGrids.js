var CrvHistory = CrvHistory || {};
var DepoInfo = DepoInfo || {};

$("#toolbarLegend").kendoToolBar({
    items: [
        { template: "<div id='hist' class='legend-storno'><label class='legend-label'>- операція сторнування/видалення</label></div>" }
    ]
});
//bocouse ie8
if (!String.prototype.includes) {
    // ReSharper disable once NativeTypePrototypeExtending
    String.prototype.includes = function () {
        'use strict';
        return String.prototype.indexOf.apply(this, arguments) !== -1;
    };
}
var dataEdit = function (date) {
    var date = kendo.toString(kendo.parseDate(date), 'dd.MM.yyyy HH:mm:ss');
    if (!date.includes("01.01.0001")) {
        if (!date.includes("00:00:00"))
            return '<div>' + date + '</div>';
        else
            return date.substring(0, 10);

    }
    return "";
}

function DATLEdit(e) {
    return dataEdit(e.DATL);
}

function DATPEdit(e) {
    return dataEdit(e.DATP);

}

function checkStatus() {
    var grid = $('#clientHistoryGrid').data('kendoGrid');
    grid.tbody.find('>tr').each(function () {
        var dataItem = grid.dataItem(this);
        if ((dataItem.STAT !== null && dataItem.STAT.includes("D")) || (dataItem.STAT !== null && dataItem.STAT.includes("S"))) {
            $(this).addClass('status-S');
        }
    });
}


DepoInfo.initDepoGrids = function (id) {    
    $("#clientHistoryGrid").kendoGrid({
        autobind: true,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        dataBound: checkStatus,
        columns: [
        {
            field: "IDM",
            title: "РК РУ",
            width: "7em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "DATL",
            title: "Дата операції",
            template: DATLEdit,
            width: "10em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "DATP",
            title: "Дата останньої<br/>зміни",
            template: DATPEdit,
            width: "12em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "TXT",
            title: "Операція",
            width: "16em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "MSG",
            title: "Інформація",
            width: "14em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "SUMOP",
            title: "Сума<br/>операції",
            width: "10em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "REF",
            title: "Референс",
            width: "14em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "STAT",
            title: "Статус<br/>операції",
            width: "14em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "ID_COMPEN_BOUND",
            title: "Пов'язаний<br/>вклад",
            width: "10em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "USER_LOGIN",
            title: "Логін<br/>користувача",
            width: "10em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "USER_LOGIN_VIZA",
            title: "Користувач,<br/>що завізував",
            width: "10em",
            filterable: {
                cell: {
                    operator: "contains"
                }
            }
        },
        {
            field: "USER_VISA_DATE",
            title: "Дата<br/>візування",
            template: DATPEdit,
            width: "12em",
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
                    url: bars.config.urlContent("/api/crkr/getprofile/gethistory?id=" + id)
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        IDM: { type: "string" },
                        DATL: { type: "string" },
                        DATP: { type: "string" },
                        OI: { type: "string" },
                        OL: { type: "string" },
                        OST: { type: "string" },
                        PREA: { type: "string" },
                        SUMOP: { type: "string" },
                        TYPO: { type: "string" },
                        VER: { type: "string" },
                        ZPR: { type: "string" },
                        REF: { type: "string" },
                        MARK: { type: "string" },
                        STAT: { type: "string" },
                        TXT: { type: "string" },
                        MSG: { type: "string" },
                        ID_COMPEN_BOUND: { type: "string" },
                        USER_LOGIN: { type: "string" },
                        USER_LOGIN_VIZA: { type: "string" },
                        USER_VISA_DATE: { type: "string" }
                    }
                }
            }
        }
    });
};
DepoInfo.powerOfAttorney = function (id) {
    $("#powerOfAttorneyGrid").kendoGrid({
        resizable: true,
        autobind: true,
        selectable: "row",
        sortable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
           {
               field: "FIOB",
               //template: "<a href='/barsroot/Crkr/DepositProfile/DepositInventory/${ID}'>${FIO}</a>",
               title: "ПІБ Клієнта",
               width: "11em",
               headerAttributes: { style: "white-space: normal" },
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "NSC",
               title: "Номер рахунку",
               headerAttributes: { style: "white-space: normal" },
               //template: "<a href='/barsroot/Heritage/Heri/DepositInventory/${CreditNumb}'>${CreditNumb}</a>",
               width: "10em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "FULLADDRESSB",
               title: "Адреса",
               width: "15em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "ICODB",
               title: "ІНН",
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCTYPEB",
               title: "Тип документа",
               headerAttributes: { style: "white-space: normal" },
               width: "9em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCUMENTB",
               title: "Серія та номер",
               headerAttributes: { style: "white-space: normal" },
               width: "8em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCORGB",
               title: "Ким виданий",
               headerAttributes: { style: "white-space: normal" },
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCDATEB",
               title: "Дата видачі",
               headerAttributes: { style: "white-space: normal" },
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "CLIENTBDATEB",
               title: "Дата народження",
               headerAttributes: { style: "white-space: normal" },
               width: "8.2em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "CLIENTPHONEB",
               title: "Телефон клієнта",
               headerAttributes: { style: "white-space: normal" },
               width: "7.5em",
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

                    //type: "POST",
                    url: bars.config.urlContent("/api/crkr/getprofile/gettrustedperson?id=" + id)
                    //data: { Id: glId }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        FIOB: { type: "string" },
                        NSC: { type: "string" },
                        FULLADDRESSB: { type: "string" },
                        ICODB: { type: "string" },
                        DOCTYPEB: { type: "string" },
                        DOCUMENTB: { nullable: true, type: "string" },
                        DOCORGB: { type: "string" },
                        DOCDATEB: { type: "string" },
                        CLIENTBDATEB: { type: "string" },
                        CLIENTPHONEB: { nullable: true, type: "string" }
                    }
                }
            }
        }
    });
};
DepoInfo.wills = function (id) {
    $("#willsGrid").kendoGrid({
        resizable: true,
        autobind: true,
        selectable: "row",
        sortable: true,
        filterable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
           {
               field: "FIOB",
               //template: "<a href='/barsroot/Crkr/DepositProfile/DepositInventory/${ID}'>${FIO}</a>",
               title: "ПІБ Клієнта",
               width: "11em",
               headerAttributes: { style: "white-space: normal" },
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "NSC",
               title: "Номер рахунку",
               headerAttributes: { style: "white-space: normal" },
               //template: "<a href='/barsroot/Heritage/Heri/DepositInventory/${CreditNumb}'>${CreditNumb}</a>",
               width: "10em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "FULLADDRESSB",
               title: "Адреса",
               width: "15em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "ICODB",
               title: "ІНН",
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCTYPEB",
               title: "Тип документа",
               headerAttributes: { style: "white-space: normal" },
               width: "9em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCUMENTB",
               title: "Серія та номер",
               headerAttributes: { style: "white-space: normal" },
               width: "8em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCORGB",
               title: "Ким виданий",
               headerAttributes: { style: "white-space: normal" },
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "DOCDATEB",
               title: "Дата видачі",
               headerAttributes: { style: "white-space: normal" },
               width: "7em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "CLIENTBDATEB",
               title: "Дата народження",
               headerAttributes: { style: "white-space: normal" },
               width: "8.2em",
               filterable: {
                   cell: {
                       operator: "contains"
                   }
               }
           },
           {
               field: "CLIENTPHONEB",
               title: "Телефон клієнта",
               headerAttributes: { style: "white-space: normal" },
               width: "7.5em",
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
                    //type: "POST",
                    url: bars.config.urlContent("/api/crkr/getprofile/getheirsperson?id=" + id)
                    //data: { Id: glId }

                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        FIOB: { type: "string" },
                        NSC: { type: "string" },
                        FULLADDRESSB: { type: "string" },
                        ICODB: { type: "string" },
                        DOCTYPEB: { type: "string" },
                        DOCUMENTB: { nullable: true, type: "string" },
                        DOCORGB: { type: "string" },
                        DOCDATEB: { type: "string" },
                        CLIENTBDATEB: { type: "string" },
                        CLIENTPHONEB: { nullable: true, type: "string" }
                    }
                }
            }
        }
    });
};



CrvHistory.clientCrvHistory = function (dbcode) {
    $("#clientHistoryGridCrv").kendoGrid({
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
                field: "ID",
                title: "ID",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STAFF_ID",
                title: "Користувач,<br/>що створив",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_STATE",
                title: "Статус",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_TYPE",
                title: "Тип",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_ID",
                title: "ID<br/>актуалізації",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_DBCODE",
                title: "DBCODE<br/>клієнта у АСВО",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_RNK",
                title: "RNK клієнта<br/>у АСВО",
                width: "9em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "BDATE_FINAL",
                title: "Кінцева<br/>дата народження",
                template: "<div>#= kendo.toString(kendo.parseDate(BDATE_FINAL),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(BDATE_FINAL),'dd.MM.yyyy')#</div>",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "BRANCH",
                title: "Відділення,<br/>де було створено",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CL_APPROVED",
                title: "Клієнта<br/>підтвердженно",
                width: "10.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CL_COMMENT",
                title: "Текст<br/>перевірки",
                width: "9em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRT_DATE",
                title: "Дата<br/>створення",
                template: "<div>#= kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_DBCODE",
                title: "DBCODE клієнта<br/>у ЦРВ",
                width: "9em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_RNK",
                title: "РНК клієнта<br/>у ЦРВ",
                width: "9em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOC_ISSUE_FINAL",
                title: "Ким видано<br/>документ",
                width: "9.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "DOC_ISSUE_DATE_FINAL",
                title: "Коли видано<br/>документ (кінцевий)",
                template: "<div>#= kendo.toString(kendo.parseDate(DOC_ISSUE_DATE_FINAL),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DOC_ISSUE_DATE_FINAL),'dd.MM.yyyy')#</div>",
                width: "9.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "FIO_FINAL",
                title: "ПІБ (кінцевий)",
                width: "11.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "KEY_DOC_COMMENT",
                title: "Ключовий реквізит<br/>текст перевірки",
                width: "16em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OKPO_FINAL",
                title: "ІПН кінцева",
                width: "9.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "SEC_WORD_FINAL",
                title: "Секретне слово, кінцеве",
                template: "<div>#= kendo.toString(kendo.parseDate(SEC_WORD_FINAL),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(SEC_WORD_FINAL),'dd.MM.yyyy')#</div>",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STATE_DATE",
                title: "Дата статусу",
                template: "<div>#= kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TEL1_FINAL",
                title: "Телефон 1<br/>кінцевий",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TEL2_FINAL",
                title: "Телефон 1<br/>кінцевий",
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
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/gethistory"),
                    data: { dbcode: dbcode }
                }
            },
            schema: {
                model: {
                    fields: {
                        ID: { type: "string" },
                        STAFF_ID: { type: "string" },
                        ACT_STATE: { type: "string" },
                        ACT_TYPE: { type: "string" },
                        ACT_ID: { type: "string" },
                        ASVO_DBCODE: { type: "string" },
                        ASVO_RNK: { type: "string" },
                        BDATE_FINAL: { type: "string" },
                        BRANCH: { type: "string" },
                        CL_APPROVED: { type: "string" },
                        CL_COMMENT: { type: "string" },
                        CRT_DATE: { type: "string" },
                        CRV_DBCODE: { type: "string" },
                        CRV_RNK: { type: "string" },
                        DOC_ISSUE_FINAL: { type: "string" },
                        DOC_ISSUE_DATE_FINAL: { type: "string" },
                        FIO_FINAL: { type: "string" },
                        KEY_DOC_COMMENT: { type: "string" },
                        OKPO_FINAL: { type: "string" },
                        SEC_WORD_FINAL: { type: "string" },
                        STATE_DATE: { type: "string" },
                        TEL1_FINAL: { type: "string" },
                        TEL2_FINAL: { type: "string" }
                    }
                }
            }
        }
    });
}
CrvHistory.depoCrvHistory = function (dbcode) {
    $("#depoHistoryGrid").kendoGrid({
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
                field: "ID_ACT",
                title: "ID_ACT",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STAFF_ID",
                title: "Користувач,<br/>що створив",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRT_DATE",
                title: "Дата<br/>створення",
                template: "<div>#= kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "BRANCH",
                title: "Відділення,<br/>де було створено",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_STATE",
                title: "Статус",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STATE_DATE",
                title: "Дата статусу",
                template: "<div>#= kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_TYPE",
                title: "Тип",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_ID",
                title: "ID<br/>актуалізації",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ID",
                title: "ID",
                width: "8.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_DPT_ID",
                title: "Ідентифікатор<br/>кладу у ЦРВ",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRB_BRANCH",
                title: "Код відділення<br/>вкладу у ЦРВ",
                width: "11.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_NSC",
                title: "Номер вкладу<br/>у ЦРВ",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_OST",
                title: "Залишок по<br/>вкладу у ЦРВ",
                width: "10.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_DBCODE",
                title: "DBCODE<br/>клієнта у АСВО",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_BRANCH",
                title: "Код відділення<br/>вкладу АСВО",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_NSC",
                title: "Номер вкладу<br/>у АСВО",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_OST",
                title: "Залишок по вкладу<br/>у АСВО",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "KEY_COMMENT",
                title: "Ключовий реквізит<br/>текст перевірки",
                width: "16em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PMT_SUM",
                title: "Сума платежу для<br/>списання з вкладу",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PMT_INF_REF",
                title: "Референс інформаційного<br/>документу",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PMT_INT_REF",
                title: "Референс внуртрішного<br/>документу",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRV_FIO",
                title: "ПІБ власника<br/>вкладу у ЦРВ",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_FIO",
                title: "ПІБ власника<br/>вкладу у АСВО",
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
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crkr/clientgrid/depohistory"),
                    data: { dbcode: dbcode }
                }
            },
            schema: {
                model: {
                    fields: {
                        ID_ACT: { type: "string" },
                        STAFF_ID: { type: "string" },
                        CRT_DATE: { type: "string" },
                        BRANCH: { type: "string" },
                        ACT_STATE: { type: "string" },
                        STATE_DATE: { type: "string" },
                        ACT_TYPE: { type: "string" },
                        ACT_ID: { type: "string" },
                        ID: { type: "string" },
                        CRV_DPT_ID: { type: "string" },
                        CRB_BRANCH: { type: "string" },
                        CRV_NSC: { type: "string" },
                        CRV_OST: { type: "string" },
                        ASVO_DBCODE: { type: "string" },
                        ASVO_BRANCH: { type: "string" },
                        ASVO_NSC: { type: "string" },
                        ASVO_OST: { type: "string" },
                        KEY_COMMENT: { type: "string" },
                        PMT_SUM: { type: "string" },
                        PMT_INF_REF: { type: "string" },
                        PMT_INT_REF: { type: "string" },
                        CRV_FIO: { type: "string" },
                        ASVO_FIO: { type: "string" }
                    }
                }
            }
        }
    });
}
CrvHistory.payCrvHistory = function (dbcode) {
    $("#payHistoryGrid").kendoGrid({
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
                field: "ID",
                title: "ID",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STAFF_ID",
                title: "Користувач,<br/>що створив",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CRT_DATE",
                title: "Дата<br/>створення",
                template: "<div>#= kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CRT_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "BRANCH",
                title: "Відділення,<br/>де було створено",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_STATE",
                title: "Статус",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "STATE_DATE",
                title: "Дата статусу",
                template: "<div>#= kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(STATE_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_TYPE",
                title: "Тип",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ACT_ID",
                title: "ID<br/>актуалізації",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ISSUE_DATE",
                title: "Дата видачі<br/>карти",
                template: "<div>#= kendo.toString(kendo.parseDate(CARD_ISSUE_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(CARD_ISSUE_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ABS_BRANCH",
                title: "Відділення<br/>картки у АБС",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ABS_ACCOUNT",
                title: "Картковий<br/>рахунок у АБС",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PAYMENT_DATE",
                title: "Дата виплат",
                template: "<div>#= kendo.toString(kendo.parseDate(PAYMENT_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(PAYMENT_DATE),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ISSUE_BRANCH",
                title: "Відділення<br/>відачі картки",
                width: "12em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ISSUE_BRANCH_ADR",
                title: "Адреса відділення,<br/>для видачі карти",
                width: "9em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ABS_MATCH",
                title: "Квитова інформація при<br/>відкритті карт. рахунку",
                width: "8.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ABS_MATCH_TEXT",
                title: "Текст квитової інформації при<br/>відкритті карт. рахунку",
                width: "8.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CARD_ABS_MATCH_FIELD",
                title: "ID файла відправки",
                width: "11.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PAYMENT_MATCH",
                title: "Квитова інформація<br/>про виплату",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PAYMENT_MATCH_TEXT",
                title: "Текст квитовки про<br/>відкриття крт. рахунку",
                width: "9.5em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "PAYMENT_MATCH_DATE",
                title: "Інформація про виплату",
                template: "<div>#= kendo.toString(kendo.parseDate(PAYMENT_MATCH_DATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(PAYMENT_MATCH_DATE),'dd.MM.yyyy')#</div>",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "ASVO_DBCODE",
                title: "DBCODE<br/>клієнта у АСВО",
                width: "12em",
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
                    url: bars.config.urlContent("/api/crkr/clientgrid/payhistory"),
                    data: { dbcode: dbcode }
                }
            },
            schema: {
                model: {
                    fields: {
                        ID: { type: "string" },
                        STAFF_ID: { type: "string" },
                        CRT_DATE: { type: "string" },
                        BRANCH: { type: "string" },
                        ACT_STATE: { type: "string" },
                        STATE_DATE: { type: "string" },
                        ACT_TYPE: { type: "string" },
                        ACT_ID: { type: "string" },
                        CARD_ISSUE_DATE: { type: "string" },
                        CARD_ABS_BRANCH: { type: "string" },
                        CARD_ABS_ACCOUNT: { type: "string" },
                        PAYMENT_DATE: { type: "string" },
                        CARD_ISSUE_BRANCH: { type: "string" },
                        CARD_ISSUE_BRANCH_ADR: { type: "string" },
                        CARD_ABS_MATCH: { type: "string" },
                        CARD_ABS_MATCH_TEXT: { type: "string" },
                        CARD_ABS_MATCH_FIELD: { type: "string" },
                        PAYMENT_MATCH: { type: "string" },
                        PAYMENT_MATCH_TEXT: { type: "string" },
                        PAYMENT_MATCH_DATE: { type: "string" },
                        ASVO_DBCODE: { type: "string" }
                    }
                }
            }
        }
    });
}
