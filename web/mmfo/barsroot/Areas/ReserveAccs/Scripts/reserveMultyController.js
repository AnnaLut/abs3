//Array fix for IE8
Array.prototype.contains = function (item) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] === item) return true;
	}
	return false;
}
Array.prototype.unique = function () {
	var arr = [];
	for (var i = 0; i < this.length; i++) {
		if (!arr.contains(this[i])) {
			arr.push(this[i]);
		}
	}
	return arr;
}
//functions used in templates
function getParameterByName(name, url) {
	if (!url) url = window.location.href;
	name = name.replace(/[\[\]]/g, "\\$&");
	var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
		results = regex.exec(url);
	if (!results) return null;
	if (!results[2]) return "";
	return decodeURIComponent(results[2].replace(/\+/g, " "));
}
function viewAcc(ACC, RNK) {
	if (ACC != null && ACC !== "null") {
		window.open(encodeURI("/barsroot/viewaccounts/accountform.aspx?type=0&acc=" + ACC + "&rnk=" + RNK + "&accessmode=1"), null,
			"height=600,width=800,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
	}
	else { bars.ui.error({ title: "Помилка", text: "Неправильний рахунок клієнта!" }); }
}
function viewCustomer(RNK) {
	if (RNK != null && RNK !== "null") {
		window.open(encodeURI("/barsroot/clientregister/registration.aspx?readonly=0&rnk=" + RNK), null,
			"height=800,width=1024,menubar=no,toolbar=no,location=no,titlebar=no,scrollbars=yes,resizable=yes");
	}
	else { bars.ui.error({ title: "Помилка", text: "Неправильний ПІБ клієнта!" }); }
}
function helpInfo() {
	bars.ui.alert({ text: "Для мультивалютного акцептування з наслідуванням параметрів, необхідно обрати зарезервовані(ий) рахунки(ок) та еталонний вже відкритий рахунок зправа(один)." });
}
function cancelSelect() {
	$("#ReservedGrid").data("kendoGrid").clearSelection();
	$("#ReadyGrid").data("kendoGrid").clearSelection();
}
function getSelected(id, prop) {
	var grid = $(id).data("kendoGrid");
	return grid.dataItem(grid.select())[prop];
}
function getSelectedAll(id, prop) {
	var res = [];
	var grid = $(id).data("kendoGrid");
	var data = grid.select();
	for (var i = 0; i < data.length; i++) {
		res.push(grid.dataItem(data[i])[prop]);
	}
	return res.unique();
}
function isSelected(id) {
	return $(id).data("kendoGrid").select().length > 0;
}
function refreshGrid(id) {
	$(id).data("kendoGrid").dataSource.read();
	$(id).data("kendoGrid").refresh();
}
function loadersControll(imperor) {
	bars.ui.loader($("body"), imperor);
}
function startMultyDublicate() {
	if (isSelected("#ReadyGrid") && isSelected("#ReservedGrid")) {
		var selectedReady = getSelected("#ReadyGrid", "Id");
		var selectedReserved = getSelectedAll("#ReservedGrid", "KV");
		loadersControll(true);
		$.ajax({
			method: "POST",
			contentType: "application/json",
			async: false,
			dataType: "json",
			url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/AcceptWithDublication"),
			data: JSON.stringify({ acc: selectedReady, kv: selectedReserved }),
			success: function (data) {
				bars.ui.notify("Рахунок(ки) Акцептовано", "", "success");
			}
		});
		loadersControll(false);
		refreshGrid("#ReadyGrid");
		refreshGrid("#ReservedGrid");
	} else {
		bars.ui.alert({ text: "Не обрано рахунки" });
	}
};

$(document).ready(function () {
	$("#ReservedToolbar").kendoToolBar({
		items:
		[
			{
				template: '<button id="pbBackToSender" type="button" class="k-button" onclick="helpInfo()" title="Довідка"><i class="pf-icon pf-16 pf-help"></i></button>'
			},
			{
				template: '<button id="pbDel" type="button" class="k-button" onclick="cancelSelect()" title="Скасувати вибір"><i class="pf-icon pf-16 pf-delete"></i></button>'
			},
			{
				template: '<button id="pbtoAnotherBank" type="button" class="k-button" onclick="startMultyDublicate()" title="Перевести у відкриті"><i class="pf-icon pf-16 pf-arrow_right"></i></button>'
			}
		]
	});
	$("#ReadyGrid").kendoGrid({
		dataBound: function (e) {
			if (e.sender.dataSource.total() === 0) {
				var colCount = e.sender.columns.length;
				$(e.sender.wrapper)
					.find("tbody")
					.append("<tr class='kendo-data-row'><td colspan='" + colCount + "' class='no-data'>" + e.sender.pager.options.messages.empty + " :(</td></tr>");
			}
			var grid = this;
			grid.element.height("auto");
			grid.element.find(".k-grid-content").height("auto");
			kendo.resize(grid.element);
			//refreshToolbar();
		},
		autobind: true,
		autoBind: true,
		groupable: false,
		sortable: true,
		resizable: true,
		filterable: true,
		scrollable: true,
        selectable: "row",
        columns: [
			{
				template: '<a onclick="viewAcc(#=Id#, #=CustomerId#)" style="color: blue">#= Id #</a>',
				field: "Id",
                title: "Ід рах."
			},
			{
				field: "Number",
				title: "Номер"
			},
			{
				field: "CurrencyId",
				title: "Валюта"
			},
			{
				field: "Name",
				title: "Назва"
			},
			{
				template: '<a onclick="viewCustomer(#=CustomerId#)" style="color: blue">#= CustomerId #</a>',
				field: "CustomerId",
				title: "Ід Клієнта"
			},

        ],
        dataSource: {
			type: "json",
			serverPaging: false,
			serverSorting: false,
			serverFiltering: false,
			serverGrouping: false,
			serverAggregates: false,
            transport: {
                read: {
					dataType: "json",
					type: "POST",
					url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/GetReadyEtalonAccounts"),
					data: { rnk: getParameterByName("rnk"), nls: getParameterByName("nls") }
                }
			},
			requestStart: function () {
				bars.ui.loader($("#ReadyGrid"), true);
			},
			requestEnd: function () {
				bars.ui.loader($("#ReadyGrid"), false);
			},
			schema: {
                model: {
                    fields: {
						Id: { type: "number" },
						Number: { type: "string" },
						CurrencyId: { type: "string" },
						Name: { type: "string" },
						CustomerId: { type: "string" },
                    }
                }
            }
        }
	});
	$("#ReservedGrid").kendoGrid({
		dataBound: function (e) {
			if (e.sender.dataSource.total() === 0) {
				var colCount = e.sender.columns.length;
				$(e.sender.wrapper)
					.find("tbody")
					.append("<tr class='kendo-data-row'><td colspan='" + colCount + "' class='no-data'>" + e.sender.pager.options.messages.empty + " :(</td></tr>");
			}
			var grid = this;
			grid.element.height("auto");
			grid.element.find(".k-grid-content").height("auto");
			kendo.resize(grid.element);
			//refreshToolbar();
		},
		dataSource: {
			type: "json",
			serverPaging: false,
			serverSorting: false,
			serverFiltering: false,
			serverGrouping: false,
			serverAggregates: false,
			transport: {
				read: {
					dataType: "json",
					type: "POST",
					url: bars.config.urlContent("/api/reserveaccs/reserveaccsapi/GetReservedAccountsByKey"),
					data: { rnk: getParameterByName("rnk"), nls: getParameterByName("nls") }
				}
			},
			requestStart: function () {
				bars.ui.loader($("#ReservedGrid"), true);
			},
			requestEnd: function () {
				bars.ui.loader($("#ReservedGrid"), false);
			},
			schema: {
				model: {
					fields: {
						NLS: { type: "string", editable: false },
						KV: { type: "number", editable: false },
						NMS: { type: "string", editable: false },
						BRANCH: { type: "number", editable: false },
						ISP: { type: "string", editable: false },
						RNK: { type: "string", editable: false },
						OKPO: { type: "string", editable: false },
						NMK: { type: "string", editable: false },
						AGRM_NUM: { type: "string", editable: false }
					}
				}
			}
		},
		height: 100,
		autoBind: true,
		selectable: "multiple",
		groupable: false,
		sortable: true,
		resizable: true,
		filterable: true,
		scrollable: true,
		columns: [
			{
				field: "NLS",
				title: "Номер",
				locked: true,
				width: "120px"
			}, {
				field: "KV",
				title: "Валюта",
				width: "70px",
				locked: true
			}, {
				field: "NMS",
				title: "Назва",
				width: "250px",
				template: '<span title="#=NMS#">#=NMS#</span>'
			}, {
				field: "RNK",
				template: '<a href="." onclick="viewCustomer(#=RNK#)" style="color: blue">#= RNK #</a>',
				title: "Ід клієнта",
				width: "100px"
			}, {
				field: "OKPO",
				title: "ЄДРПО",
				width: "100px"
			}, {
				field: "NMK",
				title: "Назва клієнта",
				width: "250px",
				template: '<span title="#=NMK#">#=NMK#</span>'
			}
		]
	});
});