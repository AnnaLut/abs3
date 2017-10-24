angular.module('BarsWeb.Controllers')
    .controller('AccessToAccounts.MainCtrl', ['$scope', 'changeGroupsService',
        function ($scope, changeGroupsService) {

            $scope.model = {};

            $scope.gridGroupsDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsUsers/GetGroups"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" },
                            BRANCH: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10,
            });

            $scope.gridGroupsOptions = {
                autoBind: true,
                dataSource: $scope.gridGroupsDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                columns: [
                    {
                        field: "ID",
                        title: "Ідентифікатор",
                        width: "20%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    { field: "NAME", title: "Найменування групи користувачів", width: "50%" },
                    { field: "BRANCH", title: "Код/назва регіонального управління", width: "30%" }
                ]
            };

            $scope.gridUserGroupsDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsUsers/GetUserGroups"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.GroupID } }
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
                serverFiltering: true,
                pageSize: 10
            });

            $scope.gridUserGroupsOptions = {
                dataSource: $scope.gridUserGroupsDataSource,
                sortable: true,
                filterable: true,
                selectable: 'row',
                pageable: true,
                columns: [
                    {
                        field: "ID",
                        title: "Ідентифікатор",
                        width: "20%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    { field: "NAME", title: "Найменування", width: "50%" }
                ]
            };

            $scope.gridAccountsGroupsDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsUsers/GetAccountsGroups"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.GroupID } }
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
                serverFiltering: true,
                pageSize: 10
            });

            $scope.gridAccountsGroupsOptions = {
                dataSource: $scope.gridAccountsGroupsDataSource,
                sortable: true,
                filterable: true,
                selectable: 'row',
                pageable: true,
                columns: [
                    {
                        field: "ID",
                        title: "Ідентифікатор",
                        width: "20%",
                        filterable: {
                            ui: function (element) {
                                element.kendoNumericTextBox({
                                    min: 0,
                                    format: "n0"
                                });
                            }
                        }
                    },
                    { field: "NAME", title: "Найменування", width: "50%" }
                ]
            };

            $scope.selectedGroups = function (data) {
                $scope.model.GroupID = data.ID;
                $scope.buttonArrowLeft = false;
                $scope.buttonArrowRight = false;
                $scope.gridUserGroupsDataSource.read({ ID: data.ID });
                $scope.gridUserGroupsDataSource.filter({});
                $scope.gridAccountsGroupsDataSource.read({ ID: data.ID });
                $scope.gridAccountsGroupsDataSource.filter({});;
            }

            $scope.selectedUserGroups = function (data) {
                $scope.buttonArrowRight = true;
                $scope.buttonArrowLeft = false;
                $scope.gridAccountsGroups.select().closest("tr").removeClass("k-state-selected");
                $scope.model.ID = data.ID;
            }

            $scope.selectedAccountsGroups = function (data) {
                $scope.buttonArrowLeft = true;
                $scope.buttonArrowRight = false;
                $scope.gridUserGroups.select().closest("tr").removeClass("k-state-selected");
                $scope.model.ID = data.ID;
            }

            $scope.changeUserGroup = function () {

                changeGroupsService.changeUserGroup($scope.model).then(
                        function (data) {
                            if (data.Status == "OK") {
                                bars.ui.alert({ text: " Видалено групу рахунків " });
                                $scope.gridAccountsGroupsDataSource.read({ ID: $scope.model.GroupID });
                                $scope.gridUserGroupsDataSource.read({ ID: $scope.model.GroupID });
                                $scope.buttonArrowRight = false;
                            }
                            else {
                                bars.ui.alert({ text: "Не вдалось видалити групу рахунків" });
                            }
                        },
                        function (data) {
                            bars.ui.alert({ text: " Не вдалось видалити групу рахунків " });
                        }
                    );

            }

            $scope.changeAccountsGroup = function () {

                changeGroupsService.changeAccountsGroup($scope.model).then(
                        function (data) {
                            if (data.Status == "OK") {
                                bars.ui.alert({ text: " Додано групу рахунків " });
                                $scope.gridAccountsGroupsDataSource.read({ ID: $scope.model.GroupID });
                                $scope.gridUserGroupsDataSource.read({ ID: $scope.model.GroupID });
                                $scope.buttonArrowLeft = false;
                            }
                            else {
                                bars.ui.alert({ text: "Не вдалось додати групу рахунків" });
                            }
                        },
                        function (data) {
                            bars.ui.alert({ text: " Не вдалось додати групу рахунків " });
                        }
                    );

            }

        }]);