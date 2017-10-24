$(document).ready(function () {

    //$("#mfo").kendoNumericTextBox({
    //    format: "n0"
    //});
    $("#regid").kendoNumericTextBox({
        format: "n0"
    });
    $('#markTopay').prop("disabled", true);
    $('body').on('click', '#markTopay', MarkToPay);
    FillMFODropDown()
    FillStateDropDown()
    kendo.ui.progress($("#gridErrorRows"), false);
    initErrorRowsGrid();
    $("#mfo").change(function () {
        $("#gridErrorRows").data("kendoGrid").dataSource.read();
    });
    $("#state").change(function () {
        $("#gridErrorRows").data("kendoGrid").dataSource.read();
    });
    $("#state").change(function () {
        $("#gridErrorRows").data("kendoGrid").dataSource.read();
    });
    //$('#mfo').on('keyup', function (ev, a) {
    //    $("#gridErrorRows").data("kendoGrid").dataSource.read();
    //})
    $("#regid").change(function () {
        $("#gridErrorRows").data("kendoGrid").dataSource.read();
    });
    if (event.which === 13)
        $("#gridErrorRows").data("kendoGrid").dataSource.read();

    $('textarea').keyup(function (e) {
        if (e.keyCode == 13) {
            $("#gridErrorRows").data("kendoGrid").dataSource.read();
        }
    });
    $("#btnExport").kendoButton({
        click: function () {
            $("#gridErrorRows").data("kendoGrid").saveAsExcel()
        }
    })

})
PrintDate = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd'), 'dd/MM/yyyy')

};

function MarkToPay() {
    grid = $("#gridErrorRows").data("kendoGrid");
    var rows = grid.select();
    for (var i = 0; i < rows.length; i++) {
        selected = grid.dataItem(rows[i]);
        var id = selected.ID;
        $.ajax({
            method: "POST",//or type
            contentType: "application/json",
            async: true,
            url: bars.config.urlContent("/api/pfu/errorrows/MarkToPayment"),
            data: JSON.stringify({ id: id }),
            complete: function () {
                $("#gridErrorRows").data("kendoGrid").dataSource.read();
                $('#markTopay').prop("disabled", true);
            }
        });
    }

}
function FillMFODropDown() {
    fillDropDownList("#mfo",
        {
            transport: { read: { url: bars.config.urlContent("/api/pfu/errorrows/GetMFO") } },
            schema: { model: { fields: { MFO: { type: "string" }, MFO_NAME: { type: "string" } } } }
        },
    {
        dataTextField: "MFO_NAME", dataValueField: "MFO", optionLabel: "Всі",
        filter: "contains"
    });
    //$("#mfo").kendoDropDownList({
    //    dataTextField: "MFO_NAME",
    //    dataValueField: "MFO",
    //    optionLabel: "Оберіть код",
    //    dataSource: {
    //        transport: {
    //            read: {
    //                dataType: "jsonp",
    //                url: bars.config.urlContent("/api/pfu/errorrows/GetMFO")
    //            }
    //    }
    //    }
    //});
    //kf = $('#mfo').data("kendoDropDownList");
    //console.log(kf);
    //debugger;
}
function FillStateDropDown() {
    fillDropDownList("#state",
        {
            transport: { read: { url: bars.config.urlContent("/api/pfu/errorrows/GetStates") } },
            schema: { model: { fields: { STATE: { type: "number" }, STATE_NAME: { type: "string" } } } }
        },
    {
        dataTextField: "STATE_NAME", dataValueField: "STATE", optionLabel: "Всі"
    });
}
PrintMFO = function (mfo, mfo_name) {
    if (mfo != null && mfo_name != null)
        return mfo_name + " " + mfo
    else
        return ""

};
function initErrorRowsGrid() {
    $("#gridErrorRows").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 7,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/errorrows/geterrorrows"),
                    data: function () {
                        var MFO = $('#mfo').data("kendoDropDownList").value();
                        var STATE = $('#state').data("kendoDropDownList").value();
                        var ID = $('#regid').val();
                        debugger;

                        return { MFO: MFO, ID: ID, STATE: STATE };
                    }
                }
            },
            requestStart: function (e) {
                kendo.ui.progress($("#gridErrorRows"), true);
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { type: "number" },
                        FILE_ID: { type: "number" },
                        PFU_ENVELOPE_ID: { type: "number" },
                        MFO: { type: "string" },
                        MFO_NAME: { type: "string" },
                        BRANCH: { type: "string" },
                        KF_BANK: { type: "string" },
                        STATE: { type: "number" },
                        STATE_NAME: { type: "string" },
                        RNK_BANK: { type: "number" },
                        OKPO_BANK: { type: "string" },
                        OKPO_PFU: { type: "string" },
                        NMK_BANK: { type: "string" },
                        NLS_BANK: { type: "string" },
                        NMK_PFU: { type: "string" },
                        NLS_PFU: { type: "string" },
                        ERR_MESS_TRACE: { type: "string" }
                    }
                }
            }
        },
        selectable: "multiple",
        pageable: true,
        filterable: true,

        dataBound: function (e) {
            kendo.ui.progress($("#gridErrorRows"), false);
        },
        change: function () {
            debugger;
            grid = this;
            var hide = true
            var rows = grid.select();
            for (var i = 0; i < rows.length; i++) {
                selected = grid.dataItem(rows[i]);
                if (selected.STATE == 1 || selected.STATE == 2 || selected.STATE == 5)
                    hide = false

            }
            if (!hide)
                $('#markTopay').prop("disabled", false);
            else
                $('#markTopay').prop("disabled", true);
        },
        toolbar: [
            {
                name: "ErrorRowsExcel.xlsx",
                template: '<button class="k-button" onclick="uploadErrorRowsExcel();"><i class="pf-icon pf-16 pf-exel"></i> Вигрузити в EXCEL</button>'
            }
            //,{
            //    template: '<button id="markTopay" class="btn btn-primary" onclick="MarkToPay();">Позначити до оплати</button>'
            //}
        ],
        //template: "#= getBlockName(block_type) #"
        columns: [
            {
                field: "MFO",
                title: "МФО (ПФУ)",
                width:"4%",
                filterable: false
            },
            {
                field: "BRANCH",
                title: "Відділення",
                width: "10%"
            },
            {
                field: "KF_BANK",
                title: "МФО",
                width: "7%"
            },
            {
                field: "PFU_ENVELOPE_ID",
                title: "ID конверту",
                width: "5%"
            },
            {
                field: "FILE_ID",
                title: "ID реєстру",
                width: "4%"
            },
            {
                field: "ID",
                title: "ID інформаційного рядка",
                width: "7%"
            },
            {
                field: "NLS_PFU	",
                title: "Рахунок (ПФУ)"
            },
            {
                field: "NLS_BANK",
                title: "Рахунок (АБС)"
            },
            {
                field: "NMK_PFU",
                title: "ПІБ Пенсіонера ПФУ",
                width: "8%"
            },
            {
                field: "NMK_BANK",
                title: "ПІБ Пенсіонера АБС"
            },
            {
                field: "OKPO_PFU",
                title: "ІПН ПФУ"
            },
            {
                field: "OKPO_BANK",
                title: "ІПН АБС"
            },
            {
                field: "RNK_BANK",
                title: "РНК Пенсіонера",
                width: "5%"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: "5%"
            },
            {
                field: "ERR_MESS_TRACE",
                title: "Опис помилки"
            }
        ]
    });

    uploadErrorRowsExcel = function () {
        var datsource = $("#gridErrorRows").data("kendoGrid").dataSource;
        var filter = datsource.filter();
        var sort = datsource.sort();
        var dataSourceRequest = "";
        if (sort && sort.length != 0) {
            dataSourceRequest = dataSourceRequest + "?sort=" + sort[0].field + "-" + sort[0].dir;
        }
        else
            dataSourceRequest = dataSourceRequest + "?sort=";
        if (filter && filter != null) {
            dataSourceRequest = dataSourceRequest + "&filter=";
            for (var i = 0; i < filter.filters.length; i++) {
                if (filter.filters[i].filters) {
                    dataSourceRequest = dataSourceRequest + "(" + filter.filters[i].filters[0].field + "~" + filter.filters[i].filters[0].operator + "~" + "'" + filter.filters[i].filters[0].value + "'";
                    dataSourceRequest = dataSourceRequest + "~" + filter.filters[i].logic + "~";
                    dataSourceRequest = dataSourceRequest + filter.filters[i].filters[1].field + "~" + filter.filters[i].filters[1].operator + "~" + "'" + filter.filters[i].filters[1].value + "'" + ")";
                }
                else {
                    dataSourceRequest = dataSourceRequest + filter.filters[i].field + "~" + filter.filters[i].operator + "~" + "'" + filter.filters[i].value + "'";
                }
                if (i + 1 < filter.filters.length) {
                    dataSourceRequest = dataSourceRequest + "~and~";
                }
            }

        }
        else
            dataSourceRequest = dataSourceRequest + "&filter=";
        var MFO = $('#mfo').val();
        var ID = $('#regid').val();
        var url = bars.config.urlContent('/pfu/pfu/GetErrorRowsFile/') + dataSourceRequest + '&MFO=' + MFO + '&ID=' + ID;
        document.location.href = url;
        return false;
    }
}
