angular.module(globalSettings.modulesAreas)
    .controller('ClientAddressCtrl',
    ['$scope',
        function ($scope) {

            var vm = this;

            vm.inputState = {};

            var isNull = function (value) {
                return value === "" || value == null;
            }

            var createAddressStr = function (model) {

                var addressStr = "";
                var addressArr = [];

                addressArr["STR_TP_NM"] = model.STR_TP_NM;
                addressArr["STREET_NAME"] = model.STREET_NAME;
                addressArr["HOME_TYPE_NM"] = model.HOME_TYPE_NM;
                addressArr["HOUSE_NUM_FULL"] = model.HOUSE_NUM_FULL;
                addressArr["SECTION_TYPE_NM"] = model.SECTION_TYPE_NM;
                addressArr["SECTION"] = model.SECTION;
                addressArr["ROOM_TYPE_NM"] = model.ROOM_TYPE_NM;
                addressArr["ROOM"] = model.ROOM;

                for (var key in addressArr) {
                    if (addressArr.hasOwnProperty(key)) {

                        var value = addressArr[key];

                        if (!isNull(value)) {

                            if (key === "STR_TP_NM" || key === "HOME_TYPE_NM" || key === "SECTION_TYPE_NM" || key === "ROOM_TYPE_NM") {
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

            var clientLegalAdress = window.parent.customerAddress.type1;
            var clientActualAdress = window.parent.customerAddress.type2;
            var clientMailAdress = window.parent.customerAddress.type3;

            vm.KEY_BACKSPACE = 8;

            vm.legalModel = {
                index: clientLegalAdress.zip,
                REGION_ID: clientLegalAdress.region_id,
                REGION_NAME: clientLegalAdress.region_id ? clientLegalAdress.region_name : clientLegalAdress.domain,
                AREA_ID: clientLegalAdress.area_id,
                AREA_NAME: clientLegalAdress.area_id ? clientLegalAdress.area_name : clientLegalAdress.region,
                SETL_TP_ID: clientLegalAdress.settlement_tp_id,
                SETL_TP_NM: clientLegalAdress.settlement_tp_nm,
                SETL_ID: clientLegalAdress.settlement_id,
                SETTLEMET_NAME: clientLegalAdress.settlement_id ? clientLegalAdress.settlement_name : clientLegalAdress.locality,
                STR_TP_ID: clientLegalAdress.str_tp_id,
                STR_TP_NM: clientLegalAdress.str_tp_nm,
                STR_ID: clientLegalAdress.street_id,
                STREET_NAME: clientLegalAdress.street_id ? clientLegalAdress.street_name : clientLegalAdress.street,
                HOME_TYPE: clientLegalAdress.aht_tp_id,
                HOME_TYPE_NM: clientLegalAdress.aht_tp_value,
                HOUSE_ID: clientLegalAdress.house_id,
                HOUSE_NUM_FULL: clientLegalAdress.house_id ? clientLegalAdress.house_num : clientLegalAdress.home,
                SECTION_TYPE: clientLegalAdress.ahpt_tp_id,
                SECTION_TYPE_NM: clientLegalAdress.ahpt_tp_value,
                SECTION: clientLegalAdress.homepart,
                ROOM_TYPE: clientLegalAdress.art_tp_id,
                ROOM_TYPE_NM: clientLegalAdress.art_tp_value,
                ROOM: clientLegalAdress.room,
                NOTE: clientLegalAdress.Comment
            };

            vm.actualModel = {
                index: clientActualAdress.zip,
                REGION_ID: clientActualAdress.region_id,
                REGION_NAME: clientActualAdress.region_id ? clientActualAdress.region_name : clientActualAdress.domain,
                AREA_ID: clientActualAdress.area_id,
                AREA_NAME: clientActualAdress.area_id ? clientActualAdress.area_name : clientActualAdress.region,
                SETL_TP_ID: clientActualAdress.settlement_tp_id,
                SETL_TP_NM: clientActualAdress.settlement_tp_nm,
                SETL_ID: clientActualAdress.settlement_id,
                SETTLEMET_NAME: clientActualAdress.settlement_id ? clientActualAdress.settlement_name : clientActualAdress.locality,
                STR_TP_ID: clientActualAdress.str_tp_id,
                STR_TP_NM: clientActualAdress.str_tp_nm,
                STR_ID: clientActualAdress.street_id,
                STREET_NAME: clientActualAdress.street_id ? clientActualAdress.street_name : clientActualAdress.street,
                HOME_TYPE: clientActualAdress.aht_tp_id,
                HOME_TYPE_NM: clientActualAdress.aht_tp_value,
                HOUSE_ID: clientActualAdress.house_id,
                HOUSE_NUM_FULL: clientActualAdress.house_id ? clientActualAdress.house_num : clientActualAdress.home,
                SECTION_TYPE: clientActualAdress.ahpt_tp_id,
                SECTION_TYPE_NM: clientActualAdress.ahpt_tp_value,
                SECTION: clientActualAdress.homepart,
                ROOM_TYPE: clientActualAdress.art_tp_id,
                ROOM_TYPE_NM: clientActualAdress.art_tp_value,
                ROOM: clientActualAdress.room,
                NOTE: clientActualAdress.Comment
            };

            vm.mailModel = {
                index: clientMailAdress.zip,
                REGION_ID: clientMailAdress.region_id,
                REGION_NAME: clientMailAdress.region_id ? clientMailAdress.region_name : clientMailAdress.domain,
                AREA_ID: clientMailAdress.area_id,
                AREA_NAME: clientMailAdress.area_id ? clientMailAdress.area_name : clientMailAdress.region,
                SETL_TP_ID: clientMailAdress.settlement_tp_id,
                SETL_TP_NM: clientMailAdress.settlement_tp_nm,
                SETL_ID: clientMailAdress.settlement_id,
                SETTLEMET_NAME: clientMailAdress.settlement_id ? clientMailAdress.settlement_name : clientMailAdress.locality,
                STR_TP_ID: clientMailAdress.str_tp_id,
                STR_TP_NM: clientMailAdress.str_tp_nm,
                STR_ID: clientMailAdress.street_id,
                STREET_NAME: clientMailAdress.street_id ? clientMailAdress.street_name : clientMailAdress.street,
                HOME_TYPE: clientMailAdress.aht_tp_id,
                HOME_TYPE_NM: clientMailAdress.aht_tp_value,
                HOUSE_ID: clientMailAdress.house_id,
                HOUSE_NUM_FULL: clientMailAdress.house_id ? clientMailAdress.house_num : clientMailAdress.home,
                SECTION_TYPE: clientMailAdress.ahpt_tp_id,
                SECTION_TYPE_NM: clientMailAdress.ahpt_tp_value,
                SECTION: clientMailAdress.homepart,
                ROOM_TYPE: clientMailAdress.art_tp_id,
                ROOM_TYPE_NM: clientMailAdress.art_tp_value,
                ROOM: clientMailAdress.room,
                NOTE: clientMailAdress.Comment
            };

            vm.callToGetInputState = function () {
                $scope.$broadcast('callToGetInputState');
            }

            vm.writeActualAddress = function () {
                angular.copy(vm.legalModel, vm.actualModel);
                vm.callToGetInputState();
                $scope.$broadcast('writeActualAddress', { actualModel: vm.actualModel, inputState: vm.inputState });
            }

            $scope.$on('getInputState', function (event, args) {
                angular.copy(args.inputState, vm.inputState);
            });

            vm.writeMailAddress = function () {
                angular.copy(vm.legalModel, vm.mailModel);
                vm.callToGetInputState();
                $scope.$broadcast('writeMailAddress', { mailModel: vm.mailModel, inputState: vm.inputState });
            }

            vm.close = function () {
                window.parent.$('#winClientAddress').data('kendoWindow').close();
            }
            vm.save = function () {

                if (vm.indexNotApprove(vm.legalModel , 'Юридичної')) return;
                if (vm.indexNotApprove(vm.actualModel, 'Фактичної')) return;
                if (vm.indexNotApprove(vm.mailModel, 'Поштової')) return;

                if (vm.legalModel.SETTLEMET_NAME == "" || vm.legalModel.SETTLEMET_NAME == null) {
                    bars.ui.alert({ text: "Населений пункт має бути заповненим" });
                }
                else if (vm.legalModel.STREET_NAME == "" || vm.legalModel.STREET_NAME == null) {
                    bars.ui.alert({ text: "Вул, Просп., б-р має бути заповненим" });
                }
                else if (vm.legalModel.HOUSE_NUM_FULL == "" || vm.legalModel.HOUSE_NUM_FULL == null) {
                    bars.ui.alert({ text: "№ буд., д/в, має бути заповненим" });
                }
                else {

                    window.parent.customerAddress.type1.filled = true;
                    window.parent.customerAddress.type2.filled = true;
                    window.parent.customerAddress.type3.filled = true;
                    vm.updateCustomerAddressLegal();
                    vm.updateCustomerAddressActual();
                    vm.updateCustomerAddressMail();

                    window.parent.$('#winClientAddress').data('kendoWindow').close();
                }

            }

            vm.updateCustomerAddressLegal = function () {
                clientLegalAdress.zip = vm.legalModel.index;
                clientLegalAdress.region_id = vm.legalModel.REGION_ID;
                clientLegalAdress.domain = vm.legalModel.REGION_NAME;
                clientLegalAdress.region_name = vm.legalModel.REGION_NAME;
                clientLegalAdress.area_id = vm.legalModel.AREA_ID;
                clientLegalAdress.region = vm.legalModel.AREA_NAME;
                clientLegalAdress.area_name = vm.legalModel.AREA_NAME;
                clientLegalAdress.settlement_tp_id = vm.legalModel.SETL_TP_ID === 0 ? null : vm.legalModel.SETL_TP_ID;
                clientLegalAdress.settlement_id = vm.legalModel.SETL_ID;
                clientLegalAdress.locality = vm.legalModel.SETTLEMET_NAME;
                clientLegalAdress.settlement_name = vm.legalModel.SETTLEMET_NAME;
                clientLegalAdress.str_tp_id = vm.legalModel.STR_TP_ID === 0 ? null : vm.legalModel.STR_TP_ID;
                clientLegalAdress.street_id = vm.legalModel.STR_ID;
                clientLegalAdress.street = vm.legalModel.STREET_NAME;
                clientLegalAdress.street_name = vm.legalModel.STREET_NAME;
                clientLegalAdress.aht_tp_id = vm.legalModel.HOME_TYPE === 0 ? null : vm.legalModel.HOME_TYPE;
                clientLegalAdress.house_id = vm.legalModel.HOUSE_ID;
                clientLegalAdress.home = vm.legalModel.HOUSE_NUM_FULL;
                clientLegalAdress.house_num = vm.legalModel.HOUSE_NUM_FULL;
                clientLegalAdress.ahpt_tp_id = vm.legalModel.SECTION_TYPE === 0 ? null : vm.legalModel.SECTION_TYPE;
                clientLegalAdress.homepart = vm.legalModel.SECTION != null ? vm.legalModel.SECTION : "";
                clientLegalAdress.art_tp_id = vm.legalModel.ROOM_TYPE === 0 ? null : vm.legalModel.ROOM_TYPE;
                clientLegalAdress.room = vm.legalModel.ROOM != null ? vm.legalModel.ROOM : "";
                clientLegalAdress.Comment = vm.legalModel.NOTE;
                clientLegalAdress.address = createAddressStr(vm.legalModel);
            }


            vm.updateCustomerAddressActual = function () {
                clientActualAdress.zip = vm.actualModel.index;
                clientActualAdress.region_id = vm.actualModel.REGION_ID;
                clientActualAdress.domain = vm.actualModel.REGION_NAME;
                clientActualAdress.region_name = vm.actualModel.REGION_NAME;
                clientActualAdress.area_id = vm.actualModel.AREA_ID;
                clientActualAdress.region = vm.actualModel.AREA_NAME;
                clientActualAdress.area_name = vm.actualModel.AREA_NAME;
                clientActualAdress.settlement_tp_id = vm.actualModel.SETL_TP_ID === 0 ? null : vm.actualModel.SETL_TP_ID;
                clientActualAdress.settlement_id = vm.actualModel.SETL_ID;
                clientActualAdress.locality = vm.actualModel.SETTLEMET_NAME;
                clientActualAdress.settlement_name = vm.actualModel.SETTLEMET_NAME;
                clientActualAdress.str_tp_id = vm.actualModel.STR_TP_ID === 0 ? null : vm.actualModel.STR_TP_ID;
                clientActualAdress.street_id = vm.actualModel.STR_ID;
                clientActualAdress.street = vm.actualModel.STREET_NAME;
                clientActualAdress.street_name = vm.actualModel.STREET_NAME;
                clientActualAdress.aht_tp_id = vm.actualModel.HOME_TYPE === 0 ? null : vm.actualModel.HOME_TYPE;
                clientActualAdress.house_id = vm.actualModel.HOUSE_ID;
                clientActualAdress.home = vm.actualModel.HOUSE_NUM_FULL;
                clientActualAdress.house_num = vm.actualModel.HOUSE_NUM_FULL;
                clientActualAdress.ahpt_tp_id = vm.actualModel.SECTION_TYPE === 0 ? null : vm.actualModel.SECTION_TYPE;
                clientActualAdress.homepart = vm.actualModel.SECTION != null ? vm.actualModel.SECTION : "";
                clientActualAdress.art_tp_id = vm.actualModel.ROOM_TYPE === 0 ? null : vm.actualModel.ROOM_TYPE;
                clientActualAdress.room = vm.actualModel.ROOM != null ? vm.actualModel.ROOM : "";
                clientActualAdress.Comment = vm.actualModel.NOTE;
                clientActualAdress.address = createAddressStr(vm.actualModel);
            }

            vm.updateCustomerAddressMail = function () {
                clientMailAdress.zip = vm.mailModel.index;
                clientMailAdress.region_id = vm.mailModel.REGION_ID;
                clientMailAdress.domain = vm.mailModel.REGION_NAME;
                clientMailAdress.region_name = vm.mailModel.REGION_NAME;
                clientMailAdress.area_id = vm.mailModel.AREA_ID;
                clientMailAdress.region = vm.mailModel.AREA_NAME;
                clientMailAdress.area_name = vm.mailModel.AREA_NAME;
                clientMailAdress.settlement_tp_id = vm.mailModel.SETL_TP_ID === 0 ? null : vm.mailModel.SETL_TP_ID;
                clientMailAdress.settlement_id = vm.mailModel.SETL_ID;
                clientMailAdress.locality = vm.mailModel.SETTLEMET_NAME;
                clientMailAdress.settlement_name = vm.mailModel.SETTLEMET_NAME;
                clientMailAdress.str_tp_id = vm.mailModel.STR_TP_ID === 0 ? null : vm.mailModel.STR_TP_ID;
                clientMailAdress.street_id = vm.mailModel.STR_ID;
                clientMailAdress.street = vm.mailModel.STREET_NAME;
                clientMailAdress.street_name = vm.mailModel.STREET_NAME;
                clientMailAdress.aht_tp_id = vm.mailModel.HOME_TYPE === 0 ? null : vm.mailModel.HOME_TYPE;
                clientMailAdress.house_id = vm.mailModel.HOUSE_ID;
                clientMailAdress.home = vm.mailModel.HOUSE_NUM_FULL;
                clientMailAdress.house_num = vm.mailModel.HOUSE_NUM_FULL;
                clientMailAdress.ahpt_tp_id = vm.mailModel.SECTION_TYPE === 0 ? null : vm.mailModel.SECTION_TYPE;
                clientMailAdress.homepart = vm.mailModel.SECTION != null ? vm.mailModel.SECTION : "";
                clientMailAdress.art_tp_id = vm.mailModel.ROOM_TYPE === 0 ? null : vm.mailModel.ROOM_TYPE;
                clientMailAdress.room = vm.mailModel.ROOM != null ? vm.mailModel.ROOM : "";
                clientMailAdress.Comment = vm.mailModel.NOTE;
                clientMailAdress.address = createAddressStr(vm.mailModel);
            }


            vm.createDropDownOptions = {
                open: function () {
                    angular.element('.k-list-container .k-list .k-item').css({ "font-size": "14px" });
                    angular.element('.k-list-container').css({ "width": "100px" });
                },
                close: function () {
                    angular.element('.k-list-container .k-list .k-item ').css({ "font-size": "" });
                    angular.element('.k-list-container').css({ "width": "" });
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

            vm.settlementTemplate = '<div style="float: left;">' +
                '<div style="float: left; width: 175px; word-wrap:break-word;">' +
                '<span>#=SETL_NM #</span>' +
                '</div>' +
                '<div style="float: left; width: 175px; word-wrap:break-word; margin-left: 2px;">' +
                '<span>#=AREA_NAME? AREA_NAME : " " #</span>' +
                '</div>' +
                '<div style="float: left; width: 175px; word-wrap:break-word; margin-left: 2px;">' +
                '<span>#=REGION_NAME ? REGION_NAME  : " "#</span>' +
                '</div>' +
                '</div>';

            vm.streetTemplate = '<div style="float: left;">' +
                '<div style="float: left; width: 180px; word-wrap:break-word;">' +
                '<span>#=STR_NM #</span>' +
                '</div>' +
                '<div style="float: left; width: 180px; word-wrap:break-word; margin-left: 2px;">' +
                '<span>#=STR_TP_NM ? STR_TP_NM : " "#</span>' +
                '</div>' +
                '</div>';

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

            vm.testIndex = function (_model) {
                if (_model.STR_ID && _model.index.length > 4) {
                    $.ajax({
                        type: "GET",
                        url: bars.config.urlContent("/Clients/clientAddress/GetHouse"),
                        data: {
                            sort: ''
                            , group: ''
                            , filter: "HOUSE_NUM_FULL~startswith~'" + _model.HOUSE_NUM_FULL.toUpperCase() + "'"
                            , columnName: 'HOUSE_NUM_FULL'
                            , streetId: _model.STR_ID
                            , _: Math.random()
                        },
                        success: function (result) {
                            if (result && result.length) {
                                for (var i = 0; i < result.length; i++) {
                                    if (_model.HOUSE_NUM_FULL.toUpperCase() === result[i].HOUSE_NUM_FULL.toUpperCase()) {
                                        if (result[i].POSTAL_CODE) {
                                            _model.indexDict = result[i].POSTAL_CODE;
                                            _model.indexChecked = true;
                                        }
                                    }
                                };
                            }
                        }
                    });
                }
            }

            vm.approve = function (msg, _model) {
                //bars.ui.approve({ text: msg }
                //    , function () { _model.indexDict = _model.index; vm.save(); } // yes
                //    , function () { }); // no
                options = { id: 'clientAddressCloseDialog',
                    text: msg, title: 'Підтвердження!', winType: 'confirm', actions: ["Pin", "Close"], pinned: true, draggable: false,
                    buttons: [
                        { text: 'Ні', click: function () { this.close(); }, cssClass: 'k-primary' },
                        { text: '<span class="k-icon k-i-tick"></span> Так',
                         click: function () {
                                _model.indexDict = _model.index; vm.save();
                                this.close();
                         }
                        }
                    ]
                };
                return bars.ui.alert(options);
            }

            vm.indexNotApprove = function (_model, modelName) {
                var isNotEqual = (_model.indexDict != _model.index);
                if (isNotEqual) {
                    vm.approve("Зазначений індекс " + modelName + " адреси (" + _model.index + ")<br\> не "
                    + (_model.indexChecked ? "співпадає із довідником" :
                            "вдалося перевірити по довіднику,<br\> оскільки адреса вводилась без використання довідників.<br\> Попереднє значення індекса") + " (" + _model.indexDict + "). Зберегти зміни?", _model);
                }
                return isNotEqual
            }

            $scope.preventDefaultBackSpace = function (e, elem) {
                var tagNames = ["INPUT", "TEXTAREA"];

                if (e.keyCode === vm.KEY_BACKSPACE) {

                    var tagName = e.target.tagName;

                    if ((tagNames.indexOf(tagName) === -1) || ((tagNames.indexOf(tagName) !== -1) && elem[0].disabled))
                        e.preventDefault();
                }
            };

        }]);