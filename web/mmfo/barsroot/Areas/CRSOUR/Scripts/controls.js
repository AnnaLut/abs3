$(document).ready(function () {

    //Список типу договору
    $("#dealType").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "AgreemtId",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crsour/multideal/getagreements")
                }
            }
        }
    });

    $("#currency").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "LCV",
        dataValueField: "KV",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    type: "GET",
                    url: bars.config.urlContent("/api/crsour/multideal/currencylist")
                }
            }
        }
    });

    //Права нижня трічка з параметрами
    /*$(function () {
        $.ajax({
            //dataType: "json",
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/gettransitinfo/gettransinfo"),

            success: function (data) {
                $("#Norm7").val(data);
            }
        });
    });*/

    //Реквізити Банка (зліва)
    /*$(function () {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/bankrequisites/getleftbankrequire"),
            success: function (data) {
                $("#bankName").val(data[0]);
                $(".mfo").val(data[1]);
                $("#bicode").val(data[2]);
                $("#okpo").val(data[3]);
                $("#pb").val(data[4]);
                $("#outRnk").val(data[5]);
            }
        });
    });
    
    $("#dealType").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "AgreemtId",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getagreements")
                }
            }
        }
    });


    var getRoadInfo = function() {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/getdata/getroadinfo?nls=" + $("#nls").val() + "&kv=" + $("#currency").val()),
            success: function (data) {
                debugger;
                $("#acc").val(data.ACC);
                $("#bicUser").val(data.BIC);
                if ($("#acc").val() == 0) {
                    $("#acc").val("");
                }
                return data;
            }
        });
    };

    //var check

    $("#scoreList").change(function() {
        
    });


    $("#currency").change(function () {
        $("#scoreList").kendoDropDownList({
            //optionLabel: " ",
            dataTextField: "NMS",
            dataValueField: "NLS",
            dataSource: {
                transport: {
                    read: {
                        dataType: "json",
                        data: { kvStr: this.value },
                        url: bars.config.urlContent("/api/mbdk/getdata/getscorelist/")
                    }
                },
                change: function (e) {
                    if (e.items.length > 0) {
                        $("#nls").val(e.items[0].NLS);
                        getRoadInfo();
                        if ($("#acc").val() == 0) {
                            $("#acc").val("");
                        }
                    } else {
                        $("#nls").val("");
                        $("#acc").val("");
                        $("#bicUser").val("");
                    }
                }
            }
        });

        
    });
    $("#scoreList").change(function () {
        debugger;
        var score = $("#scoreList").val();
        if (score != "") {
            $("#nls").val($("#scoreList").val());
            getRoadInfo();
            if ($("#acc").val() == 0) {
                $("#acc").val("");
            }
        } else {
            $("#nls").val("");
            $("#acc").val("");
            $("#bicUser").val("");
        }
    });

    $("#acc").change(function () {
        debugger;
        if ($("#acc").val() == 0) {
            $("#acc").val("");
        }
    });

    $("#callGridClient").click(function () {
        var myWindow = $("#window"),
                    undo = $("#undo");

        undo.click(function () {
            myWindow.data("kendoWindow").open();
            undo.fadeOut();
        });

        function onClose() {
            undo.fadeIn();
        }

        myWindow.kendoWindow({
            width: "800px",
            height: "390px",
            title: "Вибір контр агента",
            visible: false,
            resizable: false,
            actions: [
                "Close"
            ],
            close: onClose
        }).data("kendoWindow").center().open();

        var grid = $("#gridClient").kendoGrid({
            dataSource: {
                type: "json",
                transport: {
                    read: bars.config.urlContent("/api/mbdk/clientdata/getclient")
                },
                pageSize: 10
            },
            height: 370,
            filterable: true,
            selectable: "row",
            pageable: {
                refresh: true,
                buttonCount: 5
            },
            columns: [{
                field: "RNK",
                title: "RNK",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NMK",
                title: "NMK",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "MFO",
                title: "MFO",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CODCAGENT",
                title: "CODCAGENT",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "BIC",
                title: "BIC",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OKPO",
                title: "OKPO",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "KOD_B",
                title: "KOD_B",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }]
        });

        $("#window").append(grid);

        $("#gridClient").on("dblclick", "tbody > tr", function () {
            var data = $("#gridClient").data("kendoGrid");
            var selectedItem = data.dataItem(data.select());
            $("#nmk").val(selectedItem.NMK);
            $("#mfo").val(selectedItem.MFO);
            $("#bic").val(selectedItem.BIC);
            $("#okpoUser").val(selectedItem.OKPO);
            $("#kod_b").val(selectedItem.KOD_B);
            $("#rnk").val(selectedItem.RNK);

            $("#window").data("kendoWindow").close();
            $("#gridClient").css("height", "");
            $("#gridClient").children().remove();
        });

    });


    $("#roadPay").click(function () {
        var myWindow = $("#window"),
                    undo = $("#undo");

        undo.click(function () {
            myWindow.data("kendoWindow").open();
            undo.fadeOut();
        });

        function onClose() {
            undo.fadeIn();
        }

        myWindow.kendoWindow({
            width: "800px",
            height: "390px",
            title: "Банки учасники SWIFT",
            visible: false,
            resizable: false,
            actions: [
                "Close"
            ],
            close: onClose
        }).data("kendoWindow").center().open();

        var grid = $("#gridRoad").kendoGrid({
            dataSource: {
                type: "json",
                transport: {
                    read: bars.config.urlContent("/api/mbdk/clientdata/getpayroad")
                },
                pageSize: 10
            },
            height: 370,
            filterable: true,
            selectable: "row",
            pageable: {
                refresh: true,
                buttonCount: 5
            },
            columns: [{
                field: "BIC",
                title: "BIC",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "NAME",
                title: "NAME",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "OFFICE",
                title: "OFFICE",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CITY",
                title: "CITY",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "COUNTRY",
                title: "COUNTRY",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "CHRSET",
                title: "CHRSET",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }, {
                field: "TRANSBACK",
                title: "TRANSBACK",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }]
        });

        $("#window").append(grid);

        $("#gridRoad").on("dblclick", "tbody > tr", function () {
            var data = $("#gridRoad").data("kendoGrid");
            var selectedItem = data.dataItem(data.select());
            $("#bicRoad").val(selectedItem.BIC);
            $("#nameRoad").val(selectedItem.NAME);

            $("#window").data("kendoWindow").close();
            $("#gridRoad").css("height", "");
            $("#gridRoad").children().remove();

        });

    });


    
    $("#someList").kendoDropDownList({
        dataSource: [
            { text: "", value: "" },
            { text: "UAN", value: "1" },
            { text: "USD", value: "2" }
        ],
        dataTextField: "text",
        dataValueField: "value"
    });

    $("#listOfBase").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "BNAME",
        dataValueField: "BaseID",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getbasesdata")
                }
            }
        }
    });

    $("#initTrans").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "TXT",
        dataValueField: "ProductID",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getinitialtransferlist")
                }
            }
        }
    });


    

    $(".dateStart").kendoDatePicker({
        value: new Date(),
        max: new Date(),
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });

    $(".dateEnd").kendoDatePicker({
        value: new Date(),
        max: new Date(),
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });*/
});