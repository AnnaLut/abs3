angular.module('BarsWeb.Areas')
    .controller('Reporting.Nbu', ['$scope', '$http', function ($scope, $http) {
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
                '/' + date.getFullYear(),
            type: null,
            procc: null,
            proccName: '',
            procSemantic: ''
        };

        $scope.toolbarReportOptions = {
            items: [
                {
                    template: '<label>Дата: </label><input type="text" ng-model="report.date" kendo-date-picker="" k-options="dateOptions" />'
                }, {
                    type: 'separator'
                }, {
                    template: '<label>Звіт: </label>' +
                        '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.id" style="width:40px" />' +
                        '<input type="text" ng-attr-title="{{report.name}}" class="k-textbox k-state-disabled" disabled="disabled" data-ng-model="report.name" style="width:200px" />'
                }, {
                    //template: '<a class="k-button ng-scope" ng-click="showReportNbuHandBook()" ><i class="pf-icon pf-16 pf-book"></i></a>'

                    type: 'button',
                    text: '<i title="Довідник" class="pf-icon pf-16 pf-book"></i>',
                    title: 'Довідник',
                    click: function () {
                        $scope.showReportNbuHandBook();
                    }
                },
                { type: 'separator' },
                {
                    // <input type="checkbox" data-ng-model="reportGridOptions.showConsolidate" /> ng-change="change()"
                    template: '<label > <input type="checkbox"  ng-model="isConsolidate.value"  ng-true-value="1" ng-false-value="0" ng-change="onChangeGridType()"> консолідований </label>'
                } 
            ]
        };

        var startGenerateReport = function (/*id, reportDate*/) {
            /*var data = {
                code: id,
                date: reportDate
            };*/
            $http.put($scope.apiUrl + '?code=' + $scope.report.id + '&date=' + $scope.report.date)
                .success(function (request) {
                    bars.ui.notify('Повідомлення',
                        'Розпочато формування файлу ' + $scope.report.id +
                        ' за ' + $scope.report.date +
                        '<br> Код завдання ' + request.TaskId, 'success');
                });
        }
        var confirmGenerateReport = function () {
            if ($scope.report.id == null) {
                bars.ui.error({ text: 'Невибрано файл для формувавння.' });
            } else {
                if ($scope.report.proccName.replace(/^\s+|\s+$/g, '') === '') {
                    //ручне формування
                } else {
                    // перевіримо чи звіт уже формувася
                    if ($scope.reportGrid.dataSource.data().length > 0) {
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
        $scope.toolbarReportGridOptions = {
            items: [
                {
                    id: "GenRapBtn",
                    type: "button",
                    text: '<i class="pf-icon pf-16 pf-gears" title="Запустити формування даних для файла"></i>',
                    title: 'Start',
                    click: function () {
                        confirmGenerateReport();
                    },
                    //group: "OptionGroup",
                    //hidden: false
                },

                { type: 'separator' },

                {
                    type: "buttonGroup",
                    buttons: [
                        {
                            id: "GetArchBtn",
                            spriteCssClass: "pf-icon pf-16 pf-database-import",
                            text: "Вибрати з архіву",
                            toolTip: 'tets',
                            showText: "overflow",
                            click: function () {
                                $scope.showArchWindow();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "SaveArchBtn",
                            spriteCssClass: "pf-icon pf-16 pf-database-arrow_right",
                            text: "Зберегти в архів",
                            showText: "overflow",
                            click: function () {
                                $scope.showAdd();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        }
                    ]
                },

                { type: 'separator' },

                {
                    type: "buttonGroup",
                    buttons: [
                        {
                            id: "AddBtn",
                            spriteCssClass: "pf-icon pf-16 pf-table_row-add2",
                            text: "Додати рядок",
                            showText: "overflow",
                            click: function () {
                                $scope.addRow();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "EditBtn",
                            //spriteCssClass: "pf-icon pf-16 pf-tool_pencil",
                            //text: "Редагувати рядок",
                            //showText: "overflow",
                            text: '<i class="pf-icon pf-16 pf-tool_pencil" title="Редагувати рядок"></i>',
                            click: function () {
                                $scope.editRow();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "DelBtn",
                            spriteCssClass: "pf-icon pf-16 pf-table_row-delete2",
                            text: "Видалити рядок",
                            showText: "overflow",
                            click: function () {
                                $scope.deleteRow();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "StopBtn",
                            //spriteCssClass: "pf-icon pf-16 pf-delete",
                            //text: "Відмінити",
                            //showText: "overflow",
                            text: '<i class="pf-icon pf-16 pf-delete" title="Відмінити"></i>',
                            attributes: { "style": "display: none;" },
                            click: function () {
                                $scope.stop();
                            }
                        },
                        {
                            spriteCssClass: "pf-icon pf-16 pf-icon pf-16 pf-save",
                            text: "Зберегти",
                            showText: "overflow",
                            click: function () {
                                $scope.saveRow();
                            }
                        }
                    ]
                },

                { type: 'separator' },

                {
                    type: "buttonGroup",
                    buttons: [
                        {
                            id: "PrintBtn",
                            spriteCssClass: "pf-icon pf-16 pf-print",
                            text: "Роздрукувати",
                            showText: "overflow",
                            click: function () {
                                $scope.showAdd();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "GetFileBtn",
                            /*type: "button",*/
                            text: '<i class="pf-icon pf-16 pf-arrow_download" title="Сформувати файл"></i>',
                            /*spriteCssClass: "pf-icon pf-16 pf-arrow_download",
                            text: "Сформувати файл",
                            showText: "overflow",*/
                            click: function () {
                                $scope.getReportFile();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        }
                    ]
                },

                { type: 'separator' },

                {
                    type: "buttonGroup",
                    buttons: [
                        {
                            id: "CheckRapBtn",
                            spriteCssClass: "pf-icon pf-16 pf-report_open",
                            text: "Переглянути протокол",
                            showText: "overflow",
                            click: function () {
                                $scope.showAdd();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "CheckPointBtn",
                            spriteCssClass: "pf-icon pf-16 pf-tree",
                            text: "Переглянути контрольні точки",
                            showText: "overflow",
                            click: function () {
                                $scope.showAdd();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "ControlBtn",
                            spriteCssClass: "pf-icon pf-16 pf-document_header_footer-ok2",
                            text: "Контроль",
                            showText: "overflow",
                            click: function () {
                                $scope.showAdd();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        }
                    ]
                }
            ]
        };

        $scope.isConsolidate = {
            value: 0
        };
        $scope.onChangeGridType = function () {
            $scope.reportGrid.dataSource.read();
            $scope.reportGrid.refresh();
        };

        $scope.fields = [];

        var getReportGridColumns = function (id, isCon) {
            $http.get(bars.config.urlContent('/reporting/nbu/getstructure?id=') + id + '&isCon=' + isCon)
                .then(function (request) {
                    $scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/');
                    $scope.reportGridOptions.columns = request.data.columns;
                    $scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
                    $scope.fields = request.data.fields;
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

            for (i = 0; i < array.length; i++) {
                var name = arrayName[i];
                var conteiner = $("#reportGrid input[name='" + name + "']");
                var val = "";
                var v = array[i].value;
                if (v.indexOf('nbuc') > -1) {
                    a = array[i].value;
                    b = a.split(",");
                    val = parseInt(b[b.length - 1].split(")")[0]);
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
                for (i = 0; i < array.length; i++) {
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

        var rebindReportGrid = function (id) {
            var isCon = $scope.isConsolidate.value;
            getReportGridColumns(id, isCon);
        };

        $scope.showReportNbuHandBook = function () {
            bars.ui.handBook('V_KL_F00', function (data) {
                if (data.length != null && data.length > 0) {
                    $scope.report.id = data[0].KODF;
                    $scope.report.name = data[0].SEMANTIC;
                    $scope.report.procc = data[0].PROCC;
                    $scope.report.proccName = data[0].PROCC_NAME;
                    $scope.report.proccSemantic = data[0].PROCC_SEMANTIC;
                    $scope.$apply();
                    $scope.reportGrid.dataSource.read();
                    $scope.reportGrid.refresh();
                    rebindReportGrid(data[0].KODF);
                } else { bars.ui.alert({ text: 'Увага!</br> Ви не обрали шаблон звіту.' }); }
            }, {});
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

        $scope.editRow = function () {
            var toolBar = $scope.toolbarReportGridOptions;
            var grid = $("#reportGrid").data("kendoGrid");
            var selectedRow = grid.dataItem(grid.select());
            if (selectedRow != null) {
                switchOff();
                oldKodp = "";
                fieldsEditOtions($scope.fields);
                for (i = 0; i < array.length; i++) {
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
                $scope.reportGrid.dataSource.read();
                $scope.reportGrid.refresh();
            }
            funcType = "rowupdate";
        };

        $scope.stop = function () {
            switchOn();
            $scope.reportGrid.dataSource.read();
            $scope.reportGrid.refresh();
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
            toolBar.enable('#ControlBtn');

            $('#EditBtn').show();
            $('#AddBtn').show();
            $('#DelBtn').show();

            $('#StopBtn').hide();
        };
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
            toolBar.enable('#ControlBtn', false);

            $('#EditBtn').hide();
            $('#AddBtn').hide();
            $('#DelBtn').hide();

            $('#StopBtn').show();
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

                    for (i = 0; i < fieldsLength.length; i++) {
                        var column = "Column" + (i + 1);
                        deleteRowData.push(selectedRow[column]);
                    }
                    var kodp = "";
                    var nbuc = "";

                    if (fieldsLength.length = deleteRowData.length) {
                        for (i = 0; i < fieldsLength.length; i++) {
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
                        $scope.reportGrid.dataSource.read();
                        $scope.reportGrid.refresh();
                    }).
                    error(function () {
                        bars.ui.error({ text: 'Виникла помилка при спробі видалити запис!' });
                        clearArraysData();
                        $scope.reportGrid.dataSource.read();
                        $scope.reportGrid.refresh();
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

                for (i = 0; i < arrayName.length; i++) {
                    var cell = grid.table.find('td input[name="' + arrayName[i] + '"]');
                    var cellVal = cell.val();
                    var cellLength = parseInt(grid.table.find('td input[name="' + arrayName[i] + '"]').attr('maxlength'));
                    if (i != arrayName.length-1 && cellVal.length != cellLength) {
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
                    var nbuc = "";
                    var znap = editRowData[editRowData.length - 1];
                    for (i = 0; i < array.length; i++) {
                        var val = parseInt(array[i].length);
                        if (val < 255) {
                            kodp += editRowData[i];
                        } else if (val >= 255 && $('#reportGrid th').filter(function () { return $(this).text().indexOf('Код') > -1 }) && (i != editRowData.length - 1)) {
                            nbuc += editRowData[i];
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
                        $scope.reportGrid.dataSource.read();
                        $scope.reportGrid.refresh();
                    }).
                    error(function () {
                        bars.ui.error({ text: funcType == "rowinsert" ? 'Виникла помилка при спробі додати запис!' : 'Виникла помилка при спробі оновити запис!' });
                        clearArraysData();
                        switchOn();
                        $scope.reportGrid.dataSource.read();
                        $scope.reportGrid.refresh();
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
        $scope.reportGridOptions = {};


        $scope.reportGridColumns = [];

        var reportGridDataBound = function (e) {
            var grid = e.sender;
            if (grid.dataSource.total() === 0) {
                var colCount = grid.columns.length;
                $(e.sender.wrapper).find('tbody')
                    .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + grid.pager.options.messages.empty + ' :(</td></tr>');
            }
        };

        $scope.getReportFile = function () {
            if ($scope.report.id != null) {
                window.location = bars.config.urlContent('/api/reporting/nbu/file?code=') + $scope.report.id + '&' + 'date=' + $scope.report.date;
            } else {
                bars.ui.alert({ text: 'Не обрано шаблон звіту!' });
            }        
        };

        $scope.reportGridOptions = {
            //autoBind: false,
            //showConsolidate: false,
            editable: "inline",
            reorderable: true,
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
                            id: function () {
                                return $scope.report.id;
                            },
                            date: function () {
                                return $scope.report.date;
                            },// '16/01/2015'
                            isCon: function () {
                                return $scope.isConsolidate.value;
                            }
                        }
                    }/*,
                    update: {
                        url: "http://demos.kendoui.com/service/Products/Update",
                        dataType: "jsonp"
                    }*/
                },
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {}
                       
                },
                pageSize: 10,
                serverPaging: false,
                serverSorting: true
            },
            dataBound: reportGridDataBound,
            sortable: true,
            filterable: true,
            selectable: "multiple",
            pageable: {
                refresh: true,
                pageSizes: [10, 20, 50, 100],
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

        $scope.archiveWindowOptions = {
            animation: false,
            visible: false,
            width: "650px",
            actions: ["Close"],
            draggable: true,
            height: "700px",
            modal: true,
            pinned: false,
            resizable: true,
            title: 'Архів файлів звітності',
            position: 'center',
            /*close: function () {
                $scope.advertising = $scope.getNewAdvertising();
            },*/
            iframe: false
        };

        var getArchiveGridData = function (kodf) {
            $http.get(bars.config.urlContent('/reporting/nbu/getarchivegrid?kodf=') + kodf)
                .then(function (request) {
                    //$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/');
                    //$scope.reportGridOptions.columns = request.data.columns;
                    //$scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
                    //$scope.fields = request.data.fields;
                    $scope.archiveGridOption.dataSource.data = request.data;
                    $scope.archiveGridOption.dataSource.read();
                    $scope.archiveGridOption.refresh();
                });
            /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
            $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
            $scope.reportGridOptions.read;*/
        };

        $scope.showArchWindow = function () {
            var kodf = $scope.report.id;

            getArchiveGridData(kodf);
            //$scope.archiveGridOption.dataSource.data = dSource;
            //$scope.archiveGrid.dataSource.read();
            //$scope.archiveGrid.refresh();
            

            $scope.archiveWindow.center().open();
        };
        

        // ***************************

        $scope.archiveGridOption = {
            //toolbar: ["pdf",'excel'],
            showNotActive: false,
            dataSource: {
                //type: 'webapi',
                /*sort: {
                    field: "Id",
                    dir: "desc"
                },*/
                /*transport: {
                    read: {
                        url: bars.config.urlContent('/reporting/nbu/getarchivegrid'),
                        dataType: "json",
                        data: { kodf: $scope.report.id }
                    }
                },*/
                schema: {
                    data: "Data",
                    total: "Total",
                    errors: "Errors",
                    model: {
                        fields: {

                            DateBegin: { type: 'date' },
                            Name: { type: 'string' },
                            DateEnd: { type: 'date' },

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
            selectable: "multiple",
            pageable: {
                refresh: true,
                pageSizes: true,
                buttonCount: 5
            },
            /*dataBound: function() {
                this.expandRow(this.tbody.find("tr.k-master-row").first());
            },*/
            dataBound: adversitingGridDataBound,
            columns: [
                {
                    field: "DATF",
                    title: 'Дата звіту',
                    //headerTemplate: '<div title="Початок дії">Початок дії</div>',
                    format: '{0:dd/MM/yyyy}',
                    width: "25%"
                }, {
                    field: "FIO",
                    title: "Хто формував",
                    width: "50%",
                }, {
                    field: "DAT_BLK",
                    title: 'Дата архівації',
                    format: '{0:dd/MM/yyyy}',
                    width: "25%"
                }
            ]
        };

        var adversitingGridDataBound = function (e) {
            var grid = e.sender;
            if (grid.dataSource.total() == 0) {
                var colCount = grid.columns.length;
                $(e.sender.wrapper)
                    .find('tbody')
                    .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + grid.pager.options.messages.empty + ' :(</td></tr>');
            }
        };


    }]);

/* 
// add service in controller
        var getArchiveGridData = function (kodf) {
            $http.get(bars.config.urlContent('/reporting/nbu/getarchivegrid?kodf=') + kodf)
                .then(function (request) {
                    //$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/');
                    //$scope.reportGridOptions.columns = request.data.columns;
                    //$scope.reportGridOptions.dataSource.schema.model.fields = request.data.fields;
                    //$scope.fields = request.data.fields;
                    $scope.archiveGridOption.dataSource.data = request.data;
                    $scope.archiarchiveGridOptionveGrid.dataSource.read();
                    $scope.archiveGridOption.refresh();
                });
            /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
            $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
            $scope.reportGridOptions.read;*/
/*};

var sharedDataSource = new kendo.data.DataSource({
    transport: {
        read: {
            url: bars.config.urlContent('/reporting/nbu/getarchivegrid'),
            dataType: "json",
            data: { kodf: $scope.report.id }
        }
    }
});

      

// add 
$scope.archiveGridOption = {
    //autoBind: false,
    //showConsolidate: false,
    editable: "inline",
    reorderable: true,
    sortable: true,
    filterable: true,
    selectable: "row",
    pageable: {
        refresh: true,
        pageSizes: [10, 20, 50, 100],
        buttonCount: 5
    },
    columns: [
        {
            field: "DATF",
            title: 'Дата звіту',
            //headerTemplate: '<div title="Початок дії">Початок дії</div>',
            format: '{0:dd/MM/yyyy}',
            width: "20%"
        }, {
            field: "FIO",
            title: "Хто формував",
            width: "60%",
        }, {
            field: "DAT_BLK", 
            title: 'Дата архівації',
            format: '{0:dd/MM/yyyy}',
            width: "20%"
        }
    ]
};

var dSource = [
{ DATF: "10/10/2010", FIO: "Address", DAT_BLK: "12/12/2012" }
];


























        { 
            schema:
            {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {}
                       
            },
            pageSize: 10,
            serverPaging: false,
            serverSorting: true
        },
*/