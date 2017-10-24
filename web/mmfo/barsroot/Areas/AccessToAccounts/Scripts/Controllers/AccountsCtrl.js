angular.module('BarsWeb.Controllers')
    .controller('AccessToAccounts.AccountsCtrl', ['$scope', 'accountsService',
        function ($scope, accountsService) {

            $scope.model = {};

            $scope.gridAccountsDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccounts/GetAccounts"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" },
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10,
            });

            $scope.accountsOptions = {
                autoBind: true,
                dataSource: $scope.gridAccountsDataSource,
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
                    { field: "NAME", title: "Найменування групи користувачів", width: "50%" }
                ]
            };

            $scope.gridLeftUsersDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccounts/GetLeftUsers"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.AccountID } }
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" },
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10
            });

            $scope.LeftUsersOptions = {
                dataSource: $scope.gridLeftUsersDataSource,
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

            $scope.gridRightUsersDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccounts/GetRightUsers"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.AccountID } }
                    }
                },
                schema: {
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" },
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10
            });

            $scope.RightUsersOptions = {
                dataSource: $scope.gridRightUsersDataSource,
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

            $scope.selectedAccount = function (data) {

                $scope.model.AccountID = data.ID;
                $scope.buttonArrowLeft = false;
                $scope.buttonArrowRight = false;
                $scope.gridLeftUsersDataSource.read({ ID: data.ID });
                $scope.gridLeftUsersDataSource.filter({});
                $scope.gridRightUsersDataSource.read({ ID: data.ID });
                $scope.gridRightUsersDataSource.filter({});
            }

            $scope.selectedLeftUser = function (data) {

                $scope.buttonArrowRight = true;
                $scope.buttonArrowLeft = false;
                $scope.gridRightUsers.select().closest("tr").removeClass("k-state-selected");
                $scope.model.ID = data.ID;
            }

            $scope.selectedRightUser = function (data) {

                $scope.buttonArrowRight = false;
                $scope.buttonArrowLeft = true;
                $scope.gridLeftUsers.select().closest("tr").removeClass("k-state-selected");
                $scope.model.ID = data.ID;
            }

            $scope.changeLeftUser = function () {

                accountsService.changeLeftUser($scope.model).then(

                        function (data) {
                            if (data.Status == "OK") {
                                bars.ui.alert({ text: " Видалено групу користувачів " });
                                $scope.gridLeftUsersDataSource.read({ ID: $scope.model.AccountID });
                                $scope.gridRightUsersDataSource.read({ ID: $scope.model.AccountID });
                                $scope.buttonArrowRight = false;
                            }
                            else {
                                bars.ui.alert({ text: "Не вдалось видалити групу користувачів" });
                            }
                        },
                        function (data) {
                            bars.ui.alert({ text: " Не вдалось видалити групу користувачів " });
                        }
                    );
            }

            $scope.changeRightUser = function () {

                accountsService.changeRightUser($scope.model).then(

                        function (data) {
                            if (data.Status == "OK") {
                                bars.ui.alert({ text: " Додано групу користувачів " });
                                $scope.gridLeftUsersDataSource.read({ ID: $scope.model.AccountID });
                                $scope.gridRightUsersDataSource.read({ ID: $scope.model.AccountID });
                                $scope.buttonArrowLeft = false;
                            }
                            else {
                                bars.ui.alert({ text: "Не вдалось додати групу користувачів" });
                            }
                        },
                        function (data) {
                            bars.ui.alert({ text: " Не вдалось додати групу користувачів " });
                        }
                    );
            }


        }]);