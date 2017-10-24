var ToJavaScriptDate = function (value) {
    var pattern = /Date\(([^)]+)\)/;
    var results = pattern.exec(value);
    if (results)
    var dt = new Date(parseFloat(results[1]));
    return dt;
}
$(document).ready(function () {
    //bocouse ie8
    window.hasOwnProperty = window.hasOwnProperty || Object.prototype.hasOwnProperty;

    var searchCompen = function (data) {
        bars.ui.loader("body", true);
        $.ajax({
            url: bars.config.urlContent("/api/Crkr/getProfile/GetCrkrBag"),
            type: "POST",
            dataType: "JSON",
            //data: JSON.stringify(data),
            data: data,
            success: function (model) {
                if (model.Data != null) {
                    for (var i = 0; i < model.Data.length; i++) {
                        model.Data[i].CLIENTBDATE = ToJavaScriptDate(model.Data[i].CLIENTBDATE);
                        model.Data[i].DOCDATE = ToJavaScriptDate(model.Data[i].DOCDATE);
                        model.Data[i].DATO = ToJavaScriptDate(model.Data[i].DATO);
                        model.Data[i].REGISTRYDATE = ToJavaScriptDate(model.Data[i].REGISTRYDATE);
                        model.Data[i].OST = model.Data[i].OST / 100;
                    }
                }                
                bars.ui.loader("body", false);
                if (typeof model === "undefined") {
                    bars.ui.notify('Вибірка вкладів занадто велика!', 'Будь ласка введіть більше параметрів фільтрації', 'error');
                } else if (model.hasOwnProperty("Total") && model.Total !== 0) {                 
                    $("#toolbarHistory").show();
                    $("#heriBag").show();
                    $("#heriBag").data("kendoGrid").dataSource.data(model.Data);
                } else if (typeof model === "string") {
                    $("#heriBag").hide();
                    $("#toolbarHistory").hide();
                    bars.ui.notify('Увага!', model, 'error');
                } else {
                    $("#heriBag").hide();
                    $("#toolbarHistory").hide();
                    bars.ui.notify('Увага!', 'Вклад(и) не знайдено. Змініть фільтр.', 'error');
                }
            },
            error: function (result) {
                bars.ui.loader("body", false);
                bars.ui.notify('Увага!', 'Вклад(и) не знайдено. Змініть фільтр.', 'error');
            }
        });
    }
    var back = bars.extension.getParamFromUrl('load', window.location.toString());
    $(function () {
        if (back === "true") {
            searchCompen({ load: true });
        }
    });

    var checkInputValues = function (values) {       
        if (values.clientbdate != "" && ((values.clientbdate.search(/^([0-2]\d|3[01])\.(0\d|1[012])\.(\d{4})$/) == -1) && values.clientbdate.search(/^(\d{4})$/) == -1))
            return { Status: "Error", Msg: "Невірний формат дати народження" };

        if (values.doctype !== "" || values.docserial !== "" || values.docnumber !== "") {
            if (!(values.doctype !== "" && values.docserial !== "" && values.docnumber !== ""))
                return { Status: "Error", Msg: "Для знаходженню по документ введіть тип док. серію та номер." };
        }

        if (values.ob22 !== "") {
            if (values.branch === "")
                return {Status: "Error", Msg: "Для знаходженню по ОБ22 введіть МФО." };
        }

        return { Status: "OK" };
    }


    $("#searchWarrant").submit(function (event) {
        event.preventDefault();
        var values = {};
        $.each($('#searchWarrant').serializeArray(), function (i, field) {
            values[field.name] = field.value;
        });
        var check = checkInputValues(values);
        if (check.Status === "OK") {
            searchCompen(values);
        } else {
            $("#heriBag").hide();
            $("#toolbarHistory").hide();
            bars.ui.notify('Увага!', check.Msg, 'error');
        }
    });
    var showError = function (data) {
        var startPos = data.indexOf(':') + 1;
        var endPos = data.indexOf('ORA', 2);
        var textRes = data.substring(startPos, endPos);
        bars.ui.error({ title: "Помилка!", text: textRes });
    }
    String.prototype.splice = function (idx, rem, str) {
        return this.slice(0, idx) + str + this.slice(idx + Math.abs(rem));
    };
    $("#heriBag").hide();
    $("#toolbarHistory").hide();
    $(function loadGrid() {
        $("#heriBag").kendoGrid({
            resizable: true,
            autobind: false,
            selectable: "row",
            sortable: true,
            filterable: true,
            scrollable: true,
            serverPaging: true,
            toolbar: [
                { name: "excel", text: "Excel" },
                { template: "<div class='legend-actual'></div><label class='legend-label-nonact'>- актуалізовані вклади</label>" },
                 { template: "<div class='legend-close'></div><label class='legend-label-nonact'>- закриті вклади</label>" },
                 { template: "<div class='legend-canceled'></div><label class='legend-label-nonact'>- блоковані вклади</label>" }
            ],
            excel: {
                fileName: "Вклади.xlsx",
                allPages: true,
                proxyURL: bars.config.urlContent("/crkr/regpay/xmlproxy")
            },
            //excelExport: function (e) {
            //    var sheet = e.workbook.sheets[0];
            //    for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
            //        var row = sheet.rows[rowIndex];
            //        for (var cellIndex = 0; cellIndex < row.cells.length; cellIndex++) {
            //            row.cells[cellIndex] = convert(row.cells[cellIndex]);
            //        }
            //    }
            //},
            pageable: {
                buttonCount: 5
            },
            columns: [
                {
                    field: "ID",
                    title: "ID вкладу",
                    width: "130px",
                    headerAttributes: { style: "white-space: normal" },
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                //{ field: "ID", hidden: true },
                { field: "ACTUAL_STATE", hidden: true },
                { field: "STATE_ID", hidden: true },
                {
                    field: "FIO",
                    title: "ПІБ Клієнта",
                    width: "180px",
                    headerAttributes: { style: "white-space: normal" },
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "CLIENTBDATE",
                    title: "Дата народження",
                    format: '{0:dd.MM.yyyy}',
                    width: "100px",
                },
                 {
                     field: "ICOD",
                     title: "ІНН",
                     width: "100px",
                     filterable: {
                         cell: {
                             operator: "contains"
                         }
                     }
                 },
                {
                    field: "FULLADDRESS",
                    template: "<div>#= FULLADDRESS == ',' || FULLADDRESS == null ? '' : FULLADDRESS #</div>",
                    title: "Адреса",
                    width: "180px",
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
                    width: "100px",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "OST",
                    title: "Залишок",
                    width: "110px",
                    //template: "<div>#= OST > 0 ? OST.splice(OST.length - 2, 0, '.') : 0#</div>",
                    //template: "<div>#=kendo.format('{0:n2}', OST/100)#</div>",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "BRANCH",
                    title: "Код відділення",
                    headerAttributes: { style: "white-space: normal" },
                    width: "210px",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "DOCUMENT",
                    title: "Серія та номер",
                    headerAttributes: { style: "white-space: normal" },
                    width: "100px",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "DOCDATE",
                    title: "Дата видачі",
                    format: '{0:dd.MM.yyyy}',
                    headerAttributes: { style: "white-space: normal" },
                    width: "100px",
                },
               
                {
                    field: "STATUS",
                    title: "Статус вкладу",
                    headerAttributes: { style: "white-space: normal" },
                    width: "100px"
                },               
                {
                    field: "REGISTRYDATE",
                    title: "Дата реєстрації",
                    format: '{0:dd.MM.yyyy}',
                    //template: "<div>#= kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy')#</div>",
                    headerAttributes: { style: "white-space: normal" },
                    width: "110px"
                },
                
                {
                    field: "KV_SHORT",
                    title: "Валюта",
                    width: "100px",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "DATO",
                    title: "Дата відкриття",
                    format: '{0:dd.MM.yyyy}',
                    //template: "<div>#= kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy')#</div>",
                    headerAttributes: { style: "white-space: normal" },
                    width: "110px"
                },
                {
                    field: "OB22",
                    title: "ОБ22",
                    headerAttributes: { style: "white-space: normal" },
                    width: "80px",
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
                            FIO: { type: "string" },
                            CLIENTBDATE: { type: "date", editable: false },
                            ICOD: { type: "string" },
                            FULLADDRESS: { type: "string" },
                            NSC: { type: "string" },
                            OST: { type: "number" },
                            BRANCH: { type: "string" },
                            DOCTYPE: { type: "string" },
                            DOCUMENT: { nullable: true, type: "string" },
                            DOCDATE: { type: "date" },
                            REGISTRYDATE: { nullable: true, type: "date" },
                            KV_SHORT: { type: "string" },
                            DATO: { type: "date" },
                            STATUS: { type: "string" },
                            KK: { type: "string" },
                            OB22: { type: "string" }
                        }
                    }
                }
            },
            dataBound: showActualState
        });
    });
    function showActualState(e) {
        var grid = $('#heriBag').data('kendoGrid');
        grid.tbody.find('>tr').each(function () {
            var dataItem = grid.dataItem(this);
            if (dataItem.ACTUAL_STATE == 1) {
                $(this).addClass('actual');
            }
            if (dataItem.STATE_ID === 3) {
                $(this).addClass('close-depo');
            } else if (dataItem.STATE_ID === 91 || dataItem.STATE_ID === 92 || dataItem.STATE_ID === 99) {
                $(this).addClass('canceled-depo');
            }
        });
    };

    $("#doctype").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "PASSP",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/crkr/dropdown/clientpassp")
                }
            }
        }
    });

    var actualDepo = function (depositId, userRnk) {
        var model = {
            userid: userRnk,
            compenid: depositId,
            opercode: "ACT_DEP"
        }
        $.ajax({
            url: bars.config.urlContent("/api/crkr/depo/actualcompen"),
            type: "POST",
            data: model,
            success: function (result) {
                var flag = result.includes("ORA");
                if (flag) {
                    showError(result);
                } else {
                    window.location = "/barsroot/crkr/clientprofile/index?rnk=" + userRnk;
                }
            }
        });
    };

    var goToCompen = function () {
        var burial = bars.extension.getParamFromUrl("burial", window.location.toString()) === "true" ? "&burial=true" : "";
        var funeral = bars.extension.getParamFromUrl("funeral", window.location.toString()) === "true" ? "&funeral=true" : "";
        var control = bars.extension.getParamFromUrl("control", window.location.toString());
        var userRnk = bars.extension.getParamFromUrl('rnk', window.location.toString());//якщо зайшли через вкладу актуалізація
        var grid = $("#heriBag").data("kendoGrid");
        var row = grid.dataItem(grid.select());
        if (userRnk === null) {
            //window.location = "/barsroot/Crkr/DepositProfile/DepositInventory?depoid=" + row.ID + burial + funeral + "&tanya=123" + "&flag=1&control=" + control + (back === "true" ? "&back=true" : "");

            var wind = $("<div id='firstWindow' />").appendTo(document.body).kendoWindow({
                draggable: true, resizable: true, width: "95%",
                height: "95%",
                scrollable: false,
                draggable: false, //запрет на перетаскивание
                resizable: false,
                //content: "http://demos.kendoui.com/dataviz/api/index.html", modal: false, actions: ["Pin", "Minimize", "Maximize", "Close"]
                content: "/barsroot/Crkr/DepositProfile/DepositInventory?depoid=" + row.ID + burial + funeral + "&flag=1&control=" + control + (back === "true" ? "&back=true" : ""),
                iframe: true,
                modal: true, actions: ["Close"],
            });
            var dialog = wind.data("kendoWindow");

            //wind.parent().find('.k-window-titlebar,.k-window-actions').css('backgroundColor', '#fe2712');
            //wind.parent().find('.k-window-titlebar,.k-window-actions').css('backgroundColor', 'blue');

            //dialog.title("АНКЕТА ВКЛАДА");
            dialog.center().open();


        } else {
            actualDepo(row.ID, userRnk);
        }
    };
    $("#heriBag").on("dblclick", "tbody > tr", goToCompen);
    //bocouse ie8
    if (!String.prototype.includes) {
        // ReSharper disable once NativeTypePrototypeExtending
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }
});

function convert(cell) {
    if (cell == null || cell.value == null) { return cell; }

    if (!isNaN(cell.value) && typeof(cell.value) === "number")
    {
        cell.value = cell.value / 100;
        cell.format = '#,##0.00';
    }

    if (isNaN(cell.value) && cell.value.indexOf("Date") != -1) {
        cell.value = kendo.toString(kendo.parseDate(cell.value), 'dd.MM.yyyy');
    }
    return cell;
};