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
            , { type: "separator" }
            , { template: "<div class='legend corp-light'>CorpLight</div>" }
            , { template: "<div class='legend corp2'>Corp2</div>" }
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
            bars.ui.getFiltersByMetaTable(function (response) {
                if (response.length > 0) {
                    var grid = $("#grid").data("kendoGrid");
                    filterParam = response[0];
                    var res = getFilterParam();
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
                var grid = $("#grid").data("kendoGrid");
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
                    bars.visaCtrl.runCheckData(row);
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
            success: function (data) {
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
        return { requestType: dk, flt: getFilterParam() }
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
                        VIZA: { type: "number", editable: false },
                        PRIORITY: { type: "number", editable: false },
                        PRIORNAME: { type: "string" },
                        COMM: { gtype: "string", editable: false },
                        COVER_ID: { type: "number", editable: false },
                        VERIFY_OPT: { type: "number", editable: false },
                        OBZ: { type: "number", editable: false },
                        TXT: { type: "string" },
                        KV_CONV: { type: "number", editable: false },
                        REQ_TYPE: { type: "number", editable: false },
                        SUP_DOC: { type: "boolean" },
                        ATTACHMENTS_COUNT: { type: "number", editable: false  },
                        F092_Code: { type: "string", editable: false},
                        F092_Text: { type: "string", editable: true }
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
        //reorderable: true,
        //columnMenu: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "ATTACHMENTS_COUNT",
                title: "Додано<br>сканкопію<br>документів",
                template: function (data) {
                    var isAttach = data.ATTACHMENTS_COUNT != null && data.ATTACHMENTS_COUNT > 0;
                    var text = "<input type='checkbox' disabled data-bid-id='" + data.ID;
                    if (isAttach) {
                        text += "' checked/><label class='loadLb'>завантажити</label>";
                    }
                    else {
                        text += "' />";
                    }
                    return text;
                },
                width: 120,
                attributes: { style: "text-align:center;" }
            }, {
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
                locked: true,
                width: 100
            }, {
                field: "RNK",
                title: "РНК клієнта",
                locked: true,
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
            }, {
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
                        template: '<span style="font-size:0.8em">#:PRIORNAME#</span>',
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
            }, 
            {
                field: "F092_Text",
                title: "Мета продажу (510)",
                hidden: false,
                width: 300,
                editor: function (container, options) {
                    var input = $('<input data-text-field="F092_Name" data-value-field="F092_Code" data-bind="value:' + options.field + '"/>');
                    input.appendTo(container);

                    input.kendoDropDownList({
                        autoBind: true,
                        dataTextField: "F902_Name",
                        dataValueField: "F092_Code",
                        optionLabel: "Змінити на...",
                        valueTemplate: '<span>#:F092_Code + " " + F092_Name#</span>',
                        template: '<span style="font-size:0.8em">#:F092_Code + " " + F092_Name#</span>',
                        dataSource: {
                            transport: {
                                read: {
                                    type: "GET",
                                    dataType: "json",
                                    url: bars.config.urlContent("api/zay/F092/GetF092")
                                }
                            },
                            schema: {
                                data: "Data",
                                total: "Total"
                            }
                        },
                        change: function (e) {
                            var grid = $("#grid").data("kendoGrid");
                            var row = grid.dataItem(grid.select());
                            row.F092_Text = this.text();
                            row.F092_Code = this.value();
                        }
                    }).appendTo(container);

                    var dropdownlist = input.data("kendoDropDownList");
                    dropdownlist.list.width(360);
                }
            },
            {
                field: "TXT",
                title: "Опис коду<br/>цілі продажу",
                hidden:true,
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
                        change: function (e) {
                            var aimCode = this.value(),
                                grid = $("#grid").data("kendoGrid"),
                                row = grid.dataItem(grid.select()),
                                model = grid.dataItem(this.element.closest("tr"));

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
        }
        ,dataBound: function (e) {
            var data = this.dataSource.view();

            for (var i = 0; i < data.length; i++) {
                var dataItem = data[i];
                var tr = $("#grid").find("[data-uid='" + dataItem.uid + "']");
                if (dataItem.FNAMEKB == 'CL')
                    tr.addClass('corp-light');
                else if (dataItem.FNAMEKB == 'C2')
                    tr.addClass('corp2');
                //var color = dataItem.FNAMEKB == 'CL' ? 'corp-light' : 'corp2';
                //tr.addClass(color);
            }
        }
    });

    $("#grid .k-grid-content").on("change", "input.chkbx", function (e) {
        var grid = $("#grid").data("kendoGrid"),
            dataItem = grid.dataItem($(e.target).closest("tr"));

        dataItem.set("SUP_DOC", this.checked);
    });

    $("#grid .k-grid-content").kendoTooltip({
        autoHide: false,
        showOn: "click",
        filter: "tr.corp-light td:has(input[checked])",
        content: {
            url: bars.config.urlContent("/api/zay/currencystatus/GetFilesTooltipContent")
        },
        width: 270,
        position: "left",
        animation: {
            close: {
                effects: "fadeOut",
                //effects: "fadeOut zoom:out",
                duration: 300
            },
            open: {
                effects: "slideIn:left fadeIn",
                //effects: "fadeIn zoom:in",
                duration: 300
            }
        },
        requestStart: function (e) {
            var dataItem = $("#grid").data("kendoGrid").dataItem($(e.target).closest("tr"));
            e.options.data = {
                bidId: dataItem.ID
            }
        },
        contentLoad: function () {
            //because IE8
            $("a.load-file").each(function () {
                var href = this.href;
                $(this).click(function (e) {
                    e.preventDefault();
                    window.location.href = href;
                    return false;
                });
            });
        }
    });
    //function getTooltipContent(e) {
    //    var target = $(e.target);
    //    var bidId = target.context.children[0].dataset.bidId;
    //    var filesList = sessionStorage[bidId];
    //    if (filesList) {
    //        filesList = JSON.parse(filesList);
    //    }
    //    else {
    //        var grid = $("#grid");
    //        bars.ui.loader(grid, true);
    //        var content = false;
    //        $.ajax({
    //            async: false,
    //            url: bars.config.urlContent("/api/ExternalServices/GetCorpLightFilesInfo"),
    //            contentType: "application/json",
    //            dataType: "json",
    //            data: { bidId: bidId},
    //            success: function (result) {
    //                bars.ui.loader(grid, false);
    //                if (result.nodata) {
    //                    content = "<div class='load-file'>По заявці (ID: " + bidId + ") файлів не знайдено.</div>";
    //                }
    //                else if (result.error) {
    //                    bars.ui.error({ text: result.error });
    //                }
    //                else {
    //                    filesList = result;
    //                    sessionStorage[bidId] = JSON.stringify(result);
    //                    content = createTooltipContent(filesList, bidId);
    //                }
    //            }
    //        });
    //        bars.ui.loader(grid, false);
    //        return content;
    //    }
    //}

    //function createTooltipContent(filesList, bidId) {
    //    if (!filesList) return;
    //    var fileLinks = "";
    //    var fileIds = [];
    //    for (var i = 0; i < filesList.length; i++) {
    //        fileLinks += '<a href="' + bars.config.urlContent("/api/ExternalServices/GetCorpLightFile", { fileId: filesList[i].Id }) + '" class="load-file"><table><tr><td>' + filesList[i].FileName + '</td><td>' + filesList[i].Comment + '</td></tr></table></a>';
    //        fileIds.push(filesList[i].Id);
    //    }
    //    var content = '';
    //    if (filesList.length > 1)
    //        content += '<a href="' + bars.config.urlContent("/api/ExternalServices/GetCorpLightAllFiles", { fileIds: fileIds, bidId: bidId }) + '" class="load-file"><table><tr><td colspan="2">Завантажити всі</td></tr></table></a>';
    //    content += fileLinks;
    //    return content;
    //}
});

