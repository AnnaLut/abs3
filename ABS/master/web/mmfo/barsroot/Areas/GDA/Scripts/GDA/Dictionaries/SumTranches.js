var mainApp = angular.module(globalSettings.modulesAreas);

mainApp.controller("SumTranches", function ($controller, $scope, $timeout, $http,
                                        saveDataService, settingsService, modelService, validationService) {
    $controller('GdaBaseController', { $scope: $scope });     // Расширяем контроллер

    $scope.placementTranche = modelService.initFormData("placementTranche");

	var saveSum = {
		type: "POST",
		url: bars.config.urlContent("/api/gda/gda/setsumtracheoption"),
		data: function (data) {
            data.ValidFrom = kendo.toString(data.ValidFrom, "yyyy-MM-dd");
            var grid = $("#sumtranchesoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            if (selectedRow.length > 0) {
                $scope.sItem = grid.dataItem(grid.select()).Id;
            }
            //
			return data;
		}
	};

	var saveCondition = {
		type: "POST",
		url: bars.config.urlContent("/api/gda/gda/setsumtranchecondition"),
		data: function (data) {
			var grid = $("#sumtranchesoptions").data().kendoGrid;
            var selectedRow = grid.select();
            //
            if (selectedRow.length > 0) {
                $scope.sItem = grid.dataItem(grid.select()).Id;
            }
            //
			var selectedDataItem = grid.dataItem(selectedRow);
			data.InterestOptionId = selectedDataItem.Id;
			return data;
		}
	};

	var activeOptions = [{ value: 1, text: "Активна" }, { value: 0, text: "Не активна" }];

    var SumTranchesDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
        transport: {
            read: {
                url: bars.config.urlContent("/api/gda/gda/getsumtranchesinfo")
                //data: "Data.Conditions"
			},
			create: saveSum,
			update: saveSum
        },
        requestEnd: function (e) {
            if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Новий строк дії умов доданий", 'success', { autoHideAfter: 5 * 1000 });
                bars.ui.loader("body", false);
			}
			bars.ui.loader("body", false);
        },
        sort: { field: "ValidFrom", dir: "desc" },
        schema: {
            data: "Data",
            total: "Total",
            model: {
                id: "Id",
				fields: {
					Conditions: [],
					Id: { type: 'string' },
					ValidFrom: { type: 'date' },
					IsActive: { type: 'number', validation: { required: true, min: 0, max: 1 } },
					UserId: { type: 'string' },
					SysTime: { type: 'string' }					
                }
            }
        },
        serverFiltering: false, ////!!!!!
        serverPaging: false,
        serverSorting: false
    });

    $scope.SumTranchesGridOptions = $scope.createGridOptions({
        dataSource: SumTranchesDataSource,
        dataBound: function (e) {

            if ($scope.sItem) {
                var dataItem = this.dataSource.get($scope.sItem);
                if (dataItem == null) {
                    return;
                } else {
                    this.select($('[data-uid=' + dataItem.uid + ']'));
                }
            }
            var rows = e.sender.tbody.children();
            for (var j = 0; j < rows.length; j++) {
                var row = $(rows[j]);
                var dataItem = e.sender.dataItem(row);

                if (dataItem.get("IsActive") == "1") {
                    row.addClass("classActive");
                } else {
                    row.addClass("classClose");
                }
            }
        },
        height: 300,
        selectable: true,
        editable: 'inline',
        excel: {
            allPages: true,
            filterable: false,
            proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/")
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            for (var i = 0; i < sheet.columns.length; i++) {
                sheet.columns[i].width = 150;
            }
        },
		columns: [
			{
				field: "ValidFrom",
				title: "Дата від",
				format: "{0:dd-MM-yyyy}"
			},
			{
				field: "IsActive",
				title: "Статус",
				values: activeOptions,
				editor: function (container, options) {
					var input = $('<input data-text-field="text" data-value-field="value" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
					input.appendTo(container);
					input.kendoDropDownList({
						dataTextField: "text",
						dataValueField: "value",
						dataSource: activeOptions
					});
				}
			}
		],
        change: function (e) {
            var data = this.dataItem(this.select());
            if (data && data.Conditions != null) {
                var dataArray = $.map(data.Conditions, function (value, index) {
                    return [value];
                });
                //
                var editRow = this.dataItem('tr.k-grid-edit-row');
                if (!editRow) {
                    $('#sumconditions').data('kendoGrid').dataSource.data(dataArray);
                } else {

                }
                //
            } else {
                $('#sumconditions').data('kendoGrid').dataSource.data([]);
                $('#sumconditions').data('kendoGrid').refresh();
            }
            enableDisableButtons(['#addConditionSum', '#sumtranchesoptionsEdit'], false);
            enableDisableButtons(['#cancelConditionSum'], true);

            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data == null) {
                data = { Id: '' };
                data.Id = '';
            }
            if (data == null || (data.Id != '' && data.SysTime != null && data.UserId != null)) {
                if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionSum', '#saveOptionSum'], e) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabSum', true);
                }
            } else if (data != null && data.Id != '') {
                if (data.SysTime == null && data.UserId == null) {
                    if (data == editRow) {
                        return;
                    } else {
                        if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionSum', '#saveOptionSum'], e) == true) {
                            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                            disableTabsInEditMode('tabSum', true);
                        }
                    }
                } else {
                    return;
                }
            }
        }
    });


    $("#exportToExcelSum").click(function () {
        var grid = $("#sumtranchesoptions").data("kendoGrid");

        var selectedRow = grid.dataItem(grid.select());
        if (selectedRow == null) {
            bars.ui.alert({ text: "Щоб завантажити дані у Excel оберіть строк дії та ще раз натисніть цю кнопку" });
        } else {
            var rowsOpt = [{
                cells: [
                    { value: "Дата від" },
                    { value: "Статус" },
                ]
            }];
            var rowsCond = [{
                cells: [
                    { value: "Валюта" },
                    { value: "Мінімальна сума траншу" },
                    { value: "Максимальна сума траншу" },
                    { value: "Мінімальна сума поповнення траншу" },
                    { value: "Максимальна сума поповнення траншу"}
                ]
            }];

            if (grid.dataItem(grid.select()).Conditions != null) {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                
                for (var i = 0; i < grid.dataItem(grid.select()).Conditions.length; i++) {
                    rowsCond.push({
                        cells: [
                            { value: grid.dataItem(grid.select()).Conditions[i].Currency },
                            { value: +grid.dataItem(grid.select()).Conditions[i].MinSumTranche, format: "0.00" },
                            { value: +grid.dataItem(grid.select()).Conditions[i].MaxSumTranche, format: "0.00" },
                            { value: +grid.dataItem(grid.select()).Conditions[i].MinReplenishmentAmount, format: "0.00" },
                            { value: +grid.dataItem(grid.select()).Conditions[i].MaxReplenishmentAmount, format: "0.00" }
                        ]
                    });
                }
                var newArr = rowsOpt.concat(rowsCond);
            } else {
                rowsOpt.push({
                    cells: [
                        { value: grid.dataItem(grid.select()).ValidFrom },
                        { value: grid.dataItem(grid.select()).IsActive ? 'Активна' : 'Неактивна' }
                    ]
                });
                var newArr = rowsOpt;
            }



            var workbook = new kendo.ooxml.Workbook({
                sheets: [
                    {
                        columns: [
                            { width: 200 },
                            { width: 200 },
                            { width: 200 },
                            { width: 250 },
                            { width: 250 }
                        ],
                        title: "Суми траншів",
                        rows: newArr
                    }
                ]
            });
            kendo.saveAs({ dataURI: workbook.toDataURL(), fileName: "Суми траншів.xlsx", proxyURL: bars.config.urlContent("/GDA/GDA/ConvertBase64ToFile/") } );
        }
    });

	function Cancel() {
		var grid = $("#sumtranchesoptions").data("kendoGrid");

        var data = grid.dataItem(grid.select());
        if (data) {
            if (data.Conditions != null) {
                $('#sumconditions').data('kendoGrid').dataSource.data(data.Conditions);
                $('#sumconditions').data('kendoGrid').refresh();
                $('#sumtranchesoptions').data('kendoGrid').dataSource.read();
            }
        }
	}

    $('#addOptionTranches').click(function () {
        enableDisableButtons(['#cancelOptionTranches','#saveOptionTranches'], false);
        enableDisableButtons(['#generaloptionsEdit', '#addConditionSum', '#sumconditionsEdit', '#saveConditionSum', '#exportToExcelSum', '#addOptionTranches','#sumtranchesoptionsEdit'], true);
        var grid = $("#sumtranchesoptions").data("kendoGrid");
        grid.addRow();
        disableTabsInEditMode('tabSum', true);
        $('#sumconditions').data('kendoGrid').dataSource.data([]);
	});
	$('#sumtranchesoptionsEdit,#sumconditionsEdit').click(function (event) {
		var id = event.currentTarget.id.slice(0, -4);
		var grid = $("#" + id).data("kendoGrid");
        var selected = grid.select();
        var isSumTranchesOptions = id === 'sumtranchesoptions';
        if (selected.length == 0) {
            var toDisableIds = isSumTranchesOptions ? ['#cancelOptionTranches'] : ['#cancelConditionSum'];
            var toEnableIds = isSumTranchesOptions ? ['#addOptionTranches'] : ['#addConditionSum'];
            enableDisableButtons(toDisableIds, true);
            enableDisableButtons(toEnableIds, false);
			return;
        } else {
            var classList = selected[0].classList ? selected[0].classList : selected[0].className.split(' ');
            var inEdit = classList[classList.length - 1] === 'k-grid-edit-row';
            var toDisableIds = isSumTranchesOptions ? ['#cancelOptionTranches', '#saveOptionTranches'] : ['#addConditionSum', '#addOptionTranches', '#sumtranchesoptionsEdit', '#saveOptionTranches', '#exportToExcelSum', '#cancelOptionTranches','#sumconditionsEdit'];
            var toEnableIds = isSumTranchesOptions ? ['#addOptionTranches', '#sumconditionsEdit', '#saveConditionSum', '#addConditionSum', '#exportToExcelSum', '#sumtranchesoptionsEdit'] : ['#cancelConditionSum','#saveConditionSum'];

            if (isSumTranchesOptions) {
                if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionSum', '#saveOptionSum'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabSum', true);
                } else {
                    enableDisableButtons(toDisableIds, inEdit);
                    enableDisableButtons(toEnableIds, !inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabSum', true);
                }
            }
            else {
                if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionSum', '#saveOptionSum'], event) == true) {
                    bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                    disableTabsInEditMode('tabSum', true);
                } else {
                    enableDisableButtons(toDisableIds, !inEdit);
                    enableDisableButtons(toEnableIds, inEdit);
                    grid.editRow(selected);
                    disableTabsInEditMode('tabSum', true);
                }
            }
		}
	});
    $('#saveOptionTranches').click(function () {
        enableDisableButtons(['#cancelOptionTranches', '#saveOptionTranches', '#addConditionSum'], true);
        enableDisableButtons(['#addOptionTranches', '#sumtranchesoptionsEdit','#exportToExcelSum'], false);
        var grid = $("#sumtranchesoptions").data("kendoGrid");
		grid.saveRow();
		$('#sumtranchesoptions').data('kendoGrid').dataSource.read();
        $('#sumtranchesoptions').data('kendoGrid').refresh();
        disableTabsInEditMode('tabSum', false);
    });
    $('#cancelOptionTranches').click(function () {
        var grid = $("#sumtranchesoptions").data("kendoGrid");
		grid.cancelRow();
        enableDisableButtons(['#cancelOptionTranches', "#saveOptionTranches", '#sumtranchesoptionsEdit', '#addConditionSum'], true);
        enableDisableButtons(['#addOptionTranches', '#exportToExcelSum'], false);
        grid.dataSource.read();
		$('#sumconditions').data('kendoGrid').dataSource.data([]);
        $("#sumconditions").data("kendoGrid").refresh();
        disableTabsInEditMode('tabSum', false);
	});


    $('#addConditionSum').click(function (e) {
        enableDisableButtons(['#sumconditionsEdit', '#addOptionTranches', '#sumtranchesoptionsEdit', '#saveOptionTranches', '#cancelOptionTranches', '#addConditionSum','#exportToExcelSum'], true);
        enableDisableButtons(['#cancelConditionSum', '#saveConditionSum'], false);
        if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionTranches', '#saveOptionTranches'], e) == true) {
            bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
        } else {
            var grid = $("#sumconditions").data("kendoGrid");
            var gridOpt = $("#sumtranchesoptions").data("kendoGrid");
            //
            $scope.sItem = gridOpt.dataItem(gridOpt.select()).Id;
            //
            grid.addRow();
            disableTabsInEditMode('tabSum', true);
        }
	});
    $('#saveConditionSum').click(function () {
        var gridOpt = $("#sumtranchesoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionTranches', '#addConditionSum','#sumtranchesoptionsEdit'], false);
            enableDisableButtons(['#cancelConditionSum', '#saveConditionSum','#cancelOptionTranches','#saveOptionTranches'], true);
		    var grid = $("#sumconditions").data("kendoGrid");
            grid.saveRow();
            disableTabsInEditMode('tabSum', false);
        } else {
            return;
        }
	});
    $('#cancelConditionSum').click(function () {
        var gridOpt = $("#sumtranchesoptions").data("kendoGrid"),
            item = gridOpt.dataItem(gridOpt.select());
        if (item != null) {
            enableDisableButtons(['#addOptionTranches', '#sumtranchesoptionsEdit', '#addOptionTranches', '#sumtranchesoptionsEdit', '#addConditionSum', '#sumconditionsEdit','#exportToExcelSum'], false);
            enableDisableButtons(['#cancelConditionSum', '#saveOptionTranches','#saveConditionSum'], true);
		    var grid = $("#sumconditions").data("kendoGrid");
		    grid.cancelRow();
            Cancel();
            disableTabsInEditMode('tabSum', false);
        } else {
            return;
        }
	});

	var SumConditionsDataSource = $scope.createDataSource({
        type: "webapi",
        pageSize: 100,
		transport: {
			create: saveCondition,
			update: saveCondition
		},
		requestEnd: function (e) {
			bars.ui.loader('body', false);
			if (e.type == "create") {
                bars.ui.notify("Повідомлення", "Створена нова умова для обраного запису", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#sumtranchesoptions").data().kendoGrid;
                var gridCond = $('#sumconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
			} else if (e.type == "update") {
                bars.ui.notify("Повідомлення", "Додаткова умова була відредагована", 'success', { autoHideAfter: 5 * 1000 });
                var gridOpt = $("#sumtranchesoptions").data().kendoGrid;
                var gridCond = $('#sumconditions').data().kendoGrid;

                gridOpt.dataSource.read();
                gridCond.refresh();
            } else {
                var gridOpt = $("#sumtranchesoptions").data("kendoGrid"),
                    item = gridOpt.dataItem(gridOpt.select());
                if (item == null) {
                    enableDisableButtons(['#sumtranchesoptionsEdit', '#saveOptionTranches', '#addConditionSum', '#sumconditionsEdit'], true);
                    if (checkEdit('sumconditions', [], [], e) == true) {
                        disableTabsInEditMode('tabSum', true);
                    } else {
                        return;
                    }
                } else {
                    enableDisableButtons(['#sumtranchesoptionsEdit', '#saveOptionTranches', '#addConditionSum', '#sumconditionsEdit', '#addOptionTranches'], true);
                    enableDisableButtons(['#cancelConditionSum', '#saveConditionSum'], false);
                }
            }
		},
		schema: {
			model: {
				id: "Id",
				fields: {
					Id: { type: 'string' },
					InterestOptionId: { type: 'string' },
					CurrencyId: { type: 'string' },
					Currency: { type: 'string' },
					MinSumTranche: { type: 'number' },
					MaxSumTranche: { type: 'number' },
					MinReplenishmentAmount: { type: 'number' },
					MaxReplenishmentAmount: { type: 'number' }
				}
			}
        },
        serverFiltering: false,
        serverPaging: true,
        serverSorting: false
	});
	//var secondDatasource = new kendo.data.DataSource();

    $scope.numberWithSpaces = function (x) {
        if (x == null) {
            return;
        } else {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
        }
    }
	$scope.SumConditionsGridOptions = $scope.createGridOptions({
		dataSource: SumConditionsDataSource,
		height: 300,
        selectable: "row",
        sortable: true,
		editable: 'inline',
		columns: [
			{
				field: "CurrencyId",
				title: "Валюта",
                template: "#=Currency# | #=CurrencyId# ",
				width: 180,
				editor: function (container, options) {
					var input = $('<input data-text-field="lcv" data-value-field="kv" data-bind="value: ' + options.field + '" name="' + options.field + '"/>');
					input.appendTo(container);
					//init drop
					input.kendoDropDownList({
						autoBind: true,
						dataTextField: "lcv",
                        dataValueField: "kv",
                        filter: 'contains',
						template: '#: kv # | #: lcv #',
						dataSource: {
							transport: {
								read: {
									type: "GET",
                                    dataType: "json",
                                    
									url: bars.config.urlContent("/api/gda/gda/getcurrency")
								}
							},
							schema: {
                                data: "Data",
                                model: {
                                    fields: {
                                        kv: { type: 'string' }
                                    }
                                }
							}
                        },
                        filtering: function (ev) {
                            var filterValue = ev.filter != undefined ? ev.filter.value : "";
                            ev.preventDefault();
                            var intval = parseInt(filterValue);
                            this.dataSource.filter({
                                logic: "or",
                                filters: [
                                    { field: 'kv', operator: 'startswith', value: intval.toString() },
                                    { field: 'lcv', operator: 'contains', value: filterValue }
                                ]
                            });
                        },
						optionLabel: {
							lcv: "Оберіть валюту",
							kv: null
						}
					});
                },
                sortable: {
                    compare: function (a, b) {
                        return a.CurrencyId - b.CurrencyId;
                    }
                }
			},
			{
				field: "MinSumTranche",
				title: "Мінімальна сума траншу",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.MinSumTranche - b.MinSumTranche;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.MinSumTranche < 1) {
                        return "<span>" + "0" + $scope.numberWithSpaces(dataItem.MinSumTranche) + "</span>";
                    } else {
                        return "<span>" + dataItem.MinSumTranche + "</span>";
                    }
                }
			},
			{
				field: "MaxSumTranche",
				title: "Максимальна сума траншу",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.MaxSumTranche - b.MaxSumTranche;
                    }
                },
                template: function (dataItem) {
                    return "<span>" + $scope.numberWithSpaces(dataItem.MaxSumTranche) + "</span>"
                }
			},
			{
				field: "MinReplenishmentAmount",
				title: "Мінімальна сума поповнення траншу",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.MinReplenishmentAmount - b.MinReplenishmentAmount;
                    }
                },
                template: function (dataItem) {
                    if (dataItem.MinReplenishmentAmount < 1) {
                        return "<span>" + "0" + $scope.numberWithSpaces(dataItem.MinReplenishmentAmount) + "</span>";
                    } else {
                        return "<span>" + dataItem.MinReplenishmentAmount + "</span>";
                    }
                }
			},
			{
				field: "MaxReplenishmentAmount",
				title: "Максимальна сума поповнення траншу",
                headerAttributes: { style: "text-align:center" },
                sortable: {
                    compare: function (a, b) {
                        return a.MaxReplenishmentAmount - b.MaxReplenishmentAmount;
                    }
                },
                template: function (dataItem) {
                    return "<span>" + $scope.numberWithSpaces(dataItem.MaxReplenishmentAmount) + "</span>"
                }
			}
			//{ command: ["edit"], title: "&nbsp;", width: "250px" }
		],
		save: function (e) {
			var model = e.model;
			var ddl = $("input[name=CurrencyId]").data("kendoDropDownList");
			model.Currency = ddl.text();
        },
        filterable: true,
        filterMenuInit: function (e) {
            var filterButton = $(e.container).find('.k-primary'),
                resetButton = $(e.container).find('.k-button');

            //очистити
            $(resetButton).click(function (e) {
                setTimeout("$('#sumtranchesoptions').data('kendoGrid').trigger('change')", 500);
            });

            //фільтрувати
            $(filterButton).click(function (e) {
                setTimeout("$('#sumtranchesoptions').data('kendoGrid').trigger('change')", 500);
            });
        },
        change: function (e) {
            var data = this.dataItem(this.select());
            var currency = data.Currency;
            if (currency === null || currency === '') {
                enableDisableButtons(['#saveOptionTranches', '#cancelOptionTranches'], false);
                enableDisableButtons(['#sumtranchesoptionsEdit'], true);
            } else {
                enableDisableButtons(['#sumtranchesoptionsEdit'], true);
                enableDisableButtons(['#sumconditionsEdit', '#addConditiontranches'], false);
            }
            var editRow = this.dataItem('tr.k-grid-edit-row');

            if (data != null && data.Id != "") {
                if (data == editRow) {
                    return;
                } else {
                    if (checkEdit('sumconditions', ['#sumconditionsEdit', '#saveOptionTranches','#cancelOptionTranches'], ['#saveConditionSum', '#cancelConditionSum'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabSum', true);

                    } else if (checkEdit('sumtranchesoptions', ['#saveConditionSum', '#cancelConditionSum'], ['#cancelOptionTranches', '#saveOptionTranches'], e) == true) {
                        bars.ui.alert({ text: "Завершіть редагування/додавання! <br> Щоб відмінити редагування/додавання натисніть <button class='btn btn-default'><i class='pf-icon pf-16 pf-delete'></i></button>" });
                        disableTabsInEditMode('tabSum', true);
                    }
                }
            } else {
                return;
            }

        }
    });

    $("#sumconditions").on("mousedown", "a.k-link", function (e) {
        setTimeout("$('#sumtranchesoptions').data('kendoGrid').trigger('change')", 1);
    });
});
