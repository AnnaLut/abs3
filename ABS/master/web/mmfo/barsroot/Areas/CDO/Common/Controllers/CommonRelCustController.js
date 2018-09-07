angular.module(globalSettings.modulesAreas)
.controller('CDO.CommonRelCustController',
[
    '$scope', 
    'CDO.commonCustomersService', 
    'CDO.CorpLight.relatedCustomersService', 
    'CDO.Corp2.relatedCustomersService',
    '$rootScope',
    function ($scope, customersService, corpLightRelCustService, corp2RelCustService, $rootScope) {
        'use strict';

        var vm = this;
        var limitDictionary = null;
        customersService.getModuleVersion().then(
            function (response) {
                vm.moduleVersion = 'v' + response;
            },
            function () { }
        );

        //#region Common customers grid

        vm.showUserManual = function () {
            window.open(
                '/barsroot/areas/cdo/CorpLight/doc/userManual.htm',
                'UserManual',
                'scrollbars=yes,resizable=yes,height=900px,width=950px',
                true);
        }
        
        vm.back_confirmConnectUsersGridOptions = {
            toolbar: [{
                name: 'ShowUserManual',
                text: 'Інструкція користувача',
                template: '<button ng-click="relCustCtrl.showUserManual()" '
                + 'style="float:right;" '
                + 'class="k-button" title="Інструкція користувача">Інструкція користувача</button>'
            }],
            autoBind: true,
            editable: "popup",
            height: 120,
            width: 300,
            selectable: false,
            groupable: false,
            sortable: true,
            resizable: true,
            filterable: true,
            scrollable: true,
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100, 200],
                buttonCount: 5
            },
            dataBound: function (e) {
                bars.ext.kendo.grid.noDataRow(e);
                vm.isShowClUserForm = false;
            },
            dataBinding: function () { },
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
                sort: {
                    field: "Id",
                    dir: "desc"
                },
                transport: {
                    read: {
                        url: bars.config.urlContent('/api/cdo/common/RelatedCustomers/') + $('#custId').val(),
                        dataType: 'json',
                        cache: false,
                        data: function () {
                            return vm.customersFilter;
                        }
                    }
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        id: 'Id',
                        fields: {
                            CustId: {
                                type: 'number'
                            },
                            TaxCode: {
                                type: 'string'
                            },
                            Sdo: {
                                type: 'string'
                            },
                            FirstName: {
                                type: 'string'
                            },
                            LastName: {
                                type: 'string'
                            },
                            SecondName: {
                                type: 'string'
                            },
                            DocType: {
                                type: 'string'
                            },
                            CellPhone: {
                                type: 'string'
                            },
                            Email: {
                                type: 'string'
                            },
                            SignNumber: {
                                type: 'string'
                            },
                            IsApproved: {
                                type: 'bool'
                            },
                            ApprovedType: {
                                type: 'string'
                            }
                        }
                    }
                }
            },
            columns: [
                {
                    title: 'Статус',
                    width: '100px',
                    template: function (data) {
                        var html = '';
                        switch (data.ApprovedType) {
                            case 'add':
                                html += '<span class="label label-primary">новий</span>';
                                break;
                            case 'update':
                                html += '<span class="label label-warning">оновлено</span>';
                                break;
                            case 'delete':
                                html += '<span class="label label-danger">видалено</span>';
                                break;
                            case 'rejected':
                                html += '<span class="label label-default">відхилено</span>';
                                break;
                            default:
                                if (data.IsApproved) {
                                    html += '<span class="label label-success">підтверджено</span>';
                                }
                        };
                        return html;
                    }
                }, {
                    field: 'TaxCode',
                    title: 'ІПН',
                    width: '90px'
                }, {
                    field: 'Sdo',
                    title: 'СДО',
                    width: '60px'
                    //,template: function (data) {
                    //    var content = '';
                    //    if (data.Sdo && data.Sdo.toUpperCase() == 'CORP2') {
                    //        content = '<a href="#" ng-click="open_userConnectionParamsWindow_back(' + data.Id + ')" style="text-decoration: underline; color: steelblue;">'
                    //            + data.Sdo + '</a>';
                    //    }
                    //    else content = data.Sdo;
                    //    return content;
                    //}
                }, {
                    title: 'ПІБ',
                    width: '200px',
                    template: function (data) {
                        var content = '';
                        if (data.Sdo && data.Sdo.toUpperCase() == 'CORP2') {
                            content = '<a href="#" ng-click="open_userDetailWindow_back(' + data.Id + ')" style="text-decoration: underline; color: steelblue;">'
                                + data.LastName + ' ' + data.FirstName + ' ' + data.SecondName + '</a>';
                        }
                        else content = data.LastName + ' ' + data.FirstName + ' ' + data.SecondName;
                        return content;
                    }
                }, {
                    field: 'CellPhone',
                    title: 'Телефон',
                    width: '110px'
                }, {
                    field: 'Email',
                    title: 'e-mail',
                    width: '200px'
                }, {
                    field: 'DocType',
                    title: 'Документ',
                    width: '80px',
                    template: function (data) {
                        return '<span title="виданий ' + data.DocOrganization + ' ' + (data.DocDate ? new Date(parseInt(data.DocDate.substr(6))).toLocaleDateString('uk-UA', { year: 'numeric', month: 'long', day: 'numeric' }) : '') + '">' + data.DocSeries + ' ' + data.DocNumber;
                    }
                }, {
                    field: 'SignNumber',
                    title: '№<br>підпису',
                    width: '60px',
                    template: function (data) {
                        return '<b>' + data.SignNumber + '</b>';
                    }
                }, {
                    title: 'Підтвердити</br>/ видалити',
                    width: '150px',
                    filterable: false,
                    sortable: false,
                    template: function (data) {
                        var html = '';
                        if (!data.IsApproved && data.ApprovedType !== 'rejected') {
                            html = '<button class="btn btn-success" ng-click="visaMapedCustomers(' + data.Id + ',' + data.CustId + ',\'' + data.Sdo + '\');"  title="Підтвердити">\
                                                        <i class="fa fa-check"></i> \
                                                    </button>';
                            html += '<button style="margin-left: 10px;" class="btn btn-danger" ng-click="deleteRequest(\'' + data.Id + '\', \'' + data.CustId + '\', \'' + data.Sdo + '\');" title="Видалити">\
                                                        <i class="fa fa-trash-o"></i> \
                                                    </button>';
                        }

                        return html;
                    }
                }
            ]
        };
        $scope.open_userDetailWindow_back = vm.open_userDetailWindow_back = function (userId) {
            vm.SignNumber = null;
            vm.currentUser = vm.back_confirmConnectUsersGrid.dataSource.get(userId);            
            vm.userDetailWindow_back.center().open();
        }
        vm.userDetailWindowOptions_back = {
            width: '600px',
            height: '400px',
            title: ' ',
            modal: true,
            actions: ["Maximize", "Close"],
            close: function (e) {
                vm.currentUser = null;
            }
        }
        //vm.userConnectionParamsWindow_Options_back = {
        //    //width: '600px',
        //    //height: '400px',
        //    title: 'Налаштування користувача Корп2',
        //    modal: true,
        //    actions: ["Maximize", "Close"],
        //    close: function () {
        //        vm.userConnectionParamsWindow_Model = null;
        //        vm.userConnectionParamsWindow_LimitModel = null;
        //        vm.currentUserId = null;
        //        //clear grids
        //        vm.corp2_UserConnParamsWindow_AccsGrid.dataSource.data([]);
        //        vm.corp2_UserConnParamsWindow_availableModulesGrid.dataSource.data([]);
        //        vm.corp2_UserConnParamsWindow_userModulesGrid.dataSource.data([]);
        //        //vm.corp2_UserConnParamsWindow_userFuncsGrid.dataSource.data([]);
        //        //vm.corp2_UserConnParamsWindow_availableFuncsGrid.dataSource.data([]);
        //        //vm.ModuleName = null;
        //        //allUserFuncs.length = 0;
        //        //allAvailableFuncs.length = 0;
        //    }
        //}

        //$scope.open_userConnectionParamsWindow_back = vm.open_userConnectionParamsWindow_back = function (id) {
        //    vm.currentUserId = id;
        //    initUserConnectionParamsWindow(id);
        //    vm.userConnectionParamsWindow_back.center().open();
        //}

        //function initUserConnectionParamsWindow(userId) {

        //    vm.userConnectionParamsWindow_Model = vm.back_confirmConnectUsersGrid.dataSource.get(userId);
        //    if (!limitDictionary) {
        //        corp2RelCustService.getLimitDictionary().then(
        //            function (response) { limitDictionary = response; },
        //            function (response1) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні словника лімітів', 'error'); }
        //        );
        //    }

        //    corp2RelCustService.getUserLimit(userId).then(
        //        function (response1) { vm.userConnectionParamsWindow_LimitModel = response1; },
        //        function (response1) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні лімітів по користувачу', 'error'); }
        //    );
        //    vm.corp2_UserConnParamsWindow_AccsGrid.dataSource.read();
        //    vm.corp2_UserConnParamsWindow_availableModulesGrid.dataSource.read();
        //    vm.corp2_UserConnParamsWindow_userModulesGrid.dataSource.read();

        //    //corp2RelCustService.getAvailableFuncs(userId).then(
        //    //    function (response2) { allAvailableFuncs = response2; },
        //    //    function (response2) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні доступних до видачі функцій', 'error'); }
        //    //);
        //    //corp2RelCustService.getUserFuncs(userId).then(
        //    //    function (response3) { allUserFuncs = response3; },
        //    //    function (response3) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні доступних функцій по користувачу', 'error'); }
        //    //);
        //}
        //----------Modules & Functions
        //var allUserFuncs;
        //var allAvailableFuncs;
        //vm.corp2_UserConnParamsWindow_userModulesGridOptions = createGridOptions({
        //    dataSource: createDataSource({
        //        type: "webapi",
        //        transport: {
        //            read: {
        //                //async: false,
        //                url: bars.config.urlContent('api/cdo/corp2/getusermodules'),
        //                cache: false,
        //                data: function () { return { userId: vm.currentUserId }; }
        //            }
        //        },
        //        schema: {
        //            model: {
        //                id: 'Id',
        //                fields: { Name: { type: "string" } }
        //            }
        //        }
        //    }),
        //    editable: "popup",
        //    selectable: "multiple, row",
        //    pageable: false,
        //    autoBind: false,
        //    columns: [{
        //        field: 'Name',
        //        title: 'Перелік виданих модулів',
        //        width: '200px'
        //    }],
        //    change: function (e) {
        //        var selectedRows = this.select();
        //        if (selectedRows.length != 1) return;
        //        var dataItem = this.dataItem(selectedRows[0]);
        //        vm.ModuleName = dataItem.Name;
        //        initFuncsGrids(dataItem.id);
        //    }
        //});
        //vm.corp2_UserConnParamsWindow_availableModulesGridOptions = createGridOptions({
        //    dataSource: createDataSource({
        //        type: "webapi",
        //        transport: {
        //            read: {
        //                url: bars.config.urlContent('api/cdo/corp2/getavailablemodules'),
        //                cache: false,
        //                data: function () { return { userId: vm.currentUserId }; }
        //            }
        //        },
        //        schema: {
        //            model: {
        //                id: 'Id',
        //                fields: { Name: { type: "string" } }
        //            }
        //        }
        //        //pageSize: 10,
        //        //page: 1,
        //        //total: 0
        //    }),
        //    //height: 50,
        //    pageable: false,
        //    editable: "popup",
        //    selectable: "multiple, row",
        //    autoBind: false,
        //    columns: [{
        //        field: 'Name',
        //        title: 'Перелік доступних до видачі модулів',
        //        width: '200px'
        //    }]
        //});

        //vm.corp2_UserConnParamsWindow_userFuncsGridOptions = createGridOptions({
        //    editable: "popup",
        //    selectable: "multiple, row",
        //    pageable: false,
        //    //autoBind: false,
        //    columns: [{
        //        field: 'Name',
        //        title: 'Перелік виданих функцій',
        //        width: '200px'
        //    }]
        //});
        //vm.corp2_UserConnParamsWindow_availableFuncsGridOptions = createGridOptions({
        //    editable: "popup",
        //    selectable: "multiple, row",
        //    pageable: false,
        //    //autoBind: false,
        //    columns: [{
        //        field: 'Name',
        //        title: 'Перелік доступних до видачі функцій',
        //        width: '200px'
        //    }]
        //});

        //function initFuncsGrids(moduleId) {
        //    var availableFuncs = allAvailableFuncs.filter(function (el) { return el.ModuleId == moduleId; });
        //    var userFuncs = allUserFuncs.filter(function (el) { return el.ModuleId == moduleId; });
        //    var availableFuncsDS = new kendo.data.DataSource({
        //        data: availableFuncs,
        //        schema: {
        //            model: {
        //                id: 'Id',
        //                fields: {
        //                    Name: { type: "string" },
        //                    ModuleId: { type: "string" }
        //                }
        //            }
        //        }
        //    });
        //    var userFuncsDS = new kendo.data.DataSource({
        //        data: userFuncs,
        //        schema: {
        //            model: {
        //                id: 'Id',
        //                fields: {
        //                    Name: { type: "string" },
        //                    ModuleId: { type: "string" }
        //                }
        //            }
        //        }
        //    });
        //    vm.corp2_UserConnParamsWindow_availableFuncsGrid.setDataSource(availableFuncsDS);
        //    vm.corp2_UserConnParamsWindow_userFuncsGrid.setDataSource(userFuncsDS);
        //};

        //----------Accounts
        //var corp2_UserConnParamsWindow_AccsGrid_DataSource = createDataSource({
        //    type: "webapi",
        //    transport: {
        //        read: {
        //            url: bars.config.urlContent('api/cdo/corp2/getcorp2useraccspermissions'),
        //            cache: false,
        //            data: function () { return { custId: $('#custId').val(), userId: vm.currentUserId }; }
        //        }
        //    },
        //    schema: {
        //        model: {
        //            id: 'Id',
        //            fields: {
        //                CAN_WORK: { type: "boolean" },
        //                CAN_VIEW: { type: "boolean" },
        //                CAN_DEBIT: { type: "boolean" },
        //                CAN_VISA: { type: "boolean" },
        //                CORP2_ACC: { type: "number" },

        //                //кількість
        //                VISA_ID: { type: "number" },
        //                SEQUENTIAL_VISA: { type: "boolean" },
        //                KF: { type: "string" },
        //                KV: { type: "string" },
        //                NUM_ACC: { type: "string" },
        //                NAME: { type: "string" }
        //            }
        //        }
        //    }
        //});
        //vm.corp2_UserConnParamsWindow_AccsGridOptions = createGridOptions({
        //    dataSource: corp2_UserConnParamsWindow_AccsGrid_DataSource,
        //    autoBind: false,
        //    columns: [
        //        {
        //            field: 'CAN_WORK',
        //            title: ' ',
        //            width: '50px',
        //            filterable: false,
        //            sortable: false,
        //            //headerTemplate: "<label class='btn' ng-click='switchUserAccCheckBoxes()' title='Вибрати всі'><input type='checkbox' id='accHeaderChbx'/></label>",
        //            template: function (data) {
        //                var html = "<label class='btn'><input type='checkbox' fieldName='CAN_WORK' disabled";
        //                if (data.CAN_WORK) html += ' checked';
        //                html += " /></label>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        },
        //        {
        //            field: 'CAN_VIEW',
        //            title: 'Виписка',
        //            width: '55px',
        //            filterable: false,
        //            sortable: false,
        //            template: function (data) {
        //                var html = "<label class='btn'><input type='checkbox' fieldName='CAN_VIEW' disabled";
        //                if (data.CAN_VIEW) html += ' checked';
        //                html += " /></label>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        }, {
        //            field: 'CAN_DEBIT',
        //            title: 'Дебет',
        //            width: '50px',
        //            filterable: false,
        //            sortable: false,
        //            template: function (data) {
        //                var html = "<label class='btn'><input type='checkbox' fieldName='CAN_DEBIT' disabled";
        //                if (data.CAN_DEBIT) html += ' checked';
        //                html += " /></label>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        }, {
        //            field: 'CAN_VISA',
        //            title: 'Віза',
        //            width: '50px',
        //            filterable: false,
        //            sortable: false,
        //            template: function (data) {
        //                var html = "<label class='btn'><input type='checkbox' fieldName='CAN_VISA' disabled";
        //                if (data.CAN_VISA) html += ' checked';
        //                html += " /></label>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        }, {
        //            field: 'VISA_ID',
        //            title: '№ візи',
        //            width: '50px',
        //            filterable: false,
        //            sortable: false,
        //            template: function (data) {
        //                var html = "<input fieldName='VISA_ID' kendo-numeric-text-box k-min='1' k-max='9' data-k-format=\"'n0'\" class='k-input w-100' value='" + (data.VISA_ID || vm.userConnectionParamsWindow_Model.SignNumber) + "' disabled/>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        }, {
        //            field: 'SEQUENTIAL_VISA',
        //            title: 'Послідовна',
        //            width: '70px',
        //            filterable: false,
        //            sortable: false,
        //            template: function (data) {
        //                var html = "<label class='btn'><input type='checkbox' fieldName='SEQUENTIAL_VISA' disabled";
        //                if (data.SEQUENTIAL_VISA) html += ' checked';
        //                html += " /></label>";
        //                return html;
        //            },
        //            attributes: { "class": "cell-horiz-align-center" }
        //        }, {
        //            field: 'NUM_ACC',
        //            title: 'Рахунок',
        //            width: '120px'
        //        }, {
        //            field: 'NAME',
        //            title: 'Найменування',
        //            width: '180px'
        //        }
        //    ]
        //});


        $scope.visaMapedCustomers = vm.visaMapedCustomers = function (relCustId, custId, sdo) {

            // TODO get service function
            var _service = null;
            var _isCorpLight = false;
            if (sdo.toLowerCase() == 'corplight'){
                _isCorpLight = true;
                _service = corpLightRelCustService;
            }
            else{
                _isCorpLight = false;
                _service = corp2RelCustService;
            }

            bars.ui.loader('body', true);
            _service.visaMapedCustomer(relCustId, custId)
                .then(
                function (response) {
                    bars.ui.loader('body', false);
                    if (response.Status === 'ERROR' && response.Data) {
                        bars.ui.confirm({ text: response.Message + ' Бажаєте надати доступ цьому користувачеві?' },
                            function () {
                                if (!_isCorpLight) {
                                    bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                    vm.back_confirmConnectUsersGrid.dataSource.read();
                                }
                                else{
                                    bars.ui.loader('body', true);
                                    _service.visaExistingUser(relCustId, custId, response.Data.Id)
                                        .then(
                                        function (response) {
                                            bars.ui.loader('body', false);
                                            bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                            vm.back_confirmConnectUsersGrid.dataSource.read();
                    
                                        },
                                        function (response) {
                                            bars.ui.loader('body', false);
                                            bars.ui.notify('Помилка',
                                                response.ExceptionMessage || response.Message || response,
                                                'error');
                                        }
                                        );
                                }
                            });
                    } else {
                        bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                        vm.back_confirmConnectUsersGrid.dataSource.read();
                    }
                },
                function (response) {
                    bars.ui.loader('body', false);
                    //bars.ui.notify('Помилка',
                    //    response.ExceptionMessage || response.Message || response,
                    //    'error');
                }
                );
            //}
            //vm.currentUser = new RelatedCustomer();
        }

        $scope.deleteRequest = vm.deleteRequest = function (id, customerId, sdo) {

            // TODO get service function
            var _service = null;
            var _isCorpLight = false;
            if (sdo.toLowerCase() == 'corplight'){
                _isCorpLight = true;
                _service = corpLightRelCustService;
            }
            else{
                _isCorpLight = false;
                _service = corp2RelCustService;
            }

            bars.ui.confirm({ text: 'Видалити запит на підтвердження даних?' }, function () {
                _service.deleteRequest(id, customerId).then(
                    function () {
                        bars.ui.notify('Успішно', 'Запит на підтвердження даних видалено.', 'success');
                        vm.back_confirmConnectUsersGrid.dataSource.read();
                    },
                    function (response) {
                        bars.ui.notify('Помилка',
                            'Помилка обробки запиту <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    }
                );
            });
        }

        //#endregion
        // private helpers
        function extend(src, dst) {
            for (var key in src) {
                if (src[key] === null || src[key] instanceof Array || ["number", "boolean", "string", "function", "undefined"].indexOf(typeof src[key]) !== -1) {
                    dst[key] = src[key];
                }
                else {
                    if (!dst.hasOwnProperty(key)) { dst[key] = {}; }
                    extend(src[key], dst[key]);
                }
            }
        }

        function createDataSource(ds) {
            var _ds = {
                type: "aspnetmvc-ajax",
                pageSize: 12,
                serverPaging: true,
                serverFiltering: true,
                serverSorting: true,
                transport: {
                    read: {
                        type: "GET",
                        dataType: "json",
                        url: ""
                    }
                },
                requestStart: function () { bars.ui.loader("body", true); },
                requestEnd: function (e) { bars.ui.loader("body", false); },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: { fields: {} }
                }
            };

            extend(ds, _ds);

            return _ds;
        }

        function createGridOptions(go) {
            var _go = {
                autoBind: true,
                resizable: true,
                selectable: "row",
                scrollable: true,
                sortable: true,
                pageable: {
                    messages: {
                        allPages: "Всі"
                    },
                    refresh: true,
                    pageSizes: [10, 50, 200, 1000, "All"],
                    buttonCount: 5
                },
                filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
                reorderable: true,
                change: function () {
                    var grid = this;
                    var row = grid.dataItem(grid.select());
                },

                columns: [],
                filterable: true,
                dataBound: function (e) {
                    bars.ext.kendo.grid.noDataRow(e);
                },
                dataBinding: function () { }
            };

            extend(go, _go);

            return _go;
        }
    }
]);