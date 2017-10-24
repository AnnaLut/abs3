angular.module('BarsWeb.Controllers')
    .controller('AccessToAccounts.MainCtrl', ['$scope', 'mainService', '$rootScope',
        function ($scope, mainService, $rootScope) {

            $scope.loading = false;
            $scope.model = {};

            $scope.gridMainDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                requestStart: function () { return $scope.loading = true },
                requestEnd: function () { return $scope.loading = false },
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetAccounts"),
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            LCV: { type: "string" },
                            NLS: { type: "string" },
                            NMS: { type: "string" },
                            ACC: { type: "number" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,
                pageSize: 20
            });

            $scope.mainOptions = {
                dataBinding: function () { onPageChange() },
                autoBind: true,
                dataSource: $scope.gridMainDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                scrollable: false,
                columns: [
                    {
                        field: "LCV",
                        title: "Валюта",
                        width: "20%",
                    },
                    {
                        field: "NLS",
                        title: "Особистий рахунок",
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
                    {
                        field: "NMS",
                        title: "Найменування рахунку",
                        width: "60%"
                    },
                    {
                        field: "ACC",
                        hidden: true
                    }
                ]
            };

            $scope.gridGroupServingAccountDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetGroupServingAccount"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.Acc } }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,
                pageSize: 4
            });


            $scope.groupServingAccountOptions = {
                dataBinding: function () {
                    $scope.model.IDGroupServingAccount = -1;
                    $scope.model.IDTheGroup = -1;
                    $scope.gridGroupUsersDataSource.read();
                    $scope.gridTheGroupDataSource.read();
                    $scope.gridGroupUsersDataSource.filter({});
                    $scope.gridTheGroupDataSource.filter({});
                    $scope.groupUsersName = null;
                    $scope.theGroup = null;
                    $scope.buttonOpenWindowGroupUsers = false;
                    $scope.buttonOpenWindowTheGroup = false;
                    $scope.buttonDeleteGroupAccount = false;

                },
                autoBind: false,
                dataSource: $scope.gridGroupServingAccountDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                scrollable: false,
                columns: [
                    {
                        field: "ID",
                        title: "Код",
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
                    {
                        field: "NAME",
                        title: "Група",
                        width: "80%"
                    }
                ]
            };

            $scope.gridGroupUsersDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetGroupUsers"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.IDGroupServingAccount } }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ID: { type: "number" },
                            NAME: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,
                pageSize: 5
            });

            $scope.usersGroupOptions = {
                dataBinding: function () {
                    $scope.model.IDTheGroup = -1;
                    $scope.gridTheGroupDataSource.read();
                    $scope.gridTheGroupDataSource.filter({});
                    $scope.theGroup = null;
                    $scope.buttonOpenWindowTheGroup = false;
                    $scope.buttonDeleteGroupUser = false;
                },
                autoBind: false,
                dataSource: $scope.gridGroupUsersDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                scrollable: false,
                columns: [
                    {
                        field: "ID",
                        title: "Код",
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
                    {
                        field: "NAME",
                        title: "Група",
                        width: "80%"
                    }
                ]
            };

            $scope.gridTheGroupDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/AccessToAccounts/AccessToAccountsMain/GetTheGroups"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { ID: $scope.model.IDTheGroup } }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            ID: { type: "number" },
                            FIO: { type: "string" },
                            SECG: { type: "number" },
                            canView: { type: "number" },
                            canDebit: { type: "number" },
                            canCredit: { type: "number" },
                            MARK: { type: "string" }
                        }
                    }
                },
                serverFiltering: true,
                serverPaging: true,
                serverSorting: true,
                pageSize: 5
            });

            $scope.theGroupOptions = {
                rowTemplate: function (data) {

                    if (data.MARK == '+') {
                        return '<tr data-uid="' + data.uid + '" class="rowTemplateGreen"><td>' + data.ID + '</td><td>' + data.FIO + '</td><td><input  ng-model="canView" type="checkbox" ng-checked=" dataItem.canView === 1" ng-change="getCheckedCheckBoxCanView(this)"></td><td><input  ng-model="canDebit" type="checkbox" ng-checked=" dataItem.canDebit === 1" ng-change="getCheckedCheckBoxCanDebit(this)"></td><td><input  ng-model="canCredit" type="checkbox" ng-checked=" dataItem.canCredit === 1" ng-change="getCheckedCheckBoxCanCredit(this)"></td></tr>';
                    }
                    else if (data.MARK == '-') {
                        return '<tr data-uid="' + data.uid + '" class="rowTemplateRed"><td>' + data.ID + '</td><td>' + data.FIO + '</td><td><input  ng-model="canView" type="checkbox" ng-checked=" dataItem.canView === 1" ng-change="getCheckedCheckBoxCanView(this)"></td><td><input  ng-model="canDebit" type="checkbox" ng-checked=" dataItem.canDebit === 1" ng-change="getCheckedCheckBoxCanDebit(this)"></td><td><input  ng-model="canCredit" type="checkbox" ng-checked=" dataItem.canCredit === 1" ng-change="getCheckedCheckBoxCanCredit(this)"></td></tr>';
                    }
                    else {
                        return '<tr data-uid="' + data.uid + '" class="rowTemplateWhite"><td>' + data.ID + '</td><td>' + data.FIO + '</td><td><input   ng-model="canView" type="checkbox"   ng-checked=" dataItem.canView === 1"  ng-change="getCheckedCheckBoxCanView(this)" "></td><td><input  ng-model="canDebit" type="checkbox" ng-checked=" dataItem.canDebit === 1" ng-change="getCheckedCheckBoxCanDebit(this)"></td><td><input  ng-model="canCredit" type="checkbox" ng-checked=" dataItem.canCredit === 1" ng-change="getCheckedCheckBoxCanCredit(this)"></td></tr>';
                    }
                },
                dataBinding: function () {
                    $scope.buttonDeleteUser = false;
                },
                autoBind: false,
                dataSource: $scope.gridTheGroupDataSource,
                sortable: true,
                selectable: 'row',
                pageable: true,
                filterable: true,
                scrollable: false,
                columns: [
                    {
                        field: "ID",
                        title: "Код",
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
                    {
                        field: "FIO",
                        title: "П.І.Б",
                        width: "50%"
                    },
                    {
                        title: "Перегляд",
                        width: "10%"
                    },
                    {
                        title: "Дебет",
                        width: "10%"
                    },
                    {
                        title: "Кредит",
                        width: "10%"
                    },
                    {
                        field: "MARK",
                        hidden: true
                    }

                ]
            };

            $scope.selectedAccount = function (data) {
                $scope.model.Acc = data.ACC;
                $scope.model.IDGroupServingAccount = -1;
                $scope.model.IDTheGroup = -1;
                $scope.groupUsersName = null;
                $scope.theGroup = null;
                $scope.gridGroupServingAccountDataSource.read({ ID: data.ACC });
                $scope.gridGroupServingAccountDataSource.filter({});
                $scope.gridGroupUsersDataSource.filter({});
                $scope.gridTheGroupDataSource.filter({});
                $scope.buttonOpenWindowAddAccountGroup = true;
                $scope.buttonOpenWindowGroupUsers = false;
                $scope.buttonOpenWindowTheGroup = false;
                $scope.buttonDeleteGroupUser = false;
                $scope.buttonDeleteUser = false;
                $scope.buttonSaveCheckBox = false;

                if ($scope.model.changeUserRights == true) {
                    $scope.openWindowSaveChanges();
                }
            }

            $scope.selectedGroupServingAccount = function (data) {
                $scope.model.IDGroupServingAccount = data.ID;
                $scope.gridGroupUsersDataSource.read({ ID: data.ID });
                $scope.gridTheGroupDataSource.read({ ID: -1 });
                $scope.gridGroupUsersDataSource.filter({});
                $scope.theGroup = null;
                $scope.groupUsersName = data.NAME;
                $scope.buttonOpenWindowGroupUsers = true;
                $scope.buttonOpenWindowTheGroup = false;
                $scope.buttonDeleteGroupAccount = true;
                $scope.buttonDeleteUser = false;
                $scope.buttonSaveCheckBox = false;

                if ($scope.model.changeUserRights == true) {
                    $scope.openWindowSaveChanges();
                }
            }

            $scope.selectedGroupUsers = function (data) {
                $scope.model.IDTheGroup = data.ID;
                $scope.gridTheGroupDataSource.read({ ID: data.ID });
                $scope.gridTheGroupDataSource.filter({});
                $scope.theGroup = data.NAME;
                $scope.buttonOpenWindowTheGroup = true;
                $scope.buttonDeleteGroupUser = true;
                $scope.buttonDeleteUser = false;
                $scope.buttonSaveCheckBox = false;

                if ($scope.model.changeUserRights == true) {
                    $scope.openWindowSaveChanges();
                }
            }

            $scope.selectedTheGroup = function (data) {
                $scope.buttonDeleteUser = true;
                $scope.model.UserName = data.FIO;
                $scope.model.UserID = data.ID;

            }

            var onPageChange = function () {
                $scope.model.Acc = -1;
                $scope.model.IDGroupServingAccount = -1;
                $scope.model.IDTheGroup = -1;
                $scope.model.UserID = -1;
                $scope.model.UserName = null;
                $scope.gridGroupServingAccountDataSource.filter({});
                $scope.gridGroupUsersDataSource.filter({});
                $scope.gridTheGroupDataSource.filter({});
                $scope.groupUsersName = null;
                $scope.theGroup = null;
                $scope.buttonOpenWindowAddAccountGroup = false;
                $scope.buttonOpenWindowGroupUsers = false;
                $scope.buttonOpenWindowTheGroup = false;
                $scope.buttonDeleteGroupAccount = false;
                $scope.buttonDeleteGroupUser = false;
                $scope.buttonDeleteUser = false;
                $scope.buttonSaveCheckBox = false;

                if ($scope.model.changeUserRights == true) {
                    $scope.openWindowSaveChanges();
                }
            }

            $scope.openWindowAddAccountGroup = function () {
                var titleName = 'групу рахунків';
                $scope.openWindow(titleName);
                $rootScope.GetDropDownAccountGroup($scope.model.Acc);

            }

            $scope.openWindowGroupUsers = function () {
                var titleName = 'групу кориcтувачів';
                $scope.openWindow(titleName);
                $rootScope.GetDropDownGroupUsers($scope.model.IDGroupServingAccount);
            }

            $scope.openWindowTheGroup = function () {
                var titleName = 'користувачів';
                $scope.openWindow(titleName);
                $rootScope.GetDropDownUsers($scope.model.IDTheGroup);
            }

            $scope.openWindow = function (titleName) {
                $scope.winAddGroup.title("Додати " + titleName);
                $scope.winAddGroup.modal = true;
                $scope.winAddGroup.open().center();
                $rootScope.WinAddGroup = $scope.winAddGroup;
            }


            $scope.groupAccountToolbarOptions = {
                items: [
                     { template: "<button type = 'button' ng-disabled='!buttonOpenWindowAddAccountGroup' ng-click = 'openWindowAddAccountGroup()' class='k-button' ><i class='pf-icon pf-16 pf-add_button'></i>Додати</button>" },
                     { template: "<button type = 'button' ng-disabled='!buttonDeleteGroupAccount' ng-click = 'deleteGroupAccount()' class='k-button' ><i class='pf-icon pf-16 pf-delete'></i>Видалити</button>" }
                ]
            };

            $scope.groupUsersToolbarOptions = {
                items: [
                     { template: "<button type = 'button' ng-disabled='!buttonOpenWindowGroupUsers' ng-click = 'openWindowGroupUsers()' class='k-button' ><i class='pf-icon pf-16 pf-add_button'></i>Додати</button>" },
                     { template: "<button type = 'button' ng-disabled='!buttonDeleteGroupUser' ng-click = 'deleteGroupUser()' class='k-button' ><i class='pf-icon pf-16 pf-delete'></i>Видалити</button>" }
                ]
            };

            $scope.theGroupToolbarOptions = {
                items: [
                     { template: "<button type = 'button' ng-disabled='!buttonOpenWindowTheGroup' ng-click = 'openWindowTheGroup()' class='k-button' ><i class='pf-icon pf-16 pf-add_button'></i>Додати</button>" },
                     { template: "<button type = 'button' ng-disabled='!buttonDeleteUser' ng-click = 'deleteUser()' class='k-button' ><i class='pf-icon pf-16 pf-delete'></i>Видалити</button>" },
                     { template: "<button type = 'button' ng-disabled='!buttonSaveCheckBox' ng-click = 'openWindowSaveChanges(1)' class='k-button' ><i class='pf-icon pf-16 pf-save'></i>Зберегти зміни</button>" }
                ]
            };



            $scope.$on('refreshGridAccountGroup', function () {
                $scope.gridGroupServingAccountDataSource.filter({});
                $scope.gridGroupUsersDataSource.filter({});
                $scope.gridTheGroupDataSource.filter({});
                $scope.gridGroupServingAccountDataSource.read({ ID: $scope.model.Acc });
                $scope.gridGroupUsersDataSource.read({ ID: -1 });
                $scope.gridTheGroupDataSource.read({ ID: -1 });
                $scope.groupUsersName = null;
                $scope.theGroup = null;
                $scope.buttonOpenWindowGroupUsers = false;
                $scope.buttonOpenWindowTheGroup = false;
            });

            $scope.$on('refreshGridAddGroupUsers', function () {
                $scope.gridGroupUsersDataSource.filter({});
                $scope.gridTheGroupDataSource.filter({});
                $scope.gridGroupUsersDataSource.read({ ID: $scope.model.IDGroupServingAccount });
                $scope.gridTheGroupDataSource.read({ ID: -1 });
                $scope.theGroup = null;
                $scope.buttonOpenWindowTheGroup = false;
            });

            $scope.$on('refreshGridUsers', function () {
                $scope.gridTheGroupDataSource.filter({});
                $scope.gridTheGroupDataSource.read({ ID: $scope.model.IDTheGroup });
            });

            $scope.deleteGroupAccount = function () {

                bars.ui.confirm({
                    text: 'Групу рахунків ' + $scope.groupUsersName + ' буде видалено'
                }, function () {

                    mainService.DeleteGroupAccount($scope.model).then(

                             function (data) {
                                 if (data.Status == "OK") {
                                     bars.ui.notify('Успішно видалено ', 'Групу рахунків ' + $scope.groupUsersName, 'success', { autoHideAfter: 3500, });
                                     $scope.gridGroupServingAccountDataSource.filter({});
                                     $scope.gridGroupServingAccountDataSource.read({ ID: $scope.model.Acc });
                                 }
                                 else {
                                     bars.ui.alert({ text: "Не вдалось видалити групу рахунків " + $scope.groupUsersName });
                                 }
                             },
                             function (data) {
                                 bars.ui.alert({ text: " Не вдалось видалити групу рахунків " + $scope.groupUsersName });
                             }
                         );

                });
            }
            $scope.deleteGroupUser = function () {

                bars.ui.confirm({
                    text: 'Групу користувачів ' + $scope.theGroup + ' буде видалено'
                }, function () {

                    mainService.DeleteGroupUser($scope.model).then(

                             function (data) {
                                 if (data.Status == "OK") {
                                     bars.ui.notify('Успішно видалено ', 'Групу користувачів ' + $scope.theGroup, 'success', { autoHideAfter: 3500, });
                                     $scope.gridGroupUsersDataSource.filter({});
                                     $scope.gridGroupUsersDataSource.read({ ID: $scope.model.IDGroupServingAccount });
                                 }
                                 else {
                                     bars.ui.alert({ text: "Не вдалось видалити групу користувачів " + $scope.theGroup });
                                 }
                             },
                             function (data) {
                                 bars.ui.alert({ text: " Не вдалось видалити групу користувачів " + $scope.theGroup });
                             }
                         );

                });
            }

            $scope.deleteUser = function () {

                bars.ui.confirm({
                    text: 'Користувача ' + $scope.model.UserName + ' буде видалено'
                }, function () {

                    mainService.DeleteUser($scope.model).then(

                             function (data) {
                                 if (data.Status == "OK") {
                                     bars.ui.notify('Успішно видалено ', 'Користувача ' + $scope.model.UserName, 'success', { autoHideAfter: 3500, });
                                     $scope.gridTheGroupDataSource.filter({});
                                     $scope.gridTheGroupDataSource.read({ ID: $scope.model.IDTheGroup });
                                 }
                                 else {
                                     bars.ui.alert({ text: "Не вдалось видалити користувача " + $scope.model.UserName });
                                 }
                             },
                             function (data) {
                                 bars.ui.alert({ text: "Не вдалось видалити користувача " + $scope.model.UserName });
                             }
                         );

                });
            }

            $scope.checkedIds = {};

            $scope.getCheckedCheckBoxCanView = function (data) {

                var canView;

                if (data.canView == false) {
                    canView = 0;
                }
                else {
                    canView = 1;
                }

                if ($scope.checkedIds[data.dataItem.ID]) {
                    $scope.checkedIds[data.dataItem.ID].canView = canView;
                }
                else {
                    $scope.checkedIds[data.dataItem.ID] = {
                        GroupID: $scope.model.IDTheGroup,
                        UserID: data.dataItem.ID,
                        canView: canView,
                        canCredit: data.dataItem.canCredit,
                        canDebit: data.dataItem.canDebit
                    }
                }

                $scope.buttonSaveCheckBox = true;
                $scope.model.changeUserRights = true;
            }

            $scope.getCheckedCheckBoxCanDebit = function (data) {

                var canDebit;

                if (data.canDebit == false) {
                    canDebit = 0;
                }
                else {
                    canDebit = 1;
                }

                if ($scope.checkedIds[data.dataItem.ID]) {
                    $scope.checkedIds[data.dataItem.ID].canDebit = canDebit;
                }
                else {
                    $scope.checkedIds[data.dataItem.ID] = {
                        GroupID: $scope.model.IDTheGroup,
                        UserID: data.dataItem.ID,
                        canView: data.dataItem.canView,
                        canCredit: data.dataItem.canCredit,
                        canDebit: canDebit
                    }
                }

                $scope.buttonSaveCheckBox = true;
                $scope.model.changeUserRights = true;
            }

            $scope.getCheckedCheckBoxCanCredit = function (data) {

                var canCredit;

                if (data.canCredit == false) {
                    canCredit = 0;
                }
                else {
                    canCredit = 1;
                }

                if ($scope.checkedIds[data.dataItem.ID]) {
                    $scope.checkedIds[data.dataItem.ID].canCredit = canCredit;
                }
                else {
                    $scope.checkedIds[data.dataItem.ID] = {
                        GroupID: $scope.model.IDTheGroup,
                        UserID: data.dataItem.ID,
                        canView: data.dataItem.canView,
                        canCredit: canCredit,
                        canDebit: data.dataItem.canDebit
                    }
                }

                $scope.buttonSaveCheckBox = true;
                $scope.model.changeUserRights = true;
            }

            $scope.openWindowSaveChanges = function (buttonSave) {
               
                bars.ui.confirm({
                    text: ' Бажаєте зберeгти зміни ?'
                }, function () {

                    mainService.UpdateUser($scope.checkedIds).then(

                             function (data) {
                                 if (data.Status == "OK") {

                                     var count = 0;
                                     var i;

                                     for (i in $scope.checkedIds) {
                                         if ($scope.checkedIds.hasOwnProperty(i)) {
                                             count++;
                                         }
                                     }

                                     if (count > 1) {
                                         bars.ui.notify(' Успішно оновлено ', ' Користувачів групи' + $scope.theGroup, 'success', { autoHideAfter: 3500, });
                                     }
                                     else {
                                         bars.ui.notify(' Успішно оновлено ', ' Користувача групи' + $scope.theGroup, 'success', { autoHideAfter: 3500, });
                                     }
                                     $scope.checkedIds = {};
                                     $scope.model.changeUserRights = false;
                                     $scope.gridTheGroupDataSource.filter({});
                                     $scope.gridTheGroupDataSource.read({ ID: $scope.model.IDTheGroup });
                                     $scope.buttonSaveCheckBox = false;
                                 }
                                 else {

                                     var count = 0;
                                     var i;

                                     for (i in $scope.checkedIds) {
                                         if ($scope.checkedIds.hasOwnProperty(i)) {
                                             count++;
                                         }
                                     }

                                     if (count > 1) {

                                         bars.ui.alert({ text: "Не вдалось оновити  користувачів групи" + $scope.theGroup });
                                     }
                                     else {
                                         bars.ui.alert({ text: "Не вдалось оновити  користувача групи" + $scope.theGroup });
                                     }

                                 }
                             },
                             function (data) {

                                 var count = 0;
                                 var i;

                                 for (i in $scope.checkedIds) {
                                     if ($scope.checkedIds.hasOwnProperty(i)) {
                                         count++;
                                     }
                                 }
                                 if (count > 1) {

                                     bars.ui.alert({ text: "Не вдалось оновити  користувачів групи" + $scope.theGroup });
                                 }
                                 else {
                                     bars.ui.alert({ text: "Не вдалось оновити  користувача групи" + $scope.theGroup });
                                 }
                             }
                         );

                });

                if (buttonSave != 1) {
                    $scope.checkedIds = {};
                    $scope.model.changeUserRights = false;
                }
            }

        }]);

