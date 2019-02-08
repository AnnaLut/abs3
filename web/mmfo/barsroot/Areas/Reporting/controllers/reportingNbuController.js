angular.module(globalSettings.modulesAreas)
    .controller('Reporting.Nbu', ['$scope', '$http', 'reportingNbuService', 'base64Helper', '$timeout',
        function ($scope, $http, reportingNbuService, base64Helper, $timeout) {
            //ReportingModule.controller('NbuCtrl', function ($scope, $http) {

            $scope.ChkLogText = "";

            $scope.loading = false;
            $scope.detailedReportWindowOpened = false;

            var PAGEABLE = {
                previousNext: true,
                refresh: true,
                pageSizes: [10, 20, 50, 100, 1000],
                buttonCount: 3,
                messages: {
                    itemsPerPage: ''
                }
            };
            $scope.isRowDetailed = false;

            $scope.fillReport = function (data, versionId, isGetFileInfo, isApply) {
                if (data && data.length > 0) {
                    $scope.report.id = data[0].FILE_ID;
                    $scope.report.name = data[0].FILE_NAME;
                    $scope.report.SCHEME_CODE = data[0].SCHEME_CODE;
                    $scope.report.FILE_CODE = data[0].FILE_CODE;
                    $scope.report.PERIOD = data[0].PERIOD;
                    $scope.report.KF = data[0].KF;
                    $scope.report.FILE_TYPE = data[0].FILE_TYPE;
                    $scope.report.FILE_FMT_LIST = data[0].FILE_FMT_LIST ? data[0].FILE_FMT_LIST.split(",") : "";
                    $scope.FileCodeBase64 = base64Helper.encode($scope.report.FILE_CODE);
                    $("#currentBase64page").text($scope.FileCodeBase64);
                    if (isApply) {
                        $scope.$apply();
                    }

                    if (isGetFileInfo) {
                        getFileInfo($scope.FileCodeBase64, $scope.report.date, $scope.report.KF, $scope.report.SCHEME_CODE, versionId);
                    }
                }
            };

            $(document).ready(function () {
                var _ID = bars.extension.getParamFromUrl('id');
                var _DATE = bars.extension.getParamFromUrl('date');
                var _KF = bars.extension.getParamFromUrl('kf');
                var _VERSION_ID = bars.extension.getParamFromUrl('versionId');
                // console.log("_ID="+_ID+" _DATE="+_DATE+" _KF="+_KF + " _VERSION_ID="+_VERSION_ID);
                if (_ID != null && _ID != "" && _DATE != null && _DATE != "" && _KF != null && _KF != "") {
                    $scope.report.date = _DATE;

                    $http.get(bars.config.urlContent('/reporting/nbu/fileInitialInfo?id=' + _ID + "&kf=" + _KF)).
                        success(function (data) {
                            var versionId = _VERSION_ID != "" ? _VERSION_ID : null;
                            $scope.fillReport(data, versionId, true, false);
                        }).
                        error(function () {

                        });
                }
            });

            $scope.Title = 'Звітність НБУ';
            $scope.apiUrl = bars.config.urlContent('/api/reporting/nbu/');

            var date = new Date();

            $scope.report = {
                id: null,
                name: null,
                date: (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) +
                    '/' + ((parseInt(date.getMonth(), 10) + 1) < 9 ? '0' + (parseInt(date.getMonth(), 10) + 1) : (parseInt(date.getMonth(), 10) + 1)) +
                    '/' + date.getFullYear(),
                type: null,
                procc: null,
                proccName: '',
                procSemantic: ''
            };

            $scope.$watch(
                'report.id',
                function handleFooChange(newValue) {
                    var toolBar = $scope.appToolbarReportGridOptions;
                    if (newValue) {
                        toolBar.enable('#GenRapBtn', true);
                        toolBar.enable('#GetArchBtn', true);
                    } else {
                        toolBar.enable('#GenRapBtn', false);
                        toolBar.enable('#GetArchBtn', false);
                    }
                });

            $scope.toolbarReportOptions = {
                items: [
                    {
                        template: '<label>Дата: </label><input type="text" ng-model="report.date" kendo-masked-date-picker="" k-options="dateOptions" />'
                    }, {
                        type: 'separator'
                    }, {
                        template: '<label>Звіт: </label>' +
                            '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.FILE_CODE" style="width:40px" />' +
                            '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.name" style="width:200px" />'
                    }, {
                        //template: '<a class="k-button ng-scope" ng-click="showReportNbuHandBook()" ><i class="pf-icon pf-16 pf-book"></i></a>'

                        type: 'button',
                        text: '<i title="Довідник доступних файлів" class="pf-icon pf-16 pf-book"></i>',
                        title: 'Довідник доступних файлів',
                        click: function () {
                            $scope.showReportNbuHandBook();
                        }
                    },
                    { type: 'separator' },
                    {
                        type: 'button',
                        text: '<i title="Оновити дані" class="pf-icon pf-16 pf-reload_rotate"></i>',
                        title: 'Оновити дані',
                        click: function () {
                            if ($scope.report.id != null) {
                                //$scope.onChangeGridType();
                                getFileInfo($scope.FileCodeBase64, $scope.report.date, $scope.report.KF, $scope.report.SCHEME_CODE, null);
                            }
                            else { bars.ui.error({ text: 'Невибрано файл для формувавння.' }); }
                        }
                    }
                    //,
                    //{ type: 'separator' },
                    //{
                    //    // <input type="checkbox" data-ng-model="reportGridOptions.showConsolidate" /> ng-change="change()"
                    //    template: '<label > <input type="checkbox"  ng-model="isConsolidate.value"  ng-true-value="1" ng-false-value="0" ng-change="onChangeGridType()"> консолідований </label>'
                    //}
                ]
            };

            var startGenerateReport = function (reportDate, fileCodeBase64, schemeCode, fileType, kf) {
                bars.ui.loader('body', true);
                reportingNbuService.startGenerateReport(reportDate, fileCodeBase64, schemeCode, fileType, kf).then(
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Повідомлення', response.reponseMessage, 'success');
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка', 'Сталась помилка при виконанні операції', 'error');
                        // console.log(response);
                    }
                );
            }
            var confirmGenerateReport = function () {
                var fileCodeBase64 = base64Helper.encode($scope.report.FILE_CODE);
                startGenerateReport($scope.report.date, fileCodeBase64, $scope.report.SCHEME_CODE, $scope.report.FILE_TYPE, $scope.report.KF);
                return;
                if ($scope.report.id == null) {
                    bars.ui.error({ text: 'Невибрано файл для формувавння.' });
                } else {
                    if ($scope.report.proccName.replace(/^\s+|\s+$/g, '') === '') {
                        //ручне формування
                    } else {
                        // перевіримо чи звіт уже формувася
                        var grid = $scope.getReportGrid();
                        if (grid.dataSource.data().length > 0) {
                            bars.ui.confirm({
                                text: String.format('Увага!<br> Звіт "{0}" за {1} вже був сформований.<br> Переформувати звіт?',
                                    $scope.report.id,
                                    $scope.report.date),
                                func: function () { }
                            });
                        } else {
                            bars.ui.confirm({
                                text: String.format('Запустити формування звіту "{0}" за {1} ?',
                                    $scope.report.id,
                                    $scope.report.date),
                                func: function () {
                                    startGenerateReport($scope.report.id, $scope.report.date);
                                }
                            });
                        }
                    }
                }
            }

            var getVersions = function () {
                var url = bars.config.urlContent('/reporting/nbu/getVersions?') +
                    'FileCodeBase64=' +
                    $scope.FileCodeBase64 +
                    '&kf=' +
                    $scope.report.KF +
                    '&reportDate=' +
                    $scope.report.date;
                $http.get(url)
                    .then(function () {

                        $scope.VersionDatasours.transport.options.read.url =
                            bars.config.urlContent('/reporting/nbu/getVersions?') +
                            'FileCodeBase64=' +
                            $scope.FileCodeBase64 +
                            '&kf=' +
                            $scope.report.KF +
                            '&reportDate=' +
                            $scope.report.date;
                        //$scope.reportGridOptions.columns = request.data.columns;
                        //$scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
                        //$scope.fields = request.data.fields;
                        //$scope.archiveGrid2.data = request.data.data;
                        //$scope.archiveGrid2.read(request.data.data);
                        $scope.VersionDatasours.read();
                        //$scope.VersionDatasours.refresh();

                        //$scope.archiveGrid.dataSource.data = request.data.data;
                        //$scope.archiveGrid.dataSource.read(request.data.data);
                        //$scope.archiveGrid.refresh();
                    });
                $scope.VersionWindow.center().open().maximize();
                /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
                $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
                $scope.reportGridOptions.read;*/
            };

            var showControlPointsMessages = function () {
                if ($scope.selectedFileVersionInfo) {
                    bars.ui.handBook('V_NBUR_MESSAGES',
                        {
                            maximize: true,
                            width: 800,
                            clause: "REPORT_DATE=to_date('" +
                                $scope.report.date +
                                "','dd/mm/yyyy') " +
                                " and kf='" +
                                $scope.report.KF +
                                "' and report_code='" +
                                $scope.report.FILE_CODE +
                                "' and version_id=" +
                                $scope.selectedFileVersionInfo.VERSION_ID,
                            columns: [
                                {
                                    field: 'KF',
                                    width: 100
                                }, {
                                    field: 'REPORT_CODE',
                                    width: 100
                                }, {
                                    field: 'VERSION_ID',
                                    width: 100
                                }, {
                                    field: 'REPORT_DATE',
                                    width: 100,
                                    template:
                                        '<div title="#= kendo.toString(REPORT_DATE, \'dd.MM.yyyy\' ) #"><nobr>#=kendo.toString(REPORT_DATE, \'dd.MM.yyyy\' )#</nobr></div>'
                                }
                            ],
                            gridOptions: {
                                toolbar: [
                                    { name: 'excel', text: 'Завантажити в Excel' }
                                ],
                                excel: {
                                    fileName: "Контрольні точки.xlsx",
                                    allPages: true,
                                    filterable: false,
                                    proxyURL: bars.config.urlContent("/Reporting/Nbu/ConvertBase64ToFile/")
                                },
                            }
                        });
                }
            }


            var blockFile = function () {
                bars.ui.loader('body', true);
                reportingNbuService.blockFile($scope.report.date,
                    $scope.report.KF,
                    $scope.selectedFileVersionInfo.VERSION_ID,
                    $scope.selectedFileVersionInfo.FILE_ID)
                    .then(
                    function () {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Успішно', 'Файл успішно заблоковано', 'success');
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify(
                            'Помилка',
                            'Помилка блокування файала<br><small>' +
                            (response.Message || response.ErrorMessage || '')
                            + '</small>',
                            'error'
                        );
                        // console.log(response);
                    }
                    );
            }

            $scope.toolbarReportGridOptions = {
                items: [
                    {
                        enable: false,
                        id: "GenRapBtn",
                        type: "button",
                        text: '<i class="pf-icon pf-16 pf-gears" title="Поставити в чергу на формування"></i>',
                        title: 'Start',
                        click: function () {
                            if (!$scope.report.id) {
                                return;
                            }
                            confirmGenerateReport();
                        }
                    },
                    { type: 'separator' },
                    {
                        type: "buttonGroup",
                        buttons: [
                            {
                                enable: false,
                                id: "GetArchBtn",
                                text: '<i class="pf-icon pf-16 pf-database-import" title="Перегляд черги"></i>',
                                click: function () {
                                    if (!$scope.report.id) {
                                        return;
                                    }
                                    $scope.showArchWindow();
                                }
                            }, {
                                enable: false,
                                id: "SaveArchBtn",
                                text: '<i class="pf-icon pf-16 pf-database-arrow_right" title="Заблокувати файл"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo || $scope.selectedFileVersionInfo.STATUS_CODE === 'BLOCKED') {
                                        return;
                                    }
                                    bars.ui.confirm({
                                        text: 'Файл ' + $scope.report.FILE_CODE +
                                            ' (версії ' + $scope.selectedFileVersionInfo.VERSION_ID +
                                            ') та дані, на основі яких він сформований, ' +
                                            'будуть заблоковані за дату ' + $scope.report.date + '. Ви згодні?',
                                        func: function () {
                                            blockFile();
                                        }
                                    });
                                }
                            }
                        ]
                    },

                    //{
                    //    type: "buttonGroup",
                    //    buttons: [
                    //        {
                    //            id: "AddBtn",
                    //            //spriteCssClass: "pf-icon pf-16 pf-table_row-add2",
                    //            text: '<i class="pf-icon pf-16 pf-table_row-add2" title="Додати рядок"></i>',
                    //            //text: "Додати рядок",
                    //            //showText: "overflow",
                    //            click: function () {
                    //                $scope.addRow();
                    //            }/*,
                    //            group: "OptionGroup",
                    //            hidden: false*/
                    //        },
                    //        //{
                    //        //    id: "EditBtn",
                    //        //    //spriteCssClass: "pf-icon pf-16 pf-tool_pencil",
                    //        //    //text: "Редагувати рядок",
                    //        //    //showText: "overflow",
                    //        //    text: '<i class="pf-icon pf-16 pf-tool_pencil" title="Редагувати рядок"></i>',
                    //        //    click: function () {
                    //        //        $scope.editRow();
                    //        //    }/*,
                    //        //    group: "OptionGroup",
                    //        //    hidden: false*/
                    //        //},
                    //        {
                    //            id: "DelBtn",
                    //            //spriteCssClass: "pf-icon pf-16 pf-table_row-delete2",
                    //            text: '<i class="pf-icon pf-16 pf-table_row-delete2" title="Видалити рядок"></i>',
                    //            //text: "Видалити рядок",
                    //            //showText: "overflow",
                    //            click: function () {
                    //                $scope.deleteRow();
                    //            }/*,
                    //            group: "OptionGroup",
                    //            hidden: false*/
                    //        },
                    //        {
                    //            id: "StopBtn",
                    //            //spriteCssClass: "pf-icon pf-16 pf-delete",
                    //            //text: "Відмінити",
                    //            //showText: "overflow",
                    //            text: '<i class="pf-icon pf-16 pf-delete" title="Відмінити"></i>',
                    //            attributes: { "style": "display: none;" },
                    //            click: function () {
                    //                $scope.stop();
                    //            }
                    //        },
                    //        {
                    //            //spriteCssClass: "pf-icon pf-16 pf-icon pf-16 pf-save",
                    //            text: '<i class="pf-icon pf-16 pf-icon pf-16 pf-save" title="Зберегти"></i>',
                    //            //text: "Зберегти",
                    //            //showText: "overflow",
                    //            click: function () {
                    //                $scope.saveRow();
                    //            }
                    //        }
                    //    ]
                    //},

                    { type: 'separator' },

                    {
                        type: "buttonGroup",
                        buttons: [
                            {
                                enable: false,
                                id: "PrintBtn",
                                text: '<i class="pf-icon pf-16 pf-exel" title="Завантажити в Excel"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo) {
                                        return;
                                    }
                                    $scope.getExcel($scope.getReportGrid(), false);
                                }
                            },
                            {
                                enable: false,
                                id: "GetFileBtn",
                                text: '<i class="pf-icon pf-16 pf-arrow_download" title="Сформувати файл"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo) {
                                        return;
                                    }
                                    $scope.getReportFile();
                                }
                            }
                        ]
                    },

                    { type: 'separator' },

                    {
                        type: "buttonGroup",
                        buttons: [
                            {
                                enable: false,
                                id: "CheckRapBtn",
                                text: '<i class="pf-icon pf-16 pf-report_open" title="Переглянути протокол"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo) {
                                        return;
                                    }
                                    $scope.OpenDetailedReportGrid(false);
                                }
                            }, {
                                enable: false,
                                id: "CheckPointBtn",
                                text: '<i class="pf-icon pf-16 pf-tree"  title="Переглянути контрольні точки"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo) {
                                        return;
                                    }
                                    showControlPointsMessages();
                                }
                            }, {
                                //enable: false,
                                id: "ChkLogBtn",
                                text: '<i class="pf-icon pf-16 pf-business_report"  title="Переглянути протокол перевірки файлу"></i>',
                                click: function () {
                                    if (!$scope.selectedFileVersionInfo) {
                                        return;
                                    }
                                    $scope.ChkLogInit();
                                }
                            }
                            // , {
                            //     //enable: false,
                            //     id: "ControlBtn",
                            //     text: '<i class="pf-icon pf-16 pf-document_header_footer-ok2"  title="Перегляд доступних версій"></i>',
                            //     click: function () {
                            //         // if (!$scope.selectedFileVersionInfo) {
                            //         //     return;
                            //         // }
                            //         getVersions($scope.FileCodeBase64, $scope.report.KF, $scope.report.date);
                            //     }
                            // }
                        ]
                    },

                    { type: 'separator' },

                    {
                        type: "buttonGroup",
                        id: "fileFormatControls",
                        enable: false,
                        buttons: [
                            {
                                id: "FormatTXT",
                                text: "<span title='Перегляд файлу звітності у форматі txt'>TXT</span>",
                                togglable: true,
                                group: "FormatGroup",
                                hidden: true,
                                toggle: function () {
                                    if ($scope.report.id != null) {
                                        $scope.FileCodeBase64 = 
                                            $scope.report.FILE_CODE[0] === "#"
                                            ? base64Helper.encode($scope.report.FILE_CODE)
                                            : base64Helper.encode("#" + $scope.report.FILE_CODE.slice(0, $scope.report.FILE_CODE.length - 1));
                                        getFileInfo($scope.FileCodeBase64, $scope.report.date, $scope.report.KF, $scope.report.SCHEME_CODE, null);
                                    }
                                    else { bars.ui.error({ text: 'Невибрано файл для формувавння.' }); }
                                }
                            },
                            {
                                id: "FormatXML",
                                text: "<span title='Перегляд файлу звітності у форматі xml'>XML</span>",
                                togglable: true,
                                group: "FormatGroup",
                                hidden: true,
                                toggle: function () {
                                    if ($scope.report.id != null) {
                                        $scope.FileCodeBase64 = 
                                            $scope.report.FILE_CODE[0] === "#"
                                            ? base64Helper.encode($scope.report.FILE_CODE.slice(1) + "X")
                                            : base64Helper.encode($scope.report.FILE_CODE);
                                            //: base64Helper.encode("#" + $scope.report.FILE_CODE.slice(0, $scope.report.FILE_CODE.length - 1));
                                        getFileInfo($scope.FileCodeBase64, $scope.report.date, $scope.report.KF, $scope.report.SCHEME_CODE, null);
                                    }
                                    else { bars.ui.error({ text: 'Невибрано файл для формувавння.' }); }
                                }
                            }
                        ]
                    }
                ]
            };

            $scope.isConsolidate = {
                value: 0
            };
            $scope.onChangeGridType = function () {
                var versionId = $scope.selectedFileVersionInfo != null ? $scope.selectedFileVersionInfo.VERSION_ID : null;
                rebindReportGrid(
                    $scope.FileCodeBase64,
                    $scope.report.SCHEME_CODE,
                    $scope.report.KF,
                    versionId
                );
            };

            $scope.fields = [];

            $scope.reportGridInited = false;
            $scope.reCreateReportGrid = function (url, columns, fields) {
                if ($scope.reportGridInited) {
                    angular.element("#reportGrid").kendoGrid('destroy').empty();
                }
                else {
                    $scope.reportGridInited = true;
                }
                angular.element("#reportGrid").kendoGrid($scope.reportGridOptions(url, columns, fields));
            };
            $scope.getReportGrid = function () { return angular.element("#reportGrid").data("kendoGrid"); };

            $scope.detailedReportGridInited = false;
            $scope.reCreateDetailedReportGrid = function (url, columns, fields) {
                if ($scope.detailedReportGridInited) {
                    angular.element("#detailedReportGrid").kendoGrid('destroy').empty();
                }
                else {
                    $scope.detailedReportGridInited = true;
                }
                angular.element("#detailedReportGrid").kendoGrid($scope.reportDetailedGridOptions(url, columns, fields));
            };
            $scope.getDetailedReportGrid = function () { return angular.element("#detailedReportGrid").data("kendoGrid"); };

            var getReportGridColumns = function (fileCodeBase64, schemeCode, kf, isCon, versionId) {
                // var fileCodeBase64 = btoa(fileCode);
                $scope.loading = true;

                var url_prefix = $scope.getUrlPrefix(false);
                var urlColumns = bars.config.urlContent('/api/reporting/nbu/getdetailedrepdatacolumns?' + url_prefix);
                var url = bars.config.urlContent('/api/reporting/nbu/getdetailedrepdata?' + url_prefix);

                $http.get(urlColumns)
                    .then(function (response) {
                        $scope.loading = false;
                        if (response["data"] != null && response["data"]["Columns"] != null) {
                            var data = $scope.fillColumnsAndFields(response["data"]["Columns"]);

                            $scope.reCreateReportGrid(url, data['columns'], data['fields']);
                            $scope.setVisibilityReportGrid(true);
                        }
                        else {
                            bars.ui.notify("Інформація", "Дані відсутні!", "info", { autoHideAfter: 5 * 1000 });
                            $scope.setVisibilityReportGrid(false);
                        }
                    }, function () {
                        $scope.loading = false;
                    });
            };

            var arrayName = [];
            var array = [];
            var funcType = "";

            var fieldsEditOtions = function (fields) {

                $.each(fields, function (name, value) {
                    array.push(value);
                    arrayName.push(name);
                });

                for (var i = 0; i < array.length; i++) {
                    var name = arrayName[i];
                    var conteiner = $("#reportGrid input[name='" + name + "']");
                    var val;
                    var v = array[i].value;
                    if (v.indexOf('nbuc') > -1) {
                        val = parseInt(array[i].length);
                    } else {
                        val = parseInt(array[i].length);
                    }
                    conteiner.attr("maxlength", val);

                    if (val < 255)
                        conteiner.keyup(function () {
                            this.value = this.value.replace(/[^0-9\.]/g, '');
                        });
                }
            };

            var getFieldsLength = function (fields) {

                if ($scope.report.id != null) {
                    var fieldsLength = [];

                    $.each(fields, function (name, value) {
                        array.push(value);
                    });
                    for (var i = 0; i < array.length; i++) {
                        var val = parseInt(array[i].length);
                        fieldsLength.push(val);
                    }
                    return fieldsLength;

                } else {
                    bars.ui.alert({ text: 'Не обрано шаблон звіту з якого потрібно видалити запис!' });
                }
            };

            var clearArraysData = function () {
                arrayName = [];
                array = [];
                fieldsLength = [];
                deleteRowData = [];
            };

            var rebindReportGrid = function (fileCodeBase64, schemeCode, kf, versionId) {
                var isCon = $scope.isConsolidate.value;
                getReportGridColumns(fileCodeBase64, schemeCode, kf, isCon, versionId);
            };

            $scope.selectedFileVersionInfo = null;
            $scope.$watch(
                'selectedFileVersionInfo',
                function handleFooChange(newValue, oldValue) {

                    if (!newValue && !oldValue) {
                        return;
                    }
                    //$scope.reportGrid.dataSource.data([]);
                    //$scope.reportGrid.dataSource.read(); 
                    var toolBar = $scope.appToolbarReportGridOptions;
                    if (!newValue || newValue.STATUS_CODE === 'BLOCKED') {
                        toolBar.enable('#SaveArchBtn', false);
                    } else {
                        toolBar.enable('#SaveArchBtn', true);
                    }

                    if (newValue) {
                        toolBar.enable('#PrintBtn', true);
                        toolBar.enable('#GetFileBtn', true);
                        toolBar.enable('#CheckRapBtn', true);
                        toolBar.enable('#CheckPointBtn', true);
                        //toolBar.enable('#ControlBtn', true);
                        toolBar.toggle("#Format" + $scope.selectedFileVersionInfo.FILE_FMT, true);
                    } else {
                        toolBar.enable('#PrintBtn', false);
                        toolBar.enable('#GetFileBtn', false);
                        toolBar.enable('#CheckRapBtn', false);
                        toolBar.enable('#CheckPointBtn', false);
                        //toolBar.enable('#ControlBtn', false);
                    }
                }
            );

            $scope.$watch(
                "report.FILE_FMT_LIST",
                function (newValue, oldValue) {
                    if (!newValue && !oldValue) {
                        return;
                    }

                    var toolBar = $scope.appToolbarReportGridOptions;
                    if (!newValue || newValue.length < 2) {
                        toolBar.hide("#FormatTXT");
                        toolBar.hide("#FormatXML");
                    } else {
                        toolBar.show("#FormatTXT");
                        $("#FormatTXT").removeClass("k-group-end").addClass("k-group-start"); // костыль, но без него никак
                        toolBar.show("#FormatXML");
                    }
                });

            $scope.parseDate = function (dateString, format) {
                if (!dateString) {
                    return null;
                }
                if (format == undefined) {
                    format = 'dd.MM.yyyy HH:mm:ss';
                }

                if (typeof dateString !== 'string') {
                    return kendo.toString(dateString, format);
                }
                return kendo.toString(new Date(dateString.match(/\d+/)[0] * 1), format);
            };

            $scope.setVisibilityReportGrid = function (flag) {
                if (flag) {
                    angular.element("#reportGrid").show();
                }
                else {
                    angular.element("#reportGrid").hide();
                }
            };

            var getFileInfo = function (fileBase64Code, date, kf, schemeCode, versionId) {
                reportingNbuService.getFileInfo(fileBase64Code, date, kf, versionId).then(
                    function (response) {
                        if (response) {
                            $scope.selectedFileVersionInfo = response;
                            rebindReportGrid($scope.FileCodeBase64, schemeCode, $scope.report.KF);
                        } else {
                            $scope.selectedFileVersionInfo = null;
                            $scope.setVisibilityReportGrid(false);
                            bars.ui.notify("Інформація", "Дані відсутні!", "info", { autoHideAfter: 5 * 1000 });
                        }
                    },
                    function (response) {
                        $scope.selectedFileVersionInfo = null;
                        // console.log(response);
                        bars.ui.notify('Помилка', 'Помилка завантаження інформації про файл', 'error');
                    }
                );
            }

            $scope.showReportNbuHandBook = function () {
                bars.ui.handBook('V_NBUR_LIST_FILES_USER', function (data) {
                    if (data.length != null && data.length > 0) {
                        $scope.fillReport(data, null, true, true);
                    } else {
                        bars.ui.alert({ text: 'Увага!</br> Ви не обрали шаблон звіту.' });
                    }
                }, { clause: 'where 1=1 order by FILE_ID', gridOptions: { dataSource: { pageSize: 1000 } } });

            };

            $scope.dateOptions = {
                format: '{0:dd/MM/yyyy}',
                change: function () {
                    if ($scope.report.id != null) {
                        getFileInfo($scope.FileCodeBase64, kendo.toString(this.value(), 'dd/MM/yyyy'), $scope.report.KF, $scope.report.SCHEME_CODE, null);
                        //$scope.reportGrid.dataSource.read();
                        //$scope.reportGrid.refresh();
                    }
                }
            };



            $scope.addRow = function () {
                var grid = $scope.reportGrid;
                if ($scope.report.id != null) {
                    if (grid) {
                        switchOff();
                        grid.select(grid.addRow());
                        fieldsEditOtions($scope.fields);
                    }
                    clearArraysData();
                    funcType = "rowinsert";
                } else {
                    bars.ui.alert({ text: 'Не обрано шаблон звіту до якого потрібно додати запис!' });
                    grid.dataSource.read();
                    grid.refresh();
                }
            };

            var oldKodp = "";
            var switchOff = function () {
                var toolBar = $scope.appToolbarReportGridOptions;
                //toolBar.enable('#EditBtn', false);
                //toolBar.enable('#AddBtn', false);
                //toolBar.enable('#DelBtn', false);
                toolBar.enable('#GenRapBtn', false);
                toolBar.enable('#GetArchBtn', false);
                toolBar.enable('#SaveArchBtn', false);
                toolBar.enable('#PrintBtn', false);
                toolBar.enable('#GetFileBtn', false);
                toolBar.enable('#CheckRapBtn', false);
                toolBar.enable('#CheckPointBtn', false);
                //toolBar.enable('#ControlBtn', false);

                //$('#EditBtn').hide();
                $('#AddBtn').hide();
                $('#DelBtn').hide();

                $('#StopBtn').show();
            };
            var switchOn = function () {
                var toolBar = $scope.appToolbarReportGridOptions;
                //toolBar.enable('#EditBtn');
                //toolBar.enable('#AddBtn');
                //toolBar.enable('#DelBtn');
                toolBar.enable('#GenRapBtn');
                toolBar.enable('#GetArchBtn');
                toolBar.enable('#SaveArchBtn');
                toolBar.enable('#PrintBtn');
                toolBar.enable('#GetFileBtn');
                toolBar.enable('#CheckRapBtn');
                toolBar.enable('#CheckPointBtn');
                //toolBar.enable('#ControlBtn');

                //$('#EditBtn').show();
                $('#AddBtn').show();
                $('#DelBtn').show();

                $('#StopBtn').hide();
            };

            $scope.editRow = function () {
                var grid = $("#reportGrid").data("kendoGrid");
                var selectedRow = grid.dataItem(grid.select());
                if (selectedRow != null) {
                    switchOff();
                    oldKodp = "";
                    fieldsEditOtions($scope.fields);
                    for (var i = 0; i < array.length; i++) {
                        var valLength = parseInt(array[i].length);
                        var column = "Column" + (i + 1);
                        if (valLength < 255) {
                            oldKodp += selectedRow[column];
                        }
                    }
                    grid.editRow(grid.tbody.find("tr[data-uid='" + selectedRow.uid + "']"));
                    clearArraysData();
                } else {
                    bars.ui.alert({ text: 'Оберіть запис для редагування!' });
                    $scope.onChangeGridType();
                }
                funcType = "rowupdate";
            };

            $scope.stop = function () {
                switchOn();
                $scope.onChangeGridType();
            };

            $scope.deleteRow = function () {
                if ($scope.report.id != null) {
                    var kodf = $scope.report.id;
                    var datf = $scope.report.date;

                    var grid = $scope.reportGrid;
                    var selectedRow = grid.dataItem(grid.select());

                    if (selectedRow != null) {

                        var fieldsLength = getFieldsLength($scope.fields);

                        var deleteRowData = [];

                        for (var it = 0; it < fieldsLength.length; it++) {
                            var column = "Column" + (it + 1);
                            deleteRowData.push(selectedRow[column]);
                        }
                        var kodp = "";
                        var nbuc = deleteRowData[deleteRowData.length - 1];

                        if (fieldsLength.length === deleteRowData.length) {
                            for (var i = 0; i < fieldsLength.length; i++) {
                                if (fieldsLength[i] < 255) {
                                    kodp += deleteRowData[i];
                                } else if (fieldsLength[i] >= 255 && $('#reportGrid th').filter(function () { return $(this).text().indexOf('Код') > -1 }) && (i != deleteRowData.length - 1)) {
                                    nbuc += deleteRowData[i];
                                }
                            }
                        }
                        $http.get(bars.config.urlContent('/reporting/nbu/rowdelete?datf=' + datf + '&kodf=' + kodf + '&kodp=' + kodp + '&nbuc=' + nbuc)).
                            success(function (data) {
                                if (data.status != "error") {
                                    bars.ui.alert({ text: 'Запис успішно видалено!' });
                                } else {
                                    bars.ui.error({ text: 'Виникла помилка при спробі видалити запис!' });
                                }
                                clearArraysData();
                                $scope.onChangeGridType();
                            }).
                            error(function () {
                                bars.ui.error({ text: 'Виникла помилка при спробі видалити запис!' });
                                clearArraysData();
                                $scope.onChangeGridType();
                            });
                    } else {
                        bars.ui.alert({ text: 'Оберіть запис, будь ласка, що буде видалено!' });
                    }
                }
                else {
                    bars.ui.alert({ text: 'Не обрано шаблон звіту, згідно якого буде видалено запис!' });
                }
            };

            $scope.saveRow = function () {
                if ($scope.report.id != null) {
                    var grid = $scope.reportGrid;
                    var kodf = $scope.report.id;
                    var datf = $scope.report.date;

                    fieldsEditOtions($scope.fields);
                    editRowData = [];
                    checkedFields = [];

                    for (var i = 0; i < arrayName.length; i++) {
                        var cell = grid.table.find('td input[name="' + arrayName[i] + '"]');
                        var cellVal = cell.val();
                        var cellLength = parseInt(grid.table.find('td input[name="' + arrayName[i] + '"]').attr('maxlength'));
                        if (i < arrayName.length - 3 && cellVal.length != cellLength) {
                            cell.css("border", "solid 1px #FF0000");
                            checkedFields.push(0);
                        } else {
                            cell.css("border", "");
                            editRowData.push(grid.table.find('td input[name="' + arrayName[i] + '"]').val());
                            checkedFields.push(1);
                        }
                    }
                    statusFlag = $.inArray(0, checkedFields);

                    if (editRowData != null && statusFlag == -1 && funcType != "") {


                        var kodp = "";
                        var nbuc = editRowData[editRowData.length - 2];
                        var znap = editRowData[editRowData.length - 1];
                        for (var i = 0; i < array.length; i++) {
                            var val = parseInt(array[i].length);
                            if (val < 255) {
                                kodp += editRowData[i];
                            } else if (val >= 255 && $('#reportGrid th').filter(function () { return $(this).text().indexOf('Код') > -1 }) && (i != editRowData.length - 1)) {
                                //nbuc += editRowData[i];
                            }
                        }

                        var insertUrl = '?datf=' + datf + '&kodf=' + kodf + '&kodp=' + kodp + '&znap=' + znap + '&nbuc=' + nbuc;
                        var updateUrl = '?datf=' + datf + '&kodf=' + kodf + '&oldKodp=' + oldKodp + '&kodp=' + kodp + '&znap=' + znap + '&nbuc=' + nbuc;
                        var url = funcType == "rowupdate" ? updateUrl : insertUrl;

                        $http.get(bars.config.urlContent('/reporting/nbu/' + funcType + url)).
                            success(function (data) {
                                if (data.status != "error") {
                                    bars.ui.alert({ text: funcType == "rowinsert" ? 'Запис успішно додано!' : 'Запис успішно оновлено!' });
                                } else {
                                    bars.ui.error({ text: funcType == "rowinsert" ? 'Виникла помилка при спробі додати запис!' : 'Виникла помилка при спробі оновити запис!' });
                                }
                                clearArraysData();
                                switchOn();
                                $scope.onChangeGridType();
                            }).
                            error(function () {
                                bars.ui.error({ text: funcType == "rowinsert" ? 'Виникла помилка при спробі додати запис!' : 'Виникла помилка при спробі оновити запис!' });
                                clearArraysData();
                                switchOn();
                                $scope.onChangeGridType();
                            });
                    } else {
                        bars.ui.alert({ text: 'Введені значення полів не відповідають вимогам валідності!' });
                        clearArraysData();
                        checkedFields = [];
                    }
                } else {
                    bars.ui.alert({ text: 'Не обрано шаблон звіту до якого потрібно додати запис!' });
                }
            };

            $scope.selectedType = "";

            $scope.reportGridColumns = [];

            var reportGridDataBound = function (e) {

                var grid = e.sender;
                bars.ext.kendo.grid.noDataRow(e);
                if (grid.dataSource.total() === 0) {

                }
                if (grid.columns.length > 0) {
                    grid.hideColumn('FIELD_CODE');
                }

                //$timeout(function () {
                //    for (var i = 0; i < grid.columns.length; i++) {
                //      grid.autoFitColumn(i);
                //    }
                //}, 0);

                grid.tbody.find("tr").dblclick(function (e) {
                    e.preventDefault();

                    $scope.OpenDetailedReportGrid(true);
                });

            };

            $scope.getReportFile = function () {
                window.location = bars.config.urlContent('/api/reporting/nbu/file/?FileCodeBase64=') +
                    $scope.FileCodeBase64 +
                    '&kf=' +
                    $scope.report.KF +
                    '&reportDate=' +
                    $scope.report.date +
                    '&schemeCode=' +
                    $scope.report.SCHEME_CODE +
                    '&versionId=' +
                    ($scope.selectedFileVersionInfo.VERSION_ID || 'null');
            };

            $scope.VersionDatasours = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                autobind: false,
                transport: {
                    read: {
                        type: "GET",
                        url: '',// bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date,
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            FILE_CODE: { type: 'string' },
                            FILE_ID: { type: 'number' },
                            FILE_NAME: { type: 'string' },
                            FILE_TYPE: { type: 'string' },
                            FIO: { type: 'string' },
                            SCHEME_CODE: { type: 'string' },
                            KF: { type: 'string' },
                            VERSION_ID: { type: 'number' },
                            PERIOD: { type: 'string' },
                            REPORT_DATE: { type: 'date' },
                            START_TIME: { type: 'date' },
                            FINISH_TIME: { type: 'date' },
                            STATUS: { type: 'string' }
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10
            });

            $scope.selectFileVersion = function () {
                var row = $scope.VersionGrid.dataItem($scope.VersionGrid.select());
                if (row) {
                    $scope.selectedFileVersionInfo = row;
                    rebindReportGrid($scope.FileCodeBase64, $scope.report.SCHEME_CODE, $scope.report.KF, row.VERSION_ID);
                    $scope.VersionWindow.close();
                } else {
                    bars.ui.notify('Помилка', 'Виберіть версію в довіднику', 'error');
                }
            }

            var resizeGridVersionGrid = function (e) {
                var gridElement = e.sender.element;
                var dataArea = gridElement.find(".k-grid-content");
                var newHeight = gridElement.parent().innerHeight() - 2;
                var diff = gridElement.innerHeight() - dataArea.innerHeight();

                gridElement.height(newHeight - 60);
                gridElement.find(".k-grid-content").height(newHeight - diff - 60);
                kendo.resize(gridElement);
            };
            $scope.VersionGridOptions = {
                dataBound: resizeGridVersionGrid,
                dataSource: $scope.VersionDatasours,
                height: 500,
                autobind: false,
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "single",
                //dataBound: function (e) {
                //    bars.ext.kendo.grid.noDataRow(e);
                //},
                pageable: {
                    messages: {
                        allPages: "всі"
                    },
                    refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "REPORT_DATE",
                        title: 'Звітн<br>дата',
                        template: "<div>#=kendo.toString(REPORT_DATE,'dd/MM/yyyy')#</div>",
                        width: 80
                    }, {
                        field: "KF",
                        title: 'Код<br>філії',
                        width: 70
                    }, {
                        field: 'VERSION_ID',
                        title: 'Номер<br>версії',
                        width: 70
                    }, {
                        field: "FILE_CODE",
                        title: 'Код<br>файлу',
                        width: 70
                    }, {
                        field: "FILE_TYPE",
                        title: 'Тип<br>файлу',
                        hidden: true,
                        width: "12.5%"
                    }, {
                        field: "FILE_ID",
                        hidden: true,
                        title: "Хто формував",
                        width: "12.5%"
                    }, {
                        field: "FILE_NAME",
                        title: 'Назва файлу',
                        width: 200,
                        template: '<span title="#= FILE_NAME #" ><nobr>#= FILE_NAME #</nobr></span>'
                    }, {
                        field: "PERIOD",
                        title: 'Періодичність',
                        width: 100
                    }, {
                        field: "START_TIME",
                        title: 'Початок <br> формування',
                        template: "<div>#=kendo.toString(START_TIME,'dd.MM.yyyy HH:mm:ss')#</div>",
                        width: 100
                    }, {
                        field: "FINISH_TIME",
                        title: 'Закінчення <br> формування',
                        template: "<div>#=kendo.toString(FINISH_TIME,'dd.MM.yyyy HH:mm:ss')#</div>",
                        width: 100
                    }, {
                        field: "STATUS",
                        title: 'Статус<br>файла',
                        width: 100
                    }, {
                        field: "FIO",
                        title: 'Ініціатор <br> формування',
                        width: 200,
                        template: '<span title="#= FIO #" ><nobr>#= FIO #</nobr></span>'
                    }, {
                        field: "SCHEME_CODE",
                        title: 'Схема',
                        hidden: true,
                        width: 80
                    }
                ]
            };

            $scope.detailedReportWindowOptions = {
                animation: false,
                visible: false,
                width: '97%',
                height: '95%',
                actions: ["Maximize", "Minimize", "Close"],
                draggable: true,
                modal: true,
                pinned: false,
                resizable: true,
                title: 'Перегляд детального протоколу',
                position: 'center',
                close: function () {
                    //$scope.advertising = $scope.getNewAdvertising();
                    $scope.detailedReportWindowOpened = false;
                    $scope.isRowDetailed = false;
                },
                iframe: false

            }

            $scope.VersionWindowOptions = createWindowOptions({ title: 'Список версій по файлу' });

            $scope.ChkLogWindowOptions = createWindowOptions({ title: 'Протокол перевірки файлу' });

            $scope.ChkLogInit = function () {
                var _ID = $scope.FileCodeBase64;
                var _reportDate = $scope.report.date;
                var _KF = $scope.report.KF;
                var _schemeCode = $scope.report.SCHEME_CODE;
                var _versionId = $scope.selectedFileVersionInfo.VERSION_ID || 'null';
                var url = bars.config.urlContent('api/reporting/nbu/getchklog?fileCodeBase64=' + _ID + "&kf=" + _KF +
                    "&reportDate=" + _reportDate + "&schemeCode=" + _schemeCode + "&versionId=" + _versionId);
                $scope.loading = true;
                $http.get(url)
                    .then(function (response) {
                        $scope.loading = false;
                        if (response.data.Data != null) {
                            $scope.ChkLogWindow.center().open();
                            $scope.ChkLogText = response.data.Data;
                        }
                        else {
                            bars.ui.alert({ text: 'Протокол відсутній' })
                        }
                    }, function () {
                        $scope.loading = false;
                    });
            };

            function createWindowOptions(settings) {
                var o = {
                    animation: false,
                    visible: false,
                    width: '1000px',
                    height: '600px',
                    actions: ["Maximize", "Minimize", "Close"],
                    draggable: true,
                    modal: true,
                    pinned: false,
                    resizable: true,
                    title: '',
                    position: 'center',
                    /*close: function () {
                     $scope.advertising = $scope.getNewAdvertising();
                     },*/
                    iframe: false

                };
                reportingNbuService.extend(settings, o);
                return o;
            }

            $scope.reportGridOptions = function (url, columns, fields) {
                return {
                    dataBound: reportGridDataBound,
                    //autoBind: false,
                    dataSource: {
                        type: "aspnetmvc-ajax",
                        pageSize: 10,
                        serverPaging: true,
                        serverFiltering: true,
                        serverSorting: true,
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                url: url
                            }
                        },
                        schema: {
                            data: "Data",
                            total: "Total",
                            model: { fields: fields }
                        },
                        error: function (e) {
                            $scope.loading = false;
                            $scope.$apply();
                        }
                    },
                    height: 75,
                    editable: 'inline',
                    reorderable: true,
                    sortable: true,
                    filterable: true,
                    resizable: true,
                    selectable: "single",
                    pageable: PAGEABLE,
                    columns: columns
                }
            };

            $scope.reportDetailedGridOptions = function (url, columns, fields) {
                return {
                    dataBound: function (e) {
                        var grid = this;
                        if (!$scope.detailedReportWindowOpened) {
                            $scope.loading = false;
                            $scope.$apply();
                            $scope.detailedReportWindowOpened = true;
                            $scope.detailedReportWindow.center().open().maximize();
                        }
                    },
                    width: '99%',
                    //height: 140,
                    actions: ["Maximize", "Minimize", "Close"],
                    buttons: [
                        {
                            text: 'Відмінити',
                            click: function () { this.close(); }
                        }
                    ],
                    showNotActive: false,
                    //autoBind: false,
                    dataSource: {
                        type: "aspnetmvc-ajax",
                        pageSize: 10,
                        serverPaging: true,
                        serverFiltering: true,
                        serverSorting: true,
                        transport: {
                            read: {
                                type: "GET",
                                dataType: "json",
                                url: url
                            }
                        },
                        schema: {
                            data: "Data",
                            total: "Total",
                            model: { fields: fields }
                        },
                        error: function (e) {
                            $scope.loading = false;
                            $scope.$apply();
                        }
                    },
                    sortable: true,
                    filterable: true,
                    resizable: true,
                    selectable: "single",
                    pageable: PAGEABLE,
                    columns: columns
                }
            };

            $scope.archiveWindowOptions = {
                animation: false,
                visible: false,
                wwidth: '1200px',
                actions: ["Maximize", "Minimize", "Close"],
                draggable: true,
                height: "700px",
                modal: true,
                pinned: false,
                resizable: true,
                title: 'Перегляд черги',
                position: 'center',
                /*close: function () {
                    $scope.advertising = $scope.getNewAdvertising();
                },*/
                iframe: false
            };

            //win.bars.ui.dialog({
            //    iframe: true,
            //    actions: ["Close"],
            //    width: '850px',
            //    height: '590px',
            //    id: 'winClientAddress',
            //    title: 'Повна адреса клієнта',
            //    content: {
            //        url: bars.config.urlContent('/clients/ClientAddress/ClientAddress'),
            //        modal: true
            //    }
            //    //close: function () {
            //    //    if (win.customerAddress.type1.filled == true) {
            //    //        window.parent.$('#bt_reg').prop("disabled", false);
            //    //        $('#ed_ADR').val(parent.obj_Parameters['fullADR'].type1.locality + ', ' + parent.obj_Parameters['fullADR'].type1.address);
            //    //    }
            //    //}
            //});

            var getArchiveGridData = function (FileCodeBase64, kf, reportDate) {
                $http.get(bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date)
                    .then(function (request) {

                        $scope.archiveGridDataSource.transport.options.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date;
                        //$scope.reportGridOptions.columns = request.data.columns;
                        //$scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
                        //$scope.fields = request.data.fields;
                        //$scope.archiveGrid2.data = request.data.data;
                        //$scope.archiveGrid2.read(request.data.data);
                        $scope.archiveGridDataSource.read();
                        //$scope.archiveGridDataSource.refresh();

                        //$scope.archiveGrid.dataSource.data = request.data.data;
                        //$scope.archiveGrid.dataSource.read(request.data.data);
                        //$scope.archiveGrid.refresh();
                    });
                $scope.archiveWindow.center().open().maximize();
                /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
                $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
                $scope.reportGridOptions.read;*/
            };

            var DETAILED_COLUMNS = [
                {
                    field: 'BRANCH ',
                    title: 'Відділення',
                    width: 180
                }, {
                    field: 'FIELD_CODE',
                    title: 'Код<br />показника',
                    width: 110
                }, {
                    field: 'FIELD_VALUE',
                    title: 'Значення<br />показника',
                    width: 110
                }, {
                    field: 'ACC_ID',
                    title: 'Ідентифікатор<br /> рахунку',
                    type: 'number',
                    width: 110
                }, {
                    field: 'ACC_NUM',
                    title: 'Номер<br />рахунку',
                    width: 130
                }, {
                    field: 'KV',
                    title: 'Код<br />валюти',
                    width: 80
                }, {
                    field: 'MATURITY_DATE',
                    title: 'Дата<br />погашення',
                    template: "<div>#=(MATURITY_DATE == null) ? ' ' : kendo.toString(MATURITY_DATE,'dd/MM/yyyy')#</div>",
                    width: 110
                }, {
                    field: 'CUST_ID',
                    title: 'РНК<br />контрагента',
                    width: 130
                }, {
                    field: 'CUST_CODE',
                    title: 'ІІН<br />контрагента',
                    width: 110
                }, {
                    field: 'CUST_NMK',
                    title: 'Назва<br />контрагента',
                    width: 110
                }, {
                    field: 'ND',
                    title: 'РЕФ<br />кредитного<br />договору',
                    width: 110
                }, {
                    field: 'AGRM_NUM',
                    title: 'Номер<br />договору',
                    width: 110
                }, {
                    field: 'BEG_DT',
                    title: 'Початок дії<br />договору',
                    template: "<div>#=(BEG_DT == null) ? ' ' : kendo.toString(BEG_DT,'dd/MM/yyyy')#</div>",
                    width: 110
                }, {
                    field: 'END_DT',
                    title: 'Дата<br />завершення<br />договору',
                    template: "<div>#=(END_DT == null) ? ' ' : kendo.toString(END_DT,'dd/MM/yyyy')#</div>",
                    width: 110
                }, {
                    field: 'REF',
                    title: 'Номер<br />документу',
                    width: 110
                }, {
                    field: 'DESCRIPTION',
                    title: 'Коментар',
                    width: 310
                }, {
                    field: 'REPORT_DATE',
                    title: 'Звітна<br />дата',
                    template: "<div>#=(REPORT_DATE == null) ? ' ' : kendo.toString(REPORT_DATE,'dd/MM/yyyy')#</div>",
                    width: 110
                }
            ];

            var DATE_COLUMNS = ["MATURITY_DATE", 'BEG_DT', 'END_DT', "REPORT_DATE"];

            $scope.getUrlPrefix = function (isDtl) {
                var url_prefix = 'fileCodeBase64=' + $scope.FileCodeBase64 +
                    '&kf=' + $scope.report.KF +
                    '&reportDate=' + $scope.report.date +
                    '&schemeCode=' + $scope.report.SCHEME_CODE +
                    '&isDtl=' + isDtl;

                if ($scope.isRowDetailed !== false) {
                    url_prefix += '&fieldCode=' + encodeURIComponent($scope.selectRowForDetailedReport['FIELD_CODE']);
                    url_prefix += '&nbuc=' + $scope.selectRowForDetailedReport['NBUC'];
                }
                return url_prefix;
            };

            $scope.getExcelUrlPrefix = function (grid, isDtl) {
                var url = '/api/reporting/nbu/getexcel?' + $scope.getUrlPrefix(isDtl);
                var data = JSON.stringify({
                    page: grid.dataSource.page(),
                    pageSize: -1, //grid.dataSource.pageSize(),
                    sort: grid.dataSource.sort(),
                    filters: grid.dataSource.filter()
                });
                url += "&gridData=" + data;
                return url;
            };

            $scope.fillColumnsAndFields = function (columns) {
                var fields = {};

                var descriptionColumnIndex = -1;
                for (var i = 0; i < columns.length; i++) {
                    if (columns[i]['field'] == 'DESCRIPTION') {
                        descriptionColumnIndex = i;
                    }
                    columns[i]['width'] = 110;
                    for (var k = 0; k < DETAILED_COLUMNS.length; k++) {
                        if (DETAILED_COLUMNS[k]['field'] == columns[i]['field']) {
                            for (var attr in DETAILED_COLUMNS[k]) {
                                columns[i][attr] = DETAILED_COLUMNS[k][attr];
                            }
                            break;
                        }
                    }

                    var type = DATE_COLUMNS.indexOf(columns[i]['field']) != -1 ? "date" : "string";
                    fields[columns[i]['field']] = { type: type };
                }

                if (descriptionColumnIndex != -1) {
                    var descriptionColumn = columns[descriptionColumnIndex];
                    columns.splice(descriptionColumnIndex, 1);
                    columns.push(descriptionColumn);
                }

                return { fields: fields, columns: columns };
            };

            $scope.OpenDetailedReportGrid = function (isRowDetailed) {
                //if ($scope.selectedFileVersionInfo && $scope.selectedFileVersionInfo.FILE_FMT == "XML") {
                //    bars.ui.notify('Увага', 'Для файлів XML протокол відсутній', 'error', { autoHideAfter: 5 * 1000 });
                //    return;
                //}

                $scope.isRowDetailed = isRowDetailed;

                var grid = $scope.getReportGrid();
                $scope.selectRowForDetailedReport = grid.dataItem(grid.select());

                var url_prefix = $scope.getUrlPrefix(true);
                var urlColumns = bars.config.urlContent('/api/reporting/nbu/getdetailedrepdatacolumns?' + url_prefix);
                var url = bars.config.urlContent('/api/reporting/nbu/getdetailedrepdata?' + url_prefix);

                $scope.loading = true;

                $http.get(urlColumns)
                    .then(function (response) {
                        if (response["data"] != null &&
                            response["data"]["Columns"] != null &&
                            response["data"]["Columns"].length > 0) {
                            var data = $scope.fillColumnsAndFields(response["data"]["Columns"]);
                            $scope.reCreateDetailedReportGrid(url, data['columns'], data['fields']);
                        } else {
                            bars.ui.alert({ text: "Для файлу " + 
                                    (base64Helper.decode($scope.FileCodeBase64)) +
                                    " протокол відсутній" });
                            $scope.loading = false;
                        }
                    }, function () {
                        $scope.detailedReportWindow.center().open().maximize();
                        $scope.loading = false;
                    });
            };

            $scope.showArchWindow = function () {
                //var kodf = $scope.report.id;

                getArchiveGridData($scope.FileCodeBase64, $scope.report.KF, $scope.report.date);
                //$scope.archiveGridOption.dataSource.data = dSource;
                //$scope.archiveGrid.dataSource.read();
                //$scope.archiveGrid.refresh();



            };

            $scope.showAccountDetailWindow = function (id) {
                var url = bars.config.urlContent('/viewaccounts/accountform.aspx?type=2&acc=' + id + '&rnk=&accessmode=0');
                bars.ui.dialog({
                    iframe: true,
                    content: {
                        url: url
                    },
                    width: 999,
                    height: 610
                });
            }

            $scope.showCustomerDetailWindow = function (id) {
                var url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);
                bars.ui.dialog({
                    iframe: true,
                    content: {
                        url: url
                    },
                    width: '97%',
                    height: '95%'
                });
            }

            $scope.showDocumentDetailWindow = function (id) {

                var url = bars.config.urlContent('/documents/item/?id=' + id + '&partial=true');
                bars.ui.dialog({
                    iframe: false,
                    content: {
                        url: url
                    },
                    width: 750,
                    height: 530
                });
            }

            $scope.showLoanAgreementDetailWindow = function (id, rnk, sos) {
                $http.get(bars.ui.urlContent('/reporting/nbu/GetCustType?rnk=' + rnk), function (response) {
                    var url = bars.config.urlContent('/CreditUi/NewCredit/?custtype=' + response + '&nd=' + id + '&sos=' + sos);

                    bars.ui.dialog({
                        iframe: true,
                        content: {
                            url: url
                        },
                        width: 999,
                        height: 610
                    });
                });
            }

            $scope.getExcel = function (grid, isDtl) {
                var progress = function (flag) {
                    if (isDtl) {
                        kendo.ui.progress($("#search"), flag);
                    }
                    else {
                        $scope.loading = flag;
                    }
                };

                progress(true);
                var url = $scope.getExcelUrlPrefix(grid, isDtl);

                $http.get(bars.config.urlContent(url)).
                    success(function (data) {
                        progress(false);
                        if (data["FileName"] != null) {
                            url = '/reporting/nbu/getexcel?fName=' + data["FileName"];
                            window.location = bars.config.urlContent(url);
                        }
                        else {
                            bars.ui.notify('Помилка', 'Невдала спроба завантажити файл, спробуйте повторно', 'error');
                        }
                    }).
                    error(function () {
                        progress(false);
                        bars.ui.notify('Помилка', 'Невдала спроба завантажити файл, спробуйте повторно', 'error');
                    });
            };

            $scope.detailedReportGridToolbarOptions = {
                resizable: false,
                items: [{
                    type: "button",
                    name: 'excel',
                    text: '<i class="pf-icon pf-16 pf-exel"></i> Завантажити в Excel',
                    imageclass: 'pf-icon pf-16 pf-exel',
                    click: function () {
                        $scope.getExcel($scope.getDetailedReportGrid(), true);
                    }
                }, {
                    type: "button",
                    name: 'excel',
                    text: 'Перегляд картки рахунку',
                    click: function () {
                        var grid = $scope.getDetailedReportGrid();
                        var selectedRow = grid.dataItem(grid.select());
                        if (!selectedRow) {
                            bars.ui.notify('Помилка', 'Виберіть рядок', 'error');
                            return;
                        }
                        if (!selectedRow.ACC_ID) {
                            bars.ui.notify('Помилка', 'Значення Ідентифікатор рахунку пусте', 'error');
                            return;
                        }
                        $scope.showAccountDetailWindow(selectedRow.ACC_ID);
                    }
                }, {
                    type: "button",
                    name: 'excel',
                    text: 'Перегляд картки клієнта',
                    click: function () {
                        var grid = $scope.getDetailedReportGrid();
                        var selectedRow = grid.dataItem(grid.select());
                        if (!selectedRow) {
                            bars.ui.notify('Помилка', 'Виберіть рядок', 'error');
                            return;
                        }
                        if (!selectedRow.CUST_ID) {
                            bars.ui.notify('Помилка', 'Значення РНК пусте', 'error');
                            return;
                        }
                        $scope.showCustomerDetailWindow(selectedRow.CUST_ID);
                    }
                }, {
                    type: "button",
                    name: 'excel',
                    text: 'Перегляд документу',
                    click: function () {
                        var grid = $scope.getDetailedReportGrid();
                        var selectedRow = grid.dataItem(grid.select());
                        if (!selectedRow) {
                            bars.ui.notify('Помилка', 'Виберіть рядок', 'error');
                            return;
                        }
                        if (!selectedRow.REF) {
                            bars.ui.notify('Помилка', 'Значення номер документу пусте', 'error');
                            return;
                        }
                        $scope.showDocumentDetailWindow(selectedRow.REF);
                    }
                }, {
                    type: "button",
                    name: 'excel',
                    text: 'Перегляд договору',
                    click: function () {

                        var grid = $scope.getDetailedReportGrid();
                        var selectedRow = grid.dataItem(grid.select());
                        if (!selectedRow) {
                            bars.ui.notify('Помилка', 'Виберіть рядок', 'error');
                            return;
                        }
                        if (!selectedRow.ND) {
                            bars.ui.notify('Помилка', 'Значення РЕФ кредитного договору пусте', 'error');
                            return;
                        }
                        $scope.showLoanAgreementDetailWindow(selectedRow.ND);
                    }
                }

                ]
            };

            var resizeGrid = function (e) {
                var gridElement = e.sender.element;
                var dataArea = gridElement.find(".k-grid-content");
                var newHeight = gridElement.parent().innerHeight() - 2;
                var diff = gridElement.innerHeight() - dataArea.innerHeight();

                var infoHeight = angular.element('#detailedReportWindowFileInfo').innerHeight();

                gridElement.height(newHeight - (infoHeight + 75));
                gridElement.find(".k-grid-content").height(newHeight - diff - (infoHeight + 75));
                kendo.resize(gridElement);
            };

            $scope.archiveGridDataSource = new kendo.data.DataSource({
                type: 'aspnetmvc-ajax',
                autobind: false,
                transport: {
                    read: {
                        type: "GET",
                        url: '',// bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date,
                        dataType: 'json',
                        cache: false
                    }
                },
                schema: {
                    model: {
                        fields: {
                            FILE_CODE: { type: 'string' },
                            FILE_ID: { type: 'number' },
                            FILE_NAME: { type: 'string' },
                            FILE_TYPE: { type: 'string' },
                            FIO: { type: 'string' },
                            KF: { type: 'string' },
                            PERIOD: { type: 'string' },
                            REPORT_DATE: { type: 'date' },
                            TIME: { type: 'string' }
                        }
                    }
                },
                serverFiltering: true,
                pageSize: 10
            });

            $scope.archiveGridOption = {
                dataSource: $scope.archiveGridDataSource,
                autobind: false,
                sortable: true,
                filterable: true,
                resizable: true,
                selectable: "multiple",
                pageable: {
                    messages: {
                        allPages: "всі"
                    },
                    refresh: true,
                    pageSizes: true,
                    buttonCount: 5
                },
                columns: [
                    {
                        field: "REPORT_DATE",
                        title: 'Звітна дата',
                        template: "<div>#=kendo.toString(REPORT_DATE,'dd/MM/yyyy')#</div>",
                        width: "12.5%"
                    }, {
                        field: "KF",
                        title: 'Код філії',
                        width: "12.5%"
                    }, {
                        field: "FILE_CODE",
                        title: 'Код файлу',
                        width: "12.5%"
                    }, {
                        field: "FILE_TYPE",
                        title: 'Тип файлу',
                        width: "12.5%"
                    }, {
                        field: "FILE_NAME",
                        title: 'Назва файлу',
                        width: "12.5%"
                    }, {
                        field: "FILE_ID",
                        hidden: true,
                        title: "Хто формував",
                        width: "12.5%"
                    },
                    {
                        field: "PERIOD",
                        title: 'Періодичність',
                        width: "12.5%"
                    }, {
                        field: "TIME",
                        title: 'Дата додавання <br> до черги',
                        template: "<div>#=kendo.toString(REPORT_DATE,'dd/MM/yyyy')#</div>",
                        width: "12.5%"
                    }, {
                        field: "FIO",
                        title: 'Ініціатор <br> формування',
                        width: "12.5%"
                    }

                ]
            };

            //var adversitingGridDataBound = function (e) {
            //    var grid = e.sender;
            //    if (grid.dataSource.total() == 0) {
            //        var colCount = grid.columns.length;
            //        $(e.sender.wrapper)
            //            .find('tbody')
            //            .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + grid.pager.options.messages.empty + ' :(</td></tr>');
            //    }
            //};


        }]);

