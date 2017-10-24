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
		        }
		    });
		};

		$scope._datepickerOptionsFrom = {
		    format: '{0:dd/MM/yyyy}'/*,
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
		    debugger;
		    $scope.grid.clearAllFilters();  // filter-remove
		};

		/* --- upload file --- */
		$scope.showUploadWindow = function () {
			bars.ui.dialog({
				content: bars.config.urlContent('/way/wayapp/fileupload/'),
				iframe: true,
				width: '600px',
				height: '400px',
				title:'Завантаження та обробка файлів',
			    close: function() {
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
                    template: '<button class="k-button" title="Оновити дані таблиці" ng-click="showUploadWindow()" ng-show="isDownload"><i class="pf-icon pf-16 pf-arrow_download"></i> Завантажити файл</button>'
                }
		    ]
		};

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
		                    return $scope.dateObj.dateFrom;
		                },
		                dateTo: function () {                            
		                    return $scope.dateObj.dateTo;
		                }
		            }
		        }
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
		                FILE_N: { type: "string" },
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
		    //filterable: true,
		    filterable: {
		        mode: "row"
		    },
		    selectable: 'row',
		    sortable: true,
		    resizable: true,
		    pageable: {
		        refresh: true,
		        pageSizes: [10, 30, 45, 60],
		        buttonCount: 5
		    },
		    dataSource: $scope.dataSource,
		    columns: [
		        { field: "ID", title: "Ід. файлу", width: 100 },
                { field: "FILE_NAME", title: "Назва файлу", width: 350 },
                { field: "FILE_TYPE", title: "Тип файлу", width: 100 },
                { field: "FILE_DATE", title: "Дата файлу", template: "<div>#=kendo.toString(kendo.parseDate(FILE_DATE),'dd/MM/yyyy')#</div>", width: 100 },
                { field: "FILE_STATUS", title: "Статус", width: 75 },
                { field: "FILE_N", title: "Кількість<br/>документів", width: 100 },
                { field: "N_OPL", title: "Кількість оброблених<br/>документів", width: 100 },
                { field: "N_ERR", title: "Кількість необроблених<br/>документів", width: 100 },
                { field: "N_DEL", title: "Кількість видалених<br/>з обробки документів", width: 100 },
                { field: "N_ABS", title: "Кількість створених<br/>документів АБС", width: 100 },
                { field: "ERR_TEXT", title: "Опис помилки", width: 200 }
		    ],
		    dataBound: function () {
		        var dataSource = this.dataSource;
		        this.element.find('tr.k-master-row').each(function () {
		            var row = $(this);
		            var data = dataSource.getByUid(row.data('uid'));
		            // disable details
		            if (data.FILE_TYPE === 'CNGEXPORT') {
		                row.find('.k-hierarchy-cell a').css({ opacity: 0.3, cursor: 'default' }).click(function (e) { e.stopImmediatePropagation(); return false; });
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
		                    id: function() {
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
		        resizable: true,
		        serverPaging: true,
		        serverSorting: true,
		        serverFiltering: true
		    });

		    return {
		        autoBind: true,
		        //filterable: true,
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
						width: 100 
					},
                    { field: "MFOA",  title: "МФО<br/>відправника", width: 100 },
                    { field: "NLSA", title: "Рахунок<br/>відправника", width: 150 },
                    { field: "MFOB", title: "МФО<br/>отримувача", width: 100 },
                    { field: "NLSB", title: "Рахунок<br/>отримувача", width: 150 },
                    { field: "S",     title: "Сума", width: 100 },
                    { field: "KV",    title: "Код<br/>валюти", width: 75 },
                    { field: "LCV",   title: "Симв. код", width: 75 },
                    { field: "DIG",   title: "Коп", width: 75 },
                    { field: "S2", title: "Сума<br/>документа 2", width: 75 },
                    { field: "KV2", title: "Код<br/>валюти 2", width: 75 },
                    { field: "LCV2", title: "Симв.<br/>код 2", width: 75 },
                    { field: "DIG2",  title: "Коп 2", width: 75 },
                    { field: "SK", title: "Символ<br/>кассплана", width: 75 }, 
                    { field: "DK",    title: "Д/К", width: 100 },
                    { field: "VOB", title: "Вид <br/>банківського<br/>документа", width: 100 },
                    { field: "DATD", title: "Дата<br/>документа", width: 100 },
                    { field: "VDAT", title: "Планова<br/>дата<br/>валютування", width: 100 }, 
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
		        ]
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
        $scope.refInfo = function() {
            if (transport.proccessedRow) {
                var url = '/barsroot/docview/item/?id=' + transport.proccessedRow.REF + '&partial=true';
                window.location = url;
            }
        };

        /* --- NoProccessed Files Grid --- */
        $scope.noProccessedOptions = function(dataItem) {
            
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
						{ field: "DK", title: "Д/К", width: 75 },
						{ field: "NLSA", title: "Рахунок<br/>відправника", width: 150 },
						{ field: "S", title: "Сума", width: 75 },
						{ field: "KV", title: "Код валюти", width: 75 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума 2", width: 75 },
						{ field: "KV2", title: "Код<br/>валюти 2", width: 75 },
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
						{ field: "S", title: "Сума", width: 75 },
						{ field: "KV", title: "Код<br/>валюти", width: 75 },
						{ field: "MFOB", title: "МФО отримувача", width: 100 },
						{ field: "ID_B", title: "ІПН отримувача", width: 100 },
						{ field: "NAM_B", title: "Ім’я отримувача", width: 200 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума 2", width: 75 },
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
						{ field: "S", title: "Сума", width: 75 },
						{ field: "KV", title: "Код<br/>валюти", width: 75 },
						{ field: "NLSB", title: "Рахунок отримувача", width: 150 },
						{ field: "S2", title: "Сума 2", width: 75 },
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

            var options =  {
                autoBind: true,
                //filterable: true,
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

		            debugger;
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
