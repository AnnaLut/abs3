var isFirstLoadFlag = true;

function openDocumentByRef(Ref) {
    if (Ref != null && Ref !== "null" && Ref != undefined) {
        OpenBarsDialog("/barsroot/documentview/document.aspx?ref=" + Ref,
            {
                height: 600,
                width: 900,
                modal: false
            }
        );
    }
    else { bars.ui.error({ title: 'Помилка', text: "Неправильний Ref!" }); }
}

function openSwiftMessageByRef(SWRef) {
    if (SWRef != null && SWRef !== "null" && SWRef != undefined) {
        OpenBarsDialog("/barsroot/documentview/view_swift.aspx?swref=" + SWRef,
            {
                height: 600,
                width: 900,
                modal: false
            }
        );
    }
    else { bars.ui.error({ title: 'Помилка', text: "Неправильний SWRef!" }); }
}

function fillGPIMessagesGrid() {
    $("#GTIStatusesGrid").data("kendoGrid").dataSource.read();
    $("#GTIStatusesGrid").data("kendoGrid").refresh();
}

function fillMT199Grid() {
        $("#MT199MessagesGrid").data("kendoGrid").dataSource.read();
        $("#MT199MessagesGrid").data("kendoGrid").refresh();
}

function functionName(func) {
    // Match:
    // - ^          the beginning of the string
    // - function   the word 'function'
    // - \s+        at least some white space
    // - ([\w\$]+)  capture one or more valid JavaScript identifier characters
    // - \s*        optionally followed by white space (in theory there won't be any here,
    //              so if performance is an issue this can be omitted[1]
    // - \(         followed by an opening brace
    //
    var result = /^function\s+([\w\$]+)\s*\(/.exec(func.toString())

    return result ? result[1] : '' // for an anonymous function there won't be a match
}

function createLinkTemplate(fieldName, parameter, clickFunction) {
    var resultTempateString = "";
    if (parameter != null && parameter != "") {
        resultTempateString = '<a href="#" onclick="' + functionName(clickFunction) + '(\'' + parameter + '\')" style="color: blue">' + fieldName + '</a>';
    }
    //here clickFunction parameter is passed like reference to function, while we need only name
    return resultTempateString;
}

function makeAutofitColumnWidth(grid) {
    for (var i = 0; i < grid.columns.length; i++) {
        grid.autoFitColumn(i);
    }
}

function initMainGrid() {
    var toolbar = $("#MainGridToolbar").kendoToolBar({
        items: [
            {
                id: "excel",
                type: "button",
                text: '<span class="k-icon k-i-excel"></span>Вивантажити в Excel',
                title: "Вивантажити в Excel",
                click: function () {
                    $('#GTIStatusesGrid').data('kendoGrid').saveAsExcel();
                }, overflow: "never"
            },
        ]
    });

    $("#GTIStatusesGrid").kendoGrid({
        columns: [
            {
                template: '#= createLinkTemplate( Ref, Ref, openDocumentByRef) #',
                field: "Ref",
                title: "Реф документу АБС",
                filterable:
                {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#",
                            decimals: 0
                        });
                    }
                },
                width: "8%"
            },
            {
                field: "MT103",
                title: "MT103",
                filterable:
                {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#",
                            decimals: 0
                        });
                    }
                },
                width: "8%"
            },
            {
                field: "InputOutputInd103",
                title: "Вх/Вих MT103",
                width: "8%"
            },
            {
                template: '#= createLinkTemplate( SWRef, SWRef, openSwiftMessageByRef) #',
                field: "SWRef",
                title: "Реф MT103",
                filterable:
                {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#",
                            decimals: 0
                        });
                    }
                },
                width: "8%"
            },
            {
                field: "DateIn",
                title: "Дата надходження",
                filterable:
                {
                    operators: {
                        date: {
                            gte: "після або рівна",
                            gt: "після",
                            lte: "до або рівними",
                            lt: "до"
                        }
                    }
                },
                //filterable:
                //{
                //    ui: function DateTimeFilter(control) {
                //        $(control).kendoDateTimePicker({
                //            format: "dd.MM.yyyy HH:mm:ss",
                //            timeFormat: "HH:mm:ss"
                //        });
                //    }
                //},
                width: "15%",
                template: "<div style='text-align:center;'>#=(DateIn == null) ? ' ' : kendo.toString(DateIn,'dd.MM.yyyy  HH:mm:ss')#</div>"
            },
            {
                field: "VDate",
                title: "Дата валютування",
                width: "10%",
                template: "<div style='text-align:center;'>#=(VDate == null) ? ' ' : kendo.toString(VDate,'dd.MM.yyyy')#</div>"
            },
            {
                field: "DateOut",
                title: "Дата відправки",
                filterable:
                {
                    operators: {
                        date: {
                            gte: "після або рівна",
                            gt: "після",
                            lte: "до або рівними",
                            lt: "до"
                        }
                    }
                },
                width: "15%",
                template: "<div style='text-align:center;'>#=(DateOut == null) ? ' ' : kendo.toString(DateOut,'dd.MM.yyyy  HH:mm:ss')#</div>"
            },
            {
                field: "SenderCode",
                title: "Код відправника",
                width: "10%"
            },
            {
                field: "SenderAccount",
                title: "Рахунок відправника",
                width: "10%"
            },
            {
                field: "ReceiverCode",
                title: "Код отримувача",
                width: "10%"
            },
            {
                field: "Payer",
                title: "Платник",
                width: "15%"
            },
            {
                field: "Payee",
                title: "Отримувач платежу",
                width: "15%"
            },
            {
                field: "Summ",
                title: "Сума",
                template: '#=kendo.toString(Summ,"n")#',
                format: '{0:n}',
                width: "8%"
            },
            {
                field: "Currency",
                title: "Валюта",
                width: "4%"
            },
            {
                field: "STI",
                title: "STI",
                width: "15%"
            },
            {
                field: "UETR",
                title: "UETR (Field121)",
                width: "15%"
            },
            {
                field: "Status",
                title: "Статус платежу",
                width: "5%"
            },
            {
                field: "StatusDescription",
                title: "Опис статусу",
                width: "15%"
            },
        ],
        dataSource: {
            type: "webapi",
            transport: {
                read: {
                    type: "GET",
                    contentType: "application/json;charset=utf-8",
                    //url: bars.config.urlContent('Api/Swift/GPIDocsReviewApi/GetMainGridItems'),
                    //url: bars.config.urlContent('Api/Swift/GPIDocsReviewApi/GetTestMainItems'),
                    url: bars.config.urlContent('/Swift/GPIDocsReview/GetMainGridItems'),
                    data: function () {
                        var filter = $("#GTIStatusesGrid").data("kendoGrid").dataSource.filter();
                        if (filter != undefined) {
                            isFirstLoadFlag = false;
                            $(".filterMessage").hide();
                        }
                        else {
                            //add filter of datasource to show messages of the last 5 days:
                            //if (isFirstLoadFlag) {
                            //    var curr_filters = [];
                            //    var 5daysAgoDate = get_curr_Date() - 5 days;
                            //    var new_filter = { field: "DateIn", operator: "gte", value:  };
                            //    filter(curr_filters);
                            //    filter.Logic = "and";
                            //}
                        }
                        return {
                            isFirstLoad: isFirstLoadFlag
                        };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                error: "Errors",
                errors: function (response) {
                    if (response.Errors)
                        bars.ui.error({ text: response.Errors });
                },
                model: {
                    fields: {
                        Ref: { type: "number" },
                        MT103: { type: "number" },
                        InputOutputInd103: { type: "string" },
                        SWRef: { type: "number" },
                        DateIn: { type: "date" },
                        VDate: { type: "date" },
                        DateOut: { type: "date" },
                        SenderCode: { type: "string" },
                        SenderAccount: {type: "string"},
                        ReceiverCode: { type: "string" },
                        Payer: { type: "string" },
                        Payee: { type: "string" },
                        Summ: { type: "number" },
                        Currency: { type: "string" },
                        STI: { type: "string" },
                        UETR: { type: "string" },
                        Status: { type: "string" },
                        StatusDescription: { type: "string" }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverFiltering: true
        },
        autobind: true,
        dataBound: function (e) {
            e.sender.select("tr:eq(1)");
            makeAutofitColumnWidth(this);
        },
        change: fillMT199Grid,
        selectable: "row",
        filterable: true,
        sortable: true,
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: [10, 20, 50],
            buttonCount: 3
        },
        excel: {
            allPages: true,
            fileName: "GPI. Список повідомлень.xlsx",
            proxyURL: bars.config.urlContent("/Swift/GPIDocsReview/ConvertBase64ToFile")
        },
        excelExport: function (e) {
            var columns = e.workbook.sheets[0].columns;
            columns.forEach(function (column) {
                delete column.width;
                column.autoWidth = true;
            });
        },
        noRecords: {
            template: '<div class="k-label" style="color:grey; margin:20px 20px;"> Відсутні записи! </div>'
        }
    });
}

function getSelectedMainGridRow() {
    var mainGrid = $("#GTIStatusesGrid").data("kendoGrid");
    var selectedRow = mainGrid.dataItem(mainGrid.select());
    return selectedRow;
}

function initMT199MessagesGrid() {
    var toolbar = $("#MT199GridToolbar").kendoToolBar({
        items: [
            {
                id: "excel",
                type: "button",
                text: '<span class="k-icon k-i-excel"></span>Вивантажити в Excel',
                title: "Вивантажити в Excel",
                click: function () {
                    $('#MT199MessagesGrid').data('kendoGrid').saveAsExcel();
                }, overflow: "never"
            },
        ]
    });

    $("#MT199MessagesGrid").kendoGrid({
        columns: [
            {
                field: "UETR",
                title: "UETR",
                width: "15%"
            },
            {
                template: '#= createLinkTemplate( Ref, Ref, openSwiftMessageByRef) #',
                field: "Ref",
                title: "Реф повідомлення",
                filterable:
                {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#",
                            decimals: 0
                        });
                    }
                },
                width: "8%"
            },
            {
                field: "MT",
                title: "MT",
                filterable:
                {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#",
                            decimals: 0
                        });
                    }
                },
                width: "8%"
            },
            {
                field: "Status",
                title: "Статус платежу",
                width: "5%"
            },
            {
                field: "StatusDescription",
                title: "Опис статусу",
                width: "15%"
            },
            {
                field: "SenderCode",
                title: "Код відправника",
                width: "10%"
            },
            {
                field: "ReceiverCode",
                title: "Код отримувача",
                width: "10%"
            },
            {
                field: "Currency",
                title: "Валюта",
                width: "4%"
            },
            {
                field: "Summ",
                title: "Сума",
                template: '#=kendo.toString(Summ,"n")#',
                format: '{0:n}',
                width: "8%"
            },
            {
                field: "DateOut",
                title: "Дата відправки",
                filterable:
                {
                    operators: {
                        date: {
                            gte: "після або рівна",
                            gt: "після",
                            lte: "до або рівними",
                            lt: "до"
                        }
                    }
                },
                width: "15%",
                template: "<div style='text-align:center;'>#=(DateOut == null) ? ' ' : kendo.toString(DateOut,'dd.MM.yyyy  HH:mm:ss')#</div>"
            },
        ],
        dataSource: {
            type: "webapi",
            transport: {
                read: {
                    type: "GET",
                    //url: bars.config.urlContent('Api/Swift/GPIDocsReviewApi/GetMT199GridItems'),
                    url: bars.config.urlContent('/Swift/GPIDocsReview/GetMT199GridItems'),
                    data: function () {
                        var selectedRow = getSelectedMainGridRow();
                        var UETRobj, UETRval;
                        
                        if (!!selectedRow)
                            UETRval = selectedRow.UETR;
                        else
                            UETRval = "";

                        UETRobj = {
                            curUETR: UETRval
                        };
                       
                        return UETRobj;
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: function (response) {
                    if (response.Errors)
                        bars.ui.error({ text: response.Errors });
                },
                model: {
                    fields: {
                        UETR: { type: "string" },
                        Ref: { type: "number" },
                        MT: { type: "number" },
                        SenderCode: { type: "string" },
                        ReceiverCode: { type: "string" },
                        Summ: { type: "number" },
                        Currency: { type: "string" },
                        Status: { type: "string" },
                        StatusDescription: { type: "string" },
                        DateOut: { type: "date" }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
        },
        autobind: false,
        dataBound: function (e) {
            makeAutofitColumnWidth(this);
        },
        filterable: true,
        sortable: true,
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: [10],
            buttonCount: 3
        },
        excel: {
            allPages: true,
            fileName: "GPI. Повідомлення MT199.xlsx",
            proxyURL: bars.config.urlContent("/Swift/GPIDocsReview/ConvertBase64ToFile")
        },
        excelExport: function (e) {
            var columns = e.workbook.sheets[0].columns;
            columns.forEach(function (column) {
                delete column.width;
                column.autoWidth = true;
            });
        },
        noRecords: {
            template: '<div class="k-label" style="color:grey; margin:20px 20px;"> Відсутні записи! </div>'
        }
    });
}

$(document).ready(function () {
    initMainGrid();
    initMT199MessagesGrid();
});