var help = help || {};
$(document).ready(function () {
    var back = bars.extension.getParamFromUrl('button', window.location.toString());
    help.requiredDocForNonId = function () {
        $("#serial").prop("required", true);
        $("#number").prop("required", true);
        $("#eddrid").removeProp("required");
        $("#docid").removeProp("required");
        $("#actualdate").removeAttr("required");
        $("#bplace").removeAttr("required");
        $("#eddrid").val("");
        $("#docid").val("");
        $("#actualdate").val("");
        $("#bplace").val("");
    }

    help.requiredDocForId = function () {
        $("#serial").removeAttr("required");
        $("#number").removeAttr("required");

        $("#serial").val("");
        $("#number").val("");

        $("#eddrid").prop("required", true);
        $("#docid").prop("required", true);
        $("#actualdate").prop("required", true);
        $("#bplace").prop("required", true);
    }
    help.checkBox = function (bool) {
        $("#middlenamecheck").prop("disabled", bool);
        $("#inncheck").prop("disabled", bool);
        $("#serialcheck").prop("disabled", bool);
        $("#edrpoucheck").prop("disabled", bool);
    }

    help.switchInput = function (bool) {
        $("#lastname").prop('readonly', bool);
        $("#firstname").prop('readonly', bool);
        $("#middlename").prop('readonly', bool);
        $("#inn").prop('readonly', bool);
        $("#serial").prop('readonly', bool);
        $("#number").prop('readonly', bool);
        $("#phone").prop('readonly', bool);
        $("#mobileNumber").prop('readonly', bool);
        $("#sourceDownload").prop('readonly', bool);
        $("#postIndex").prop('readonly', bool);
        $("#region").prop('readonly', bool);
        $("#area").prop('readonly', bool);
        $("#address").prop('readonly', bool);
        $("#mfo").prop('readonly', bool);
        $("#edrpou").prop('readonly', bool);
        $('#nls').prop('readonly', bool);
        $("#nlsedrpou").prop('readonly', bool);
        $('#mfoedrpou').prop('readonly', bool);

    }

    help.switchListAndPicker = function (bool) {
        $('#sexDropList').data("kendoDropDownList").enable(bool);
        $('#resDropList').data("kendoDropDownList").enable(bool);
        $('#docTypeDropList').data("kendoDropDownList").enable(bool);
        $('#mfo').data("kendoDropDownList").enable(bool);
        $('#country').data("kendoDropDownList").enable(bool);

        $('#birthday').data("kendoDatePicker").enable(bool);
        $('#issueDate').data("kendoDatePicker").enable(bool);
    }


    help.refreshGridAfterDeactual = function () {
        $('#clientProfileGrid').data('kendoGrid').dataSource.read();
        $('#clientProfileGrid').data('kendoGrid').refresh();
    }

    help.valDate = function () {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/getinfo/valdate"),
            type: "GET",
            success: function (result) {
                $("#dateRegister").val(kendo.toString(kendo.parseDate(result), "dd.MM.yyyy"));
            }
        });
    }

    help.userBranch = function () {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/getinfo/userbranch"),
            type: "GET",
            success: function (result) {
                $("#codeDep").val(result);
            }
        });
    }

    help.getLimit = function (rnk) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/getinfo/getamount"),
            type: "GET",
            data: { rnk: rnk },
            dataType: "json",
            success: function (result) {
                var limit = parseInt(result);
                if (!isNaN(limit)) {
                    $('#limit').val(result);
                    if (limit > 0) {
                        $('#limit').addClass("limit");
                    }
                    else {
                        $('#limit').addClass("zero-limit");
                    }
                }
            },
            error: function (result) {
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    };

    help.getDBcode = function (doctype, ser, numdoc, cbSuccess) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/getinfo/getdbcode"),
            type: "GET",
            data: { doctype: doctype, ser: ser, numdoc: numdoc },
            dataType: "json",
            success: cbSuccess,
            error: function (result) {
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    };

    help.showError = function (data) {
        var startPos = data.indexOf(':') + 1;
        var endPos = data.indexOf('ORA', 2);
        var textRes = data.substring(startPos, endPos);
        bars.ui.error({ title: "Помилка!", text: textRes });
    }

    help.contains = function (needle) {
        var findNaN = needle !== needle;
        var indexOf;

        if (!findNaN && typeof Array.prototype.indexOf === "function") {
            indexOf = Array.prototype.indexOf;
        } else {
            indexOf = function (needle) {
                var i = -1, index = -1;
                for (i = 0; i < this.length; i++) {
                    var item = this[i];

                    if ((findNaN && item !== item) || item === needle) {
                        index = i;
                        break;
                    }
                }
                return index;
            }
        }
        return indexOf.call(this, needle) > -1;
    }

    
    //контроль ІНН
    $("#inn, #birthday").change(function () {
        var inn = $("#inn").val();
        var birthday = $("#birthday").val();
        var isnum = /^\d+$/.test(inn);
        if (inn !== "" && birthday !== "" && isnum) {
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/crkr/getinfo/getbday"),
                data: { okpo: inn },
                success: function (date) {
                    date = kendo.toString(kendo.parseDate(date), 'dd.MM.yyyy');
                    if (date !== birthday) {
                        bars.ui.notify("Увага!", "Контроль ІНН не пройдено", "error");
                    }
                }
            });
        }
    });

    $("#inn, #sexDropList").change(function () {
        var inn = $("#inn").val();
        var sex = $("#sexDropList").val();
        var isnum = /^\d+$/.test(inn);
        if (inn !== "" && sex !== "" && isnum) {
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/crkr/getinfo/getsex"),
                data: { okpo: inn },
                success: function (data) {
                    if (data !== sex) {
                        bars.ui.notify("Увага!", "Контроль ІНН не пройдено", "error");
                    }
                }
            });
        }
    });

    $("#docTypeDropList, #serial, #number, #eddrid, #docid").change(function () {
        var type = $("#docTypeDropList").val();
        var serial = $("#serial").val();
        var number = $("#number").val();
        var eddrid = $("#eddrid").val();
        var docid = $("#docid").val();
        var secondary = $("#edrpoucheck").is(":checked") ? "1" : "0";
        if (type !== "" && (serial !== "" && number !== "") || (eddrid !== "" && docid !== "")) {
            $.ajax({
                type: "GET",
                url: bars.config.urlContent("/api/crkr/getinfo/checkdocument"),
                data: { type: type, serial: serial, number: number === "" ? docid : number, eddrid: eddrid, secondary: secondary },
                success: function (result) {
                    if (result !== "")
                        bars.ui.alert({ title: "Увага!", text: "Клієнт вже зареєстрований в " + result });
                }
            });
        }
    });

    $(function ($) {
        $("#mobileNumber").mask("+99(999) 999-9999");
    });


    $("#edrpoucheck").change(function () {
        if ($("#edrpoucheck").is(":checked")) {
            $("#edrpou").prop("readonly", false);
            $("#ml").hide();
            $("#me").show();
            $("#nl").hide();
            $("#ne").show();
            $("#edrpou").prop("required", true);
            $("#nls").removeAttr("required");
            $("#print").show();
            $("#edrpou").removeClass("disable");
            $("#mfoedrpou").prop("required", true);
            $("#mfo").removeAttr("required");
            
        } else {
            $("#mfo").prop("required", true);
            $("#mfoedrpou").removeAttr("required");
            $("#edrpou").val("");
            $("#edrpou").prop("readonly", true);
            $("#ml").show();
            $("#me").hide();
            $("#nl").show();
            $("#ne").hide();
            $("#edrpou").prop("required", false);
            $("#nls").prop("required", true);
            $("#print").hide();
            $("#edrpou").addClass("disable").css("border-color", "rgb(204, 204, 204)");
            $("#edrpou_validationMessage").hide();
        }
    });

    $("#middlenamecheck, #inncheck, #serialcheck").change(function () {
        var targetName = this.id.slice(0, -5);

        if ($(this).is(":checked")) {
            $("#" + targetName).prop("disabled", true).addClass("disable").val("").css("border-color", "rgb(204, 204, 204)");
            $("#" + targetName + "_validationMessage").hide();
        } else {
            $("#" + targetName).prop("disabled", false).removeClass("disable").val("");
        }
    });

    //-----------------------Актуалізація вкладу--------------------------------
    $("#actual").kendoWindow({
        width: "900px",
        title: "Вклади для актуалізації",
        resizable: false,
        visible: false,
        modal: true,
        actions: [
            "Close"
        ],
        close: onClose
    });

    function onClose() {        
        $('#clientProfileGrid').data('kendoGrid').dataSource.read();
        $('#clientProfileGrid').data('kendoGrid').refresh();
    };

    $("#toolbarActual").kendoToolBar({
        items: [
            { template: "<button type='button' id='alldepo' class='k-button'><span class='k-sprite pf-icon pf-16 pf-report_open'></span> Вибрати із усіх неактуалізованих</button>" }
        ]
    });

    $("#deposit").kendoGrid({
        autobind: false,
        selectable: "row",
        sortable: true,
        scrollable: true,
        filterable: true,
        pageable: {
            refresh: true,
            buttonCount: 5
        },
        columns: [
            { field: "ID", hidden: true },
            {
                field: "FIO",
                title: "ФІО",
                width: "14em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "STATUS_NAME",
                title: "Статус",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DOCSERIAL",
                title: "Серія",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DOCNUMBER",
                title: "Номер",
                width: "7em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "ICOD",
                title: "ІНН",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "KKNAME",
                title: "Назва вкладу",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "NSC",
                title: "Номер вкладу",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "LCV",
                title: "Валюта",
                width: "6em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "ICOD",
                title: "ІНН",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "DATO",
                title: "Дата",
                template: "<div>#= kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy')#</div>",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "SUM",
                title: "Сумма",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            },
            {
                field: "OST",
                title: "Залишок",
                width: "10em",
                filterable: {
                    cell: {
                        operator: "contains"
                    }
                }
            }

        ],
        dataSource: {
            pageSize: 5,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { type: "string" },
                        FIO: { type: "string" },
                        STATUS_NAME: { type: "string" },
                        DOCSERIAL: { type: "string" },
                        DOCNUMBER: { type: "string" },
                        ICOD: { type: "string" },
                        KKNAME: { type: "string" },
                        NSC: { type: "string" },
                        LCV: { type: "string" },
                        DATO: { type: "string" },
                        SUM: { type: "string" },
                        OST: { type: "string" }
                    }
                }
            }
        }
    });

    $("#nls").kendoDropDownList({
        optionLabel: " ",
        dataTextField: "NMS",
        dataValueField: "NLS",
        dataSource: []
    });

    //--------------------------------------------------------------------------
});