angular.module('BarsWeb.Controllers').controller('Async.Tasks', ['$scope', '$http', function ($scope, $http) {
    //$scope.apiUrl = bars.config.urlContent('/api/async/schedulers/');

    $scope.task = {};

    var tasksDataSource = {
        url: bars.config.urlContent('/api/async/tasks/'),
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



    $scope.toolbarOptions = {
        items: [
            /*{
                template: '<label ><input type="radio" data-ng-model="adversitingGridOptions.showNotActive" /> показувати неактивні</label>'
            },
            { type: "separator" },*/


            /*{
                type: "button",
                text: '<i class="pf-icon pf-16 pf-add_button"></i>Створити',
                click: function () {
                    toolbarWindows.add();
                }
            },
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати',
                click: function () {
                    toolbarWindows.edit();
                }
            },*/
            {
                enable: false,
                type: "button",
                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Зупинити',
                id: 'stopTaskBtn',
                click: function () {
                    $scope.toolbarWindows.remove();
                }
            }
        ]
    };
    var selectedTaskGridRow = function () {
        return $scope.tasksGrid.dataItem($scope.tasksGrid.select());
    };
    $scope.toolbarWindows = {
        add: function () {
            $scope.scheduler = schedulersDataSource.get();
            $scope.$apply();
            $scope.schedulerWindow.center().open();
        },
        edit: function() {
            var data = selectedTaskGridRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для редагування' });
            } else {
                $scope.scheduler = schedulersDataSource.get();
                
                schedulersDataSource.get(data.Id, function () { /*$scope.$apply();*/ });
                $scope.schedulerWindow.center().open();
            }
        },
        remove:function() {
            var data = selectedTaskGridRow();
            if (!data) {
                bars.ui.error({ text: 'Не вибрано жодного рядка для видалення' });
            } else {
                bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити завдання №' + data.Id },
                    function () {
                        tasksDataSource.remove(data.Id, function() {
                            bars.ui.notify('Завдання № ' + data.Id + ' видалено', '', 'success');
                            $scope.tasksGrid.dataSource.read();
                            $scope.tasksGrid.refresh();
                        });
                    });
            }
        }
    };

    $scope.showSql = function (text) {
        var row = $scope.tasksGrid.dataSource.get(text);
        bars.ui.alert({ text: '<pre>' + row.JobSql + '</pre>', title: 'SQL',width:'500px',height:'300px' });
    }
    $scope.showErrorMessage = function(id) {
        var row = $scope.tasksGrid.dataSource.get(id);
        bars.ui.alert({ text: '<pre>' + row.ErrorMessage + '</pre>', title: 'Текст помилки', width: '500px', height: '300px' });
    }
    var getStatusTemplate = function (status) {
        var className = '';
        switch (status) {
            case 'RUNNING':
                className = 'success';
                break;
            case 'ERROR':
                className = 'error';
                break;
            default:
                className = 'warning';
                break;
        }
        return '<div class="k-block k-'+ className +'-colored text-center">'+ status+'</div>';
    }


    var enableToolbarButtons = function (type, data) {
        $scope.tasksToolbar.enable('#stopTaskBtn', type);
    }

    $scope.tasksGridOptions = {
        sortable: true,
        filterable: true,
        resizable: true,
        selectable: "single",
        height: 100,
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
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
            enableToolbarButtons(true, selectedTaskGridRow());
        },
        dataSource: {
            type:'odata',
            //type: 'webapi',
            transport: {
                read: {
                    url: tasksDataSource.url,
                    dataType: 'json'
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                //errors: "Errors",
                model: {
                    id: "Id",
                    fields: {
                        Id: { type: 'number' },
                        SchedulerId: { type: 'number' },
                        JobName: { type: 'string' },
                        JobSql: { type: 'string' },
                        StartDate: { type: 'date' },
                        EndDate: { type: 'date' },
                        DbmshpRunId: { type: 'number' },
                        ExclusionMode: { type: 'string' },
                        State: { type: 'string' },
                        ErrorMessage: { type: 'string' },
                        UserId: { type: 'number' },
                        ProgressPercent: { type: 'number' },
                        ProgressText: { type: 'string' } 
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true,
            serverGrouping: true,
            serverAggregates: true
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
                field: "State",
                title: "Статус",
                /*template: '<div class="k-block k-#= getStatusColor(State)#-colored centerField">#= State #</div>',*/
                template: function (dataItem) {

                    return getStatusTemplate(dataItem.State);
                },
                width: "100px"
            },{
                field: "UserId",
                title: "Користувач",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            min: 0,
                            format: "n0"
                        });
                    }
                },
                width: "100px"
            },{
                field: "SchedulerId",
                title: "Код задачі",
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            min: 0,
                            format: "n0"
                        });
                    }
                },
                width: "120px"
            }, {
                field: "JobName",
                title: "JOB",
                width: "120px"
            }, {
                field: "JobSql",
                title: "Sql запит",
                width: "100px",
                template: '<button ng-click=\"showSql(#=Id#);\" class=k-button>показати</button>'
            }, {
                field: "StartDate",
                title: "Дата початку",
                width: "120px",
                format: '{0:dd.MM.yyyy HH:mm}',
                filterable: {
                    ui: function (element) {
                        element.kendoDateTimePicker({});
                    }
                }
            }, {
                field: "EndDate",
                title: "дата закінчення",
                width: "120px",
                format: '{0:dd.MM.yyyy HH:mm}',
                filterable: {
                    ui: function (element) {
                        element.kendoDateTimePicker({});
                    }
                }
            },{
                field: "ExclusionMode",
                title: "Режим запуску",
                width: "120px"
            }, {
                field: "ErrorMessage",
                title: "текст помилки",
                template: '<button ng-click=\"showErrorMessage(#=Id#);\" style="display:#= ErrorMessage? \'block\' : \'none\' #" class=k-button>показати</button>',
                width: "100px"
            }, {
                field: "ProgressPercent",
                title: "прогрес",
                width: "200px",
                template: '<div class="progress" style="display:#= ProgressPercent? \'block\' : \'none\' #">\
                              <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow=\" #=ProgressPercent# \" \
                              aria-valuemin="0" aria-valuemax="100" style="width:#=ProgressPercent#%">\
                                  #=ProgressPercent#  % \
                              </div>\
                            </div>'
            }, {
                field: "ProgressText",
                title: "дія",
                width: "200px"                
            }
        ]
    };

}]);