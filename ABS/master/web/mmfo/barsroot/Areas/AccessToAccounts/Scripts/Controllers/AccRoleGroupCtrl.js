angular.module('BarsWeb.Controllers')
    .controller('RoleGroupsCtrl', ['$scope',
        function ($scope) {
            angular.element('#mydiv').hide();
            var grpId = 0;
            var data = null;
            var nls = 0;
            var filter = null;
            var IssuedAcc = null;
            var NotIssuedAcc = null;
            var ready1 = false, ready2 = false, ready3 = false, ready4 = false, ready5 = false;

            $scope.model = {};

            // верхний грид - групы
            $scope.gridRoleGroupsDataSource = new kendo.data.DataSource({
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetAccRoleGroups"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { grpId: $scope.model.ID } }
                    }
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                schema: {
                    total: "Total",
                    data: "Data",
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

            $scope.GetFilterValue = function (type) {
                debugger;
                $.ajax({
                    url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetFilterValue") + "?grpId=" + $scope.grpId,
                    method: "GET",
                    dataType: "json",
                    async: false,
                    complete: function (data) {
                        $scope.filter = data.responseJSON;
                    }
                });
                return $scope.filter;
            };

            $scope.gridRoleGroupsOptions = {
                autoBind: true,
                dataSource: $scope.gridRoleGroupsDataSource,
                change: function () {

                },
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                },
                sortable: true,
                selectable: 'row',
                pageable: true,
                columns: [
                    { field: "ID", title: "Код групи", width: "20%", filterable: { format: "{0:n0}" }},
                    { field: "NAME", title: "Назва групи", width: "50%" }
                ]
            };

            //выбор строки в верхнем гриде
            $scope.selectedGroup = function (data) {
                angular.element('#mydiv').show();
                $scope.grpId = data.ID;
                $scope.GetFilterValue();
                $scope.gridGrpAccountsSource.filter({ field: "NLS", operator: "startswith", value: $scope.filter });
                $scope.gridNotIssuedAccounts.dataSource.read();
                $scope.gridIssuedAccounts.dataSource.read();
                $scope.gridAccounts.dataSource.read();
                $scope.gridGrpAccounts.dataSource.read();

            };

            $scope.gridIssuedAccountsDataSource = new kendo.data.DataSource({
                type: 'webapi',
                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetRoles"),
                        data: {
                            grpId: function () {
                                return $scope.grpId;
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                error: function () {
                    ready1 = true;
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                schema: {
                    total: "Total",
                    data: "Data",
                    model: {
                        fields: {
                            ROLE_CODE: { type: "string" },
                            ROLE_STATE_ID: { type: "number" }
                        }
                    }

                },
                pageSize: 10,
                page: 1,
                serverFiltering: true
            });
            $scope.gridIssuedAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridIssuedAccountsDataSource,
                sortable: true,
                dataBound: function dataBound(e) {
                    var grid = $("#roles").data("kendoGrid");
                    var gridData = grid.dataSource.view();

                    for (var i = 0; i < gridData.length; i++) {
                        if (gridData[i].ROLE_STATE_ID == 1) {
                            grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("one-row");
                        }
                        if (gridData[i].ROLE_STATE_ID == 2) {
                            grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("two-row");
                        }
                        if (gridData[i].ROLE_STATE_ID == 3) {
                            grid.table.find("tr[data-uid='" + gridData[i].uid + "']").addClass("three-row");
                        }
                    }
                    ready1 = true;
                    if (ready1 && ready2 && ready3 && ready4) {
                        angular.element('#mydiv').hide();
                        ready1 = false;
                    }
                },
                selectable: 'row',
                pageable: true,
                columns: [
                    {
                        field: "ROLE_CODE", title: "Код ролі", width: "15%", format: "{0:0}"},
                    { field: "ROLE_STATE_ID", title: "Код стану ролі", width: "25%", hidden: true }
                ]
            };


            $scope.gridNotIssuedAccountsDataSource = new kendo.data.DataSource({
                type: 'webapi',

                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetUsers"),
                        data: {
                            grpId: function () {
                                return $scope.grpId;
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                error: function () {
                    ready2 = true;
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                schema: {
                    total: "Total",
                    data: "Data",
                    model: {
                        fields: {
                            ID: { type: "number" },
                            USER_NAME: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1

            });
            $scope.gridNotIssuedAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridNotIssuedAccountsDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                dataBound: function () {
                    ready2 = true;
                    if (ready1 && ready2 && ready3 && ready4) {
                        angular.element('#mydiv').hide();
                        ready2 = false;
                    }
                },
                columns: [
                    { field: "USER_NAME", title: "ФІО", width: "15%" },
                    { field: "BRANCH", title: "Бранч", width: "25%" }
                ]
            };


            $scope.gridGrpAccountsSource = new kendo.data.DataSource({
                type: 'webapi',

                transport: {
                    read: {
                       url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetGrpAccounts"),
                        data: {
                            grpId: function () {
                                return $scope.grpId;
                            },
                            myfilter: function () {
                                var Grid = $("#gridGrpAccounts").data("kendoGrid");
                                return Grid.dataSource.filter().filters[0].value;
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                error: function () {
                    ready3 = true;
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                schema: {
                    total: "Total",
                    data: "Data",
                    model: {
                        fields: {
                            KV: { type: "number" },
                            NLS: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                pageSize: 10,
                page: 1

            });
            $scope.gridGrpAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridGrpAccountsSource,
                sortable: true,
                selectable: 'row',
                filterable: {
                    extra: false,
                    operators: {
                        string: {
                            startswith: "Починається з",
                            eq: "Рівне"
                        }
                    }
                },
                dataBound: function(){
                   // $scope.gridGrpAccountsSource.filter({ field: "NLS", operator: "startswith", value: "1001" });
                    // 
                    ready3 = true;
                    if (ready1 && ready2 && ready3 && ready4) {
                        angular.element('#mydiv').hide();
                        ready3 = false;
                    }
                },
                pageable: true,
                columns: [
                    {field: "NLS", title: "Рахунок", width: "15%"},
                    { field: "KV", title: "Валюта", width: "25%", filterable: false },
                    { field: "BRANCH", title: "Бранч", width: "15%", filterable: true }
                ]
            };


            $scope.gridAccountsSource = new kendo.data.DataSource({
                type: 'webapi',

                transport: {
                    read: {
                        url: bars.config.urlContent("/AccessToAccounts/AccessRoleGroups/GetAccounts"),
                        data: {
                            grpId: function () {
                                return $scope.grpId;
                            }
                        },
                        dataType: 'json',
                        cache: false
                    }
                },
                error: function () {
                    ready4 = true;
                },
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                serverGrouping: true,
                serverAggregates: true,
                schema: {
                    total: "Total",
                    data: "Data",
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
            $scope.gridAccountsOptions = {
                autoBind: false,
                dataSource: $scope.gridAccountsSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                dataBound: function () {
                    ready4 = true;
                    if (ready1 && ready2 && ready3 && ready4) {
                        angular.element('#mydiv').hide();
                        ready4 = false;
                    }
                    },
                columns: [
                    { field: "ID", title: "Код", width: "15%" },
                    { field: "NAME", title: "Назва групи", width: "25%" }
                ]
            };
        }]);