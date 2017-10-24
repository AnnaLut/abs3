angular.module(globalSettings.modulesAreas)
    .controller('Clients.Customers',
            ['$scope', 'customersService',
        function ($scope, customersService) {
            'use strict';

            var vm = this;

            if (bars.test.hasIE && (bars.test.hasIE === '8' || bars.test.hasIE === '7')) {
                vm.isIE8 = true;
            }

            $scope.getClientTypeIcon = function (clientTypeId) {
                var result = '';
                switch (clientTypeId) {
                    case 1:
                        result = 'bank';
                        break;
                    case 2:
                        result = 'user_group';
                        break;
                    case 3:
                        result = 'user';
                        break;
                }
                return result;
            };

            vm.customerCreateModel = {
                type: 'PERSON',
                isResident: true
            };

            vm.selectCustomrTypeWinOptions = {
                content: {
                    url: bars.config.urlContent('/clients/customers/SelectCustomerType/')
                },
                modal: true,
                title: '',
                width: 250,
                height: 315
            };

            vm.searchCustomerWinOptions = {
                modal: true,
                title: '',
                width: 760,
                height: 600,
                open: function () {
                    //debugger
                    vm.searchCustomerWin.options.content = {
                        url: bars.config.urlContent('/clients/customers/search/?partial=true&custtype=' + vm.customersFilter.type)
                    };
                    vm.searchCustomerWin.refresh();
                },
                refresh: function () {
                    //bars.ui.loader(vm.searchCustomerWin, true);
                }
            }

            var isNotEmpty = function (val) { return !(val == null || val == ' ' || val == 'null' || val == '' || val == '&nbsp' || val == '&nbsp;' || val == '01/01/0001'); }

            var selectedCustGridRow = function () {
                return vm.customersGrid.dataItem(vm.customersGrid.select());
            };

            var enableToolbarButtons = function (type, data) {
                vm.customersGridToolbar.enable('#openCustAccsBtn', type);
                vm.customersGridToolbar.enable('#openCustHistoryBtn', type);
                vm.customersGridToolbar.enable('#printCustDocumBtn', type);
                if (type === true) {
                    if (data && data.DateClosed) {
                        vm.customersGridToolbar.enable('#reRegisterCustBtn', type);
                    } else {
                        vm.customersGridToolbar.enable('#closeCustBtn', type);
                    }
                } else {
                    vm.customersGridToolbar.enable('#reRegisterCustBtn', type);
                    vm.customersGridToolbar.enable('#closeCustBtn', type);
                }
            }

            var viewCustomerWinOptions = {
                width: 1111,
                height: 610
            }

            var editCustomerService = {
                viewCustomer: function (id) {
                    var url;
                    if (id) {
                        url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);
                        bars.ui.dialog({
                            close: function () {
                                vm.reloadCustomersGrid();
                            },
                            iframe: true,
                            content: {
                                url: url
                            },
                            width: viewCustomerWinOptions.width,
                            height: viewCustomerWinOptions.height
                        });
                    } else {
                        this.registerCustomer(vm.customerCreateModel.type, vm.customerCreateModel.isResident);
                    }
                },

                registerCustomer: function (type, isResident) {

                    if (isResident) {
                        vm.searchCustomerWin.center().open();
                    } else {

                        var url = bars.config.urlContent('/clientregister/registration.aspx?client=' + type.toLowerCase() + '&spd=' + (type === 'PERSONSPD' ? '1': '0') + '&rezid=' + (isResident ? '1' : '2'));
                        bars.ui.dialog({
                            iframe: true,
                            content: {
                                url: url
                            },
                            width: viewCustomerWinOptions.width,
                            height: viewCustomerWinOptions.height
                        });
                    }
                },
                restoreCustomer: function () {
                    var row = selectedCustGridRow();
                    if (!row) {
                        bars.ui.error({ text: 'Спочатку виберіть клієнта, якого ви бажаєте перереєструвати.' });
                    } else {
                        if (row.DateClosed == null) {
                            bars.ui.error({
                                text: 'Неможливо перереєструвати клієнта який не є закритим.<br>' +
                                    'Перевірте чи правильно ви вибрали клієнта.'
                            });
                        } else {
                            bars.ui.confirm({
                                text: 'Ви впевнені що хочете перереєструвати клієнта <b>' + row.Name + '</b>?',
                                func: function () {
                                    customersService.restoreCustomer(row.Id).then(
                                        function () {
                                            bars.ui.notify('Статус', 'Клієнта № ' + row.Id + ' успішно перевідкрито.', 'success');
                                            vm.customersGrid.dataSource.read();
                                        },
                                        function () {
                                            //vm.serviceState.searchText = '';
                                            //bars.ui.notify('Помилка виклику сервісу.',error.Message || error, 'error')
                                        });
                                }
                            });
                        }
                    }
                },
                closeCustomer: function () {
                    var row = selectedCustGridRow();
                    if (!row) {
                        bars.ui.error({ text: 'Спочатку виберіть клієнта, якого ви бажаєте закрити.' });
                    } else {
                        if (row.DateClosed != null) {
                            bars.ui.error({
                                text: 'Неможливо закрити клієнта який вже і так закритий.<br>' +
                                    'Перевірте чи правильно ви вибрали клієнта.'
                            });
                        } else {
                            bars.ui.confirm({
                                text: 'Ви впевнені що хочете поставити відмітку про закриття клієнта <b>' + row.Name +'</b>?',
                                func: function() {
                                    customersService.closeCustomer(row.Id).then(
                                        function () {

                                            var custType = bars.extension.getParamFromUrl('custtype', document.location.href);
                                            var options = { autoHideAfter: 2000}
                                            bars.ui.notify('Статус', 'Клієнта № ' + row.Id + ' успішно закрито. Дані відправляються до ЄБК', 'success', options);

                                            customersService.closeCustomerInEBK(row.Id, custType).then(
                                                function (response) {
                                                    if (response.Message == 'ERROR')
                                                    bars.ui.alert({ text: 'Помилка роботи з сервісом ЄБК. <br><b> Дані будуть відправлені в режимі offline</b>' });
                                                    else if (response.Message == 'OK')
                                                    bars.ui.alert({ text: 'Клієнта № ' + row.Id + ' успішно  відправлений до ЄБК' });

                                                    vm.customersGrid.dataSource.read();
                                                },
                                                function () {
                                                    bars.ui.alert({ text: 'Помилка роботи з сервісом ЄБК. <br><b> Дані будуть відправлені в режимі offline</b>' });
                                                    vm.customersGrid.dataSource.read();
                                                });
                                        },
                                        function () {
                                            //vm.serviceState.searchText = '';
                                            //bars.ui.notify('Помилка виклику сервісу.', error.Message || error, 'error');
                                        });
                                }
                            });

                        }
                    }
                },
                openCustomerAcct: function () {
                    var row = selectedCustGridRow();
                    if (!row) {
                        bars.ui.error({ text: 'Спочатку виберіть клієнта, рахунки якого ви бажаєте переглянути.' });
                    } else {
                        var urlViewAcc = bars.config.urlContent("/customerlist/custacc.aspx?type=0&rnk=" + row.Id);
                        document.location.href = urlViewAcc;
                    }
                },
                openCustomerHistory: function () {
                    var row = selectedCustGridRow();
                    if (!row) {
                        bars.ui.error({ text: 'Спочатку виберіть клієнта, історію змін якого ви бажаєте переглянути.' });
                    } else {
                        bars.ui.dialog({
                            iframe: true,
                            content: {
                                url: bars.config.urlContent('/customerlist/CustHistory.aspx?mode=2&rnk=' + row.Id + '&type=0')
                            },
                            width: viewCustomerWinOptions.width,
                            height: viewCustomerWinOptions.height
                        });
                        //document.location.href = "../customerlist/CustHistory.aspx?mode=2&rnk=" + row.Id + "&type=0";
                    }
                },
                openCustomerPrintDoc: function() {
                    var row = selectedCustGridRow();
                    if (!row) {
                        bars.ui.error({ text: 'Спочатку виберіть клієнта, по якому ви бажаєте роздрукувати документи.' });
                    } else {
                        //document.location.href = bars.config.urlContent('');
                    }
                }
            };

            vm.registerNewCustomer = function () {
                editCustomerService.registerCustomer(vm.customerCreateModel.type, vm.customerCreateModel.isResident);
                vm.selectCustomrTypeWin.close();
            };

            vm.viewCustomer = function (id) {
                editCustomerService.viewCustomer(id);
            }

            vm.customersGridToolbarOptions = {
                resizable: false,
                items: [
                    {
                        type: 'button',
                        id: 'registerCustBtn',
                        text: '<i class="pf-icon pf-16 pf-add_button"></i> Зареєструвати',
                        click: function () {
                            vm.selectCustomrTypeWin.center().open();
                        }
                    }, {
                        type: 'separator'
                    }, {
                        enable: false,
                        id: 'reRegisterCustBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-man_1-update"></i> Перереєструвати',
                        click: function () {
                            editCustomerService.restoreCustomer();
                        }
                    }, {
                        enable: false,
                        id: 'closeCustBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Закрити',
                        click: function () {
                            editCustomerService.closeCustomer();
                        }
                    }, {
                        type: 'separator'
                    }, {
                        enable: false,
                        id: 'openCustAccsBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-bank-account"></i> Рахунки',
                        click: function () {
                            editCustomerService.openCustomerAcct();
                        }
                    }, {
                        enable: false,
                        id: 'openCustHistoryBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-report_open"></i> Історія змін',
                        click: function () {
                            editCustomerService.openCustomerHistory();
                        }
                    }/*, {
                        enable: false,
                        id: 'printCustDocumBtn',
                        type: 'button',
                        text: '<i class="pf-icon pf-16 pf-print"></i> Друк',
                        click: function () {
                            editCustomerService.openCustomerPrintDoc();
                        }
                    }*/
                ]
            };

            vm.customersFilter = {
                type: 'ALL',
                showClosed: false,
                likeClause: '',
                systemFilterId: 0,
                userFilterId: 0,
                whereClause: ''
            }

            
            var changeCustomerFilter = function(type) {
                if (type) {
                    vm.customersFilter.type = type.toUpperCase();
                    vm.customerCreateModel.type = type.toUpperCase();
                    vm.isCustomerFilterFromUrl = true;
                }
            };

            changeCustomerFilter(bars.extension.getParamFromUrl('custType', document.location.href));

            vm.reloadCustomersGrid = function () {
                enableToolbarButtons(false);

                vm.customersGrid.dataSource.read();
                //vm.customersGrid.refresh();
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
                    previousNext: true,
                    refresh: true,
                    pageSizes: [10, 20, 50, 200, 1000],
                    buttonCount: 3,
                    messages: {
                        itemsPerPage: ''
                    }
                },
                dataBound: function (e) {
                    var data = e.sender.dataSource.data();

                    $.each(data, function (i, row) {
                        $('tr[data-uid="' + row.uid + '"] ').css("background-color", "");
                        if (isNotEmpty(row.DEATH) && isNotEmpty(row.DTDIE)){
                            $('tr[data-uid="' + row.uid + '"] ').css("background-color", "rgb(193,193,193)");
                        }
                    });

                    if (data.length === 0) {
                        //if (e.sender.dataSource.total() === 0) {
                        var colCount = e.sender.columns.length;
                        $(e.sender.wrapper)
                            .find('tbody')
                            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' :(</td></tr>');
                    }
                    var grid = this;
                    grid.element.height("auto");
                    grid.element.find(".k-grid-content").height("auto");
                    kendo.resize(grid.element);
                },
                dataBinding: function() {
                    enableToolbarButtons(false);
                },
                change: function () {
                    enableToolbarButtons(true, selectedCustGridRow());
                },
                dataSource: {
                    type: 'webapi',
                    pageSize: 10,
                    page: 1,
                    total: 0,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    serverGrouping: true,
                    serverAggregates: true,
                    /*sort: {
                        field: "Id",
                        dir: "desc"
                    },*/
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/v1/clients/customers/getcustomers'),
                            dataType: 'json',
                            data: function () { return vm.customersFilter; }
                            /*,
                            data: {filter1: function () { return vm.customersFilter; }} /*function () { return vm.customersFilter; } /* {
                                type: function () { return vm.customersFilter.type; },
                                showClosed: function () { return vm.customersFilter.showClosed; },
                                customFilter: function() { return vm.customersFilter; }
                            }*/
                        }/*,
                        parameterMap: function (data, operation) {
                            debugger
                            return $.extend(data, vm.customersFilter);
                        }*/
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
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
                                DEATH: {type: 'string'},
                                DTDIE: {type: 'string'},
                                PHOTO_WEB: {type: 'string'}
                            }
                        }
                    }
                },
                columns: [
                    {
                        title: ' ',
                        field: 'Id',
                        template: function(dataItem) {
                            if (dataItem.PHOTO_WEB) {
                                return '<div class="cust-avatar">' +
                                    '<img width="24" height="24" alt="" src="' + dataItem.PHOTO_WEB + '" />' +
                                    '</div>';
                            } else {
                                return '<div class="cust-avatar">' +
                                    '<div class="no-avatar"><i class="ti-user"></i></div>' +
                                    //'<i class="pf-icon pf-24 pf-file_picture-user"></i>' +
                                    '</div>';
                            }
                        },
                        /*template: '<div class="cust-avatar">' +
                                    '<img alt="" src="#= Id #" />' +
                                  '</div>',*/
                        width: '50px',
                        filterable: false,
                        sortable: false
                    }, {
                        field: 'Id',
                        title: 'Реєстр.<br/>номер',
                        template: '<a style="color: blue" href="#= bars.config.urlContent(\'/clients/customers/view/\') + Id #" ng-click="custCtrl.viewCustomer(#=Id#)" onclick="return false;">#= Id #</a>',
                        filterable: bars.ext.kendo.grid.uiNumFilter,
                        width: '80px'
                    }, {
                        field: 'ContractNumber',
                        title: '№ договору',
                        width: '100px'
                    }, {
                        field: 'Code',
                        title: 'ЕДРПОУ /<br/>іден. код',
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
                        filterable: false,//{ messages: { isTrue: "trueString", isFalse: "falseString" } },
                        width: '60px'
                    }, {
                        field: 'Name',
                        title: 'Найменування',
                        width: '200px'
                    }, {
                        field: 'DateOpen',
                        title: 'Дата<br/>реєстрації',
                        format: '{0:dd.MM.yyyy}',
                        width: '80px'
                    }, {
                        field: 'DateClosed',
                        title: 'Дата<br/>закриття',
                        format: '{0:dd.MM.yyyy}',
                        width: '80px'
                    }, {
                        field: 'Branch',
                        title: 'Код безб.<br/>відділення',
                        width: '170px'
                    }
                ]
            };
        }
    ]);