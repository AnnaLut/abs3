angular.module('BarsWeb.Controllers', ['kendo.directives'])
    .controller('IOData.Job', ['$scope', '$http', function ($scope, $http) {

        $scope.isJobSelect = false;

        $scope.jobsDataSource = {
            type: "webapi",
            transport: {
                read: {
                    type: "GET",
                    dataType: "json",
                    url: bars.config.urlContent("/api/iodata/job/getjobs")
                }
            },
            schema: {
                data: function (result) {
                    return result.Data || (function () { return bars.ui.error({ text: 'Помилка:<br/>' + result.Msg }); })();
                }
            }
        };
        $scope.filesDataSource = {
            type: "webapi",
            transport: {
                read: {
                    dataType: "json",
                    url: bars.config.urlContent("/api/iodata/files/GetFiles"),
                    data: function () {
                        return { jobName: $scope.JobObject.JobName.JobName };
                    }
                }
            },
            schema: {
                data: function (result) {
                    return result.Data || (function () { return bars.ui.error({ text: 'Помилка:<br/>' + result.Msg }); })();
                }
            }
        };

        $scope.JobObject = {
            JobDate: new Date()
        };

        $scope.jobOptions = {
            optionLabel: "Оберіть потрібне значення...",
            select: function (e) {
                var item = e.item;
                var val = item.val();
                $scope.isJobSelect = val !== '' ? true : false;
            },
            change: function (e) {
                $scope.filesDropDown.dataSource.read();
                $scope.filesDropDown.refresh();
            }
        };

        $scope.filesOptions = {
            autoBind: false,
            optionLabel: "Оберіть потрібне значення..."            
        };

        $scope.JobRemove = function (job) {

            // IE 8 doesnt like > $http.delete(bars.config.urlContent("/api/iodata/job/delete"), JSON.stringify(job));

            //var jobRemoveService = $http({
            //    method: 'GET',
            //    url: bars.config.urlContent("/api/iodata/job/delete"),
            //    //contentType: "application/json; charset=utf-8",
            //    data: job
            //});

            var jobRemoveService = $http.post(bars.config.urlContent("/api/iodata/job/delete"), JSON.stringify(job));

            bars.ui.loader('body', true);

            jobRemoveService.success(function (result) {
                if (result.Data !== 0) {
                    bars.ui.loader('body', false);
                    //bars.ui.alert({ text: result.Message });
                    bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                    refresh();
                } else {
                    bars.ui.loader('body', false);
                    bars.ui.error({ text: 'Помилка : ' + result.Message });
                    //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                }
            });
        };

        $scope.jobCheckResult = function (res, job) {
            if (res.ErrCode && res.ErrCode !== '0000') {
                if (res.ErrCode === '0028') {
                    bars.ui.confirm({
                        text: 'Увага! Вивантаження даних знаходиться в стадії роботи!' +
                        'Якщо статус поточного вивантаження втановлено помилково можна видалиті дану фнформацію. Видалити?'
                    },
                    function () {
                        $scope.JobRemove(job);
                    });
                } else {
                    bars.ui.confirm({
                        text: 'Увага! Вивантаження даних за дану дату вже було проведено!' +
                         'Якщо потрібно повторити вивантаження, потрібно видалити попередній статус. Видалити?'
                    },
                     function () {
                         $scope.JobRemove(job);
                     });
                }
            } else {
                var jobUpdateService = $http.put(bars.config.urlContent("/api/iodata/job/put"), JSON.stringify(job));
                bars.ui.loader('body', true);
                jobUpdateService.success(function (result) {
                    if (result.Data !== 0) {
                        bars.ui.loader('body', false);
                        //bars.ui.alert({ text: result.Message });
                        bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                        refresh();
                    } else {
                        bars.ui.loader('body', false);
                        bars.ui.error({ text: 'Помилка : ' + result.Message });
                        //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                    }
                });
            }
        };

        $scope.jobSubmit = function () {
            if ($scope.oneFileChecked) {
                oneFileUpload();
                return;
            }
            bars.ui.loader('body', true);
            var job = {
                JobName: $scope.JobObject.JobName.JobName,
                JobDate: $scope.JobObject.JobDate
            };
            var jobCheckService = $http.post(bars.config.urlContent("/api/iodata/job/post"), JSON.stringify(job));
            jobCheckService.success(function (result) {
                if (result.Data !== 0) {
                    bars.ui.loader('body', false);
                    $scope.jobCheckResult(result.Data, job);
                } else {
                    bars.ui.loader('body', false);
                    bars.ui.error({ text: 'Помилка : ' + result.Message });
                    //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                }
            });

            function oneFileUpload() {
                if (typeof $scope.FileObject === undefined || $scope.FileObject.FileCode === "") {
                    bars.ui.alert({ text: " Оберіть файл для вивантаження! " });
                    return;
                }
                bars.ui.loader('body', true);
                var dataobject = {
                    jobName: $scope.JobObject.JobName.JobName,
                    jobDate: $scope.JobObject.JobDate,
                    fileCode: $scope.FileObject.FileCode
                };
                var fileUploadService = $http.post(bars.config.urlContent("/api/iodata/files/upload"), dataobject);
                fileUploadService.success(function (result) {
                    if (result.Data !== 0) {
                        bars.ui.loader('body', false);
                        bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                        refresh();
                    } else {
                        bars.ui.loader('body', false);
                        bars.ui.error({ text: 'Помилка : ' + result.Message });
                    }
                });
            }            
        };
        function refresh() {
            $scope.JobObject = {
                JobDate: new Date()
            };
            $scope.isJobSelect = false;
            $scope.oneFileChecked = false;
            $scope.FileObject = {};
        }

    }]);