angular.module('BarsWeb.Controllers').controller('Reporting.Nbu', ['$scope', '$http', function ($scope, $http) {
//ReportingModule.controller('NbuCtrl', function ($scope, $http) {
    $scope.Title = 'Звітність НБУ';
    $scope.apiUrl = bars.config.urlContent('/api/reporting/nbu/');

    $scope.dateOptions = {
        format: '{0:dd/MM/yyyy}',
        change: function () {
            if ($scope.report.id != null) {
                $scope.reportGrid.dataSource.read();
                $scope.reportGrid.refresh();
            }
        }
    };

    var date = new Date();

    $scope.report = {
        id: null,
        name: null,
        date: (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
            '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
            '/'+ date.getFullYear(),
        type: null,
        procc: null,
        proccName: '',
        procSemantic:''
    };

    $scope.toolbarReportOptions = {
        items: [
            {
                template: '<label>Дата: </label><input type="text" ng-model="report.date" kendo-date-picker="" k-options="dateOptions" />'
            }, {
                type: 'separator'
            },{
                template: '<label>Звіт: </label>' +
                    '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.id" style="width:40px" />' +
                    '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.name" style="width:200px" />'
            },{
                template: '<a class="k-button ng-scope" ng-click="showReportNbuHandBook()" ><i class="pf-icon pf-16 pf-book"></i></a>'

                /*type: "button",
                text: '<i class="pf-icon pf-16 pf-book"></i>',
                title: 'Довідник',
                click: function () {
                    $scope.getReportGridColumns();
                }*/
            },
            { type: 'separator' },
            {
                template: '<label ><input type="checkbox" data-ng-model="adversitingGridOptions.showNotActive" /> консолідований</label>'
            }
        ]
    };

    $scope.toolbarReportGridOptions = {
        items: [
            {
                type: "button",
                text: '<i class="pf-icon pf-16 pf-gears" title="Запустити формування даних для файла"></i>',
                title: 'Start',
                click: function () {
                    confirmGenerateReport();
                }
            },

            { type: 'separator' },

            {
                type: "buttonGroup",
                buttons: [
                    {
                        spriteCssClass: "pf-icon pf-16 pf-database-import",
                        text: "Вибрати з архіву",
                        toolTip:'tets',
                        showText: "overflow",
                        click: function() {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-database-arrow_right",
                        text: "Зберегти в архів",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    }
                ]
            },

            { type: 'separator' },

            {
                type: "buttonGroup",
                buttons: [
                    {
                        spriteCssClass: "pf-icon pf-16 pf-table_row-add2",
                        text: "Додати рядок",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-table_row-delete2",
                        text: "Видалити рядок",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-icon pf-16 pf-save",
                        text: "Зберегти",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    }
                ]
            },

            { type: 'separator' },

            {
                type: "buttonGroup",
                buttons: [
                    {
                        spriteCssClass: "pf-icon pf-16 pf-print",
                        text: "Роздрукувати",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-arrow_download",
                        text: "Сформувати файл",
                        showText: "overflow",
                        click: function () {
                            $scope.showAdd();
                        }
                    }
                ]
            },

            { type: 'separator' },

            {
                type: "buttonGroup",
                buttons: [
                    {
                        spriteCssClass: "pf-icon pf-16 pf-report_open",
                        text: "Переглянути протокол",
                        showText: "overflow",
                        click: function() {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-tree",
                        text: "Переглянути контрольні точки",
                        showText: "overflow",
                        click: function() {
                            $scope.showAdd();
                        }
                    },
                    {
                        spriteCssClass: "pf-icon pf-16 pf-document_header_footer-ok2",
                        text: "Контроль",
                        showText: "overflow",
                        click: function() {
                            $scope.showAdd();
                        }
                    }
                ]
            }
        ]
    };

    var confirmGenerateReport = function() {
        if ($scope.report.id == null) {
            bars.ui.error({ text: 'Невибрано файл для формувавння.' });
        } else {
            if ($scope.report.proccName.replace(/^\s+|\s+$/g, '') == '') {
                //ручне формування
            } else {
                // перевіримо чи звіт уже формувася
                if ($scope.reportGrid.dataSource.data().length > 0) {
                    bars.ui.confirm({
                        text: String.format('Увага!<br> Звіт "{0}" за {1} вже був сформований.<br> Переформувати звіт?',
                                            $scope.report.id,
                                            $scope.report.date),
                        func: function() {}
                    });
                } else {
                    bars.ui.confirm({
                        text: String.format('Запустити формування звіту "{0}" за {1} ?',
                                            $scope.report.id,
                                            $scope.report.date),
                        func: function() {
                            startGenerateReport($scope.report.id, $scope.report.date);
                        }
                    });
                }
            }
        }
    }

    var startGenerateReport = function (id, reportDate) {
        var data = {
            code: id,
            date:reportDate
        };
        $http.put($scope.apiUrl+'?code='+$scope.report.id+'&date='+$scope.report.date)
            .success(function (request) {
                bars.ui.notify(/*'Оголошення створено. № ' + request.TaskId*/'', 'Test test ' +  request.TaskId, 'success');
            });
    }

    $scope.showReportNbuHandBook = function () {
        bars.ui.handBook('V_KL_F00', function(data) {
            if (data.length != null) {
                $scope.report.id = data[0].KODF;
                $scope.report.name = data[0].SEMANTIC;
                $scope.report.procc = data[0].PROCC;
                $scope.report.proccName = data[0].PROCC_NAME;
                $scope.report.proccSemantic = data[0].PROCC_SEMANTIC;
                $scope.$apply();
                rebindReportGrid(data[0].KODF);
            }
        });
    };


    $scope.selectedType = "";
    $scope.reportGridOptions = {};

    var rebindReportGrid = function(id) {
        getReportGridColumns(id);
    };

    var getReportGridColumns = function (id) {
        $http.get(bars.config.urlContent('/reporting/nbu/getstructure/') + id)
            .then(function (request) {
                $scope.reportGridOptions.dataSource.transport.read.url= bars.config.urlContent('/api/reporting/nbu/') ;
                $scope.reportGridOptions.columns = request.data.columns;
                $scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
        });
    };

    $scope.reportGridColumns = [];

    var reportGridDataBound = function (e) {
        var grid = e.sender;
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper).find('tbody')
                .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + grid.pager.options.messages.empty + ' :(</td></tr>');
        }
    };

    $scope.reportGridOptions = {
        //autoBind: false,
        dataSource: {
            type: 'webapi',
            /*sort: {
                field: "Id",
                dir: "desc"
            },*/
            transport: {
                read: {
                    //url: bars.config.urlContent('/api/reporting/nbu/') ,
                    dataType: 'json',
                    data: {
                        id: function() {
                             return $scope.report.id;
                        },
                        date: function() {
                            return $scope.report.date;
                        }// '16/01/2015'
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    fields: {
                        /*Id: { type: 'number' },
                        Name: { type: 'string' },
                        DateBegin: { type: 'date' },
                        DateEnd: { type: 'date' },
                        DataBodyHtml: { type: 'string' },
                        IsActive: { type: 'string' },
                        Description: { type: 'string' },
                        UserId: { type: 'string' },
                        Branch: { type: 'string' },
                        TransactionCodeList: { type: 'string' },
                        IsDefault: { type: 'string' },
                        Kf: { type: 'string' }*/
                    }
                }
            },
            pageSize: 10,
            serverPaging: true,
            serverSorting: true
        },
        dataBound: reportGridDataBound,
        sortable: true,
        filterable: true,
        selectable: "multiple",
        pageable: {
            refresh: true,
            pageSizes: [10,20,50,100],
            buttonCount: 5
        },
        columns: [
            /*{
                field: "Id",
                title: "ID",
                width: "70px"
            }, {
                field: "Name",
                title: "Назва",
                width: "120px"
            }, {
                field: "DateBegin",
                title: 'Початок дії',
                headerTemplate: '<div title="Початок дії">Початок дії</div>',
                format: '{0:dd/MM/yyyy}',
                width: "120px"
            }, {
                field: "DateEnd",
                title: "Кінець дії",
                format: '{0:dd/MM/yyyy}',
                width: "120px"
            }, {
                field: "IsActive",
                title: "Пр. активності",
                width: "120px",
                template: '<input type="checkbox" #= (IsActive == "Y") ? "checked=checked" : "" # disabled="disabled" >'
            }, {
                field: "Branch",
                title: "Відділення",
                width: "150px"
            }, {
                field: "TransactionCodeList",
                title: "Список операцій",
                width: "120px"
            }, {
                field: "IsDefault",
                title: "Пр. рек. по замовч.",
                width: "120px",
                template: '<input type="checkbox" #= (IsDefault == "Y") ? "checked=checked" : "" # disabled="disabled" >'
            }*/
        ]
    };


}]);