angular.module(globalSettings.modulesAreas)
    .controller('ClearAddressMailCtrl',
        function ($scope) {

            var vm = this;

            vm.regionForChoose = [];
            vm.areaForChoose = [];
            vm.settlementForChoose = [];
            vm.streetForChoose = [];
            vm.houseForChoose = [];

            vm.mailModel = $scope.clrAdr.mailModel;

            vm.changeIndex = function (index) {
                vm.mailModel.addressIndex = parseInt(index);
            }

            vm.regionOptions = $scope.clrAdr.regionOptions;

            vm.regionOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.selectedRegion(dataItem);
                $scope.$apply();
            }

            vm.regionDataSource = $scope.clrAdr.regionDataSource;

            vm.regionDataSource.requestEnd = function (data) {
                vm.regionForChoose = data.response;
            }


            vm.changeRegion = function (regionName) {
                if (regionName !== vm.mailModel.regionName) {
                    vm.mailModel.regionId = null;
                    vm.mailModel.regionName = regionName;
                }
                vm.disabledStreet = vm.disabledStreetType = regionName === "" || vm.settlementEdit === "" || vm.settlementEdit === undefined ? true : false;
            }

            vm.areasOptions = $scope.clrAdr.areasOptions;
            vm.areaDataSource = $scope.clrAdr.areaDataSource;

            vm.areaDataSource.transport.read.data = function () {
                return { columnName: "AREA_NM", regionId: vm.mailModel.regionId }
            }

            vm.areaDataSource.requestEnd = function (data) {
                vm.areaForChoose = data.response;
            }

            vm.areasOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.selectedArea(dataItem);
                $scope.$apply();
            }

            vm.changeArea = function (areaName) {
                if (areaName !== vm.mailModel.areaName) {
                    vm.mailModel.areaId = null;
                    vm.mailModel.areaName = areaName;
                }
                vm.disableRegion = vm.mailModel.areaId ? true : false;
            }

            vm.settlementDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.settlementDropDownOptions.dataBound = $scope.clrAdr.settlementDropDownBoundFunc.BoundFunction;

            vm.changeSettlementType = function (settlementType) {
                vm.mailModel.settlementTypeId = settlementType === "0" || settlementType === null ? null : parseInt(settlementType);
            }

            vm.settlementOptions = $scope.clrAdr.settlementOptions;
            vm.settlementDataSource = $scope.clrAdr.settlementDataSource;

            vm.settlementDataSource.transport.read.data = function () {
                return { columnName: "SETL_NM", regionId: vm.mailModel.regionId, areaId: vm.mailModel.areaId }
            }

            vm.settlementDataSource.requestEnd = function (data) {
                vm.settlementForChoose = data.response;
            }

            vm.settlementOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.selectedSettlement(dataItem);
                $scope.$apply();
            }

            vm.changeSettlement = function (settlementName) {
                if (settlementName !== vm.mailModel.settlementName) {
                    vm.mailModel.settlementId = null;
                    vm.mailModel.settlementName = settlementName;
                    vm.disableSettlementType = false;
                }

                if (!settlementName) {
                    vm.mailModel.settlementTypeId = vm.settlementType = 0;
                }

                vm.disabledStreet = vm.disabledStreetType = settlementName === "" || vm.mailModel.regionName === "" || vm.mailModel.regionName === null ? true : false;
                vm.disableRegion = vm.disableArea = vm.mailModel.settlementId ? true : false;
            }


            vm.streetDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.streetDropDownOptions.dataBound = $scope.clrAdr.streetDropDownBoundFunc.BoundFunction;

            vm.streetDropDownOptions.select = function (e) {
                var item = e.item;
                vm.mailModel.streetTypeNm = item.text();
                vm.mailModel.streetTypeId = item.index();
            }

            vm.streetOptions = $scope.clrAdr.streetOptions;
            vm.streetDataSource = $scope.clrAdr.streetDataSource;

            vm.streetDataSource.transport.read.data = function () {
                return { columnName: "STR_NM", settlementId: vm.mailModel.settlementId }
            }

            vm.streetDataSource.requestEnd = function (data) {
                vm.streetForChoose = data.response;
            }

            vm.streetOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.mailModel.streetTypeId = vm.streetType = dataItem.STR_TP_ID;
                vm.mailModel.streetTypeNm = dataItem.STR_TP_NM;
                vm.mailModel.streetName = dataItem.STR_NM;
                vm.mailModel.streetId = dataItem.STR_ID;
                vm.disabledStreetType = true;
                $scope.$apply();
            }

            vm.changeStreet = function (streetName) {
                if (streetName !== vm.mailModel.streetName) {
                    vm.mailModel.streetId = null;
                    vm.mailModel.streetName = streetName;
                    vm.disabledStreetType = false;
                }

                if (!streetName) {
                    vm.mailModel.streetTypeId = vm.streetType = 0;
                    vm.mailModel.streetTypeNm = "";
                }
                vm.disabledHouse = streetName === "" ? true : false;
                vm.disableSettlement = !vm.disabledHouse;
                vm.disableArea = vm.disableRegion = true;
                vm.disableSettlementType = streetName || vm.mailModel.settlementId ? true : false;

            }

            vm.houseOptions = $scope.clrAdr.houseOptions;
            vm.houseDataSource = $scope.clrAdr.houseDataSource;

            vm.houseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: vm.mailModel.streetId }
            }

            vm.houseDataSource.requestEnd = function (data) {
                vm.houseForChoose = data.response;
            }

            vm.houseOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.selectedHouse(dataItem);
                $scope.$apply();
            }

            vm.changeHouse = function (houseNumber) {
                if (houseNumber !== vm.mailModel.home) {
                    vm.mailModel.houseId = null;
                    vm.mailModel.home = houseNumber;
                    vm.disabledIndex = false;
                    vm.indexEdit = vm.mailModel.index = "";
                }

                if (!houseNumber) {
                    vm.mailModel.homeTypeId = vm.houseType = 0;
                    vm.mailModel.homeTypeNm = "";
                }

                vm.disabledStreet = houseNumber === "" ? false : true;
                vm.disabledSection = vm.disabledRoom = houseNumber === "" ? true : false;
                vm.disabledStreetType = houseNumber || vm.mailModel.streetId ? true : false;
            }

            vm.houseDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.houseDropDownOptions.dataBound = $scope.clrAdr.houseDropDownBoundFunc.BoundFunction;

            vm.houseDropDownOptions.select = function (e) {
                var item = e.item;
                vm.mailModel.homeTypeNm = item.text();
                vm.mailModel.homeTypeId = item.index();
            }

            vm.sectionDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.sectionDropDownOptions.dataBound = $scope.clrAdr.sectionDropDownBoundFunc.BoundFunction;

            vm.sectionDropDownOptions.select = function (e) {
                var item = e.item;
                vm.mailModel.homePartTypeNm = item.text();
                vm.mailModel.homePartTypeId = item.index();
            }

            vm.changeSection = function (sectionNumber) {
                vm.mailModel.homePart = sectionNumber;
                vm.disabledHouse = sectionNumber || vm.roomEdit ? true : false;

                if (!sectionNumber) {
                    vm.mailModel.homePartTypeId = vm.sectionType = 0;
                    vm.mailModel.homePartTypeNm = "";
                }
            }

            vm.roomDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.roomDropDownOptions.dataBound = $scope.clrAdr.roomDropDownBoundFunc.BoundFunction;

            vm.roomDropDownOptions.select = function (e) {
                var item = e.item;
                vm.mailModel.roomTypeNm = item.text();
                vm.mailModel.roomTypeId = item.index();
            }

            vm.changeRoom = function (roomNumber) {
                vm.mailModel.room = roomNumber;
                vm.disabledHouse = roomNumber || vm.sectionEdit ? true : false;
                vm.disabledSection = roomNumber && vm.sectionEdit ? true : false;

                if (!roomNumber) {
                    vm.mailModel.roomTypeId = vm.roomType = 0;
                    vm.mailModel.roomTypeNm = "";
                }
            }

            vm.changeNote = function (note) {
                vm.mailModel.comm = note;
            }

            $scope.$on('fillMailAddress', function (event, data) {
                vm.indexShow = vm.indexEdit = vm.mailModel.addressIndex = data.mailAddress.AddressIndex;
                vm.regionShow = data.mailAddress.Domain;
                vm.regionEdit = vm.mailModel.regionName = data.mailAddress.RegionName;
                vm.mailModel.regionId = data.mailAddress.RegionId;
                vm.areaShow = data.mailAddress.Region;
                vm.areaEdit = vm.mailModel.areaName = data.mailAddress.AreaName;
                vm.mailModel.areaId = data.mailAddress.AreaId;
                vm.settlementShowType = data.mailAddress.LocalityTypeName;
                vm.settlementShow = data.mailAddress.Locality;
                vm.settlementType = vm.mailModel.settlementTypeId = data.mailAddress.SettlementTypeId;
                vm.settlementEdit = vm.mailModel.settlementName = data.mailAddress.SettlementName;
                vm.mailModel.settlementId = data.mailAddress.SettlementId;
                vm.streetShowType = data.mailAddress.StreetTypeName;
                vm.streetShow = data.mailAddress.Street;
                vm.streetType = vm.mailModel.streetTypeId = data.mailAddress.StreetTypeId;
                vm.mailModel.streetTypeNm = data.mailAddress.StreetTypeNm;
                vm.streetEdit = vm.mailModel.streetName = data.mailAddress.StreetName;
                vm.mailModel.streetId = data.mailAddress.StreetId;
                vm.houseShowType = data.mailAddress.HomeTypeName;
                vm.houseShow = data.mailAddress.Home;
                vm.houseEdit = vm.mailModel.home = data.mailAddress.HouseNum;
                vm.mailModel.houseId = data.mailAddress.HouseId;
                vm.houseType = vm.mailModel.homeTypeId = data.mailAddress.HomeTypeId;
                vm.mailModel.homeTypeNm = data.mailAddress.HomeTypeNm;
                vm.sectionShowType = data.mailAddress.HomePartTypeName;
                vm.sectionShow = vm.sectionEdit = vm.mailModel.homePart = data.mailAddress.HomePart;
                vm.sectionType = vm.mailModel.homePartTypeId = data.mailAddress.HomePartTypeId;
                vm.mailModel.homePartTypeNm = data.mailAddress.HomePartTypeNm;
                vm.roomShowType = data.mailAddress.RoomTypeName;
                vm.roomShow = vm.roomEdit = vm.mailModel.room = data.mailAddress.Room;
                vm.roomType = vm.mailModel.roomTypeId = data.mailAddress.RoomTypeId;
                vm.mailModel.roomTypeNm = data.mailAddress.RoomTypeNm;
                vm.noteShow = vm.noteEdit = vm.mailModel.comm = data.mailAddress.Comm;

                vm.disabledIndex = vm.mailModel.houseId === null ? false : true;
                vm.disableRegion = !vm.streetEdit || (vm.mailModel.settlementId === null && vm.mailModel.areaId !== null) ? false : true;
                vm.disableArea = vm.mailModel.settlementId === null || !vm.streetEdit ? false : true;
                vm.disableSettlement = vm.disableSettlementType = !vm.streetEdit ? false : true;
                vm.disabledStreet = vm.disabledStreetType = vm.houseEdit || !vm.settlementEdit || !vm.regionEdit || vm.mailModel.streetId ? true : false;
                vm.disabledHouse = !vm.settlementEdit || !vm.regionEdit || ((vm.sectionEdit || vm.roomEdit) && vm.houseEdit) ? true : false;
                vm.disabledRoom = vm.disabledSection = !vm.houseEdit || !vm.settlementEdit || !vm.regionEdit ? true : false;
            });

            $scope.$on('clearMailAddress', function () {
                vm.indexShow = vm.indexEdit = vm.mailModel.addressIndex = null;
                vm.regionShow = "";
                vm.regionEdit = vm.mailModel.regionName = "";
                vm.mailModel.regionId = null;
                vm.areaShow = "";
                vm.areaEdit = vm.mailModel.areaName = "";
                vm.mailModel.areaId = null;
                vm.settlementShowType = "";
                vm.settlementShow = "";
                vm.settlementType = vm.mailModel.settlementTypeId = null;
                vm.settlementEdit = vm.mailModel.settlementName = "";
                vm.mailModel.settlementId = null;
                vm.streetShowType = "";
                vm.streetShow = "";
                vm.streetType = vm.mailModel.streetTypeId = null;
                vm.mailModel.streetTypeNm = "";
                vm.streetEdit = vm.mailModel.streetName = "";
                vm.mailModel.streetId = null;
                vm.houseShowType = "";
                vm.houseShow = vm.houseEdit = vm.mailModel.home = "";
                vm.houseType = vm.mailModel.homeTypeId = vm.mailModel.houseId = null;
                vm.mailModel.homeTypeNm = "";
                vm.sectionShowType = "";
                vm.sectionShow = vm.sectionEdit = vm.mailModel.homePart = "";
                vm.sectionType = vm.mailModel.homePartTypeId = null;
                vm.mailModel.homePartTypeNm = "";
                vm.roomShowType = "";
                vm.roomShow = vm.roomEdit = vm.mailModel.room = "";
                vm.roomType = vm.mailModel.roomTypeId = null;
                vm.mailModel.roomTypeNm = "";
                vm.noteShow = vm.noteEdit = vm.mailModel.comm = "";

                vm.disabledIndex = vm.disableRegion = vm.disableArea = vm.disableSettlement = vm.disableSettlementType = false;
                vm.disabledStreet = vm.disabledStreetType = vm.disabledHouse = vm.disabledSection = vm.disabledRoom = true;
            });

            vm.selectedRegion = function (data) {
                vm.mailModel.regionId = data.REGION_ID;
                vm.mailModel.regionName = data.REGION_NM;
            }

            vm.regionLostFocus = function () {
                for (var i = 0; i < vm.regionForChoose.length; i++) {
                    if (vm.mailModel.regionName.toUpperCase() === vm.regionForChoose[i].REGION_NM.toUpperCase()) {
                        vm.selectedRegion(vm.regionForChoose[i]);
                    }
                };
            }

            vm.selectedArea = function (data) {
                vm.mailModel.areaId = data.AREA_ID;
                vm.mailModel.areaName = data.AREA_NM;
                vm.mailModel.regionId = data.REGION_ID;
                vm.mailModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.disableRegion = true;
            }

            vm.areaLostFocus = function () {
                for (var i = 0; i < vm.areaForChoose.length; i++) {
                    if (vm.mailModel.areaName.toUpperCase() === vm.areaForChoose[i].AREA_NM.toUpperCase() && !vm.mailModel.areaId) {
                        vm.selectedArea(vm.areaForChoose[i]);
                    }
                };
            }

            vm.selectedSettlement = function (data) {
                vm.mailModel.settlementTypeId = vm.settlementType = data.SETL_TP_ID;
                vm.mailModel.settlementName = data.SETL_NM;
                vm.mailModel.settlementId = data.SETL_ID;
                vm.mailModel.regionId = data.REGION_ID;
                vm.mailModel.areaId = data.AREA_ID;
                vm.mailModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.mailModel.areaName = vm.areaEdit = data.AREA_NAME;
                vm.disabledStreet = false;
                vm.disableRegion = vm.disableArea = vm.disableSettlementType = true;
            }

            vm.settlementLostFocus = function () {
                for (var i = 0; i < vm.settlementForChoose.length; i++) {
                    if (vm.mailModel.settlementName.toUpperCase() === vm.settlementForChoose[i].SETL_NM.toUpperCase() && !vm.mailModel.settlementId) {
                        vm.selectedSettlement(vm.settlementForChoose[i]);
                    }
                };
            }

            vm.selectedStreet = function (data) {
                vm.mailModel.streetTypeId = vm.streetType = data.STR_TP_ID;
                vm.mailModel.streetTypeNm = data.STR_TP_NM;
                vm.mailModel.streetName = data.STR_NM;
                vm.mailModel.streetId = data.STR_ID;
                vm.disabledStreetType = true;
            }

            vm.streetLostFocus = function () {
                for (var i = 0; i < vm.streetForChoose.length; i++) {
                    if (vm.mailModel.streetName.toUpperCase() === vm.streetForChoose[i].STR_NM.toUpperCase() && !vm.mailModel.streetId) {
                        vm.selectedStreet(vm.streetForChoose[i]);
                    }
                };
            }

            vm.selectedHouse = function (data) {
                vm.mailModel.houseId = data.HOUSE_ID;
                vm.mailModel.home = data.HOUSE_NUM_FULL;
                vm.indexEdit = vm.mailModel.addressIndex = data.POSTAL_CODE === null ? "" : data.POSTAL_CODE;
                vm.disabledIndex = true;
            }

            vm.houseLostFocus = function () {
                for (var i = 0; i < vm.houseForChoose.length; i++) {
                    if (vm.mailModel.home.toUpperCase() === vm.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase() && !vm.mailModel.houseId) {
                        vm.selectedHouse(vm.houseForChoose[i]);
                    }
                };
            }

            vm.checkKeyDown = function (e, type) {
                if (e.keyCode === $scope.clrAdr.KEY_ENTER)
                    vm.checkAddressType(type);
            }

            vm.checkAddressType = function (type) {
                switch (type) {
                    case "region":
                        vm.regionLostFocus();
                        break;
                    case "area":
                        vm.areaLostFocus();
                        break;
                    case "settlement":
                        vm.settlementLostFocus();
                        break;
                    case "street":
                        vm.streetLostFocus();
                        break;
                    case "house":
                        vm.houseLostFocus();
                        break;
                }
            }

        });