angular.module('BarsWeb.Controllers', [])
.controller('AddRequisitesCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.Init = function () {
        angular.element("#btnDebet").kendoButton({ enable: true });
        angular.element("#btnCredit").kendoButton({ enable: true });
        angular.element("#btnDebetCredit").kendoButton({ enable: false });
        $scope.dc = "Всі документи";
        $scope.bankdate = kendo.toString(kendo.parseDate(new Date(AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetBankDate"))), 'yyyy-MM-dd'), 'dd/MM/yyyy');
        $scope.params = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetParams") + "?date=" + $scope.bankdate);
        $scope.TEXT_B_list = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetText") + "?name=" + "TEX_B");
        $scope.TEXT_N_list = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetText") + "?name=" + "TEX_N");
        $scope.TEXT_G_list = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetText") + "?name=" + "TEX_G");
    };
    function AjaxGetFunction(url) {
        var response_data = {};
        $.ajax({
            url: url,
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        response_data = data;
                    }
        });
        return response_data;
    };


    $scope.reload = function () {
        $scope.mainGrid.dataSource.read();
    }

    angular.element("#btnDebet").click(function () {
        $scope.dc = "Тільки дебет"
        angular.element("#btnDebet").data("kendoButton").enable(false);
        angular.element("#btnCredit").removeAttr("disabled").data("kendoButton").enable(true);
        angular.element("#btnDebetCredit").removeAttr("disabled").data("kendoButton").enable(true);
        angular.element("#mainGrid").data("kendoGrid").dataSource.read();
    });

    angular.element("#btnCredit").click(function () {
        $scope.dc = "Тільки кредит"
        angular.element("#btnCredit").data("kendoButton").enable(false);
        angular.element("#btnDebet").data("kendoButton").enable(true);
        angular.element("#btnDebetCredit").data("kendoButton").enable(true);
        angular.element("#mainGrid").data("kendoGrid").dataSource.read();
    });

    angular.element("#btnDebetCredit").click(function () {
        $scope.dc = "Всі документи"
        angular.element("#btnDebetCredit").data("kendoButton").enable(false);
        angular.element("#btnCredit").data("kendoButton").enable(true);
        angular.element("#btnDebet").data("kendoButton").enable(true);
        angular.element("#mainGrid").data("kendoGrid").dataSource.read();
    });

    $scope.mainGridOptions = {
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pb1/addRequisitesApi/GetGridData"),
                    data: function () {
                        if ($scope.dc === "Тільки дебет")
                            DC = 'D';
                        else if ($scope.dc === "Тільки кредит")
                            DC = 'C'
                        else if ($scope.dc === "Всі документи")
                            DC = 'DC'
                        return {
                            dc: DC, date: $scope.bankdate
                        };
                    }
                }
            },
            requestStart: function () {
                $("#mydiv").show();
            },
            requestEnd: function () {
                $("#mydiv").hide();
            },
            serverPaging: true,
            serverFiltering: true,
            serverSortering: true,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        NLS: {
                            type: 'string',
                            editable: false
                        },
                        KV: {
                            type: 'string',
                            editable: false
                        },
                        DC: {
                            type: 'string',
                            editable: false
                        },
                        ND: {
                            type: 'string',
                            editable: false
                        },
                        S: {
                            type: 'string',
                            editable: false
                        },
                        KOD_N: {
                            type: 'string',
                            editable: true,
                            validation: {
                                KOD_Nvalidation: function (input) {
                                    var OnlyNumbers = /[0-9]/;
                                    if (input.is("[name='KOD_N']")) {
                                        if (!input.val().match(OnlyNumbers) && input.val() !== "") {
                                            input.attr("data-KOD_Nvalidation-msg", "Повинно бути числом");
                                            return false;
                                        }
                                        else {
                                            var grid = $("#mainGrid").data("kendoGrid");
                                            var selectedItem = grid.dataItem(grid.select());
                                            if (parseInt(input.val()) !== parseInt(selectedItem.TEX_N)) {
                                                if (GetText(input.val(), 'TEX_N') !== "")
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_N = input.val();
                                                else
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_N = "";
                                                $("#mainGrid > div.k-grid-content > table > tbody > tr[data-uid='" + selectedItem.uid + "'] > td:nth-child(7)").text(GetText(input.val(), 'TEX_N'));
                                            }
                                        }
                                    }
                                    return true;
                                }
                            }
                        },
                        TEX_N: {
                            type: 'string',
                            editable: true
                        },
                        DC1: {
                            type: 'string',
                            editable: false
                        },
                        KOD_G: {
                            type: 'string',
                            editable: true,
                            validation: {
                                KOD_Gvalidation: function (input) {
                                    var OnlyNumbers = /[0-9]/;
                                    if (input.is("[name='KOD_G']")) {
                                        if (!input.val().match(OnlyNumbers) && input.val() !== "") {
                                            input.attr("data-KOD_Gvalidation-msg", "Повинно бути числом");
                                            return false;
                                        }
                                        else {
                                            var grid = $("#mainGrid").data("kendoGrid");
                                            var selectedItem = grid.dataItem(grid.select());
                                            if (parseInt(input.val()) !== parseInt(selectedItem.TEX_G)) {
                                                if (GetText(input.val(), 'TEX_G') !== "")
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_G = input.val();
                                                else
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_G = "";
                                                $("#mainGrid > div.k-grid-content > table > tbody > tr[data-uid='" + selectedItem.uid + "'] > td:nth-child(10)").text(GetText(input.val(), 'TEX_G'));
                                            }
                                        }
                                    }
                                    return true;
                                }
                            }
                        },
                        TEX_G: {
                            type: 'string',
                            editable: true
                        },
                        KOD_B: {
                            type: 'string',
                            editable: true,
                            validation: {
                                KOD_Bvalidation: function (input) {
                                    var OnlyNumbers = /[0-9]/;
                                    if (input.is("[name='KOD_B']")) {
                                        if (!input.val().match(OnlyNumbers) && input.val() !== "") {
                                            input.attr("data-KOD_Bvalidation-msg", "Повинно бути числом");
                                            return false;
                                        }
                                        else {
                                            var grid = $("#mainGrid").data("kendoGrid");
                                            var selectedItem = grid.dataItem(grid.select());
                                            if (parseInt(input.val()) !== parseInt(selectedItem.TEX_B)) {
                                                if (GetText(input.val(), 'TEX_B') !== "")
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_B = input.val();
                                                else
                                                    grid.dataItem(grid.table.find("tr[data-uid='" + selectedItem.uid + "']")).TEX_B = "";
                                                $("#mainGrid > div.k-grid-content > table > tbody > tr[data-uid='" + selectedItem.uid + "'] > td:nth-child(12)").text(GetText(input.val(), 'TEX_B'));
                                            }
                                        }
                                    }
                                    return true;
                                }
                            }
                        },
                        TEX_B: {
                            type: 'string',
                            editable: true
                        },
                        SQ: {
                            type: 'number',
                            editable: false
                        }

                    }
                }
            }
        },
        dataBound: function (e) {
            angular.element("div.k-grid-content")[0].style.maxHeight = String.format("{0}px", document.documentElement.offsetHeight * 0.53);
            grid = $("#mainGrid").data("kendoGrid");
            val = $("#mainGrid").find("tbody>tr")[0];
            grid.select(val)
            gridData = grid.dataSource.data();
            var rows = e.sender.tbody.children();
            for (var i = 0; i < gridData.length; i++) {
                var row = $(rows[i]);
                if (gridData[i].KOD_N !== null && (typeof gridData[i].KOD_N !== "undefined") && gridData[i].KOD_G !== null && (typeof gridData[i].KOD_G !== "undefined"))
                {
                    if (gridData[i].KOD_N.toString().substring(1, 5) === "8447"
                       && gridData[i].KOD_G.toString().substring(1, 4) !== "804"
                       && gridData[i].KOD_G.toString().substring(1, 4) !== "UKR") {
                        row.children().eq(5).addClass("red");
                        row.children().eq(8).addClass("red");
                    }
                }
                if (gridData[i].KOD_N !== null && (typeof gridData[i].KOD_N !== "undefined")) {
                    if (gridData[i].SQ >= $scope.params.POROG && gridData[i].KOD_N.toString().substring(1, 5) !== "8444") {
                        if ($scope.params.NBU === "1" && gridData[i].NBSK === 35 || $scope.params.NBU === "0" && gridData[i].NBSK === 26) {
                            row.addClass("lightgreen");
                        }
                        else if ($scope.params.NBU === "0" && (gridData[i].NBSK === 16 || gridData[i].NBSK === 39)) {
                            row.addClass("green");
                        }
                    }
                }
                if ((gridData[i].DC === "C" && gridData[i].DC1 === "D") || (gridData[i].DC1 === "C" && gridData[i].DC === "D")) {
                    row.children().eq(7).addClass("red");
                }
            }
            if (grid.dataSource.data().length < 1) {
                angular.element("#ref").val("");
                angular.element("#tt").val("");
                angular.element("#stt").val("");
                angular.element("#nlsa").val("");
                angular.element("#kva").val("");
                angular.element("#nama").val("");
                angular.element("#nlsb").val("");
                angular.element("#kvb").val("");
                angular.element("#namb").val("");
                angular.element("#nazn").val("");
            }
            if (grid.dataSource.data().length > 0)
            {
                var pageInfo = this.pager.element.find(".k-pager-info");
                setTimeout(function () {
                    pageInfo.text("Зображено записів - " + grid.dataSource.data().length);
                });
            }

        },
        change: function () {
            var grid = $("#mainGrid").data("kendoGrid");
            var selectedItem = grid.dataItem(grid.select());
            if (selectedItem != null) {
                angular.element("#ref").val(selectedItem.REF);
                angular.element("#tt").val(selectedItem.TT);
                angular.element("#stt").val(selectedItem.STT);
                angular.element("#nlsa").val(selectedItem.NLSA);
                angular.element("#kva").val(selectedItem.KVA);
                angular.element("#nama").val(selectedItem.NAMA);
                angular.element("#nlsb").val(selectedItem.NLSB);
                angular.element("#kvb").val(selectedItem.KVB);
                angular.element("#namb").val(selectedItem.NAMB);
                angular.element("#nazn").val(selectedItem.NAZN.substring(0, 100));
            }
        },
        selectable: "row",
        columns: [
                    {
                        field: "NLS",
                        title: "ЛС",
                        width: "100px"
                    },
                    {
                        field: "KV",
                        title: "Вал",
                        width: "70px"
                    },
                    {
                        field: "DC",
                        title: "Д<br>К",
                        width: "50px"
                    },
                    {
                        field: "ND",
                        title: "№ док",
                        width: "95px"
                    },
                    {
                        field: "S",
                        title: "Сума проводки",
                        width: "140px",
                        attributes: { style: "text-align:right;" }
                    },
                    {
                        field: "KOD_N",
                        title: "Код НП",
                        width: "100px"
                    },
                    {
                        field: "TEX_N",
                        title: "Призначення платежу",
                        width: "200px",
                        editor: DropDownEditor,
                        template: '#: GetText(TEX_N, "TEX_N") #'
                    },
                    {
                        field: "DC1",
                        title: "D<br>C",
                        width: "50px"
                    },
                    {
                        field: "KOD_G",
                        title: "Код ГБ",
                        width: "80px"
                    },
                    {
                        field: "TEX_G",
                        title: "ДЕРЖАВА бенефіц. <br> Текст",
                        width: "110px",
                        editor: DropDownEditor,
                        template: '#: GetText(TEX_G, "TEX_G") #'
                    },
                    {
                        field: "KOD_B",
                        title: "Код БК",
                        width: "80px"
                    },
                    {
                        field: "TEX_B",
                        title: "БАНК-кориспондент Текст",
                        width: "100px",
                        editor: DropDownEditor,
                        template: '#: GetText(TEX_B, "TEX_B") #'
                    },
                    {
                        field: "SQ",
                        title: "ЕКВ",
                        width: "100px"
                    }
        ],
        sortable: true,
        filterable: true,
        scrollable: true,
        editable: true,
        pageable: true
    };

    function DropDownEditor(container, options) {
        data = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetText") + "?name=" + options.field);
        $('<input name="' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                filter: "contains",
                dataTextField: "TEXT",
                dataValueField: "VALUE",
                dataSource: {
                    data: data
                }
            });
    }

    GetText = function (value, field) {//value .id
        debugger;
        data = []
        if (field == "TEX_N")
            data = $scope.TEXT_N_list;
        else if (field == "TEX_G")
            data = $scope.TEXT_G_list;
        else if (field == "TEX_B")
            data = $scope.TEXT_B_list;

        if (value !== null && typeof (value) === 'object') {
            idvalue = value.VALUE
        }
        else
            idvalue = value

        for (var i = 0; i < data.length; i++) {
            if (parseInt(data[i].VALUE) === parseInt(idvalue)) {
                var grid = $("#mainGrid").data("kendoGrid");
                var selectedItem = grid.dataItem(grid.select());
		if(selectedItem) {
                if (field === "TEX_N")
                    selectedItem.KOD_N = idvalue;
                else if (field === "TEX_G")
                    selectedItem.KOD_G = idvalue;
                else if (field === "TEX_B")
                    selectedItem.KOD_B = idvalue;
                return data[i].TEXT;
		}
            }
        }
        if (value !== null && value.length > 0 && !parseInt(value))
            return value;
        else
            return "";
    };

    $scope.SavePrintGrid = function () {
        if ($("#mainGrid").data("kendoGrid").dataSource.data().length !== 0) {
            $scope.SaveGridWindow.center().open();
        }
        else
            bars.ui.alert({ text: "Наповніть таблицю" });
    };

    $scope.SaveFileAs = function () {
        $scope.SaveGridWindow.close();
        var option = angular.element("#export").find("input:checked").val();
        window.open("/barsroot/pb1/pb1/SaveFile" + "?par=" + $scope.printpar + "&save_type=" + option);

    };

    $scope.Details = function () {
        var grid = $("#mainGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null) {
            if (selectedItem.REF > 0) {
                bars.ui.dialog({
                    content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + selectedItem.REF,
                    iframe: true,
                    height: document.documentElement.offsetHeight * 0.8,
                    width: document.documentElement.offsetWidth * 0.8
                });
            }
            else {
                bars.ui.alert({ text: "Референс дорівнює 0." });
            }
        }
        else {
            bars.ui.alert({ text: "Оберіть стрічку." });
        }
    };

    $scope.Save = function () {
        var dataSource = $("#mainGrid").data("kendoGrid").dataSource,
        data = dataSource.data(),
        changedModels = [];
        if (dataSource.hasChanges) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].dirty) {
                    changedModels.push(data[i]);
                }
            }
        }
        $.ajax({
            url: bars.config.urlContent("/api/pb1/addRequisitesApi/SaveData"),
            method: "POST",
            dataType: "json",
            data: JSON.stringify(changedModels),
            contentType: "application/json",
            async: false,
            success:
                    function (data) {
                        bars.ui.success({ text: "Дані успішно збережені" });
                        $("#mainGrid").data("kendoGrid").dataSource.read();
                    }
        });
    }

    $("#mainGrid").on("dblclick", "tr.k-state-selected", function (e) {
        var grid = $("#mainGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
		loro_open = false;
        if (selectedItem.KOD_N !== null && (typeof selectedItem.KOD_N !== "undefined")) {
            if (selectedItem.SQ >= $scope.params.POROG && selectedItem.KOD_N.toString().substring(1, 5) !== "8444") {
                if ($scope.params.NBU === "1" && selectedItem.NBSK === 35 || $scope.params.NBU === "0" && selectedItem.NBSK === 26) {
					loro_open = true;
                }
                else if ($scope.params.NBU === "0" && (selectedItem.NBSK === 16 || selectedItem.NBSK === 39)) {
					loro_open = true;
                }
				if (loro_open)
				{
					loro_params = AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/GetLoroParams") + "?refer=" + selectedItem.REF);
                    angular.element("#okpo1").val(loro_params.OKPO);
                    angular.element("#name1").val(loro_params.NAME);
                    angular.element("#status1").val(loro_params.STATUS);
                    angular.element("#ref").val(selectedItem.REF.toString());
                    angular.element("#loroGrid").data("kendoGrid").dataSource.data([]);
                    angular.element("#loroGrid").data("kendoGrid").dataSource.read();
                    $scope.loroWin.center().open();
				}
            }
        }
    });

    $scope.loroGridOptions = {
        autoBind: false,
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pb1/addRequisitesApi/GetLoroBanks")
                }
            },
            requestStart: function () {
            },
            requestEnd: function () {
            },
            serverPaging: true,
            serverFiltering: true,
            serverSortering: true,
            pageSize: 15,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        OKPO: {
                            type: 'string',
                            editable: true,
                            validation: {
                                OKPOvalidation: function (input) {
                                    if (input.is("[name='OKPO']")) {
                                        if (input.val() !== AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/V_OKPO") + "?okpo=" + input.val())) {
                                            input.attr("data-okpovalidation-msg", "Помилка ОКПО");
                                            return false;
                                        }
                                    }
                                    return true;
                                }
                            }
                        },
                        NAME: {
                            type: 'string',
                            editable: true
                        },
                        STATUS: {
                            type: 'string',
                            editable: true,
                            validation: {
                                STATUSvalidation: function (input) {
                                    if (input.is("[name='STATUS']")) {
                                        if (input.val() !== "U" && input.val() !== "S" && input.val() !== "F") {
                                            input.attr("data-statusvalidation-msg", "Помилка статусу");
                                            return false;
                                        }
                                    }
                                    return true;
                                }
                            }
                        },
                        MFO: {
                            type: 'string',
                            editable: true
                        },
                        NB: {
                            type: 'string',
                            editable: false
                        },
                        IDROW: {
                            type: 'string',
                            editable: false
                        }
                    }
                }
            }
        },
        dataBound: function (e) {
        },
        selectable: "row",
        columns: [
                    {
                        field: "OKPO",
                        title: "ОКПО клієнта",
                        width: "110px"
                    },
                    {
                        field: "NAME",
                        title: "Найменування клієнта",
                        width: "170px"
                    },
                    {
                        field: "STATUS",
                        title: "Статус клієнта <br>(U, S, F)",
                        width: "110px"
                    },
                    {
                        field: "MFO",
                        title: "Код ЛОРО-банка",
                        width: "110px"
                    },
                    {
                        field: "NB",
                        title: "Найменування ЛОРО-банка",
                        width: "170px"
                    },
                    {
                        field: "IDROW",
                        title: "Id стрічки",
                        hidden: true
                    }
        ],
        sortable: true,
        filterable: true,
        pageable: true,
        scrollable: true,
        editable: {
            createAt: "top"
        }
    };

    $scope.AddRow = function () {
        var grid = angular.element("#loroGrid").data("kendoGrid");
        grid.addRow();
    }

    $scope.SaveLoro = function () {
        var dataSource = $("#loroGrid").data("kendoGrid").dataSource,
        data = dataSource.data(),
        changedModels = [];
        if (dataSource.hasChanges) {
            for (var i = 0; i < data.length; i++) {
                if (data[i].dirty) {
                    changedModels.push(data[i]);
                }
            }
        }
        $.ajax({
            url: bars.config.urlContent("/api/pb1/addRequisitesApi/SaveLoroData"),
            method: "POST",
            dataType: "json",
            data: JSON.stringify(changedModels),
            contentType: "application/json",
            async: false,
            success:
                    function (data) {
                        bars.ui.success({ text: "Дані успішно збережені" });
                        angular.element("#loroGrid").data("kendoGrid").dataSource.read();
                    }
        });
    }

    $scope.DeleteLoro = function () {
        var grid = $("#loroGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null) {
            if (AjaxGetFunction(bars.config.urlContent("/api/pb1/addRequisitesApi/DeleteLoroData") + "?okpo=" + selectedItem.OKPO) === "OK") {
                bars.ui.success({ text: "Дані успішно видалені" });
                angular.element("#loroGrid").data("kendoGrid").dataSource.read();
            }
        }
        else {
            bars.ui.alert({ text: "Оберіть стрічку." });
        }
    }

    $scope.OK = function () {
        var grid = $("#loroGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem !== null)
        {
            $.ajax({
                url: bars.config.urlContent("/api/pb1/addRequisitesApi/OK"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ model: selectedItem, refer: angular.element("#ref").val() }),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            angular.element("#loroGrid").data("kendoGrid").dataSource.read();
                        }
            });
        }
        $scope.loroWin.close();
    }

    $("#loroGrid").on("dblclick", "tr.k-state-selected", function (e) {
        $scope.OK();
    });
}]);