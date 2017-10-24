///*** GLOBALS
var PAGE_INITIAL_COUNT = 30;
var session = {};
///***

function updateMainGrid() {
    var grid = $("#_gridMain").data("kendoGrid");
    if (grid) {
        grid.dataSource.read();
        grid.refresh();
        //grid.dataSource.fetch();
        //grid.refresh();
    }
}

function getHeadersDateFromString(strVal) {
    var dateResult = new Date();
    if (strVal != null && strVal != undefined) {

        var dateNum = strVal.split('(')[1].split(')')[0];
        var dateNumClear = dateNum.split('+')[0];

        dateResult = new Date(+dateNumClear);
    }
    var year = dateResult.getFullYear();
    var month = dateResult.getMonth() + 1;
    month = month > 9 ? month : '0' + month;
    var day = dateResult.getDate();
    day = day > 9 ? day : '0' + day;

    return day + "/" + month + "/" + year;
};

function initHeaders(item) {

    $("#tbNazn").val(session.nazn != null ? session.nazn : "");

    $("#diDatD").val(item.DATD != null ? getHeadersDateFromString(item.DATD) : "");
    $("#diDateFrom").val(item.DATE_FROM != null ? getHeadersDateFromString(item.DATE_FROM) : "");
    $("#diDateTo").val(item.DATE_TO != null ? getHeadersDateFromString(item.DATE_TO) : "");

    var _ref = item.REF != null ? item.REF : "0";
    if (session.isA) {
        setValueToKendoNumeric("tbRef", _ref);
        $("#tbKvA").val(item.KV_A != null ? item.KV_A : "");
        $("#tbNlsA").val(item.NLS_A != null ? item.NLS_A : "");
        setValueToKendoNumeric("tbOstC", item.OSTC != null ? item.OSTC : "0.0");
        $("#tbNlsAName").val(item.NMS != null ? item.NMS : "");
    }
    if (_ref != "0") {
        $("#tbTotalSum, #tbKvA, #tbNd, #tbNazn, #diDatD, #diDateFrom, #diDateTo, #cbDatesToNazn").attr('disabled', 'disabled');

        $("#btOpenDocument").removeAttr("disabled");
    }


    setValueToKendoNumeric("tbTypedPercents", item.TYPED_PERCENT != null ? item.TYPED_PERCENT : "0.0");
    setValueToKendoNumeric("tbTypedSum", item.TYPED_SUMM != null ? item.TYPED_SUMM : "0.0");

    var rGroupVal = 0;
    var cbInfoState = false;

    if (item.DK == 0) {
        rGroupVal = "0";
        cbInfoState = false;
    }
    else if (item.DK == 1) {
        rGroupVal = "1";
        cbInfoState = false;
    }
    else if (item.DK == 2) {
        rGroupVal = "0";
        cbInfoState = true;
    }
    else if (item.DK == 3) {
        rGroupVal = "1";
        cbInfoState = true;
    }

    var radioName;
    if (rGroupVal == "1") {
        radioName = "dk1_rb";
    } else {
        radioName = "dk2_rb";
    }

    radiobtn = document.getElementById(radioName);
    radiobtn.checked = true;

    $("#cbInfo").attr("checked", cbInfoState)
};

function SearchAndUpdateHeaders() {

    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/SearchTmpDynamicLayout"),
        success: function (data) {
            bars.ui.loader('body', false);
            for (var i = 0; i < data.length; i++) {
                initHeaders(data[i]);
            }
        }
    });
};

function initMainGrid() {

    SearchAndUpdateHeaders();

    var dataSourceObj = {
        type: "aspnetmvc-ajax",
        //sort: [ { field: "ID", dir: "desc" } ],
        transport: {
            read: {
                type: "GET",
                dataType: "json",
                url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/SearchStaticLayoutData")
            }
        },
        requestStart: function (e) {
        },
        requestEnd: function (e) {
            bars.ui.loader('body', false);
        },
        pageSize: PAGE_INITIAL_COUNT,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    ID: { type: 'number' },
                    ND: { type: 'string' },
                    KV: { type: 'string' },
                    BRANCH: { type: 'string' },
                    BRANCH_NAME: { type: 'string' },
                    NLS_A: { type: 'string' },
                    NLS_B: { type: 'string' },
                    NAMA: { type: 'string' },
                    OKPOA: { type: 'string' },
                    MFOB: { type: 'string' },
                    MFOB_NAME: { type: 'string' },
                    NAMB: { type: 'string' },
                    OKPOB: { type: 'string' },
                    PERCENT: { type: 'number' },
                    SUMM_A: { type: 'number' },
                    SUMM_B: { type: 'number' },
                    DELTA: { type: 'number' },
                    TT: { type: 'string' },
                    VOB: { type: 'number' },
                    NAZN: { type: 'string' },
                    REF: { type: 'string' },
                    NLS_COUNT: { type: 'number' },
                    ORD: { type: 'number' },
                    USERID: { type: 'number' }
                }
            }
        },
        sort: ([
            { field: "PERCENT", dir: "desc" },
            { field: "DELTA", dir: "desc" },
            { field: "SUMM_A", dir: "desc" }
        ])
    };

    var mainGridDataSource = new kendo.data.DataSource(dataSourceObj);

    var mainGridOptions = {
        dataSource: mainGridDataSource,
        pageable: {
            refresh: true,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [PAGE_INITIAL_COUNT, 50, 100, 200, 1000, "All"],
            buttonCount: 5
        },
        filterable: true,
        reorderable: false,
        toolbar: [
            {
                template: '<div class="btn-group">'
                            + '<a class="btn btn-primary k-grid-excel"><span><img src="/common/images/default/16/export_excel.png"/></span>  Вивантажити в Exel</a>'
                            + '<a class="btn btn-primary k-grid-custom-add"><span><img src="/common/images/default/16/new.png"/></span>  Додати</a>'
                            + '<a class="btn btn-primary k-grid-custom-edit"><span><img src="/common/images/default/16/edit.png"/></span>  Редагувати</a>'
                            + '<a class="btn btn-primary k-grid-custom-delete"><span><img src="/common/images/default/16/delete.png"/></span>  Видалити</a>'
                        + '</div>'
            }
        ],
        excel: {
            fileName: "table.xlsx",
            allPages: true,
            proxyURL: bars.config.urlContent('/dynamicLayout/dynamicLayout/ConvertBase64ToFile/')
        },
        columns: [
            { field: "KV", title: "Код вал", width: "80px" },
            { field: "NLS_A", title: "Рах А у нас", width: "100px", hidden: session.isA },
            { field: "BRANCH_NAME", title: "Рах А залишок", width: "100px", hidden: session.isA, format: "{0:n2}" },
            { field: "NAMA", title: "Назва відправника", hidden: session.isA },
            { field: "MFOB", title: "Код МФО-Б", width: "100px" },
            { field: "MFOB_NAME", title: "Назава МФО-Б", width: "200px" },
            { field: "NLS_B", title: "Рах.Б в МФО-Б" },
            { field: "NAMB", title: "Назва отримувача" },
            { field: "OKPOB", title: "Ід Код-Б", width: "90px" },
            { field: "PERCENT", title: "% від заг. суми", width: "100px" },
            { field: "DELTA", title: "+ або - Константа", width: "100px", format: "{0:n2}" },
            { field: "SUMM_A", title: "Сума проводки", width: "110px", format: "{0:n2}" },
            { field: "REF", title: "РЕФ", width: "100px" },
            { field: "NAZN", title: "Призначення", width: "350px" },
            { field: "TT", title: "Код оп", width: "75px" },
            { field: "NLS_COUNT", title: "№ грп", width: "75px" },
            { field: "ORD", title: "№ ПП", width: "75px" },
            { field: "VOB", title: "Вид док", width: "75px" }
        ],
        selectable: "row",
        dataBound: function () {
            if (session.isA) return;

            var a = $("#_gridMain").find("tr");
            $("#_gridMain").find("tr").each(function () {
                var mainGrid = $("#_gridMain").data("kendoGrid");
                if (mainGrid.dataItem($(this)).BRANCH_NAME == 0) {
                    mainGrid.dataItem($(this)).BRANCH_NAME = 0.00;
                }
                if (mainGrid.dataItem($(this)).BRANCH_NAME != 0.00) {
                    $(this).addClass('coloredRow');
                }
            });
        },
        change: onChange,
        sortable: {
            mode: "multiple",
            allowUnsort: true
        },
        navigatable: true
    };

    $("#_gridMain").kendoGrid(mainGridOptions);

    $(".k-grid-custom-add").click(function () {
        editForm({});
    });

    $(".k-grid-custom-edit").click(function () {
        var grid = $("#_gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null) {
            bars.ui.alert({ text: "Необхідно обрати рядок для редагування." });
            return;
        }

        editForm(selectedItem);
    });

    $(".k-grid-custom-delete").click(function () {
        var grid = $("#_gridMain").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem == null) {
            bars.ui.alert({ text: "Нічого не вибрано = Нічого не видалено." });
            return;
        }

        bars.ui.confirm(
          { text: 'Точно видалити ?' },
           function () {
               deleteRow(selectedItem);
           });
    });

    //$($("#_gridMain").data("kendoGrid").tbody).on("dblclick", "tr", openEditFormWithRowDblClick);
    $("#_gridMain").on("dblclick", "tr", openEditFormWithRowDblClick);

    changeGridMaxHeight();
    addDblClickEventToCell();
}

function onChange(arg) {
    var data = this.dataItem(this.select());
    var summ = data.SUMM_A;
    var ref = data.REF;

    if (summ > 0) {
        $("#btPaySelected").removeAttr('disabled');
    } else {
        $("#btPaySelected").attr('disabled', 'disabled');
    }

    if (ref != undefined && ref != null) {
        $("#btOpenDocument").removeAttr('disabled');
        $("#btPaySelected").attr('disabled', 'disabled');
    } else {
        $("#btOpenDocument").attr('disabled', 'disabled');
    }
}

function changeGridMaxHeight() {
    var a1 = $(".k-grid-content").height();
    var a2 = $(".k-grid-content").offset();
    var a3 = $(document).height();
    var a4 = a3 - a2.top;

    $(".k-grid-content").css("max-height", a4 * 0.9);
};

function openEditFormWithRowDblClick() {
    var mainGrid = $("#_gridMain").data("kendoGrid");
    var row = $(this).closest("tr");
    var dataItem = mainGrid.dataItem(row);

    editForm(dataItem);
};

function editForm(dataItem) {
    var isNew = false;
    if (dataItem.ID === undefined || dataItem.ID == null || dataItem.ID == 0) isNew = true;
    dataItem.saveBtnText = isNew ? "Зберегти" : "Оновити";
    dataItem.isA = session.isA;

    var kendoWindow = $("<div />").kendoWindow({
        actions: ["Close"],
        title: isNew ? "Додавання" : "Редагування",
        resizable: false,
        modal: true,
        draggable: true,
        animation: {
            close: {
                effects: "fade:out",
                duration: 300
            },
            open: {
                effects: "fade:in",
                duration: 300
            }
        },
        deactivate: function () {
            $("#btPaySelected").attr('disabled', 'disabled');
            this.destroy();
        },
        activate: function () {
            //alert("12");
            if (session.isA)
                $("#mfob_editor").focus();
            else {

                var selectFilter = $("#kv_editor").data("kendoDropDownList");
                selectFilter.focus();
            }
            //$("#kv_editor").data
            //$("#kv_editor").focus();
        }
    });

    var template = kendo.template($("#popup_editor").html());

    kendoWindow.data("kendoWindow").content(template(dataItem)).center().open();

    kendoWindow
        .find("#btnCancel")
            .click(function () {
                kendoWindow.data("kendoWindow").close();
            })
            .end();

    kendoWindow
            .find("#btnSave")
                .click(function () {
                    var v = checkEditForm()
                    if (!v.result) {
                        bars.ui.error({ text: v.errorMessage });
                        return;
                    } else {
                        bars.ui.loader('body', true);

                        $.ajax({
                            type: "POST",
                            url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/SaveDetails"),
                            data: postDataForEditor(dataItem),
                            success: function (data) {
                                bars.ui.loader('body', false);
                                if (data.Result != "OK") {
                                    showBarsErrorAlert(data.ErrorMsg);
                                } else {
                                    //bars.ui.alert({ text: "Дані успішно збережено !" });
                                    SearchAndUpdateHeaders();
                                    kendoWindow.data("kendoWindow").close();
                                }
                                updateMainGrid();
                            }
                        });
                    }
                }).end();

    kendoWindow.find("#btnSave").keypress(function (e) {
        if (e.which == 13) {
            this.click();
        }
    });

    kendoWindow
           .find("#btnClearSums")
               .click(function () {
                   setValueToKendoNumeric("percent_editor", "0.00");
                   setValueToKendoNumeric("delta_editor", "0.00");
                   setValueToKendoNumeric("summ_a_editor", "0.00");
               }).end();

    kendoWindow.find("#vob_editor, #ord_editor").kendoNumericTextBox(getNumericOptions({ decimals: 0, format: "n0" }));

    kendoWindow.find("#percent_editor").kendoNumericTextBox(getNumericOptions({ max: 100 }));

    kendoWindow.find("#summ_a_editor").kendoNumericTextBox(getNumericOptions());

    var opt = getNumericOptions();
    delete opt["min"];
    kendoWindow.find("#delta_editor").kendoNumericTextBox(opt);

    if (!session.isA) {
        $("#kv_editor").kendoDropDownList({
            dataValueField: "KV",
            dataTextField: "KV",
            template: '<b>${data.KV}</b> - ${data.NAME}',
            dataSource: {
                type: "json",
                transport: {
                    read: {
                        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/KvAC"),
                        dataType: "json"
                    }
                }
            }
        });
    }
};

function getNumericOptions(options) {
    if (options === undefined || options == null) options = {};
    options = $.extend(
        {
            min: 0,
            spinners: false,
            decimals: 2,
            restrictDecimals: true,
            format: "n2",
            change: kendoNumericChange
        },
        options
    );
    return options;
};

function kendoNumericChange() {
    var value = this.value();
    if (value == null || $.trim(value) == "")
        this.value(0);
};

function checkValForEdit(val, defValue) {
    if (val === undefined || val == null || val == "") return defValue;
    return $.trim(val);
};

function postDataForEditor(dataItem) {
    var postData = {};
    postData.UdlModel = UpdateDynamicLayoutDataModel();

    var dk;
    var rbListDkValue = $('input[name="dkRb"]:checked').val();


    if (!$("#cbInfo").checked) {
        dk = rbListDkValue == 1 ? 1 : 0;
    } else {
        dk = rbListDkValue == 1 ? 3 : 2;
    }

    var _pnd = $("#tbNd").val();

    var _nazn = $("#nazn_editor").val();
    if (_nazn === undefined || _nazn == null || _nazn == "")
        _nazn = $("#tbNazn").val();

    var _pKv, _pNlsa;
    if (session.isA) {
        _pKv = $("#tbKvA").val();
        _pNlsa = $("#tbNlsA").val();
    } else {
        _pKv = checkValForEdit($("#kv_editor").val(), 980);
        _pNlsa = $("#nls_a_editor").val();
    }

    var tmpAslModel = {
        pId: dataItem.ID === undefined ? 0 : dataItem.ID,
        pDk: dk,
        pNd: _pnd === undefined ? "" : _pnd,
        pKv: _pKv,
        pNlsa: _pNlsa,
        pNamA: null,
        pOkpoA: null,
        pMfoB: $("#mfob_editor").val(),
        pNlsB: $("#nls_b_editor").val(),
        pNamB: $("#namb_editor").val(),
        pOkpoB: $("#okpob_editor").val(),
        pPercent: $("#percent_editor").val(),
        pSumA: $("#summ_a_editor").val(),
        pSumB: $("#summ_a_editor").val(),
        pDelta: $("#delta_editor").val(),
        pTt: $("#tt_editor").val(),
        pVob: $("#vob_editor").val(),
        pNazn: _nazn,
        pOrd: $("#ord_editor").val()
    };
    postData.AslModel = tmpAslModel;

    return postData;
}

function checkEditForm() {
    var returnRes = {
        errorMessage: "Не усі обов'язкові поля заповнено !<br/>Необхідно ввести наступні дані:<br/>",
        result: true
    }

    var nls_b = $("#nls_b_editor").val();
    if (nls_b === undefined || nls_b == null || nls_b == "") {
        returnRes.errorMessage += "<b>Рах.Б в МФО-Б</b><br/>";
        returnRes.result = false;
    }

    var namb = $("#namb_editor").val();
    if (namb === undefined || namb == null || namb == "") {
        returnRes.errorMessage += "<b>Назва отримувача</b><br/>";
        returnRes.result = false;
    }

    var okpob = $("#okpob_editor").val();
    if (okpob === undefined || okpob == null || okpob == "") {
        returnRes.errorMessage += "<b>Ід Код-Б</b><br/>";
        returnRes.result = false;
    }

    var percent = $("#percent_editor").val();
    var summ_a = $("#summ_a_editor").val();
    if (percent != 0 && summ_a != 0) {
        returnRes.errorMessage += "або <b>% від суми</b> або <b>Сума проводки</b> (одне поле на вибір)<br/>";
        returnRes.result = false;
    }

    var nls_a = $("#nls_a_editor").val();
    if (nls_a === undefined || nls_a == null || nls_a == "") {
        if (!session.isA) {
            returnRes.errorMessage += "<b>№ рахунку А</b><br/>";
            returnRes.result = false;
        }
    }

    return returnRes;
};

function deleteRow(selectedItem) {
    var postData = {
        pGrp: selectedItem.NLS_COUNT,
        pId: selectedItem.ID
    };

    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/DeleteStaticLayout"),
        data: postData,
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg, goToIndex);
            } else {
                SearchAndUpdateHeaders();
                updateMainGrid();
                bars.ui.alert({ text: "Запис успішно видалено." });
            }
        }
    });
};

function initLayout(urlParams) {
    bars.ui.loader('body', true);
    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/GetStaticLayout"),
        data: urlParams,
        success: function (data) {
            if (data.Result != "OK") {
                bars.ui.loader('body', false);
                showBarsErrorAlert(data.ErrorMsg, goToIndex);
            } else {
                initMainGrid();
            }
        }
    });
};

function showBarsErrorAlert(message, func) {
    if (func == undefined) func = function () { };
    bars.ui.error({ text: message.replace("ы", "і"), deactivate: func });
};

function getUrlParameter(param) {
    var PageURL = window.location.search.substring(1);
    var URLVariables = PageURL.split('&');
    for (var i = 0; i < URLVariables.length; i++) {
        var ParameterName = URLVariables[i].split('=');
        if (ParameterName[0].toUpperCase() == param.toUpperCase()) {
            return ParameterName[1];
        }
    }
};

function goToIndex() {
    window.location.href = 'index?filter=' + session.indexParam;
};

function initElements() {
    var kendoNumericOptions = {
        spinners: false,
        value: 0,
        decimals: 2,
        restrictDecimals: true
    };

    $("#btNew").click(function () {
        goToIndex();
    });

    $("#tbTotalSum").kendoNumericTextBox(getNumericOptions());
    setValueToKendoNumeric("tbTotalSum", "0.00");

    $("#tbRef").kendoNumericTextBox(getNumericOptions({ decimals: 0, format: "n0" }));

    $("#tbTypedPercents").kendoNumericTextBox(getNumericOptions());
    $("#tbTypedSum").kendoNumericTextBox(getNumericOptions());

    $("#tbOstC").kendoNumericTextBox(getNumericOptions());

    $("#diDatD").kendoDatePicker({
        min: new Date(2016, 0, 1),
        format: "dd/MM/yyyy"
    });
    $("#diDateFrom, #diDateTo").kendoDatePicker({
        format: "dd/MM/yyyy"
    });

    $("#diDatD, #diDateFrom, #diDateTo").change(function () {
        var v = kendo.parseDate($(this).val(), "dd/MM/yyyy");
        if (v instanceof Date) { return true; }
        else {
            bars.ui.error({ text: "Не коректно введено дату!" });
            var dd = new Date();

            $(this).val(kendo.toString(dd, "dd/MM/yyyy"));
        }
    });

    $("#btCalc").click(calculate);
    $("#btPay").click(pay);
    $("#btPaySelected").click(paySelected);
    $("#btOpenDocument").click(OpenDocument);

    $("#percent_editor, #delta_editor, #summ_a_editor").kendoNumericTextBox(kendoNumericOptions);
    $("#ord_editor, #vob_editor").kendoNumericTextBox({
        spinners: false,
        value: 0,
        decimals: 0,
        restrictDecimals: true
    });
};

function addDblClickEventToCell() {
    //$("#_gridMain").data("kendoGrid").tbody
    $("#_gridMain").on("dblclick", "td:nth-child(13)", function (event) {

        var mainGrid = $("#_gridMain").data("kendoGrid");
        var row = $(this).closest("tr");
        var dataItem = mainGrid.dataItem(row);

        var tmp = dataItem.REF;
        if (tmp != undefined && tmp != null && tmp != "") {
            event.stopPropagation();
            openDoc(tmp);
        }
    });
};

function OpenDocument() {
    var mainGrid = $("#_gridMain").data("kendoGrid");
    var dataItem = mainGrid.dataItem(mainGrid.select());
    if (dataItem === undefined || dataItem == null) return;

    var ref = dataItem.REF;

    openDoc(ref);
};

function openDoc(ref) {
    if (window.showModalDialog)
        window.showModalDialog('/barsroot/documents/item/?id=' + ref, null, 'dialogWidth:720px;dialogHeight:550px');
    else {
        var w = 720;
        var h = 550;

        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);

        var targetWin = window.open('/barsroot/documents/item/?id=' + ref, '', 'modal=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }
    //window.open('/barsroot/documents/item/?id=' + ref, '', 'width=720,height=550');
};

function UpdateDynamicLayoutDataModel() {
    var tSum = $("#tbTotalSum").val();
    var datesToNazn = $("#cbDatesToNazn").checked ? 1 : 0;
    tSum = tSum * 100;

    return {
        pNd: $("#tbNd").val(),
        pDatd: $("#diDatD").val(),
        pDatFrom: $("#diDateFrom").val(),
        pDatTo: $("#diDateTo").val(),
        pDatesToNazn: datesToNazn,
        pNazn: $("#tbNazn").val(),
        pSum: tSum,
        pCorr: 0
    };
};

function calculate(e) {
    var tSum = $("#tbTotalSum").val();
    if (tSum == null || +tSum <= 0) {
        bars.ui.alert({ text: "Необхідно заповнити суму розподілу" });
        return;
    }
    bars.ui.loader('body', true);

    var postData = UpdateDynamicLayoutDataModel();

    $.ajax({
        type: "POST",
        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/UpdateAndCalculateDynamicLayout"),
        data: postData,
        success: function (data) {

            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                $("#btPay").attr('disabled', 'disabled');
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                SearchAndUpdateHeaders();
                updateMainGrid();
                $("#btPay").removeAttr('disabled');
            }
            sortGrid();
        }
    });
};

function sortGrid() {
    //var grid = $("#_gridMain").data("kendoGrid");
    //grid.dataSource.sort([
    //        { field: "PERCENT", dir: "desc" },
    //        { field: "DELTA", dir: "desc" },
    //        { field: "SUMM_A", dir: "desc" },
    //]);
};

function pay() {
    var tSum = +$("#tbTotalSum").val();

    if (tSum <= 0) {
        bars.ui.alert({ text: "Не вказано суму розподілу." });
        return;
    }

    var paydPercents = +$("#tbTypedPercents").val();
    if (paydPercents != 100) {
        bars.ui.alert({ text: "Загальний % не дорівнює 100" });
        return;
    }
    var typedSum = +$("#tbTypedSum").val();
    if (tSum != typedSum) {
        bars.ui.alert({ text: "Набранна сума " + typedSum + " не дорівнює загальній сумі розподілу " + tSum });
        return;
    }

    bars.ui.loader("body", true);
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/PayStaticLayout?pMak=" + 1),
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Result != "OK") {
                showBarsErrorAlert(data.ErrorMsg);
            } else {
                SearchAndUpdateHeaders();
                updateMainGrid();
                $("#btPay").attr('disabled', 'disabled');
                bars.ui.alert({ text: "Успішно сплачено !" });
            }
            sortGrid();
        }
    });
};

function paySelected() {
    var mainGrid = $("#_gridMain").data("kendoGrid");
    var dataItem = mainGrid.dataItem(mainGrid.select());
    if (dataItem != undefined && dataItem != null) {
        var postData = {
            ID: dataItem.ID,
            ND: dataItem.ND,
            KV: dataItem.KV,
            BRANCH: dataItem.BRANCH,
            BRANCH_NAME: dataItem.BRANCH_NAME,
            NLS_A: dataItem.NLS_A,
            NAMA: dataItem.NAMA,
            OKPOA: dataItem.OKPOA,
            MFOB: dataItem.MFOB,
            MFOB_NAME: dataItem.MFOB_NAME,
            NLS_B: dataItem.NLS_B,
            NAMB: dataItem.NAMB,
            OKPOB: dataItem.OKPOB,
            PERCENT: dataItem.PERCENT,
            SUMM_A: dataItem.SUMM_A * 100,
            SUMM_B: dataItem.SUMM_B * 100,
            DELTA: dataItem.DELTA,
            TT: dataItem.TT,
            VOB: dataItem.VOB,
            NAZN: dataItem.NAZN,
            REF: dataItem.REF,
            NLS_COUNT: dataItem.NLS_COUNT,
            ORD: dataItem.ORD,
            USERID: dataItem.USERID,
        }

        bars.ui.loader("body", true);
        $.ajax({
            type: "POST",
            data: postData,
            url: bars.config.urlContent("/api/dynamicLayout/dynamicLayout/PaySelected"),
            success: function (data) {
                bars.ui.loader('body', false);
                if (data.Result != "OK") {
                    showBarsErrorAlert(data.ErrorMsg);
                } else {
                    SearchAndUpdateHeaders();
                    updateMainGrid();
                    $("#btPaySelected").attr('disabled', 'disabled');
                    bars.ui.alert({ text: "Успішно оплачено !" });
                }
            }
        });
    }
};

function setValueToKendoNumeric(elementName, newValue) {
    $("#" + elementName).data("kendoNumericTextBox").value(newValue);
};

$(document).ready(function () {
    $("#title").html("Макети Юридичних Осіб");

    $(document).keyup(function (e) {
        if (e.keyCode == 27) {
            var visibleWindow = $(".k-window:visible > .k-window-content");
            if (visibleWindow.length)
                visibleWindow.data("kendoWindow").close();
        }
    });

    var fromUrl = getUrlParameter("params");
    var decodedFromUrl = decodeURIComponent(fromUrl);

    session = JSON.parse(decodedFromUrl);

    session.isA = session.pMode == 1;

    initElements();
    initLayout(session);
});

