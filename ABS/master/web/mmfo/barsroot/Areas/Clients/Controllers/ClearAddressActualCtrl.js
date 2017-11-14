angular.module(globalSettings.modulesAreas)
    .controller('ClearAddressActualCtrl',
        function($scope) {
           
            var vm = this;

            vm.regionForChoose = [];
            vm.areaForChoose = [];
            vm.settlementForChoose = [];
            vm.streetForChoose = [];
            vm.houseForChoose = [];

            vm.actualModel = $scope.clrAdr.actualModel;

            vm.changeIndex = function (index) {
                vm.actualModel.addressIndex = parseInt(index);
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
                if (regionName !== vm.actualModel.regionName) {
                    vm.actualModel.regionId = null;
                    vm.actualModel.regionName = regionName;
                }
                vm.disabledStreet = vm.disabledStreetType = regionName === "" || vm.settlementEdit === "" || vm.settlementEdit === undefined ? true : false;
            }

            vm.areasOptions = $scope.clrAdr.areasOptions;
            vm.areaDataSource = $scope.clrAdr.areaDataSource;

            vm.areaDataSource.transport.read.data = function () {
                return { columnName: "AREA_NM", regionId: vm.actualModel.regionId }
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
                if (areaName !== vm.actualModel.areaName) {
                    vm.actualModel.areaId = null;
                    vm.actualModel.areaName = areaName;
                }
                vm.disableRegion = vm.actualModel.areaId ? true : false;
            }

            vm.settlementDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.settlementDropDownOptions.dataBound = $scope.clrAdr.settlementDropDownBoundFunc.BoundFunction;

            vm.changeSettlementType = function (settlementType) {
                vm.actualModel.settlementTypeId = settlementType === "0" || settlementType === null ? null : parseInt(settlementType);
            }

            vm.settlementOptions = $scope.clrAdr.settlementOptions;
            vm.settlementDataSource = $scope.clrAdr.settlementDataSource;

            vm.settlementDataSource.transport.read.data = function () {
                return { columnName: "SETL_NM", regionId: vm.actualModel.regionId, areaId: vm.actualModel.areaId }
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
                if (settlementName !== vm.actualModel.settlementName) {
                    vm.actualModel.settlementId = null;
                    vm.actualModel.settlementName = settlementName;
                    vm.disableSettlementType = false;
                }

                if (!settlementName) {
                    vm.actualModel.settlementTypeId = vm.settlementType = 0;
                }

                vm.disabledStreet =vm.disabledStreetType = settlementName === "" || vm.actualModel.regionName === "" || vm.actualModel.regionName === null ? true : false;
                vm.disableRegion = vm.disableArea = vm.actualModel.settlementId ? true : false;
            }

            vm.streetDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.streetDropDownOptions.dataBound = $scope.clrAdr.streetDropDownBoundFunc.BoundFunction;

            vm.streetDropDownOptions.select = function (e) {
                var item = e.item;
                vm.actualModel.streetTypeNm = item.text();
                vm.actualModel.streetTypeId = item.index();
            }

            vm.streetOptions = $scope.clrAdr.streetOptions;
            vm.streetDataSource = $scope.clrAdr.streetDataSource;

            vm.streetDataSource.transport.read.data = function () {
                return { columnName: "STR_NM", settlementId: vm.actualModel.settlementId }
            }

            vm.streetDataSource.requestEnd = function (data) {
                vm.streetForChoose = data.response;
            }

            vm.streetOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                vm.selectedStreet(dataItem);
                $scope.$apply();
            }

            vm.changeStreet = function (streetName) {
                if (streetName !== vm.actualModel.streetName) {
                    vm.actualModel.streetId = null;
                    vm.actualModel.streetName = streetName;
                    vm.disabledStreetType = false;
                }

                if (!streetName) {
                    vm.actualModel.streetTypeId = vm.streetType = 0;
                    vm.actualModel.streetTypeNm = "";
                }
                vm.disabledHouse = streetName === "" ? true : false;
                vm.disableArea = vm.disableRegion = true;
                vm.disableSettlement = !vm.disabledHouse;
                vm.disableSettlementType = streetName || vm.actualModel.settlementId ? true : false;
            }

            vm.houseOptions = $scope.clrAdr.houseOptions;
            vm.houseDataSource = $scope.clrAdr.houseDataSource;

            vm.houseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: vm.actualModel.streetId }
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
                if (houseNumber !== vm.actualModel.home) {
                    vm.actualModel.houseId = null;
                    vm.actualModel.home = houseNumber;
                    vm.disabledIndex = false;
                    vm.indexEdit = vm.actualModel.addressIndex = "";
                }

                if (!houseNumber) {
                    vm.actualModel.homeTypeId = vm.houseType = 0;
                    vm.actualModel.homeTypeNm = "";

                }

                vm.disabledStreet = houseNumber === "" ? false : true;
                vm.disabledSection = vm.disabledRoom = houseNumber === "" ? true : false;
                vm.disabledStreetType = houseNumber || vm.actualModel.streetId ? true : false;
            }


            vm.houseDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.houseDropDownOptions.dataBound = $scope.clrAdr.houseDropDownBoundFunc.BoundFunction;

            vm.houseDropDownOptions.select = function (e) {
                var item = e.item;
                vm.actualModel.homeTypeNm = item.text();
                vm.actualModel.homeTypeId = item.index();
            }

            vm.sectionDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.sectionDropDownOptions.dataBound = $scope.clrAdr.sectionDropDownBoundFunc.BoundFunction;


            vm.sectionDropDownOptions.select = function (e) {
                var item = e.item;
                vm.actualModel.homePartTypeNm = item.text();
                vm.actualModel.homePartTypeId = item.index();
            }

            vm.changeSection = function (sectionNumber) {
                vm.actualModel.homePart = sectionNumber;
                vm.disabledHouse = sectionNumber || vm.roomEdit ? true : false;

                if (!sectionNumber) {
                    vm.actualModel.homePartTypeId = vm.sectionType = 0;
                    vm.actualModel.homePartTypeNm = "";
                }
            }

            vm.roomDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.roomDropDownOptions.dataBound = $scope.clrAdr.roomDropDownBoundFunc.BoundFunction;

            vm.roomDropDownOptions.select = function (e) {
                var item = e.item;
                vm.actualModel.roomTypeNm = item.text();
                vm.actualModel.roomTypeId = item.index();
            }

            vm.changeRoom = function (roomNumber) {
                vm.actualModel.room = roomNumber;
                vm.disabledHouse = roomNumber || vm.sectionEdit ? true : false;
                vm.disabledSection = roomNumber && vm.sectionEdit ? true : false;

                if (!roomNumber) {
                    vm.actualModel.roomTypeId = vm.roomType = 0;
                    vm.actualModel.roomTypeNm = "";
                }
            }

            vm.changeNote = function (note) {
                vm.actualModel.comm = note;
            }

            $scope.$on('fillActualAddress', function (event, data) {
                vm.indexShow = vm.indexEdit = vm.actualModel.addressIndex = data.actualAddress.AddressIndex;
                vm.regionShow = data.actualAddress.Domain;
                vm.regionEdit = vm.actualModel.regionName = data.actualAddress.RegionName;
                vm.actualModel.regionId = data.actualAddress.RegionId;
                vm.areaShow = data.actualAddress.Region;
                vm.areaEdit = vm.actualModel.areaName = data.actualAddress.AreaName;
                vm.actualModel.areaId = data.actualAddress.AreaId;
                vm.settlementShowType = data.actualAddress.LocalityTypeName;
                vm.settlementShow = data.actualAddress.Locality;
                vm.settlementType = vm.actualModel.settlementTypeId = data.actualAddress.SettlementTypeId;
                vm.settlementEdit = vm.actualModel.settlementName = data.actualAddress.SettlementName;
                vm.actualModel.settlementId = data.actualAddress.SettlementId;
                vm.streetShowType = data.actualAddress.StreetTypeName;
                vm.streetShow = data.actualAddress.Street;
                vm.streetType = vm.actualModel.streetTypeId = data.actualAddress.StreetTypeId;
                vm.actualModel.streetTypeNm = data.actualAddress.StreetTypeNm;
                vm.streetEdit = vm.actualModel.streetName = data.actualAddress.StreetName;
                vm.actualModel.streetId = data.actualAddress.StreetId;
                vm.houseShowType = data.actualAddress.HomeTypeName;
                vm.houseShow = data.actualAddress.Home;
                vm.houseEdit = vm.actualModel.home = data.actualAddress.HouseNum;
                vm.actualModel.houseId = data.actualAddress.HouseId;
                vm.houseType = vm.actualModel.homeTypeId = data.actualAddress.HomeTypeId;
                vm.actualModel.homeTypeNm = data.actualAddress.HomeTypeNm;
                vm.sectionShowType = data.actualAddress.HomePartTypeName;
                vm.sectionShow = vm.sectionEdit = vm.actualModel.homePart = data.actualAddress.HomePart;
                vm.sectionType = vm.actualModel.homePartTypeId = data.actualAddress.HomePartTypeId;
                vm.actualModel.homePartTypeNm = data.actualAddress.HomePartTypeNm;
                vm.roomShowType = data.actualAddress.RoomTypeName;
                vm.roomShow = vm.roomEdit = vm.actualModel.room = data.actualAddress.Room;
                vm.roomType = vm.actualModel.roomTypeId = data.actualAddress.RoomTypeId;
                vm.actualModel.roomTypeNm = data.actualAddress.RoomTypeNm;
                vm.noteShow = vm.noteEdit = vm.actualModel.comm = data.actualAddress.Comm;

                vm.disabledIndex = vm.actualModel.houseId === null ? false : true;
                vm.disableRegion = !vm.streetEdit || (vm.actualModel.settlementId === null && vm.actualModel.areaId !== null) ? false : true;
                vm.disableArea = vm.actualModel.settlementId === null || !vm.streetEdit ? false : true;
                vm.disableSettlement = vm.disableSettlementType = !vm.streetEdit ? false : true;
                vm.disabledStreet = vm.disabledStreetType = vm.houseEdit || !vm.settlementEdit || !vm.regionEdit || vm.actualModel.streetId ? true : false;
                vm.disabledHouse = !vm.settlementEdit || !vm.regionEdit || ((vm.sectionEdit || vm.roomEdit) && vm.houseEdit) ? true : false;
                vm.disabledRoom = vm.disabledSection = !vm.houseEdit || !vm.settlementEdit || !vm.regionEdit ? true : false;
            });


            $scope.$on('clearActualAddress', function () {
                vm.indexShow = vm.indexEdit = vm.actualModel.addressIndex = null;
                vm.regionShow = "";
                vm.regionEdit = vm.actualModel.regionName = "";
                vm.actualModel.regionId = null;
                vm.areaShow = "";
                vm.areaEdit = vm.actualModel.areaName = "";
                vm.actualModel.areaId = null;
                vm.settlementShowType = "";
                vm.settlementShow = "";
                vm.settlementType = vm.actualModel.settlementTypeId = null;
                vm.settlementEdit = vm.actualModel.settlementName = "";
                vm.actualModel.settlementId = null;
                vm.streetShowType = "";
                vm.streetShow = "";
                vm.streetType = vm.actualModel.streetTypeId = null;
                vm.actualModel.streetTypeNm = "";
                vm.streetEdit = vm.actualModel.streetName = "";
                vm.actualModel.streetId = null;
                vm.houseShowType = "";
                vm.houseShow = vm.houseEdit = vm.actualModel.home = "";
                vm.houseType = vm.actualModel.homeTypeId = vm.actualModel.houseId = null;
                vm.actualModel.homeTypeNm = "";
                vm.sectionShowType = "";
                vm.sectionShow = vm.sectionEdit = vm.actualModel.homePart = "";
                vm.sectionType = vm.actualModel.homePartTypeId = null;
                vm.actualModel.homePartTypeNm = "";
                vm.roomShowType = "";
                vm.roomShow = vm.roomEdit = vm.actualModel.room = "";
                vm.roomType = vm.actualModel.roomTypeId = null;
                vm.actualModel.roomTypeNm = "";
                vm.noteShow = vm.noteEdit = vm.actualModel.comm = "";

                vm.disabledIndex = vm.disableRegion = vm.disableArea = vm.disableSettlement = vm.disableSettlementType = false;
                vm.disabledStreet = vm.disabledStreetType = vm.disabledHouse = vm.disabledSection = vm.disabledRoom = true;
            });

            vm.selectedRegion = function (data) {
                vm.actualModel.regionId = data.REGION_ID;
                vm.actualModel.regionName = data.REGION_NM;
            }

            vm.regionLostFocus = function () {
                for (var i = 0; i < vm.regionForChoose.length; i++) {
                    if (vm.actualModel.regionName.toUpperCase() === vm.regionForChoose[i].REGION_NM.toUpperCase()) {
                        vm.selectedRegion(vm.regionForChoose[i]);
                    }
                };
            }

            vm.selectedArea = function (data) {
                vm.actualModel.areaId = data.AREA_ID;
                vm.actualModel.areaName = data.AREA_NM;
                vm.actualModel.regionId = data.REGION_ID;
                vm.actualModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.disableRegion = true;
            }

            vm.areaLostFocus = function () {
                for (var i = 0; i < vm.areaForChoose.length; i++) {
                    if (vm.actualModel.areaName.toUpperCase() === vm.areaForChoose[i].AREA_NM.toUpperCase() && !vm.actualModel.areaId) {
                        vm.selectedArea(vm.areaForChoose[i]);
                    }
                };
            }

            vm.selectedSettlement = function (data) {
                vm.actualModel.settlementTypeId = vm.settlementType = data.SETL_TP_ID;
                vm.actualModel.settlementName = data.SETL_NM;
                vm.actualModel.settlementId = data.SETL_ID;
                vm.actualModel.regionId = data.REGION_ID;
                vm.actualModel.areaId = data.AREA_ID;
                vm.actualModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.actualModel.areaName = vm.areaEdit = data.AREA_NAME;
                vm.disabledStreet = false;
                vm.disableRegion = vm.disableArea = vm.disableSettlementType = true;
            }

            vm.settlementLostFocus = function () {
                for (var i = 0; i < vm.settlementForChoose.length; i++) {
                    if (vm.actualModel.settlementName.toUpperCase() === vm.settlementForChoose[i].SETL_NM.toUpperCase() && !vm.actualModel.settlementId) {
                        vm.selectedSettlement(vm.settlementForChoose[i]);
                    }
                };
            }

            vm.selectedStreet = function (data) {
                vm.actualModel.streetTypeId = vm.streetType = data.STR_TP_ID;
                vm.actualModel.streetTypeNm = data.STR_TP_NM;
                vm.actualModel.streetName = data.STR_NM;
                vm.actualModel.streetId = data.STR_ID;
                vm.disabledStreetType = true;
            }

            vm.streetLostFocus = function () {
                for (var i = 0; i < vm.streetForChoose.length; i++) {
                    if (vm.actualModel.streetName.toUpperCase() === vm.streetForChoose[i].STR_NM.toUpperCase() && !vm.actualModel.streetId) {
                        vm.selectedStreet(vm.streetForChoose[i]);
                    }
                };
            }

            vm.selectedHouse = function (data) {
                vm.actualModel.houseId = data.HOUSE_ID;
                vm.actualModel.home = data.HOUSE_NUM_FULL;
                vm.indexEdit = vm.actualModel.addressIndex = data.POSTAL_CODE === null ? "" : data.POSTAL_CODE;
                vm.disabledIndex = true;
            }

            vm.houseLostFocus = function () {
                for (var i = 0; i < vm.houseForChoose.length; i++) {
                    if (vm.actualModel.home.toUpperCase() === vm.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase() && !vm.actualModel.houseId) {
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