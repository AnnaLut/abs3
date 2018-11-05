angular.module(globalSettings.modulesAreas)
    .controller('ClientAddressLegalCtrl',
    ['$scope',
        function ($scope) {


            $scope.regionForChoose = [];
            $scope.areaForChoose = [];
            $scope.settlementForChoose = [];
            $scope.streetForChoose = [];
            $scope.houseForChoose = [];

            $scope.spanEnterRegionLegal = { 'visibility': 'hidden' };

            $scope.KEY_ENTER = 13;

            $scope.legalRegionDataSource = new kendo.data.DataSource({
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


            $scope.legalRegionOptions = {
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
                dataSource: $scope.legalRegionDataSource
            }

            $scope.legalAreasDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetAreas"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "AREA_NM", regionId: $scope.clientAddress.legalModel.REGION_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.areaForChoose = data.response;
                }
            });

            $scope.legalAreasOptions = {
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
                dataSource: $scope.legalAreasDataSource,
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

            $scope.legalSettlementDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetSettlement"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "SETL_NM", regionId: $scope.clientAddress.legalModel.REGION_ID, areaId: $scope.clientAddress.legalModel.AREA_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.settlementForChoose = data.response;
                }
            });

            $scope.legalSettlementOptions = {
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
                dataSource: $scope.legalSettlementDataSource,
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

            $scope.legalStreetDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetStreet"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "STR_NM", settlementId: $scope.clientAddress.legalModel.SETL_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.streetForChoose = data.response;
                }
            });

            $scope.legalStreetOptions = {
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
                dataSource: $scope.legalStreetDataSource,
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

            $scope.legalDropDownSettlementDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSettlement"),
                        cache: false
                    }
                }
            };

            $scope.legalDropDownStreetDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownStreet"),
                        cache: false
                    }
                }
            };

            $scope.legalDropDownHouseDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownHouse"),
                        cache: false
                    }
                }
            };

            $scope.legalDropDownSectionDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSection"),
                        cache: false
                    }
                }
            };

            $scope.legalDropDownRoomDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownRoom"),
                        cache: false
                    }
                }
            };

            $scope.legalDropDownRoomOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.legalModel.ROOM_TYPE = parseInt(dataItem.ROOM_TP_ID);
                    $scope.clientAddress.legalModel.ROOM_TYPE_NM = dataItem.ROOM_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.roomDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.legalDropDownSectionOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.legalModel.SECTION_TYPE = parseInt(dataItem.SECTION_TP_ID);
                    $scope.clientAddress.legalModel.SECTION_TYPE_NM = dataItem.SECTION_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.sectionDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.legalDropDownHouseOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.legalModel.HOME_TYPE = parseInt(dataItem.HOUSE_TP_ID);
                    $scope.clientAddress.legalModel.HOME_TYPE_NM = dataItem.HOUSE_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.houseDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.legalDropDownSettlementOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.legalModel.SETL_TP_ID = parseInt(dataItem.SETL_TP_ID);
                    $scope.clientAddress.legalModel.SETL_TP_NM = dataItem.SETL_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.settlementDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.legalDropDownStreetOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.legalModel.STR_TP_ID = parseInt(dataItem.STR_TP_ID);
                    $scope.clientAddress.legalModel.STR_TP_NM = dataItem.STR_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.streetDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };


            angular.element(document).ready(function () {
                $scope.bindModel();
				$scope.$apply();
            });

            $scope.changeLegalIndex = function () {
                $scope.clientAddress.legalModel.index = $scope.legalIndex;
                $scope.clientAddress.testIndex($scope.clientAddress.legalModel);
            }

            $scope.changeLegalRegion = function (regionName) {
                if (regionName != $scope.clientAddress.legalModel.REGION_NAME) {
                    $scope.clientAddress.legalModel.REGION_ID = null;
                    $scope.clientAddress.legalModel.REGION_NAME = regionName;
                }
                $scope.disabledStreet = $scope.disabledStreetType = regionName === "" || $scope.legalSettlement === "" || $scope.legalSettlement === undefined ? true : false;

                var showSpan = !regionName && !$scope.clientAddress.legalModel.settlementName;
                $scope.spanEnterRegionLegal = { 'visibility': showSpan ? 'visible' : 'hidden' };
            }

            $scope.changeLegalArea = function (areaName) {
                if (areaName != $scope.clientAddress.legalModel.AREA_NAME) {
                    $scope.clientAddress.legalModel.AREA_ID = null;
                    $scope.clientAddress.legalModel.AREA_NAME = areaName;
                }
                $scope.disableRegion = $scope.clientAddress.legalModel.AREA_ID ? true : false;
            }

            $scope.changeLegalSettlement = function (settlementName) {
                if (settlementName != $scope.clientAddress.legalModel.SETTLEMET_NAME) {
                    $scope.clientAddress.legalModel.SETL_ID = null;
                    $scope.clientAddress.legalModel.SETTLEMET_NAME = settlementName;
                    $scope.disableSettlementType = false;
                }

                if (!settlementName) {
                    $scope.clientAddress.legalModel.SETL_TP_ID = 0;
                    $scope.clientAddress.legalModel.SETL_TP_NM = "";
                    $scope.legalSettlementDropDown.value(0);
                }

                $scope.disabledStreet = $scope.disabledStreetType = settlementName === "" || $scope.clientAddress.legalModel.REGION_NAME === "" || $scope.clientAddress.legalModel.REGION_NAME === null ? true : false;
                $scope.disableRegion = $scope.clientAddress.legalModel.SETL_ID ? true : false;
                $scope.disableArea = $scope.clientAddress.legalModel.SETL_ID ? true : false;
            }

            $scope.changeLegalStreet = function (streetName) {
                if (streetName != $scope.clientAddress.legalModel.STREET_NAME) {
                    $scope.clientAddress.legalModel.STR_ID = null;
                    $scope.clientAddress.legalModel.STREET_NAME = streetName;
                    $scope.disabledStreetType = false;
                }

                if (!streetName) {
                    $scope.clientAddress.legalModel.STR_TP_ID = 0;
                    $scope.clientAddress.legalModel.STR_TP_NM = "";
                    $scope.legalStreetDropDown.value(0);
                }
                $scope.disabledHouse = streetName === "" ? true : false;
                $scope.disableArea = $scope.disableRegion = true;
                $scope.disableSettlement = !$scope.disabledHouse;
                $scope.disableSettlementType = streetName || $scope.clientAddress.legalModel.SETL_ID ? true : false;
            }

            $scope.legalHouseOptions = $scope.clientAddress.houseOptions;
            $scope.legalHouseDataSource = $scope.clientAddress.houseDataSource;

            $scope.legalHouseDataSource.requestEnd = function (data) {
                $scope.houseForChoose = data.response;
            }

            $scope.legalHouseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: $scope.clientAddress.legalModel.STR_ID }
            }

            $scope.legalHouseOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                $scope.selectedHouse(dataItem);
                $scope.$apply();
            }

            $scope.changeLegalHouse = function (houseNumber) {
                if (houseNumber !== $scope.clientAddress.legalModel.HOUSE_NUM_FULL) {
                    $scope.clientAddress.legalModel.HOUSE_ID = null;
                    $scope.clientAddress.legalModel.HOUSE_NUM_FULL = houseNumber;
                    $scope.disabledIndex = false;
                    $scope.clientAddress.legalModel.index = $scope.legalIndex = "";
                }

                if (!houseNumber) {
                    $scope.clientAddress.legalModel.HOME_TYPE = 0;
                    $scope.clientAddress.legalModel.HOME_TYPE_NM = "";
                    $scope.legalHouseDropDown.value(0);
                }

                $scope.disabledStreet = houseNumber === "" ? false : true;
                $scope.disabledSection = $scope.disabledRoom = houseNumber === "" ? true : false;
                $scope.disabledStreetType = houseNumber || $scope.clientAddress.legalModel.STR_ID ? true : false;
            }

            $scope.changeLegalSection = function (legalSection) {
                $scope.clientAddress.legalModel.SECTION = legalSection;
                $scope.disabledHouse = legalSection || $scope.legalRoom ? true : false;

                if (!legalSection) {
                    $scope.clientAddress.legalModel.SECTION_TYPE = 0;
                    $scope.clientAddress.legalModel.SECTION_TYPE_NM = "";
                    $scope.legalSectionDropDown.value(0);
                }
            }

            $scope.changeLegalRoom = function (legalRoom) {
                $scope.clientAddress.legalModel.ROOM = legalRoom;
                $scope.disabledHouse = legalRoom || $scope.legalSection ? true : false;
                $scope.disabledSection = legalRoom && $scope.legalSection ? true : false;

                if (!legalRoom) {
                    $scope.clientAddress.legalModel.ROOM_TYPE = 0;
                    $scope.clientAddress.legalModel.ROOM_TYPE_NM = "";
                    $scope.legalRoomDropDown.value(0);
                }
            }

            $scope.changeLegalNote = function () {
                $scope.clientAddress.legalModel.NOTE = $scope.legalNote;
            }

            $scope.clearLegalAddress = function () {

                $scope.legalIndex = "";
                $scope.legalRegion = "";
                $scope.legalArea = "";
                $scope.legalSettlement = "";
                $scope.legalStreet = "";
                $scope.legalHouse = "";
                $scope.legalSection = "";
                $scope.legalRoom = "";
                $scope.legalNote = "";
                $scope.legalSettlementDropDown.value(0);
                $scope.legalStreetDropDown.value(0);
                $scope.legalHouseDropDown.value(0);
                $scope.legalSectionDropDown.value(0);
                $scope.legalRoomDropDown.value(0);

                $scope.disabledIndex = $scope.disableRegion = $scope.disableArea = $scope.disableSettlement = $scope.disableSettlementType = false;
                $scope.disabledStreet = $scope.disabledHouse = $scope.disabledSection = $scope.disabledRoom = $scope.disabledStreetType = true;

                $scope.clientAddress.legalModel = {
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
                    ROOM_TYPE_NM: "",
                    SECTION_TYPE_NM: "",
                    HOME_TYPE_NM: "",
                    STR_TP_NM: ""
                };
            }

            $scope.bindModel = function () {

                var legalModel = $scope.clientAddress.legalModel;

                legalModel.indexChecked = false;
                $scope.legalIndex = legalModel.indexDict = legalModel.index;
                $scope.legalRegion = legalModel.REGION_NAME;
                $scope.legalArea = legalModel.AREA_NAME;
                $scope.legalSettlement = legalModel.SETTLEMET_NAME;
                $scope.legalStreet = legalModel.STREET_NAME;
                $scope.legalHouse = legalModel.HOUSE_NUM_FULL;
                $scope.legalSection = legalModel.SECTION;
                $scope.legalRoom = legalModel.ROOM;
                $scope.legalNote = legalModel.NOTE;

                $scope.legalSettlementDropDown.value(legalModel.SETL_TP_ID);
                $scope.legalStreetDropDown.value(legalModel.STR_TP_ID);
                $scope.legalHouseDropDown.value(legalModel.HOME_TYPE);
                $scope.legalSectionDropDown.value(legalModel.SECTION_TYPE);
                $scope.legalRoomDropDown.value(legalModel.ROOM_TYPE);

                $scope.disabledIndex = $scope.clientAddress.legalModel.HOUSE_ID === null || legalModel.index === null || legalModel.index === "" ? false : true;
                $scope.disableRegion = !legalModel.STREET_NAME || (legalModel.SETL_ID === null && legalModel.AREA_ID !== null) ? false : true;
                $scope.disableArea = legalModel.SETL_ID === null || !legalModel.STREET_NAME ? false : true;
                $scope.disableSettlement = $scope.disableSettlementType = !legalModel.STREET_NAME ? false : true;
                $scope.disabledStreet = $scope.disabledStreetType = legalModel.HOUSE_NUM_FULL || !legalModel.SETTLEMET_NAME || !legalModel.REGION_NAME ? true : false;
                $scope.disabledHouse = !legalModel.SETTLEMET_NAME || !legalModel.REGION_NAME || legalModel.SECTION || legalModel.ROOM ? true : false;
                $scope.disabledSection = !legalModel.HOUSE_NUM_FULL || !legalModel.SETTLEMET_NAME || !legalModel.REGION_NAME ? true : false;
                $scope.disabledRoom = !legalModel.HOUSE_NUM_FULL || !legalModel.SETTLEMET_NAME || !legalModel.REGION_NAME ? true : false;

                document.getElementById("buttonToFocus").focus();
                $scope.buttonToFocus = false;
            }

            $scope.getInputState = function () {

                var inputState = {
                    disabledIndex: $scope.disabledIndex,
                    disableRegion: $scope.disableRegion,
                    disableArea: $scope.disableArea,
                    disableSettlement: $scope.disableSettlement,
                    disableSettlementType: $scope.disableSettlementType,
                    disabledStreet: $scope.disabledStreet,
                    disabledStreetType: $scope.disabledStreetType,
                    disabledHouse: $scope.disabledHouse,
                    disabledSection: $scope.disabledSection,
                    disabledRoom: $scope.disabledRoom
                }
                $scope.$emit('getInputState', { inputState: inputState });
            }

            $scope.$on('callToGetInputState', function () {
                $scope.getInputState();
            });

            $scope.selectedRegion = function (data) {
                $scope.clientAddress.legalModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.legalModel.REGION_NAME = data.REGION_NM;
            }

            $scope.regionLostFocus = function () {
                for (var i = 0; i < $scope.regionForChoose.length; i++) {
                    if ($scope.clientAddress.legalModel.REGION_NAME.toUpperCase() === $scope.regionForChoose[i].REGION_NM.toUpperCase()) {
                        $scope.selectedRegion($scope.regionForChoose[i]);
                    }
                };
            }

            $scope.selectedArea = function (data) {
                $scope.clientAddress.legalModel.AREA_NAME = data.AREA_NM;
                $scope.clientAddress.legalModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.legalModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.legalModel.REGION_NAME = $scope.legalRegion = data.REGION_NAME;
                $scope.disableRegion = true;
            }

            $scope.areaLostFocus = function () {
                for (var i = 0; i < $scope.areaForChoose.length; i++) {
                    if ($scope.clientAddress.legalModel.AREA_NAME.toUpperCase() === $scope.areaForChoose[i].AREA_NM.toUpperCase() && !$scope.clientAddress.legalModel.AREA_ID) {
                        $scope.selectedArea($scope.areaForChoose[i]);
                    }
                };
            }

            $scope.selectedSettlement = function (data) {
                $scope.clientAddress.legalModel.SETL_TP_ID = data.SETL_TP_ID;
                $scope.clientAddress.legalModel.SETL_TP_NM = data.SETL_TP_NM;
                $scope.clientAddress.legalModel.SETTLEMET_NAME = data.SETL_NM;
                $scope.clientAddress.legalModel.SETL_ID = data.SETL_ID;
                $scope.clientAddress.legalModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.legalModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.legalModel.REGION_NAME = $scope.legalRegion = data.REGION_NAME;
                $scope.clientAddress.legalModel.AREA_NAME = $scope.legalArea = data.AREA_NAME;
                $scope.legalSettlementDropDown.value(data.SETL_TP_ID);
                $scope.disabledStreet = $scope.disabledStreetType = false;
                $scope.disableRegion = $scope.disableArea = $scope.disableSettlementType = true;

                $scope.spanEnterRegionLegal = { 'visibility': 'hidden' };
            }

            $scope.settlementLostFocus = function () {
                $scope.spanEnterRegionLegal = { 'visibility': $scope.clientAddress.legalModel.REGION_NAME ? 'hidden' : 'visible' };
                for (var i = 0; i < $scope.settlementForChoose.length; i++) {
                    if ($scope.clientAddress.legalModel.SETTLEMET_NAME.toUpperCase() === $scope.settlementForChoose[i].SETL_NM.toUpperCase() && !$scope.clientAddress.legalModel.SETL_ID) {
                        $scope.selectedSettlement($scope.settlementForChoose[i]);
                    }
                };
            }

            $scope.selectedStreet = function (data) {
                $scope.clientAddress.legalModel.STR_ID = data.STR_ID;
                $scope.clientAddress.legalModel.STREET_NAME = data.STR_NM;
                $scope.clientAddress.legalModel.STR_TP_ID = data.STR_TP_ID;
                $scope.clientAddress.legalModel.STR_TP_NM = data.STR_TP_NM;
                $scope.legalStreetDropDown.value(data.STR_TP_ID);
                $scope.disabledStreetType = true;
            }

            $scope.streetLostFocus = function () {
                for (var i = 0; i < $scope.streetForChoose.length; i++) {
                    if ($scope.clientAddress.legalModel.STR_ID === $scope.streetForChoose[i].STR_ID) {
                        $scope.selectedStreet($scope.streetForChoose[i]);
                    }
                };
            }

            $scope.selectedHouse = function (data) {
                $scope.clientAddress.legalModel.HOUSE_NUM_FULL = data.HOUSE_NUM_FULL;
                $scope.clientAddress.legalModel.HOUSE_ID = data.HOUSE_ID;

                if (data.POSTAL_CODE) {
                    $scope.legalIndex = $scope.clientAddress.legalModel.indexDict = $scope.clientAddress.legalModel.index = data.POSTAL_CODE;
                    $scope.clientAddress.legalModel.indexChecked = $scope.disabledIndex = true;
                }
                else {
                    $scope.legalIndex = $scope.clientAddress.legalModel.index = "";
                    $scope.disabledIndex = false;
                }
            }

            $scope.houseLostFocus = function () {
                for (var i = 0; i < $scope.houseForChoose.length; i++) {
                    if ($scope.clientAddress.legalModel.HOUSE_NUM_FULL.toUpperCase() === $scope.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase()) {
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