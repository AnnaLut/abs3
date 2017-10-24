angular.module(globalSettings.modulesAreas)
    .controller('IOData.dailyTasks', ['$scope', '$http',
        function ($scope, $http) {
            'use strict'
            var vm = this;
            vm.userName = "BARSUPL";
            vm.changeJobStatus = function () {
                if (vm.selectedJob === undefined) {
                    return;
                }
                $http({
                    url: bars.config.urlContent('/api/iodata/statistic/ChangeJobState'),
                    method: 'get',
                    params: {
                        JobName: vm.selectedJob.JobName,
                        JobEnabled: vm.selectedJob.Enabled
                    }

                }).success(function (response) {
                    vm.refreshGridData();
                })
            }

            vm.refreshGridData = function () {
                vm.existingJobsGrid.dataSource.read();
            }

            vm.showAddJobWindow = function () {
                vm.enableJobsGrid.dataSource.read();
                vm.enableJobsWindow.center().open();
            }

            vm.showEditParamsWindow = function () {
                if (vm.selectedJob === undefined) {
                    return;
                }
                vm.jobParamsGrid.dataSource.read();
                vm.editParamsWindow.center().open();
                vm.editParamsWindow.setOptions({ title: 'Параметри для завдання ' + vm.selectedJob.JobName });
            }
            vm.showAvailableJobParamsWindow = function () {
                if (vm.selectedJob === undefined) {
                    return;
                }
                vm.availableJobParamsGrid.dataSource.read();
                vm.availableJobParamsWindow.center().open();
                vm.availableJobParamsWindow.setOptions({ title: 'Доступні параметри для завдання ' + vm.selectedJob.JobName });
            }

            vm.addNewJobFromEnabled = function (dataItem) {

                vm.recreateJob(dataItem.JobName);
                vm.enableJobsGrid.dataSource.data([]);
                vm.enableJobsGrid.refresh();
                vm.enableJobsWindow.close();
            }

            vm.addNewParamFromDefaults = function (dataItem) {

                vm.jobParamsGrid.addRow();
                var cratedItem = vm.jobParamsGrid.dataItem("tr:eq(1)");
                cratedItem.ParamName = dataItem.ParamName;
                cratedItem.Value = dataItem.Value;
                cratedItem.Description = dataItem.Description;

                vm.availableJobParamsWindow.close();
            }

            vm.recreateJob = function (jobName) {
                $http({
                    url: bars.config.urlContent('/api/iodata/statistic/RecreateJob'),
                    method: 'get',
                    params: {
                        JobName: jobName
                    }
                }).success(function (response) {
                    vm.refreshGridData();
                    bars.ui.alert({ text: response.Message })
                })
            }

            vm.showInfo = function (dataItem) {
                bars.ui.alert({title:dataItem.JobName, text:'<p  style="white-space: pre-line;">'+dataItem.MessInfo+'</p>'})
            }
            vm.mainToolbarOptions = {
                resizable: false,
                items: [
                    {
                        type: 'button',
                        id: 'addJobButton',
                        text: '<i class="pf-icon pf-16 pf-add_button"></i> Додати нове завдання',
                        click: function () {
                            vm.showAddJobWindow();
                        }
                    },
                    { type: 'separator' },
                    {
                        type: 'button',
                        id: 'tackOptionButton',
                        text: '<i class="pf-icon pf-16 pf-tool_pencil"></i> Параметри',
                        click: function () {
                            vm.showEditParamsWindow();
                        }
                    },
                    {
                        type: 'button',
                        id: 'startStopButton',
                        icon: "pf-icon pf-16 pf-gear",
                        click: function (e) {
                            vm.changeJobStatus();
                        },
                        attributes: { "ng-style": "{'background-color':dailyTasks.selectedJob.Enabled == 'TRUE' ?  'lawnGreen': 'red'}" }

                    },
                    { type: 'separator' },
                    {
                        template: '<ul style="list-style: none"><li>Завдання: {{dailyTasks.selectedJob.JobName}}</li> <li>Статус: {{dailyTasks.selectedJob.State}}</li> <li>Код виконання: {{dailyTasks.selectedJob.JobAction}}</li></ul>'
                    }
                ]
            };


            vm.existingJobsGridOptions = {
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                height: '300',
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/iodata/statistic/getjobs'),
                            dataType: 'json'
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'JobName',
                            fields: {
                                JobName: { type: 'string' },
                                State: { type: 'string' },
                                Enabled: { type: 'string' },
                                LastStartDate: { type: 'date' },
                                NextRunDate: { type: 'date' },
                                Description: { type: 'string' },
                                JobAction: { type: 'string' }
                            }

                        }
                    }
                },
                dataBound: function (e) {
                    var grid = this;
                    if (vm.selectedJob == undefined) {
                        grid.tbody.find('>tr:first').addClass('k-state-selected');
                    }
                    else {
                        $.each(grid.tbody.find('tr'), function () {
                            var model = grid.dataItem(this);
                            if (model.JobName == vm.selectedJob.JobName) {
                                $('[data-uid=' + model.uid + ']').addClass('k-state-selected');
                                return;
                            }
                        });
                    }
                    $scope.$apply(function () {
                        vm.selectedJob = vm.existingJobsGrid.dataItem(vm.existingJobsGrid.select());
                    });

                },
                change: function () {
                    $scope.$apply(function () {
                        vm.selectedJob = vm.existingJobsGrid.dataItem(vm.existingJobsGrid.select());
                    });
                },
                columns: [
                    {
                        field: 'JobName',
                        title: 'Назва',
                        width: '120'
                    },
                    {
                        field: 'State',
                        title: 'Статус',
                        width: '65'
                    },
                    {
                        field: 'Enabled',
                        title: 'Стан',
                        width: '45'
                    },
                    {
                        field: 'LastStartDate',
                        title: 'Остання<br>дата запуску',
                        width: '60',
                        format: "{0:dd/MM/yyyy HH:mm:ss}"
                    },
                    {
                        field: 'NextRunDate',
                        title: 'Наступна<br>дата запуску',
                        width: '60',
                        format: "{0:dd/MM/yyyy HH:mm:ss}"
                    },
                    {
                        field: 'Description',
                        title: 'Опис',
                        width: '120'
                    },
                    {
                        field: 'JobAction',
                        title: 'Код виконання',
                        width: '*'
                    }
                ]
            };

            vm.jobsStatisticGridOptions = {
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                height: '300',
                pageable: {
                    pageSizes: false,
                    info: false,
                    numeric: false,
                    previousNext: false,
                    refresh: true,
                },
                dataBound: function (e) {
                    var grid = this;
                    grid.tbody.find("tr").dblclick(function (e) {
                        var dataItem = grid.dataItem(this);
                        vm.showInfo(dataItem);
                    });
                },
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/iodata/statistic/GetLogRecords'),
                            dataType: 'json'
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'LogId',
                            fields: {
                                LogId: { type: 'number' },
                                LogDate: { type: 'date' },
                                JobName: { type: 'string' },
                                Status: { type: 'string' },
                                ActualStartDate: { type: 'date' },
                                RunDuration: { type: 'number' },
                                Info: { type: 'string' },
                                MessInfo: {type: 'string'}
                            }
                        }
                    }
                },
                columns: [
                   {
                       field: 'LogId',
                       title: '№пп',
                       width: '60'
                   },
                   {
                       field: 'LogDate',
                       title: 'Дата запису',
                       width: '120',
                       format: "{0:dd/MM/yyyy HH:mm:ss}"
                   },
                   {
                       field: 'JobName',
                       title: 'Назва',
                       width: '200'
                   },
                   {
                       field: 'Status',
                       title: 'Статус',
                       width: '160'
                   },
                   {
                       field: 'ActualStartDate',
                       title: 'Дата запуску',
                       width: '120',
                       format: "{0:dd/MM/yyyy HH:mm:ss}"
                   },
                   {
                       field: 'RunDuration',
                       title: 'Тривалість<br>(хв)',
                       width: '120'
                   },
                   {
                       field: 'Info',
                       title: 'Інформація',
                       width: '250'
                   }
                ]
            };


            vm.jobParamsGridOptions = {
                autoBind: false,
                selectable: 'single',
                pageable: {
                    pageSizes: false,
                    info: false,
                    numeric: false,
                    previousNext: false,
                    refresh: true,
                },
                dataSource: {
                    transport: {
                        read: {
                            dataType: "json",
                            url: bars.config.urlContent("/api/iodata/statistic/getJobParams"),
                            data: function () {
                                return { jobName: vm.selectedJob.JobName };
                            }
                        },
                        update: {
                            dataType: "json",
                            type: "POST",
                            url: bars.config.urlContent("/api/iodata/statistic/UpdateJobParams")
                        },
                        destroy: {
                            dataType: "json",
                            type: "POST",
                            url: bars.config.urlContent("/api/iodata/statistic/deleteJobParams")
                        },
                        create: {
                            dataType: "json",
                            type: "POST",
                            url: bars.config.urlContent("/api/iodata/statistic/insertJobParams")
                        },
                        parameterMap: function (data, operation) {
                            if (operation === "update" || operation === "create" || operation === "destroy") {
                                return { jobName: vm.selectedJob.JobName, jobParams: (data.models) };
                            }
                            return data;
                        }
                    },
                    batch: true,
                    schema: {
                        data: "Data",
                        model: {
                            id: "ParamName",
                            fields: {
                                ParamName: { editable: false, validation: { required: true } },
                                Value: {},
                                Description: { editable: false, validation: { required: true } }
                            }
                        }
                    }
                },
                toolbar: [
                    { template: '<button data-ng-click=\'dailyTasks.showAvailableJobParamsWindow()\' class=\'k-button\'><i class="pf-icon pf-16 pf-add"></i>Додати новий параметр</button>' },
                    { name: "save", text: "Зберегти зміни" },
                    { name: "cancel", text: "Відмінити зміни" },
                    { template: '<button data-ng-click=\'dailyTasks.recreateJob(dailyTasks.selectedJob.JobName)\' class=\'k-button\'><i class="pf-icon pf-16 pf-reload_rotate"></i>Перестворити завдання</button>' }
                ],
                scrollable: true,
                columns: [
                    { field: "ParamName", title: "Параметр", width: 150 },
                    { field: "Value", title: "Значення", width: 200 },
                    { field: "Description", title: "Опис" },
                    { command: "destroy", title: "&nbsp;", width: 105 }
                ],
                editable: true
            }

            vm.availableJobParamsGridOptions = {
                autoBind: false,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                dataSource: {
                    transport: {
                        read: {
                            dataType: "json",
                            url: bars.config.urlContent("/api/iodata/statistic/getAvailableJobParams"),
                            data: function () {
                                return { jobName: vm.selectedJob.JobName };
                            }
                        }
                    },
                    schema: {
                        data: "Data",
                        model: {
                            fields: {
                                ParamName: { type: 'string' },
                                Value: { type: 'string' },
                                Description: { type: 'string' }
                            }
                        }
                    }
                },
                dataBound: function (e) {
                    var grid = this;
                    grid.tbody.find("tr").dblclick(function (e) {
                        var dataItem = grid.dataItem(this);
                        vm.addNewParamFromDefaults(dataItem);
                    });
                },
                columns: [
                    { field: "ParamName", title: "Параметр", width: 150 },
                    { field: "Value", title: "Значення", width: 200 },
                    { field: "Description", title: "Опис" }
                ]
            };

            vm.enableJobsGridOptions = {
                autoBind: false,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                height: '300',
                dataSource: {
                    type: 'webapi',
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/iodata/statistic/GetEnabledjobs'),
                            dataType: 'json'
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'JobName',
                            fields: {
                                JobName: { type: 'string' },
                                Description: { type: 'string' },
                                IsActive: { type: 'number' }
                            }
                        }
                    }
                },
                dataBound: function (e) {
                    var grid = this;
                    grid.tbody.find("tr").dblclick(function (e) {
                        var dataItem = grid.dataItem(this);
                        vm.addNewJobFromEnabled(dataItem);
                    });
                },
                columns: [
                   {
                       field: 'JobName',
                       title: 'Назва завдання',
                       width: '140'
                   },
                   {
                       field: 'Description',
                       title: 'Опис завдання',
                       width: '150'
                   },
                   {
                       field: 'IsActive',
                       title: 'Активність',
                       width: '60'
                   }
                ]
            };
        }])