angular.module('BarsWeb.Controllers')
    .controller('SplitSum', ['$scope', '$http', function ($scope, $http) {


        var sColumnsArr = [
            {
                field: "LCV",
                title: "Вал",
                width: 75
            },
            {
                field: "ACC",
                title: "Рен. номер клієнта",
                width: 100
            },
            {
                field: "NMK",
                title: "Найменування клієнта",
                width: 80
            },
            {
                field: "NLS",
                title: "№ счета",
                width: 80
            },
            {
                field: "FDAT",
                title: "Дата отримання",
                template: "<div>#=kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy') === null ? '' : kendo.toString(kendo.parseDate(FDAT),'dd/MM/yyyy')#</div>",
                width: 60
            },
            {
                field: "REF",
                title: "Реф. документа",
                width: 150
            },
            {
                field: "AMNT",
                format: '{0:0.00}',
                title: "Сума документа",
                width: 80
            },
            {
                field: "IS_SPLIT",
                title: "Ознака проведення розщеплення",
                width: 150
            }
        ];
        var spliterColumnsArr = [
           {
               field: "TP_NM",
               title: "Ознака обов. продажу",
               width: 75,
               editable: false
           },
           {
               field: "AMNT",
               title: "Сума продажу",
               format: '{0:0.00}',
               width: 100
           }

        ];

        /* --- DataSource'S http result function --- */
        $scope.requestDataResult = function (result) {
            $scope.enableBtnCurrency = true;
            return result.Data || (function () {
                $scope.enableBtnCurrency = false;
                return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Msg });
            })();
        };


        /* --- SplitEarnGrid data --- */
        $scope.sDataSource = new kendo.data.DataSource({
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/zay/AverageEarnings/get'),
                    dataType: 'json'
                }
            },
            schema: {
                data: $scope.requestDataResult,
                total: function (result) {
                    return result.Total || 0;
                },
                model: {
                    fields: {
                        RNK: { type: "number" },
                        NMK: { type: "string" },
                        ACC: { type: "number" },
                        KV: { type: "number" },
                        LCV: { type: "string" },
                        NLS: { type: "string" },
                        FDAT: { type: "date" },
                        REF: { type: "number" },
                        AMNT: { type: "number" },
                        IS_SPLIT: { type: "number" }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true
        });

        /* --- SplitEarnGrid --- */
        $scope._sGridOptions = {
            filterable: true,
            selectable: 'multiple, row',
            sortable: true,
            pageable: {
                refresh: true,
                pageSizes: [15, 30, 45, 60],
                buttonCount: 5
            },
            dataSource: $scope.sDataSource,
            columns: sColumnsArr,
            dataBound: function (data) {

            },
            change: function () {
                $("#_sGridOptions").on("dblclick", "tr.k-state-selected", function (e) {
                    $scope.OpenSpliterWin();
                });
            },
        };


        /* --- SpliterGrid data --- */
        $scope.SpliterDataSource = new kendo.data.DataSource({
            type: 'webapi',
            transport: {
                read: {
                    url: bars.config.urlContent('/api/zay/AverageEarnings/GetSplitSum'),
                    data: function () {
                        return { nRef: $scope.nRef, AMNT: $scope.AMNT }
                    }
                }
            },
            schema: {
                data: $scope.requestDataResult,
                total: function (result) {
                    return result.Total || 0;
                },
                model: {
                    fields: {
                        ID: { type: "number" },
                        TP_ID: { type: "number" },
                        TP_NM: { type: "string", editable: false },
                        AMNT: { type: "number" },
                        VIRTUAL: { type: "number" }
                    }
                }
            }
        });

        /* --- SpliterGrid --- */
        $scope._SpliterGridOptions = {
            autoBind: false,
            selectable: 'multiple, row',
            dataSource: $scope.SpliterDataSource,
            columns: spliterColumnsArr,
            editable: { createAt: "bottom" },
            dataBound: function (data) {

                var grid = this;
                var data = grid._data;
                if (data.length == 3)
                    $("#addnew").prop("disabled", true);
            },
            edit: function () {
                CororizeDirty();
            },
            change: function () {
                CororizeDirty();
            },
        };


        $scope.OpenSpliterWin = function () {

            grid = $("#_sGridOptions").data("kendoGrid");
            selectedItem = grid.dataItem(grid.select());
            //$scope.baseWin.element[0].style.width = String.format("{0}px", document.documentElement.offsetWidth * 0.5);
            $scope.baseWin.element[0].style.width = "600px";
            $scope.baseWin.title("Розподіл суми платежу #" + selectedItem.REF);
            $scope.baseWin.open().center();
            $scope.nRef = selectedItem.REF;
            $scope.AMNT = selectedItem.AMNT;
            $scope.selectedItem = selectedItem;
            $scope._SpliterGridOptions.dataSource.read()
        };

        $scope.SaveSplitSettings = function () {
            grid = $("#_SpliterGridOptions").data("kendoGrid");
            var data = grid._data;
            $scope.sum = 0;
            $scope.valid = true;

            angular.forEach(data, function (i) {
                $scope.sum = $scope.sum + i.AMNT * 100;
            });

            if (($scope.sum / 100).toFixed(2) != $scope.selectedItem.AMNT) {
                bars.ui.error({ text: 'Сума' });
                return;
            }
            else {
                $scope.valid = true;
                $scope.SaveEditedRows();
            }

        }
        $scope.AddNewSetting = function () {

            if ($("#_SpliterGridOptions").data("kendoGrid")._data.length < 3) {
                $("#_SpliterGridOptions").data("kendoGrid").addRow();
                if ($("#_SpliterGridOptions").data("kendoGrid")._data.length == 3)
                    $("#addnew").prop("disabled", true);
            }

        }
        $scope.ReloadGrid = function (id) {
            $("#" + id).data("kendoGrid").dataSource.read();
        }

        $scope.DeleteSetting = function (id) {
            var grid = $("#_SpliterGridOptions").data("kendoGrid");
            var selectedItem = grid.dataItem(grid.select());

            var ID = selectedItem.TP_ID == null ? selectedItem.ID : selectedItem.TP_ID;
            if (selectedItem) {
                $http({
                    url: bars.config.urlContent("/api/zay/AverageEarnings/DeleteSetting?ID=") + ID,
                    method: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    async: false
                }).success(function (data) {
                    if (selectedItem.VIRTUAL)
                        $scope.ReloadGrid("_SpliterGridOptions");
                    else {

                        grid = $("#_SpliterGridOptions").data("kendoGrid");
                        var rows = grid.select();
                        if (rows.length != 0) {
                            var rows_for_delete = [];
                            rows.each(function (index, row) {
                                var selectedItem = grid.dataItem(row);
                                rows_for_delete.push(selectedItem);
                            });
                            for (var i = 0; i < rows_for_delete.length; i++) {
                                grid.dataSource.remove(rows_for_delete[i]);
                            }
                            $("#addnew").prop("disabled", false);
                            bars.ui.success({ text: "Успішно видалено з таблиці " + rows_for_delete.length + " рядків" });
                        }
                    }
                });
            }

        }

        CororizeDirty = function (data) {
            var dataSource = $("#_SpliterGridOptions").data("kendoGrid").dataSource,
            data = dataSource.data();
            $scope.editedR = []
            $scope.changedModels = [];
            if (dataSource.hasChanges) {
                for (var i = 0; i < data.length; i++) {
                    if (data[i].dirty) {
                        $scope.changedModels.push(data[i]);
                    }
                }
            }

            var tr = [];
            for (var i = 0; i < $scope.changedModels.length; i++) {
                var element = $('tr[data-uid="' + $scope.changedModels[i].uid + '"] ');
                angular.element(element).addClass("change-background");
            }
        }

        $scope.SaveEditedRows = function () {
            var gridElement = angular.element("#_SpliterGridOptions").data("kendoGrid");
            var dataSource = $("#_SpliterGridOptions").data("kendoGrid").dataSource;
            var data = dataSource.data();
            $scope.editedR = []
            $scope.changedModels = [];
            if (dataSource.hasChanges) {
                for (var i = 0; i < data.length; i++) {
                    if (data[i].dirty) {
                        $scope.changedModels.push(data[i]);
                    }
                }
            }
            var editedrows = $scope.changedModels;

            if (editedrows.length != 0) {

                var rows_for_update = [];
                for (var i = 0; i < editedrows.length; i++) {
                    rows_for_update.push(editedrows[i]);
                }

                for (var i = 0; i < rows_for_update.length; i++) {
                    $http({
                        url: bars.config.urlContent("/api/zay/AverageEarnings/SaveSettings") + "?ID=" + rows_for_update[i].ID + "&nREF=" + $scope.selectedItem.REF + "&SALE_TP=" + rows_for_update[i].TP_ID + "&AMNT=" + rows_for_update[i].AMNT,
                        method: "POST",
                        contentType: "application/json",
                        async: false
                    }).success(function (data) {
                        $scope.baseWin.close();
                        $scope.ReloadGrid("_SpliterGridOptions");
                    });

                }
            }
            else {
                if ($scope.valid) {

                    for (var i = 0; i < data.length; i++) {
                        var idParam;


                        if (null == data[i].SALE_TP) {
                            idParam = data[i].TP_ID
                        };

                        if (null == data[i].TP_ID) {
                            idParam = data[i].SALE_TP
                        };

                        //idParam = (data[i].SALE_TP == null || data[i].SALE_TP == undefined) ? idParam = data[i].TP_ID : 


                        $http({
                            //url: bars.config.urlContent("/api/zay/AverageEarnings/SaveSettings") + "?ID=" + data[i].ID + "&nREF=" + $scope.selectedItem.REF + "&SALE_TP=" + data[i].TP_ID + "&AMNT=" + data[i].AMNT,
                            //url: bars.config.urlContent("/api/zay/AverageEarnings/SaveSettings") + "?ID=" + data[i].ID + "&nREF=" + $scope.selectedItem.REF + "&SALE_TP=" + data[i].SALE_TP + "&AMNT=" + data[i].AMNT,
                            url: bars.config.urlContent("/api/zay/AverageEarnings/SaveSettings") + "?ID=" + data[i].ID + "&nREF=" + $scope.selectedItem.REF + "&SALE_TP=" + idParam + "&AMNT=" + data[i].AMNT,
                            method: "POST",
                            contentType: "application/json",
                            async: false
                        }).success(function (data) {
                            $scope.baseWin.close();
                            $scope.ReloadGrid("_SpliterGridOptions");
                        }).error(function (err) {
                        });
                    }
                }
                $scope.baseWin.close();
            }
        }

        $scope.GetDefaultSpliter = function () {
            $.ajax({
                url: bars.config.urlContent("/api/DptAdm/EditFinesDFOApi/GetDataForDrop") + "?ddt=" + type,
                method: "GET",
                dataType: "json",
                async: false,
                complete: function (data) {
                    $scope.tmp = data.responseJSON;
                }
            });
            return $scope.tmp;
        }
    }]);