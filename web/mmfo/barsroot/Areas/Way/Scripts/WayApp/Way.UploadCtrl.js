angular.module("BarsWeb.Controllers")
    .factory('transport', function () {
        return {
            gridItem: {},
            proccessedGridItem: {},
            noProccessedGrid: {},
            noProccessedGridItem: {},
            proccessedRow: {}
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

        function getYesterdaysDate() {
            var date = new Date();
            date.setDate(date.getDate() - 1);
            var dd = date.getDate() + '/',
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
                    template: '<button class="k-button" title="Видалити файл" ng-click="deleteFile()" ng-disabled="!enableBtn"><i class="pf-icon pf-16 pf-delete"></i></button>'
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
                },{
                    template: '<button class="k-button"  title="Фільтри метаданних" ng-click="getMetaFilters()"><i class="pf-icon pf-16 pf-filter-ok"></i></button>'
                }, {
                    template: '<button class="k-button"  title="Скинути Фільтри метаданних" ng-click="removeMetaFilters()"><i class="pf-icon pf-16 pf-filter-remove"></i></button>'
                }
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
                            return kendo.toString(kendo.parseDate($scope.dateObj.dateFrom), 'dd/MM/yyyy') || dateFrom;
                        },
                        dateTo: function () {
                            return kendo.toString(kendo.parseDate($scope.dateObj.dateTo), 'dd/MM/yyyy') || dateTo;
                        },
                        condition:function () {
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
            resizable: true,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true
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
            bars.ui.confirm({ text: 'Ви дійсно бажаєте видалити файл ID: ' + transport.gridItem.ID + ' ?' }, function () {

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
            filterable: { mode: "row" },
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
                    model: {}
                },
                pageSize: 10,
                aggregate:[
                    { field: "S", aggregate: "sum" },
                     { field: "S2", aggregate: "sum" }
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
                    refresh: true,
                    pageSizes: [15, 30, 45, 60],
                    buttonCount: 5
                },
                dataSource: proccessedDataSource,
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
                    { field: "S", title: "Сума в гривнях", template: "#=kendo.format('{0:n2}', S/100)#", footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum/100, 'N')#</div>", width: 120 },
                    { field: "KV", title: "Код<br/>валюти", width: 75 },
                    { field: "LCV", title: "Симв. код", width: 75 },
                   // { field: "DIG", title: "Коп", width: 75 },
                    { field: "S2", title: "Сума<br/>еквіваленту", template: "#=kendo.format('{0:n2}', S2/100)# ", footerTemplate: "<div style='text-align: right;'>#=kendo.toString(sum/100, 'N')#</div>", width: 120 },
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
						{ field: "S", title: "Сума <br/> в гривнях", template: "#=kendo.format('{0:n2}', S/100)#", width: 75 },
						{ field: "KV", title: "Код валюти", width: 75 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума екв.",template: "#=kendo.format('{0:n2}', S2/100)#", width: 75 },
						{ field: "KV2", title: "Код<br/> валюти екв.", width: 75 },
						{ field: "NAZN", title: "Призначення платежу", width: 350 },
						{ field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
                case 'DOCUMENTS':
                    columns = [
						{ field: "ID", width: 50, hidden: true },
                        { field: "URL", width: 125, template: "<i class='pf-icon pf-16 pf-document_header_footer-ok2'><span style='margin-left:20px;'>#=URL#</span></i>" },
						{ field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
						{ field: "NLSA", title: "Рахунок відправника", width: 150 },
						{ field: "S", title: "Сума",template: "#=kendo.format('{0:n2}', S/100)#", width: 75 },
						{ field: "KV", title: "Код<br/>валюти", width: 75 },
						{ field: "MFOB", title: "МФО отримувача", width: 100 },
						{ field: "ID_B", title: "ІПН отримувача", width: 100 },
						{ field: "NAM_B", title: "Ім’я отримувача", width: 200 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума 2", template: "#=kendo.format('{0:n2}', S2/100)#", width: 75 },
						{ field: "KV2", title: "Код<br/>валюти 2", width: 75 },
						{ field: "NAZN", title: "Призначення платежу", width: 350 },
						{ field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
                case 'STRANSFERS':
                    columns = [
						{ field: "ID", width: 50, hidden: true },
                        { field: "URL", width: 125, template: "<i class='pf-icon pf-16 pf-document_header_footer-ok2'><span style='margin-left:20px;'>#=URL#</span></i>" },
						{ field: "IDN", title: "Ід. строки<br/>в файлі", width: 75 },
						{ field: "NLSA", title: "Рахунок відправника", width: 150 },
						{ field: "S", title: "Сума",template: "#=kendo.format('{0:n2}', S/100)#", width: 75 },
						{ field: "KV", title: "Код<br/>валюти", width: 75 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума 2",template: "#=kendo.format('{0:n2}', S2/100)#", width: 75 },
						{ field: "KV2", title: "Код<br/>валюти 2", width: 75 },
						{ field: "NAZN", title: "Призначення платежу", width: 350 },
						{ field: "ERR_TEXT", title: "Помилки в тексті", width: 350 }
                    ];
                    break;
            }

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
                    model: {}
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
                    refresh: true,
                    pageSizes: [15, 30, 45, 60],
                    buttonCount: 5
                },
                dataSource: noProccessedDataSource,
                columns: columns
            }

            return options;
        };
        //$scope.getMetaFilters();
        /* --- tabstip ---*/
        /*$scope._tabstripOptions = {
            activate: function (e) {
                e.item.innerText === "Оброблені" ?
		        (function () {
		            var gridOptions = $scope.detailGridOptions(transport.proccessedGridItem);
		            gridOptions.dataSource.read({
		                id: function () {
		                    return transport.proccessedGridItem.ID;
		                }
		            });
		        })() : (function () {
		            var gridOptions = $scope.noProccessedOptions(transport.noProccessedGridItem);

                    var grid = transport.noProccessedGrid;

		            gridOptions.dataSource.read({
		                id: function () {
		                    return transport.noProccessedGridItem.ID;
		                }, mode: function () {
		                    return transport.noProccessedGridItem.FILE_TYPE;
		                }
		            });
                })();
            }
        };*/
    });
