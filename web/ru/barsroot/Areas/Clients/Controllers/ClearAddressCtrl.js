angular.module(globalSettings.modulesAreas)
    .controller('ClearAddressCtrl',
    ['clearAddressService', '$location', '$anchorScroll', '$scope',
        function (clearAddressService, $location, $anchorScroll, $scope) {
            var vm = this;

            vm.KEY_BACKSPACE = 8;
            vm.KEY_ENTER = 13;

            vm.legalModel = {
                addressIndex: null,
                regionId: null,
                regionName: "",
                areaId: null,
                areaName: "",
                settlementTypeId: null,
                settlementName: "",
                settlementId: null,
                streetTypeId: null,
                streetTypeNm: "",
                streetId: null,
                streetName: "",
                homeTypeId: null,
                homeTypeNm: "",
                houseId: null,
                home: null,
                homePartTypeId: null,
                homePartTypeNm: "",
                homePart: null,
                roomTypeId: null,
                roomTypeNm: "",
                room: null,
                comm: "",
                rnk: null,
                typeId: 1,
                countryId: null,
                address: null
            };


            vm.actualModel = {
                addressIndex: null,
                regionId: null,
                regionName: "",
                areaId: null,
                areaName: "",
                settlementTypeId: null,
                settlementName: "",
                settlementId: null,
                streetTypeId: null,
                streetTypeNm: "",
                streetId: null,
                streetName: "",
                homeTypeId: null,
                homeTypeNm: "",
                houseId: null,
                home: null,
                homePartTypeId: null,
                homePartTypeNm: "",
                homePart: null,
                roomTypeId: null,
                roomTypeNm: "",
                room: null,
                comm: "",
                rnk: null,
                typeId: 2,
                countryId: null,
                address: null
            };

            vm.mailModel = {
                addressIndex: null,
                regionId: null,
                regionName: "",
                areaId: null,
                areaName: "",
                settlementTypeId: null,
                settlementName: "",
                settlementId: null,
                streetTypeId: null,
                streetTypeNm: "",
                streetId: null,
                streetName: "",
                homeTypeId: null,
                homeTypeNm: "",
                houseId: null,
                home: null,
                homePartTypeId: null,
                homePartTypeNm: "",
                homePart: null,
                roomTypeId: null,
                roomTypeNm: "",
                room: null,
                comm: "",
                rnk: null,
                typeId: 3,
                countryId: null,
                address: null
            };


            vm.showAll = 1;

            vm.clrAdrDataSource = new kendo.data.DataSource({
                requestStart: function () {
                    angular.element('.k-loading-mask').css('display', 'block');
                },
                requestEnd: function () {
                    angular.element('.k-loading-mask').css('display', 'none');
                },
                change: function () {
                    vm.legalModel.rnk = vm.actualModel.rnk = vm.mailModel.rnk = null;
                    vm.adrShow("hideAll");
                },
                type: "aspnetmvc-ajax",
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true,
                pageSize: 5,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/clients/clearAddress/GetClearAddress"),
                        dataType: 'json',
                        data: function () {

                            if (vm.clrAdrGrid) {
                                var parameterMap = vm.clrAdrGrid.dataSource.transport.parameterMap;
                                return parameterMap({
                                    sort: vm.clrAdrGrid.dataSource.sort(),
                                    filter: vm.clrAdrGrid.dataSource.filter(),
                                    group: vm.clrAdrGrid.dataSource.group(),
                                    domain: bars.extension.getParamFromUrl("domain"),
                                    region: bars.extension.getParamFromUrl("region"),
                                    street: bars.extension.getParamFromUrl("street"),
                                    regionId: bars.extension.getParamFromUrl("regionId"),
                                    areaId: bars.extension.getParamFromUrl("areaId"),
                                    mode: bars.extension.getParamFromUrl("mode"),
                                    locality: bars.extension.getParamFromUrl("locality"),
                                    settlementId: bars.extension.getParamFromUrl("settlementId"),
                                    all: vm.showAll
                                });
                            } else {
                                return {
                                    domain: bars.extension.getParamFromUrl("domain"),
                                    region: bars.extension.getParamFromUrl("region"),
                                    street: bars.extension.getParamFromUrl("street"),
                                    regionId: bars.extension.getParamFromUrl("regionId"),
                                    areaId: bars.extension.getParamFromUrl("areaId"),
                                    mode: bars.extension.getParamFromUrl("mode"),
                                    locality: bars.extension.getParamFromUrl("locality"),
                                    settlementId: bars.extension.getParamFromUrl("settlementId"),
                                    all: vm.showAll
                                };
                            }
                        },
                        cache: false
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    model: {
                        fields: {
                            Rnk: { type: "number" },
                            FirstName: { type: "string" },
                            Address: { type: "string" },
                            HouseNum: { type: "string" },
                            StreetName: { type: "string" },
                            CountryName: { type: "string" },
                            SettlementName: { type: "string" },
                            Locality: { type: "string" },
                            Domain: { type: "string" },
                            RegionName: { type: "string" },
                            ParentName: { type: "string" },
                            SurName: { type: "string" },
                            Region: { type: "string" },
                            AreaName: { type: "string" },
                            TypeName: { type: "string" }
                        }
                    }
                }
            });

            vm.clrAdrGridOptions = {
                autoBind: true,
                dataSource: vm.clrAdrDataSource,
                sortable: true,
                selectable: true,
                filterable: true,
                resizable: true,
                scrollable: true,
                pageable: {
                    pageSizes: [5, 10, 20, 50, 100],
                    buttonCount: 3
                },
                columns: [
                    {
                        field: "Rnk",
                        title: "РНК",
                        width: "100px",
                        hidden: true
                    },
                    {
                        field: "FirstName",
                        title: "Ім'я",
                        width: "100px"
                    },
                    {
                        field: "SurName",
                        title: "Прізвище",
                        width: "100px"
                    },
                    {
                        field: "ParentName",
                        title: "По батьвові",
                        width: "100px"
                    },
                    {
                        field: "TypeName",
                        title: "Тип адреси",
                        width: "100px"
                    },
                    {
                        field: "Address",
                        title: "Адреса (поточне значення)",
                        width: "200px"
                    },
                    {
                        field: "CountryName",
                        title: "Країна",
                        width: "100px"
                    },
                    {
                        field: "Domain",
                        title: "Область (поточне значення)",
                        width: "100px"
                    },
                    {
                        field: "RegionName",
                        title: "Область (призначене значення)",
                        width: "100px"
                    },
                    {
                        field: "Region",
                        title: "Район (поточне значення)",
                        width: "100px"
                    },
                    {
                        field: "AreaName",
                        title: "Район (призначене значення)",
                        width: "100px"
                    },
                    {
                        field: "Locality",
                        title: "Населений пункт (поточне значення)",
                        width: "100px"
                    },
                    {
                        field: "SettlementName",
                        title: "Насалений пункт (призначене значення)",
                        width: "100px"
                    },
                    {
                        field: "StreetName",
                        title: "Вулиця (призначене значення)",
                        width: "100px"
                    },
                    {
                        field: "HouseNum",
                        title: "Будинок (призначене значення)",
                        width: "100px"
                    }
                ]
            };

            vm.adrShow = function (type) {
                if (vm.legalModel.rnk) {
                    switch (type) {

                        case "legal":
                            vm.legalAdrShow = !vm.legalAdrShow ? true : false;
                            break;
                        case "actual":
                            vm.actualAdrShow = !vm.actualAdrShow ? true : false;
                            break;
                        case "mail":
                            vm.mailAdrShow = !vm.mailAdrShow ? true : false;
                            break;
                        case "showAll":
                            vm.legalAdrShow = vm.actualAdrShow = vm.mailAdrShow = true;
                            break;
                    }
                }
                else {
                    if (type !== "hideAll")
                        bars.ui.alert({ text: " Потрібно вибрати клієнта " });
                    vm.legalAdrShow = vm.actualAdrShow = vm.mailAdrShow = false;
                }
            }

            vm.goToTop = function () {

                $location.hash('top');
                $anchorScroll();

            }

            vm.changeCheckBoxShowAll = function (chkBox) {
                vm.showAll = chkBox ? 1 : 0;
                vm.clrAdrGrid.dataSource.read();
            }

            vm.regionDataSource = {
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
                }
            };

            vm.regionOptions = {
                dataTextField: "REGION_NM",
                dataValueField: "REGION_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                dataSource: vm.regionDataSource
            }

            vm.areaDataSource = {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetAreas"),
                        dataType: 'json',
                        cache: false
                    }
                }
            };


            vm.areasOptions = {
                dataTextField: "AREA_NM",
                dataValueField: "AREA_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                dataSource: vm.areaDataSource,
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

            vm.settlementDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSettlement"),
                        cache: false
                    }
                }
            }

            vm.createDropDownOptions = function () {
                return {
                    open: function () {
                        angular.element('.k-list-container .k-list .k-item').css({ "font-size": "14px" });
                        angular.element('.k-list-container').css({ "width": "100px" });
                    },
                    close: function () {
                        angular.element('.k-list-container .k-list .k-item ').css({ "font-size": "" });
                        angular.element('.k-list-container').css({ "width": "" });
                    }
                };
            }


            vm.settlementDataSource = {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetSettlement"),
                        dataType: 'json',
                        cache: false
                    }
                }
            }

            vm.settlementOptions = {
                dataTextField: "SETL_NM",
                dataValueField: "SETL_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                minLength: 2,
                dataSource: vm.settlementDataSource,
                template: '<div style="float: left;">' +
                              '<div style="float: left; width: 175px; word-wrap:break-word;">' +
                                    '<span>#=SETL_NM #</span>' +
                              '</div>' +
                              '<div style="float: left; width: 175px; word-wrap:break-word; margin-left: 2px;">' +
                                    '<span>#=AREA_NAME? AREA_NAME : " " #</span>' +
                               '</div>' +
                                '<div style="float: left; width: 175px; word-wrap:break-word; margin-left: 2px;">' +
                                    '<span>#=REGION_NAME ? REGION_NAME  : " "#</span>' +
                               '</div>' +
                          '</div>',
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

            vm.streetDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownStreet"),
                        cache: false
                    }
                }
            }

            vm.streetDataSource = {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetStreet"),
                        dataType: 'json',
                        cache: false
                    }
                }
            }

            vm.streetOptions = {
                dataTextField: "STR_NM",
                dataValueField: "STR_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                minLength: 3,
                dataSource: vm.streetDataSource,
                template: '<div style="float: left;">' +
                              '<div style="float: left; width: 180px; word-wrap:break-word;">' +
                                    '<span>#=STR_NM #</span>' +
                              '</div>' +
                              '<div style="float: left; width: 180px; word-wrap:break-word; margin-left: 2px;">' +
                                    '<span>#=STR_TP_NM ? STR_TP_NM : " "#</span>' +
                               '</div>' +
                          '</div>',
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

            vm.houseDataSource = {
                type: 'aspnetmvc-ajax',
                serverFiltering: true,
                transport: {
                    read: {
                        type: "GET",
                        contentType: "application/json",
                        url: bars.config.urlContent("/Clients/clientAddress/GetHouse"),
                        dataType: 'json',
                        cache: false
                    }
                }
            }

            vm.houseOptions = {
                dataTextField: "HOUSE_NUM_FULL",
                dataValueField: "HOUSE_ID",
                filtering: function (e) {
                    if (!e.filter.value) {
                        e.preventDefault();
                        this.popup.close();
                    }
                },
                dataSource: vm.houseDataSource
            }

            vm.houseDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownHouse"),
                        cache: false
                    }
                }
            }


            vm.sectionDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownSection"),
                        cache: false
                    }
                }
            }

            vm.roomDropDownDataSource = {
                transport: {
                    read: {
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetDropDownRoom"),
                        cache: false
                    }
                }
            }

            var dataBoundAddEmptyToDD = function (id, value) {

                var elem = {};
                elem[id] = "0";
                elem[value] = " ";

                this.BoundFunction = function () {

                    var dataSource = this.dataSource;
                    var data = dataSource.data();

                    if (!this._adding) {
                        this._adding = true;

                        data.splice(0, 0, elem);

                        this._adding = false;

                    }
                }
            }

            vm.settlementDropDownBoundFunc = new dataBoundAddEmptyToDD("SETL_TP_ID", "SETL_TP_NM");
            vm.streetDropDownBoundFunc = new dataBoundAddEmptyToDD("STR_TP_ID", "STR_TP_NM");
            vm.houseDropDownBoundFunc = new dataBoundAddEmptyToDD("HOUSE_TP_ID", "HOUSE_TP_NM");
            vm.sectionDropDownBoundFunc = new dataBoundAddEmptyToDD("SECTION_TP_ID", "SECTION_TP_NM");
            vm.roomDropDownBoundFunc = new dataBoundAddEmptyToDD("ROOM_TP_ID", "ROOM_TP_NM");


            vm.selectedRow = function (data) {

                vm.legalModel.rnk = vm.actualModel.rnk = vm.mailModel.rnk = data.Rnk;
                vm.legalModel.countryId = vm.actualModel.countryId = vm.mailModel.countryId = data.CountryId;

                $scope.$broadcast('clearLegalAddress', {});
                $scope.$broadcast('clearActualAddress', {});
                $scope.$broadcast('clearMailAddress', {});

                clearAddressService.getClearAddress(data.Rnk).then(
                    function (data) {
                        for (var i = 0; i < data.length; i++) {
                            switch (data[i].TypeId) {
                                case 1:
                                    $scope.$broadcast('fillLegalAddress', {
                                        legalAddress: data[i]
                                    });
                                    break;
                                case 2:
                                    $scope.$broadcast('fillActualAddress', {
                                        actualAddress: data[i]
                                    });
                                    break;
                                case 3:
                                    $scope.$broadcast('fillMailAddress', {
                                        mailAddress: data[i]
                                    });
                                    break;
                            }
                        }
                        vm.adrShow('showAll');
                    },
                    function (error) {

                    });
            }


            $scope.preventDefaultBackSpace = function (e, elem) {

                var tagNames = ["INPUT", "TEXTAREA"];

                if (e.keyCode === vm.KEY_BACKSPACE) {

                    var tagName = e.target.tagName;

                    if ((tagNames.indexOf(tagName) === -1) || ((tagNames.indexOf(tagName) !== -1) && elem[0].disabled))
                        e.preventDefault();
                }
            };

            vm.save = function () {

                vm.legalModel.address = createAddressStr(vm.legalModel);
                vm.actualModel.address = createAddressStr(vm.actualModel);
                vm.mailModel.address = createAddressStr(vm.mailModel);

                var clearAddress = [];

                clearAddress.push(vm.legalModel);
                clearAddress.push(vm.actualModel);
                clearAddress.push(vm.mailModel);

                clearAddressService.saveClearAddress(clearAddress).then(
                    function (data) {
                        if (data.Status === "Ok") {
                            bars.ui.alert({ text: "Зміни збережено" });
                            vm.clrAdrGrid.dataSource.read();
                        }
                        else {
                            bars.ui.error({ text: "Не вдалось зберегти зміни: <br/>" + data.Message });
                        }
                    });
            }

            var isNull = function (value) {
                return value === "" || value == null;
            }


            var createAddressStr = function (model) {

                var addressStr = "";
                var addressArr = [];

                addressArr["streetTypeNm"] = model.streetTypeNm;
                addressArr["streetName"] = model.streetName;
                addressArr["homeTypeNm"] = model.homeTypeNm;
                addressArr["home"] = model.home;
                addressArr["homePartTypeNm"] = model.homePartTypeNm;
                addressArr["homePart"] = model.homePart;
                addressArr["roomTypeNm"] = model.roomTypeNm;
                addressArr["room"] = model.room;

                for (var key in addressArr) {
                    if (addressArr.hasOwnProperty(key)) {

                        var value = addressArr[key];

                        if (!isNull(value)) {

                            if (key === "streetTypeNm" || key === "homeTypeNm" || key === "homePartTypeNm" || key === "roomTypeNm") {
                                value = value.split('.').join("");
                                addressStr += value + ". ";
                            } else {
                                addressStr += value + ", ";
                            }
                        }
                    }


                }
                return addressStr.slice(-2) === ", " || addressStr.slice(-2) === ". " ? addressStr.slice(0, -2) : addressStr;
            }

            vm.clearAddress = function (addressType) {

                switch (addressType) {
                    case 'legal':
                        $scope.$broadcast('clearLegalAddress', {});
                        break;
                    case 'actual':
                        $scope.$broadcast('clearActualAddress', {});
                        break;
                    case 'mail':
                        $scope.$broadcast('clearMailAddress', {});
                        break;
                }
            }
        }]);
