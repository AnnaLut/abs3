/**
 * Created by serhii.karchavets on 23-Nov-17.
 */

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

mainApp.controller("KendoMainController", function ($controller, $scope, $http) {
    $controller('CommonController', { $scope: $scope });     // Расширяем контроллер

    $scope.createDataSource = function (ds) {
        var _ds = {
            type: "aspnetmvc-ajax",
            pageSize: 12,
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

    $scope.dateOptions = { format: '{0:dd/MM/yyyy}', change: function () { } };

    $scope.excelGridOptions = function (o) {
        var _o = {
            fileName: "mcp_files.xlsx",
            allPages: true,
            filterable: true,
            proxyURL: bars.config.urlContent('/Mcp/Mcp/ConvertBase64ToFile/')
        };
        if(o !== undefined && o !== null){
            $scope.extend(o, _o);
        }
        return _o;
    };

    $scope.excelExport = function (e) {
        var sheet = e.workbook.sheets[0];
        var header = sheet.rows[0];
        for (var headerCellIndex = 0; headerCellIndex < header.cells.length; headerCellIndex++) {
            var headerColl = header.cells[headerCellIndex];
            headerColl.value = headerColl.value.replace(/<br>/g, ' ');
        }
    };

    $scope.window = function (o) {
      var _o = {
          animation: false,
          visible: false,
          width: '1200px',
          actions: ["Maximize", "Minimize", "Close"],
          draggable: true,
          height: "700px",
          modal: true,
          pinned: false,
          resizable: true,
          title: '',
          position: 'center',
          /*close: function () {
           $scope.advertising = $scope.getNewAdvertising();
           },*/
          iframe: false
      };
        if(o !== undefined && o !== null){
            $scope.extend(o, _o);
        }
        return _o;
    };

    $scope.resultMulty = function (response, textOk) {
        var errCount = response['Errors'].length;
        if(errCount > 0){
            var text = "";
            for(var i = 0; i < errCount; i++){
                text += response['Errors'][i];
                if(i < errCount - 1){
                    text += '<br>';
                }
            }
            bars.ui.notify("Дані оброблено з помилками - ID : опис", text, "error", {autoHideAfter: 15*1000});
        }
        else{
            bars.ui.notify("До відома", textOk, "info", {autoHideAfter: 5*1000});
        }
    };
});