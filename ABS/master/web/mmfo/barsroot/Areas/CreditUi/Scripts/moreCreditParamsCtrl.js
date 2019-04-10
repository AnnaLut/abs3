﻿angular.module("BarsWeb.Areas").controller("CreditUi.moreCreditParamsCtrl", ["$scope", "$http", "$rootScope", "$location", function ($scope, $http, $rootScope, $location) {
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

    $scope.ArrayTabs = ["Параметри КД", "Дані про погашення", "Комісія та Ліміт"];

    $scope.NoEditParams = [{ tag: "FLAGS", tab: $scope.ArrayTabs[1], fields: "\"Канікули\" та \"За попередній\"" }, { tag: "S_SDI", tab: $scope.ArrayTabs[2], fields: "Початкова, Одноразова" },
        { tag: "SN8_R", tab: $scope.ArrayTabs[2], fields: "Пеня" }, { tag: "DATSN", tab: $scope.ArrayTabs[1], fields: "Погашення процентного боргу -> Перша платіжна дата" },
        { tag: "DAYNP", tab: $scope.ArrayTabs[1], fields: "Тип урегулювання дня погашення" }, { tag: "DAYSN", tab: $scope.ArrayTabs[1], fields: "Погашення процентного боргу  -> День" },
        { tag: "INIC", tab: $scope.ArrayTabs[0], fields: "Ініціатива" }, { tag: "CCRNG", tab: $scope.ArrayTabs[1], fields: "Шаблон погашення рахунку \"SG\" " },
        { tag: "I_CR9", tab: $scope.ArrayTabs[0], fields: "Вид" }, { tag: "R_CR9", tab: $scope.ArrayTabs[2], fields: "Комісія за невикористаний ліміт" },
        { tag: "FREQ", tab: $scope.ArrayTabs[1], fields: "Погашення основного боргу -> Періодичність" }, { tag: "FREQP", tab: $scope.ArrayTabs[1], fields: "Погашення процентного боргу -> Періодичність" },
        { tag: "S_S36", tab: $scope.ArrayTabs[2], fields: "Комісія за обслуговування кредиту (сплачується перед видачею кредиту)" },
        { tag: "GKD_IN", tab: $scope.ArrayTabs[0], fields: "Приналежність до ГКД", blockOnTagOnly: true }, { tag: "GKD_ND", tab: $scope.ArrayTabs[0], fields: "Ген. договір" },
        { tag: "BUS_MOD", tab: $scope.ArrayTabs[0], fields: "BUS_MOD", blockOnTagOnly: true }, { tag: "SPPI", tab: $scope.ArrayTabs[0], fields: "SPPI", blockOnTagOnly: true },
        { tag: "IFRS", tab: $scope.ArrayTabs[0], fields: "IFRS", blockOnTagOnly: true }, { tag: "POCI", tab: $scope.ArrayTabs[0], fields: "POCI", blockOnTagOnly: true }
    ];

    $scope.GetMessage = function (tag) {
        for (var i = 0; i < $scope.NoEditParams.length; i++) {
            if (($rootScope.isTagOnly && $scope.NoEditParams[i].blockOnTagOnly && $scope.NoEditParams[i].tag === tag) ||
                (!$rootScope.isTagOnly && $scope.NoEditParams[i].tag === tag))
                return [$scope.NoEditParams[i].tab, $scope.NoEditParams[i].fields];
        }
        return false;
    };

    $rootScope.ndtxtsave = { nd: null, txt: [] };

    $http.post(bars.config.urlContent('/creditui/newcredit/GetMoreCreditsParams'), { nd: $rootScope.nd }).then(function (request) {
        $rootScope.moreCreditsParamsDataSource = request.data;
        $scope.tabDataSource = new kendo.data.DataSource({
            data: $rootScope.moreCreditsParamsDataSource.TabList
        });

        $scope.tabDataSource.fetch(function () {
            bars.ui.loader('body', true);
            $rootScope.LoadMoreCreditData("new");
            bars.ui.loader('body', false);
        });
    });

    //$scope.tabDataSource = new kendo.data.DataSource({
    //    transport: {
    //        read: {
    //            url: bars.config.urlContent("/creditui/newcredit/getTabList/"),
    //            dataType: "json"
    //        }
    //    }
    //});

    $scope.tabParamsOptions = {
        animation: false        
    };

    $scope.getEditor = function (container, options) {
        if (!($scope.GetMessage(options.model.TAG))) {
            switch (options.model.TYPE) {
                case "S":
                    var editor = container.append('<input type="text" class="k-textbox" data-bind="value:' + options.field + '"/>');
                    //debugger;
                    break;
                case "N":
                    var editor = container.append('<input kendo-numeric-text-box data-decimals="2" data-bind="value:' + options.field + '"/>');
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
        else
            var editor = container.append('<input type="text" class="k-textbox" data-bind="value:' + options.field + '"/>');
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
        edit: function (e)
        {
            var message = $scope.GetMessage(e.model.TAG);
            if (message) {
                this.cancelRow();
                bars.ui.alert({
                    text: "Редагування на вкладці <b>" + message[0] + "</b>, <br> поле: <b>\"" + message[1] + "\"</b>"
                });
            }

            if (e.model.TAG === "S_S36" && $rootScope.isTagOnly) {
                this.cancelRow();
                bars.ui.error({ text: "Заборонено редагувати параметр <b>" + e.model.TAG + "</b> у авторизованому кредиті" });
            }
                
        },
        save: function (e) {
            if ((e.model.TYPE == "D") && (e.model.TXT != null)) {
                var date = new Date(e.model.TXT);
                e.model.TXT = kendo.toString(kendo.parseDate(date), 'dd/MM/yyyy');
            }
            if (e.model.TXT === "" || e.model.TXT == null) {
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
                $rootScope.ndtxtsave.txt.push({ tag: e.model.TAG, txt: e.model.TXT });
            }
        }
    }

    $rootScope.LoadMoreCreditData = function(mode)
    {
        var tabs = $scope.tabDataSource.view();
        var tabStrip = $scope.tabParams;
        //var nd = bars.extension.getParamFromUrl('nd', $location.absUrl());
        for (i = 0; i < tabs.length; i++) {
            if (mode === "new") {
                tabStrip.append({
                    text: tabs[i].Value,
                    content: "<div kendo-grid='" + tabs[i].Key + "' k-columns='gridColumns' k-filterable='true' k-options='gridOptions' k-pageable='true'></div>"
                });
            }
            //var urlTxt = "";
            //var dataTxt;
            //if (nd != null) {
            //    urlTxt = "/creditui/newcredit/getNdTxtDeal/";
            //    dataTxt = { nd: nd, code: tabs[i].CODE };
            //}
            //else {
            //    urlTxt = "/creditui/newcredit/getNdTxt/";
            //    dataTxt = { code: tabs[i].CODE };
            //}
            var gridDataSource = new kendo.data.DataSource({
                data: $rootScope.moreCreditsParamsDataSource.NdTxt,
                batch: true,
                pageSize: 20,
                schema: {
                    data: tabs[i].Key,
                    total: function () {
                        return $rootScope.moreCreditsParamsDataSource.NdTxt[tabs[i].Key].length;
                    },
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
            $scope[tabs[i].Key].setDataSource(gridDataSource);
        }
        tabStrip.select(0);
    }

}]);