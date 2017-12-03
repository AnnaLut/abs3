angular.module("BarsWeb.Areas").controller("CreditUi.moreCreditParamsCtrl", ["$scope", "$http", "$rootScope", "$location", function ($scope, $http, $rootScope, $location) {
    var url = bars.config.urlContent("/creditui/newcredit/");

    //$scope.isSave = false;

    /*var tabList = {};
    var url = '/credit/newcredit/getTabList/';
    $http.get(bars.config.urlContent(url)).then(function (request) {
        if (request.data.length > 0) {

            tabList = request.data;
            console.log(tabList);
        }
    });*/

    $rootScope.ndtxtsave = { nd: null, txt: [] };

    $scope.tabDataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: bars.config.urlContent("/creditui/newcredit/getTabList/"),
                dataType: "json"
            }
        }
    });

    $scope.tabParamsOptions = {
        animation: false        
    };

    $scope.getEditor = function (container, options) {
        switch (options.model.TYPE) {
            case "S":
                var editor = container.append('<input type="text" class="k-textbox" data-bind="value:' + options.field + '"/>');
                //debugger;
                break;
            case "N":
                var editor = container.append('<input kendo-numeric-text-box data-bind="value:' + options.field + '"/>');
                break;
            case "D":
                var editor = container.append('<input kendo-masked-date-picker k-format="dd/MM/yyyy" data-bind="value:' + options.field + '"/>');
                break;
            case "R": {
                var editor = container.append('<input type="text" class="k-textbox" style="widrh:60%" data-bind="value:' + options.field + '" id="edit' + options.model.TAG + '"/>');
                var tabname = options.model.TABLE_NAME;
                var columns = options.model.COL_NAME;
                bars.ui.handBook(tabname, function (data) {
                    angular.element(document).find('#edit' + options.model.TAG)[0].value = data[0].PrimaryKeyColumn;
                    options.model.TXT = data[0].PrimaryKeyColumn;
                    options.model.SEM = data[0].SemanticColumn;
                },
                {
                    multiSelect: false,
                    clause: null,
                    columns: columns
                });
                break;
            }
            default: var editor = container.append('<input type="text" class="k-textbox" data-bind="value:' + options.field + '"/>'); break;
        }
    }

    $scope.gridColumns = [{
        title: "Код реквізиту",
        field: "TAG"
    },
    {
        title: "Найменування реквізиту",
        field: "NAME"
    },
    {
        title: "Значення реквізиту",
        field: "TXT",
        filterable: false,
        editor: $scope.getEditor
    },
    {
        title: "Значення довідника",
        field: "SEM",
        filterable: false
    },
    {
        command: "edit",
        title: " "
    }];

    $scope.gridOptions = {
        editable: {
            mode: "inline"
        },
        save: function (e) {
            if (e.model.TYPE == "D") {
                var date = new Date(e.model.TXT);
                e.model.TXT = kendo.toString(kendo.parseDate(date), 'dd/MM/yyyy');
            }
            if (e.model.TXT == "" || e.model.TXT == null) {
                e.model.TXT = null;
                if (e.model.TYPE == "R") {
                    e.model.SEM = null;
                }
            }
            var key = false;
            for (var i = 0; i < $rootScope.ndtxtsave.txt.length; i++) {
                if ($rootScope.ndtxtsave.txt[i].tag == e.model.TAG)
                {
                    $rootScope.ndtxtsave.txt[i].txt = e.model.TXT;
                    key = true;
                }
            }
            if (!key) {
                console.log('in key check');
                $rootScope.ndtxtsave.txt.push({ tag: e.model.TAG, txt: e.model.TXT });
            }
        }
    }

    $scope.tabDataSource.fetch(function () {
        bars.ui.loader('body', true);
        var tabs = $scope.tabDataSource.view();
        var tabStrip = $scope.tabParams;
        var nd = bars.extension.getParamFromUrl('nd', $location.absUrl());
        for (i = 0; i < tabs.length; i++) {
            tabStrip.append({
                text: tabs[i].NAME,
                content: "<div kendo-grid='" + tabs[i].CODE + "' k-columns='gridColumns' k-filterable='true' k-options='gridOptions' k-pageable='true'></div>"
            });
            var urlTxt = "";
            var dataTxt;
            if (nd != null) {
                urlTxt = "/creditui/newcredit/getNdTxtDeal/";
                dataTxt = { nd: nd, code: tabs[i].CODE };
            }
            else {
                urlTxt = "/creditui/newcredit/getNdTxt/";
                dataTxt = { code: tabs[i].CODE };
            }
            var gridDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent(urlTxt),
                        data: dataTxt,
                        dataType: "json"
                    },
                    update: {
                        url: "#"
                    }
                },
                batch: true,
                pageSize: 20,
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: "TAG",
                        fields: {
                            TAG: { type: "string", editable: false },
                            NAME: { type: "string", editable: false },
                            TXT: { type: "string", editable: true },
                            SEM: { type: "string", editable: false }
                        }
                    }
                }
            });
            $scope[tabs[i].CODE].setDataSource(gridDataSource);
        }
        tabStrip.select(0);
        bars.ui.loader('body', false);
    });
}]);