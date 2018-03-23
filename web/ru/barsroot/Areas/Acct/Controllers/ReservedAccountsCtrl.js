angular.module('BarsWeb.Areas')
	.controller('Acct.ReservedAccountsCtrl', ['$scope', '$http', function ($scope, $http) {
		var vm = this;
		var apiUrl = bars.config.urlContent('/api/v1/acct/ReservedAccounts/');
		var exception = "";
		var getSelectedItem = function () {
			return vm.resAcctGrid.dataItem(vm.resAcctGrid.select());
		};

		vm.viewCustomer = function (RNK) {
			if (RNK != null && RNK !== "null") {
				window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + RNK), null,
					"height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
			}
			else { bars.ui.error({ title: 'Помилка', text: "Неправильний ПІБ клієнта!" }); }
		};

		vm.viewAcc = function (ACC, RNK) {
			if (ACC != null && ACC !== "null") {
				window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + ACC + "&rnk=" + RNK + "&accessmode=1"), null,
					"height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
			}
			else { bars.ui.error({ title: 'Помилка', text: "Неправильний рахунок клієнта!" }); }
		};

		$scope.openReservedAcc = function (confirm) {
			$scope.winConfirmOpen.close();
			bars.ui.loader($('#resAcctGrid'), true);
			var grid = vm.resAcctGrid;
			var data = grid.select();
			var kv = [];
			for (var i = 0; i < data.length; i++) {
				kv.push(grid.dataItem(data[i]).CurrencyId);
			}
			var nls = grid.dataItem(data[0]).Id;
			$http({
				method: 'POST',
				url: "/barsroot/api/reserveaccs/reserveaccsapi/Activate",
				data: JSON.stringify({ kv: kv, nls: nls })
			}).success(function () {
				vm.opened = true;
				bars.ui.loader($('#resAcctGrid'), false);
				bars.ui.notify('Рахунок відкрито', '', 'success');
				if (vm.resAcctGrid.select().length === 1 && confirm === 0)
					$scope.OpenAccCard(0);
				else {
					vm.resAcctGrid.dataSource.read();
					vm.resAcctGrid.refresh();
				}
			}).error(function (data) {
				vm.opened = false;
				bars.ui.loader($('#resAcctGrid'), false);
				exception = data.ExceptionMessage;
				if (exception !== null && exception !== undefined)
					exception = data.Message;
				angular.element("body > div.k-widget.k-window.with-footer > div.k-content.k-window-footer > button").click(function () {
					if (exception !== null && exception !== undefined && exception.indexOf("необхідно заповнити") > 0) {
						angular.element("#conf").text(exception + "\n Редагувати?")
						angular.element("#winConfirm").data("kendoWindow").center().open();
					}
				});
			});
		};




		vm.openReservedAccDialog = function () {
			var data = getSelectedItem();
			if (!data) {
				bars.ui.error({ text: 'Не вибрано жодного рахунку' });
			} else {
				var grid = vm.resAcctGrid;
				var grid_data = grid.select();
				var kv = null;

				if (grid_data.length > 1) {
					kv = "";
					for (var i = 0; i < grid_data.length; i++) {
						kv += grid.dataItem(grid_data[i]).CurrencyId + ", ";
					}
					kv = kv.substring(0, kv.length - 2);
					enableButton('btnOk', false);
				}
				else {
					//vm.id_edit = data.Id;
					vm.rnk_edit = data.CustomerId;
					vm.kv_edit = data.CurrencyId;
					vm.nls_edit = data.Id;
					
					kv = data.CurrencyId;
					enableButton('btnOk', true);
				}
				bars.ui.confirm(
					{
						text: 'Перевести рахунок <b>' + data.Id + '</b>(валюта ' + kv + ') ' +
						'клієнта <b> ' + data.CustomerName + '</b>, в статус "відкритий"?'
					},
					function () {
						$scope.winConfirmOpen.center().open();
					}
				);
			}
		}

		vm.showDelete = function () {
			bars.ui.confirm(
				{
					text: 'Ви <b>дійсно впевнені</b> що хочете <b>видалити</b> зарезервований рахунок?<br>' +
					'Разунок може видалятися у разі його <b>помилкового резервування працівником фронт офісу</b>, або у разі <b>відмови клієнта від обслуговлювання</b>'
				},
				function () {
					bars.ui.loader($('#resAcctGrid'), true);
					var grid = vm.resAcctGrid;
					var data = grid.select();
					var kv = [];
					for (var i = 0; i < data.length; i++) {
						kv.push(grid.dataItem(data[i]).CurrencyId);
					}
					var nls = grid.dataItem(data[0]).Id;
					$http({
						method: 'POST',
						url: bars.config.urlContent("/api/bpkw4/acceptacc/denyaccepraccount"),
						data: JSON.stringify({ kv: kv, nls: nls })
					}).success(function () {
						bars.ui.loader($('#resAcctGrid'), false);
						bars.ui.notify('Рахунок відхилено', '', 'success');
						vm.resAcctGrid.dataSource.read();
						vm.resAcctGrid.refresh();
					}).error(function () {
						bars.ui.loader($('#resAcctGrid'), false);
					});
				}
			);
		};

		vm.toolbarOptions = {
			items: [
				{
					id: "btnOpen",
					type: "button",
					text: '<i class="pf-icon pf-16 pf-add_button"></i> Відкрити',
					click: function (e) {
						vm.runIfValid(e, vm.openReservedAccDialog);
					}
				},
				//{
				//	id: "btnNLS",
				//	type: "button",
				//	text: '<i class="pf-icon pf-16 pf-folder_open"></i> Картка рахунку',
				//	click: function (e) {
				//		if (!e.target.context.disabled) {
				//			var temp = e;
				//			var formUrl = bars.config.urlContent("/viewaccounts/accountform.aspx?type=2&acc=" + getSelectedItem().Id + "&rnk=&accessmode=0");
				//			bars.ui.dialog({
				//				content: formUrl,
				//				iframe: true,
				//				width: '90%',
				//				height: '80%',
				//			});
				//		}
				//	}
				//},
				{
					id: "btnDelete",
					type: "button",
					text: '<i class="pf-icon pf-16 pf-delete_button_error"></i> Відхилити',
					click: function (e) {
						vm.runIfValid(e, vm.showDelete);
					}
				},
				{
					id: "btnMultyOpen",
					type: "button",
					text: '<i class="pf-icon pf-16 pf-tabs-export"></i> Мультивалютне Відкриття з Наслідуванням',
					click: function (e) {
						vm.runIfValid(e, vm.runIfhasAccounts);
					}
				},
				{
					id: "btnPrintDoc",
					type: "button",
					text: '<i class="pf-icon pf-16 pf-print"></i> Роздрукувати договір',
					click: function (e) {
						$scope.winPrintDocOpen.center().open();
					}
				}
			]
		};
		vm.runIfhasAccounts = function () {
			var grid = vm.resAcctGrid;
			var data = grid.select();
			var nls = grid.dataItem(data[0]).Id;
			var rnk = grid.dataItem(data[0]).CustomerId;
			$.ajax({
				type: "POST",
				url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/HasAnyOpenAccounts/"),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				data: JSON.stringify({ nls: nls, rnk: rnk}),
				success: function (result) {
					if (result) {
						vm.openMultyAccept(rnk,nls);
					} else {
						bars.ui.alert({ text: "У обраного мультивалютного рахунку відсутній відкритий рахунок<br>Для використання неодхідно відкрити хоч один." });
					}
				}
			});
		}
		vm.openMultyAccept = function (rnk, nls) {
			var win = window.open(bars.config.urlContent("/ReserveAccs/ReserveMultyAccs/index?rnk=" + rnk + "&nls=" + nls), '_blank');
			win.focus();
		}
		vm.openNLS = function () {
			var formUrl = bars.config.urlContent("/viewaccounts/accountform.aspx?type=2&acc=" + getSelectedItem().Id + "&rnk=&accessmode=1");
			bars.ui.dialog({
				content: formUrl,
				iframe: true,
				width: '90%',
				height: '80%',
			});

		};
		vm.resAcctGridOptions = {
			height: 100,
			autoBind: true,
			selectable: 'multiple',
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
				if (e.sender.dataSource.total() === 0) {
					var colCount = e.sender.columns.length;
					$(e.sender.wrapper)
						.find('tbody')
						.append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' :(</td></tr>');
				}
				var grid = this;
				grid.element.height("auto");
				grid.element.find(".k-grid-content").height("auto");
				kendo.resize(grid.element);
				refreshToolbar();
			},
			change: refreshToolbar,
			dataSource: {
				type: 'webapi',
				pageSize: 20,
				page: 1,
				total: 0,
				serverPaging: true,
				serverSorting: true,
				serverFiltering: true,
				serverGrouping: true,
				serverAggregates: true,
				sort: {
					field: "Id",
					dir: "desc"
				},
				transport: {
					dataType: 'json',
					type: 'GET',
					read: apiUrl
				},
				requestStart: function () {
					bars.ui.loader($('#resAcctGrid'), true);
				},
				requestEnd: function () {
					bars.ui.loader($('#resAcctGrid'), false);
				},
				schema: {
					data: "Data",
					total: "Total",
					errors: "Errors",
					model: {
						fields: {
							//Id: { type: "number", editable: false },
							Id: { type: "string", editable: false },
							CurrencyId: { type: "number", editable: false },
							Name: { type: "string", editable: false },
							//IsOpen: { type: "boolean", editable: false },
							CustomerId: { type: "number", editable: false },
							CustomerCode: { type: "string", editable: false },
							CustomerName: { type: "string", editable: false }
						}
					}
				}
			},
			columns: [
				//{
				//	field: 'Id',
				//	title: 'Ід',
				//	width: '100px',
				//	filterable: {
				//		ui: function (element) {
				//			element.kendoNumericTextBox({
				//				min: 0,
				//				format: "n0"
				//			});
				//		}
				//	}
				//},
				{
					//template: '<a href="." ng-click="resAcctCtrl.viewAcc(#=Id#, #=CustomerId#)" style="color: blue" onclick="return false;">#= Id #</a>',
					field: 'Id',
					title: 'Номер',
					width: '120px'
				}, {
					field: 'CurrencyId',
					title: 'Валюта',
					width: '70px',
					filterable: {
						ui: function (element) {
							element.kendoNumericTextBox({
								min: 0,
								format: "n0"
							});
						}
					}
				}, {
					field: 'Name',
					title: 'Назва',
					width: '250px',
					template: '<span title="#=Name#">#=Name#</span>'
				}, {
					field: 'CustomerId',
					template: '<a href="." ng-click="resAcctCtrl.viewCustomer(#=CustomerId#)" style="color: blue" onclick="return false;">#= CustomerId #</a>',
					title: 'Ід клієнта',
					width: '100px',
					filterable: {
						ui: function (element) {
							element.kendoNumericTextBox({
								min: 0,
								format: "n0"
							});
						}
					}
				}, {
					field: 'CustomerCode',
					title: 'ЄДРПО',
					width: '100px'
				}, {
					field: 'CustomerName',
					title: 'Назва клієнта',
					width: '250px',
					template: '<span title="#=CustomerName#">#=CustomerName#</span>'
				}
			]
		}
		vm.printDocOptions = {
			height: 300,
			autoBind: true,
			selectable: 'row',
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
			change: function (e) {
				vm.printDoc(e, vm.printDocGrid.dataItem(vm.printDocGrid.select()).ID);
				$scope.winPrintDocOpen.close();
			},
			dataSource: {
				type: 'json',
				pageSize: 20,
				page: 1,
				total: 0,
				serverPaging: false,
				serverSorting: false,
				serverFiltering: false,
				serverGrouping: false,
				serverAggregates: false,
				transport: {
					read: {
						dataType: "json",
						type: "GET",
						url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/GetPrintDocs")
					}
				},
				schema: {
					fields: {
						ID: { type: "string", editable: false },
						NAME: { type: "string", editable: false }
					}
				}
			},
			columns: [
				{
					field: 'ID',
					title: 'Номер',
					width: '100px'
				},
				{
					field: 'NAME',
					title: 'Назва',
					width: '140px'
				}
			]
		};
		
		vm.runIfValid = function (event, func) {
			if (!event.target.context.disabled) {
				vm.executeIfBackOffice(func);
			}
		};
		vm.printDoc = function (event, templateName) {
			function formUrlForPrint(source) {
				return window.location.href.split("barsroot")[0] + "barsroot/WebPrint.aspx?filename=" + source.replace(/\"/g, "");
			}
			var grid = vm.resAcctGrid;
			var data = grid.select();
			var _kv = grid.dataItem(data[0]).CurrencyId;
			var _nls = grid.dataItem(data[0]).Id;
			$http({
				method: 'POST',
				url: "/barsroot/api/reserveaccs/reserveaccsapi/printdoc",
				data: JSON.stringify({ kv: _kv, nls: _nls, templateId: templateName })
			}).success(function (result) {
				if (!result) return;
				window.showModalDialog(formUrlForPrint(result), '', 'dialogWidth: 900px; dialogHeight: 800px; center: yes');
			});
		};

		vm.executeIfBackOffice = function (func) {
			$.ajax({
				type: "GET",
				url: bars.config.urlContent("/api/custacc/start/"),
				success: function (result) {
					if (result > 0) {
						func();
					} else {
						bars.ui.alert({ text: "Поточний користувач не нележить \"Підрозділу бек-офісу\"" });
					}
				}
			});
		};

		vm.haveOneKV = function (data) {
			var grid = vm.resAcctGrid;
			var nls = grid.dataItem(data[0]).Id;
			var kv = grid.dataItem(data[0]).CurrencyId;
			for (var i = 1; i < data.length; i++) {
				row = grid.dataItem(data[i]);
				if (row.Id === nls && row.CurrencyId !== kv)
					continue;
				else
					return false;
			}
			return true;
		};

		function refreshToolbar() {
			var grid = vm.resAcctGrid;
			var currentRowData = null;

			if (grid.select().length == 1) {
				currentRowData = grid.dataItem(grid.select());
			}

			//enableButton('btnNLS', currentRowData != null && grid.select().length == 1);
			enableButton('btnDelete', (currentRowData != null && grid.select().length == 1) || (grid.select().length > 1 && vm.haveOneKV(grid.select())));
			enableButton('btnOpen', (currentRowData != null && grid.select().length == 1) || (grid.select().length > 1 && vm.haveOneKV(grid.select())));
			enableButton('btnMultyOpen', (currentRowData != null && grid.select().length == 1) || (grid.select().length > 1 && vm.haveOneKV(grid.select())));
			enableButton('btnPrintDoc', (currentRowData != null && grid.select().length == 1));
		}

		function enableButton(buttonId, enabled) {
			if (typeof (enabled) === 'undefined') {
				enabled = true;
			}
			var $button = $('#' + buttonId);
			$button[0].disabled = !enabled;
			if (enabled) {
				$button.find('i').removeClass("pf-disabled");
				$button.attr("disabled", false);
			} else {
				$button.find('i').addClass("pf-disabled");
				$button.attr("disabled", true);
			}
		}

		$scope.OnCloseCoonfWin = function () {
			$("#winConfirm").data("kendoWindow").close();
		}

		$scope.OpenAccCard = function (type) {
			$scope.OnCloseCoonfWin();
			if (type === 1) {
				bars.ui.dialog({
					content: encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + vm.rnk_edit),
					iframe: true,
					width: document.documentElement.offsetWidth * 0.8,
					height: document.documentElement.offsetHeight * 0.8,
					close: function () {
						if (!vm.opened)
							vm.openReservedAccDialog();
					}
				});
			}
			else {
				$.ajax({
					type: "GET",
					url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/GetCreatedAccNLSKV?nls=" + vm.nls_edit + "&kv=" + vm.kv_edit),
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (result) {					
						if (result) {						
							bars.ui.dialog({
								content: encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + result + "&rnk=" + vm.rnk_edit + "&accessmode=1"),
								iframe: true,
								width: document.documentElement.offsetWidth * 0.8,
								height: document.documentElement.offsetHeight * 0.8,
								close: function () {
									if (!vm.opened)
										vm.openReservedAccDialog();
									vm.resAcctGrid.dataSource.read();
									vm.resAcctGrid.refresh();
								}
							});
						}
					}
				});
				
			}
		}
	}]);