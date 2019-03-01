var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("CommonController", function ($scope) {
    $scope.extend = function (src, dst) {
        for (var key in src) {
            if (src[key] == null || src[key] instanceof Array || ["number", "boolean", "string", "function", "undefined"].indexOf(typeof src[key]) != -1) {
                dst[key] = src[key];
            }
            else {
                if (!dst.hasOwnProperty(key)) { dst[key] = {}; }
                arguments.callee(src[key], dst[key]);
            }
        }
    };

    $scope.replaceAll = function (s, oldValue, newValue) {       // replaceAll("Hello world!", "o", "_")
        var newS = "";
        var i;
        var indexes = [];
        for (i = 0; i < s.length; i++) {
            if (s[i] === oldValue) {
                indexes.push(i);
            }
        }
        for (i = 0; i < s.length; i++) {
            if (indexes.indexOf(i) != -1) {
                newS += newValue;
            }
            else {
                newS += s[i];
            }
        }
        return newS;
    }
});




mainApp.controller("KendoMainController", function ($controller, $scope) {
    $controller('CommonController', { $scope: $scope });     // Расширяем контроллер

    $scope.createDataSource = function (ds) {
        var _ds = {
            type: "aspnetmvc-ajax",
            pageSize: 50,
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: ""
                }
            },
            requestStart: function () { bars.ui.loader("body", true); },
            requestEnd: function (e) { bars.ui.loader("body", false); },
            schema: {
                data: "Data",
                total: "Total",
                model: { fields: {} }
            }
        };

        $scope.extend(ds, _ds);

        return _ds;
    };

    $scope.createGridOptions = function (go) {
        var _go = {
            autoBind: true,
            resizable: true,
            selectable: "row",
            scrollable: true,
            sortable: true,
            pageable: {
                messages: {
                    allPages: "Всі"
                },
                refresh: true,
                pageSizes: [10, 50, 200, 1000, "All"],
                buttonCount: 5
            },
            filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
            reorderable: true,
            change: function () {
                var grid = this;
                var row = grid.dataItem(grid.select());
            },

            columns: [],
            filterable: true
        };

        $scope.extend(go, _go);

        return _go;
    };
});

mainApp.controller("Compare_351_601Ctrl", function ($controller, $scope) {
    $controller('KendoMainController', { $scope: $scope });     // Расширяем контроллер

    $scope.Title = "";

    var mainDataSource = $scope.createDataSource({
        type: "webapi",
        transport: { read: { url: bars.config.urlContent("/api/Compare_351_601/Compare_351_601/SearchMain") } },
        schema: {
            model: {
                fields: {
                    OKPO: { type: 'string' },
                    RNK: { type: 'number' },
                    ND: { type: 'number' },
                    KV: { type: 'string' },
                    SUM_ALL_CR: { type: 'number' },
                    SUM_ALL_601: { type: 'number'},
                    DIFFERENCE: { type: 'number' },
                    KF: { type: 'string' }
                }
            }
        }
    });

    $scope.MainGridOptions = $scope.createGridOptions({
        dataSource: mainDataSource,

        toolbar: ["excel", { name: "btPay", type: "button", text: "<span class='pf-icon pf-17 pf-money'></span> Консолідувати дані"}],
        excel: {
            fileName: "Export_Data.xlsx",
            allPages: true,
            filterable: true,
            proxyURL: bars.config.urlContent('/EscrExcelExport/ExcelExport_Save/')
        },  
        
        columns: [
            {
                field: "OKPO",
                title: "OKPO",
                width: "100%"
            },
            {
                field: "RNK",
                title: "RNK",
                width: "100%"
            },
            {
                field: "ND",
                title: "ДОГОВІР",
                width: "100%"
            },
            {
                field: "KV",
                title: "ВАЛЮТА",
                width: "100%"
            },
            {
                field: "SUM_ALL_CR",
                title: "ЗАГАЛЬНА СУМА ПО REZ_CR",
                width: "100%"
            },
            {
                field: "SUM_ALL_601",
                title: "ЗАГАЛЬНА СУМА ПО 601",
                width: "100%"
            },
            {
                field: "DIFFERENCE",
                title: "РІЗНИЦЯ",
                width: "100%"
            },
            {
                field: "KF",
                title: "МФО",
                width: "100%"
            }
        ],
        
    });


    //buttons consolidate
    $(document).ready(function () {
        $(".k-grid-btPay").click(function () { 
            bars.ui.loader("body", true);
            $.ajax({
                dataSource: mainDataSource,
                async: true,
                type: 'GET',
                url: bars.config.urlContent("/api/Compare_351_601/Compare_351_601/consl"),
                success: function (data) {
                    if (!data.Error) {
                        bars.ui.alert({ text: "консолідацію виконано успішно" });
                        location.reload();
                    }
                    else
                        bars.ui.error({
                            text: data.Error,
                            height: 'auto'
                        });
                },
                complete: function () {
                    bars.ui.loader("body", false);
                   // location.reload(); 
                }
            });
        });
    });


});



