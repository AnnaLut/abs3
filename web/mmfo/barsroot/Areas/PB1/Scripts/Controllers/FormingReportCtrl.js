angular.module('BarsWeb.Controllers', [])
.controller('FormingReportCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.dropdowndata = AjaxGetFunction(bars.config.urlContent("/api/pb1/FormingReportApi/GetDropDownData"));
    var data_do = false;
    var date_do = "200001"
    $scope.Init = function () {
        $("#mydiv").hide();
        angular.element("#btnDocument").kendoButton({});
        $scope.params = AjaxGetFunction(bars.config.urlContent("/api/pb1/FormingReportApi/GetParams"));
        if ($scope.params.KOD_B === 30 || $scope.params.BANKTYPE === "AVAL")
            angular.element("#btnDocument").data("kendoButton").enable(false);
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

    $scope.OnChangeDate = function () {
        date_do = angular.element("#dropdownlist").val();
        angular.element("#mainGrid").data("kendoGrid").dataSource.read();
    };

    $scope.mainGridOptions = {
        autoBind: false,
        dataSource: {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pb1/FormingReportApi/GetGridData"),
                    data: function () {
                        return { D: date_do, KOD_B: $scope.params.KOD_B, data_do: data_do };
                    }
                }
            },
            requestStart: function () {
            },
            requestEnd: function () {
                data_do = false;
                $("#mydiv").hide();
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
                        DEN: {
                            type: 'string'
                        },
                        COUNKOD: {
                            type: 'string'
                        },
                        PARTN: {
                            type: 'string'
                        },
                        VALKOD: {
                            type: 'string'
                        },
                        NLS: {
                            type: 'string'
                        },
                        KRE: {
                            type: 'number'
                        },
                        DEB: {
                            type: 'number'
                        },
                        COUN: {
                            type: 'string',
                        },
                        KOD: {
                            type: 'string'
                        },
                        OPER: {
                            type: 'string'
                        },
                        BANK: {
                            type: 'string',
                        }
                    }
                }
            }
        },
        //dataBound: function(){
        //    if (angular.element("#mainGrid").data("kendoGrid").dataSource.data().length > 0)
        //        data_exist = true;
        //},
        selectable: "row",
        columns: [
                    {
                        field: "DEN",
                        title: "День",
                        width: "80px"
                    },
                    {
                        field: "COUNKOD",
                        title: "Країна КР",
                        width: "90px"
                    },
                    {
                        field: "PARTN",
                        title: "Назва КР",
                        width: "210px"
                    },
                    {
                        field: "VALKOD",
                        title: "ВАЛ КР",
                        width: "90px"
                    },
                    {
                        field: "NLS",
                        title: "КорРахунок",
                        width: "190px"
                    },
                    {
                        field: "KRE",
                        title: "КРД",
                        width: "190px"
                    },
                    {
                        field: "DEB",
                        title: "ДЕБ",
                        width: "190px"
                    },
                    {
                        field: "COUN",
                        title: "Країна бен",
                        width: "90px"
                    },
                    {
                        field: "KOD",
                        title: "Код призн",
                        width: "100px"
                    },
                    {
                        field: "OPER",
                        title: "Призначення пл.",
                        width: "420px"
                    },
                    {
                        field: "BANK",
                        title: "КБ",
                        width: "90px"
                    }
        ],
        sortable: true,
        filterable: true,
        pageable: true,
        scrollable: true
    };

    $scope.Run = function () {
        data_do = true;
        date_do = angular.element("#dropdownlist").val();
        if (angular.element("#mainGrid").data("kendoGrid").dataSource.data().length < 1)
            $("#mydiv").show();
        angular.element("#mainGrid").data("kendoGrid").dataSource.read();
    };

    $scope.Details = function () {
        var grid = $("#mainGrid").data("kendoGrid");
        var selectedItem = grid.dataItem(grid.select());
        if (selectedItem != null) {
            if (selectedItem.REFE > 0) {
                bars.ui.dialog({
                    content: bars.config.urlContent('/documentview/default.aspx') + '?ref=' + selectedItem.REFE,
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

    $scope.printDoc = function () {
        if ($("#mainGrid").data("kendoGrid").dataSource.data().length !== 0) {
            $.get(bars.config.urlContent("/api/pb1/FormingReportApi/CreateFileForPrint"), {},
            function getRes(data) {
                if (data != 'error') {
                    barsie$print(data.tempDir + data.name); //  "C:/Windows/Temp/RecReport.pdf"data.tempDir + data.name " D:\\file.pdf"
                }
                else { return; }
            });
        }
        else
            bars.ui.alert({ text: "Наповніть таблицю" });
    };
}]);