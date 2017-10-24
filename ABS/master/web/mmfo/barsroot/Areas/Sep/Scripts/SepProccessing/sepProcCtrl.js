function goBack() {
    window.location = bars.config.urlContent('/sep/septechaccounts/Index?isBack=true');
};

function reloadGrid() {
    var datepicker = $("#datepicker").data("kendoDatePicker");
    datepicker.trigger("change");
};

var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }

function exportExcel(btn) {
    debugger
    var model = buildExportExcelModel();
    var grid = $("#Grid").data("kendoGrid");
    var filters = grid.dataSource.filter();
    var sort = grid.dataSource.sort();
    var gridColumns = grid.options.columns;
    var resColumns = [];
    gridColumns.forEach(function (column) {
        resColumns.push({
            name: column.field,
            title: column.title
        }
            )


    })
    var mainModel = {
        sort: sort == undefined ? '' : sort,
        filters: filters == undefined ? '' : filters,
        columns: resColumns,
        page: grid.dataSource.page(),
        pageSize: grid.dataSource._total,
    };

    //var url = "/sep/SepProccessing/GetExcel?" + 'filters=' + model.filters + '&sort=' + model.sort + '&page=' + model.page + '&pageSize=' + model.pageSize + '&acc=' + model.acc + '&tip=' +
    //    model.tip + '&kv=' + model.kv + '&dat=' + model.dat + '&query=' + model.query;
    var url = "/sep/SepProccessing/GetExcel?" + 'model=' + JSON.stringify(mainModel) + '&acc=' + model.acc + '&tip=' +
        model.tip + '&kv=' + model.kv + '&dat=' + model.dat + '&query=' + model.query;
    window.open(bars.config.urlContent(url));

};

function buildExportExcelModel() {
    var data = accInfoData();
    debugger;
    //var dsParams = {
    //    acc: data.acc === undefined ? '' : data.acc,
    //    tip: data.tip === undefined ? '' : data.tip,
    //    kv: data.kv === undefined ? '' : data.kv,
    //    dat: data.DAPP,
    //    srtQuery: getMetaFilterString()
    //};
    var grid = $("#Grid").data("kendoGrid");
    var filters = grid.dataSource.filter();
    var sort = grid.dataSource.sort();

    var exportExcelModel = {
        sort: sort == undefined ? '' : JSON.stringify(sort),
        filters: filters == undefined ? '' : JSON.stringify(filters),
        page: grid.dataSource.page(),
        pageSize: grid.dataSource._total,
        acc: dsParams.acc,
        tip: dsParams.tip,
        kv: dsParams.kv,
        dat: dsParams.dat,
        query: getMetaFilterString()
    };
    return exportExcelModel;

};
function initAccInfoTemplate() {

    var emptyData = {
        acc: 0,
        kv: '',
        nls: '',
        nms: '',
        ost1: '',
        dos: '',
        kos: '',
        ost: ''
    };
    $("#accInfo").html(template(emptyData));
    $("#accSumm").html(templateSumm({}));
};

function getMetaFilterString() {

    var filterStr = window.metadataFiltersQuery === undefined ? '' : window.metadataFiltersQuery;
    return filterStr;
};

function setMetaFilterString(filterString) {
    window.metadataFiltersQuery = filterString == undefined ? '' : Base64.encode(filterString);
    return window.metadataFiltersQuery;
};

// Раскраска и преобразование данных в формат отображения счетов
function CellPaint(data) {
    if (data == 0) {
        return moneyFormat(data);
    }
    else {
        if (data < 0) {
            return "<font color=\"red\">" + moneyFormat(Math.abs(data)) + "</font>";

        }
        else if (data > 0) {
            return "<font color=\"blue\">" + moneyFormat(data) + "</font>";
        }
    }
}

// Преобразование в формать отображения денег
function moneyFormat(money) {
    return kendo.toString(money, '###,##0.00').replace(new RegExp(",", 'g'), ' ');
}


$(document).ready(function () {

    $("#Toolbar").kendoToolBar({
        items: [
            {
                template: '<div id="accInfo" style="margin-top:3px;margin-bottom:3px;"></div>'
            }, {
                template: '<div id="accSumm" style="margin-top:3px;margin-bottom:3px;"></div>'
            }, {
                template: "<button id='pbGoBack' type='button' class='k-button' onclick='goBack()' title='Повернутись до переліку технологічних рахунків'><i class='pf-icon pf-16 pf-arrow_left'></i> Назад</button>"
            }, {
                type: 'separator'
            }, {
                template: "<button type='button' id='btn_ReloadGrid' onclick='reloadGrid()' class='k-button' title='Перечитати дані'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>"
            }, {
                type: "separator"
            }, {
                template: "<button id='pbFilter' type='button' class='k-button' title='Складний фільтр'><i class='pf-icon pf-16 pf-filter-ok'></i></button>"
            }, {
                template: "<button id='pbRefresh' type='button' class='k-button' title='Оновити грід'><i class='pf-icon pf-16 pf-filter-remove'></i></button>"
            }, {
                type: 'separator'
            }, {
                template: '<div><input type="text" id="datepicker" name="dat" title="На дату"></div>'
            }
        ]
    });


    var data = accInfoData();

    dsParams = {
        acc: data.acc,
        tip: data.tip,
        kv: null,
        dat: null,
        srtQuery: ''
    };

    initAccInfoTemplate();

    $("#accInfo").parent().css("display", "block");
    $("#accSumm").parent().css("display", "block");

    $("#pbFilter").kendoButton({
        click: function () {
            bars.ui.getFiltersByMetaTable(function (response, success) {
                if (!success)
                    return false;

                var grid = $("#Grid").data("kendoGrid");
                if (response.length > 0)
                    dsParams.srtQuery = response.join(' and ');
                else
                    dsParams.srtQuery = '';
                dsParams.srtQuery = setMetaFilterString(dsParams.srtQuery);
                grid.dataSource.read({
                    acc: dsParams.acc,
                    tip: dsParams.tip,
                    kv: dsParams.kv,
                    dat: dsParams.dat,
                    query: dsParams.srtQuery
                });

            }, { tableName: "V_TECH_ACCOUNTS" });
        }
    });

    $("#pbRefresh").kendoButton({
        click: function () {

            dsParams.srtQuery = '';
            //.transport.options.read.url
            // var qeuryStr = getMetaFilterString();
            $("#Grid").data("kendoGrid").dataSource.read({
                acc: dsParams.acc,
                tip: dsParams.tip,
                kv: dsParams.kv,
                dat: dsParams.dat,
                query: dsParams.srtQuery
            });
        }
    });

    $("#datepicker").kendoDatePicker({
        format: "dd/MM/yyyy",
        value: data.DAPP ? kendo.parseDate(data.DAPP, "dd/MM/yyyy") : new Date(),
        change: function () {
            dsParams.dat = kendo.toString(this.value(), 'dd/MM/yyyy');
            $.get(bars.config.urlContent('/sep/SepProccessing/GetOstByDate'), { acc: data.acc, dat: dsParams.dat }).done(function (data) {
                if (data.Status === 1) {
                    dsParams.kv = data.DataResult.kv;

                    // update grid ds
                    $("#Grid").data("kendoGrid").dataSource.read({
                        acc: dsParams.acc,
                        tip: dsParams.tip,
                        kv: dsParams.kv,
                        dat: dsParams.dat,
                        query: dsParams.srtQuery
                    });
                    data.DataResult.ost = data.DataResult.kos ? kendo.toString(data.DataResult.ost, '###,##0.00').replace(new RegExp(',', 'g'), ' ') : '0.00';
                    data.DataResult.ost1 = data.DataResult.kos ? kendo.toString(data.DataResult.ost1, '###,##0.00').replace(new RegExp(',', 'g'), ' ') : '0.00';
                    data.DataResult.kos = data.DataResult.kos ? kendo.toString(data.DataResult.kos, '###,##0.00').replace(new RegExp(',', 'g'), ' ') : '0.00';
                    data.DataResult.dos = data.DataResult.dos ? kendo.toString(data.DataResult.dos, '###,##0.00').replace(new RegExp(',', 'g'), ' ') : '0.00';
                    $("#accInfo").html(template(data.DataResult));

                } else {

                    $("#Grid").data("kendoGrid").dataSource.read({
                        acc: dsParams.acc,
                        tip: dsParams.tip,
                        kv: dsParams.kv,
                        dat: dsParams.dat,
                        query: dsParams.srtQuery
                    });
                }
            });
        }
    });

    var datepicker = $("#datepicker").data("kendoDatePicker");
    datepicker.trigger("change");

    $("#Grid").kendoGrid({
        autoBind: false,
        selectable: "multiple",
        filterable: true,
        sortable: true,
        resizable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5,
            pageSizes: [10, 20, 50, 100]
        },
        toolbar: [{ template: "<button id='excelBtnId' type='button' class='k-button' onclick='exportExcel()' title='Друк'><i class='k-icon k-i-excel'></i> Друк</button>" }],
        dataBound: function (e) {
            var data = this.dataSource.data();
            if (data.length > 0) {
                $("#sumDeb").val(data[0].SUBDEB ? kendo.toString(data[0].SUBDEB, '###,##0.00').replace(new RegExp(",", 'g'), ' ') : "0.00");
                $("#sumCred").val(data[0].SUMCRED ? kendo.toString(data[0].SUMCRED, '###,##0.00').replace(new RegExp(",", 'g'), ' ') : "0.00");
            }
            $(data).each(function () {
                if (this.FN_A) {
                    if (this.FN_A.substr(1, 1) === 'B' || this.FN_A.substr(1, 1) === 'V' || this.FN_A.substr(1, 1) === 'C') {
                        this.set('JM', 'Ж');
                    } else {
                        this.set('JM', 'M');
                    }
                } else if (this.FN_B) {
                    this.set('JM', this.FN_B.substr(1, 1) === 'A' ? 'Ж' : 'M');
                }
            });
        },
        columns: [
            //{
            //    field: "JM",
            //    title: "Ж/М",
            //    width: 50
            //    /*
            //        If Subs(FN_A,2,1)='B' or Subs(FN_B,2,1)='A' or Subs(FN_A,2,1)='V' or Subs(FN_A,2,1)='C'
	        //            Set JM='Ж'
            //    */
            //},
            {
                field: "ND",
                title: "Номер документа",
                width: 100
                //,filterable: {
                //    cell: {
                //        operator: "contains"
                //    }
                //}
            }, {
                field: "REC",
                title: "REC",
                width: 100
            }, {
                field: "REF",
                title: "Реф.",
                width: 100
            }, {
                field: "MFOA",
                title: "МФО-А",
                width: 100
            }, {
                field: "MFOB",
                title: "МФО-Б",
                width: 100
            }, {
                field: "NLS",
                title: "Наш рахунок",
                width: 120
            }, {
                field: "NLSA",
                title: "Рахунок - A",
                width: 120
            }, {
                field: "NLSB",
                title: "Рахунок - Б",
                width: 120
            }, {
                field: "NAM",
                title: "Наш клієнт",
                width: 120
            }, {
                field: "S1",
                title: "Дебет",
                template: "<div style='text-align:right'>#=CellPaint(S1)#</div>",
                width: 150
            }, {
                field: "S0",
                title: "Кредит",
                template: "<div style='text-align:right'>#=CellPaint(S0)#</div>",
                width: 150
            }, {
                field: "PRTY",
                title: "ССП",
                width: 100
            }, {
                field: "NAZN",
                title: "Призначення платежу",
                width: 400
            }, {
                field: "FN_A",
                title: "Ім'я вхідного файлу",
                width: 125
            }, {
                field: "DAT_A",
                title: "Дата отримання (DAT_A)",
                template: "<div>#= DAT_A !== null ? kendo.toString(kendo.parseDate(DAT_A),'dd/MM/yyyy HH:mm:ss') : '-' #</div>",
                width: 100
            }, {
                field: "FN_B",
                title: "Ім'я вихідного файлу",
                width: 125
            }, {
                field: "DAT_B",
                title: "Дата виходу (DAT_B)",
                template: "<div>#= DAT_B !== null ? kendo.toString(kendo.parseDate(DAT_B),'dd/MM/yyyy HH:mm:ss') : '-' #</div>",
                width: 100
            }, {
                field: "SOS",
                title: "",
                hidden: true
            }, {
                field: "REC",
                title: "",
                hidden: true
            }, {
                field: "DIK",
                title: "",
                hidden: true
            }, {
                field: "DK",
                title: "",
                hidden: true
            }
        ],
        dataSource: {
            type: 'aspnetmvc-ajax',
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            pageSize: 10,
            transport: {
                read: {
                    dataType: 'json',
                    url: bars.config.urlContent('/sep/SepProccessing/Data'),
                    data: function () {
                        return {
                            acc: dsParams.acc,
                            tip: dsParams.tip,
                            kv: dsParams.kv,
                            dat: dsParams.dat,
                            query: getMetaFilterString()
                        };
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
                errors: function (response) {
                    if (response.Errors === "undefined")
                        bars.ui.alert({ title: "Error", text: response.Errors.message });
                },
                model: {
                    fields: {
                        JM: { type: "string" },
                        ND: { type: "string" },
                        REC: { type: "string" },
                        REF: { type: "string" },
                        MFOA: { type: "string" },
                        MFOB: { type: "string" },
                        NLS: { type: "string" },
                        NLSA: { type: "string" },
                        NLSB: { type: "string" },
                        NAM: { type: "string" },
                        SKR: { type: "number" },
                        SDE: { type: "number" },
                        PRTY: { type: "number" },
                        NAZN: { type: "string" },
                        FN_A: { type: "string" },
                        DAT_A: { type: "date" },
                        TIMA: { type: "date" },
                        FN_B: { type: "string" },
                        DAT_B: { type: "date" },
                        TIMB: { type: "date" },
                        SOS: { type: "number" },
                        REC: { type: "number" },
                        DIK: { type: "number" },
                        DK: { type: "number" },
                        SUMDEB: { type: "number" },
                        SUMCRED: { type: "number" }
                    }
                }
            }
        }
    });

    function openGrid() {
        var grid = $("#Grid").data("kendoGrid");
        var item = grid.dataItem(grid.select());
        if (item != null) {
              debugger;
              $.get(bars.config.urlContent('/sep/sep3720/getrefbyrec'), { recId: item.REC }).done(function (result) {
                  if (result.data == null && item.REF != "")
                  {
                      var docUrl = bars.config.urlContent("/documents/item/" + item.REF + "/");
                      window.showModalDialog(docUrl, null, 'dialogWidth:790px;dialogHeight:550px');
                  } else {
                      if (result.data.REF !== 0) {
                          var docUrl = bars.config.urlContent("/documents/item/" + result.data.REF + "/");
                          window.showModalDialog(docUrl, null, 'dialogWidth:790px;dialogHeight:550px');
                      } else {
                          var sepDocViewer = bars.sepfiles.sepDocViewer;
                          sepDocViewer.loadFirstTab(result.data);
                          sepDocViewer.loadSecondTab.part1(result.data);
                          sepDocViewer.loadSecondTab.part2(result.data);
                          sepDocViewer.show();
                      } 
                  }                
             });
        }
    }


    $('#Grid').on('dblclick', ' tbody > tr', function () {
        openGrid();
    });

    insertRowSelectionTooltip();

});