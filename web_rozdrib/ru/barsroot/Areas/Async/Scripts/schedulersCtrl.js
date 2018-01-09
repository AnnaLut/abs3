angular.module('BarsWeb.Areas').controller('Async.SchedulersCtrl',['$scope', '$http', function ($scope, $http) {
    $scope.apiUrl = bars.config.urlContent('/api/async/schedulers/');

    $scope.scheduler = {};

    var schedulersDataSource = {
        url: bars.config.urlContent('/api/async/schedulers/'),
        get: function (id, func) {
            if (id) {
                $http.get(this.url + '?id=' + id)
                    .success(function (request) {
                        $scope.scheduler = request;
                        $scope.parametersListGrid.dataSource.data(request.ParametersList);
                        $scope.parametersListGrid.refresh();
                        if (func) {
                            func.apply(null, [request]);
                        }
                    });
                return null;
            } else {
                $scope.parametersListGrid.dataSource.data([]);
                $scope.parametersListGrid.refresh();
                return {
                    Id :null,
                    Code:null,
                    Type: 'PLSQL',
                    SqlId: null,
                    SqlText:null,
                    WebUiId :null,
                    IsBarsLogin :null,
                    ExclusionMode :'NONE',
                    MaxExecutionTime: null,
                    UserMessages: null,
                    Name: '',
                    Description: '',
                    ParametersList: []
                }
            }
        },
        add: function (object, func) {
            $http.post(this.url, object)
                .success(function (request) {
                    if (func) {
                        func.apply(null, [request]);
                    }
                    /*bars.ui.loader('#advertisingWindow', false);
                    $scope.advertisingWindow.close();
                    bars.ui.notify('Оголошення створено. № ' + request.Id, '', 'success');
                    $scope.adversitingGrid.dataSource.read();
                    $scope.adversitingGrid.refresh();*/
                });
        },
        edit: function (object, func) {
            $http.put(this.url, object)
                .success(function (request) {
                    if (func) {
                        func.apply(null, [request]);
                    }
                });
        },
        remove: function (id, func) {
            $http({
                method: 'DELETE',
                url: this.url + '?id=' + id
            }).success(function (request) {
                if (func) {
                    func.apply(null, [request]);
                }
            });
        }
    }

    var selectedRow = function () {
        return $scope.schedulersGrid.dataItem($scope.schedulersGrid.select());
    };

    var toolbarWindows = {
        add: function () {
            $scope.scheduler = schedulersDataSource.get();
            $scope.$apply();
            $scope.schedulerWindow.center().open();
        },
        edit: function() {
            var data = selectedRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для редагування' });
            } else {
                $scope.scheduler = schedulersDataSource.get();
                
                schedulersDataSource.get(data.Id, function () { /*$scope.$apply();*/ });
                $scope.schedulerWindow.center().open();
            }
        },
        remove:function() {
            var data = selectedRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для видалення' });
            } else {
                bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити завдання №' + data.Id },
                    function () {
                        schedulersDataSource.remove(data.Id, function() {
                            bars.ui.notify('Завдання № ' + data.Id + ' видалено', '', 'success');
                            $scope.schedulersGrid.dataSource.read();
                            $scope.schedulersGrid.refresh();
                        });
                    });
            }
        }
    };
    $scope.toolbarOptions = {
        items: [
            {
                type: "button",
                id: 'addSchedulerBtn',
                text: '<i class="pf-icon pf-16 pf-add_button"></i> Створити',
                click: function () {
                    toolbarWindows.add();
                }
            },
            {
                type: "button",
                enable: false,
                id: 'editSchedulerBtn',
                text: '<i class="pf-icon pf-16 pf-tool_pencil"></i> Редагувати',
                click: function () {
                    toolbarWindows.edit();
                }
            },
            {
                type: "button",
                enable: false,
                id: 'deleteSchedulerBtn',
                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Видалити',
                click: function () {
                    toolbarWindows.remove();
                }
            }, {
                type: 'separator'
            }, {
                type: "button",
                enable: false,
                id: 'getSqlCodeBtn',
                text: '<i class="pf-icon pf-16 pf-sql_check"></i> Вигрузити в SQL',
                click: function () {
                    toolbarWindows.remove();
                }
            }
        ]
    };
    $scope.schedulerWindowOptions = {
        animation: false,
        visible: false,
        width: "550px",
        actions: ["Maximize", "Minimize", "Close"],
        draggable: true,
        height: "650px",
        modal: true,
        pinned: false,
        resizable: true,
        title: '',
        position: 'center',
        close: function () {
            $scope.scheduler = schedulersDataSource.get();
        },
        iframe: false
    };
    $scope.schedulerWindowTitle = function() {
        if ($scope.scheduler.Id == null) {
            return 'Створення нового завдання';
        } else {
            return 'Редагування завдання № ' + $scope.scheduler.Id;
        }
    }

    $scope.saveScheduler = function () {
        console.log($scope.parametersListGrid.dataSource.view());
        $scope.scheduler.ParametersList = $scope.parametersListGrid.dataSource.view();

        if ($scope.scheduler.Id == null) {
            schedulersDataSource.add($scope.scheduler, function (request) {
                bars.ui.notify('Завдання збережено. № ' + request.Id, '', 'success');
                $scope.schedulersGrid.dataSource.read();
                $scope.schedulersGrid.refresh();
                $scope.schedulerWindow.close();
            });
        } else {
            schedulersDataSource.edit($scope.scheduler, function (request) {
                bars.ui.notify('Завдання № ' + request.Id + ' збережено.', '', 'success');
                $scope.schedulersGrid.dataSource.read();
                $scope.schedulersGrid.refresh();
                $scope.schedulerWindow.close();
            });            
        }
    }

    $scope.showSql = function (text) {
        var row = $scope.schedulersGrid.dataSource.get(text);
        bars.ui.alert({ text: '<pre>' + row.SqlText + '</pre>', title: 'SQL'});
    }
    var enableToolbarButtons = function (type, data) {
        $scope.schedulersGridToolbar.enable('#editSchedulerBtn', type);
        $scope.schedulersGridToolbar.enable('#deleteSchedulerBtn', type);
        $scope.schedulersGridToolbar.enable('#getSqlCodeBtn', type);
    }
    $scope.schedulersGridOptions = {
        height: 100,
        dataBound: function (e) {
            var data = e.sender.dataSource.data();
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
        dataBinding: function () {
            enableToolbarButtons(false);
        },
        change: function () {
            enableToolbarButtons(true, selectedRow());
        },
        dataSource: {
            type: 'webapi',
            transport: {
                read: {
                    url: schedulersDataSource.url,
                    dataType: 'json'
                }
            },
            sort: {
                field: "Id",
                dir: "desc"
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    id: "Id",
                    fields: {
                        Id: { type: 'number' },
                        Code: { type: 'string' },
                        Type: { type: 'string' },
                        SqlId :{ type: 'number' },
                        WebUiId :{ type: 'number' },
                        IsBarsLogin: { type: 'boolean' },
                        ExclusionMode: { type: 'string' },
                        MaxExecutionTime: { type: 'number' }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true
        },
        sortable: true,
        filterable: true,
        resizable: true,
        selectable: "single",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        columns: [
            {
                field: "Id",
                title: "ID",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            min: 0,
                            format: "n0"
                        });
                    }
                },
                width: "70px"
            }, {
                field: "Code",
                title: "Код",
                width: "120px"
            }, {
                field: "Type",
                title: "Тип",
                width: "120px"
            }, {
                field: "SqlText",
                title: "Sql запит",
                width: "120px",
                template: '<button ng-click=\"showSql(#=Id#)\"; class=k-button>показати</button>'
            }, {
                field: "WebUiId",
                title: "ID веб сервісу",
                width: "120px"
            }, {
                field: "IsBarsLogin",
                title: "BARS логін",
                width: "170px",
                template: '<input type="checkbox" #= (IsBarsLogin) ? "checked=checked" : "" # disabled="disabled" >'
            },{
                field: "ExclusionMode",
                title: "Режим запуску",
                width: "120px"
            }, {
                field: "MaxExecutionTime",
                title: "Макс. час вик.(сек)",
                width: "120px"
            }
        ]
    };

    var dbTypeDropDownEditor = function (container, options) {
        $('<input required data-text-field="SemanticColumn" data-value-field="PrimaryKeyColumn" data-bind="value:' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                dataSource:[
                {
                    PrimaryKeyColumn: 'VARCHAR2',
                    SemanticColumn: 'Строка'
                },{
                    PrimaryKeyColumn: 'DATE',
                    SemanticColumn: 'Дата'
                },{
                    PrimaryKeyColumn: 'NUMBER',
                    SemanticColumn: 'Номер'
                }]

                /*autoBind: false,
                dataSource: {
                    type: "odata",
                    transport: {
                        read: "http://demos.telerik.com/kendo-ui/service/Northwind.svc/Categories"
                    }
                }*/
            });
    };

    var uiTypeDropDownEditor = function (container, options) {
        $('<input data-text-field="SemanticColumn" data-value-field="PrimaryKeyColumn" data-bind="value:' + options.field + '"/>')
            .appendTo(container)
            .kendoDropDownList({
                dataSource:[
                {
                    PrimaryKeyColumn: null,
                    SemanticColumn: ''                    
                },{
                    PrimaryKeyColumn: 'DIRECTORY',
                    SemanticColumn: 'Довідник'
                },{
                    PrimaryKeyColumn: 'DROPDOWN',
                    SemanticColumn: 'Випадаючий список'
                },{
                    PrimaryKeyColumn: 'INPUT',
                    SemanticColumn: 'Поле вводу'
                },{
                    PrimaryKeyColumn: 'TEXTAREA',
                    SemanticColumn: 'Розширене поле вводу'
                }]
            });
    };

    $scope.parametersListGridOptions = {
        dataSource: {
            schema: {
                model: {
                    id: "Id",
                    fields: {
                        Id: { type: 'number' },
                        Name: { type: 'string' },
                        Type: { type: 'string' },
                        OriginalDbType: { type: 'string' },
                        Value: { type: 'string' },
                        Minimum: { type: 'number', format:'n0' },
                        Maximum: { type: 'number' },
                        UiType: { type: 'string' },
                        Directory: {type: 'string'},
                        Description: { type: 'string' }
                    }
                }
            }
        },
        selectable: "multiple",
        editable: "popup",
        toolbar: [{
            name: "create",
            imageClass: 'pf-icon pf-16 pf-add_button'
        }],
        height:'150px',
        //dataBound: schedulerGridDataBound,
        columns: [
            {
                command: [
                {
                    name:"edit", 
                    text: '',
                    imageClass: 'pf-icon pf-16 pf-tool_pencil',
                    width: '30px'
                }, {
                    name: "Видалити",
                    text: '',
                    imageClass: 'pf-icon pf-16 pf-delete_button_error',
                    click: function (e) {  //add a click event listener on the delete button
                        var tr = $(e.target).closest("tr"); //get the row for deletion
                        var data = this.dataItem(tr); //get the row data so it can be referred later

                        bars.ui.confirm({
                            text: 'Видалити параметр', func: function () {
                                $scope.parametersListGrid.dataSource.remove(data);
                            }
                        });
                    }
                }],
                title: "&nbsp;", width: "100px"
            },
            /*{
                field: "Id",
                title: "ID",
                width: "70px"
            },*/ {
                field: "Name",
                title: "Ім'я",
                width: "120px"
            }, {
                field: "OriginalDbType",
                editor: dbTypeDropDownEditor,
                title: "Тип",
                width: "120px"
            }, {
                field: "Value",
                title: "Значення по зам.",
                width: "120px"
            }, {
                field: "Minimum",
                title: "Мін.знач.",
                //editor: { format: 'n0' },
                width: "100px"               
            }, {
                field: "Maximum",
                title: "Макс.знач.",
                width: "100px"
            }, {
                field: "UiType",
                title: "Віз.відображення",
                editor: uiTypeDropDownEditor,
                width: "100px"
            }, {
                field: "Directory",
                title: "Довідник  ",
                width: "100px"                
            }, {
                field: "Description",
                title: "Назва",
                width: "120px"
            }
        ]
    }

    var validateAdvt = function () {
        var result = {
            status: true,
            message: ''
        };
        if ($scope.advertising.Name == '' || $scope.advertising.Name == null) {
            result.status = false;
            result.message += 'Незаповнено поле Назва<br/>';
        }
        if ($scope.advertising.DateBegin == '' || $scope.advertising.DateBegin == null) {
            result.status = false;
            result.message += 'Незаповнено поле Початок дії<br/>';
        }
        if ($scope.advertising.DateEnd == '' || $scope.advertising.DateEnd == null) {
            result.status = false;
            result.message += 'Незаповнено поле Кінець дії<br/>';
        }
        if ($scope.advertising.BranchList == null || $scope.advertising.BranchList.length == 0 ) {
            result.status = false;
            result.message += 'Незаповнено поле Відділення<br/>';
        }
        if ($scope.advertising.TransactionCodeList == null || $scope.advertising.TransactionCodeList == '') {
            result.status = false;
            result.message += 'Незаповнено поле Список операцій<br/>';
        }
        return result;
    }
}]);