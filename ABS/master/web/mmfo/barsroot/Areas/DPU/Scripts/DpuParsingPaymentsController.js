var app = angular.module('BarsWeb.Controllers', []).controller('DPU', ['$scope', '$http', function ($scope, $http) {
    //второй грид 
    //данные для второгно грида
    $scope.GetDataSourceForDocGrid = function () {
        return {
            async: false,
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/DPU/DpuParsingPaymentsApi/GetDataForDocGrid')
                }
            },
            serverPaging: true,
            //serverFiltering: true,

            schema:
                {
                    data: "Data",
                    total: "Total",
                    model:
                        {
                            fields:
                                {
                                    ACC: { type: "number", editable: true },
                                    NLS: { type: "string", editable: false },
                                    KV: { type: "number", editable: false },
                                    OSTC: { type: "number", editable: false },
                                    OSTB: { type: "number", editable: false },
                                    NMS: { type: "string", editable: false },
                                    NAZN: { type: "string", editable: false },
                                    REF1: { type: "number", editable: false },
                                    VDAT: { type: "date", editable: false },
                                    S_100: { type: "number", editable: false },
                                    S: { type: "number", editable: false },
                                    BAL: { type: "number", editable: false }
                                }
                        }
                }
        };
    };
    $scope.DocGridOptions = {
        toolbar: [
            {
                name: "delete",
                text: "delete",
                template: '<button id="delete" class="k-button"  ng-click="DeleteRow()" title="Видалити запис"><img src="/barsroot/Content/images/PureFlat/16/delete.png" width="20" height="20" /></button>'
            },
            {
                name: "reload_rotate",
                text: "reload_rotate",
                template: '<button id="reload" class="k-button "  ng-click="ReloadFirstGrid()" title="Оновити данні"><img src="/barsroot/Content/images/PureFlat/16/reload_rotate.png" width="20" height="20" /></button>'
            },
            {
                name: "save",
                text: "save",
                template: ' <button id="return" class="k-button "  ng-click="CreditedAmount()" title="Зарахувати суму на позасистемний рахунок"><img src="/barsroot/Content/images/PureFlat/16/save.png" width="20" height="20" /></button>'
            },
            {
                name: "save",
                text: "save",
                template: ' <button id="credit" class="k-button " ng-click="PayBack()" title="Поверення коштів"><img src="/barsroot/Areas/DPU/Content/transfer.png" width="20" height="20" /></button>'
            },
            {
                name: "folder_open",
                text: "folder_open",
                template: '<button id="show" class="k-button "  ng-click="ShowDoc()" title="Відкрити документ"><img src="/barsroot/Content/images/PureFlat/16/folder_open.png" width="20" height="20" /></button>'
            }
        ],
        dataSource: $scope.GetDataSourceForDocGrid(),
        selectable: true,
        //filterable: true,
        scrollable: false,
        /*change: function () {
             
            ReloadDownGrid();
        },*/
        dataBound: function (e) {
            /* dataItem = $("#DocGrid").data().kendoGrid.dataSource.view();
           var grid = e.sender;
            $.each(grid.tbody.find('tr'), function () {
                var model = grid.dataItem(this);
                if (model.ACC == dataItem[0].ACC) {
                    grid.select(this);
                }
            });
             
            if (dataItem.length > 0) {
                $scope.firstid = dataItem[0].ACC;
                $scope.LoadData();
            }*/
        },
        
        columns: [
            {
                field: "KV",
                title: "Вал",
                width: "2%"
               
            },
            {
                field: "NLS",
                title: "Депозитний рах. ген. угоди",
                width: "12%"
            },
            {
                field: "NMS",
                title: "Назва рахунку",
                width: "10%"
            },
            {
                field: "OSTC",
                title: "Фактичний залишок",
                template: '<span style="float:right">#= OSTC #</span>',
                width: "5%"
            },
            {
                field: "OSTB",
                title: "Плановий залишок",
                template: '<span style="float:right">#= OSTB #</span>',
                width: "5%"
            },
            {
                field: "BAL",
                title: "Залишок 'дочірніх'",
                template: '<span style="float:right">#= BAL #</span>',
                width: "5%"
                //hidden:true
            },
            {
                field: "REF1",
                title: "Референс документу",
                width: "5%",
                template: '<span style="float:right">#= REF1 #</span>',
                //hidden:true
            },
            {
                field: "VDAT",
                title: "Дата платежу",
                template: "#= kendo.toString(kendo.parseDate(VDAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #",
                width: "5%"
            },
            {
                field: "S_100",
                title: "Сума платежу",
                template: '<span style="float:right">#= S_100 #</span>',
                width: "5%"
            },
            {
                title: "Призначення платежу",
                field: "NAZN",
                width: "46%"
            }
        ],
        srollable: true

    };

    //береб данные для второгно грида
    GetDataSourceForGrid = function () {
         
        //dataItem = $("#DocGrid").data().kendoGrid.dataSource.view();
        //$scope.firstid = dataItem[0].ACC;
         
        if ($scope.firstid != undefined || $scope.firstid != null) {

            return {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/DPU/DpuParsingPaymentsApi/GetDataForGrid') + '?id=' + $scope.firstid
                    }
                },
                serverPaging: true,
                //serverFiltering: true,
                schema:
                    {
                        data: "Data",
                        total: "Total",
                        model:
                            {
                                fields:
                                    {
                                        ACC: { type: "number", editable: true },
                                        NLS: { type: "string", editable: false },
                                        KV: { type: "number", editable: false },
                                        OSTC: { type: "number", editable: false },
                                        OSTB: { type: "number", editable: false },
                                        NMS: { type: "string", editable: false },
                                        ND: { type: "string", editable: false },
                                        SUM: { type: "number", editable: false }
                                    }
                            }
                    }
            };
        }
         
        
    };
    $scope.GridOptions = {
        dataSource: GetDataSourceForGrid(),
        selectable: true,
        //filterable: true,
        scrollable: false,
        change: function () {
             
        },
        columns: [
            {
                field: "KV",
                title: "Вал",
                width: "2%"
            },
            {
                field: "NLS",
                title: "Депозитний рах. додаткової угоди",
                width: "12%"
            },
            
            {
                field: "NMS",
                title: "Назва рахунку",
                width: "10%"
            },
            {
                field: "OSTB",
                title: "Фактичний залишок",
                template: '<span style="float:right">#= OSTB #</span>',
                width: "5%"
            },
            {
                field: "OSTC",
                title: "Плановий залишок",
                template: '<span style="float:right">#= OSTC #</span>',
                width: "5%"
            },
            {
                field: "ND",
                title: "№ додаткової угоди",
                template: '<span style="float:right">#= SUM #</span>',
                width: "5%"
            },
            {
                field: "SUM",
                title: "Сума додаткової угоди",
                template: '<span style="float:right">#= SUM #</span>',
                width: "5%"
            },
            {
                title: "",
                width: "56%"
            }
        ],
        srollable: true

    };

     $scope.LoadData = function(){
         
        if ($scope.firstid != undefined || $scope.firstid != null) {
            $scope.GridOptions.dataSource = {
                async: false,
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/DPU/DpuParsingPaymentsApi/GetDataForGrid') + '?id=' + $scope.firstid
                    }
                },
                serverPaging: true,
                //serverFiltering: true,
                schema:
                    {
                        data: "Data",
                        total: "Total",
                        model:
                            {
                                fields:
                                    {
                                        ACC: { type: "number", editable: true },
                                        NLS: { type: "string", editable: false },
                                        KV: { type: "number", editable: false },
                                        OSTC: { type: "number", editable: false },
                                        OSTB: { type: "number", editable: false },
                                        NMS: { type: "string", editable: false },
                                        ND: { type: "string", editable: false },
                                        SUM: { type: "number", editable: false }
                                    }
                            }
                    }
            };
        }
        angular.element("#Grid").data("kendoGrid").dataSource.read();
        angular.element("#Grid").data("kendoGrid").refresh();
    }
    $scope.ReloadDownGrid = function(data) {
         
        selected = GetSelected("#DocGrid");
        $scope.firstid = selected.ACC;
        $scope.GridOptions.dataSource = GetDataSourceForGrid();
        $("#Grid").data("kendoGrid").dataSource.read();
        $scope.ReloadGrid();
    };
    //виполняем процедуру перед заполнение всех гридов
    $scope.BeforeStart = function () {
        debugger;
        //$.ajax({
        //    url: bars.config.urlContent("/api/DPU/DpuParsingPaymentsApi/BeforeStart"),
        //    method: "GET",
        //    async: false,
        //    complete: function (data) {
        //    }
        //});
        $http({
            url: bars.config.urlContent("/api/DPU/DpuParsingPaymentsApi/BeforeStart"),
            method: "POST",
            async: false
        }).success(function (data) {
        }).error(function (error) {
        });
    };
    //удаляепм строку со вторго грилда
    $scope.DeleteRow = function () {
         
        // var gridElement = angular.element("#Grid").data("kendoGrid");
        //var selectedAcc = GetSelected("#Grid");
        var selectedRef1 = GetSelected("#DocGrid");
         
        if (selectedRef1 != null) {
            $http({
                url: bars.config.urlContent("/api/DPU/DpuParsingPaymentsApi/DeleteRow"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ ACC: selectedRef1, REF1: selectedRef1 }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                $scope.ReloadGrid();
            }).error(function (error) {
            });
        }
        else {
            AlertNotifyError();
        }

    };

    //Поверення коштів що надійшли на рах. депозитної лінії
    $scope.PayBack = function () {
        var selected = GetSelected("#DocGrid");
         
        if (selected != 0) {
            $http({
                url: bars.config.urlContent("/api/DPU/DpuParsingPaymentsApi/PayBack"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ row: selected }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                $scope.ReloadGrid();
            }).error(function (error) {
            });
        }
        else {
            AlertNotifyError();
        }

    };
    //Зарахувати суму на позасистемний рахунок
    $scope.CreditedAmount = function () {
        var selected1 = GetSelected("#Grid");
        var selected2 = GetSelected("#DocGrid");
         
        if (selected1 != null || selected1 != null) {
            $http({
                url: bars.config.urlContent("/api/DPU/DpuParsingPaymentsApi/CreditedAmount"),
                method: "POST",
                dataType: "json",
                data: JSON.stringify({ row: selected1, acc: selected2 }),
                contentType: "application/json",
                async: false
            }).success(function (data) {
                $scope.ReloadGrid();
            }).error(function (error) {
            });
        }
        else {
            AlertNotifyError();
        }

    };


    var myWindow = $("#window");



    //Посмотреть документ
    $scope.ShowDoc = function () {
        selected = GetSelected("#DocGrid");
        $scope.REF1 = selected.REF1;
        $scope.link = "/documentview/default.aspx?ref=" + $scope.REF1;
        //$scope.link = "http://10.10.10.47:1001/barsroot/documentview/default.aspx?ref=57310805901"
        console.log($scope.link);
        //myWindow.load("/barsroot/documentview/default.aspx?ref=" + $scope.REF1);
       
        if (selected != 0) {
            bars.ui.dialog({
                content: bars.config.urlContent($scope.link),
                iframe: true,
                width: '90%',
                height: '60%'
            });
        }
        else {
            AlertNotifyError();
        }
        $scope.ReloadGrid();
    };

    //получаем выбраною строчку
    function GetSelected(name) {
         
        var gridElement = angular.element(name).data("kendoGrid");
        var selected = gridElement.dataItem(gridElement.select());
        return selected;
    }
    //перпезагрнужаем first грида
    $scope.ReloadFirstGrid = function () {
        angular.element("#DocGrid").data('kendoGrid').dataSource.read();
    };

    //перпезагрнужаем грида
    $scope.ReloadGrid = function () {
        angular.element("#Grid").data('kendoGrid').dataSource.read();
    };
    //отрисовывваем алерт
    AlertNotifyError = function () {
         
        var popupNotification = $("#popupNotification").kendoNotification({
            height: 45,
            position: {
                pinned: true,
                top: 20,
                right: 20
            },
        }).data("kendoNotification");
        popupNotification.show("Виберіть запис", "error");
    }
}]);