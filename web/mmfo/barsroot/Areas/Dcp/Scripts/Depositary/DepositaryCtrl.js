angular.module('BarsWeb.Controllers', [])
.controller('DepositaryCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {
    $scope.fn = "";
    $scope.update = false;
    $scope.Init = function (nMode, nPar) {
        $scope.Mode = nMode;
        var currentdate = new Date();
        var cur_date = kendo.toString(kendo.parseDate(currentdate, 'yyyy-MM-dd'), 'dd/MM/yyyy');

        date = new Date();
        angular.element("#cur_time").val(getFullTime(date));

        $scope.tickInterval = 1000;

        var tick = function () {
            date = new Date();
            angular.element("#cur_time").val(getFullTime(date))
            $timeout(tick, $scope.tickInterval);
        }

        $timeout(tick, $scope.tickInterval);

        angular.element("#cur_date").val(cur_date);
        $scope.nPar = nPar;
        if (parseInt(nPar) === 1) {
            angular.element("#btnOpl").kendoButton({ enable: false });
            angular.element("#btnDelete").kendoButton({ enable: false });
            angular.element("#btnDetails").kendoButton({ enable: false });
        }
        else if (parseInt(nPar) === 2) {
            angular.element("#btnRef").kendoButton({ enable: false });
        }

        $.ajax({
            url: bars.config.urlContent("/api/Dcp/DepositaryApi/GetVob"),
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        $scope.vob1 = data[0];
                        $scope.vob2 = data[1];
                    }
        });
    }

    getFullTime = function (date) {
        hours = date.getHours();
        minutes = date.getMinutes();
        seconds = date.getSeconds();
        if (hours.toString().length < 2)
            hours = "0" + hours.toString();
        if (minutes.toString().length < 2)
            minutes = "0" + minutes.toString();
        if (seconds.toString().length < 2)
            seconds = "0" + seconds.toString();
        return hours + ":" + minutes + ":" + seconds;
    };

    $scope.mainGridOptions = {
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/Dcp/DepositaryApi/GetGridData"),
                    data: function () {
                        return { nPar: $scope.nPar, fn: $scope.fn }
                    }
                }
            },
            serverPaging: true,
            serverFiltering: true,
            serverSortering: true,
            pageSize: 13,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        MFOA: {
                            type: 'string',
                            editable: false
                        },
                        MDOA: {
                            type: 'string',
                            editable: false
                        },
                        NLSA: {
                            type: 'string',
                            validation: {
                                NLSAvalidation: function (input) {
                                    if (input.is("[name='NLSA']")) {
                                        var grid = $("#mainGrid").data("kendoGrid");
                                        var selectedItem = grid.dataItem(grid.select());
                                        if (selectedItem.REF == null)
                                            GetDataByNLS(input.val(), selectedItem.ID, selectedItem.OKPOA, selectedItem.uid);
                                    }
                                    return true;
                                }
                            }
                        },
                        NAMA: {
                            type: 'string',
                            editable: false
                        },
                        MFOB: {
                            type: 'string',
                            editable: false
                        },
                        MDOB: {
                            type: 'string',
                            editable: false
                        },
                        NLSB: {
                            type: 'string',
                            editable: false
                        },
                        OKPOB: {
                            type: 'string',
                            editable: false
                        },
                        S: {
                            type: 'number',
                            editable: false
                        },
                        ID_UG: {
                            type: 'string',
                            editable: false
                        },
                        DAT_UG: {
                            type: 'date',
                            editable: false
                        },
                        OZN_SP: {
                            type: 'string',
                            editable: false
                        },
                        FN: {
                            type: 'string',
                            editable: false
                        },
                        NAMB: {
                            type: 'string'
                        },
                        ACC: {
                            type: 'number',
                            editable: false
                        },
                        ID: {
                            type: 'number',
                            editable: false
                        },
                        REF: {
                            type: 'number',
                            editable: false
                        },
                        OKPOA: {
                            type: 'string',
                            editable: false
                        },
                        N_UG: {
                            type: 'string',
                            editable: false
                        },
                        D_UG: {
                            type: 'date',
                            editable: false
                        },
                        NAZN: {
                            type: 'string',
                            editable: false
                        },
                        RESERV: {
                            type: 'string',
                            editable: false
                        },
                        ND: {
                            type: "string"
                        },
                        VOB_NAME: {
                            type: "string",
                            editable: false
                        }
                    }
                }
            }
        },
        dataBound: function () {
            grid = $("#mainGrid").data("kendoGrid");
            data = grid.dataSource.data;
            if (parseInt($scope.nPar) === 1) {
                grid.hideColumn("REF");
                grid.hideColumn("NLSA");
                grid.hideColumn("NAMA");
            }
        },
        selectable: "row",
        columns: [
                    {
                        field: "REF",
                        title: "Реф.",
                        width: "85px"
                    },
                    {
                        field: "ND",
                        title: "№ Документа",
                        width: "120px"
                    },
                    {
                        field: "VOB_NAME",
                        title: "Вид док.",
                        width: "85px"
                    },
                    {
                        field: "VOB",
                        title: "Вид док.",
                        width: "85px",
                        hidden: true
                    },
                    {
                        field: "MDOA",
                        title: "МДО А",
                        width: "85px"
                    },
                    {
                        field: "NLSA",
                        title: "Рахунок А",
                        width: "105px"
                    },
                    {
                        field: "NAMA",
                        title: "Платник",
                        width: "150px"
                    },
                    {
                        field: "OKPOA",
                        title: "ОКПО А",
                        width: "95px"
                    },
                    {
                        field: "MFOB",
                        title: "МФО Б",
                        width: "87px"
                    },
                    {
                        field: "MDOB",
                        title: "МДО Б",
                        width: "85px"
                    },
                    {
                        field: "NLSB",
                        title: "Рахунок Б",
                        width: "105px"
                    },
                    {
                        field: "NAMB",
                        title: "Отримувач",
                        width: "250px"
                    },
                    {
                        field: "OKPOB",
                        title: "ОКПО Б",
                        width: "95px"
                    },
                    {
                        field: "S",
                        title: "Сума пл.",
                        width: "135px"
                    },
                    {
                        field: "NAZN",
                        title: "Призначення пл.",
                        width: "250px"
                    },
                    {
                        field: "ID_UG",
                        title: "Номер оплати",
                        width: "100px"
                    },
                    {
                        field: "DAT_UG",
                        title: "Дата розр.",
                        template: "#= kendo.toString(kendo.parseDate(DAT_UG, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: "100px"
                    },
                    {
                        field: "N_UG",
                        title: "Номер угоди",
                        width: "120px"
                    },
                    {
                        field: "D_UG",
                        title: "Дата угоди",
                        template: "#= kendo.toString(kendo.parseDate(D_UG, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: "100px"
                    },
                    {
                        field: "FN",
                        title: "Файл &P",
                        width: "110px"
                    },
                    {
                        field: "ID",
                        title: "Ід",
                        hidden: true
                    }
        ],
        sortable: true,
        filterable: true,
        pageable: true,
        editable: true
    }

    GetDataByNLS = function (nls, id, okpo, uid) {
        $.ajax({
            url: bars.config.urlContent("/api/Dcp/DepositaryApi/GetDataByNLS") + "?nls=" + nls + "&id=" + id + "&okpo=" + okpo,
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        var grid = $("#mainGrid").data("kendoGrid");
                        grid.dataItem(grid.table.find("tr[data-uid='" + uid + "']")).ACC = data.ACC;
                        grid.dataItem(grid.table.find("tr[data-uid='" + uid + "']")).OKPOA = data.OKPO;
                        grid.dataItem(grid.table.find("tr[data-uid='" + uid + "']")).NAMA = data.NAM;
                    }
        });
    }

    GetVob = function (mfoa, mfob) {
        if (mfoa === mfob)
            return $scope.vob1.VOB_NAME;
        else
            return $scope.vob2.VOB_NAME;
    }

    $scope.archGridOptions = {
        autoBind: false,
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/Dcp/DepositaryApi/GetArchGridData"),
                }
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
                        MFOA: {
                            type: 'string'
                        },
                        MDOA: {
                            type: 'string'
                        },
                        MFOB: {
                            type: 'string'
                        },
                        MDOB: {
                            type: 'string'
                        },
                        NLSB: {
                            type: 'string'
                        },
                        OKPOB: {
                            type: 'string'
                        },
                        S: {
                            type: 'number'
                        },
                        ID_UG: {
                            type: 'string',
                        },
                        DAT_UG: {
                            type: 'date'
                        },
                        OZN_SP: {
                            type: 'string'
                        },
                        FN: {
                            type: 'string',
                        },
                        NAMB: {
                            type: 'string'
                        },
                        ACC: {
                            type: 'number'
                        },
                        ID: {
                            type: 'number',
                        },
                        REF: {
                            type: 'number'
                        },
                        OKPOA: {
                            type: 'string'
                        },
                        N_UG: {
                            type: 'string',
                        },
                        D_UG: {
                            type: 'date'
                        },
                        NAZN: {
                            type: 'string'
                        }
                    }
                }
            }
        },
        selectable: "row",
        columns: [
                    {
                        field: "REF",
                        title: "Реф.",
                        width: "95px",
                        template: '<a style="color: blue" ng-click="ViewDoc(${REF})">{{ GetRefTemplate(dataItem.REF) }}</a>'
                    },
                    {
                        field: "MDOA",
                        title: "МДО А",
                        width: "85px"
                    },
                    {
                        field: "OKPOA",
                        title: "ОКПО А",
                        width: "95px"
                    },
                    {
                        field: "MFOB",
                        title: "МФО Б",
                        width: "87px"
                    },
                    {
                        field: "MDOB",
                        title: "МДО Б",
                        width: "85px"
                    },
                    {
                        field: "NLSB",
                        title: "Рахунок Б",
                        width: "105px"
                    },
                    {
                        field: "NAMB",
                        title: "Отримувач",
                        width: "250px"
                    },
                    {
                        field: "OKPOB",
                        title: "ОКПО Б",
                        width: "95px"
                    },
                    {
                        field: "S",
                        title: "Сума пл",
                        width: "135px"
                    },
                    {
                        field: "NAZN",
                        title: "Призначення платежу",
                        width: "85px"
                    },
                    {
                        field: "ID_UG",
                        title: "Номер оплати",
                        width: "85px"
                    },
                    {
                        field: "DAT_UG",
                        title: "Дата розр.",
                        template: "#= kendo.toString(kendo.parseDate(DAT_UG, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: "85px"
                    },
                    {
                        field: "N_UG",
                        title: "Номер угоди",
                        width: "85px"
                    },
                    {
                        field: "D_UG",
                        title: "Дата угоди",
                        template: "#= kendo.toString(kendo.parseDate(D_UG, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                        width: "85px"
                    },
                    {
                        field: "FN",
                        title: "Файл &P",
                        width: "110px"
                    }
        ],
        sortable: true,
        filterable: true,
        pageable: true
    }

    $scope.GetRefTemplate = function (ref) {
        if (ref)
            return ref;
        else
            return '';
    }

    $scope.ViewDoc = function (ref) {
        bars.ui.dialog({
            content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + ref,
            iframe: true,
            height: document.documentElement.offsetHeight * 0.8,
            width: document.documentElement.offsetWidth * 0.8
        });
    }

    $scope.OpenArchive = function () {
        $scope.winArch.maximize().open();
        angular.element("#archGrid").data("kendoGrid").dataSource.read();
    }

    $scope.AcceptFile = function () {
        $.ajax({
            url: bars.config.urlContent("/api/Dcp/DepositaryApi/CheckFile"),
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        $scope.fn = data.fn;
                        $scope.update = data.update;
                        if ($scope.update) {
                            $scope.winConfirm.center().open();
                        }
                        else {
                            $.ajax({
                                url: bars.config.urlContent("/api/Dcp/DepositaryApi/AcceptFile") + "?update=" + $scope.update,
                                method: "GET",
                                dataType: "json",
                                async: false,
                                success:
                                        function (data) {
                                            bars.ui.success({ text: "ДЦП. Файл " + data.fn + " успішно прийнятий." })
                                            $('#mainGrid').data('kendoGrid').dataSource.read();
                                        }
                            });
                        }
                    }
        });
    }

    $scope.ReAccept = function () {
        $scope.winConfirm.close();
        $.ajax({
            url: bars.config.urlContent("/api/Dcp/DepositaryApi/CheckStorno"),
            method: "GET",
            dataType: "json",
            async: false,
            success:
                    function (data) {
                        if (data) {
                            $scope.winConfirmStorno.center().open();
                        }
                        else {
                            $.ajax({
                                url: bars.config.urlContent("/api/Dcp/DepositaryApi/AcceptFile") + "?update=" + $scope.update,
                                method: "GET",
                                dataType: "json",
                                async: false,
                                success:
                                        function (data) {
                                            bars.ui.success({ text: "ДЦП. Файл " + $scope.fn + " повторно прийнятий." })
                                            $('#mainGrid').data('kendoGrid').dataSource.read();
                                        }
                            });
                        }
                    }
        });
    }

    $scope.Pay = function () {
        debugger;
        data = $("#mainGrid").data("kendoGrid").dataSource.data();
        if (data.length > 0) {
            $.ajax({
                url: bars.config.urlContent("/api/Dcp/DepositaryApi/Pay"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify(data),
                contentType: "application/json",
                async: false,
                success:
                        function (data) {
                            bars.ui.success({ text: "Операція успішна.</br>Документ оплачено." });
                            $("#mainGrid").data("kendoGrid").dataSource.read();
                        }
            });
        }
        else
            bars.ui.alert({ text: "Документи для оплати відсутні." });
    }

    $scope.Details = function () {
        var grid = $("#archGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null) {
            if (selectedItem.REF != null) {
                bars.ui.dialog({
                    content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + selectedItem.REF,
                    iframe: true,
                    height: document.documentElement.offsetHeight * 0.8,
                    width: document.documentElement.offsetWidth * 0.8
                });
            }
            else {
                bars.ui.alert({ text: "Референс пустий. </br>Оплатіть файл." }); v
            }
        }
        else {
            bars.ui.alert({ text: "Оберіть стрічку." });
        }
    }

    $scope.DeleteRow = function () {
        var grid = $("#mainGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null) {
            if (selectedItem.REF === null) {
                $.ajax({
                    url: bars.config.urlContent("/api/Dcp/DepositaryApi/DeleteRow") + "?id=" + selectedItem.ID,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    success:
                            function (data) {
                                bars.ui.success({ text: "Стрічку успішно видалено." });
                                $("#mainGrid").data("kendoGrid").dataSource.read();
                            }
                });
            }
            else {
                bars.ui.alert({ text: "Референс не пустий.</br>Файл оплачено.</br>Неможливо видалити." }); v
            }
        }
        else {
            bars.ui.alert({ text: "Оберіть стрічку." });
        }
    }

    $scope.ReloadGrid = function () {
        $("#mainGrid").data("kendoGrid").dataSource.read();
    }

    $scope.reasonsGridOptions = {
        autoBind: false,
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/Dcp/DepositaryApi/GetBPReasons"),
                }
            },
            serverFiltering: true,
            serverSortering: true,
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: {
                            type: 'number'
                        },
                        REASON: {
                            type: 'string'
                        }
                    }
                }
            }
        },
        selectable: "row",
        columns: [
                    {
                        field: "ID",
                        title: "Код",
                        width: "85px"
                    },
                    {
                        field: "REASON",
                        title: "Причина",
                        width: "200px"
                    }
        ],
        filterable: true,
        scrollable: true,
        height: 400
    }

    $scope.ChooseReason = function () {
        $scope.winConfirmStorno.close()
        $("#reasonsGrid").data("kendoGrid").dataSource.read();
        $("#winReason").parent().find(".k-window-action").css("visibility", "hidden");
        $scope.winReason.center().open();
    }

    $scope.Storno = function () {
        var grid = $("#reasonsGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null)
        {
            $scope.winReason.close();
            $.ajax({
                url: bars.config.urlContent("/api/Dcp/DepositaryApi/Storno") + "?reasonid=" + selectedItem.ID + "&fn=" + $scope.fn.substring(1, 12),
                method: "GET",
                dataType: "json",
                async: false,
                success:
                        function (data) {
                            if (data.STATUS.toUpperCase() !== "OK")
                                bars.ui.error({ text: data.MESSAGE });
                            else
                            {
                                $.ajax({
                                    url: bars.config.urlContent("/api/Dcp/DepositaryApi/AcceptFile") + "?update=" + $scope.update,
                                    method: "GET",
                                    dataType: "json",
                                    async: false,
                                    success:
                                            function (data) {
                                                bars.ui.success({ text: "ДЦП. Файл " + $scope.fn + " повторно прийнятий." })
                                                $('#mainGrid').data('kendoGrid').dataSource.read();
                                            }
                                });
                            }  
                        }
            });
        }
        else {
            bars.ui.alert({ text: "Оберіть причину." });
        }
    }

    $scope.CancelStorno = function () {
        $scope.winReason.close();
        bars.ui.error({text: "Файл " + $scope.fn + " не прийнято!" });
    }

    $scope.SavePrintGrid = function (par) {
        $scope.printpar = par;
        $scope.SaveGridWindow.center().open();
    }

    $scope.SaveFileAs = function () {
        $scope.SaveGridWindow.close();
        var option = angular.element("#export").find("input:checked").val();
        if ($("#mainGrid").data("kendoGrid").dataSource.data().length !== 0) {
            window.open("/barsroot/Dcp/Depositary/SaveFile" + "?par=" + $scope.printpar + "&save_type=" + option);
        }
        else
            bars.ui.error({ text: "Наповніть таблицю" });
    };
}]);