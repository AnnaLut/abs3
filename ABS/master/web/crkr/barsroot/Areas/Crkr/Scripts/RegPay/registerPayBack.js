var registerGrids = registerGrids || {};
var error = error || {};
$(document).ready(function () {
    //bocouse ie8
    window.hasOwnProperty = window.hasOwnProperty || Object.prototype.hasOwnProperty;

   
    $(".datepicker").kendoDatePicker({
        value: new Date(),
        format: "dd.MM.yyyy",
        animation: {
            open: {
                effects: "zoom:in",
                duration: 300
            }
        }
    });

    //if type = dep it's compen if type = bur it's on funeral
    var type = bars.extension.getParamFromUrl('type', window.location.toString());
    (function () {
        if (type === "dep") {
            $(".container-fluid > h1").text("Реєстр виплат компенсаційних вкладів");
        }
        else if (type === "bur") {
            $(".container-fluid > h1").text("Реєстр виплат на поховання");
        }
    })();

    var validator = $("#periodForm").kendoValidator().data("kendoValidator");
    registerGrids.initGrid();
    $("#backActual").hide();

    //формує об'єкт з дат на формі
    var serializeForm = function () {
        var values = {};
        $.each($('#periodForm').serializeArray(), function (i, field) {
            values[field.name] = field.value;
        });
        values.type = type;
        values.check = false;
        if ($("#showall").is(":checked")) {
            values.check = true;
        }
        return values;
    }

    var actionWithDepo = function (url, data) {
        bars.ui.loader("body", true);
        $.ajax({
            url: url,
            data: data,
            dataType: "JSON",
            type: "POST",
            success: function (result) {
                bars.ui.loader("body", false);
                //debugger;
                if (typeof result === "object") {
                    $("#backActual").show();
                    $("#backActual").data("kendoGrid").dataSource.data(result.ListOfDepos);
                    $('#backActual').data('kendoGrid').refresh();
                    if (result.Amount >= 0 || result.Count >= 0) {
                        bars.ui.notify("Увага!", "Платежі сформовано на суму " + result.Amount + " та в кількості " + result.Count, "success");
                    }
                } else {
                    var flag = result.includes("ORA");
                    if (flag) {
                        error.window(result);
                    } else {
                        bars.ui.notify("Увага!", "Сталася помилка!", "error");
                    }
                }
            },
            error: function (result) {
                bars.ui.loader("body", false);
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    }

    $('#showall').change(function () {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/pay/onlyplandepos"),
            data: serializeForm(),
            dataType: "JSON",
            type: "POST",
            success: function (result) {
                if (result !== null) {
                    $("#backActual").show();
                    $("#backActual").data("kendoGrid").dataSource.data(result);
                }
            },
            error: function (result) {
                bars.ui.loader("body", false);
                bars.ui.error("Сталася помилка " + result.text);
            }
        });
    });

    $("#regPay").click(function (event) {
        if (validator.validate()) {
            event.preventDefault();
            bars.ui.confirm({ text: "Виконати формування реєстру?" }, function () {
                actionWithDepo(bars.config.urlContent("/api/crkr/pay/createreg"), serializeForm());
            });
        }
    });

    $("#sendPay").click(function (event) {
        if (validator.validate()) {
            event.preventDefault();
            var values = serializeForm();
            values.preRequest = true;
            //спочатку визначаємо загальну суму та кількість платежів
            $.ajax({
                url: bars.config.urlContent("/api/crkr/pay/sendpay"),
                data: values,
                dataType: "JSON",
                type: "POST",
                success: function (model) {
                    bars.ui.confirm({ text: "Виконати формування платежів на суму " + model.Amount + " та в кількості " + model.Count + "?" }, function () {
                        values.preRequest = false;
                        //формуємо платежі
                        actionWithDepo(bars.config.urlContent("/api/crkr/pay/sendpay"), values);
                    });

                },
                error: function (result) {
                    bars.ui.loader("body", false);
                    bars.ui.error({ title: "Сталася помилка", text: result.text });
                }
            });
        }
    });

    var getDepoForBlockUnBlock = function (isBlock) {
        var idsToSend = [];
        var grid = $("#backActual").data("kendoGrid");
        var ds = grid.dataSource.view();

        for (var i = 0; i < ds.length; i++) {
            var row = grid.table.find("tr[data-uid='" + ds[i].uid + "']");
            var checkbox = $(row).find(".checkbox");

            if (checkbox.is(":checked")) {
                idsToSend.push(ds[i].ID);
            }
        }
        if (idsToSend.length > 0) {
            var values = {};
            $.each($('#periodForm').serializeArray(), function (i, field) {
                values[field.name] = field.value;
            });
            values.type = type;
            values.id = idsToSend;
            values.block = isBlock;
            return values;
        }
        else {
            bars.ui.notify("Увага!", "Оберіть хоча б один запис", "error");
        }
    }

    var requestForBlockUnBlock = function (isBlock) {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/pay/blockunblockpay"),
            data: getDepoForBlockUnBlock(isBlock),
            dataType: "JSON",
            type: "POST",
            success: function (result) {
                $('#backActual').data('kendoGrid').dataSource.data(result.ListOfDepos);
                $('#backActual').data('kendoGrid').refresh();
                bars.ui.alert({ title: "Увага!", text: result.Info });
            },
            error: function (result) {
                bars.ui.error({ title: "Сталася помилка", text: result.text });
            }
        });
    }

    $(".k-grid-blockPay").click(function () {
        bars.ui.confirm({ text: "Виконати блокування реєстру?" }, function () {
            requestForBlockUnBlock(true);
        });
    });

    $(".k-grid-unblockPay").click(function () {
        bars.ui.confirm({ text: "Виконати розблокування реєстру?" }, function () {
            requestForBlockUnBlock(false);
        });
    });

    $("#backActual").find('#checkAll').on('change', function () {
        var grid = $("#backActual");
        var checkedRows = grid.find('input[type="checkbox"][name="checkRow"]');
        var $this = $(this);
        if ($this.is(':checked')) {
            checkedRows.prop("checked", true);
        } else {
            checkedRows.prop("checked", false);
        }
    });

    var getStatisic = function () {
        $.ajax({
            url: bars.config.urlContent("/api/crkr/pay/statistic"),
            dataType: "JSON",
            type: "GET",
            data: { type: type },
            success: function (result) {
                $("#compenAll").text(result.compenAll);
                $("#actAll").text(result.actAll);
                $("#actReg").text(result.actReg);
                $("#compenReg").text(result.compenReg);
                $("#compenNew").text(result.compenNew);
                $("#stateNew").text(result.stateNew);
                $("#stateFormed").text(result.stateFormed);
                $("#statePayed ").text(result.statePayed);
                $("#stateBlock").text(result.stateBlock);
                $("#dateFirst").text(result.dateFirst);
                $("#dateLast").text(result.dateLast);
            },
            error: function (result) {
                bars.ui.error({ title: "Сталася помилка", text: result.text });
            }
        });

    };

    $(".k-grid-addEmail").click(function () {
        getStatisic();
        $("#infoWindow").data("kendoWindow").center().open();
    });

    //вікно статистики
    (function () {
        var window = $("#infoWindow");

        function onClose() {
            window.fadeIn();
        }
        window.kendoWindow({
            width: "500px",
            title: "Інофрмація та статистика",
            resizable: false,
            visible: false,
            modal: true,
            actions: [
                "Close"
            ],
            close: onClose
        });
    })();

    //bocouse ie8
    if (!String.prototype.includes) {
        // ReSharper disable once NativeTypePrototypeExtending
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }
});