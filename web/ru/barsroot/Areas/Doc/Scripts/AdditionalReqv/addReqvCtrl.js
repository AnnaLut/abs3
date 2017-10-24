$(document).ready(function () {

    $("#filter_datre").kendoDatePicker({
        value: new Date(),
        format: "dd.MM.yyyy"
    });

    $("#codes_list").kendoDropDownList({
        dataTextField: "KODF",
        dataValueField: "ID",
        dataSource: {
            transport: {
                read: {
                    type: "POST",
                    dataType: "json",
                    url: function () {
                        return bars.config.urlContent("/api/doc/additionalreqv/getcodesinfo");
                    },
                }
            }
        }
    });

    var element = $("#grid").kendoGrid({
        autoBind: false,
        dataSource: {
            transport: {
                read: {
                    dataType: 'json',
                    type: "POST",
                    url: function () {
                        var code = $("#codes_list").data("kendoDropDownList").text();
                        var date = kendo.toString($("#filter_datre").data("kendoDatePicker").value(), "dd.MM.yyyy");
                        return bars.config.urlContent("/api/doc/additionalreqv/getmaingridinfo?KODF=" + code + "&DATEF=" + date);
                    },
                }
            },
            pageSize: 10,
            schema: {
                model: {
                    fields: {
                        REF: { type: "string" },
                        KODF: { type: "string" },
                        DATF: { type: "date" },
                        KV: { type: "string" },
                        SumVal: { type: "number" },
                        COMM: { type: "string" }
                    }
                }
            }
        },
        height: 600,
        sortable: true,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        detailInit: detailInit,
        columns: [
            {
                field: "REF",
                title: "Референс",
                template: '<a target="_blank" href="/barsroot/docinput/docinput_editPropsVal.aspx?ref=#=REF#&kodf=#=KODF#", "_blank");" > #=REF# </a>'
            },
            {
                field: "KODF",
                title: "Код",
            },
            {
                template: "#= kendo.toString(DATF, 'dd.MM.yyyy') #",
                field: "Дата",
            },
            {
                field: "KV",
                title: "Валюта"
            },
            {
                field: "SumVal",
                title: "Сума"
            }
        ]
    });


    function detailInit(e) {
        $(".mon-info").click(function () { debugger; });

        $("<div/>").appendTo(e.detailCell).kendoGrid({
            dataSource: {
                transport: {
                    read: {
                        dataType: 'json',
                        type: "POST",
                        url: function () {
                            return bars.config.urlContent("/api/doc/additionalreqv/getchildgridinfo?Ref=" + e.data.REF);
                        },
                    }
                },
                pageSize: 10,
            },
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },
            columns: [
                { field: "KODP", title:"Код"},
                { field: "ZNAP", title:"Значення" }
            ]
        });
    }


    $("#filterGrid").click(function () {
        $("#grid").show();
        $('#grid').data('kendoGrid').dataSource.read();
        $('#grid').data('kendoGrid').refresh();
    });


    //$("#popup_win_content").kendoWindow({
    //    width: "90%",
    //    title: "Ввід даних",
    //    visible: false,
    //    actions: [
    //        "Minimize",
    //        "Maximize",
    //        "Close"
    //    ],
    //}).data("kendoWindow");

    //$("#popup_win_content").data("kendoWindow").center().open();
   
    //$.ajax({
    //    type: "GET",
    //    url: bars.config.urlContent("/docinput/editprops.aspx?mode=0"),
    //    success: function (data) {
    //        $("#InnerContent").append(data);
    //        debugger;
    //    }
    //});

});

