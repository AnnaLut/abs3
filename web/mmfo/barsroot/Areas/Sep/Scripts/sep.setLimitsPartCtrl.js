$(document).ready(function () {

    $("#setLimitToolbar").kendoToolBar({
        items: [
            { template: "<button id='setL_btr_reload' type='button' class='k-button' title='Перечитати'><i class='pf-icon pf-16 pf-reload_rotate'></i></button>" },
            { template: "<button id='setL_btr_save' type='button' class='k-button' title='Зберегти зміни в базі даних'><i class='pf-icon pf-16 pf-save'></i></button>" },
            { template: "<button id='setL_btr_history' type='button' class='k-button' title='Історія встановлення лімітів по даному МФО'><i class='pf-icon pf-16 pf-folder_open'></i></button>" },
            { template: "<button id='setL_btr_excel' type='button' class='k-button' title='Друк'><i class='pf-icon pf-16 pf-exel'></i></button>" },
            { template: "<label><input type='checkbox' id='isFormFile'> Сформувати файл лімітів для учасників</label>"},
        ]
    });

    $("#setL_btr_reload").click(function () {
        $("#setLimitGrid").data('kendoGrid').dataSource.read();
    });
    $("#setL_btr_excel").click(function () {
        $("#setLimitGrid").data('kendoGrid').saveAsExcel();
    });
    $("#setL_btr_history").click(function () {
        openChildGrid();
    });
    $("#setL_btr_save").click(function () {

        var grid = $("#setLimitGrid").data('kendoGrid');
        var data = grid.dataSource.data();
        var dirty = $.grep(data, function (item) { return item.dirty });

        $.ajax({
            type: "POST",
            data: JSON.stringify(dirty),
            url: bars.config.urlContent('/sep/sepsetlimitsdirectparticipants/saveparticipantschanges'),
            dateType: "json",
            contentType: "application/json; charset=UTF-8",
            success: function (data) {
                if (data.status !== "error") {
                    alert("Зміні успішно збережені");
                    if ($('#isFormFile').is(":checked")) {
                        //forming file
                        $.ajax({
                            type: "POST",
                            url: bars.config.urlContent('/sep/sepsetlimitsdirectparticipants/createflagfile'),
                            dateType: "json",
                            contentType: "application/json; charset=UTF-8",
                            success: function (data2) {
                                if (data2.status === "ok") {
                                    alert("Файл сформовано");
                                } else {
                                    alert(data2.message);
                                }
                            }
                        });
                    }
                    $("#setL_btr_reload").click();
                } else {
                    bars.ui.error({ text: "Невдалося зберегти зміни.<br>" + data.message });
                }
            }
        });



        //need send dirty via post to controller
    });

    var openChildGrid = function () {
        var grid = $("#setLimitGrid").data("kendoGrid");
        var item = grid.dataItem(grid.select());
        if (item != null)
            bars.ui.dialog({
                title: "Історія змін",
                content: String("/barsroot/sep/sepsetlimitsdirectparticipants/SetLimitsHistory?mfo=" + item.MFO),
                iframe: true,
                width: '90%',
                height: 500,
            });
        else
            bars.ui.alert({text: "Оберіть стрічку."});
    };

    $('#setLimitGrid').on('dblclick', ' tbody > tr', function () {
        openChildGrid();
    });

    $("#setLimitGrid").kendoGrid({
        excel: {
            allPages: true,
            fileName: "Ліміти прямим учасникам.xlsx",
            proxyURL: bars.config.urlContent("/Notary/ExportToExcel")
        },
        dataSource: {
            transport: {
                read: {
                    dataType: 'json',
                    type: "GET",
                    url: function () {
                        return bars.config.urlContent('/sep/sepsetlimitsdirectparticipants/getparticipantsinfo');
                    }
                }
            },
            schema: {
                parse: function (response) {
                    return response.data;
                },
                model: {
                    fields: {
                        ACC: { type: "string", editable: false, },
                        MFO: { type: "string", editable: false, },
                        KV: { type: "string", editable: false, },
                        NMS: { type: "string", editable: false, },
                        OSTC: { type: "number", editable: false, },
                        DOS: { type: "number", editable: false, },
                        KOS: { type: "number", editable: false, },
                        LIM: { type: "number", editable: true, },
                        LNO: { type: "number", editable: true, },
                        MFOP: { type: "string", editable: false, },
                        LCV: { type: "string", editable: false, },
                        NB: { type: "string", editable: false, },
                        clOstN: { type: "number", editable: false, },
                        clOstNL: { type: "number", editable: false, },
                    }
                }
            },
            aggregate: [
                { field: "DOS", aggregate: "sum" },
                { field: "KOS", aggregate: "sum" },
                { field: "OSTC", aggregate: "sum" },
                { field: "clOstN", aggregate: "sum" },
                { field: "clOstNL", aggregate: "sum" },
                { field: "LIM", aggregate: "sum" },
                { field: "LNO", aggregate: "sum" }

            ],
            serverPaging: false,
            serverFiltering: false,
        },
        sortable: true,
        selectable: true,
        height: document.documentElement.offsetHeight * 0.8,
        filterable: true,
        editable: true,
        columns:
        [{
            field: "ACC",
            hidden: true,
        }, {
            field: "MFO",
            title: "MFO",
            width: "75px"
        },{
            field: "LCV",
            title: "Вал.",
            width: "74px"
        }, {
            field: "NMS",
            title: "Назва",
            width: "160px"
        }, {
            field: "DOS",
            title: "Обороти Дебет",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        }, {
            field: "KOS",
            title: "Обороти Кредит",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        },{
            field: "OSTC",
            title: "Залишок",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"

        }, {
            field: "clOstN",
            title: "Залишок незаквитований",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        }, {
            field: "clOstNL",
            title: "Залишок незаквитований (Ліміт 6-7)",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        }, {
            field: "LIM",
            title: "Ліміт",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        }, {
            field: "LNO",
            title: "Ліміт початкових",
            format: "{0:n2}",
            attributes: { style: "text-align:right;" },
            aggregates: ["sum"],
            footerTemplate: "<div style='text-align:right;'> #=kendo.toString(sum, \"n2\")#</div>"
        }, {
            field: "KV",
            title: "Назва",
            hidden: true,
        },  {
            field: "MFOP",
            title: "МФО юр. особи",
            hidden: true,
        }, {
            field: "NB",
            title: "МФО юр. особи",
            hidden: true,
        }, 
        ]
    });
});