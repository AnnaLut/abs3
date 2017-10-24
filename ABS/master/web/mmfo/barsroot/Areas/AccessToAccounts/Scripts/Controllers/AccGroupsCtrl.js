angular.module('BarsWeb.Controllers')
    .controller('AccessToAccounts.AccGroupsCtrl', ['$scope', 'accGroupsService',
        function ($scope, accGroupsService) {

            var grpId = 0;
            var data = null;
            var nls = 0;
            var filter = null;
            var IssuedAcc = null;
            var NotIssuedAcc = null;

            $scope.model = {};
            //прячем нижние гриды
            $scope.disableChildsGrids = { 'visibility': 'hidden' };

            // верхний грид - групы счетов
            $scope.gridAccGroupsDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccGroups/GetAccGroups"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { grpId: $scope.model.ID } }
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1
            });

            $scope.gridAccGroupsOptions = {
                autoBind: true,
                dataSource: $scope.gridAccGroupsDataSource,
                sortable: true,
                selectable: 'row',
                resizable: true,
                pageable: true,
                columns: [
                    { field: "ID", title: "Номер групи", width: "20%" },
                    { field: "NAME", title: "Найменування групи рахунків", width: "50%" }
                ]
            };
            //выбор строки в верхнем гриде
            $scope.selectedAccountsGroup = function (data) {

                grpId = data.ID;
                $scope.model.grpId = data.ID;

                $scope.disableChildsGrids = { 'visibility': 'visible' }; // then button will visible.

                $scope.gridIssuedAccounts.dataSource.read();
                $scope.gridNotIssuedAccounts.dataSource.read();

                $scope.buttonArrowRight = false;
                $scope.buttonArrowLeft = false;

                IssuedAcc = null;
                NotIssuedAcc = null;
            };

            // левый грид - выданых счетов в групу счетов
            $scope.gridIssuedAccountsDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccGroups/GetIssuedAccounts"),
                        //data: {
                        //    grpId: function () {
                        //        return grpId;
                        //    },
                        //    obj: function () {
                        //        var obj = {};

                        //        if ($scope.gridIssuedAccountsDataSource.filter() != undefined) {
                        //            var arr = $scope.gridIssuedAccountsDataSource.filter().filters;

                        //            for (var i = 0; i < arr.length; i++) {
                        //                if (arr[i].field == "ACC") {
                        //                    obj.ACC = arr[i].value;
                        //                }
                        //                if (arr[i].field == "NLS") {
                        //                    obj.NLS = arr[i].value;
                        //                }
                        //            }                                  
                        //        }                              
                        //        return obj;                                
                        //    }
                        //},
                        data: function () {
                            var obj = {};
                                if ($scope.gridIssuedAccountsDataSource.filter() != undefined) {
                                    var arr = $scope.gridIssuedAccountsDataSource.filter().filters;

                                    for (var i = 0; i < arr.length; i++) {
                                        if (arr[i].field == "ACC") {
                                            obj.ACC = arr[i].value;
                                        }
                                        if (arr[i].field == "NLS") {
                                            obj.NLS = arr[i].value;
                                        }
                                    }
                                    obj['grpId'] = grpId;
                                }                              
                                return obj;
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ACC: { type: "number" },
                            NLS: { type: "string" },
                            KV: { type: "number" },
                            NMS: { type: "string" },
                            DAZS: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1,
                serverFiltering: true,
                //filter: {                    
                //    field: "NLS", operator: "startswith", value: "НБР або рахунок"
                //}


                filter: {
                    logic: "or",
                    filters: [
                      { field: "ACC", operator: "startswith", value: 0 },
                      { field: "NLS", operator: "startswith", value: "НБР або рахунок" }
                    ]
                }


            });

            $scope.gridIssuedAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridIssuedAccountsDataSource,
                sortable: true,
                selectable: 'row',
                resizable: true,
                pageable: true,
                filterable: {
                    mode: "row"
                },
                columns: [
                    //{ field: "ACC", title: "Ід. рахунку", width: "20%"  },


                    {
                        field: "ACC", title: "Ід. рахунку", width: "20%", filterable: {
                            cell: {
                                template: function (args) {
                                    args.element.kendoNumericTextBox({
                                        min: 0,
                                        format: "n0"
                                    });
                                }
                            }
                        }
                    },



                    { field: "NLS", title: "Номер рахунку", width: "25%"},
                    { field: "KV", title: "Вал.", width: "10%" },
                    { field: "NMS", title: "Найменування", width: "30%" },
                    //{ field: "DAZS", title: "Дата закриття", width: "15%" }
                    { field: "BRANCH", title: "Відділення", width: "15%" }
                ]
            };
            //выбор строки в левом гриде
            $scope.selectedIssuedAccount = function (data) {
                
                $scope.gridNotIssuedAccounts.select().closest("tr").removeClass("k-state-selected");

                $scope.model.IssuedAcc = data.ACC;
                IssuedAcc = data.ACC;
                if (data.ACC == "0") {
                    $scope.buttonArrowRight = false;
                    $scope.buttonArrowLeft = false;
                }
                else {
                    $scope.buttonArrowRight = true;
                    $scope.buttonArrowLeft = false;
                }

            };
            //добавляем счёт к групе счетов
            $scope.addAccountToGroup = function () {

                bars.ui.confirm({ text: 'Ви дійсно хочете додати рахунок до групи?' },
                    function () {
                        accGroupsService.addAgrp($scope.model).then(
                            function (data) {
                                if (data.Status == "OK") {
                                    bars.ui.alert({ text: "Рахунок додано до групи рахунків " });
                                    $scope.gridIssuedAccounts.dataSource.read();
                                    $scope.gridNotIssuedAccounts.dataSource.read();
                                    $scope.buttonArrowLeft = false;
                                }
                                else {
                                    bars.ui.alert({ text: "Не вдалось додати рахунок до групи" });
                                    console.log(data);
                                }
                            },
                            function (data) {
                                console.log(data);
                                bars.ui.alert({ text: "Не вдалось додати рахунок до групи" });
                            }
                        );
                    });
            };

            // правый грид - не выданых счетов в групу счетов
            $scope.gridNotIssuedAccountsDataSource = new kendo.data.DataSource({
                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccGroups/GetNotIssuedAccounts"),
                        data: {
                            grpId: function () {
                                return grpId;
                            },
                            nls: function () {
                                if ($scope.gridNotIssuedAccountsDataSource.filter() != undefined) {
                                    nls = $scope.gridNotIssuedAccountsDataSource.filter().filters[0].value;
                                    
                                }
                                else {
                                    nls = "";
                                }
                                return nls;
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ACC: { type: "number" },
                            NLS: { type: "string" },
                            KV: { type: "number" },
                            NMS: { type: "string" },
                            DAZS: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1,
                serverFiltering: true,
                filter: { field: "NLS", operator: "startswith", value: "НБР або рахунок" }
            });

            $scope.gridNotIssuedAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridNotIssuedAccountsDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                resizable: true,
                filterable: {
                    mode: "row"
                },
                columns: [
                    { field: "ACC", title: "Ід. рахунку", width: "20%" },
                    { field: "NLS", title: "Номер рахунку", width: "25%" },
                    { field: "KV", title: "Вал.", width: "10%" },
                    { field: "NMS", title: "Найменування", width: "30%" },
                    //{ field: "DAZS", title: "Дата закриття", width: "15%" }
                    { field: "BRANCH", title: "Відділення", width: "15%" }
                ]
            };

            //выбор строки в правом гриде
            $scope.selectedNotIssuedAccount = function (data) {
                
                $scope.gridIssuedAccounts.select().closest("tr").removeClass("k-state-selected");

                NotIssuedAcc = data.ACC;
                $scope.model.IssuedAcc = data.ACC;

                if (data.ACC == "0") {
                    $scope.buttonArrowRight = false;
                    $scope.buttonArrowLeft = false;
                }
                else {
                    $scope.buttonArrowRight = false;
                    $scope.buttonArrowLeft = true;
                }
            };
            // удаляем счёт из групы счетов
            $scope.RemoveAccFromGroup = function () {

                bars.ui.confirm({ text: 'Ви дійсно хочете видалити рахунок з групи?' },
                        function () {
                            accGroupsService.delAgrp($scope.model).then(
                               function (data) {
                                   if (data.Status == "OK") {
                                       bars.ui.alert({ text: "Рахунок прибрано з групи рахунків " });
                                       $scope.gridIssuedAccounts.dataSource.read();
                                       $scope.gridNotIssuedAccounts.dataSource.read();
                                       $scope.buttonArrowLeft = false;
                                   }
                                   else {
                                       bars.ui.alert({ text: "Не вдалось прибрати рахунок з групи рахунків" });
                                       console.log(data);
                                   }
                               },
                              function (data) {
                                  console.log(data);
                                  bars.ui.alert({ text: "Не вдалось прибрати рахунок з групи рахунків" });
                              }
                          );
                        });
            };

        }]);