angular.module(globalSettings.modulesAreas)
    .controller('ClientAddressMailCtrl',
    ['$scope',
        function ($scope) {

            $scope.regionForChoose = [];
            $scope.areaForChoose = [];
            $scope.settlementForChoose = [];
            $scope.streetForChoose = [];
            $scope.houseForChoose = [];

            $scope.spanEnterRegionMail = { 'visibility': 'hidden' };

            $scope.KEY_ENTER = 13;

            $scope.mailRegionDataSource = new kendo.data.DataSource({
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



            $scope.mailRegionOptions = {
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
                dataSource: $scope.mailRegionDataSource
            }

            $scope.mailAreasDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetAreas"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "AREA_NM", regionId: $scope.clientAddress.mailModel.REGION_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.areaForChoose = data.response;
                }
            });

            $scope.mailAreasOptions = {
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
                dataSource: $scope.mailAreasDataSource,
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

            $scope.mailDropDownSettlementDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSettlement"),
                        cache: false
                    }
                }
            };

            $scope.mailDropDownSettlementOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.mailModel.SETL_TP_ID = parseInt(dataItem.SETL_TP_ID);
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.settlementDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };


            $scope.mailSettlementDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetSettlement"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "SETL_NM", regionId: $scope.clientAddress.mailModel.REGION_ID, areaId: $scope.clientAddress.mailModel.AREA_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.settlementForChoose = data.response;
                }
            });
            $scope.mailSettlementOptions = {
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
                dataSource: $scope.mailSettlementDataSource,
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

            $scope.mailDropDownStreetDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownStreet"),
                        cache: false
                    }
                }
            };

            $scope.mailDropDownStreetOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.mailModel.STR_TP_ID = parseInt(dataItem.STR_TP_ID);
                    $scope.clientAddress.mailModel.STR_TP_NM = dataItem.STR_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.streetDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };


            $scope.mailStreetDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetStreet"),
                        dataType: 'json',
                        cache: false,
                        data: function () { return { columnName: "STR_NM", settlementId: $scope.clientAddress.mailModel.SETL_ID } }
                    }
                },
                requestEnd: function (data) {
                    $scope.streetForChoose = data.response;
                }
            });

            $scope.mailStreetOptions = {
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
                dataSource: $scope.mailStreetDataSource,
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

            $scope.mailDropDownHouseDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownHouse"),
                        cache: false
                    }
                }
            };

            $scope.mailDropDownHouseOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.mailModel.HOME_TYPE = parseInt(dataItem.HOUSE_TP_ID);
                    $scope.clientAddress.mailModel.HOME_TYPE_NM = dataItem.HOUSE_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.houseDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.mailDropDownSectionDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSection"),
                        cache: false
                    }
                }
            };

            $scope.mailDropDownSectionOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.mailModel.SECTION_TYPE = parseInt(dataItem.SECTION_TP_ID);
                    $scope.clientAddress.mailModel.SECTION_TYPE_NM = dataItem.SECTION_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.sectionDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.mailDropDownRoomDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownRoom"),
                        cache: false
                    }
                }
            };

            $scope.mailDropDownRoomOptions = {
                select: function (e) {
                    var dataItem = this.dataItem(e.item.index());
                    $scope.clientAddress.mailModel.ROOM_TYPE = parseInt(dataItem.ROOM_TP_ID);
                    $scope.clientAddress.mailModel.ROOM_TYPE_NM = dataItem.ROOM_TP_NM;
                    $scope.$apply();
                },
                dataBound: $scope.clientAddress.roomDropDownBoundFunc.BoundFunction,
                open: $scope.clientAddress.createDropDownOptions.open,
                close: $scope.clientAddress.createDropDownOptions.close
            };

            $scope.$on('writeMailAddress', function (event, args) {

                $scope.mailIndex = args.mailModel.index;
                $scope.REGION_ID = args.mailModel.REGION_ID;
                $scope.mailRegion = args.mailModel.REGION_NAME;
                $scope.AREA_ID = args.mailModel.AREA_ID;
                $scope.mailArea = args.mailModel.AREA_NAME;
                $scope.SETL_ID = args.mailModel.SETL_ID;
                $scope.mailSettlement = args.mailModel.SETTLEMET_NAME;
                $scope.SETL_TP_ID = args.mailModel.SETL_TP_ID;
                $scope.STR_ID = args.mailModel.STR_ID;
                $scope.mailStreet = args.mailModel.STREET_NAME;
                $scope.STR_TP_ID = args.mailModel.STR_TP_ID;
                $scope.HOUSE_ID = args.mailModel.HOUSE_ID;
                $scope.mailHouse = args.mailModel.HOUSE_NUM_FULL;
                $scope.mailSection = args.mailModel.SECTION;
                $scope.mailRoom = args.mailModel.ROOM;
                $scope.mailSettlementDropDown.value(args.mailModel.SETL_TP_ID);
                $scope.mailStreetDropDown.value(args.mailModel.STR_TP_ID);
                $scope.mailHouseDropDown.value(args.mailModel.HOME_TYPE);
                $scope.mailSectionDropDown.value(args.mailModel.SECTION_TYPE);
                $scope.mailRoomDropDown.value(args.mailModel.ROOM_TYPE);
                $scope.mailNote = args.mailModel.NOTE;

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

            $scope.changeMailIndex = function () {
                $scope.clientAddress.mailModel.index = $scope.mailIndex;
                $scope.clientAddress.testIndex($scope.clientAddress.mailModel);
            }

            $scope.changeMailRegion = function (regionName) {
                if (regionName != $scope.clientAddress.mailModel.REGION_NAME) {
                    $scope.clientAddress.mailModel.REGION_ID = null;
                    $scope.clientAddress.mailModel.REGION_NAME = regionName;
                }
                $scope.disabledStreet = $scope.disabledStreetType = regionName === "" || $scope.mailSettlement === "" || $scope.mailSettlement === undefined ? true : false;

                var showSpan = !regionName && !$scope.clientAddress.mailModel.settlementName;
                $scope.spanEnterRegionMail = { 'visibility': showSpan ? 'visible' : 'hidden' };
            }

            $scope.changeMailAreas = function (areaName) {
                if (areaName != $scope.clientAddress.mailModel.AREA_NAME) {
                    $scope.clientAddress.mailModel.AREA_ID = null;
                    $scope.clientAddress.mailModel.AREA_NAME = areaName;
                }
                $scope.disableRegion = $scope.clientAddress.mailModel.AREA_ID ? true : false;
            }

            $scope.changeMailSettlement = function (settlementName) {
                if (settlementName != $scope.clientAddress.mailModel.SETTLEMET_NAME) {
                    $scope.clientAddress.mailModel.SETL_ID = null;
                    $scope.clientAddress.mailModel.SETTLEMET_NAME = settlementName;
                    $scope.disableSettlementType = false;
                }

                if (!settlementName) {
                    $scope.clientAddress.mailModel.SETL_TP_ID = 0;
                    $scope.clientAddress.mailModel.SETL_TP_NM = "";
                    $scope.mailSettlementDropDown.value(0);
                }

                $scope.disabledStreet = $scope.disabledStreetType = settlementName === "" || $scope.clientAddress.mailModel.REGION_NAME === "" || $scope.clientAddress.mailModel.REGION_NAME === null ? true : false;
                $scope.disableRegion = $scope.clientAddress.mailModel.SETL_ID ? true : false;
                $scope.disableArea = $scope.clientAddress.mailModel.SETL_ID ? true : false;
            }

            $scope.changeMailStreet = function (streetName) {
                if (streetName != $scope.clientAddress.mailModel.STREET_NAME) {
                    $scope.clientAddress.mailModel.STR_ID = null;
                    $scope.clientAddress.mailModel.STREET_NAME = streetName;
                    $scope.disabledStreetType = false;
                }

                if (!streetName) {
                    $scope.clientAddress.mailModel.STR_TP_ID = 0;
                    $scope.clientAddress.mailModel.STR_TP_NM = "";
                    $scope.mailStreetDropDown.value(0);
                }
                $scope.disabledHouse = streetName === "" ? true : false;
                $scope.disableArea = $scope.disableRegion = true;
                $scope.disableSettlement = !$scope.disabledHouse;
                $scope.disableSettlementType = streetName || $scope.clientAddress.mailModel.SETL_ID ? true : false;
            }

            $scope.mailHouseOptions = $scope.clientAddress.houseOptions;
            $scope.mailhouseDataSource = $scope.clientAddress.houseDataSource;

            $scope.mailhouseDataSource.transport.read.data = function () {
                return { columnName: "HOUSE_NUM_FULL", streetId: $scope.clientAddress.mailModel.STR_ID }
            }

            $scope.mailhouseDataSource.requestEnd = function (data) {
                $scope.houseForChoose = data.response;
            }

            $scope.mailHouseOptions.select = function (e) {
                var dataItem = this.dataItem(e.item.index());
                $scope.selectedHouse(dataItem);
                $scope.$apply();
            }

            $scope.changeMailHouse = function (houseNumber) {
                if (houseNumber !== $scope.clientAddress.mailModel.HOUSE_NUM_FULL) {
                    $scope.clientAddress.mailModel.HOUSE_ID = null;
                    $scope.clientAddress.mailModel.HOUSE_NUM_FULL = houseNumber;
                    $scope.disabledIndex = false;
                    $scope.clientAddress.mailModel.index = $scope.mailIndex = "";
                }

                if (!houseNumber) {
                    $scope.clientAddress.mailModel.HOME_TYPE = 0;
                    $scope.clientAddress.mailModel.HOME_TYPE_NM = "";
                    $scope.mailHouseDropDown.value(0);
                }

                $scope.disabledStreet = houseNumber === "" ? false : true;
                $scope.disabledSection = $scope.disabledRoom = houseNumber === "" ? true : false;
                $scope.disabledStreetType = houseNumber || $scope.clientAddress.mailModel.STR_ID ? true : false;
            }

            $scope.changeMailSection = function (mailSection) {
                $scope.clientAddress.mailModel.SECTION = mailSection;
                $scope.disabledHouse = mailSection || $scope.mailRoom ? true : false;

                if (!mailSection) {
                    $scope.clientAddress.mailModel.SECTION_TYPE = 0;
                    $scope.clientAddress.mailModel.SECTION_TYPE_NM = "";
                    $scope.mailSectionDropDown.value(0);
                }
            }

            $scope.changeMailRoom = function (mailRoom) {
                $scope.clientAddress.mailModel.ROOM = mailRoom;
                $scope.disabledHouse = mailRoom || $scope.mailSection ? true : false;
                $scope.disabledSection = mailRoom && $scope.mailSection ? true : false;

                if (!mailRoom) {
                    $scope.clientAddress.mailModel.ROOM_TYPE = 0;
                    $scope.clientAddress.mailModel.ROOM_TYPE_NM = "";
                    $scope.mailRoomDropDown.value(0);
                }
            }

            $scope.changeMailNote = function () {
                $scope.clientAddress.mailModel.NOTE = $scope.mailNote;
            }

            $scope.clearMailAddress = function () {

                $scope.mailIndex = "";
                $scope.mailRegion = "";
                $scope.mailArea = "";
                $scope.mailSettlement = "";
                $scope.mailStreet = "";
                $scope.mailHouse = "";
                $scope.mailSection = "";
                $scope.mailRoom = "";
                $scope.mailNote = "";
                $scope.mailSettlementDropDown.value(0);
                $scope.mailStreetDropDown.value(0);
                $scope.mailHouseDropDown.value(0);
                $scope.mailSectionDropDown.value(0);
                $scope.mailRoomDropDown.value(0);

                $scope.disabledIndex = $scope.disableRegion = $scope.disableArea = $scope.disableSettlement = $scope.disableSettlementType = false;
                $scope.disabledStreet = $scope.disabledHouse = $scope.disabledSection = $scope.disabledRoom = $scope.disabledStreetType = true;

                $scope.clientAddress.mailModel = {
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

                var mailModel = $scope.clientAddress.mailModel;

                mailModel.indexChecked = false;
                $scope.mailIndex = mailModel.indexDict = mailModel.index;
                $scope.mailRegion = mailModel.REGION_NAME;
                $scope.mailArea = mailModel.AREA_NAME;
                $scope.mailSettlement = mailModel.SETTLEMET_NAME;
                $scope.mailStreet = mailModel.STREET_NAME;
                $scope.mailHouse = mailModel.HOUSE_NUM_FULL;
                $scope.mailSection = mailModel.SECTION;
                $scope.mailRoom = mailModel.ROOM;
                $scope.mailNote = mailModel.NOTE;

                $scope.mailSettlementDropDown.value($scope.clientAddress.mailModel.SETL_TP_ID);
                $scope.mailStreetDropDown.value($scope.clientAddress.mailModel.STR_TP_ID);
                $scope.mailHouseDropDown.value($scope.clientAddress.mailModel.HOME_TYPE);
                $scope.mailSectionDropDown.value($scope.clientAddress.mailModel.SECTION_TYPE);
                $scope.mailRoomDropDown.value($scope.clientAddress.mailModel.ROOM_TYPE);

                $scope.disabledIndex = mailModel.HOUSE_ID === null || mailModel.index === null || mailModel.index === "" ? false : true;
                $scope.disableRegion = !mailModel.STREET_NAME || (mailModel.SETL_ID === null && mailModel.AREA_ID !== null) ? false : true;
                $scope.disableArea = mailModel.SETL_ID === null || !mailModel.STREET_NAME ? false : true;
                $scope.disableSettlement = $scope.disableSettlementType = !mailModel.STREET_NAME ? false : true;
                $scope.disabledStreet = $scope.disabledStreetType = mailModel.HOUSE_NUM_FULL || !mailModel.SETTLEMET_NAME || !mailModel.REGION_NAME ? true : false;
                $scope.disabledHouse = !mailModel.SETTLEMET_NAME || !mailModel.REGION_NAME || mailModel.SECTION || mailModel.ROOM ? true : false;
                $scope.disabledSection = !mailModel.HOUSE_NUM_FULL || !mailModel.SETTLEMET_NAME || !mailModel.REGION_NAME ? true : false;
                $scope.disabledRoom = !mailModel.HOUSE_NUM_FULL || !mailModel.SETTLEMET_NAME || !mailModel.REGION_NAME ? true : false;
				$scope.$apply();
            }

            $scope.selectedRegion = function (data) {
                $scope.clientAddress.mailModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.mailModel.REGION_NAME = data.REGION_NM;
            }

            $scope.regionLostFocus = function () {
                for (var i = 0; i < $scope.regionForChoose.length; i++) {
                    if ($scope.clientAddress.mailModel.REGION_NAME.toUpperCase() === $scope.regionForChoose[i].REGION_NM.toUpperCase()) {
                        $scope.selectedRegion($scope.regionForChoose[i]);
                    }
                };
            }

            $scope.selectedArea = function (data) {
                $scope.clientAddress.mailModel.AREA_NAME = data.AREA_NM;
                $scope.clientAddress.mailModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.mailModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.mailModel.REGION_NAME = $scope.mailRegion = data.REGION_NAME;
                $scope.disableRegion = true;
            }

            $scope.areaLostFocus = function () {
                for (var i = 0; i < $scope.areaForChoose.length; i++) {
                    if ($scope.clientAddress.mailModel.AREA_NAME.toUpperCase() === $scope.areaForChoose[i].AREA_NM.toUpperCase() && !$scope.clientAddress.mailModel.AREA_ID) {
                        $scope.selectedArea($scope.areaForChoose[i]);
                    }
                };
            }

            $scope.selectedSettlement = function (data) {
                $scope.clientAddress.mailModel.SETL_TP_ID = data.SETL_TP_ID;
                $scope.clientAddress.mailModel.SETL_TP_NM = data.SETL_TP_NM;
                $scope.clientAddress.mailModel.SETTLEMET_NAME = data.SETL_NM;
                $scope.clientAddress.mailModel.SETL_ID = data.SETL_ID;
                $scope.clientAddress.mailModel.REGION_ID = data.REGION_ID;
                $scope.clientAddress.mailModel.AREA_ID = data.AREA_ID;
                $scope.clientAddress.mailModel.REGION_NAME = $scope.mailRegion = data.REGION_NAME;
                $scope.clientAddress.mailModel.AREA_NAME = $scope.mailArea = data.AREA_NAME;
                $scope.mailSettlementDropDown.value(data.SETL_TP_ID);
                $scope.disabledStreet = $scope.disabledStreetType = false;
                $scope.disableRegion = $scope.disableArea = $scope.disableSettlementType = true;

                $scope.spanEnterRegionMail = { 'visibility': 'hidden' };
            }

            $scope.settlementLostFocus = function () {
                $scope.spanEnterRegionMail = { 'visibility': $scope.clientAddress.mailModel.REGION_NAME ? 'hidden' : 'visible' };
                for (var i = 0; i < $scope.settlementForChoose.length; i++) {
                    if ($scope.clientAddress.mailModel.SETTLEMET_NAME.toUpperCase() === $scope.settlementForChoose[i].SETL_NM.toUpperCase() && !$scope.clientAddress.mailModel.SETL_ID) {
                        $scope.selectedSettlement($scope.settlementForChoose[i]);
                    }
                };
            }

            $scope.selectedStreet = function (data) {
                $scope.clientAddress.mailModel.STR_ID = data.STR_ID;
                $scope.clientAddress.mailModel.STREET_NAME = data.STR_NM;
                $scope.clientAddress.mailModel.STR_TP_ID = data.STR_TP_ID;
                $scope.clientAddress.mailModel.STR_TP_NM = data.STR_TP_NM;
                $scope.mailStreetDropDown.value(data.STR_TP_ID);
                $scope.disabledStreetType = true;
            }


            $scope.streetLostFocus = function () {
                for (var i = 0; i < $scope.streetForChoose.length; i++) {
                    if ($scope.clientAddress.mailModel.STR_ID === $scope.streetForChoose[i].STR_ID) {
                        $scope.selectedStreet($scope.streetForChoose[i]);
                    }
                };
            }

            $scope.selectedHouse = function (data) {
                $scope.clientAddress.mailModel.HOUSE_NUM_FULL = data.HOUSE_NUM_FULL;
                $scope.clientAddress.mailModel.HOUSE_ID = data.HOUSE_ID;

                if (data.POSTAL_CODE) {
                    $scope.mailIndex = $scope.clientAddress.mailModel.indexDict = $scope.clientAddress.mailModel.index = data.POSTAL_CODE;
                    $scope.clientAddress.mailModel.indexChecked = $scope.disabledIndex = true;
                }
                else {
                    $scope.mailIndex = $scope.clientAddress.mailModel.index = "";
                    $scope.disabledIndex = false;
                }
            }

            $scope.houseLostFocus = function () {
                for (var i = 0; i < $scope.houseForChoose.length; i++) {
                    if ($scope.clientAddress.mailModel.HOUSE_NUM_FULL.toUpperCase() === $scope.houseForChoose[i].HOUSE_NUM_FULL.toUpperCase()) {
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