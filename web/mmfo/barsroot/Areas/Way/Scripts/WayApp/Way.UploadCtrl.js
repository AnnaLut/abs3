angular.module("BarsWeb.Controllers")
    .factory('transport', function () {
        return {
            gridItem: {},
            proccessedGridItem: {},
            noProccessedGrid: {},
            noProccessedGridItem: {},
            proccessedRow: {}, 
            DeletedGrid: {},
            DeletedGridItem: {}
        };
    })
    .controller("Way.UploadCtrl", function ($scope, $http, $location, transport) {

        var localUrl = $location.absUrl();
        $scope.type = bars.extension.getParamFromUrl('type', localUrl);

        $scope.isDownload = $scope.type == 'import' ? true : false;
        if ($scope.type == 'import') {
            $scope.Title = 'Way4. Імпорт та обробка файлів';
        }
        else if ($scope.type == 'protokol') {
            $scope.Title = 'Way4. Протокол обробки файлів від ПЦ';
        }

        /* --- Btns defState --- */
        $scope.enableBtn = false;
        $scope.enableReloadFileBtn = false;
        $scope.enableDelBtn = false;
        $scope.enableRevBtn = false;



        function getYesterdaysDate() {
            var date = new Date();
            date.setDate(date.getDate() - 1);
            var dd = (date.getDate() < 9 ? '0' + date.getDate() : date.getDate()) + '/',
                MM = ((date.getMonth() + 1) < 9 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)) + '/',
                yyyy = date.getFullYear();
            return dd + MM + yyyy;
        }

        var dateFrom = getYesterdaysDate();

        var dateTo = (new Date().getDate() < 9 ? '0' + new Date().getDate() : new Date().getDate()) +
            '/' + ((parseInt(new Date().getMonth(), 10) + 1) < 9 ? '0' + (parseInt(new Date().getMonth(), 10) + 1) : (parseInt(new Date().getMonth(), 10) + 1)) +
            '/' + new Date().getFullYear();
        $scope.dateObj = {
            dateFrom: dateFrom,
            dateTo: dateTo
        };


        $scope.refreshGrid = function () {
            $scope.enableBtn = false;
            $scope.enableReloadFileBtn = false;
            $scope.enableDelBtn = false;
            $scope.enableRevBtn = false;
            transport.gridItem = {};
            $scope._gridOptions.dataSource.read({
                dateFrom: function () {
                    return kendo.toString(kendo.parseDate($scope.dateObj.dateFrom), 'dd/MM/yyyy') || dateFrom;
                },
                dateTo: function () {
                    return kendo.toString(kendo.parseDate($scope.dateObj.dateTo), 'dd/MM/yyyy') || dateTo;
                },
                condition: $scope.base64Condition
            });
        };


        $scope._datepickerOptionsFrom = {
            format: '{0:dd/MM/yyyy}'
            /*,
		    change: function () {
		        $scope.refreshGrid();
		    }*/
        };

        $scope._datepickerOptionsTo = {
            format: '{0:dd/MM/yyyy}'
        };

        function clearFiter() {
            $("form.k-filter-menu button[type='reset']").trigger("click");
        }

        /*$scope.clearFilters = function () {
		    var columns = $scope.grid.columns;
		    for (var i = 0; i < columns.length; i++) {
		        if (columns[i].enableFiltering) {
		            columns[i].filters[0].term = '';
		        }
		    }
		};*/

        // init in dataBound:
        $scope.gridApi = null;

        $scope.clearFilters = function () {
            var gr = $scope.grid;
            var api = $scope.gridApi;

            $scope.grid.clearAllFilters();
        };

        /* --- upload file --- */
        $scope.showUploadWindow = function () {
            bars.ui.dialog({
                content: bars.config.urlContent('/way/wayapp/fileupload/'),
                iframe: true,
                width: '600px',
                height: '400px',
                title: 'Завантаження та обробка файлів',
                close: function () {
                    $scope.refreshGrid();
                }
            });
        }
        /* --- toolbar --- */
        $scope._toolbarOptions = {
            items: [
                {
                    template: '<label>Дата з </label><input kendo-date-picker k-ng-model="dateObj.dateFrom" k-options="_datepickerOptionsFrom" style="width: 120px;" />'
                },
                {
                    template: '<label> по </label><input kendo-date-picker k-ng-model="dateObj.dateTo" k-options="_datepickerOptionsTo" style="width: 120px;" />'
                },
                {
                    template: '<button class="k-button" title="Пошук" ng-click="refreshGrid()"><i class="pf-icon pf-16 pf-find"></i></button>'
                },
                /*{ type: 'separator' },
                {
                    template: '<button class="k-button" title="Відмінити фільтр" ng-click="clearFilters()"><i class="pf-icon pf-16 pf-filter-remove"></i></button>'
                },*/
                { type: 'separator' },
                {
                    template: '<button class="k-button" title="Обробити файл повторно" ng-click="reloadFile()" ng-disabled="!enableReloadFileBtn"><i class="pf-icon pf-16 pf-application-update"></i></button>'
                },
                {
                    template: '<button class="k-button" title="Вилучити файл" ng-click="deleteFile()" ng-disabled="!enableBtn"><i class="pf-icon pf-16 pf-delete"></i></button>'
                },
                {
                    template: '<button class="k-button" title="Оновити дані таблиці" ng-click="refreshGrid()"><i class="pf-icon pf-16 pf-reload_rotate"></i></button>'
                },
                { type: 'separator' },
                /*
                    template: '<button class="k-button" ng-disabled="!enableBtn" ng-click="processedWindowOpen()">Оброблені</button>'
                },*/
				/*{
                	type: "button",
                	text: '<div ng-show="isDownload"><i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл</div>',
                	click: function () {
                    	showUploadWindow();
                	}
            	}*/
                {
                    template: '<button class="k-button" title="Завантажити файл" ng-click="showUploadWindow()" ng-show="isDownload"><i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл</button>'
                }, {
                    template: '<button class="k-button"  title="Фільтри метаданних" ng-click="getMetaFilters()"><i class="pf-icon pf-16 pf-filter-ok"></i></button>'
                }, {
                    template: '<button class="k-button"  title="Скинути Фільтри метаданних" ng-click="removeMetaFilters()"><i class="pf-icon pf-16 pf-filter-remove"></i></button>'
                },
                { template: '<a class="k-button" title="Вивантажити в Excel" ng-click="saveAsmaingrid(1)" ><i class="pf-icon pf-16 pf-exel"></i></a>' }
            ]
        };

        var Base64 = {
            _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
            encode: function (e) {
                var t = ""; var n, r, i, s, o, u, a; var f = 0; e = Base64._utf8_encode(e);
                while (f < e.length) { n = e.charCodeAt(f++); r = e.charCodeAt(f++); i = e.charCodeAt(f++); s = n >> 2; o = (n & 3) << 4 | r >> 4; u = (r & 15) << 2 | i >> 6; a = i & 63; if (isNaN(r)) { u = a = 64 } else if (isNaN(i)) { a = 64 } t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a) } return t
            }, decode: function (e) {
                var t = ""; var n, r, i; var s, o, u, a; var f = 0; e = e.replace(/[^A-Za-z0-9+/=]/g, "");
                while (f < e.length) { s = this._keyStr.indexOf(e.charAt(f++)); o = this._keyStr.indexOf(e.charAt(f++)); u = this._keyStr.indexOf(e.charAt(f++)); a = this._keyStr.indexOf(e.charAt(f++)); n = s << 2 | o >> 4; r = (o & 15) << 4 | u >> 2; i = (u & 3) << 6 | a; t = t + String.fromCharCode(n); if (u != 64) { t = t + String.fromCharCode(r) } if (a != 64) { t = t + String.fromCharCode(i) } } t = Base64._utf8_decode(t); return t
            }, _utf8_encode: function (e) { e = e.replace(/rn/g, "n"); var t = ""; for (var n = 0; n < e.length; n++) { var r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r) } else if (r > 127 && r < 2048) { t += String.fromCharCode(r >> 6 | 192); t += String.fromCharCode(r & 63 | 128) } else { t += String.fromCharCode(r >> 12 | 224); t += String.fromCharCode(r >> 6 & 63 | 128); t += String.fromCharCode(r & 63 | 128) } } return t },
            _utf8_decode: function (e) { var t = ""; var n = 0; var r = c1 = c2 = 0; while (n < e.length) { r = e.charCodeAt(n); if (r < 128) { t += String.fromCharCode(r); n++ } else if (r > 191 && r < 224) { c2 = e.charCodeAt(n + 1); t += String.fromCharCode((r & 31) << 6 | c2 & 63); n += 2 } else { c2 = e.charCodeAt(n + 1); c3 = e.charCodeAt(n + 2); t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63); n += 3 } } return t }
        }

        //function getMetaFilterString() {
        //    var filterStr = window.metadataFiltersQuery === undefined ? '' : window.metadataFiltersQuery;
        //    return filterStr;
        //};

        //function setMetaFilterString(filterString) {
        //    window.metadataFiltersQuery = filterString == undefined ? '' : Base64.encode(filterString);
        //    return window.metadataFiltersQuery;
        //};

        $scope.saveAsmaingrid = function saveexcel(typeGrid) {
            var grid;
            if (typeGrid == 1)
                grid = $scope.grid;
            else if (typeGrid == 2)
                grid = $('#proccessedGridId').data("kendoGrid");
            else if (typeGrid == 3)
                grid = $('#NoProccessedGridId').data("kendoGrid");
            else if (typeGrid == 4)
                grid = $('#DeletedGridId').data("kendoGrid");
            grid.saveAsExcel();
        };
        $scope.getMetaFilters = function getFilters() {
            var filters;
            bars.ui.getFiltersByMetaTable(function (response, success) {

                if (!success)
                    return false;


                if (response.length > 0)
                    filters = response.join(' and ');
                else
                    filters = '';
                $scope.base64Condition = filters == '' ? '' : Base64.encode(filters);
                $scope.refreshGrid();


            }, { tableName: "V_OW_FILES" });
        };

        $scope.removeMetaFilters = function removeFilters() {
            $scope.base64Condition = '';
            $scope.refreshGrid();

        };
        $scope.base64Condition = '';
        /* --- DataSource for grid --- */
        $scope.dataSource = new kendo.data.DataSource({
            type: 'webapi',
            transport: {
                read: {
                    type: 'GET',
                    url: bars.config.urlContent('/api/way/waydoc/get'),
                    dataType: 'json',
                    data: {
                        dateFrom: function () {
                            /*return kendo.toString(kendo.parseDate(dateFrom), 'dd/MM/yyyy') || dateFrom;*/
                            return dateFrom;
                        },
                        dateTo: function () {
                            /*return kendo.toString(kendo.parseDate(dateTo), 'dd/MM/yyyy') || dateTo;*/
                            return dateTo;
                        },
                        condition: function () {
                            return $scope.base64Condition;
                        }

                    }
                },
            },
            requestStart: function () {
                bars.ui.loader("body", true);
            },
            requestEnd: function (e) {
                bars.ui.loader("body", false);
            },
            schema: {
                data: function (result) {
                    return result.Data.Data || (function () {
                        return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Message });
                    })();
                },
                total: function (result) {
                    return result.Data.Total || 0;
                },
                model: {
                    fields: {
                        ID: { type: "number" },
                        FILE_NAME: { type: "string" },
                        FILE_TYPE: { type: "string" },
                        FILE_DATE: { type: "date" },
                        FILE_STATUS: { type: "number" },
                        //FILE_N: { type: "string" },
                        FILE_N: { type: "number" },
                        N_OPL: { type: "number" },
                        N_ERR: { type: "number" },
                        N_DEL: { type: "number" },
                        N_ABS: { type: "number" },
                        ERR_TEXT: { type: "string" }
                    }
                }
            },
            pageSize: 10,
            resizable: true
            //serverPaging: true,
            //serverSorting: true,
            //serverFiltering: true
        });


        /* --- Grids events --- */
        $scope.onSelection = function (data, kendoEvent) {
            if (kendoEvent.sender.select().length > 0) {
                transport.gridItem = data;
                $scope.enableBtn = true;
                $scope.enableReloadFileBtn = data.N_ERR > 0 ? true : false;
            } else {
                transport.gridItem = {};
                $scope.enableBtn = false;
                $scope.enableReloadFileBtn = false;
            }
        };

        /* ---Additional Grids events --- */
        $scope.onSelectionAdd = function (data, kendoEvent, btnName, grdItem) {
            if (kendoEvent.sender.select().length > 0) {
                //$scope.enableDelBtn = true;
                $scope[btnName] = true;
                transport[grdItem] = data;
            } else {
                $scope[btnName] = false;
                transport[grdItem] = {};
            }
        };

        /* --- file reload --- */
        $scope.reloadFile = function () {

            var url = '/api/way/waydoc/put?id=' + transport.gridItem.ID;

            var reloadFileService = $http.put(bars.config.urlContent(url));

            bars.ui.loader('body', true);

            reloadFileService.success(function (result) {
                if (result.Data !== 0) {
                    bars.ui.loader('body', false);
                    //bars.ui.alert({ text: result.Message });
                    $scope.refreshGrid();
                    bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                } else {
                    bars.ui.loader('body', false);
                    bars.ui.error({ text: 'Помилка : ' + result.Message });
                    //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                }
            });
        };

        /* --- file delete --- */
        $scope.deleteFile = function () {
            bars.ui.confirm({ text: 'Ви дійсно бажаєте вилучити файл ID: ' + transport.gridItem.ID + ' ?' }, function () {

                var url = '/api/way/waydoc/delete?id=' + transport.gridItem.ID;

                var fileDeleteService = $http['delete'](bars.config.urlContent(url));

                bars.ui.loader('body', true);

                fileDeleteService.success(function (result) {
                    if (result.Data !== 0) {
                        bars.ui.loader('body', false);
                        //bars.ui.alert({ text: result.Message });
                        $scope.refreshGrid();
                        bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                    } else {
                        bars.ui.loader('body', false);
                        bars.ui.error({ text: 'Помилка : ' + result.Message });
                        //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                    }
                });
            });
        };

        /* --- Grid --- */
        $scope._gridOptions = {
            autoBind: true,
            selectable: 'row',
            sortable: true,
            resizable: true,
            pageable: {
                refresh: false,
                pageSizes: [10, 30, 45, 60],
                buttonCount: 5,
            },
            dataSource: $scope.dataSource,
            columns: [
                { field: "ID", title: "Ід. файлу", width: 100, filterable: true },
                { field: "FILE_NAME", title: "Назва файлу", width: 350, filterable: true },
                { field: "FILE_TYPE", title: "Тип файлу", width: 100, filterable: true },

                //------Mine-------------
                {
                    field: "FILE_DATE", title: "Дата файлу",
                    template: "<div>#=kendo.toString(kendo.parseDate(FILE_DATE),'dd.MM.yyyy HH:mm:ss')#</div>", width: 200,
                    filterable: {
                        cell: {
                            template: function (args) {
                                args.element.kendoDatePicker({
                                    format: "{0:dd.MM.yyyy}",
                                    parseFormats: "{0:dd.MM.yyyy}",
                                });
                            }
                        }
                    }
                },
                //-------------------


                { field: "FILE_STATUS", title: "Статус", width: 75, filterable: true },
                { field: "FILE_N", title: "Кількість<br/>документів", width: 100, filterable: true },
                { field: "N_OPL", title: "Кількість оброблених<br/>документів", width: 100, filterable: true },
                { field: "N_ERR", title: "Кількість необроблених<br/>документів", width: 100, filterable: true },
                { field: "N_DEL", title: "Кількість видалених<br/>з обробки документів", width: 100, filterable: true },
                { field: "N_ABS", title: "Кількість створених<br/>документів АБС", width: 100, filterable: true },
                { field: "ERR_TEXT", title: "Опис помилки", width: 200 }

            ],
            filterable: true,
            dataBound: function () {
                var dataSource = this.dataSource;
                this.element.find('tr.k-master-row').each(function () {

                    var row = $(this);
                    var data = dataSource.getByUid(row.data('uid'));

                    // disable details
                    if (data.FILE_TYPE === 'CNGEXPORT' || data.FILE_TYPE === 'R_IIC_DOCUMENTS') {
                        row.find('.k-hierarchy-cell a').css({ opacity: 0.3, cursor: 'default' }).click(function (e) { e.stopImmediatePropagation(); return false; });
                    }

                    // adding bg-color:
                    if (data.FILE_STATUS === 3) {
                        row.css('background-color', '#fb8888');
                    }
                    if (data.FILE_STATUS === 2 && data.N_ERR > 0) {
                        row.css('background-color', '#e0a1fb');
                    }
                });
            },
            onRegisterApi: function (gridApi) {
                $scope.gridApi = gridApi;
            },
            excelExport: function (e) {


                if (!exportFlag) {

                    e.preventDefault();
                    exportFlag = true;
                    setTimeout(function () {
                        e.sender.saveAsExcel();
                    });



                } else {
                    var rows = e.workbook.sheets[0].rows;
                    var row = rows[0];
                    for (var ci = 0; ci < row.cells.length; ci++) {
                        var cell = row.cells[ci];
                        if (cell.value) {
                            cell.value = cell.value.replace(/<br\/>/g, ' ');
                        }
                    }

                    exportFlag = false;
                }
            },
            excel: {
                fileName: "FileList.xls",
                proxyURL: bars.config.urlContent('/way/WayApp/ConvertBase64ToFile/'),
                allPages: true
            }
        };

        /* --- Detail grid --- */
        $scope.file = {};

        $scope.detailGridOptions = function (dataItem) {
            transport.proccessedGridItem = dataItem;
            var proccessedDataSource = new kendo.data.DataSource({
                type: 'webapi',
                transport: {
                    read: {
                        type: 'GET',
                        url: bars.config.urlContent('/api/way/waydocdetails/get'),
                        dataType: 'json',
                        data: {
                            id: function () {
                                return transport.proccessedGridItem.ID;
                            }
                        }
                    }
                },
                schema: {
                    data: function (result) {
                        return result.Data.Data || (function () {
                            return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Message });
                        })();
                    },
                    total: function (result) {
                        return result.Data.Total || 0;
                    },
                    model: {
                        fields: {
                            MFOA: { type: "string" }, // МФО отправителя
                            MFOB: { type: "string" }, // МФО получателя
                            NLSA: { type: "string" }, // Счет отправителя
                            NLSB: { type: "string" }, // Счет получателя
                            Sgrn: { type: "number" }, // Сумма
                            KV: { type: "number" }, // Код валюты
                            LCV: { type: "string" }, // Симв Код
                            DIG: { type: "number" }, // Коп
                            Sgrn2: { type: "number" }, // Сумма документа 2
                            KV2: { type: "number" }, // Код валюты 2
                            LCV2: { type: "string" }, // Симв Код
                            DIG2: { type: "number" }, // Коп
                            SK: { type: "number" }, // Символ кассплана
                            DK: { type: "number" }, // Д/К
                            VOB: { type: "number" }, // Вид банковского документа
                            DATD: { type: "date" }, // Дата документа
                            VDAT: { type: "date" }, // Плановая дата валютирования
                            TT: { type: "string" }, // Тип транзакции
                            ID: { type: "number" }, // REF - Внутренний номер документа
                            REF: { type: "number" }, // Внутренний номер документа
                            SOS: { type: "number" }, // Состояние документа
                            USERID: { type: "number" },
                            ND: { type: "string" }, // Номер документа
                            NAZN: { type: "string" }, // Назначение платежа
                            ID_A: { type: "string" }, // Идент. код отправителя
                            NAM_A: { type: "string" }, // Наименование отправителя
                            ID_B: { type: "string" }, // Идент. код получателя
                            NAM_B: { type: "string" }, // Наименование получателя
                            TOBO: { type: "string" } // Код безбалансового отделения
                        }

                    }
                },
                pageSize: 10,
                aggregate: [
                    { field: "Sgrn", aggregate: "sum" },
                    { field: "Sgrn2", aggregate: "sum" }
                ],
                resizable: true,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            return {
                autoBind: true,
                selectable: 'row',
                sortable: true,
                resizable: true,
                pageable: {
                    refresh: false,
                    pageSizes: [15, 30, 45, 60],
                    buttonCount: 5
                },
                excelExport: function (e) {


                    if (!exportFlag) {
                        e.preventDefault();
                        exportFlag = true;
                        setTimeout(function () {
                            e.sender.saveAsExcel();
                        });



                    } else {
                        var rows = e.workbook.sheets[0].rows;
                        var row = rows[0];
                        for (var ci = 0; ci < row.cells.length; ci++) {
                            var cell = row.cells[ci];
                            if (cell.value) {
                                cell.value = cell.value.replace(/<br\/>/g, ' ');
                            }
                        }

                        exportFlag = false;
                    }
                },
                excel: {
                    fileName: "ProccesedDocList.xls",
                    proxyURL: bars.config.urlContent('/way/WayApp/ConvertBase64ToFile/'),
                    allPages: true
                },
                dataSource: proccessedDataSource,
                toolbar: [{ template: '<a class="k-button" title="Вивантажити в Excel" ng-click="saveAsmaingrid(2)" ><i class="pf-icon pf-16 pf-exel"></i></a>' }],
                columns: [
                    /*{ field: "RefInfo", title: "REF_Info", template: "<button class='k-button' ng-click='refInfo()'><i class='pf-icon pf-16 pf-accept_doc'></i></button>" },*/
                    {
                        field: "REF",
                        title: "Внутрішній<br/>номер<br/>документа",
                        template: "<a href='/barsroot/documentview/default.aspx?ref=#:REF#'><font color='6db8e6'>#:REF#</font></a>",
                        footerTemplate: "Всього:",
                        width: 100
                    },
                    { field: "MFOA", title: "МФО<br/>відправника", width: 100 },
                    { field: "NLSA", title: "Рахунок<br/>відправника", width: 150 },
                    { field: "MFOB", title: "МФО<br/>отримувача", width: 100 },
                    { field: "NLSB", title: "Рахунок<br/>отримувача", width: 150 },
                    { field: "Sgrn", title: "Сума в гривнях", footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>", width: 120 },
                    { field: "KV", title: "Код<br/>валюти", width: 75 },
                    { field: "LCV", title: "Симв. код", width: 75 },
                    // { field: "DIG", title: "Коп", width: 75 },
                    { field: "Sgrn2", title: "Сума<br/>еквіваленту", footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum, 'N')#</div>", width: 120 },
                    { field: "KV2", title: "Код<br/>валюти<br/>еквіваленту", width: 80 },
                    { field: "LCV2", title: "Симв.<br/>код екв.<br/>Сума в гривнях", width: 90 },
                    //{ field: "DIG2", title: "Коп 2", width: 75 },
                    { field: "SK", title: "Символ<br/>кассплана", width: 75 },
                    { field: "DK", title: "Д/К", width: 100 },
                    { field: "VOB", title: "Вид <br/>банківського<br/>документа", width: 100 },
                    { field: "DATD", title: "Дата<br/>документа", template: "#= kendo.toString(kendo.parseDate(DATD, 'yyyy-MM-dd'), 'dd/MM/yyyy') #", width: 100 },
                    { field: "VDAT", title: "Планова<br/>дата<br/>валютування", template: "#= kendo.toString(kendo.parseDate(VDAT, 'yyyy-MM-dd'), 'dd/MM/yyyy') #", width: 100 },
                    { field: "TT", title: "Тип<br/>транзакції", width: 100 },
                    { field: "ID", title: "REF - <br/>Внутрішній номер<br/> документа", width: 100 },
                    { field: "SOS", title: "Стан<br/>документа", width: 100 },
                    { field: "USERID", title: "Іден. користувача", width: 100 },
                    { field: "ND", title: "Номер<br/>документа", width: 100 },
                    { field: "NAZN", title: "Призначення<br/>платежу", width: 250 },
                    { field: "ID_A", title: "Ідент. код<br/>відправника", width: 100 },
                    { field: "NAM_A", title: "Ім’я<br/>відправника", width: 200 },
                    { field: "ID_B", title: "Ідент. код<br/>отримувача", width: 100 },
                    { field: "NAM_B", title: "Ім’я<br/>отримувача", width: 200 },
                    { field: "TOBO", title: "Код безбалансового<br/>віділення", width: 100 }
                ],
                filterable: true,
                dataBound: function () {
                    var dataSource = this.dataSource;

                    this.element.find('tr.ng-scope').each(function () {

                        var row = $(this);
                        var data = dataSource.getByUid(row[0].attributes['data-uid'].value)

                        // disable details
                        //if (data.SOS === 1) {
                        //    row.find('.k-hierarchy-cell a').css({ opacity: 0.3, cursor: 'default' }).click(function (e) { e.stopImmediatePropagation(); return false; });
                        //}
                        switch (data.SOS) {
                            case -2:
                                row.css('color', '#C34722');
                                break;
                            case -1:
                                row.css('color', '#DC3E59');
                                break;
                            case 0:
                                row.css('color', '#17D8CB');
                                break;
                            case 1:
                                row.css('color', '#198415');
                                break;
                            case 2:
                                row.css('color', '#9999FF');
                                break;
                            case 3:
                                row.css('color', '#3E4EDC');
                                break;
                            case 4:
                                row.css('color', '#660000');
                                break;
                            case 5:
                                row.css('color', '#000000');
                                break;

                            default:
                                break;

                        }


                    });


                }
            }
        };



        /* --- Proccessed files grids events --- */
        $scope.onDetailSelection = function (data, kendoEvent) {
            if (kendoEvent.sender.select().length > 0) {
                transport.proccessedRow = data;
            } else {
                bars.ui.error({ text: "Не має значення для відображення!" });
            }
        };

        /* --- open REF info --- */
        $scope.refInfo = function () {
            if (transport.proccessedRow) {
                var url = '/barsroot/docview/item/?id=' + transport.proccessedRow.REF + '&partial=true';
                window.location = url;
            }
        };

        /* --- NoProccessed Files Grid --- */
        $scope.noProccessedOptions = function (dataItem) {

            transport.noProccessedGridItem = dataItem;
            transport.noProccessedGrid = $scope.noProccessedGrid;

            var columns = [];

            switch (dataItem.FILE_TYPE) {
                case 'ATRANSFERS':
                case 'FTRANSFERS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "URL", width: 125, template: "<i class='pf-icon pf-16 pf-document_header_footer-ok2'><span style='margin-left:20px;'>#=URL#</span></i>" },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "SYNTHCODE", title: "Код синтетичнаої<br/>проводки", width: 75 },
                        { field: "DOC_DRN", title: "Документ ДРН", width: 100 },
                        { field: "DOC_ORN", title: "Документ ОРН", width: 100 },
                        //{ field: "DK", title: "Д/К", width: 75 },
                        { field: "NLSA", title: "Рахунок<br/>відправника", width: 150 },
                        { field: "Sgrn", title: "Сума <br/> в гривнях", width: 75 },
                        { field: "KV", title: "Код валюти", width: 75 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума екв.", width: 75 },
                        { field: "KV2", title: "Код<br/> валюти екв.", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "INST_CHAIN_IDT", title: "ІД субдоговору", width: 75 },
                        { field: "INST_PLAN_ID", title: "ІД плану", width: 75 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
                case 'DOCUMENTS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "URL", width: 125, template: "<i class='pf-icon pf-16 pf-document_header_footer-ok2'><span style='margin-left:20px;'>#=URL#</span></i>" },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "NLSA", title: "Рахунок відправника", width: 150 },
                        { field: "Sgrn", title: "Сума", width: 75},
                        { field: "KV", title: "Код<br/>валюти", width: 75 },
                        { field: "MFOB", title: "МФО отримувача", width: 100 },
                        { field: "ID_B", title: "ІПН отримувача", width: 100 },
                        { field: "NAM_B", title: "Ім’я отримувача", width: 200 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума 2", width: 75 },
                        { field: "KV2", title: "Код<br/>валюти 2", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 },
                        { field: "FAILURES_COUNT", title: "Кількість спроб<br/>обробки", width: 100 }
                    ];
                    break;
                case 'STRANSFERS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "URL", width: 125, template: "<i class='pf-icon pf-16 pf-document_header_footer-ok2'><span style='margin-left:20px;'>#=URL#</span></i>" },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "NLSA", title: "Рахунок відправника", width: 150 },
                        { field: "Sgrn", title: "Сума", width: 75 },
                        { field: "KV", title: "Код<br/>валюти", width: 75 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума 2", width: 75 },
                        { field: "KV2", title: "Код<br/>валюти 2", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
            }
            if (dataItem.FILE_NAME.indexOf('_LOCPAY_') === -1 && dataItem.FILE_TYPE == 'DOCUMENTS')
                columns.splice(-1, 1);


            var noProccessedDataSource = new kendo.data.DataSource({
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        type: 'GET',
                        url: bars.config.urlContent('/api/way/waydocdetails/get'),
                        dataType: 'json',
                        data: {
                            id: function () {
                                return transport.proccessedGridItem.ID;
                            }, mode: dataItem.FILE_TYPE
                        }
                    }
                },
                schema: {
                    data: function (result) {

                        return result.Data.Data || (function () {
                            return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Message });
                        })();
                    },
                    total: function (result) {
                        return result.Data.Total || 0;
                    },
                    model: {
                        fields: {
                            ID: { type: "number" },
                            IDN: { type: "number" },
                            NLSA: { type: "string" },
                            Sgrn: { type: "number" },
                            KV: { type: "number" },
                            MFOB: { type: "string" },
                            ID_B: { type: "string" },
                            NAM_B: { type: "string" },
                            NLSB: { type: "string" },
                            Sgrn2: { type: "number" },
                            KV2: { type: "number" },
                            NAZN: { type: "string" },
                            ERR_TEXT: { type: "string" },
                            URL: { type: "string" },
                            FAILURES_COUNT: { type: "number" },
                            SYNTHCODE: { type: "string" },
                            DOC_DRN: { type: "number" },
                            DOC_ORN: { type: "number" }
                        }
                    }
                },
                pageSize: 10,
                resizable: true,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            var options = {
                autoBind: true,
                selectable: 'row',
                sortable: true,
                resizable: true,
                pageable: {
                    refresh: false,
                    pageSizes: [15, 30, 45, 60],
                    buttonCount: 5
                },
                dataSource: noProccessedDataSource,
                filterable: true,
                columns: columns,
                toolbar: [{ template: '<a class="k-button" title="Вивантажити в Excel" ng-click="saveAsmaingrid(3)" ><i class="pf-icon pf-16 pf-exel"></i></a>' },
                { template: '<a class="k-button" title="Вилучити з обробки" ng-click="setRowState(99, \'Ви дійсно бажаєте вилучити з обробки запис №: \', \'noProccessedGridItem\')" ng-disabled="!enableDelBtn"><i class="pf-icon pf-16 pf-delete"></i></a>' }
                ],
                excelExport: function (e) {


                    if (!exportFlag) {
                        e.sender.hideColumn("URL");
                        e.preventDefault();
                        exportFlag = true;
                        setTimeout(function () {
                            e.sender.saveAsExcel();
                        });



                    } else {
                        var rows = e.workbook.sheets[0].rows;
                        var row = rows[0];
                        for (var ci = 0; ci < row.cells.length; ci++) {
                            var cell = row.cells[ci];
                            if (cell.value) {
                                cell.value = cell.value.replace(/<br\/>/g, ' ');
                            }
                        }
                        e.sender.showColumn("URL");
                        exportFlag = false;
                    }
                },
                excel: {
                    fileName: "NotProccesedDocList.xls",
                    proxyURL: bars.config.urlContent('/way/WayApp/ConvertBase64ToFile/'),
                    allPages: true
                },

            }

            return options;
        };

        /* --- Deleted Files Grid --- */
        $scope.DeletedOptions = function (dataItem) {

            transport.DeletedGridItem = dataItem;
            transport.DeletedGrid = $scope.DeletedGrid;

            var columns = [];

            switch (dataItem.FILE_TYPE) {
                case 'ATRANSFERS':
                case 'FTRANSFERS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "SYNTHCODE", title: "Код синтетичнаої<br/>проводки", width: 75 },
                        { field: "DOC_DRN", title: "Документ ДРН", width: 100 },
                        { field: "DOC_ORN", title: "Документ ОРН", width: 100 },
                        //{ field: "DK", title: "Д/К", width: 75 },
                        { field: "NLSA", title: "Рахунок<br/>відправника", width: 150 },
                        { field: "Sgrn", title: "Сума <br/> в гривнях", width: 75 },
                        { field: "KV", title: "Код валюти", width: 75 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума екв.", width: 75 },
                        { field: "KV2", title: "Код<br/> валюти екв.", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
                case 'DOCUMENTS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "NLSA", title: "Рахунок відправника", width: 150 },
                        { field: "Sgrn", title: "Сума", width: 75 },
                        { field: "KV", title: "Код<br/>валюти", width: 75 },
                        { field: "MFOB", title: "МФО отримувача", width: 100 },
                        { field: "ID_B", title: "ІПН отримувача", width: 100 },
                        { field: "NAM_B", title: "Ім’я отримувача", width: 200 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума 2", width: 75 },
                        { field: "KV2", title: "Код<br/>валюти 2", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
                case 'STRANSFERS':
                    columns = [
                        { field: "ID", width: 50, hidden: true },
                        { field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
                        { field: "NLSA", title: "Рахунок відправника", width: 150 },
                        { field: "Sgrn", title: "Сума", width: 75 },
                        { field: "KV", title: "Код<br/>валюти", width: 75 },
                        { field: "NLSB", title: "Рахунок отримувача", width: 150 },
                        { field: "Sgrn2", title: "Сума 2", width: 75 },
                        { field: "KV2", title: "Код<br/>валюти 2", width: 75 },
                        { field: "NAZN", title: "Призначення платежу", width: 350 },
                        { field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
            }


            var DeletedDataSource = new kendo.data.DataSource({
                type: "aspnetmvc-ajax",
                transport: {
                    read: {
                        type: 'GET',
                        url: bars.config.urlContent('/api/way/waydocdetails/get'),
                        dataType: 'json',
                        data: {
                            id: function () {
                                return transport.proccessedGridItem.ID;
                            }, mode: dataItem.FILE_TYPE + "DEL"
                        }
                    }
                },
                schema: {
                    data: function (result) {

                        return result.Data.Data || (function () {
                            return bars.ui.error({ text: 'Помилка отримання значень таблиці:<br/>' + result.Message });
                        })();
                    },
                    total: function (result) {
                        return result.Data.Total || 0;
                    },
                    model: {
                        fields: {
                            ID: { type: "number" },
                            IDN: { type: "number" },
                            NLSA: { type: "string" },
                            Sgrn: { type: "number" },
                            KV: { type: "number" },
                            MFOB: { type: "string" },
                            ID_B: { type: "string" },
                            NAM_B: { type: "string" },
                            NLSB: { type: "string" },
                            Sgrn2: { type: "number" },
                            KV2: { type: "number" },
                            NAZN: { type: "string" },
                            ERR_TEXT: { type: "string" },
                            URL: { type: "string" },
                            FAILURES_COUNT: { type: "number" },
                            SYNTHCODE: { type: "string" },
                            DOC_DRN: { type: "number" },
                            DOC_ORN: { type: "number" }
                        }
                    }
                },
                pageSize: 10,
                resizable: true,
                serverPaging: true,
                serverSorting: true,
                serverFiltering: true
            });

            var options = {
                autoBind: true,
                selectable: 'row',
                sortable: true,
                resizable: true,
                pageable: {
                    refresh: false,
                    pageSizes: [15, 30, 45, 60],
                    buttonCount: 5
                },
                filterable: true,
                dataSource: DeletedDataSource,
                columns: columns,
                toolbar: [{ template: '<a class="k-button" title="Вивантажити в Excel" ng-click="saveAsmaingrid(4)" ><i class="pf-icon pf-16 pf-exel"></i></a>' },
                { template: '<a class="k-button" title="Повернути в обробку" ng-click="setRowState(0,\'Ви дійсно бажаєте повернути в обробку запис №: \', \'DeletedGridItem\')" ng-disabled="!enableRevBtn"><i class="pf-icon pf-16 pf-arrow_left"></i></a>' }
                ],
                excelExport: function (e) {


                    if (!exportFlag) {
                        e.preventDefault();
                        exportFlag = true;
                        setTimeout(function () {
                            e.sender.saveAsExcel();
                        });



                    } else {
                        var rows = e.workbook.sheets[0].rows;
                        var row = rows[0];
                        for (var ci = 0; ci < row.cells.length; ci++) {
                            var cell = row.cells[ci];
                            if (cell.value) {
                                cell.value = cell.value.replace(/<br\/>/g, ' ');
                            }
                        }
                        exportFlag = false;
                    }
                },
                excel: {
                    fileName: "DeletedDocList.xls",
                    proxyURL: bars.config.urlContent('/way/WayApp/ConvertBase64ToFile/'),
                    allPages: true
                },

            }

            return options;
        };

        /* --- REfresh additionals grid--- */
        $scope.refreshAdditionalGrid = function () {
            $scope.enableDelBtn = false;
            $scope.enableRevBtn = false
            transport.noProccessedGridItem = {};
            transport.DeletedGridItem = {};
            $('#NoProccessedGridId').data("kendoGrid").dataSource.read();
            $('#DeletedGridId').data("kendoGrid").dataSource.read();
        };

        /* --- set row state --- */
        $scope.setRowState = function (state, txt, grdItem) {
            bars.ui.confirm({ text: txt + transport[grdItem].IDN + ' ?' }, function () {

                var url = '/api/way/waydoc/SetRowState?id=' + transport.proccessedGridItem.ID + '&idn=' + transport[grdItem].IDN + '&state=' + state;

                var fileDeleteService = $http['put'](bars.config.urlContent(url));

                bars.ui.loader('body', true);

                fileDeleteService.success(function (result) {
                    if (result.Data !== 0) {
                        bars.ui.loader('body', false);
                        //bars.ui.alert({ text: result.Message });
                        $scope.refreshAdditionalGrid();
                        bars.ui.notify(result.Message, '', 'success', { width: 'auto' });
                    } else {
                        bars.ui.loader('body', false);
                        bars.ui.error({ text: 'Помилка : ' + result.Message });
                        //bars.ui.notify('Помилка : ' + result.Message, '', 'error', { width: 'auto'});
                    }
                });
            });
        };


        var exportFlag = false;
    });
