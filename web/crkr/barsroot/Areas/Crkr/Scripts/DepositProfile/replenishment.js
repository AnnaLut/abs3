$(document).ready(function () {
    var rnk = bars.extension.getParamFromUrl('rnk', window.location.toString());
    var herid = bars.extension.getParamFromUrl('herid', window.location.toString());//id вкладу з якого будуть списані кошти при оформленні спадщини

    $("#clientProfile").click(function () {
        if (rnk !== "") {
            window.location = bars.config.urlContent("/crkr/clientprofile/index?rnk=" + rnk + "&button=false");
        }
    });

    //Get info for current depo
    (function () {
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/crkr/depo/currentdepo"),
            data: { rnk: rnk },
            dataType: "JSON",
            success: function (result) {
                if (result !== null)
                    $("#fromDepo").val(result.NAME);
                else {
                    $("#fromDepo").val(localStorage.getItem("fullname"));
                    localStorage.clear();
                }
            },
            error: function () {
                bars.ui.notify({ text: "Виноикла помилка" });
            }
        });

        var model = {
            rnk: rnk,
            nsc: null,
            fio: null,
            id: herid
        };
        $.ajax({
            type: "GET",
            url: bars.config.urlContent("/api/crkr/depo/clientdepo"),
            data: model,
            dataType: "JSON",
            success: function (result) {
                debugger;
                loadGrid();
                $("#depoGrid").show();
                $("#depoGrid").data("kendoGrid").dataSource.data(result);
                $("#depoGrid").data("kendoGrid").select("tr:eq(0)");
            },
            error: function () {
                bars.ui.notify({ text: "Виникла помилка" });
            }
        });

    })();

    String.prototype.splice = function (idx, rem, str) {
        return this.slice(0, idx) + str + this.slice(idx + Math.abs(rem));
    };

    var validatorAdd = $("#addDepo").kendoValidator().data("kendoValidator");
    $("#add").click(function () {
        if (validatorAdd.validate()) {
            var model = {
                CompenId: herid,
                Rnk: rnk,
                Amount: $("#amount").val()
            };

            $.ajax({
                type: "POST",
                url: bars.config.urlContent("/api/crkr/depo/addmoney"),
                data: model,
                success: function (data) {
                    var flag = data.includes("ORA");
                    if (!flag) {
                        $("#searchBtn").click();
                        bars.ui.notify('Вклад поповнено', 'Відправлення на візування!', 'success');
                    } else {
                        var startPos = data.indexOf(':') + 1;
                        var endPos = data.indexOf('ORA', 2);
                        var textRes = data.substring(startPos, endPos);
                        bars.ui.notify("Увага!", textRes, "error");
                    }
                },
                error: function (result) {
                    bars.ui.alert({ text: "Error" + result });
                }
            });
        }
    });

    function onChange(arg) {
        var entityGrid = $("#depoGrid").data("kendoGrid");
        var data = entityGrid.dataSource.data();
        $("#toDepo").val(data[0].FIO);
        $("#amount").val(data[0].HERITAGE_OST);
        $("#persent").val("100");
    }

    function loadGrid() {

        $("#depoGrid").kendoGrid({
            resizable: true,
            autobind: false,
            selectable: "row",
            sortable: true,
            filterable: true,
            scrollable: true,
            change: onChange,
            pageable: {
                buttonCount: 5
            },
            columns: [
                { field: "ID", hidden: true },
                {
                    field: "KKNAME",
                    title: "Назва вкладу",
                    width: "11em",
                    headerAttributes: { style: "white-space: normal" },
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "NSC",
                    title: "Номер книжки",
                    headerAttributes: { style: "white-space: normal" },
                    width: "9em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "FIO",
                    title: "ПІБ Клієнта",
                    headerAttributes: { style: "white-space: normal" },
                    width: "16em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "REGISTRYDATE",
                    title: "Дата реєстрації",
                    template: "<div>#= kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy')==null? '':kendo.toString(kendo.parseDate(REGISTRYDATE),'dd.MM.yyyy') #</div>",
                    headerAttributes: { style: "white-space: normal" },
                    width: "8.2em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "DATO",
                    title: "Дата відкриття",
                    template: "<div>#= kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy')== null? '': kendo.toString(kendo.parseDate(DATO),'dd.MM.yyyy') #</div>",
                    headerAttributes: { style: "white-space: normal" },
                    width: "8em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                /*{
                    field: "DATN",
                    title: "Дата відкриття",
                    template: "<div>#= kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy') == null ? '' : kendo.toString(kendo.parseDate(DATN),'dd.MM.yyyy')  #</div>",
                    headerAttributes: { style: "white-space: normal" },
                    width: "8em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },*/
                {
                    field: "OST",
                    title: "Залишок",
                    width: "7.6em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "HERITAGE_OST",
                    title: "Залишок<br/>початковий",
                    width: "7.6em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "STATUS_NAME",
                    title: "Статус клієнта",
                    headerAttributes: { style: "white-space: normal" },
                    width: "8em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "BRANCH",
                    title: "Код відділення",
                    headerAttributes: { style: "white-space: normal" },
                    width: "14em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                },
                {
                    field: "BRANCHACT",
                    title: "Код відділення",
                    headerAttributes: { style: "white-space: normal" },
                    width: "10em",
                    filterable: {
                        cell: {
                            operator: "contains"
                        }
                    }
                }
            ],
            dataSource: {
                pageSize: 10,
                schema: {
                    model: {
                        fields: {
                            ID: { hidden: true },
                            KKNAME: { type: "string" },
                            NSC: { type: "string" },
                            FIO: { type: "string" },
                            REGISTRYDATE: { nullable: true, type: "string" },
                            DATO: { type: "string" },
                            DATN: { type: "string" },
                            SUM: { type: "string" },
                            OST: { type: "string" },
                            HERITAGE_OST: { type: "string" },
                            STATUS_NAME: { type: "string" },
                            BRANCH: { type: "string" },
                            BRANCHACT: { type: "string" }
                        }
                    }
                }
            }
        });
    }

    $("#persent").change(function () {
        var entityGrid = $("#depoGrid").data("kendoGrid");
        var data = entityGrid.dataSource.data();
        var percent = parseFloat($("#persent").val(), 10);
        var amount = parseFloat(data[0].HERITAGE_OST, 10);
        if (percent <= 100 && percent >= 0) {
            var newAmount = (Math.round(percent * amount * 100) / 10000).toFixed(2);
            //проверяем, чтобы найденная сумма не была больше остатка
            if (newAmount > data[0].OST)
            {
                newAmount = data[0].OST;
                percent = Math.round((data[0].OST * 100) / data[0].HERITAGE_OST);
                $("#persent").val(percent);
            }              
            $("#amount").val(newAmount);
        } else {
            bars.ui.notify("Увага!", "Відсоток в межах [0; 100]", "error");
        }
    });
    $("#amount").change(function () {
        $("#persent").val("");
    });

    //bocouse ie8
    if (!String.prototype.includes) {
        String.prototype.includes = function () {
            'use strict';
            return String.prototype.indexOf.apply(this, arguments) !== -1;
        };
    }
});