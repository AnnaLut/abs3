angular.module('BarsWeb.Controllers', [])
	.controller('accSpecCtr', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

		$scope.Title = "Перегляд рахунків. Спецпараметри. ";

		$scope.accTools = {
			items: [
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-folder_open" title="Картка рахунку"></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null)
							$scope.commonMethods.viewAcc(item.Acc, item.RNK);
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-user" title="Картка клієнта"></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null) 
							$scope.commonMethods.viewCustomer(item.RNK);
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-filter-ok" title="Встановити фільтр"></i>',
					click: function () {
						$scope.commonMethods.callFilter();
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-filter-remove" title="Скасувати фільтр"></i>',
					click: function () {
						$scope.gridParams.metaFilter = "";
						$scope.accGrid.dataSource.read($scope.gridParams);
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-bank" title="Історія рахунку"></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null) { 
							$scope.commonMethods.openInWindow("/barsroot/customerlist/showhistory.aspx?" +
																"acc=" + item.Acc +
																"&type=" + $scope.commonMethods.getVal("type"));
						}
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-bank-update"  title="Історія змін параметрів рахунку"></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null) {
							$scope.commonMethods.openInWindow("/barsroot/customerlist/custhistory.aspx?mode=1&rnk=" + item.RNK + "&type=" + $scope.commonMethods.getVal("type"));
						}
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-percentage title="Моделювання нарахованих відсотків""></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null)
							$scope.commonMethods.showPersents(item.Acc);
					}
				},
				//{
				//	type: "button",
				//	text: '<i class="pf-icon pf-16 pf-table" title="Пов\'язані рахунки "></i>',
				//	click: function () {
				//		//
				//		// /barsroot/customerlist/custacc.aspx?type=6&nls=260093061734&lcv=UAH&mod=ro
				//		var item = $scope.commonMethods.getSelectedItem()
				//		if (item != null) {
				//			var win = window.open("/barsroot/customerlist/turn4day.aspx?acc=" + item.Acc, '_blank');
				//			win.focus();
				//		}
				//		alert(2); 
				//	}
				//},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-currency_conversion" title="Підсумки по валютам"></i>',
					click: function () {
						var win = window.open("/barsroot/customerlist/customerlist/totalcurrency", '_blank');
						win.focus();
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-arrow_right" title="Обороти по рахунку за період"></i>',
					click: function () {
						var item = $scope.commonMethods.getSelectedItem()
						if (item != null) {
							var win = window.open("/barsroot/customerlist/turn4day.aspx?acc=" + item.Acc, '_blank');
							win.focus();
						}
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-delete" title="Вийти"></i>',
					click: function () {
						window.history.back();
					}
				},
				{
					type: "button",
					text: '<i class="pf-icon pf-16 pf-reload_rotate" title="Перечитати"></i>',
					click: function () {
						$scope.accGrid.dataSource.read($scope.gridParams);
					}
				}
			]
		};

		$scope.commonMethods = {
			getVal: function (str) {
				var v = window.location.search.match(new RegExp('(?:[\?\&]' + str + '=)([^&]+)'));
				return v ? v[1] : null;
			},
			openInWindow: function (InitUrl) {
				var ENDING_URL = "height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes";
				window.open(InitUrl, null, ENDING_URL);
			},
			viewAcc: function (ACC, RNK) {
				if (ACC != null && ACC !== "null") {
					this.openInWindow(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + ACC + "&rnk=" + RNK + "&accessmode=1"));
				}
				else {
					bars.ui.error({ title: "Помилка", text: "Неправильний рахунок клієнта!" });
				}
			},
			viewCustomer: function (RNK) {
				if (RNK != null && RNK !== "null") {
					this.openInWindow(encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + RNK));
				}
				else {
					bars.ui.error({ title: "Помилка", text: "Неправильний ПІБ клієнта!" });
				}
			},
			showPersents: function(ACC) {
				window.showModalDialog("/barsroot/tools/int_statement.aspx?acc=" + ACC + "&" + Math.random(), "",
					"dialogWidth:800px;dialogHeight:600px;center:yes;edge:sunken;scroll:no;help:no;status:no;");
			},
			callFilter: function () {
				bars.ui.getFiltersByMetaTable(function (response, success) {
					if (!success) {
						bars.ui.alert({
							text: "Будь ласка, задайте фільтр."
						});
						return false;
					}
					if (response.length > 0) {
						$scope.gridParams.metaFilter = response[0].split("V_ACCOUNTS_SPECPARCUST").join("v");
						$scope.accGrid.dataSource.read($scope.gridParams);
					} else {
						bars.ui.alert({ text: "Будь ласка, задайте фільтр."});
					}
				}, { tableName: "V_ACCOUNTS_SPECPARCUST" });
			},
			getSelectedItem: function () {
				var grid = angular.element("#accGrid").data("kendoGrid");
				return grid.dataItem(grid.select());
			},
			doRefreshGrid: function () {
				$scope.accGrid.dataSource.read($scope.gridParams);
			}
			//onChangeBranch: function () {},
			//onChangeOb22: function () {}
		};

		$scope.gridParams = {
			metaFilter: "",
			Custtype: $scope.commonMethods.getVal("custtype"),
			nls: "",
			branch: "",
			nms: "",
			ob22: "",
			rnk: "",
			kv: "",
			showClosed: false
		};

		$scope.Init = function () {
			var custIndex = $scope.commonMethods.getVal("custtype");
			var custArr = ["Банки", "ЮО", "ФО", "ФОП"];
			$scope.Title += custArr[custIndex - 1];
			//SetFilter
			$scope.commonMethods.callFilter();	
		};

		//general Grid
		$scope.accGrid = {
			autoBind: false,
			dataSource: new kendo.data.DataSource({
				type: 'webapi',
				pageSize: 20,
				page: 1,
				serverPaging: true,
				serverSorting: true,
				serverFiltering: true,
				transport: {
					dataType: 'json',
					type: 'GET',
					read: {
						url: bars.config.urlContent('/api/customerlist/accountsspecparamview/accountssource'),
						data: function () {
							return $scope.gridParams;
						}
					},
				},
				requestStart: function (e) {
					bars.ui.loader("body", true);
				},
				requestEnd: function (e) {
					bars.ui.loader("body", false);
				},
				schema: {
					data: "Data", 
					total: "Total",
					aggregates: "AggregateResults", 
					errors: "Errors", 
					model: {
						id: "Acc",
						data: "Data",
						fields: {
							Acc: { type: "number" },
							BRANCH: { type: "string" },
							NLS: { type: "string" },
							KV: { type: "number" },
							NMS: { type: "string" },
							DOS: { type: "number" },
							KOS: { type: "number" },
							OSTB: { type: "number" },
							OSTC: { type: "number" },
							OSTF: { type: "number" },
							DAPP: { type: "date" },
							MDATE: { type: "date" },
							LIM: { type: "number" },
							NBS: { type: "string" },
							AP: { type: "string" },
							TIP: { type: "string" },
							VID: { type: "number" },
							OB22: { type: "string" },
							R011: { type: "string" },
							R013: { type: "string" },
							s080: { type: "string" },
							S190: { type: "string" },
							S200: { type: "string" },
							S230: { type: "string" },
							S240: { type: "string" },
							S260: { type: "string" },
							S270: { type: "string" },
							isp: { type: "number" },
							DAOS: { type: "date" },
							DAZS: { type: "date" },
							RNK: { type: "string" },
							okpo: { type: "string" },
							custtype: { type: "number" }
						}
					}
				}
			}),
			height: function () {
				return $(window).height() / 10 * 6;
			},
			selectable: 'single',
			groupable: false,
			sortable: true,
			resizable: true,
			filterable: true,
			scrollable: true,
			pageable: {
				refresh: true,
				pageSizes: [10, 20, 50, 100, 200],
				buttonCount: 1
			},
			dataBound: function (e) {
				var dataItems = e.sender.dataSource.view();
				for (var j = 0; j < dataItems.length; j++) {
					var closed = !!dataItems[j].DAZS;
					if (closed) {
						$(e.sender.tbody[0].children[j]).addClass("closedAcc");
					}
				}
			},
			columns: [{
				field: "Acc",
				title: "Acc",
				hidden: true,
				//locked: true,
				//lockable: false,
				width: "100px"
			}, {
				field: "BRANCH",
				title: "Відділення",
				locked: true,
				lockable: false,
				width: "100px"
			}, {
			    template: '<a href="." ng-click="commonMethods.viewAcc(#=Acc#, #=RNK#)" style="color: blue" onclick="return false;">#= NLS #</a>',
				field: "NLS",
				title: "Рахунок",
				locked: true,
				width: "120px"
			}, {
				field: "KV",
				title: "Код вал.",
				locked: true,
				width: "70px"
			}, {
				field: "NMS",
				title: "Наймен. рах.",
				locked: true,
				width: "280px"
			},
			{
				field: "DOS",
				title: "Обороти детет.",
				template: '#= (DOS == null ) ? " " : kendo.toString(DOS/100.0, "n2") #',
				width: "120px"
			}, {
				field: "KOS",
				title: "Обороти кредит",
				template: '#= (KOS == null ) ? " " : kendo.toString(KOS/100.0, "n2") #',
				width: "120px"
			}, {
				field: "OSTB",
				title: "Плановий залишок",
				template: '#= (OSTB == null ) ? " " : kendo.toString(OSTB/100.0, "n2") #',
				width: "120px"
			}, {
				field: "OSTC",
				title: "Фактичний залишок",
				template: '#= (OSTC == null ) ? " " : kendo.toString(OSTC/100.0, "n2") #',
				width: "120px"
			}, {
				field: "OSTF",
				title: "Залишок Майб.",
				template: '#= (OSTF == null ) ? " " : kendo.toString(OSTF/100.0, "n2") #',
				width: "120px"
			}, {
				template: "#= (DAPP == null ) ? ' ' : kendo.toString(kendo.parseDate(DAPP), 'dd/MM/yyyy') #",
				field: "DAPP",
				title: "Дата ост рух.",
				width: "120px"
			}, {
				template: "#= (MDATE == null ) ? ' ' : kendo.toString(kendo.parseDate(MDATE), 'dd/MM/yyyy') #",
				field: "MDATE",
				title: "Дата погаш. рах.",
				width: "120px"
			}, {
				field: "LIM",
				title: "Лііт",
				width: "120px"
			}, {
				field: "NBS",
				title: "Балансовий рах",
				width: "100px"
			}, {
				field: "AP",
				title: "AП",
				width: "80px"
			}, {
				field: "TIP",
				title: "Тип",
				width: "80px"
			}, {
				field: "VID",
				title: "Вид",
				width: "80px"
			}, {
				field: "OB22",
				title: "OB22",
				width: "80px"
			}, {
				field: "R011",
				title: "R011",
				width: "80px"
			}, {
				field: "R013",
				title: "R013",
				width: "80px"
			}, {
				field: "s080",
				title: "S080",
				width: "80px"
			}, {
				field: "S190",
				title: "S190",
				width: "80px"
			}, {
				field: "S200",
				title: "S200",
				width: "80px"
			}, {
				field: "S230",
				title: "S230",
				width: "80px"
			}, {
				field: "S240",
				title: "S240",
				width: "80px"
			}, {
				field: "S260",
				title: "S260",
				width: "80px"
			}, {
				field: "S270",
				title: "S270",
				width: "80px"
			}, {
				field: "isp",
				title: "isp",
				width: "80px"
			}, {
				template: "#= (DAOS == null ) ? ' ' : kendo.toString(kendo.parseDate(DAOS), 'dd/MM/yyyy') #",
				field: "DAOS",
				title: "Дата відкриття",
				width: "120px"
			}, {
				template: "#= (DAZS == null ) ? ' ' : kendo.toString(kendo.parseDate(DAZS), 'dd/MM/yyyy') #",
				field: "DAZS",
				title: "Дата закриття",
				width: "120px"
			}, {
				template: '<a href="." ng-click="commonMethods.viewCustomer(#=RNK#)" style="color: blue" onclick="return false;">#= RNK #</a>',
				field: "RNK",
				title: "РНК",
				locked: true,
				width: "80px"
			}, {
				field: "okpo",
				title: "ІНН",
				hidden: true,
				width: "120px"
			}, {
				field: "custtype",
				title: "custtype",
				hidden: true,
				width: "220px"
			}]
		};

		$scope.BranchDatasource = {
			transport: {
				read: {
					dataType: "json",
					url: bars.config.urlContent('/api/customerlist/accountsspecparamview/getavaliablebranchlist'),
				}
			}}; 
		$scope.Ob22Datasource = {
			transport: {
				read: {
					dataType: "json",
					url: bars.config.urlContent('/api/customerlist/accountsspecparamview/getavaliableob22list'),
				}
			}};
	}]);