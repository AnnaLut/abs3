$(document).ready(function() {

    var validator = $("#deal").kendoValidator().data("kendoValidator"), status = $(".status");

    var ND;
    $("#deal").kendoValidator({
        //errorTemplate: "<span>#=message#</span>"
        errorTemplate: "<span style=\"color:red; font-style:italic;\">#=message#</span>"
    });

    //Для autoComplete поля Валюты
    if (!Number.prototype.toLowerCase) {
        Number.prototype.toLowerCase = function() {
            return this.toString();
        }
    }

    var checkTopDivsHeightTimer = setInterval(function() {

        var lHeight = $("#topLeft").height();
        var rHeight = $("#topRight").height();

        if (rHeight != lHeight)
            $("#topRight").height(lHeight);
    }, 100);

    //Реквізити Банка (зліва)
    $(function() {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/bankrequisites/getleftbankrequire"),
            success: function(data) {
                $("#bankName").text(data[0]);
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
        dataValueField: "VIDD",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getagreements")
                }
            }
        },
        change: function(e) {
            $("#nmk").text("");
            $("#mfo").val("");
            $("#bic").val("");
            $("#okpoUser").val("");
            $("#kod_b").val("");
            $("#rnk").val("");

            $("#s1").val("");
            $("#s3").val("");
            $("#bicRoad").val("");
            if ($("#currency").val() == "980") {
                $("#bicRoad").val($("#bic").val());
            }
            $("#sslb").val("");
            $("#nameRoad").val("");
            $("#58D").val("");
        }
    });



    $("#productType").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME_PRODUCT",
        dataValueField: "CODE_PRODUCT",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getproductlist")
                }
            }
        }
    });

    $("#s58DfieldWindow").kendoWindow({
        width: "300px",
        title: "Підтвердження",
        visible: false
    });
    $("#confirm58DBtn").kendoButton({
        click: function() {
            $("#s58DfieldWindow").data("kendoWindow").close();
            saveDeal();
        }
    });


    $("#currency").kendoAutoComplete({
        template: '<div>#: data.KV # - #: data.LCV #</div>',
        dataSource: {
            transport: {
                read: {
                    url: bars.config.urlContent("/api/mbdk/getdata/getcurrency"),
                    dataType: "json"
                }
            }
        },
        filter: "contains",
        delay: 0,
        dataValueField: "KV",
        dataTextField: "KV",
        minLength: 0,
        placeholder: "Валюта",
        autoWidth: false,
        change: function() {
            var val = this.value().trim();
            var data = this.dataSource.data();
            if (!data.some(function(x) { return x.KV == val; })) {
                this.value('');
                $('#currency').data('kendoAutoComplete').search();
            };
            onCurrencyChange();
        }
    });
    var autoComplete = $("#currency").data("kendoAutoComplete");
    autoComplete.list.width(400);

    $('#currency').focus(function() {
        $('#currency').data('kendoAutoComplete').search();
    });

    $("#eq3").change(function() {
        if ($('#eq3').is(':checked')) {
            $("#s3").attr("readonly", true);
            $("#s3").val("");
            $("#s3").addClass("non-active");
        } else {
            $("#s3").attr("readonly", false);
            $("#s3").removeClass("non-active");
        }
    });
    $("#eq2").change(function() {
        if ($('#eq2').is(':checked')) {
            $("#s1").attr("readonly", true);
            $("#s1").val("");
            $("#s1").addClass("non-active");

        } else {
            $("#s1").attr("readonly", false);
            $("#s1").removeClass("non-active");
        }
    });
    $("#s1").change(function() {
        if (!bars.utils.checkNlsCtrlDigit($("#mfo").val(), $("#s1").val())) {
            bars.ui.alert({ text: "Не проходить перевірку контрольного розряду" })
        }
    });
    $("#s3").change(function() {
        if (!bars.utils.checkNlsCtrlDigit($("#mfo").val(), $("#s3").val())) {
            bars.ui.alert({ text: "Не проходить перевірку контрольного розряду" })
        }
    });

    var getRoadInfo = function() {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/getdata/getroadinfo?nls=" + $("#nls").val() + "&kv=" + $("#currency").val()),
            success: function(data) {
                $("#acc").val(data.ACC);
                $("#bicUser").val(data.BIC);
                if ($("#acc").val() == 0) {
                    $("#acc").val("");
                }
                return data;
            }
        });
    };

    function NullUndefToEmptyString(value) {
        if (value == null || value == undefined)
            return "";

        return value;
    }

    var getContractorParams = function() {

        var currVal = NullUndefToEmptyString($("#currency").val());
        var dTypeVal = NullUndefToEmptyString($("#dealType").val());
        var rnkVal = NullUndefToEmptyString($("#rnk").val());

        if (rnkVal == "" || currVal == "" || dTypeVal == "") {
            return;
        }

        if ($("#currency").val() == "Валюта") {
            bars.ui.alert({ title: "Попередження", text: "Оберіть валюту" });
            return;
        }

        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/getdata/getContractorParams?nVidd=" + $("#dealType").val() + "&rnkB=" + $("#rnk").val() + "&kv=" + $("#currency").val()),
            success: function(data) {
                try {
                    $("#s1").val(data.nls);
                    $("#s3").val(data.nlsn);
                    $("#bicRoad").val(data.swo_bic);
                    $("#sslb").val(data.swo_acc);
                    $("#nameRoad").val(data.swo_alt);
                    $("#58D").val(data.field_58d);
                    return data;
                } catch (err) {
                    $("#s1").val("");
                    $("#s3").val("");
                    $("#bicRoad").val("");
                    if ($("#currency").val() == "980") {
                        $("#bicRoad").val($("#bic").val());
                    }
                    $("#sslb").val("");
                    $("#nameRoad").val("");
                    $("#58D").val("");
                }
            }
        });
    }

    var checkTicketNumber = function(ticketID) {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/getdata/checkTicketNumber?ticketNumber=" + ticketID),
            success: function(data) {
                if (data > 0) {
                    bars.ui.alert({ title: "Попередження", text: "Тікет з таким номером вже існує!" });
                }
                return data;
            }
        });
    }

    var disableUnnecessaryFields = function() {
        if ($("#dealType").val() == "") return;
        var deal = $("#dealType").val();
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/mbdk/getdata/GetDealType?nVidd=" + deal),
            success: function(type) {
                if (type["TIPD"] == 1) {
                    $("#eq3").attr("disabled", "disabled");
                    $("#s3").attr("readonly", true);
                    $("#s3").val("");
                    $("#s3").addClass("non-active");
                }
                else {
                    $("#eq3").removeAttr("disabled");
                    $("#s3").attr("readonly", false);
                    $("#s3").removeClass("non-active");
                }
            }
        });
    }


    var getPawnAccountNumber = function() {
        var mainDealAccount = $("#baseScore").val();
        var rnk = $("#rnk").val();
        var nTip = $("#dealType").val();
        var kv = $("#provKv").val();
        var pawn = localStorage.getItem("pawn");

        var item = { mainDealAccount: mainDealAccount, rnk: rnk, nTip: nTip, kv: kv, pawn: pawn }

        if (rnk != "" && kv != "" && pawn != "") {
            $.ajax({
                dataType: "json",
                type: "POST",
                url: bars.config.urlContent("/api/mbdk/getdata/getprovidingscore"),
                data: item,
                success: function(data) {
                    if (data != null) {
                        $("#provScore").val(data.score);
                    } else {
                        $("#provScore").val(" ");
                    }
                }
            });
        }
    };

    var getNmsScore = function() {
        var deal = $("#dealType").val();
        var rnk = $("#rnk").val();
        var kv = $("#currency").val();
        var initiator = $("#initTrans").val();
        var model = { RNKB: rnk, nVidd: deal, nKv: kv, initiator: initiator };
        if (deal != "" && rnk != "" && kv != "" && initiator != "") {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/mbdk/getdata/getscorenms"),
                data: model,
                success: function(data) {

                    $("#scoreNLS").empty();
                    if (data[0].length == 0) {
                        $("#scoreNLS").append("<div class='form-group'><label class='k-label col-md-10'>Рахунок доходів не обрано</label></div>");
                    } else {
                        var scrNls = data[0];
                        for (var i = 0; i < scrNls.length; i++) {
                            $("#scoreNLS").append("<div class='form-group'>" +
                                "<input type='radio' name='engine2' id='engine" + i + "' class='k-radio col-md-2' checked='checked'>" +
                                "<label class='k-radio-label col-md-10 name-lb' style='margin-left:25px' for='engine" + i + "'>" + scrNls[i].NMS + "</label>" +
                                "</div>");
                        }
                    }
                    if (data[1] != null) {
                        $("#baseScore").val(data[1].nls1);
                        if ($("#currency").val() == "980") {
                            $("#acc").val($("#baseScore").val());
                        }
                        $("#assessedScore").val(data[1].nls2);
                    }
                    getPawnAccountNumber();
                }
            });
        }
    };

    var calcSumma = function() {
        var inSum = $("#inSumField").val();
        var procStav = $("#procStav").val();
        var basey = $("#listOfBase").val();

        var value;

        //if ($("#dateStart") == undefined || $("#dateStart").data('kendoDatePicker') == undefined) {
        //    value = Date.now();
        //} else {
        value = $("#dateStart").data('kendoDatePicker').value();
        //}
        var dateStart = kendo.toString(value, "dd/MM/yyyy");

        //if ($("#dateEnd") == undefined || $("#dateEnd").data('kendoDatePicker') == undefined) {
        //    value = Date.now();
        //} else {
        value = $("#dateEnd").data('kendoDatePicker').value();
        //}
        var dateEnd = kendo.toString(value, "dd/MM/yyyy");

        //if ($("#conclusionDate") == undefined || $("#conclusionDate").data('kendoDatePicker') == undefined) {
        //    value = Date.now();
        //} else {
        value = $("#conclusionDate").data('kendoDatePicker').value();
        //}
        var conclusionDate = kendo.toString(value, "dd/MM/yyyy");


        var nVidd = $("#dealType").val();
        var kv = $("#currency").val();
        var model = {
            nAmnt: inSum,
            colProcStavka: procStav,
            nBASEY: basey,
            colDatDU: dateStart,
            dDatEnd: dateEnd,
            nVidd: nVidd,
            nKv: kv
        }
        if (inSum != "" && procStav != "" && basey != "" && dateStart != "" && dateEnd != "" && nVidd != "" && kv != "") {
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/mbdk/getdata/calcsumm"),
                data: model,
                success: function(data) {
                    $("#outSum").data("kendoNumericTextBox").value(data);
                }
            });
        }
    };

    $("#dealType, #initTrans").change(function() {
        disableUnnecessaryFields();
        getNmsScore();
        calcSumma();
    });

    $("#ccid").change(function() {
        checkTicketNumber($("#ccid").val());
    })

    $("#inSumField").kendoNumericTextBox({
        min: 0,
        decimal: 3,
        spinners: false
    });

    $("#inSumField").change(function() {
        if (validator.validateInput($("#inSumField"))) {
            calcSumma();
        }
    });
    $("#outSum").kendoNumericTextBox({
        min: 0,
        decimal: 3,
        spinners: false
    });
    $("#provSum").kendoNumericTextBox({
        min: 0,
        decimal: 3,
        spinners: false,
        enable: false
    });


    $("#procStav").change(function() {
        $("#procStav").val($("#procStav").val().replace(",", "."));
        if (validator.validateInput($("#procStav"))) {
            calcSumma();
        }
    });

    $("#listOfBase").change(function() {
        calcSumma();
    });

    function onCurrencyChange() {
        if (validator.validateInput($("#currency"))) {
            if ($("#currency").val() != "980") {
                $("#scoreList").kendoDropDownList({
                    dataTextField: "NMS",
                    dataValueField: "NLS",
                    dataSource: {
                        transport: {
                            read: {
                                dataType: "json",
                                data: { kvStr: $("#currency").val() },
                                url: bars.config.urlContent("/api/mbdk/getdata/getscorelist/")
                            }
                        },
                        change: function(e) {
                            if (e.items.length > 0) {
                                $("#nls").val(e.items[0].NLS);
                                getRoadInfo();
                                if ($("#acc").val() == 0) {
                                    $("#acc").val("");
                                }
                            } else {
                                $("#nls").val("");
                                $("#acc").val("");
                            }
                        }
                    }
                });
                $("#disableGroup :input").attr("disabled", true);
                $("#disableGroup :input").addClass("non-active");
            }
            else {
                $("#bicUser").val($("#bicode").val());
                $("#disableGroup :input").attr("disabled", false);
                $("#disableGroup :input").removeClass("non-active");
            }

            $(function() {
                $.ajax({
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/gettransitinfo/getmultiscore"),
                    data: { KV: $("#currency").val() },
                    success: function(data) {
                        if (data == null) {
                            bars.ui.alert({ text: "Транзитний рахунок 3739 для валюти " + $("#currency").val() + " не відкритий" })
                            $("#currency").val("");
                        } else {
                            $("#multiScore").val(data.NLS);
                            $("#ostat").val(data.NUMB);
                            $("#kv").val($("#currency").val());
                        }

                    }
                });
            });
            getNmsScore();
            calcSumma();
            getContractorParams();
        }
    }


    $("#mfo, #rnk").change(function() {

        if ($("#rnk").val() !== $("#backupRnk").text() &&
            $("#rnk").val() !== "") {
            var rnk = $("#rnk").val();
            var mfo = $("#mfo").val();

            var item = { rnk: rnk, mfo: mfo, bParKR: 0 }
            $.ajax({
                dataType: "json",
                type: "POST",
                url: bars.config.urlContent("/api/mbdk/clientdata/getclient"),
                data: item,
                success: function(data) {
                    if (data.length > 0) {
                        $("#nmk").text(data[0].NMK);
                        $("#mfo").val(data[0].MFO);
                        $("#bic").val(data[0].BIC);
                        $("#numNd").val(data[0].ND)
                        $("#okpoUser").val(data[0].OKPO);
                        $("#kod_b").val(data[0].KOD_B);
                        $("#rnk").val(data[0].RNK);

                        $("#backupRnk").text(data[0].RNK);
                        $("#backupMfo").text(data[0].MFO);
                    }
                }
            });
            getNmsScore();
            getContractorParams();
        }
    });


    $("#scoreList").change(function() {
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
        }
    });

    $("#acc").change(function() {
        if ($("#acc").val() == 0) {
            $("#acc").val("");
        }
    });
    $("#callCurrencyHandBook").click(function() {
        var options = {
            tableName: "TABVAL",
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        }
        bars.ui.getMetaDataNdiTable("TABVAL", function(selectedItem) {
            $("#currency").val(selectedItem.KV);
            onCurrencyChange();
        }, options)
    });
    //--------------------викливає грід з контрагентами----------------

    $("#callGridClient").click(function() {

        var dropDown = $("#dealType").data("kendoDropDownList");
        var selectedIndex = dropDown.select();

        if (selectedIndex == 0) {
            bars.ui.alert({ title: "Увага!", text: "Спочатку оберіть 'Вид договору'" });
            return;
        }

        var ddData = dropDown.dataSource.view()[selectedIndex - 1];
        var contrAgentsTableName = ddData["TIPP"] == 1 ? "V_MBDK_CONTRACTOR_UO" : "V_MBDK_CONTRACTOR";

        var options = {
            tableName: contrAgentsTableName,
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        }
        bars.ui.getMetaDataNdiTable(contrAgentsTableName, function(selectedItem) {

            $("#nmk").text(selectedItem.NMK);
            $("#mfo").val(selectedItem.MFO);
            $("#bic").val(selectedItem.BIC);
            $("#okpoUser").val(selectedItem.OKPO);
            $("#kod_b").val(selectedItem.KOD_B);
            $("#rnk").val(selectedItem.RNK);
            getNmsScore();
            getContractorParams();
        }, options)
    });
    //----------------------------------------------------------------

    //--------------------викливає грід з трасою платежу-----------------
    $("#roadPay").click(function() {
        var options = {
            tableName: "SW_BANKS",
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        }
        bars.ui.getMetaDataNdiTable("SW_BANKS", function(selectedItem) {
            $("#bicRoad").val(selectedItem.BIC);
            $("#nameRoad").val(selectedItem.NAME);
        }, options)
    });

    //--------------------викливає грід з коментарієм-----------------
    $("#comments").click(function() {
        var options = {
            tableName: "SW_BANKS",
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        }
        bars.ui.getMetaDataNdiTable("SW_BANKS", function(selectedItem) {
            $("#area").val(selectedItem.BIC);
        }, options)
    });
    //----------------------------------------------------------------
    //Все свободные счета с остатком в портфеле
    $('#accountsInBriefcase').click(function() {
        if (!$("#dealType").val() || !$("#currency").val() || !$("#outRnk").val() || !$("#inSumField").val()) return;
        var requestUrl = "GetFreeAccountsInBriefcase?nVidd=" + $("#dealType").val() + "&nKv=" + $("#currency").val() + "&RNKB=" + $("#outRnk").val()
            + "&nSUM=" + $("#inSumField").val();
        openAccountsWindow("Рахунки контрагента у портфелі", requestUrl);
    });
    $('#accountsOutsideBriefcase').click(function() {
        if (!$("#dealType").val() || !$("#currency").val() || !$("#outRnk").val()) return;
        var requestUrl = "GetFreeAccountsOutsideBriefcase?nVidd=" + $("#dealType").val() + "&nKv=" + $("#currency").val() + "&RNKB=" + $("#outRnk").val();
        openAccountsWindow("Рахунки контрагента поза портфелем", requestUrl);
    });
    $('#accountsWithoutBalance').click(function() {
        if (!$("#dealType").val() || !$("#currency").val() || !$("#outRnk").val()) return;
        var requestUrl = "GetFreeAccountsWithoutBalance?nVidd=" + $("#dealType").val() + "&nKv=" + $("#currency").val() + "&RNKB=" + $("#outRnk").val();
        openAccountsWindow("Вільні рахунки контрагента", requestUrl);

    });
    function openAccountsWindow(windowTitle, requestUrl) {

        var accountWindow = $('#windowAccounts'),
            undo = $('#undo');
        undo.click(function() {
            accountWindow.data("kendoWindow").open();
            undo.fadeOut();
        });

        function onClose() {
            $("#gridAccounts").children().remove();
            $("#gridAccounts").css("height", "");
            undo.fadeIn();
        }

        accountWindow.kendoWindow({
            width: "800px",
            height: "390px",
            visible: false,
            resizable: false,
            actions: [
                "Close"
            ],
            close: onClose
        }).data("kendoWindow").center().open();
        accountWindow.data("kendoWindow").title(windowTitle);

        var grid = $("#gridAccounts").kendoGrid({
            dataSource: {
                type: "json",
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        dataType: "json",
                        url: bars.config.urlContent("/api/mbdk/getdata/" + requestUrl)
                    }
                },
                schema: {
                    model: {
                        fields: {
                            mainAccount: { type: "string" },
                            completionDate: { type: "date" },
                            mainAccountBalance: { type: "string" },
                            accrualsAccount: { type: "string" },
                            accrualsCompletionDate: { type: "date" },
                            accrualsAccountBalance: { type: "string" }
                        }
                    }
                },
                pageSize: 10
            },
            height: 370,
            filterable: true,
            selectable: "row",
            resizable: true,
            pageable: {
                refresh: true,
                buttonCount: 5
            },
            columns: [
                {
                    field: "MAINACCOUNT",
                    title: "Основний<br>рахунок",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                }, {
                    field: "COMPLETIONDATE",
                    title: "Дата<br>завершення",
                    template: "<div>#= COMPLETIONDATE != null ? kendo.toString(kendo.parseDate(COMPLETIONDATE),'dd.MM.yyyy') : '' #</div>",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    },
                    width: "120px"
                }, {
                    field: "MAINACCOUNTBALANCE",
                    title: "Залишок на<br>основному<br>рахунку",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    },
                    width: "110px"
                }, {
                    field: "ACCRUALSACCOUNT",
                    title: "Рахунок<br>нарахованих %",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                }, {
                    field: "ACCRUALSCOMPLETIONDATE",
                    title: "Дата<br>завершення<br>нарахувань",
                    template: "<div>#= ACCRUALSCOMPLETIONDATE != null ? kendo.toString(kendo.parseDate(ACCRUALSCOMPLETIONDATE),'dd.MM.yyyy') : '' #</div>",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    },
                    width: "120px"
                }, {
                    field: "ACCRUALSACCOUNTBALANCE",
                    title: "Залишок на<br>рахунку<br>нарахованих %",

                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    },
                    width: "110px"
                }]
        });
        $("#windowAccounts").append(grid);
    }

    //----------------------------------------------------------------
    //--------------------забезпечення-------------------------------
    $("#providing").click(function() {
        var options = {
            tableName: "V_MBDK_CC_PAWN",
            jsonSqlParams: "",
            filterCode: "",
            hasCallbackFunction: true
        }
        bars.ui.getMetaDataNdiTable("V_MBDK_CC_PAWN", function(selectedItem) {
            $("#providName").text(selectedItem.NAME);
            $("#provScore").removeClass('non-active');
            $("#provSum").data("kendoNumericTextBox").enable(true);
            $("#provKv").removeClass('non-active');
            $("#provScore").attr('readonly', false);
            $("#provSum").attr('readonly', false);
            $("#provKv").attr('readonly', false);
            $("#provScore").attr('required', true);
            $("#provSum").attr('required', true);
            $("#provKv").attr('required', true);
            localStorage.setItem("pawn", selectedItem.PAWN);
            getPawnAccountNumber();
        }, options)
    });
    //---------------------------------------------------------------

    $(function setStartDate() {
        var dateOn;

        $.ajax({
            type: "GET",
            async: false,
            url: bars.config.urlContent("/api/mbdk/getdata/getbankdate"),
            success: function(data) {
                dateOn = data;
            }
        });
        var dats = dateOn.split('.').reverse().join('/'), nwdates = new Date(dats);

        $("#dateStart").kendoDatePicker({
            value: nwdates,
            format: "dd.MM.yyyy",
            animation: {
                open: {
                    effects: "zoom:in",
                    duration: 300
                }
            },
            change: function() {
                calcSumma(); //value is the selected date in the datepicker
            }
        });
        var date = dateOn.split('.').reverse().join('/'), nwdatee = new Date(date);
        nwdatee.setDate(nwdatee.getDate() + 1);

        $("#dateEnd").kendoDatePicker({
            value: nwdatee,
            format: "dd.MM.yyyy",
            animation: {
                open: {
                    effects: "zoom:in",
                    duration: 300
                }
            },
            change: function() {
                calcSumma(); //value is the selected date in the datepicker
            }

        });

        $("#conclusionDate").kendoDatePicker({
            value: nwdatee,
            format: "dd.MM.yyyy",
            animation: {
                open: {
                    effects: "zoom:in",
                    duration: 300
                }
            },
            change: function() {
                calcSumma(); //value is the selected date in the datepicker
            }

        });

        $("#nbuRegDate").kendoDatePicker({
            //value: nwdatee,
            format: "dd.MM.yyyy",
            animation: {
                open: {
                    effects: "zoom:in",
                    duration: 300
                }
            },
            change: function() {
                calcSumma(); //value is the selected date in the datepicker
            }
        });


    });


    $("#listOfBase").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NAME",
        dataValueField: "BASEY",
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
        dataValueField: "CODE",
        dataSource: {
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/mbdk/getdata/getinitialtransferlist")
                }
            }
        }
    });




    $("#provKv").change(function() {
        getPawnAccountNumber();
    });

    //--------------Збереження угоди---------------------
    saveDeal = function() {

        var CC_ID = $("#ccid").val(); //номер договору
        var nVidd = $("#dealType").val(); //вид договору
        var nKv = $("#currency").val();
        var RNKB = $("#rnk").val();

        var value = $("#dateStart").data("kendoDatePicker").value();
        var colDatDU = kendo.toString(value, "dd/MM/yyyy");
        var colDatDV = colDatDU;
        value = $("#dateEnd").data("kendoDatePicker").value();
        var colDatEndDog = kendo.toString(value, "dd/MM/yyyy");


        var IR = $("#procStav").val();

        var colSumma = $("#inSumField").val();
        var nBASEY = $("#listOfBase").val();
        var S1 = $("#s1").val();
        if ($('#eq2').is(':checked')) {
            var S2 = $(".mfo").val();
        }
        else {
            S2 = $("#mfo").val();
        }
        var S3 = $("#s3").val();
        if ($('#eq3').is(':checked')) {
            var S4 = $(".mfo").val();
        }
        else {
            S4 = $("#mfo").val();
        }
        var S5 = $("#nls").val();
        var NLSA = $("#baseScore").val();
        var NLSNA = $("#assessedScore").val();
        var NMSN = $("#nmk").text();

        var NLSNB = $("#s3").val();
        var NMKB = $("#nmk").text();

        var Nazn_ = "% по дог. " + $("#ccid").val();
        var NLSZ_ = $("#provScore").val();
        var nKVZ_ = $("#provKv").val();
        var p_pawn = localStorage.getItem("pawn");
        var BICKA = $("#bicUser").val();
        var SSLA = $("#acc").val();
        var BICKB = $("#bicRoad").val();
        var SSLB = $("#sslb").val();
        var colSummaP = $("#outSum").val();
        var NMS = $("#nmk").text();
        var AltB = $("#area").val();
        var colSummaZ = $("#provSum").val() * 100;
        var procStav = $("#procStav").val();
        var mfo = $("#mfo").val();

        value = $("#conclusionDate").data("kendoDatePicker").value();
        var concDate = kendo.toString(value, "dd/MM/yyyy");

        value = $("#nbuRegDate").data("kendoDatePicker").value();
        var nbuRegDate = kendo.toString(value, "dd/MM/yyyy");

        var product = $("#productType").val();

        var EffectiveProc = $("#EffectiveProcStav").val();

        var nbuIdValue = $("#nbuId").val();

        var megamodel = {
            CC_ID: CC_ID,
            nVidd: nVidd,
            nKv: nKv,
            colDatDU: colDatDU,
            colDatDV: colDatDV,
            colDatEndDog: colDatEndDog,
            RNKB: RNKB,
            IR: IR,
            colSumma: colSumma,
            nBASEY: nBASEY,
            S1: S1,
            S2: S2,
            S3: S3,
            S4: S4,
            S5: S5,
            NLSA: NLSA,
            NLSNA: NLSNA,
            NMSN: NMSN,
            NLSNB: NLSNB,
            NMKB: NMKB,
            Nazn_: Nazn_,
            NLSZ_: NLSZ_,
            nKVZ_: nKVZ_,
            p_pawn: p_pawn,
            BICKA: BICKA,
            SSLA: SSLA,
            BICKB: BICKB,
            SSLB: SSLB,
            colSummaP: colSummaP,
            NMS: NMS,
            AltB: AltB,
            colSummaZ: colSummaZ,
            colDatConclusion: concDate,
            colNbuRegDate: nbuRegDate,
            productCode: product,
            irr: EffectiveProc,
            n_nbu: nbuIdValue
        }

        if (nVidd != "" && nKv != "" && RNKB != "" && procStav != "" && nBASEY != "" && colSumma != "") {
            bars.ui.loader('body', true);
            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/mbdk/savedeal/createdeal"),
                data: megamodel,
                success: function(data) {

                    bars.ui.loader('body', false);
                    if (data.error == null) {
                        bars.ui.alert({ title: "Збереження угоди", text: "Угода " + data.acc + " збережена ND = " + data.nd });
                        ND = data.nd;
                        $("#saveDeal").attr("disabled", true);
                        $("#saveDeal").find('span').addClass("pf-disabled");
                        activateButtons();
                    } else {

                        bars.ui.error({ title: "Помилка!", text: data.error });
                    }

                }
            });
        } else {

            bars.ui.alert({ title: "Помилка!", text: "Недостатньо даних для збереження угоди!" });
        }
    }
    $("#saveDeal").click(function(event) {
        event.preventDefault();
        if (validator.validate()) {

            if ($("#currency").val() === "643") {
                $("#s58DfieldWindow").data("kendoWindow").center().open();
            }
            else {
                saveDeal();
            }

        } else {
            bars.ui.alert({ title: "Помилка!", text: "Недостатньо даних для збереження угоди!" });
        }
    });

    $("#printDeal").kendoButton({
        click: function() {
            if (ND) {
                window.open(bars.config.urlContent("/mbdk/deal/ExportDoc/") + "?ND=" + ND, ND);
            } else {

            }
        }
    });
    $("#saveRoad").kendoButton({
        click: function() {
            bars.ui.confirm({ text: 'Зберегти параметри траси?' }, function() {
                var rnk = $("#rnk").val();
                var currency = $("#currency").val();
                var partnerBic = $("#bicRoad").val();
                var partnerAcc = $("#sslb").val();
                var altRoad = $("#area").val();
                var partherAccNumber = $("#s1").val();
                var s58D = $("#58D").val();

                $.ajax({
                    dataType: "json",
                    type: "POST",
                    url: bars.config.urlContent("/api/mbdk/getdata/SaveRoadParams"),
                    data: {
                        rnk: rnk,
                        currencyCode: currency,
                        partnerBick: partnerBic,
                        partnerAccount: partnerAcc,
                        altRoad: altRoad,
                        sIntermB: "",
                        s58D: s58D,
                        partherAccNumber: partherAccNumber
                    },
                    success: function(data) {
                        bars.ui.alert({ text: "Трасу збережено" });
                    }
                });
            });

        }
    });

    $("#partnersResidentsBtn").kendoButton({
        click: function() {
            bars.ui.getMetaDataNdiTable("V_RESID_PARTNERS", function() { }, { tableName: "V_RESID_PARTNERS", jsonSqlParams: "", filterCode: "" })
        }
    });
    $("#partnersNonResidentsBtn").kendoButton({
        click: function() {
            bars.ui.getMetaDataNdiTable("V_NONRESID_PARTNERS", function() { }, { tableName: "V_NONRESID_PARTNERS", jsonSqlParams: "", filterCode: "" })
        }
    });
    $("#dealsArchive").kendoButton({
        click: function() {
            bars.ui.getMetaDataNdiTable("V_MBDK_ARCHIVE", function() { }, { tableName: "V_MBDK_ARCHIVE", jsonSqlParams: "", filterCode: "" })
        }
    });
    $("#clientPasportBtn").kendoButton({
        click: function() {
            var rnk = $("#rnk").val();
            if (rnk === "") {
                bars.ui.alert({ title: "Помилка!", text: "Оберіть клієнта-контрагента" });
                return;
            }

            var myWindow = $("#clientPasportWindow"),
                undo = $("#undo");
            undo.click(function() {
                myWindow.data("kendoWindow").open();
                undo.fadeOut();
            });

            myWindow.kendoWindow({
                width: "800px",
                height: "700px",
                resizable: true,
                modal: true,
                visible: false,
                iframe: true,
                content: bars.config.urlContent("/clientregister/registration.aspx?readonly=0&rnk=" + rnk)

            }).data("kendoWindow").center().open();

        }
    });

    $("#clientOpenAccountsBtn").kendoButton({
        click: function() {
            var rnk = $("#rnk").val();
            if (rnk === "") {
                bars.ui.alert({ title: "Помилка!", text: "Оберіть клієнта-контрагента" });
                return;
            }

            var myWindow = $("#clientOpenAccountsWindow"),
                undo = $("#undo");
            undo.click(function() {
                myWindow.data("kendoWindow").open();
                undo.fadeOut();
            });

            myWindow.kendoWindow({
                width: "800px",
                height: "700px",
                resizable: true,
                modal: true,
                visible: false,
                iframe: true,
                content: bars.config.urlContent("/customerlist/custacc.aspx?type=0&rnk=" + rnk)

            }).data("kendoWindow").center().open();

        }
    });

    $("#reloadBtn").kendoButton({
        click: function() {
            window.location = window.location
        }
    });
    $("#createDocuments").kendoButton({
        click: function() {
            if (ND) {
                url = '/barsroot/ndi/referencebook/GetRefBookData/?NsiFuncId=40&TableName=V_MBDK_PORTFOLIO&RowParamsNames=:ND|&jsonSqlParams=[{%22Name%22:%22ND%22,%22Type%22:%22N%22,%22Value%22:' + ND + '}]';
                bars.ui.dialog({
                    content: url,
                    iframe: true,
                    modal: false,
                    height: document.documentElement.offsetHeight * 0.8,
                    width: document.documentElement.offsetWidth * 0.8,
                    padding: 0,
                    actions: ["Refresh", "Maximize", "Minimize", "Close"]
                });
            }
        }
    });

    $("#createSwift").kendoButton({

        click: function() {
            if (ND) {
                $.ajax({
                    dataType: "json",
                    type: "POST",
                    url: bars.config.urlContent("/api/mbdk/AdditionalFunctions/CreateSwiftMessage"),
                    data: { '': ND },
                    success: function(data) {
                        $("#showSwift").data('kendoButton').enable(true);
                        $("#showSwift").find('span').removeClass("pf-disabled");
                        bars.ui.alert({ text: "SWIFT повідомлення сформовано" });
                    }
                });
            }

        }
    });

    $("#showSwift").kendoButton({

        click: function() {
            if (ND) {
                $.ajax({
                    type: "GET",
                    url: bars.config.urlContent("/api/mbdk/AdditionalFunctions/GetSwifMessageRef?ND=" + ND),
                    success: function(swiftRef) {
                        if (swiftRef) {
                            window.open('/barsroot/documentview/view_swift.aspx?swref=' + swiftRef, '_blank')
                        }
                    }
                });
            }

        }
    });



    function activateButtons() {
        $("#printDeal").data('kendoButton').enable(true);
        $("#printDeal").find('span').removeClass("pf-disabled");
        $("#saveRoad").data('kendoButton').enable(true);
        $("#saveRoad").find('span').removeClass("pf-disabled");
        $("#createDocuments").data('kendoButton').enable(true);
        $("#createDocuments").find('span').removeClass("pf-disabled");
        $("#createSwift").data('kendoButton').enable(true);
        $("#createSwift").find('span').removeClass("pf-disabled");
    };
    $("#initTrans").data("kendoDropDownList").focus();


    jQuery.extend(jQuery.expr[':'], {
        focusable: function(el, index, selector) {
            return $(el).is('a, button, :input, [tabindex]');
        }
    });

    $(document).on('keydown', 'input[id], .k-dropdown, .k-button', function(e) {

        if (e.which == 13) {
            e.preventDefault();
            // Get all focusable elements on the page            
            var index = $(document.activeElement).prop("tabindex") + 1;
            $('[tabindex=' + index + ']').focus();
            return;
        }
    });
});