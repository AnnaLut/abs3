angular.module(globalSettings.modulesAreas)
    .controller('ClientAddressActualCtrl',
    ['$scope',
        function ($scope) {

            $scope.regionForChoose = [];
            $scope.areaForChoose = [];
            $scope.settlementForChoose = [];
            $scope.streetForChoose = [];
            $scope.houseForChoose = [];

            $scope.spanEnterRegionActual = { 'visibility': 'hidden' };

            $scope.KEY_ENTER = 13;

            $scope.actualRegionDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetRegions"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "REGION_NM" } }
                    }
                },
                requestEnd: function (data) {
                    $scope.regionForChoose = data.response;
                }
            });

            $scope.actualRegionOptions = {
                dataTextField: "REGION_NM",
                dataValueField: "REGION_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.selectedRegion(dataItem);
                    $scope.$apply();
                },
                dataSource: $scope.actualRegionDataSource
            }

            $scope.actualAreasDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetAreas"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "AREA_NM", regionId: $scope.clientAddress.actualModel.REGION_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.areaForChoose = data.response;
                }
            });

            $scope.actualAreasOptions = {
                dataTextField: "AREA_NM",
                dataValueField: "AREA_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.selectedArea(dataItem);
                    $scope.$apply();
                },
                dataSource: $scope.actualAreasDataSource,
                template: '<div style="float: left;">' +
                '<div style="float: left; width: 200px; word-wrap:break-word;">' +
                '<span>#=AREA_NM #</span>' +
                '</div>' +
                '<div style="float: left; width: 200px; word-wrap:break-word; margin-left: 2px;">' +
                '<span>#=REGION_NAME ? REGION_NAME : " "#</span>' +
                '</div>' +
                '</div>',
                open: function () {
                    angular.element('.k-list-container').css({ "width": "460px" });
                },
                close: function () {
                    angular.element('.k-list-container').css({ "width": "" });
                    angular.element('.k-item').css({ "float": "", "width": "" });
                },
                dataBound: function () {
                    angular.element('.k-item').css({ "float": "left", "width": "402px" });
                }
            }

            $scope.actualSettlementDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetSettlement"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "SETL_NM", regionId: $scope.clientAddress.actualModel.REGION_ID, areaId: $scope.clientAddress.actualModel.AREA_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.settlementForChoose = data.response;
                }
            });
            $scope.actualSettlementOptions = {
                dataTextField: "SETL_NM",
                dataValueField: "SETL_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.selectedSettlement(dataItem);
                    $scope.$apply();
                },
                minLength: 2,
                dataSource: $scope.actualSettlementDataSource,
                template: $scope.clientAddress.settlementTemplate,
                open: function () {
                    angular.element('.k-list-container').css({ "width": "580px" });
                },
                close: function () {
                    angular.element('.k-list-container').css({ "width": "" });
                    angular.element('.k-item').css({ "float": "", "width": "" });
                },
                dataBound: function () {
                    angular.element('.k-item').css({ "float": "left", "width": "529px" });
                }
            }

            $scope.actualDropDownSettlementDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSettlement"),
                        cache: false
                    }
                }
            };

            $scope.actualDropDownSettlementOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.actualModel.SETL_TP_ID = parseInt(dataItem.SETL_TP_ID);
                    $scope.clientAddress.actualModel.SETL_TP_NM = dataItem.SETL_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.settlementDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.actualDropDownStreetDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownStreet"),
                        cache: false
                    }
                }
            };

            $scope.actualDropDownStreetOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.actualModel.STR_TP_ID = parseInt(dataItem.STR_TP_ID);
                    $scope.clientAddress.actualModel.STR_TP_NM = dataItem.STR_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.streetDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.actualStreetDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetStreet"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "STR_NM", settlementId: $scope.clientAddress.actualModel.SETL_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.streetForChoose = data.response;
                }
            });


            $scope.actualStreetOptions = {
                dataTextField: "STR_NM",
                dataValueField: "STR_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.selectedStreet(dataItem);
                    $scope.$apply();
                },
                minLength: 2,
                dataSource: $scope.actualStreetDataSource,
                template: $scope.clientAddress.streetTemplate,
                open: function () {
                    angular.element('.k-list-container').css({ "width": "400px" });
                },
                close: function () {
                    angular.element('.k-list-container').css({ "width": "" });
                    angular.element('.k-item').css({ "float": "", "width": "" });
                },
                dataBound: function () {
                    angular.element('.k-item').css({ "float": "left", "width": "362px" });
                }
            }

            $scope.actualDropDownHouseDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownHouse"),
                        cache: false
                    }
                }
            };

            $scope.actualDropDownHouseOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.actualModel.HOME_TYPE = parseInt(dataItem.HOUSE_TP_ID);
                    $scope.clientAddress.actualModel.HOME_TYPE_NM = dataItem.HOUSE_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.houseDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.actualDropDownSectionDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSection"),
                        cache: false
                    }
                }
            };

            $scope.actualDropDownSectionOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.actualModel.SECTION_TYPE = parseInt(dataItem.SECTION_TP_ID);
                    $scope.clientAddress.actualModel.SECTION_TYPE_NM = dataItem.SECTION_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.sectionDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.actualDropDownRoomDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownRoom"),
                        cache: false
                    }
                }
            };

            $scope.actualDropDownRoomOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.actualModel.ROOM_TYPE = parseInt(dataItem.ROOM_TP_ID);
                    $scope.clientAddress.actualModel.ROOM_TYPE_NM = dataItem.ROOM_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.roomDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.$on('writeActualAddress', function (event, args) {
                $scope.actualIndex = args.actualModel.index;
                $scope.REGION_ID = args.actualModel.REGION_ID;
                $scope.actualRegion = args.actualModel.REGION_NAME;
                $scope.AREA_ID = args.actualModel.AREA_ID;
                $scope.actualArea = args.actualModel.AREA_NAME;
                $scope.SETL_ID = args.actualModel.SETL_ID;
                $scope.actualSettlement = args.actualModel.SETTLEMET_NAME;
                $scope.SETL_TP_ID = args.actualModel.SETL_TP_ID;
                $scope.STR_ID = args.actualModel.STR_ID;
                $scope.actualStreet = args.actualModel.STREET_NAME;
                $scope.STR_TP_ID = args.actualModel.STR_TP_ID;
                $scope.HOUSE_ID = args.actualModel.HOUSE_ID;
                $scope.actualHouse = args.actualModel.HOUSE_NUM_FULL;
                $scope.actualSection = args.actualModel.SECTION;
                $scope.actualRoom = args.actualModel.ROOM;
                $scope.actualSettlementDropDown.value(args.actualModel.SETL_TP_ID);
                $scope.actualStreetDropDown.value(args.actualModel.STR_TP_ID);
                $scope.actualHouseDropDown.value(args.actualModel.HOME_TYPE);
                $scope.actualSectionDropDown.value(args.actualModel.SECTION_TYPE);
                $scope.actualRoomDropDown.value(args.actualModel.ROOM_TYPE);
                $scope.actualNote = args.actualModel.NOTE;

                $scope.disabledIndex = args.inputState.disabledIndex;
                $scope.disableRegion = args.inputState.disableRegion;
                $scope.disableArea = args.inputState.disableArea;
                $scope.disableSettlement = args.inputState.disableSettlement;
                $scope.disableSettlementType = args.inputState.disableSettlementType;
                $scope.disabledStreet = args.inputState.disabledStreet;
                $scope.disabledStreetType = args.inputState.disabledStreetType;
                $scope.disabledHouse = args.inputState.disabledHouse;
                $scope.disabledSection = args.inputState.disabledSection;
                $scope.disabledRoom = args.inputState.disabledRoom;
            });

            angular.element(document).ready(function () {
                $scope.bindModel();
            });

            $scope.changeActualIndex = function () {
                $scope.clientAddress.actualModel.index = $scope.actualIndex;
                $scope.clientAddress.testIndex($scope.clientAddress.actualModel);
            }

            $scope.changeActualRegion = function (regionName) {
                if (regionName != $scope.clientAddress.actualModel.REGION_NAME) {
                    $scope.clientAddress.actualModel.REGION_ID = null;
                    $scope.clientAddress.actualModel.REGION_NAME = regionName;
                }
                $scope.disabledStreet = $scope.disabledStreetType = regionName === "" || $scope.actualSettlement === "" || $scope.actualSettlement === undefined ? true : false;

                var showSpan = !regionName && !$scope.clientAddress.actualModel.settlementName;
                $scope.spanEnterRegionActual = { 'visibility': showSpan ? 'visible' : 'hidden' };
            }

            $scope.changeActualArea = function (areaName) {
                if (areaName != $scope.clientAddress.actualModel.AREA_NAME) {
                    $scope.clientAddress.actualModel.AREA_ID = null;
                    $scope.clientAddress.actualModel.AREA_NAME = areaName;
                }
                $scope.disableRegion = $scope.clientAddress.actualModel.AREA_ID ? true : false;
            }

            $scope.changeActualSettlement = function (settlementName) {
                if (settlementName != $scope.clientAddress.actualModel.SETTLEMET_NAME) {
                    $scope.clientAddress.actualModel.SETL_ID = null;
                    $scope.clientAddress.actualModel.SETTLEMET_NAME = settlementName;
                    $scope.disableSettlementType = false;
                }

                if (!settlementName) {
                    $scope.clientAddress.actualModel.SETL_TP_ID = 0;
                    $scope.clientAddress.actualModel.SETL_TP_NM = "";
                    $scope.actualSettlementDropDown.value(0);
                }
                $scope.disabledStreet = $scope.disabledStreetType = settlementName === "" || $scope.clientAddress.actualModel.REGION_NAME === "" || $scope.clientAddress.actualModel.REGION_NAME === null ? true : false;
                $scope.disableRegion = $scope.clientAddress.actualModel.SETL_ID ? true : false;
                $scope.disableArea = $scope.clientAddress.actualModel.SETL_ID ? true : false;
            }

            $scope.changeActualStreet = function (streetName) {
                if (streetName != $scope.clientAddress.actualModel.STREET_NAME) {
                    $scope.clientAddress.actualModel.STR_ID = null;
                    $scope.clientAddress.actualModel.STREET_NAME = streetName;
                    $scope.disabledStreetType = false;
                }

                if (!streetName) {
                    $scope.clientAddress.actualModel.STR_TP_ID = 0;
                    $scope.clientAddress.actualModel.STR_TP_NM = "";
                    $scope.actualStreetDropDown.value(0);
                }
                $scope.disabledHouse = streetName === "" ? true : false;
                $scope.disableArea = $scope.disableRegion = true;
                $scope.disableSettlement = !$scope.disabledHouse;
                $scope.disableSettlementType = streetName || $scope.clientAddress.actualModel.SETL_ID ? true : false;
            }

            $scope.actualHouseOptions = $scope.clientAddress.houseOptions;
            $scope.actualhouseDataSource = $scope.clientAddress.houseDataSource;

            $scope.actualhouseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: $scope.clientAddress.actualModel.STR_ID }
            }

            $scope.actualhouseDataSource.requestEnd = function (data) {
                $scope.houseForChoose = data.response;
            }

            $scope.actualHouseOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                $scope.selectedHouse(dataItem);
                $scope.$apply();
            }

            $scope.changeActualHouse = function (houseNumber) {
                if (houseNumber !== $scope.clientAddress.actualModel.HOUSE_NUM_FULL) {
                    $scope.clientAddress.actualModel.HOUSE_ID = null;
                    $scope.clientAddress.actualModel.HOUSE_NUM_FULL = houseNumber;
                    $scope.disabledIndex = false;
                    $scope.clientAddress.actualModel.index = $scope.actualIndex = "";
                }

                if (!houseNumber) {
                    $scope.clientAddress.actualModel.HOME_TYPE = 0;
                    $scope.clientAddress.actualModel.HOME_TYPE_NM = "";
                    $scope.actualHouseDropDown.value(0);
                }

                $scope.disabledStreet = houseNumber === "" ? false : true;
                $scope.disabledSection = $scope.disabledRoom = houseNumber === "" ? true : false;
                $scope.disabledStreetType = houseNumber || $scope.clientAddress.actualModel.STR_ID ? true : false;
            }

            $scope.changeActualSection = function (actualSection) {
                $scope.clientAddress.actualModel.SECTION = actualSection;
                $scope.disabledHouse = actualSection || $scope.actualRoom ? true : false;

                if (!actualSection) {
                    $scope.clientAddress.actualModel.SECTION_TYPE = 0;
                    $scope.clientAddress.actualModel.SECTION_TYPE_NM = "";
                    $scope.actualSectionDropDown.value(0);
                }
            }

            $scope.changeActualRoom = function (actualRoom) {
                $scope.clientAddress.actualModel.ROOM = actualRoom;
                $scope.disabledHouse = actualRoom || $scope.actualSection ? true : false;
                $scope.disabledSection = actualRoom && $scope.actualSection ? true : false;

                if (!actualRoom) {
                    $scope.clientAddress.actualModel.ROOM_TYPE = 0;
                    $scope.clientAddress.actualModel.ROOM_TYPE_NM = "";
                    $scope.actualRoomDropDown.value(0);
                }
            }

            $scope.changeActualNote = function () {
                $scope.clientAddress.actualModel.NOTE = $scope.actualNote;
            }

            $scope.clearActualAddress = function () {

                $scope.actualIndex = "";
                $scope.actualRegion = "";
                $scope.actualArea = "";
                $scope.actualSettlement = "";
                $scope.actualStreet = "";
                $scope.actualHouse = "";
                $scope.actualSection = "";
                $scope.actualRoom = "";
                $scope.actualNote = "";
                $scope.actualSettlementDropDown.value(0);
                $scope.actualStreetDropDown.value(0);
                $scope.actualHouseDropDown.value(0);
                $scope.actualSectionDropDown.value(0);
                $scope.actualRoomDropDown.value(0);

                $scope.disabledIndex = $scope.disableRegion = $scope.disableArea = $scope.disableSettlement = $scope.disableSettlementType = false;
                $scope.disabledStreet = $scope.disabledHouse = $scope.disabledSection = $scope.disabledRoom = $scope.disabledStreetType = true;

                $scope.clientAddress.actualModel = {
                    REGION_ID: null,
                    AREA_ID: null,
                    SETL_ID: null,
                    STR_ID: null,
                    SETL_TP_ID: 0,
                    SETL_TP_NM: "",
                    STR_TP_ID: 0,
                    index: "",
                    indexDict: "",
                    REGION_NAME: "",
                    AREA_NAME: "",
                    SETTLEMET_NAME: "",
                    STREET_NAME: "",
                    HOME_TYPE: 0,
                    HOUSE_ID: null,
                    HOUSE_NUM_FULL: "",
                    SECTION_TYPE: 0,
                    SECTION: "",
                    ROOM_TYPE: 0,
                    ROOM: "",
                    NOTE: "",
                    ROOM_TYPE_NM: " ",
                    SECTION_TYPE_NM: " ",
                    HOME_TYPE_NM: " ",
                    STR_TP_NM: " "
                };
            }

            $scope.bindModel = function () {

                var actualModel = $scope.clientAddress.actualModel;

                actualModel.indexChecked = false;
                $scope.actualIndex = actualModel.indexDict = actualModel.index;
                $scope.actualRegion = actualModel.REGION_NAME;
                $scope.actualArea = actualModel.AREA_NAME;
                $scope.actualSettlement = actualModel.SETTLEMET_NAME;
                $scope.actualStreet = actualModel.STREET_NAME;
                $scope.actualHouse = actualModel.HOUSE_NUM_FULL;
                $scope.actualSection = actualModel.SECTION;
                $scope.actualRoom = actualModel.ROOM;
                $scope.actualNote = actualModel.NOTE;

                $scope.actualSettlementDropDown.value($scope.clientAddress.actualModel.SETL_TP_ID);
                $scope.actualStreetDropDown.value($scope.clientAddress.actualModel.STR_TP_ID);
                $scope.actualHouseDropDown.value($scope.clientAddress.actualModel.HOME_TYPE);
                $scope.actualSectionDropDown.value($scope.clientAddress.actualModel.SECTION_TYPE);
                $scope.actualRoomDropDown.value($scope.clientAddress.actualModel.ROOM_TYPE);

                $scope.disabledIndex = actualModel.HOUSE_ID === null || actualModel.index === null || actualModel.index === "" ? false : true;
                $scope.disableRegion = !actualModel.STREET_NAME || (actualModel.SETL_ID === null && actualModel.AREA_ID !== null) ? false : true;
                $scope.disableArea = actualModel.SETL_ID === null || !actualModel.STREET_NAME ? false : true;
                $scope.disableSettlement = $scope.disableSettlementType = !actualModel.STREET_NAME ? false : true;
                $scope.disabledStreet = $scope.disabledStreetType = actualModel.HOUSE_NUM_FULL || !actualModel.SETTLEMET_NAME || !actualModel.REGION_NAME ? true : false;
                $scope.disabledHouse = !actualModel.SETTLEMET_NAME || !actualModel.REGION_NAME || actualModel.SECTION || actualModel.ROOM ? true : false;
                $scope.disabledSection = !actualModel.HOUSE_NUM_FULL || !actualModel.SETTLEMET_NAME || !actualModel.REGION_NAME ? true : false;
                $scope.disabledRoom = !actualModel.HOUSE_NUM_FULL || !actualModel.SETTLEMET_NAME || !actualModel.REGION_NAME ? true : false;
				$scope.$apply();
            }


            $scope.selectedRegion = function (data) {
                $scope.clientAddress.actualModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.actualModel.REGION_NAME = data.REGION_NM;
            }

            $scope.regionLostFocus = function () {
                for (var i = 0; i < $scope.regionForChoose.length; i++) {
                    if ($scope.clientAddress.actualModel.REGION_NAME.toUpperCase() === $scope.regionForChoose[i].REGION_NM.toUpperCase()) {
                        $scope.selectedRegion($scope.regionForChoose[i]);
                    }
                };
            }

            $scope.selectedArea = function (data) {
                $scope.clientAddress.actualModel.AREA_NAME = data.AREA_NM;
                $scope.clientAddress.actualModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.actualModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.actualModel.REGION_NAME = $scope.actualRegion = data.REGION_NAME;
                $scope.disableRegion = true;
            }

            $scope.areaLostFocus = function () {
                for (var i = 0; i < $scope.areaForChoose.length; i++) {
                    if ($scope.clientAddress.actualModel.AREA_NAME.toUpperCase() === $scope.areaForChoose[i].AREA_NM.toUpperCase() && !$scope.clientAddress.actualModel.AREA_ID) {
                        $scope.selectedArea($scope.areaForChoose[i]);
                    }
                };
            }

            $scope.selectedSettlement = function (data) {
                $scope.clientAddress.actualModel.SETL_TP_ID = data.SETL_TP_ID;
                $scope.clientAddress.actualModel.SETL_TP_NM = data.SETL_TP_NM;
                $scope.clientAddress.actualModel.SETTLEMET_NAME = data.SETL_NM;
                $scope.clientAddress.actualModel.SETL_ID = data.SETL_ID;
                $scope.clientAddress.actualModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.actualModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.actualModel.REGION_NAME = $scope.actualRegion = data.REGION_NAME;
                $scope.clientAddress.actualModel.AREA_NAME = $scope.actualArea = data.AREA_NAME;
                $scope.actualSettlementDropDown.value(data.SETL_TP_ID);
                $scope.disabledStreet = $scope.disabledStreetType = false;
                $scope.disableRegion = $scope.disableArea = $scope.disableSettlementType = true;

                $scope.spanEnterRegionActual = { 'visibility': 'hidden' };
            }

            $scope.settlementLostFocus = function () {
                $scope.spanEnterRegionActual = { 'visibility': $scope.clientAddress.actualModel.REGION_NAME ? 'hidden' : 'visible' };
                for (var i = 0; i < $scope.settlementForChoose.length; i++) {
                    if ($scope.clientAddress.actualModel.SETTLEMET_NAME.toUpperCase() === $scope.settlementForChoose[i].SETL_NM.toUpperCase() && !$scope.clientAddress.actualModel.SETL_ID) {
                        $scope.selectedSettlement($scope.settlementForChoose[i]);
                    }
                };
            }

            $scope.selectedStreet = function (data) {
                $scope.clientAddress.actualModel.STR_ID = data.STR_ID;
                $scope.clientAddress.actualModel.STREET_NAME = data.STR_NM;
                $scope.clientAddress.actualModel.STR_TP_ID = data.STR_TP_ID;
                $scope.clientAddress.actualModel.STR_TP_NM = data.STR_TP_NM;
                $scope.actualStreetDropDown.value(data.STR_TP_ID);
                $scope.disabledStreetType = true;
            }


            $scope.streetLostFocus = function () {
                for (var i = 0; i < $scope.streetForChoose.length; i++) {
                    if ($scope.clientAddress.actualModel.STR_ID === $scope.streetForChoose[i].STR_ID) {
                        $scope.selectedStreet($scope.streetForChoose[i]);
                    }
                };
            }

            $scope.selectedHouse = function (data) {
                $scope.clientAddress.actualModel.HOUSE_NUM_FULL = data.HOUSE_NUM_FULL;
                $scope.clientAddress.actualModel.HOUSE_ID = data.HOUSE_ID;

                if (data.POSTAL_CODE) {
                    $scope.actualIndex = $scope.clientAddress.actualModel.indexDict = $scope.clientAddress.actualModel.index = data.POSTAL_CODE;
                    $scope.clientAddress.actualModel.indexChecked = $scope.disabledIndex = true;
                }
                else {
                    $scope.actualIndex = $scope.clientAddress.actualModel.index = "";
                    $scope.disabledIndex = false;
                }
            }

            $scope.houseLostFocus = function () {
                for (var i = 0; i < $scope.houseForChoose.length; i++) {
                    if ($scope.clientAddress.actualModel.HOUSE_NUM_FULL.toUpperCase() === $scope.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase()) {
                        $scope.selectedHouse($scope.houseForChoose[i]);
                    }
                };
            }

            $scope.checkKeyDown = function (e, type) {
                if (e.keyCode === $scope.KEY_ENTER)
                    $scope.checkAddressType(type);
            }

            $scope.checkAddressType = function (type) {
                switch (type) {
                    case "region":
                        $scope.regionLostFocus();
                        break;
                    case "area":
                        $scope.areaLostFocus();
                        break;
                    case "settlement":
                        $scope.settlementLostFocus();
                        break;
                    case "street":
                        $scope.streetLostFocus();
                        break;
                    case "house":
                        $scope.houseLostFocus();
                        break;
                }
            }
        }]);