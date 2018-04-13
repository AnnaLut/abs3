angular.module('BarsWeb.Controllers').controller('Async.Tasks', ['$scope', '$http', function ($scope, $http) {
    $scope.Title = 'Перегляд запущених задач';
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
            {
                template: '<label ><input type="radio" data-ng-model="adversitingGridOptions.showNotActive" /> показувати неактивні</label>'
            },
            { type: "separator" },


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
                type: "button",
                text: '<i class="pf-icon pf-16 pf-delete_button_error"></i>Зупинити',
                click: function () {
                    toolbarWindows.remove();
                }
            }
        ]
    };

    var selectedRow = function () {
        return $scope.tasksGrid.dataItem($scope.tasksGrid.select());
    };


    $scope.toolbarWindows = {
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

    $scope.tasksGridOptions = {
        toolbar:[
        {
            template:'<button class="k-button" ng-click="toolbarWindows.remove()"><i class="pf-icon pf-16 pf-delete_button_error"></i> Зупинити</button>',
            type: 'button',
            name: "Stop"//,
            //id: "button1",
            //text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Зупинити',
            /*click: function (e) {
                alert();
                toolbarWindows.remove();
            }*/
        }],
        sortable: true,
        filterable: true,
        resizable: true,
        selectable: "multiple",
        pageable: {
            refresh: true,
            pageSizes: true,
            buttonCount: 5
        },
        dataSource: {
            type: 'webapi',
            transport: {
                read: {
                    url: tasksDataSource.url,
                    dataType: 'json'
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
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
                        UserId:{ type: 'number' }
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true
        },
        columns: [
            {
                field: "Id",
                title: "ID",
                width: "70px"
            }, {
                field: "State",
                title: "Статус",
                width: "100px"
            },{
                field: "UserId",
                title: "Користувач",
                width: "100px"
            },{
                field: "SchedulerId",
                title: "Код задачі",
                width: "120px"
            }, {
                field: "JobName",
                title: "JOB",
                width: "120px"
            }, {
                field: "JobSql",
                title: "Sql запит",
                width: "100px",
                template: '<button ng-click=\"showSql(#=Id#)\"; class=k-button>показати</button>'
            }, {
                field: "StartDate",
                title: "Дата початку",
                width: "120px",
                format: '{0:dd/MM/yyyy HH:mm}'
            }, {
                field: "EndDate",
                title: "дата закінчення",
                width: "120px",
                format: '{0:dd/MM/yyyy HH:mm}'
            },{
                field: "ExclusionMode",
                title: "Режим запуску",
                width: "120px",
            }, {
                field: "ErrorMessage",
                title: "текст помилки",
                width: "200px"
            }
        ]
    };

}]);