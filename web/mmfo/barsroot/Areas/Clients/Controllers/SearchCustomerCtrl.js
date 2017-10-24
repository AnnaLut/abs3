'use strict';
angular.module(globalSettings.modulesAreas)
    .controller('Clients.SearchCustomer',
        ['$scope', 'searchCustomerService', '$sce', 'customersService',
        function ($scope, searchCustomerService, $sce, customersService) {
            var vm = this;
            vm.custParams = {};
            vm.serviceState = searchCustomerService.state;
            vm.serviceState.customerNotFind = false;
            vm.btnAddSeparatedSubdivisionDisabled = true;
            var showProgress = function (text) {
                vm.serviceState.searchText = text;
                var timeOut = $scope.ebkRequestTimeout;
                var canvas = $('<canvas>');
                if (canvas.get(0).getContext) {
                    $('.circle-progress').circleProgress({
                        value: 1,
                        fill: { gradient: ['#0681c4', '#07c6c1'] },
                        size: 150,
                        animation: {
                            duration: timeOut,
                            easing: 'swing'
                        }
                    }).on('circle-animation-progress', function (event, progress) {
                        $(this).find('strong').html(parseInt((timeOut / 1000 * progress)) + '<i>сек.</i>');
                    });
                }
            };

            var isEbkClients = false;
            vm.customerType = bars.extension.getParamFromUrl('custtype', document.location.href);
            if (vm.customerType === "person") {
                $(".lp").hide();
                $(".psAndLp").hide();
            }
            else if (vm.customerType === "personspd") {
                $(".ip").hide();
                $(".lp").hide();
            } else {
                $(".ip").hide();
            }

            vm.birthDateOptions = {
                format: '{0:dd/MM/yyyy}',
                mask: '00/00/0000',
                max: new Date()
            };

            vm.viewCustomer = function (id, dateClosed, customerName) {
                var url = '';
				var customerRnk = '&rnk=' + id;
                var urlPerson = '/clientregister/registration.aspx?client=person&spd=0&rezid=1';
                var urlPersonSpd = '/clientregister/registration.aspx?client=person&spd=1&rezid=1';
                var urlCorp = '/clientregister/registration.aspx?client=corp&spd=0&rezid=1';
                var readOnly = '&readonly=1';

                if (isEbkClients) {


                    if (vm.searchCustomerParams.customerType == 'corp') {
                        url = bars.config.urlContent(urlCorp + customerRnk);
						url += '&' + $.param(searchCustomerService.convertSearchParams(vm.searchCustomerParams));
                    }
                    else if (vm.searchCustomerParams.customerType == 'personspd') {
                        url = bars.config.urlContent(urlPersonSpd + customerRnk);
						url += '&' + $.param(searchCustomerService.convertSearchParams(vm.searchCustomerParams));
                    } else {
                        url = bars.config.urlContent(urlPerson + customerRnk);
						url += '&' + $.param(searchCustomerService.convertSearchParams(vm.searchCustomerParams));
                    }

					bars.ui.dialog({
						iframe: true,
						content: {
							url: url
						},
						width: 999,
						height: 610
					});
                    

                }
				else if(id){
					
					if (vm.searchCustomerParams.customerType == 'corp') {
                        url = bars.config.urlContent(urlCorp + customerRnk);
                    }
                    else if (vm.searchCustomerParams.customerType == 'personspd') {
                        url = bars.config.urlContent(urlPersonSpd + customerRnk);
                    }
                    else {
                        url = bars.config.urlContent(urlPerson + customerRnk);
                    }
					
					if (dateClosed) {


                        var options = {
                            id: 'confirmRestore',
                            text: 'Даний клієнт закритий.',
                            buttons: [
                            {
                                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Відмінити',
                                click: function () { this.close(); }
                            },
                            {
                                text: '<span class="k-icon k-i-tick"></span> Переглянути',
                                click: function () {
                                    bars.ui.dialog({
                                        iframe: true,
                                        content: {
                                            url: url + readOnly
                                        },
                                        width: 999,
                                        height: 610
                                    });
                                }
                            },
                            {
                                text: '<i class="pf-icon pf-16 pf-man_1-update"></i>  Перереєструвати',
                                click: function () {

                                  bars.ui.confirm({
                                        text: 'Ви впевнені що хочете перереєструвати клієнта <b>' + customerName + '</b>?',
                                        func: function () {
                                            customersService.restoreCustomer(id).then(
                                                function () {
                                                    bars.ui.alert({text: 'Клієнта № ' + id + ' успішно перевідкрито.'});
                                                    vm.searchCustomer();
                                                    this.close();
                                                    var dialog = $("#confirmRestore").data("kendoWindow");
                                                    dialog.close();

                                                },
                                                function () {  });
                                        }
                                  });

                                }
                            }]
                        };
                       bars.ui.alert(options);


                    } else {
                        bars.ui.dialog({
                            iframe: true,
                            content: {
                                url: url
                            },
                            width: 999,
                            height: 610
                        });
                    }
						
				}
				else {

                    if (vm.searchCustomerParams.customerType == 'corp') {
                        url = bars.config.urlContent(urlCorp);
                    }
                    else if (vm.searchCustomerParams.customerType == 'personspd') {
                        url = bars.config.urlContent(urlPersonSpd);
                    }
                    else {
                        url = bars.config.urlContent(urlPerson);
                    }
					
					bars.ui.dialog({
                            iframe: true,
                            content: {
                                url: url
                            },
                            width: 999,
                            height: 610
                        });

                }
            };

            vm.searchCustomerParams = {
                customerType: bars.extension.getParamFromUrl('custtype', document.location.href),
                customerRnk: '',
                customerCode: '',
                firstName: '',
                lastName: '',
                documentSerial: '',
                documentNumber: '',
                birthDate: '',
                gcif: '',
                eddrId: '',
                fullName: '',
                fullNameInternational: '',
                dateOn: ''
            };

            vm.customersList = [];
            vm.csbCustomersList = [];

            vm.searchCustomerInCsb = function () {
                vm.customersList = [];
                vm.csbCustomersList = [];
                showProgress('Пошук в ЄБК');
                searchCustomerService.searchCustomerInCsb(vm.searchCustomerParams, $scope.ebkRequestTimeout).then(
                    function (response) {
                        vm.serviceState.searchText = '';
                        vm.csbCustomersList = response;

                        if (vm.csbCustomersList.length === undefined) {

                            bars.ui.alert({ text: response.Message });
                            vm.serviceState.customerNotFind = true;

                        }
                        else if (vm.csbCustomersList.length === 0) {
                            vm.serviceState.customerNotFind = true;

                        }
                        else {
                            vm.btnAddSeparatedSubdivisionDisabled = vm.isCheckedSeparatedSubdivision ? false : true;
                            vm.customersGrid.dataSource.data(vm.csbCustomersList);
                            vm.serviceState.customerNotFind = false;
                            isEbkClients = true;
                            angular.copy(vm.searchCustomerParams, vm.custParams);                            
                        }
                    },
                    function (error) {
                        vm.serviceState.searchText = '';
                        vm.serviceState.customerNotFind = true;
                        vm.serviceState.lastUpdate = true;
                    });
            };

            vm.searchCustomer = function () {
                vm.btnAddSeparatedSubdivisionDisabled = true;
                vm.customersList = [];
                vm.csbCustomersList = [];
                var isValid = validate();
                if (isValid) {

                    showProgress('Пошук в базі');
                    // if by rnk - search only in remote service 
                    if (vm.searchCustomerParams.customerRnk && vm.searchCustomerParams.customerRnk.length > 0) {
                        vm.searchCustomerInCsb();
                        return;
                    }
                    searchCustomerService.searchCustomer(vm.searchCustomerParams).then(
                        function (response) {
                            vm.serviceState.searchText = '';
                            vm.customersList = response;

                            if (vm.customersList.length === 0) {
                                vm.searchCustomerInCsb();
                            } else {
                                vm.btnAddSeparatedSubdivisionDisabled = vm.isCheckedSeparatedSubdivision ? false : true;
                                vm.customersGrid.dataSource.data(vm.customersList);
                                vm.serviceState.customerNotFind = false;
                                angular.copy(vm.searchCustomerParams, vm.custParams);
                            }
                            isEbkClients = false;
                        },
                        function (error) {
                            vm.serviceState.searchText = '';

                        });
                }
            }

            vm.customersGridOptions = {
                height: 120,
                autoBind: true,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                pageable: {
                    refresh: false,
                    pageSizes: [5],
                    buttonCount: 1
                },
                dataBound: function (e) {
                    bars.ext.kendo.grid.noDataRow(e);
                },
                dataBinding: function () {
                    //enableToolbarButtons(false);
                },
                change: function () {
                    //enableToolbarButtons(true, selectedCustGridRow());
                },
                dataSource: {
                    pageSize: 5,
                    page: 1,
                    total: 0,
                    serverPaging: false,
                    serverSorting: false,
                    serverFiltering: false,
                    serverGrouping: false,
                    serverAggregates: false,
                    sort: {
                        field: "Id",
                        dir: "desc"
                    },
                    schema: {
                        model: {
                            id: 'Id',
                            fields: {
                                Id: {
                                    type: 'number'
                                },
                                ContractNumber: {
                                    type: 'string'
                                },
                                Code: {
                                    type: 'string'
                                },
                                TypeId: {
                                    type: 'number'
                                },
                                TypeName: {
                                    type: 'string'
                                },
                                Sed: {
                                    type: 'string'
                                },
                                Name: {
                                    type: 'string'
                                },
                                DateOpen: {
                                    type: 'date'
                                },
                                DateClosed: {
                                    type: 'date'
                                },
                                Branch: {
                                    type: 'string'
                                },
                                Gcif: {
                                    type: 'string'
                                }
                            }
                        }
                    }
                },
                columns: [
                    {
                        field: 'Id',
                        title: '№',
                        template: function (dataItem) {
                            var id = dataItem.Id;
                            var isDateClose = dataItem.DateClosed ? true : false;
                            var customerName = dataItem.Name;
                            var newCustomerNameStr = customerName.replace(/"|'/gi, ' ');
                            var customerNameStr = "'" + newCustomerNameStr + "'";
                            return '<a href="#" ng-click="searchCustCtrl.viewCustomer(' + id + ',' + isDateClose + ',' + customerNameStr + ')">' + id + '</a>';
                        },
                        filterable: bars.ext.kendo.grid.uiNumFilter,
                        width: '80px'
                    }, {
                        field: 'ContractNumber',
                        title: '№ договору',
                        width: '100px'
                    }, {
                        field: 'Code',
                        title: 'Іден. код',
                        width: '100px'
                    }, {
                        field: 'TypeName',
                        title: 'Тип клієнта',
                        width: '160px',
                        template: '<i class="pf-icon pf-16 pf-{{getClientTypeIcon(dataItem.TypeId)}}"></i> #=TypeName#'
                    }, {
                        field: 'Sed',
                        title: 'Підпр.',
                        template: '<input type="checkbox" #= Sed == \"91  \" ?  \"checked\":\"\" # onclick="return false;"/>',
                        filterable: false,
                        width: '60px'
                    }, {
                        field: 'Name',
                        title: 'Найменування',
                        width: '200px'
                    }, {
                        field: 'DateOpen',
                        title: 'Зареєстрований',
                        format: '{0:dd.MM.yyyy}',
                        width: '80px'
                    }, {
                        field: 'DateClosed',
                        title: 'Закритий',
                        format: '{0:dd.MM.yyyy}',
                        width: '80px'
                    }, {
                        field: 'Branch',
                        title: 'Код відділення',
                        width: '170px'
                    }
                ]
            };

            vm.validation = {
                message: '',
                custRnkReq: function () {
                    if (this._allIsEmpty()) {
                        return true;
                    } else {
                        return false;
                    }
                },
                custCodeReq: function () {
                    if (this._allIsEmpty()) {
                        return true;
                    } else {
                        return false;
                    }
                },
                docReq: function () {
                    if (this._allIsEmpty()
                        || (this._isIndividualPerson() && this._allUniqueIsEmpty()
                            && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === ''))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                docSerialReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty() && this._isIndividualPerson()
                            && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === '')
                            && (!vm.searchCustomerParams.eddrId || vm.searchCustomerParams.eddrId === ''))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                custReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty() && this._isIndividualPerson()
                            && ((((vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial !== '')
                                || (vm.searchCustomerParams.eddrId || vm.searchCustomerParams.eddrId !== ''))
                                && (vm.searchCustomerParams.documentNumber || vm.searchCustomerParams.documentNumber !== ''))
                                || (vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate !== '')
                        ))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                birthDateReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty() && this._isIndividualPerson()
                            && ((!vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial === '')
                                && (!vm.searchCustomerParams.documentNumber || vm.searchCustomerParams.documentNumber === '')))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                gcifReq: function () {
                    if (this._allIsEmpty()) {
                        return true;
                    } else {
                        return false;
                    }
                },
                docEddrIdReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty() && this._isIndividualPerson()
                            && (!vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial === '')
                            && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === ''))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                fullNameReq: function () {
                    if (this._allIsEmpty() || (vm.searchCustomerParams.dateOn && vm.searchCustomerParams.fullNameInternational == '')) {
                        return true;
                    } else {
                        return false;
                    }
                },
                fullNameInternationalReq: function () {
                    if (this._allIsEmpty() || (vm.searchCustomerParams.dateOn && vm.searchCustomerParams.fullName == '')) {
                        return true;
                    } else {
                        return false;
                    }
                },
                dateOnReq: function () {
                    if (this._allIsEmpty() || (vm.searchCustomerParams.fullName == ''
                        &&  vm.searchCustomerParams.fullNameInternational == '' && !vm.searchCustomerParams.customerCode
                        && !vm.searchCustomerParams.customerRnk && !vm.searchCustomerParams.gcif
                        && !vm.searchCustomerParams.firstName && !vm.searchCustomerParams.lastName
                        && !vm.searchCustomerParams.documentSerial && !vm.searchCustomerParams.documentNumber
                        && !vm.searchCustomerParams.birthDate && !vm.searchCustomerParams.eddrId))
                    {
                        return true;
                    }
                    else {
                        return false;
                    }
                },
                _allIsEmpty: function () {
                    if (this._allUniqueIsEmpty()
                        && (!vm.searchCustomerParams.firstName || vm.searchCustomerParams.firstName === '')
                        && (!vm.searchCustomerParams.lastName || vm.searchCustomerParams.lastName === '')
                        && (!vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial === '')
                        && (!vm.searchCustomerParams.documentNumber || vm.searchCustomerParams.documentNumber === '')
                        && (!vm.searchCustomerParams.eddrId || vm.searchCustomerParams.eddrId === '')
                        && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === '')
                        && (!vm.searchCustomerParams.fullName || vm.searchCustomerParams.fullName === '')
                        && (!vm.searchCustomerParams.fullNameInternational || vm.searchCustomerParams.fullNameInternational === '')
                        && (!vm.searchCustomerParams.dateOn || vm.searchCustomerParams.dateOn === '')) {
                        return true;
                    } else {
                        return false;
                    }
                },
                _allUniqueIsEmpty: function () {
                    if ((!vm.searchCustomerParams.customerCode || vm.searchCustomerParams.customerCode === '')
                        && (!vm.searchCustomerParams.gcif || vm.searchCustomerParams.gcif === '')
                        && (!vm.searchCustomerParams.customerRnk || vm.searchCustomerParams.customerRnk === '')) {
                        return true;
                    } else {
                        return false;
                    }
                },
                _isIndividualPerson: function () {
                    return vm.customerType === "person";
                }
            };
            var validate = function () {

                //хак для задізейбленого текстареа
                //орегінал - ":input:not(:button,[type=submit],[type=reset],[disabled],[readonly])[data-validate!=false]"
                vm.validator._inputSelector = ":input:not(:button,[type=submit],[type=reset],[readonly])[data-validate!=false]";

                if (vm.validator.validate()) {
                    vm.validation.message = "";
                    return true;
                } else {
                    vm.validation.messageHtml = function () {
                        return $sce.trustAsHtml($scope.snippet);
                    }
                    var validationMessage = 'Перевірте правильність заповнення даних.<br>' +
                        'Для пошуку заповніть наступні групи полів:<br>' +
                        '<b>Найменування клієнта (нац.)</b>;<br>' +
                        'або <b>Найменування клієнта (міжн.)</b>;<br>' +
                        'або <b>Реєстрційний номер (РНК) в ЄБК</b>;<br>' +
                        'або <b>Ідентифікаційний код</b>;<br>' +
                        'або <b>GCIF</b>.<br>';
                    if (vm.customerType == "person") {
                        validationMessage += 'або <b>Ім’я, Прізвище та Серія, Номер документа</b>;<br>' +
                            'або <b>Ім’я, Прізвище, та Дата народження</b>;<br>' +
                            'або <b>Ім’я, Прізвище та Номер документа, Унік. номер запису в ЄДДР</b>.<br>';
                    }
                    vm.validation.message = $sce.trustAsHtml(validationMessage);
                    return false;
                }
            };

            vm.changeSubdivisionCheckBox = function () {
                if (vm.customersList.length !== 0 || vm.csbCustomersList.length !== 0)
                vm.btnAddSeparatedSubdivisionDisabled = vm.isCheckedSeparatedSubdivision ? false : true;
            }

            vm.addSeparatedSubdivision = function () {               
                bars.ui.dialog({
                    iframe: true,
                    content: {
                        url: bars.config.urlContent('/clientregister/registration.aspx?client=corp&spd=0&rezid=1&addSeparatedSubdivision=1&' + $.param(searchCustomerService.convertSearchParams(vm.custParams)))
                    },
                    width: 999,
                    height: 610
                });
            }
        }
        ]);