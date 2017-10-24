angular.module('BarsWeb.Controllers')
    .controller('KFiles.CorporationCtrl', ['$scope', '$http', '$rootScope',
        function ($scope, $http, $rootScope) {

            $scope.mode = false;
            $scope.checkBoxChangeMode = true;
            $scope.model = {};
          
            $scope.tabOptionsFilesCorporation = {
                select: function (e) {
                    if (e.item.innerText == 'Файли корпорації') {
                        $rootScope.getCorporationFiles($scope.model.corporationId);
                    }
                }
            };

            $rootScope.config = {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;'
                }
            };

            $scope.ddlDataSource = {
                //type: 'aspnetmvc-ajax',
                //select: function (e) {
                //    debugger;
                //var dataItem = this.dataItem(e.item.index());
                // $scope.clientAddress.actualModel.SETL_TP_ID = parseInt(dataItem.SETL_TP_ID);
                //},
                serverFiltering: true,
                transport: {
                    read: {
                        url: bars.config.urlContent('/kfiles/kfiles/GetCorporationsList'),
                        data: { mode: $scope.mode },
                        dataType: "json"
                    },
                    schema: {
                        data: "Data",
                        model: {
                            fields: { ID: { type: "number" }, CORPORATION_NAME: { type: "string" } }
                        }
                    }
                }
            };

            $scope.ditem = "";

            $scope.corporationArr = [];

            var dataSource = new kendo.data.TreeListDataSource({
                //requestStart: function () { $scope.Waiting(true); },
                //requestEnd: function () { $scope.Waiting(false); },
                transport: {
                    read: {
                        url: bars.config.urlContent('/kfiles/kfiles/GetCorporations'),
                        data: { mode: $scope.mode, parentid: "" },
                        dataType: "json"
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        id: "ID",
                        parentId: "PARENT_ID",
                        fields: {
                            ID: { type: "number", nullable: false },
                            PARENT_ID: { type: "number", nullable: true },
                            CORPORATION_NAME: { type: "string" },
                            EXTERNAL_ID: { type: "string" },
                            CORPORATION_CODE: { type: "string" },
                            STATE_ID: { type: "number" },
                            CORPORATION_STATE: { type: "string" },
                            PARENT_NAME: { type: "string" }
                        }
                    }
                },
            });

            $scope.treeList;

            $scope.actualDropDownSettlementOptions = {
                select: function (e) {

                    $scope.corporationArr = [];

                    $scope.ditem = this.dataItem(e.item.index());
                    $scope.treeList = angular.element("#treeList").data("kendoTreeList");

                    if ($scope.ditem != null && $scope.ditem.ID != "-1") {
                        dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                    }
                },
                dataBound: function () {
                    var dataSource = this.dataSource;
                    var data = dataSource.data();

                    if (!this._adding) {
                        this._adding = true;
                        
                        data.unshift({
                            "ID": "",
                            "CORPORATION_NAME": "Всі"
                        });

                        data.unshift({
                            "ID": "-1",
                            "CORPORATION_NAME": "Виберіть корпорацію"
                        });

                        this._adding = false;
                        var dropdownlist = this;
                        dropdownlist.value("-1");
                    }

                }
            };

            $rootScope.dataSourceGridCorporations = dataSource;

            $scope.treelistOptions = {
                dataSource: dataSource,

                expand: function (e) {
                    $scope.corporationArr.push(e.model.ID);

                    //if (!e.model.hasChildren) return;
                    //var dataSourceView = $(this)[0].dataSource._view;
                    //for (var i = 0; i < dataSourceView.length; i++) {
                    //    var pid = dataSourceView[i].parentId;

                    //    var Children = dataSourceView[i].hasChildren;
                    //    if (pid == id && Children) {
                    //        var uid = dataSourceView[i].uid;
                    //        $('[data-uid="' + uid + '"] td').css("font-weight", "bold");
                    //    }
                    //}
                },

                collapse: function (e) {
                    var i = $scope.corporationArr.indexOf(e.model.ID);
                    if (i != -1) {
                        $scope.corporationArr.splice(i, 1);
                    }
                },

                dataBound: function (e) {
                    if ($scope.corporationArr.length > 0) {
                        for (i = 0; i < $scope.corporationArr.length; i++) {
                            // find item with id in datasource
                            var dataItem = $scope.treeList.dataSource.get($scope.corporationArr[i]);
                            // find row for data item
                            var row = $scope.treeList.content.find("tr[data-uid=" + dataItem.uid + "]")
                            $scope.treeList.expand(row);
                        }
                    }
                },

                autoBind: false,
                sortable: true,
                selectable: 'row',
                columns: [
                    { field: "CORPORATION_NAME", expandable: true, title: "Назва корпорації або її підрозділу", width: "20%"},
                    { field: "EXTERNAL_ID", title: "Код корпорації/Код установи корпорації", width: "20%" },
                    { field: "CORPORATION_CODE", title: "Код ЄДРПОУ", width: "20%" },
                    { field: "CORPORATION_STATE", title: "Стан корпорації або її підрозділу", width: "20%" },
                    { hidden: true, field: "STATE_ID" },
                    { hidden: true, field: "ID" },
                    { hidden: true, field: "PARENT_NAME" },
                ]
            };

            $scope.toolbarOptions = {
                items: [
                     { template: "<button type = 'button' ng-click = 'addCorporation()' class='k-button' ><i class='pf-icon pf-16 pf-add_button'></i>Додати корпорацію</button>" },
                     { template: "<button ng-click = 'addSubCorporation()' ng-disabled='!buttonAddSubCorporation' class='k-button' title = 'Додати підрозділ' ng-model = 'corporationNameforAddSubCorporation'><i class='pf-icon pf-16 pf-add_button'></i>Додати підрозділ</button>" },
                     { template: "<button ng-click = 'editCorporationOrSubCorporation()' ng-disabled='!buttonEditCorporationOrSubCorporation' ng-model = 'editParentId' class='k-button'><i class='pf-icon pf-16 pf-tool_pencil'></i>Редагувати</button>" },
                     { template: "<button ng-click = 'lockCorporation()' ng-disabled='!buttonlockCorporation'class='k-button' ng-model = 'hasParent'><i class='pf-icon pf-16 pf-security_lock'></i>Блокувати</button>" },
                     { template: "<button ng-click = 'unLockCorporation()' ng-disabled='!buttonUnLockCorporation'class='k-button' ng-model = 'hasParent'><i class='pf-icon pf-16 pf-security_unlock'></i>Розблокувати</button>" },
                     { template: "<button ng-click = 'closeCorporation()' ng-disabled='!buttonCloseCorporation' class='k-button' ng-model = 'hasParent'><i class='pf-icon pf-16 pf-delete_button_error'></i>Закрити</button>" },
                     { template: "<button ng-click = 'changeHierarchyCorporation()' ng-disabled='!buttonChangeHierarchyCorporation' class='k-button'><i class='pf-icon pf-16 pf-tree'></i>Змінити рівень ієрархії</button>" },
                     { template: "<div class = 'containerDisplayClosed'>Відображати закриті <input type= 'checkbox' ng-click = 'changeMode()'  ng-model='mode' ng-disabled = '!checkBoxChangeMode' /></div>" }
                ]
            };

            $scope.changeHierarchyCorporation = function () {

                var parentId = $scope.editParentId;

                $scope.$broadcast('changeHierarchyCorporation', { id: $scope.ID, parentId: parentId });

                $rootScope.windowChangeHierarchyCorporation = $scope.winChangeHierarchyCorporation;

                $scope.winChangeHierarchyCorporation.modal = true;
                $scope.winChangeHierarchyCorporation.open().center();
            }

            $scope.closeForm = function () {
                $scope.PARENT_ID = undefined;
                $scope.buttonAddSubCorporation = false;
                $scope.buttonEditCorporationOrSubCorporation = false;
                $scope.buttonlockCorporation = false;
                $scope.buttonUnLockCorporation = false;
                $scope.buttonCloseCorporation = false;
                $scope.buttonChangeHierarchyCorporation = false;
                $scope.clearForm();
                //dataSource.read({ mode: $scope.mode });

                $scope.form = false;
            }

            $scope.clearForm = function () {
                $scope.CORPORATION_CODE = null;
                $scope.CORPORATION_NAME = null;
                $scope.EXTERNAL_ID = null;
            }


            $scope.closeCorporation = function () {

                var id = parseInt($scope.ID);

                if ($scope.hasParent == null) {

                    bars.ui.confirm({
                        text: 'Корпорація ' + $scope.CORPORATION_NAME + ' та всі її підрозділи  будуть закриті і не зможуть бути повернуті в список діючих'
                    }, function () { $scope.sendDataCloseCorporation(id); });
                }
                else {
                    bars.ui.confirm({
                        text: 'Підрозділ ' + $scope.CORPORATION_NAME + ' та всі її підрозділи  будуть закриті і не зможуть бути повернуті в список діючих'
                    }, function () { $scope.sendDataCloseCorporation(id); });
                }
            }

            $scope.unLockCorporation = function () {

                var id = parseInt($scope.ID);

                if ($scope.hasParent == null) {

                    bars.ui.confirm({
                        text: 'Корпорацію ' + $scope.CORPORATION_NAME + ' буде розблоковано'
                    }, function () { $scope.sendDataUnlockCorporation(id); });
                }
                else {
                    bars.ui.confirm({
                        text: 'Підрозділ ' + $scope.CORPORATION_NAME + ' буде розблоковано'
                    }, function () { $scope.sendDataUnlockCorporation(id); });
                }
            }

            $scope.lockCorporation = function () {

                var id = parseInt($scope.ID);

                if ($scope.hasParent == null) {

                    bars.ui.confirm({
                        text: 'Корпорація ' + $scope.CORPORATION_NAME + ' буде заблокована'
                    }, function () { $scope.sendDatalockCorporation(id); });
                }
                else {
                    bars.ui.confirm({
                        text: 'Підрозділ ' + $scope.CORPORATION_NAME + ' буде заблоковано'
                    }, function () { $scope.sendDatalockCorporation(id); });
                }
            }

            $scope.sendDataCloseCorporation = function (id) {

                var corporationName = $scope.CORPORATION_NAME;

                $http.get('/barsroot/KFiles/KFiles/CloseCorporation?ID=' + id, $rootScope.config)
                    .success(function (data) {
                        if (data.Status == "ERROR") {
                            bars.ui.error({ text: data.Message });
                        }
                        if (data.Status == "OK") {
                            if ($scope.parentNameForCheck == null) {
                                bars.ui.alert({ text: "Корпорацію " + corporationName + " закрито" });
                            }
                            else {
                                bars.ui.alert({ text: "Підрозділ " + corporationName + " закрито " });
                            }
                        }
                    })
                   .error(function (status) {
                       bars.ui.error({ text: data.Message });
                   })
                    ["finally"](function () {
                        $scope.closeForm();
                        dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                    });
            }

            $scope.sendDatalockCorporation = function (id) {

                var corporationName = $scope.CORPORATION_NAME;

                $http.get('/barsroot/KFiles/KFiles/LockCorporation?ID=' + id, $rootScope.config)
                    .success(function (data) {
                        if (data.Status == "ERROR") {
                            bars.ui.error({ text: data.Message });
                        }
                        if (data.Status == "OK") {
                            if ($scope.parentNameForCheck == null) {
                                bars.ui.alert({ text: "Корпорацію " + corporationName + " заблоковано" });
                            }
                            else {
                                bars.ui.alert({ text: "Підрозділ " + corporationName + " заблоковано " });
                            }
                        }
                    })
                   .error(function (status) {
                       bars.ui.error({ text: data.Message });
                   })
                    ["finally"](function () {
                        dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                        $scope.closeForm();
                    });
            }

            $scope.sendDataUnlockCorporation = function (id) {

                var corporationName = $scope.CORPORATION_NAME;

                $http.get('/barsroot/KFiles/KFiles/UnLockCorporation?ID=' + id, $rootScope.config)
                    .success(function (data) {
                        if (data.Status == "ERROR") {
                            bars.ui.error({ text: data.Message });
                        }
                        if (data.Status == "OK") {
                            if ($scope.parentNameForCheck == null) {
                                bars.ui.alert({ text: "Корпорацію " + corporationName + " розблоковано" });
                            }
                            else {
                                bars.ui.alert({ text: "Підрозділ " + corporationName + " розблоковано" });
                            }
                        }
                    })
                   .error(function (status) {
                       bars.ui.error({ text: data.Message });
                   })
                    ["finally"](function () {
                        dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                        $scope.closeForm();
                    });
            }

            $scope.sendEditCorporationOrSubCorpotation = function () {

                var id = parseInt($scope.ID)

                var data = $.param({
                    ID: id,
                    CORPORATION_CODE: $scope.CORPORATION_CODE,
                    CORPORATION_NAME: $scope.CORPORATION_NAME,
                    EXTERNAL_ID: $scope.EXTERNAL_ID
                });

                $http.post('/barsroot/KFiles/KFiles/EditCorporation', data, $rootScope.config)
                .success(function (data) {
                    if (data.Status == "ERROR") {
                        bars.ui.error({ text: data.Message });
                    }
                    if (data.Status == "OK") {
                        if ($scope.parentNameForCheck == null) {
                            bars.ui.alert({ text: "Корпорацію відредаговано" });
                        }
                        else {
                            bars.ui.alert({ text: "Підрозділ відредаговано" });
                        }
                    }
                })
                .error(function (status) {
                    bars.ui.error({ text: data.Message });
                })
                ["finally"](function () {
                   
                    $scope.ddl.dataSource.read();
                    dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                    $scope.closeForm();
                });;
            }

            $scope.addNewCorporationOrSubCorporation = function () {

                var parentId = 0;

                if ($scope.PARENT_ID != undefined) {
                    parentId = $scope.PARENT_ID;
                }
                var data = $.param({
                    CORPORATION_NAME: $scope.CORPORATION_NAME,
                    CORPORATION_CODE: $scope.CORPORATION_CODE,
                    EXTERNAL_ID: $scope.EXTERNAL_ID,
                    PARENT_ID: parentId
                });

                $http.post('/barsroot/KFiles/KFiles/AddCorporationOrSubCorporation', data, $rootScope.config)
                .success(function (data) {
                    if (data.Status == "ERROR") {
                        bars.ui.error({ text: data.Message });
                    }
                    if (data.Status == "OK") {
                        if (parentId == 0) {
                            bars.ui.alert({ text: "Корпорацію додано" });
                        }
                        else {
                            bars.ui.alert({ text: "Підрозділ додано" });
                        }
                    }
                })
                .error(function (status) {
                    bars.ui.error({ text: data.Message });
                })
                ["finally"](function () {

                    $scope.ddl.dataSource.read();
                    dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                    $scope.closeForm();
                });;


            }

            $scope.addCorporation = function () {
                $scope.clearForm();
                $scope.PARENT_ID = undefined;
                $scope.showButtonAddNewCorporationOrSubCorporation = true;
                $scope.showButtonEditCorporationOrSubCorporation = false;
                $scope.formTitle = 'Додати корпорацію';
                $scope.form = true;
                $scope.parentCorporation = false;
            };

            $scope.addSubCorporation = function () {
                $scope.clearForm();
                $scope.parentCorporationName = $scope.corporationNameforAddSubCorporation;
                $scope.showButtonAddNewCorporationOrSubCorporation = true;
                $scope.showButtonEditCorporationOrSubCorporation = false;
                $scope.formTitle = 'Додати підрозділ';
                $scope.form = true;
            }

            $scope.editCorporationOrSubCorporation = function () {

                $scope.showButtonAddNewCorporationOrSubCorporation = false;
                $scope.showButtonEditCorporationOrSubCorporation = true;
                $scope.parentCorporation = false;
                $scope.formTitle = 'Редагувати';
                $scope.form = true;

                if ($scope.editParentId != null) {
                    $scope.parentCorporation = true;
                }

            }

            $scope.selectedRow = function (kendoEvent) {
                var treeList = kendoEvent.sender;
                var selectedData = treeList.dataItem(treeList.select());
                //$scope.expandedRowUid = selectedData.ID;
                $scope.isActiveTabFileCorporation(selectedData);

                if (selectedData.STATE_ID == 3) {
                    if (selectedData.PARENT_NAME != null) {
                        treeList.select().closest("tr").removeClass("k-state-selected");
                    }
                    $scope.PARENT_ID = undefined;
                    $scope.buttonAddSubCorporation = false;
                    $scope.buttonEditCorporationOrSubCorporation = false;
                    $scope.buttonlockCorporation = false;
                    $scope.buttonUnLockCorporation = false;
                    $scope.buttonCloseCorporation = false;
                    $scope.buttonChangeHierarchyCorporation = false;
                }

                if (selectedData.STATE_ID != 3) {
                    if (selectedData.PARENT_NAME == null) {

                        $scope.parentCorporationName = selectedData.CORPORATION_NAME;
                        $scope.hasParent = selectedData.PARENT_NAME;
                        $scope.buttonChangeHierarchyCorporation = false;
                    }
                    else {
                        $scope.hasParent = selectedData.PARENT_NAME;
                        $scope.parentCorporationName = selectedData.PARENT_NAME;
                        $scope.buttonChangeHierarchyCorporation = true;
                    }
                    $scope.corporationNameforAddSubCorporation = selectedData.CORPORATION_NAME;
                    $scope.parentCorporation = true;
                    $scope.editParentId = selectedData.PARENT_ID;
                    $scope.PARENT_ID = selectedData.ID
                    $scope.ID = selectedData.ID;
                    $scope.buttonEditCorporationOrSubCorporation = true;
                    $scope.buttonAddSubCorporation = true;
                    $scope.buttonlockCorporation = true;
                    $scope.buttonCloseCorporation = true;
                    $scope.buttonUnLockCorporation = false;
                    $scope.CORPORATION_CODE = selectedData.CORPORATION_CODE;
                    $scope.EXTERNAL_ID = selectedData.EXTERNAL_ID;
                    $scope.CORPORATION_NAME = selectedData.CORPORATION_NAME;
                    $scope.parentNameForCheck = selectedData.PARENT_NAME;
                }

                if (selectedData.STATE_ID == 2) {
                    $scope.buttonlockCorporation = false;
                    $scope.buttonUnLockCorporation = true;
                }
            };

            $scope.isActiveTabFileCorporation = function (selectedData) {
                if (selectedData.PARENT_NAME == null) {
                    $scope.unLockTabFilesCorporation = true;
                    $scope.model.corporationId = selectedData.ID;
                }
                else {
                    $scope.unLockTabFilesCorporation = false;
                }
            }

            $scope.blockBackSpace = function (event) {
                if (event.keyCode === 8) {
                    event.preventDefault();
                }
            }

            $scope.changeMode = function () {
                $scope.unLockTabFilesCorporation = false;
                $scope.buttonAddSubCorporation = false;
                $scope.buttonEditCorporationOrSubCorporation = false;
                $scope.buttonlockCorporation = false;
                $scope.buttonUnLockCorporation = false;
                $scope.buttonCloseCorporation = false;
                $scope.buttonChangeHierarchyCorporation = false;
                $scope.PARENT_ID = undefined;

                if ($scope.mode == false) {
                    $scope.mode = true;

                    //dataSource.read({ mode: $scope.mode });
                    dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                }
                else if ($scope.mode == true) {
                    $scope.mode = false;
                    //dataSource.read({ mode: $scope.mode });
                    dataSource.read({ mode: $scope.mode, parentid: $scope.ditem.ID });
                }
            }

            /*------------------------------------------------*/
            //$scope.displayLoading = function (target) {
                //var element = $(target);
                //kendo.ui.progress(element, true);

            //    setTimeout(function () {
            //        kendo.ui.progress(element, false);
            //    }, 2000);
            //}


            //$scope.Waiting = function (flag) {
            //    $scope.WaitingForID(flag, ".search-main");
            //}

            //$scope.WaitingForID = function (flag, ID) {
            //    kendo.ui.progress($(ID), flag);
            //}

            /*------------------------------------------------*/

        }]);


