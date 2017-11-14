angular.module(globalSettings.modulesAreas)
    .controller('ClearAddressLegalCtrl', ['$scope',
        function ($scope) {

            var vm = this;

            vm.regionForChoose = [];
            vm.areaForChoose = [];
            vm.settlementForChoose = [];
            vm.streetForChoose = [];
            vm.houseForChoose = [];

            vm.legalModel = $scope.clrAdr.legalModel;

            vm.changeIndex = function (index) {
                vm.legalModel.addressIndex = parseInt(index);
            }

            vm.changeRegion = function (regionName) {
                if (regionName !== vm.legalModel.regionName) {
                    vm.legalModel.regionId = null;
                    vm.legalModel.regionName = regionName;
                }
                vm.disabledStreet = vm.disabledStreetType = regionName === "" || vm.settlementEdit === "" || vm.settlementEdit === undefined ? true : false;
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

            vm.areasOptions = $scope.clrAdr.areasOptions;
            vm.areaDataSource = $scope.clrAdr.areaDataSource;

            vm.areaDataSource.transport.read.data = function() {
                return { columnName: "AREA_NM", regionId: vm.legalModel.regionId }
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
                if (areaName !== vm.legalModel.areaName) {
                    vm.legalModel.areaId = null;
                    vm.legalModel.areaName = areaName;
                }
                vm.disableRegion = vm.legalModel.areaId ? true : false;
            }

            vm.settlementDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.settlementDropDownOptions.dataBound = $scope.clrAdr.settlementDropDownBoundFunc.BoundFunction;

            vm.changeSettlementType = function (settlementType) {
                vm.legalModel.settlementTypeId =  settlementType === "0" || settlementType === null ? null : parseInt(settlementType);
            }
            

            vm.settlementOptions = $scope.clrAdr.settlementOptions;
            vm.settlementDataSource = $scope.clrAdr.settlementDataSource;

            vm.settlementDataSource.transport.read.data = function () {
                return { columnName: "SETL_NM", regionId: vm.legalModel.regionId, areaId: vm.legalModel.areaId }
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
                if (settlementName !== vm.legalModel.settlementName) {
                    vm.legalModel.settlementId = null;
                    vm.legalModel.settlementName = settlementName;
                    vm.disableSettlementType = false;
                }

                if (!settlementName) {
                    vm.legalModel.settlementTypeId = vm.settlementType = 0;
                }

                vm.disabledStreet = vm.disabledStreetType = settlementName === "" || vm.legalModel.regionName === "" || vm.legalModel.regionName === null ? true : false;
                vm.disableRegion = vm.disableArea = vm.legalModel.settlementId ? true : false;
            }

            vm.streetDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.streetDropDownOptions.dataBound = $scope.clrAdr.streetDropDownBoundFunc.BoundFunction;

            vm.streetDropDownOptions.select = function (e) {
                var item = e.item;
                vm.legalModel.streetTypeNm = item.text();
                vm.legalModel.streetTypeId = item.index();
            }

            vm.streetOptions = $scope.clrAdr.streetOptions;
            vm.streetDataSource = $scope.clrAdr.streetDataSource;

            vm.streetDataSource.transport.read.data = function () {
                return { columnName: "STR_NM", settlementId: vm.legalModel.settlementId }
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
                if (streetName !== vm.legalModel.streetName) {
                    vm.legalModel.streetId = null;
                    vm.legalModel.streetName = streetName;
                    vm.disabledStreetType = false;
                }

                if (!streetName) {
                    vm.legalModel.streetTypeId = vm.streetType = 0;
                    vm.legalModel.streetTypeNm = "";
                }
                vm.disabledHouse = streetName === "" ? true : false;
                vm.disableArea = vm.disableRegion = true;
                vm.disableSettlement = !vm.disabledHouse;
                vm.disableSettlementType = streetName || vm.legalModel.settlementId ? true : false;
            }
            
            vm.houseOptions = $scope.clrAdr.houseOptions;
            vm.houseDataSource = $scope.clrAdr.houseDataSource;

            vm.houseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: vm.legalModel.streetId }
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
                if (houseNumber !== vm.legalModel.home) {
                    vm.legalModel.houseId = null;
                    vm.legalModel.home = houseNumber;
                    vm.disabledIndex = false;
                    vm.indexEdit = vm.legalModel.addressIndex = "";
                }

                if (!houseNumber) {
                    vm.legalModel.homeTypeId = vm.houseType = 0;
                    vm.legalModel.homeTypeNm = "";
                }

                vm.disabledStreet = houseNumber === "" ? false : true;
                vm.disabledSection = vm.disabledRoom = houseNumber === "" ? true : false;
                vm.disabledStreetType = houseNumber || vm.legalModel.streetId ? true : false;

            }


            vm.houseDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.houseDropDownOptions.dataBound = $scope.clrAdr.houseDropDownBoundFunc.BoundFunction;

            vm.houseDropDownOptions.select = function (e) {
                var item = e.item;
                vm.legalModel.homeTypeNm = item.text();
                vm.legalModel.homeTypeId = item.index();
            }

            vm.sectionDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.sectionDropDownOptions.dataBound = $scope.clrAdr.sectionDropDownBoundFunc.BoundFunction;


            vm.sectionDropDownOptions.select = function (e) {
                var item = e.item;
                vm.legalModel.homePartTypeNm = item.text();
                vm.legalModel.homePartTypeId = item.index();
            }

            vm.changeSection = function (sectionNumber) {
                vm.legalModel.homePart = sectionNumber;
                vm.disabledHouse = sectionNumber || vm.roomEdit ? true : false;

                if (!sectionNumber) {
                    vm.legalModel.homePartTypeId = vm.sectionType = 0;
                    vm.legalModel.homePartTypeNm = "";
                }
            }


            vm.roomDropDownOptions = $scope.clrAdr.createDropDownOptions();

            vm.roomDropDownOptions.dataBound = $scope.clrAdr.roomDropDownBoundFunc.BoundFunction;

            vm.roomDropDownOptions.select = function (e) {
                var item = e.item;
                vm.legalModel.roomTypeNm = item.text();
                vm.legalModel.roomTypeId = item.index();
            }

            vm.changeRoom = function (roomNumber) {
                vm.legalModel.room = roomNumber;
                vm.disabledHouse = roomNumber || vm.sectionEdit ? true : false;
                vm.disabledSection = roomNumber && vm.sectionEdit ? true : false;

                if (!roomNumber) {
                    vm.legalModel.roomTypeId = vm.roomType = 0;
                    vm.legalModel.roomTypeNm = "";
                }

            }

            vm.changeNote = function (note) {
                vm.legalModel.comm = note;
            }

            $scope.$on('fillLegalAddress', function (event, data) {
                vm.indexShow = vm.indexEdit = vm.legalModel.addressIndex = data.legalAddress.AddressIndex;
                vm.regionShow = data.legalAddress.Domain;
                vm.regionEdit = vm.legalModel.regionName = data.legalAddress.RegionName;
                vm.legalModel.regionId = data.legalAddress.RegionId;
                vm.areaShow = data.legalAddress.Region;
                vm.areaEdit = vm.legalModel.areaName = data.legalAddress.AreaName;
                vm.legalModel.areaId = data.legalAddress.AreaId;
                vm.settlementShowType = data.legalAddress.LocalityTypeName;
                vm.settlementShow = data.legalAddress.Locality;
                vm.settlementType = vm.legalModel.settlementTypeId = data.legalAddress.SettlementTypeId;
                vm.settlementEdit = vm.legalModel.settlementName = data.legalAddress.SettlementName;
                vm.legalModel.settlementId = data.legalAddress.SettlementId;
                vm.streetShowType = data.legalAddress.StreetTypeName;
                vm.streetShow = data.legalAddress.Street;
                vm.streetType = vm.legalModel.streetTypeId = data.legalAddress.StreetTypeId;
                vm.legalModel.streetTypeNm = data.legalAddress.StreetTypeNm;
                vm.streetEdit = vm.legalModel.streetName = data.legalAddress.StreetName;
                vm.legalModel.streetId = data.legalAddress.StreetId;
                vm.houseShowType = data.legalAddress.HomeTypeName;
                vm.houseShow = data.legalAddress.Home;
                vm.houseEdit = vm.legalModel.home = data.legalAddress.HouseNum;
                vm.legalModel.houseId = data.legalAddress.HouseId;
                vm.houseType = vm.legalModel.homeTypeId = data.legalAddress.HomeTypeId;
                vm.legalModel.homeTypeNm = data.legalAddress.HomeTypeNm;
                vm.sectionShowType = data.legalAddress.HomePartTypeName;
                vm.sectionShow = vm.sectionEdit = vm.legalModel.homePart = data.legalAddress.HomePart;
                vm.sectionType = vm.legalModel.homePartTypeId = data.legalAddress.HomePartTypeId;
                vm.legalModel.homePartTypeNm = data.legalAddress.HomePartTypeNm;
                vm.roomShowType = data.legalAddress.RoomTypeName;
                vm.roomShow = vm.roomEdit = vm.legalModel.room = data.legalAddress.Room;
                vm.roomType = vm.legalModel.roomTypeId = data.legalAddress.RoomTypeId;
                vm.legalModel.roomTypeNm = data.legalAddress.RoomTypeNm;
                vm.noteShow = vm.noteEdit = vm.legalModel.comm = data.legalAddress.Comm;

                vm.disabledIndex = vm.legalModel.houseId === null ? false : true;
                vm.disableRegion = !vm.streetEdit || (vm.legalModel.settlementId === null && vm.legalModel.areaId !== null) ? false : true;
                vm.disableArea = vm.legalModel.settlementId === null || !vm.streetEdit ? false : true;
                vm.disableSettlement = vm.disableSettlementType = !vm.streetEdit ? false : true;
                vm.disabledStreet = vm.disabledStreetType =  vm.houseEdit || !vm.settlementEdit || !vm.regionEdit || vm.legalModel.streetId ? true : false;
                vm.disabledHouse = !vm.settlementEdit || !vm.regionEdit || ((vm.sectionEdit || vm.roomEdit) && vm.houseEdit ) ? true : false;
                vm.disabledRoom = vm.disabledSection = !vm.houseEdit || !vm.settlementEdit || !vm.regionEdit ? true : false;

            });

            $scope.$on('clearLegalAddress', function () {
                vm.indexShow = vm.indexEdit = vm.legalModel.addressIndex = null;
                vm.regionShow = "";
                vm.regionEdit = vm.legalModel.regionName = "";
                vm.legalModel.regionId = null;
                vm.areaShow = "";
                vm.areaEdit = vm.legalModel.areaName = "";
                vm.legalModel.areaId = null;
                vm.settlementShowType = "";
                vm.settlementShow = "";
                vm.settlementType = vm.legalModel.settlementTypeId = null;
                vm.settlementEdit = vm.legalModel.settlementName = "";
                vm.legalModel.settlementId = null;
                vm.streetShowType = "";
                vm.streetShow = "";
                vm.streetType = vm.legalModel.streetTypeId = null;
                vm.legalModel.streetTypeNm = "";
                vm.streetEdit = vm.legalModel.streetName = "";
                vm.legalModel.streetId = null;
                vm.houseShowType = "";
                vm.houseShow = vm.houseEdit = vm.legalModel.home = "";
                vm.houseType = vm.legalModel.homeTypeId = vm.legalModel.houseId = null;
                vm.legalModel.homeTypeNm = "";
                vm.sectionShowType = "";
                vm.sectionShow = vm.sectionEdit = vm.legalModel.homePart = "";
                vm.sectionType = vm.legalModel.homePartTypeId = null;
                vm.legalModel.homePartTypeNm = "";
                vm.roomShowType = "";
                vm.roomShow = vm.roomEdit = vm.legalModel.room = "";
                vm.roomType = vm.legalModel.roomTypeId = null;
                vm.legalModel.roomTypeNm = "";
                vm.noteShow = vm.noteEdit = vm.legalModel.comm = "";

                vm.disabledIndex = vm.disableRegion = vm.disableArea = vm.disableSettlement = vm.disableSettlementType = false;
                vm.disabledStreet = vm.disabledStreetType = vm.disabledHouse = vm.disabledSection = vm.disabledRoom = true;
            });

            vm.selectedRegion = function (data) {
                vm.legalModel.regionId = data.REGION_ID;
                vm.legalModel.regionName = data.REGION_NM;
            }

            vm.regionLostFocus = function () {
                for (var i = 0; i < vm.regionForChoose.length; i++) {
                    if (vm.legalModel.regionName.toUpperCase() === vm.regionForChoose[i].REGION_NM.toUpperCase()) {
                        vm.selectedRegion(vm.regionForChoose[i]);
                    }
                };
            }

            vm.selectedArea = function (data) {
                vm.legalModel.areaId = data.AREA_ID;
                vm.legalModel.areaName = data.AREA_NM;
                vm.legalModel.regionId = data.REGION_ID;
                vm.legalModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.disableRegion = true;
            }

            vm.areaLostFocus = function () {
                for (var i = 0; i < vm.areaForChoose.length; i++) {
                    if (vm.legalModel.areaName.toUpperCase() === vm.areaForChoose[i].AREA_NM.toUpperCase() && !vm.legalModel.areaId) {
                        vm.selectedArea(vm.areaForChoose[i]);
                    }
                };
            }

            vm.selectedSettlement = function (data) {
                vm.legalModel.settlementTypeId = vm.settlementType = data.SETL_TP_ID;
                vm.legalModel.settlementName = data.SETL_NM;
                vm.legalModel.settlementId = data.SETL_ID;
                vm.legalModel.regionId = data.REGION_ID;
                vm.legalModel.areaId = data.AREA_ID;
                vm.legalModel.regionName = vm.regionEdit = data.REGION_NAME;
                vm.legalModel.areaName = vm.areaEdit = data.AREA_NAME;
                vm.disabledStreet = false;
                vm.disableRegion = vm.disableArea = vm.disableSettlementType = true;
            }

            vm.settlementLostFocus = function () {
                for (var i = 0; i < vm.settlementForChoose.length; i++) {
                    if (vm.legalModel.settlementName.toUpperCase() === vm.settlementForChoose[i].SETL_NM.toUpperCase() && !vm.legalModel.settlementId) {
                        vm.selectedSettlement(vm.settlementForChoose[i]);
                    }
                };
            }

            vm.selectedStreet = function (data) {
                vm.legalModel.streetTypeId = vm.streetType = data.STR_TP_ID;
                vm.legalModel.streetTypeNm = data.STR_TP_NM;
                vm.legalModel.streetName = data.STR_NM;
                vm.legalModel.streetId = data.STR_ID;
                vm.disabledStreetType = true;
            }

            vm.streetLostFocus = function () {
                for (var i = 0; i < vm.streetForChoose.length; i++) {
                    if (vm.legalModel.streetName.toUpperCase() === vm.streetForChoose[i].STR_NM.toUpperCase() && !vm.legalModel.streetId) {
                        vm.selectedStreet(vm.streetForChoose[i]);
                    }
                };
            }

            vm.selectedHouse = function (data) {
                vm.legalModel.houseId = data.HOUSE_ID;
                vm.legalModel.home = data.HOUSE_NUM_FULL;
                vm.indexEdit = vm.legalModel.addressIndex = data.POSTAL_CODE === null ? "" : data.POSTAL_CODE;
                vm.disabledIndex = true;
            }

            vm.houseLostFocus = function () {
                for (var i = 0; i < vm.houseForChoose.length; i++) {
                    if (vm.legalModel.home.toUpperCase() === vm.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase() && !vm.legalModel.houseId) {
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

        }]);


