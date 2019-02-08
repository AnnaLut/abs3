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
                }//,
                //{ type: 'separator' },
                //{
                //    // <input type="checkbox" data-ng-model="reportGridOptions.showConsolidate" /> ng-change="change()"
                //    template: '<label > <input type="checkbox"  ng-model="isConsolidate.value"  ng-true-value="1" ng-false-value="0" ng-change="onChangeGridType()"> консолідований </label>'
                //}
            ]
        };

        var startGenerateReport = function (reportDate, fileCodeBase64, schemeCode, fileType, kf) {
            /*var data = {
                code: id,
                date: reportDate
            };*/
            var encodedURI = '?reportDate=' + encodeURIComponent(reportDate) + '&fileCodeBase64=' +  encodeURIComponent(fileCodeBase64) + '&schemeCode=' + encodeURIComponent(schemeCode) + '&fileType=' + encodeURIComponent(fileType) + '&kf=' + encodeURIComponent(kf);
            $http.put($scope.apiUrl + encodedURI)
                .success(function (request) {
                    bars.ui.notify('Повідомлення',request.reponseMessage, 'success');
                });
        }
        var confirmGenerateReport = function () {

            startGenerateReport($scope.report.date, $scope.FileCodeBase64, $scope.report.SCHEME_CODE,$scope.report.FILE_TYPE, $scope.report.KF);
            return;
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
                    text: '<i class="pf-icon pf-16 pf-gears" title="Поставити в чергу на формування"></i>',
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
                            text: '<i class="pf-icon pf-16 pf-database-import" title="Перегляд черги"></i>',
                            click: function () {
                                $scope.showArchWindow();
                            }/*,
                            group: "OptionGroup",
                            hidden: false*/
                        },
                        {
                            id: "SaveArchBtn",
                            text: '<i class="pf-icon pf-16 pf-database-arrow_right" title="Заблокувати файл"></i>',
                            click: function () {
                                //$scope.showAdd();
                            }
                        },
                    ]
                },

                //{ type: 'separator' },

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
                            id: "PrintBtn",
                            text: '<i class="pf-icon pf-16 pf-print" title="Роздрукувати"></i>',
                            click: function () {
                            }
                        },
                        {
                            id: "GetFileBtn",
                            text: '<i class="pf-icon pf-16 pf-arrow_download" title="Сформувати файл"></i>',
                            click: function () {
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
                            id: "CheckRapBtn",
                            text: '<i class="pf-icon pf-16 pf-report_open" title="Переглянути протокол"></i>',
                            click: function () {
                                $scope.OpenDetailedReportGrid(false);
                            }
                        },
                        {
                            id: "CheckPointBtn",
                            text: '<i class="pf-icon pf-16 pf-tree"  title="Переглянути контрольні точки"></i>',
                            click: function () {
                                $scope.showAdd();
                            }
                        },
                        {
                            id: "ControlBtn",
                            text: '<i class="pf-icon pf-16 pf-document_header_footer-ok2"  title="Перегляд доступних версій"></i>',
                            click: function () {
                                getVersions($scope.FileCodeBase64, $scope.reportGrid.KF, $scope.reportGrid.REPORT_DATE);
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
            $scope.reportGrid.dataSource.read();
            $scope.reportGrid.refresh();
        };

        $scope.fields = [];

        var getReportGridColumns = function (fileCodeBase64, schemeCode, kf, isCon) {
            // var fileCodeBase64 = btoa(fileCode);
            var url = bars.config.urlContent('/reporting/nbu/getstructure?fileCodeBase64=') + fileCodeBase64 + '&schemeCode=' + schemeCode + '&kf=' + kf + '&isCon=' + isCon;
            $http.get(url)
                .then(function (request) {
                    $scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/GetRepo?fileCodeBase64=') + fileCodeBase64 + '&schemeCode=' + schemeCode + '&kf=' + kf + '&isCon=' + isCon;
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

        var rebindReportGrid = function (fileCodeBase64, schemeCode, kf) {
            var isCon = $scope.isConsolidate.value;
            getReportGridColumns(fileCodeBase64, schemeCode, kf, isCon);
        };

        var Base64 = { _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", encode: function (e) { var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e); while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t }, decode: function (e) { var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, ""); while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t }, _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t } }

        $scope.showReportNbuHandBook = function () {

            bars.ui.handBook('V_NBUR_LIST_FILES_USER', function (data) {
                if (data.length != null && data.length > 0) {
                    $scope.report.id = data[0].FILE_ID;
                    $scope.report.name = data[0].FILE_NAME;
                    $scope.report.SCHEME_CODE = data[0].SCHEME_CODE;
                    $scope.report.FILE_CODE = data[0].FILE_CODE;
                    $scope.report.PERIOD = data[0].PERIOD;
                    $scope.report.KF = data[0].KF;
                    $scope.report.FILE_TYPE = data[0].FILE_TYPE;
                    $scope.$apply();
                    $scope.reportGrid.dataSource.read();
                    $scope.reportGrid.refresh();
                    $scope.FileCodeBase64 = Base64.encode($scope.report.FILE_CODE);
                    rebindReportGrid($scope.FileCodeBase64, $scope.report.SCHEME_CODE, $scope.report.KF);
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

            //$('#EditBtn').show();
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

            //$('#EditBtn').hide();
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
                    var nbuc = deleteRowData[deleteRowData.length - 1];

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
                    for (i = 0; i < array.length; i++) {
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
            if (grid.columns.length > 0) {
                grid.hideColumn('FIELD_CODE');
            }
          
        };

        $scope.getReportFile = function () {
            if (true) {
                debugger;
                window.location = bars.config.urlContent('/api/reporting/nbu/file?FileCodeBase64=') + $scope.fileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date + '&schemeCode=' + $scope.report.SCHEME_CODE;
            } else {
                bars.ui.alert({ text: 'Не обрано шаблон звіту!' });
            }
        };

        var getVersions = function (FileCodeBase64, kf, reportDate) {
            $http.get(bars.config.urlContent('/reporting/nbu/getVersions?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date)
                .then(function (request) {

                    $scope.VersionDatasours.transport.options.read.url = bars.config.urlContent('/reporting/nbu/getVersions?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date;
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
            $scope.VersionWindow.center().open();
            /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
            $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
            $scope.reportGridOptions.read;*/
        };

        $scope.VersionDatasours = new kendo.data.DataSource({
            type: 'aspnetmvc-ajax',
            autobind: false,
            transport: {
                read: {
                    type: "GET",
                    url: '',// bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date,
                    dataType: 'json',
                    cache: false,
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

        $scope.VersionGridOptions = {
            dataSource: $scope.VersionDatasours,
            autobind: false,
            sortable: true,
            filterable: true,
            resizable: true,
            selectable: "multiple",
            pageable: {
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
                    //format: 'string',
                    width: "12.5%"
                }, {
                    field: 'VERSION_ID',
                    title: 'number',
                    width: "12.5%"
                }, {
                    field: "FILE_CODE",
                    title: 'Код файлу',
                    width: "12.5%"
                }, {
                    field: "FILE_TYPE",
                    title: 'Тип файлу',
                    hidden: true,
                    //formate: 'string',
                    width: "12.5%"
                }, {
                    field: "FILE_ID",
                    hidden: true,
                    title: "Хто формував",
                    width: "12.5%"
                }, 
                {
                    field: "FILE_NAME",
                    title: 'Назва файлу',
                    //formate: "string",
                    width: "12.5%"
                }, {
                    field: "PERIOD",
                    title: 'Періодичність',
                    //format: 'string',
                    width: "12.5%"
                }, {
                    field: "START_TIME",
                    title: 'Початок </br> формування',
                    template: "<div>#=kendo.toString(START_TIME,'dd/MM/yyyy')#</div>",
                    width: "12.5%"
                }, {
                    field: "FINISH_TIME",
                    title: 'Закінчення </br> формування',
                    template: "<div>#=kendo.toString(FINISH_TIME,'dd/MM/yyyy')#</div>",
                    width: "12.5%"
                }, {
                    field: "STATUS",
                    title: 'Статус файлу',
                    //format: 'string',
                    width: "12.5%"
                }, {
                    field: "FIO",
                    title: 'Ініціатор </br> формування',
                    //formate: "string",
                    width: "12.5%"
                },{
                    field: "SCHEME_CODE",
                    title: 'Схема',
                    hidden: true,
                    //formate: "string",
                    width: "12.5%"
                }
            ]
        };
    //}]);
        
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
            /*close: function () {
                $scope.advertising = $scope.getNewAdvertising();
            },*/
            iframe: false

        }

$scope.VersionWindowOptions = {
    animation: false,
    visible: false,
    width: '1200px',
    height: '600px',
    actions: ["Maximize", "Minimize", "Close"],
    draggable: true,
    modal: true,
    pinned: false,
    resizable: true,
    title: 'версії файлу',
    position: 'center',
    /*close: function () {
        $scope.advertising = $scope.getNewAdvertising();
    },*/
    iframe: false

}

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
    change: function () {
        $('tr.ng-scope').dblclick(function () {
            $scope.OpenDetailedReportGrid(true);
        });
    },
    sortable: true,
    filterable: true,
    selectable: "multiple",
    pageable: {
        refresh: true,
        pageSizes: [10, 20, 50, 100],
        buttonCount: 5
    },
    columns: [

    ]
};

$scope.archiveWindowOptions = {
    animation: false,
    visible: false,
    wwidth: '1200px',
    height: '600px',
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
    $scope.archiveWindow.center().open();
    /*$scope.reportGridOptions.dataSource.transport.read.url = bars.config.urlContent('/reporting/nbu/getarchivegrid');
    $scope.reportGridOptions.dataSource.transport.read.data = { kodf: kodf };
    $scope.reportGridOptions.read;*/
};

$scope.OpenDetailedReportGrid = function (isRowDetailed) {

    //var gridrep = $("#reportGrid").data("kendoGrid");
    //var detailedGrid = $("#detailedReportGrid").data("kendoGrid");
    $scope.selectRowForDetailedReport = $scope.reportGrid.dataItem($scope.reportGrid.select());
    if (isRowDetailed == false)
        $scope.detailedReportGridOption.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/DetailedRep?fileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date);
    else
        $scope.detailedReportGridOption.dataSource.transport.read.url = bars.config.urlContent('/api/reporting/nbu/DetailedRep?fileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date + '&fieldCode=' + $scope.selectRowForDetailedReport['Column_FIELD_CODE']);
    //window.bars.ui.dialog({
    //    iframe: true,
    //    actions: ["Close"],
    //    width: '850px',
    //    height: '590px',
    //    id: 'winClientAddress',
    //    title: 'Повна адреса клієнта',
    //    content: {
    //        url: bars.config.urlContent('/ndi/ReferenceBook/GetRefBookData/?tableName=V_NBUR_DETAIL_PROTOCOLS'),
    //        modal: true
    //    }
    //    //close: function () {
    //    //    if (win.customerAddress.type1.filled == true) {
    //    //        window.parent.$('#bt_reg').prop("disabled", false);
    //    //        $('#ed_ADR').val(parent.obj_Parameters['fullADR'].type1.locality + ', ' + parent.obj_Parameters['fullADR'].type1.address);
    //    //    }
    //    //}
    //});

    $scope.detailedReportGrid.dataSource.read();
    $scope.detailedReportGrid.refresh();
    $scope.detailedReportWindow.center().open();
};

$scope.showArchWindow = function () {
    //var kodf = $scope.report.id;

    getArchiveGridData($scope.FileCodeBase64, $scope.report.KF, $scope.report.date);
    //$scope.archiveGridOption.dataSource.data = dSource;
    //$scope.archiveGrid.dataSource.read();
    //$scope.archiveGrid.refresh();


           
};


// ***************************

$scope.detailedReportGridOption = {
    //toolbar: ["pdf",'excel'],
    width: '99%',
    height: '99%',
    actions: ["Maximize", "Minimize", "Close"],
    buttons: [{
        text: 'Відмінити',
        click: function () { this.close(); }
    }],
    showNotActive: false,
    autoBind: false,
    dataSource: {

        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/api/reporting/nbu/DetailedRep?kodf=02&datf=23.11.2011'),

            }
        },

        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    BRANCH: { type: 'string' },
                    FIELD_CODE: { type: 'string' },
                    FIELD_VALUE: { type: 'string' },
                    ACC_ID: { type: 'number' },
                    ACC_NUM: { type: 'sting' },
                    KV: { type: "number" },
                    MATURITY_DATE: { type: "date" },
                    CUST_ID: { type: 'int' },
                    CUST_CODE: { type: 'string' },
                    CUST_NMK: { type: 'string' },
                    ND: { type: 'string' },
                    AGRM_NUM: { type: 'string' },
                    BEG_DT: { type: 'date' },
                    END_DT: { type: 'date' },
                    REF: { type: 'number' },
                    DESCRIPTION: { type: 'string' }
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
                    field: 'BRANCH ',
                    title: 'Відділення'//,
                   // width: 110
                },{
                    field: 'FIELD_CODE',
                    title: 'Значення </br> показника'//,
                   // width: 110
                },{
                    field: 'FIELD_VALUE',
                    title: 'Код </br> показника',
                    width: 110
                },{
                    field: 'ACC_ID',
                    title: 'Ідентифікатор </br> рахунку',
                    type: 'number'//,
                    //width: 110,
                },{
                     field: 'ACC_NUM',
                     title: 'Номер </br> рахунку'//,
                    // width: 110
                 },{
                     field: 'KV',
                     title: 'Код </br> валюти',
                     //width: 110,
                     type: "number"
                 },{
                     field: 'MATURITY_DATE',
                     title: 'Дата </br> погашення',
                     type: "number",
                     template: "<div style='text-align:right;'>#=MATURITY_DATE == null ? '' :kendo.toString(MATURITY_DATE,'dd/MM/yyyy')#</div>"//,
                    // width: 110
                 },{
                      field: 'CUST_ID',
                      title: 'РНК  </br> контрагента',
                      type: "number"//,
                     // width: 130
                  },{
                      field: 'CUST_CODE',
                      title: 'ІІН </br> контрагента'//,
                      //width: 110
                  },{
                      field: 'CUST_NMK',
                      title: 'Назва </br> контрагента'//,
                     // width: 110
                  },{
                       field: 'ND',
                       title: 'РЕФ </br> кредитного </br> договору'//,
                       //width: 110
                   },{
                        field: 'AGRM_NUM',
                        title: 'Номер <br> договору'//,
                        //width: 110
                    },{
                         field: 'BEG_DT',
                         title: 'Початок дії </br> договору',
                         template: "<div style='text-align:right;'>#=BEG_DT == null ? '' :kendo.toString(BEG_DT,'dd/MM/yyyy')#</div>"//,
                         //width: 110
                     },{
                         field: 'END_DT',
                         title: 'Дата </br> завершення </br> договору',
                         template: "<div style='text-align:right;'>#=BEG_DT == null ? '' :kendo.toString(BEG_DT,'dd/MM/yyyy')#</div>"//,
                        // width: 110
                     }, {
                         field: 'REF',
                         title: 'Номер  </br> документу',//,
                         type: "number",
                        // width: 110
                     }, {
                         field: 'DESCRIPTION',
                         title: 'Коментар'//,
                         //width: 110
                     }
    ]
};

$scope.archiveGridDataSource = new kendo.data.DataSource({
    type: 'aspnetmvc-ajax',
    autobind: false,
    transport: {
        read: {
            type: "GET",
            url: '',// bars.config.urlContent('/reporting/nbu/getarchivegrid?') + 'FileCodeBase64=' + $scope.FileCodeBase64 + '&kf=' + $scope.report.KF + '&reportDate=' + $scope.report.date,
            dataType: 'json',
            cache: false,
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
                TIME: { type: 'date' },
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
            //format: 'string',
            width: "12.5%"
        }, {
            field: "FILE_CODE",
            title: 'Код файлу',
            width: "12.5%"
        }, {
            field: "FILE_TYPE",
            title: 'Тип файлу',
            //formate: 'string',
            width: "12.5%"
        }, {
            field: "FILE_NAME",
            title: 'Назва файлу',
            //formate: "string",
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
            //format: 'string',
            width: "12.5%"
        }, {
            field: "TIME",
            title: 'Дата додавання </br> до черги',
            template: "<div>#=kendo.toString(REPORT_DATE,'dd/MM/yyyy')#</div>",
            width: "12.5%"
        }, {
            field: "FIO",
            title: 'Ініціатор </br> формування',
            //formate: "string",
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

