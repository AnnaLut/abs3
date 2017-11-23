$(document).ready(function () {
    function switchCurrencyMode() {
        $("#grid").data("kendoGrid").dataSource.read();
    }

    $("#toolbar").kendoToolBar({
        items: [
            {
                template: "<button id='sightCencel' type='button' class='k-button' title='Повернути з візування'><i class='pf-icon pf-16 pf-delete'></i></button>"
            },
            {
                template: "<button id='setViza' type='button' class='k-button' title='Завізувати'><i class='pf-icon pf-16 pf-save'></i></button>"
            },
            {
                template: "<button id='btnPrint' type='button' class='k-button' title='Завантажити для друку'><i class='pf-icon pf-16 pf-print'></i></button>"
            },
            { type: "separator" },
            {
                template: "<button id='btnPrintCorp' type='button' class='k-button' title='Завантажити для друку, заявка CORP2'><i class='pf-icon pf-16 pf-print'></i></button>"
            },
            { type: "separator" },
            { type: "button", text: "За валюту", id: "currencyUse", togglable: true, selected: false, toggle: switchCurrencyMode }
        ]
    });

    $("#currencyUse").kendoButton();

    $("#cenceling-window").kendoWindow({
        title: "Повернення заявки з візування",
        visible: false,
        width: "600px",
        resizable: false,
        actions: ["Close"]
    });

    var createCencelTemplate = function (data) {
        var box = $("#cencel-box"),
            cencelTemplate = kendo.template($("#CencelReasonPattern").html());
        box.html(cencelTemplate(data));
    }

    var initReasonDictionare = function () {
        $("#reason").kendoDropDownList({
            dataTextField: "REASON",
            dataValueField: "ID",
            dataSource: {
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: bars.config.urlContent("/api/zay/reason/get")
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total"
                }
            },
            height: 400
        });
        var dropdownlist = $("#reason").data("kendoDropDownList");
        dropdownlist.list.width(380);
    }

    var initRequestWindowBtns = function (row) {

        var window = $("#cenceling-window").data("kendoWindow");

        var backReasonObj = function (row) {
            return {
                Mode: 2,
                Id: row.ID,
                IdBack: $("#reason").data("kendoDropDownList").value(),
                Comment: $("#comment").val()
            }
        }


        $("#save-reason-btn").kendoButton({
            click: function (row, window) {
                var grid=$("#grid").data("kendoGrid");
                rowSelect = grid.dataItem(grid.select());                
                var request = backReasonObj(rowSelect);

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/zay/backrequest/post"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(request)
                }).done(function (result) {
                    if (result.Status === "Ok") {
                        bars.ui.alert({ text: result.Message });
                        $("#grid").data("kendoGrid").dataSource.read();

                        $("#cenceling-window").data("kendoWindow").close();
                    } else {
                        bars.ui.error({ text: result.Message });

                        $("#cenceling-window").data("kendoWindow").close();
                    }
                });
            }
        });

        $("#cencel-reason-btn").kendoButton({
            click: function (window) {
                $("#cenceling-window").data("kendoWindow").close();
            }
        });
    }

    $("#sightCencel").kendoButton({
        click: function () {
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {
                bars.ui.confirm({
                    text: "Ви впевнені, що хочете повернути заявку клієнта " +
                        row.NMK + " на купівлю " + (row.S2 / 100).toFixed(2) + "/" + row.KV2 + "?"
                }, function () {
                    var window = $("#cenceling-window").data("kendoWindow");
                    createCencelTemplate(row);

                    initReasonDictionare();
                    initRequestWindowBtns(row);

                    window.center();
                    window.open();
                });
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        }
    });

    $("#btnPrint").kendoButton({
        click: function () {
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {
                window.location = bars.config.urlContent("/zay/currencybuysighting/ExportDoc/") + "?id=" + row.ID;
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        }
    });

    var isEnableCorpPrintBtn = function (data) {
        if (data != null && data.IDENTKB != null) {
            return true;
        } else {
            return false;
        }
    }

    $("#btnPrintCorp").kendoButton({
        click: function () {
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {
                var winDoc = window.open(bars.config.urlContent("/zay/currencybuysighting/clobcorp?id=" + row.IDENTKB), "_blank", "");
                //winDoc.document.write("<p>try msg</p>");
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        },
        enable: false
    });

    function dataContext() {
        var grid = $("#grid").data("kendoGrid");
        var dk = 1;
        grid.hideColumn("KV_CONV");
        if ($("#currencyUse.k-state-active").length > 0) {
            grid.showColumn("KV_CONV");
            dk = 3;
        }
        return { requestType: dk }
    }

    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        pageSize: 10,
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        transport: {
            read: {
                dataType: "json",
                type: "GET",
                url: bars.config.urlContent("/api/zayBuy/zay/currencybuysighting/GetDataList"),
                data: dataContext,
                success: function () {
                    //
                },
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
                    KV2: { type: "number" },
                    KV_CONV: { type: "number" },
                    ID: { type: "number" },
                    RNK: { type: "number" },
                    NMK: { type: "string" },
                    CUST_BRANCH: { type: "string" },
                    NLS_ACC0: { type: "string" },
                    OSTC0: { type: "number" },
                    NLS: { type: "string" },
                    S2: { type: "number" },
                    KURS_Z: { type: "number" },
                    FDAT: { type: "date" },
                    KOM: { type: "number" },
                    SKOM: { type: "number" },
                    PRIORNAME: { type: "string" },
                    META_AIM_NAME: { type: "string" },
                    CONTRACT: { type: "string" },
                    DAT2_VMD: { type: "date" },
                    NUM_VMD: { type: "string" },
                    DAT_VMD: { type: "date" },
                    DAT5_VMD: { type: "string" },
                    BASIS_TXT: { type: "string" },
                    COUNTRY_NAME: { type: "string" },
                    NAME: { type: "string" },
                    BANK_CODE: { type: "string" },
                    BANK_NAME: { type: "string" },
                    PRODUCT_GROUP_NAME: { type: "string" },
                    MFOP: { type: "string" },
                    NLSP: { type: "string" },
                    OKPOP: { type: "string" },
                    COMM: { type: "string" },
                    REQ_TYPE: { type: "number" },
                    ATTACHMENTS_COUNT: { type: "number" }
                }
            }
        }
    });

    $("#grid").kendoGrid({
        //autoBind: false,
        dataSource: dataSource,
        //height: 550,
        //groupable: true,
        sortable: true,
        selectable: "row",
        filterable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "BLK",
                title: "Флаг<br/>блок.<br/>грн",
                template: "<div style='text-align:center'>" +
                           "<input name='BLK' type='checkbox' checked='checked' />" +
                           "</div>",
                width: 50,
                filterable: false,
                hidden: glReserve !== 0 ? true : false
            },
            {
                field: "KV2",
                title: "Валюта<br/> заявки",
                width: 70,
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            min: 0,
                            format: "n0"
                        });
                    }
                }
            }
        , {
            field: "KV_CONV",
            title: "ЗА ВАЛ",
            width: 100,
            hidden: true
        }, {
            field: "ID",
            title: "Ідентифікатор<br/> заявки",
            width: 110,
            filterable: {
                ui: function (element) {
                    element.kendoNumericTextBox({
                        min: 0,
                        format: "n0"
                    });
                }
            }
        }, {
            field: "RNK",
            title: "РНК клієнта",
            width: 100,
            filterable: {
                ui: function (element) {
                    element.kendoNumericTextBox({
                        min: 0,
                        format: "n0"
                    });
                }
            }
        }, {
            field: "NMK",
            title: "Назва<br/>клієнта-продавця",
            width: 150
        }, {
            field: "CUST_BRANCH",
            title: "Відділення<br/>клієнта-продавця",
            width: 200
        }, {
            field: "NLS_ACC0",
            title: "Рахунок для<br/> списання коштів",
            width: 125,
            filterable: {
                ui: function (element) {
                    element.kendoNumericTextBox({
                        min: 0,
                        format: "n0"
                    });
                }
            }
        }, {
            field: "OSTC0",
            title: "Сальдо<br/>  рахунку списання",
            width: 130,
            filterable: {
                ui: function (element) {
                    element.kendoNumericTextBox({
                        min: 0,
                        format: "n0"
                    });
                }
            },
            template: "<div style='text-align:right'>#=OSTC0.toLocaleString()#</div>"
        }, {
            field: "NLS",
            title: "Рахунок для<br/>  зарахування ВАЛ",
            width: 150,
            filterable: {
                ui: function (element) {
                    element.kendoNumericTextBox({
                        min: 0,
                        format: "n0"
                    });
                }
            }
        }, {
            field: "S2",
            title: "Сума<br/> покупки ВАЛ",
            width: 100,
            //template: "<div>#=(S2/100).toFixed(2)#</div>"
            template: "<div style='text-align:right'>#=(S2/100).toLocaleString()#</div>"
}, {
            field: "KURS_Z",
            title: "Курс<br/> покупки",
            width: 75
        }, {
            field: "FDAT",
            title: "Дата заявки",
            width: 100,
            template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>"
        }, {
            title: "Комісія",
            columns: [
                {
                    field: "KOM",
                    title: "%",
                    width: 50
                }, {
                    field: "SKOM",
                    title: "Сума",
                    width: 100
                }
            ]
        }, {
            field: "PRIORNAME",
            title: "Пріоритет<br/> заявки",
            width: 120
        }, {
            field: "META_AIM_NAME",
            title: "Ціль",
            width: 50,
            template: "<div style='text-align:center'>" +
                "<input name='META_AIM_NAME' type='checkbox' disabled='disabled' data-bind='checked: META_AIM_NAME' #= META_AIM_NAME !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            title: "Контракт",
            columns: [
                {
                    field: "CONTRACT",
                    title: "№",
                    width: 50,
                    template: "<div style='text-align:center'>" +
                        "<input name='CONTRACT' type='checkbox' disabled='disabled' data-bind='checked: CONTRACT' #= CONTRACT !== null ? checked='checked' : '' #/>" +
                        "</div>",
                    filterable: false
                }, {
                    field: "DAT2_VMD",
                    title: "Дата",
                    width: 50,
                    template: "<div style='text-align:center'>" +
                        "<input name='DAT2_VMD' type='checkbox' disabled='disabled' data-bind='checked: DAT2_VMD' #= DAT2_VMD !== null ? checked='checked' : '' #/>" +
                        "</div>",
                    filterable: false
                }
            ]
        }, {
            title: "ТД",
            columns: [
                {
                    field: "NUM_VMD",
                    title: "№",
                    width: 50,
                    template: "<div style='text-align:center'>" +
                        "<input name='NUM_VMD' type='checkbox' disabled='disabled' data-bind='checked: NUM_VMD' #= NUM_VMD !== null ? checked='checked' : '' #/>" +
                        "</div>",
                    filterable: false
                }, {
                    field: "DAT_VMD",
                    title: "Дата",
                    width: 50,
                    template: "<div style='text-align:center'>" +
                        "<input name='DAT_VMD' type='checkbox' disabled='disabled' data-bind='checked: DAT_VMD' #= DAT_VMD !== null ? checked='checked' : '' #/>" +
                        "</div>",
                    filterable: false
                }, {
                    field: "DAT5_VMD",
                    title: "Дати <br/> інших <br/> ТД",
                    width: 55,
                    template: "<div style='text-align:center'>" +
                        "<input name='DAT5_VMD' type='checkbox' disabled='disabled' data-bind='checked: DAT5_VMD' #= DAT5_VMD !== null ? checked='checked' : '' #/>" +
                        "</div>",
                    filterable: false
                }
            ]
        }, {
            field: "BASIS_TXT",
            title: "Причина<br/> покупки",
            width: 75,
            template: "<div style='text-align:center'>" +
                "<input name='BASIS_TXT' type='checkbox' disabled='disabled' data-bind='checked: BASIS_TXT' #= BASIS_TXT !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            field: "COUNTRY_NAME",
            title: "Країна<br/>  перерахув. <br /> вал",
            width: 85,
            template: "<div style='text-align:center'>" +
                "<input name='COUNTRY_NAME' type='checkbox' disabled='disabled' data-bind='checked: COUNTRY_NAME' #= COUNTRY_NAME !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            field: "NAME",
            title: "Країна<br/> бенефіц.",
            width: 75,
            template: "<div style='text-align:center'>" +
                "<input name='NAME' type='checkbox' disabled='disabled' data-bind='checked: NAME' #= NAME !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            field: "BANK_CODE",
            title: "Код <br /> банку",
            width: 75,
            template: "<div style='text-align:center'>" +
                "<input name='BANK_CODE' type='checkbox' disabled='disabled' data-bind='checked: BANK_CODE' #= BANK_CODE !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            field: "BANK_NAME",
            title: "Назва <br /> банку",
            width: 75,
            template: "<div style='text-align:center'>" +
                "<input name='BANK_NAME' type='checkbox' disabled='disabled' data-bind='checked: BANK_NAME' #= BANK_NAME !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            field: "PRODUCT_GROUP_NAME",
            title: "Код<br/>  товарної <br /> групи",
            width: 75,
            template: "<div style='text-align:center'>" +
                "<input name='PRODUCT_GROUP_NAME' type='checkbox' disabled='disabled' data-bind='checked: PRODUCT_GROUP_NAME' #= PRODUCT_GROUP_NAME !== null ? checked='checked' : '' #/>" +
                "</div>",
            filterable: false
        }, {
            title: "ПФ",
            columns: [
                {
                    field: "MFOP",
                    title: "МФО ",
                    width: 120
                }, {
                    field: "NLSP",
                    title: "Рахунок",
                    width: 120,
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }, {
                    field: "OKPOP",
                    title: "Код ОКПО",
                    width: 120,
                    filterable: {
                        ui: function (element) {
                            element.kendoNumericTextBox({
                                min: 0,
                                format: "n0"
                            });
                        }
                    }
                }
            ]
        }, {
            field: "COMM",
            title: "Коментар",
            width: 400
        }, {
            field: "REQ_TYPE",
            title: "Назва<br/>типу заявки",
            width: 130
        }, {
            field: "ATTACHMENTS_COUNT",
            title: "Додано<br>сканкопію<br>документів",
            template: "<input type='checkbox' disabled " + "#=(data.ATTACHMENTS_COUNT == 0 || data.ATTACHMENTS_COUNT == null) ? '' : 'checked'#" + "/>",
            width: 90,
            attributes: { style: "text-align:center;" }
        }
        ],
        change: function () {
            var grid = $("#grid").data("kendoGrid"),
                currentRow = grid.dataItem(grid.select());
            $("#btnPrintCorp").data("kendoButton").enable(isEnableCorpPrintBtn(currentRow));
        }
    });

    $("#window").kendoWindow({
        title: "Перегляд додаткових реквізитів покупки",
        visible: false,
        width: "600px",
        //height: "300px",
        resizable: false,
        actions: ["Close"]
    });

    var windowSeedTemplate = function (data) {
        var box = $("#box"),
            rowEditTemplate = kendo.template($("#RowEditPattern").html());
        box.html(rowEditTemplate(data));
    }

    $("#grid").on("dblclick", "tr.k-state-selected", function () {
        var grid = $("#grid").data("kendoGrid"),
            currentRow = grid.dataItem(grid.select()),
            window = $("#window").data("kendoWindow");

        var aimCode = currentRow.META_AIM_NAME ? currentRow.META_AIM_NAME.substr(0, currentRow.META_AIM_NAME.indexOf(" ")) : '',
            aimName = currentRow.META_AIM_NAME ? currentRow.META_AIM_NAME.substr(currentRow.META_AIM_NAME.indexOf(" ") + 1) : '';
        aimCode = aimCode.replace(/^0/, "");

        var p63 = currentRow.BASIS_TXT ? currentRow.BASIS_TXT.substr(0, currentRow.BASIS_TXT.indexOf(" ")) : "",
            txt = currentRow.BASIS_TXT ? currentRow.BASIS_TXT.substr(currentRow.BASIS_TXT.indexOf(" ") + 1) : "";

        var grpCode = currentRow.PRODUCT_GROUP_NAME !== null ? currentRow.PRODUCT_GROUP_NAME.substr(0, currentRow.PRODUCT_GROUP_NAME.indexOf(" ")) : currentRow.PRODUCT_GROUP_NAME,
            grpName = currentRow.PRODUCT_GROUP_NAME !== null ? currentRow.PRODUCT_GROUP_NAME.substr(currentRow.PRODUCT_GROUP_NAME.indexOf(" ") + 1) : currentRow.PRODUCT_GROUP_NAME;

        // update responsed model for dropdownlists:
        currentRow.AIM_CODE = aimCode;
        currentRow.AIM_NAME = aimName;

        currentRow.P63 = p63;
        currentRow.TXT = txt;

        currentRow.PRODUCT_GROUP = grpCode;
        currentRow.PRODUCT_GROUP_NAME = grpName;

        windowSeedTemplate(currentRow);

        bars.helper.initAllDictionaries(currentRow);
        bars.helper.initDatepickers(currentRow);

        window.center();
        window.open();
    });
    /*
    function setViza(row) {
         
        var model = { Id: row.ID, Viza: 1, Priority: row.PRIORITY, AimsCode: null, SupDoc: null };
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/zay/setvisa/post"),
            data: JSON.stringify(model)
        }).done(function (result) {
             
            bars.ui.loader("body", false);
            if (result.Status === 1) {
                bars.ui.alert({ text: result.Message });
                var grid = $("#grid").data("kendoGrid");
                grid.dataSource.read();
            } else {
                bars.ui.error({ text: result.Message });
            }
        });
    }
    
    
    function setPriority(row, dk) {
        // SET_PRIORITY(ZAYV_BUY.ID, ZAYV_BUY.DK, ZAYV_BUY.COVERED, ZAYV_BUY.PRIORITY)
         
        bars.ui.loader("body", false);
        if (dk !== 3) {
            // check: If pCoverFl = 0 AND pPriorId != nCovered AND nCovered > 0
            if (row.COVER_ID === 0 && row.PRIORITY !== parseInt(glCovered) && parseInt(glCovered) > 0) {
                bars.ui.confirm({
                    text: 'Заявка № ' + row.ID + ' не обеспечена средствами.' +
                        'Вы действительно хотите завизировать заявку с приоритетом № ' + row.PRIORITY +' ?'
                }, function() {
                     
                    //If pBuySell = 1
                    //Set ZAYV_BUY.PRIORITY = nCovered
                    bars.ui.loader("body", true);
                    setViza(row);
                });
            } else {
                bars.ui.error({ text: 'Заявка не пройшла перевірку. Операція скасована!' });
            }
        } else {
             
            bars.ui.loader("body", true);
            setViza(row);
        }
    }*/

    $("#setViza").kendoButton({
        click: function () {
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {

                bars.visaCtrl.runCheckData(row);

                /*
                 
                // F_CHECK_DATA: перша з 3х 
                bars.ui.loader("body", true);
                var model = { dk: row.DK, id: row.ID, kv: row.KV2, s: row.S2, kursZ: row.KURS_Z, fDat: row.FDAT };
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/zay/currencystatus/post"),
                    data: JSON.stringify(model)
                }).done(function (result) {
                    
                     
    
                    
                    if (result) {
                        bars.ui.loader("body", false);
                        var arrayOfLines = [];
                        arrayOfLines = result.split(/\r?\n/);
                        bars.ui.error({ text: arrayOfLines[0] });
                    } else {
    
                         
    
                        // F_RESERVE:
                        if (parseInt(glReserve) === 0) {
                            
                            // insure if realy unlock grn? Y/N
                            // Y > SET_PRIORITY ? do viza : false
    
                            //get DK result - покупка або продаж....але ж і так зрозуміло????!!!!!!! навіщо????
                            $.ajax({
                                type: "GET",
                                contentType: "application/json",
                                url: bars.config.urlContent("/api/zay/actiontype/get"),
                                data: { id: row.ID }
                            }).done(function(dkResult) {
                                 
                                if (dkResult.Data !== 3) {
                                     
                                    bars.ui.loader("body", false);
    
                                    bars.ui.confirm({ text: 'Вы действительно хотите отказаться от блокировки гривны?' }, function () {
                                         
                                        // -- bars.ui.alert({ text: 'ZAY. Пользователь отказался от блокировки гривны, необходимой на покупку валюты по заявке' });
                                        // run PRIORITY(row + start > bars.ui.loader("body", false);) func
    
                                        setPriority(row, dkResult.Data);
                                    });
                                } else {
                                     
                                    // Do reserve:
                                    $.ajax({
                                        type: "GET",
                                        contentType: "application/json",
                                        url: bars.config.urlContent("/api/zay/reserve/get"),
                                        data: { id: row.ID, type: 1 }
                                    }).done(function(reserveResult) {
                                        if (reserveResult.Data.Msg && reserveResult.Data.SumB === 0) {
                                             
                                            bars.ui.loader("body", false);
                                            bars.ui.alert({ text: reserveResult.Data.Msg });
                                        } else {
                                             
                                            // go forward, run PRIORITY(row + start > bars.ui.loader("body", false);) func
                                            bars.ui.loader("body", false);
                                            bars.ui.alert({ text: reserveResult.Data.Msg });
                                             
                                            bars.ui.loader("body", true);
                                            setPriority(row, dkResult.Data);
                                        }
                                    });
                                }
                            });
    
                             
                            
                        } else {
                             
                            bars.ui.loader("body", false);
                        }
                    }
                });
    
                */
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        },
        enable: true
    });

    

});