angular.module('BarsWeb.Controllers')
    .controller('AccessToAccounts.AddGroupCtrl', ['$scope', 'mainService', '$rootScope',
        function ($scope, mainService, $rootScope) {

            $scope.model = {};

            $rootScope.GetDropDownAccountGroup = function (id) {
                
                $scope.btnAddAccountGroup = true;
                $scope.model.Acc = id;

                $scope.winAddGroupDataSource = {
                    transport: {
                        read: {
                            type: "GET",
                            url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetDropDownAccountGroup"),
                            data: function () { return { ID: id } }
                        }
                    }
                };
            }

            $rootScope.GetDropDownGroupUsers = function (id) {

                $scope.btnAddGroupUsers = true;
                $scope.model.IDGroupServingAccount = id;

                $scope.winAddGroupDataSource = {
                    transport: {
                        read: {
                            type: "GET",
                            url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetDropDownGroupUsers"),
                            data: function () { return { ID: id } }
                        }
                    }
                };
            }

            $rootScope.GetDropDownUsers = function (id) {

                $scope.btnAddUser = true;
                $scope.model.IDTheGroup = id;

                $scope.winAddGroupDataSource = {
                    transport: {
                        read: {
                            type: "GET",
                            url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetDropDownUsers"),
                            data: function () { return { ID: id } }
                        }
                    }
                };
            }

            $scope.closeWinAddGroup = function () {
                $scope.WinAddGroup.close();
                $scope.selectedID = null;
                $scope.btnAddAccountGroup = false;
                $scope.btnAddGroupUsers = false;
                $scope.btnAddUser = false;
            }

            $scope.AddAccountGroup = function () {

                $scope.model.ID = $scope.selectedID;

               mainService.AddAccountGroup($scope.model).then(

                        function (data) {
                            if (data.Status == "OK") {
                                bars.ui.alert({ text: " Додано групу рахунків " });
                                $scope.closeWinAddGroup();
                                $scope.$emit('refreshGridAccountGroup');
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

            $scope.AddGroupUsers = function () {

                $scope.model.ID = $scope.selectedID;

                mainService.AddGroupUsers($scope.model).then(

                         function (data) {
                             if (data.Status == "OK") {
                                 bars.ui.alert({ text: " Додано групу користувачів " });
                                 $scope.closeWinAddGroup();
                                 $scope.$emit('refreshGridAddGroupUsers');
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

            $scope.AddUser = function () {

                $scope.model.ID = $scope.selectedID;

                mainService.AddUser($scope.model).then(

                         function (data) {
                             if (data.Status == "OK") {
                                 bars.ui.alert({ text: " Додано користувача " });
                                 $scope.closeWinAddGroup();
                                 $scope.$emit('refreshGridUsers');
                             }
                             else {
                                 bars.ui.alert({ text: "Не вдалось додати користувача" });
                             }
                         },
                         function (data) {
                             bars.ui.alert({ text: " Не вдалось додати користувача " });
                         }
                     );
            }

       }]);