'use strict';
angular.module(globalSettings.modulesAreas)
    .controller('Clients.SearchCustomer',
        ['$scope', 'searchCustomerService','$sce',
        function ($scope, searchCustomerService, $sce) {
            var vm = this;
            vm.serviceState = searchCustomerService.state;
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
                        $(this).find('strong').html(parseInt((timeOut/1000 * progress)) + '<i>сек.</i>');
                    });
                }
            };

            var isEbkClients = false;

            vm.birthDateOptions = {
                format: '{0:dd/MM/yyyy}',
                mask: '00/00/0000',
                max: new Date()
            };

            vm.viewCustomer = function (id) {
                var url = '';
                if (isEbkClients) {
                    url = bars.config.urlContent('/clientregister/registration.aspx?client=person&spd=0&rezid=1&rnk=' + id);
                    url += '&' + $.param(searchCustomerService.convertSearchParams(vm.searchCustomerParams));
                } else if (id) {
                    url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);
                } else {
                    url = bars.config.urlContent('/clientregister/registration.aspx?client=person&spd=0&rezid=1');
                }
                bars.ui.dialog({
                    iframe: true,
                    content: {
                        url: url
                    },
                    width: 999,
                    height: 610
                });
            };
            

            vm.searchCustomerParams = {
                customerCode: '',
                firstName: '',
                lastName: '',
                documentSerial: '',
                documentNumber: '',
                birthDate: '',
                gcif: ''
            };
                      

            vm.customersList = [];
            vm.csbCustomersList = [];

            vm.searchCustomerInCsb = function () {
                vm.customersList = [];
                vm.csbCustomersList = [];
                vm.serviceState.customerNotFind = false;
                showProgress('Пошук в ЄБК');

                searchCustomerService.searchCustomerInCsb(vm.searchCustomerParams, $scope.ebkRequestTimeout).then(
                    function (response) {
                        vm.serviceState.searchText = '';
                        vm.csbCustomersList = response;
                        
                        if (vm.csbCustomersList.length === 0) {
                            vm.serviceState.customerNotFind = true;
                        } else {
                            vm.customersGrid.dataSource.data(vm.csbCustomersList);
                        }
                        isEbkClients = !vm.serviceState.customerNotFind;
                    },
                    function (error) {
                        vm.serviceState.searchText = '';
                        vm.serviceState.customerNotFind = true;
                    });
            };

            vm.searchCustomer = function () {
                vm.customersList = [];
                vm.csbCustomersList = [];
                vm.serviceState.customerNotFind = false;

                var isValid = validate();
                if (isValid) {

                    showProgress('Пошук в базі');

                    searchCustomerService.searchCustomer(vm.searchCustomerParams).then(
                        function (response) {
                            vm.serviceState.searchText = '';
                            vm.customersList = response;

                            if (vm.customersList.length === 0) {
                                vm.searchCustomerInCsb();
                            } else {
                                vm.customersGrid.dataSource.data(vm.customersList);
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
                            var id =  dataItem.Id;
                            return '<a href="#" ng-click="searchCustCtrl.viewCustomer(' + id + ')">' + id + '</a>';
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
                custCodeReq: function () {
                    if (this._allIsEmpty()) {
                        return true;
                    } else {
                        return false;
                    }
                },
                docReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty()
                            && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === ''))) {
                        return true;
                    } else {
                        return false;
                    }
                },
                custReq: function () {
                    if (this._allIsEmpty()
                        || (this._allUniqueIsEmpty() 
                            && (((vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial !== '')
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
                        || (this._allUniqueIsEmpty() 
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

                _allIsEmpty: function () {
                    if (this._allUniqueIsEmpty()
                        && (!vm.searchCustomerParams.firstName || vm.searchCustomerParams.firstName === '')
                        && (!vm.searchCustomerParams.lastName || vm.searchCustomerParams.lastName === '')
                        && (!vm.searchCustomerParams.documentSerial || vm.searchCustomerParams.documentSerial === '')
                        && (!vm.searchCustomerParams.documentNumber || vm.searchCustomerParams.documentNumber === '')
                        && (!vm.searchCustomerParams.birthDate || vm.searchCustomerParams.birthDate === '')) {
                        return true;
                    } else {
                        return false;
                    }
                },
                _allUniqueIsEmpty: function () {
                    if ((!vm.searchCustomerParams.customerCode || vm.searchCustomerParams.customerCode === '')
                        && (!vm.searchCustomerParams.gcif || vm.searchCustomerParams.gcif === '')) {
                        return true;
                    } else {
                        return false;
                    }
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
                    vm.validation.messageHtml = function() {
                        return $sce.trustAsHtml($scope.snippet);
                    }
                    vm.validation.message = $sce.trustAsHtml('Перевірте правильність заповнення даних.<br>' + 
                                            'Для пошуку заповніть наступні групи полів:<br>'+
                                            'або <b>Ідентифікаційний код</b>;<br>' +
                                            'або <b>Ім’я, Прізвище та Серія, Номер документа</b>;<br>' +
                                            'або <b>Ім’я, Прізвище, та Дата народження</b>;<br>' +
                                            'або <b>GCIF</b>.<br>');
                    return false;
                }
            };
        }
    ]);