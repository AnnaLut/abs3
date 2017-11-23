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
            {
                template: "<button id='btnRefresh' type='button' class='k-button' title='Оновити'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>"
            },
             {
                 template: "<button id='btnFilter' type='button' class='k-button' title='Складний фільтр'><i class='pf-icon pf-16 pf-filter-ok'></i></button>"
             },
            { type: "separator" },
            {
                template: "<button id='btnPrintCorp' type='button' class='k-button' title='Завантажити для друку, заявка CORP2'><i class='pf-icon pf-16 pf-print'></i></button>"
            },
            { type: "separator" },
            { type: "button", text: "За валюту", id: "currencyUse", togglable: true, selected: false, toggle: switchCurrencyMode }
        ]
    });

    // *** toolbar funcs ***
    $("#cenceling-window").kendoWindow({
        title: "Повернення заявки з візування",
        visible: false,
        width: "600px",
        resizable: false,
        actions: ["Close"]
    });

    var filterParam = '';
    /**
     * повертає значення фільтру у вигляді стринга
     */
    function getFilterParam() {
        debugger;
        var result = '';
        var paramType = typeof filterParam;
        if (filterParam && paramType === "string") {
            result = filterParam;
        } else if (filterParam && paramType === "object") {
            result = filterParam[0];
        }
        return result.toString();
    }


    $("#btnFilter").kendoButton({
        click: function () {
            debugger;
            bars.ui.getFiltersByMetaTable(function (response) {
                debugger;
                if (response.length > 0) {
                    var grid = $("#grid").data("kendoGrid");
                    filterParam = response[0];
                    var res = getFilterParam();
                    debugger;
                    grid.dataSource.read({
                        flt: res
                    });
                }
            }, { tableName: "V_ZAY_QUEUE" });
        }
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

    var initRequestWindowBtns = function(row) {

        var window = $("#cenceling-window").data("kendoWindow");

        var backReasonObj = function(row) {
            return {
                Mode: 2,
                Id: row.ID,
                IdBack: $("#reason").data("kendoDropDownList").value(),
                Comment: $("#comment").val()
            }
        }

        $("#save-reason-btn").kendoButton({
            click: function (row, window) {
                var grid = $("#grid").data("kendoGrid");
                rowSelect = grid.dataItem(grid.select());
                var request = backReasonObj(rowSelect);

                $.ajax({
                    type: "POST",
                    url: bars.config.urlContent("/api/zay/backrequest/post"),
                    contentType: "application/json",
                    dataType: "json",
                    data: JSON.stringify(request)
                }).done(function(result) {
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
            click: function(window) {
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

    $("#btnRefresh").kendoButton({
        click: function () {
            $("#grid").data("kendoGrid").dataSource.read();
            $("#grid").data("kendoGrid").refresh();
        }
    });
    $("#btnPrint").kendoButton({
        click: function () {
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {
                window.location = bars.config.urlContent("/zay/currencysalesighting/ExportDoc/") + "?id=" + row.ID;
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        }
    });

    var isEnableCorpPrintBtn = function (data) {
        // та сама умова відображення, що і для покупки...але "продаж" не має IDENTKB! (в новій версії sqlQuery)
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
                var winDoc = window.open(bars.config.urlContent("/zay/currencysalesighting/clobcorp?id=" + row.IDENTKB), "_blank", "");
                //winDoc.document.write("<p>try msg</p>");
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        },
        enable: false
    });

    $("#setViza").kendoButton({
        click: function () {
             
            var grid = $("#grid").data("kendoGrid"),
                row = grid.dataItem(grid.select());
            if (row) {
                if (row.TXT) {
                    bars.visaCtrl.runCheckData(row);
                } else {
                    bars.ui.error({ text: "Необхідно вказати опис коду цілі!" });
                }
            } else {
                bars.ui.error({ text: "Оберіть заявку!" });
            }
        },
        enable: true
    });

    // *** grid ***

    function isValidItem(itemId) {
        $.ajax({
            url: bars.config.urlContent("/api/zay/kodd31/checkitem"),
            data: { id: itemId },
            type: "GET",
            success: function(data) {
                if (data === 1) {
                    return true;
                } else {
                    return false;
                }
            }
        });
    }

    function dataContext() {
        var grid = $("#grid").data("kendoGrid");
        var dk = 2;
        grid.hideColumn("KV_CONV");
        if ($("#currencyUse.k-state-active").length > 0) {
            dk = 4;
            grid.showColumn("KV_CONV");
        }
        return { requestType: dk,flt: getFilterParam()   }
    }

    $("#grid").kendoGrid({
        //autoBind: false,
        editable: true,
        dataSource: {
            type: "aspnetmvc-ajax",
            transport: {
                read: {
                    type: "GET",
                    dataType: 'json',
                    contentType: "application/json",
                    url: bars.config.urlContent("/api/zaySale/zay/currencysalesighting/GetDataList"),
                    data: dataContext,
                    success: function () {
                        //
                    },
                    error: function (xhr, error) {
                        bars.ui.error({ text: "Сталася помилка при спробі завантажити дані таблиці.<br/>" + error });
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        KV2: { type: "number", editable: false },
                        DK: { type: "number", editable: false },
                        ID: { type: "number", editable: false },
                        FDAT: { type: "date", editable: false },
                        RNK: { type: "number", editable: false },
                        NMK: { type: "string", editable: false },
                        CUST_BRANCH: { type: "string", editable: false },
                        S2: { type: "number", editable: false },
                        KURS_Z: { type: "number", editable: false },
                        ACC0: { type: "number", editable: false },
                        NLS_ACC0: { type: "string", editable: false },
                        MFO0: { type: "string", editable: false },
                        OKPO0: { type: "string", editable: false },
                        ACC1: { type: "number", editable: false },
                        NLS: { type: "string", editable: false },
                        OSTC: { type: "number", editable: false },
                        DIG: { type: "number", editable: false },
                        KOM: { type: "number", editable: false },
                        SKOM: { type: "number", editable: false },
                        META_AIM_NAME: { type: "string", editable: false },
                        VIZA: { type: "number", editable: false },
                        PRIORITY: { type: "number", editable: false },
                        PRIORNAME: { type: "string" },
                        COMM: { gtype: "string", editable: false },
                        COVER_ID: { type: "number", editable: false },
                        VERIFY_OPT: { type: "number", editable: false },
                        OBZ: { type: "number", editable: false },
                        AIMS_CODE: { type: "number", editable: false }, // centura має можливість редагувати, у вебі сказали не треба, лише dropList
                        TXT: { type: "string" },
                        KV_CONV: { type: "number", editable: false },
                        REQ_TYPE: { type: "number", editable: false },
                        SUP_DOC: { type: "boolean" },
                        ATTACHMENTS_COUNT: { type: "number" }
                    }
                }
            },
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 20
        },
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
                title: "Валюта<br/>заявки",
                width: 100,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            },
            {
                field: "KV_CONV",
                title: "За<br/>валюту",
                width: 100,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                },
                hidden: true 
            }, {
                field: "OBZ",
                title: "ОБЗ",
                width: 50,
                hidden: false,
                template: "<div style='text-align:center'>" +
                            "<input name='OBZ' type='checkbox' disabled='disabled' data-bind='checked: OBZ' #= OBZ !== null ? checked='checked' : '' #/>" +
                            "</div>",
                filterable: false
            }, {
                field: "ID",
                title: "Ідентифікатор<br/>заявки",
                width: 100
            }, {
                field: "RNK",
                title: "РНК клієнта",
                width: 100,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            }, {
                field: "NMK",
                title: "Назва<br/>клієнта-продавця",
                width: 150
            }, {
                field: "CUST_BRANCH",
                title: "Відділення<br/>клієнта-продавця",
                width: 120
            }, {
                field: "MFO0",
                title: "МФО<br/>зарахування коштів",
                width: 150
            }, {
                field: "NLS_ACC0",
                title: "Рахунок для<br/>зарахування коштів",
                width: 150
            }, {
                field: "NLS",
                title: "Рахунок для<br/>списання ВАЛ",
                width: 150
            }, {
                field: "OSTC",
                title: "Сальдо<br/>рахунку ВАЛ",
                width: 130,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            }, {
                field: "S2",
                title: "Сума<br/>продажу ВАЛ",
                template: "<div style='text-align: right;'>#=(S2/100).toFixed(2)#</div>",
                width: 130,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            }, {
                field: "KURS_Z",
                title: "Курс<br/>продажу",
                width: 130,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            },{
                field: "FDAT",
                title: "Дата<br/>заявки",
                width: 150,
                template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>"
            },
            {
                title: "Комісія",
                columns: [
                    {
                        field: "KOM",
                        title: "%",
                        width: 100,
                        filterable: {
                            cell: {
                                showOperators: false
                            }
                        }
                    }, {
                        field: "SKOM",
                        title: "Сума",
                        width: 100,
                        filterable: {
                            cell: {
                                showOperators: false
                            }
                        }
                    }
                ]
            }, {
                field: "PRIORNAME",
                title: "Пріоритет<br/>заявки",
                width: 120,
                editor: function (container, options) {
                    var input = $('<input data-text-field="PRIORNAME" data-value-field="PRIORITY" data-bind="value: ' + options.field + '"/>');
                    input.appendTo(container);
                    //init drop
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "PRIORNAME",
                        dataValueField: "PRIORITY",
                        optionLabel: "Змінити на...",
                        /*valueTemplate: '<span>#:PRIORNAME#</span>',
                        template: '<span class="k-state-default"></span>' +
                                                  '<span class="k-state-default">#:PRIORNAME#</span>',*/
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/zay/priority/get")
                                }
                            },
                            schema: {
                                data: "Data",
                                total: "Total"
                            }
                        },
                        change: function (e) {
                            var priorityCode = this.value(),
                                priorityName = this.text(),
                                grid = $("#grid").data("kendoGrid"),
                                row = grid.dataItem(grid.select());

                            row.PRIORNAME = priorityName;
                            // ToDo: 
                            // row.ID + new aimCode....
                        }
                    }).appendTo(container);
                }
            }, {
                field: "META_AIM_NAME",
                title: "Мета",
                width: 150
            }, {
                field: "AIMS_CODE",
                title: "Цифровий код<br/>цілі продажу",
                hidden: true,
                width: 100
            }, {
                field: "TXT",
                title: "Опис коду<br/>цілі продажу",
                width: 300,
                editor: function (container, options) {
                    var input = $('<input data-text-field="TXT" data-value-field="P40" data-bind="value:' + options.field + '"/>');
                    input.appendTo(container);

                    // init block of dropdownlist:
                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "TXT",
                        dataValueField: "P40",
                        optionLabel: "Змінити на...",
                        valueTemplate: '<span>#:TXT#</span>',
                        template: '<span class="k-state-default"></span>' +
                                                  '<span class="k-state-default">#:TXT#</span>',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("/api/zay/kodd31/get")
                                }
                            },
                            schema: {
                                data: "Data",
                                total: "Total"
                            }
                        },
                        change: function(e) {
                            var aimCode = this.value(),
                                grid = $("#grid").data("kendoGrid"),
                                row = grid.dataItem(grid.select()),
                                model = grid.dataItem(this.element.closest("tr"));
                             
                            model.set("AIMS_CODE", parseInt(aimCode));
                            //model.set('TXT', this.text());
                            row.TXT = this.text();
                            //grid.select(0);
                        }
                    }).appendTo(container);
                }
            }, {
                field: "SUP_DOC",
                title: "Наявність<br/>затвердж.<br/>документів",
                width: 50,
                hidden: false,
                template: "<div style='text-align:center'>" +
                            '<input name="SUP_DOC" type="checkbox" #= SUP_DOC ? \'checked="checked"\' : "" # class="chkbx" />' +
                            "</div>",
                filterable: false
            }, {
                field: "COMM",
                title: "Коментар",
                width: 400
            }, {
                field: "REQ_TYPE",
                title: "Назва<br/>типу заявки",
                width: 200,
                filterable: {
                    cell: {
                        showOperators: false
                    }
                }
            },{
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
        },
        edit: function (e) {

            var input = e.container.find(".k-input");
            var value = input.val();
            input.keyup(function () {
                value = input.val();
            });
            $("[name='AIMS_CODE']", e.container).blur(function () {
                var input = $(this);
                //$("#log").html(input.attr('name') + " blurred : " + value);
                var grid = $("#grid").data("kendoGrid");
                var row = $(this).closest("tr");
                var item = grid.dataItem(row);
                if (isValidItem(input.val())) {

                } else {
                    bars.ui.alert({ text: 'Увага!!! Такого коду цілі не знайдено!' });
                }
                //alert("TXT is : " + item.TXT);
            });
            
        }
        /*,
        dataBound: function (e) {
            console.log("dataBound");

            var data = this.dataSource.view();

            for (var i = 0; i < data.length; i++) {
                var dataItem = data[i];
                var tr = $("#grid").find("[data-uid='" + dataItem.uid + "']");
                // use the table row (tr) and data item (dataItem)
            }
        }*/
    });

    $("#grid .k-grid-content").on("change", "input.chkbx", function (e) {
        var grid = $("#grid").data("kendoGrid"),
            dataItem = grid.dataItem($(e.target).closest("tr"));

        dataItem.set("SUP_DOC", this.checked);
    });
});

