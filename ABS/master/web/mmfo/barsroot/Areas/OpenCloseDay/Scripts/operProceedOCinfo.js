var interval;

$(document).ready(function () {

    //// var tomorrowDate = new Date();
    //// tomorrowDate.setDate(tomorrowDate.getDate() + 1);
    $("#dateNew").kendoDatePicker({
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
        //,
        //change: function () {
        //    //validation of date change. nice code
        //    //will bity to delete it
        //    /////////////////////////////////////
        //    //var newDatep = this.value();
        //    //var pDate = $("#date").val().split(".");
        //    //var oldDatep = new Date(pDate[2], pDate[1] - 1, pDate[0]);
        //    //if (oldDatep > newDatep) {
        //    //    bars.ui.error({ title: 'Помилка', text: "Дата наступного банківського дня,\n менше за наступну" });
        //    //    this.value(tomorrowDate);
        //    //}
        //    //console.log(value); //value is the selected date in the datepicker
        //}
    });
    

    $("#departmentReadyGrid").kendoGrid({
        dataSource: {
            //type: "aspnetmvc-ajax",
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/opencloseday/departmentinfo/getallbranchstages/")
                }
            },
            schema: {
                model: {
                    fields: {
                        BRANCH: { type: "string" },
                        BRANCH_NAME: { type: "string" },
                        STAGE_NAME: { type: "string" },
                        STAGE_TIME: { type: "string" },
                        STAGE_USER: { type: "string" },
                        IS_READY: { type: "string" }
                    }
                }
            }
        },
        height: 350,
        sortable: true,
        pageable: false,
        serverPaging: false,
        serverSorting: false,
        serverFiltering: false,
        
        columns: [{
            field: "BRANCH",
            title: "Бранч",
            width: 240
        }, {
            field: "BRANCH_NAME",
            title: "Відділення"
        }, {
            field: "STAGE_NAME",
            title: "Назва"
        }, {
            template: "#= (STAGE_TIME == null) ? ' ' : kendo.toString(kendo.parseDate(STAGE_TIME), 'dd MMM yyyy hh:mm') #",
            field: "STAGE_TIME",
            title: "Час"
        }, {
            field: "STAGE_USER",
            title: "Користувач"
        }, {
            field: "IS_READY",
            title: "Готовність",
            hidden: true,
            attributes: {
                "class": "invisible-knd"
            }
        }]
    });

    //function ckeck_depart_ready() {
    //    debugger;
    //    var tmp = 1;
    //    $(".invisible-knd")
    //        .each(function () {
    //            var item = ($(this).html());
    //            debugger;
    //            tmp *= item;
    //        });
    //    if (tmp == 1) {
    //        $("#warningText").text("Всі оператори готові")
    //                         .removeClass("text-danger")
    //                         .addClass("text-success");
    //        $("#warningTextInfo").text("Ви можете продовжити виконання процедури, але у разі продовження, регламентні процедури по таких РУ за замовчанням не виконуються - виконання процедур може бути включено технологом в індивідуальному порядку.")
    //                         .removeClass("text-danger")
    //                         .addClass("text-success");
    //    } else {
    //        $("#warningText").text("Увага!!! Не всі оператори готові!!");
    //        debugger;
    //    }

    //    $("#departmentReadyGrid").data('kendoGrid').dataSource.read();
    //    $("#departmentReadyGrid").data('kendoGrid').refresh();
    //};

    //debugger;
    ////interval = setInterval(ckeck_depart_ready, 2000);


   

    $("#windowInfo").kendoWindow({
        width: "50%",
        height: "30%",
        title: "УВАГА!",
        visible: false,
        actions: [
            "Minimize",
            "Maximize",
            "Close"
        ]
    }).data("kendoWindow");


    function goToOpenCloseSeinings() {
        $("#windowInfo").data("kendoWindow").close();
        var nextDate = $("#dateNew").val();
        var currentDate = $("#date").val();

        $.ajax({
            type: "GET",
            async: false,
            url: bars.config.urlContent("/api/opencloseday/departmentinfo/getdeployrunid/?date=" + nextDate),
            success: function (dataid) {
                
                debugger;
                //if succsess go to the next page
                $.ajax({
                    type: "GET",
                    async: false,
                    url: bars.config.urlContent("/opencloseday/openclose/opseitings?" +
                                                    "dayclose=" + currentDate +
                                                    "&dayopen=" + nextDate),
                    dateType: "json",
                    data: currentDate,
                    success: function (data) {
                        //clearInterval(interval);

                        if (data.State == "Error") {
                            bars.ui.error({ title: 'Помилка', text: data.Error });
                            $("#pass").val("");
                        } else {
                            debugger;
                            var link = bars.config.urlContent("/opencloseday/openclose/opseitings?" +
                                                    "dayclose=" + currentDate +
                                                    "&dayopen=" + nextDate +
                                                    "&runId=" + dataid);
                            window.location.href = link;
                            $("#sessionId").text(dataid);
                            //
                            //$(".form-horizontal").remove();
                            $(".container").append(data);
                        }
                    }
                });

                $("#sessionId").text(dataid);
            }
        });
    };

    $("#getKeyId").click(goToOpenCloseSeinings);


    $("#alertInfo").click(function () {
        var tmp = 1;
        $(".invisible-knd")
            .each(function () {
                tmp *= ($(this).html());
            });
        if (tmp == 1) {
            goToOpenCloseSeinings();
        } else {
            $("#windowInfo").data("kendoWindow").center().open();
        }
        
    });

    $("#btnCancel").click(function () {
        $("#windowInfo").data("kendoWindow").close();
    });

    
});