var formConfig = {
	nd: null,
	setNd: function (val) {
		this.nd = !val ? null : +val;
	},

    firstLoad: true,

	currentGridName: "contracts",
    currentGridSelector: "#contractsGrid",
    currentFilterSelector: "#contractsFilter",
    chain_idt: "",
    contractId: "",
	states: {},
    contractsFilters: [],
    paymentsFilters: [],
	contractsOptions: {
		selectable: "row",
		columns:
            [
                { title: "ID договору", field: "ND", width: "120px" },
				{ title: "ID субдоговору", field: "CHAIN_IDT", width: "125px" },
				{ title: "Статус", field: "ST_NAME", width: "200px" },
                { title: "Сума по договору", field: "TOTAL_AMOUNT", width: "120px" },
                { title: "Непогашений залишок", field: "AMOUNT_TO_PAY", width: "135px" },
                { title: "Кількість порцій", field: "TENOR", width: "130px" },
                { title: "Оплачено порцій", field: "PAID_PARTS", width: "130px" },
                { title: "Очікують оплати", field: "WAITING_PARTS", width: "130px" },
                { title: "Кількість прострочених порцій", field: "OVD_PARTS", width: "140px" },
                { title: "Сума прострочки порцій", field: "OVD_PARTS_SUM", width: "130px" },
                { title: "Процентна ставка", field: "SUB_INT_RATE", width: "130px" },
                { title: "Ефективна ставка", field: "EFF_RATE", width: "130px" },
                { title: "Комісія", field: "SUB_FEE_RATE", width: "130px" },
                { title: "Дата з", field: "POSTING_DATE", template: "<div style='text-align:center;'>#=(POSTING_DATE == null) ? ' ' : kendo.toString(POSTING_DATE,'dd.MM.yyyy')#</div>", width: "130px" },
                { title: "Дата по", field: "END_DATE_P", template: "<div style='text-align:center;'>#=(END_DATE_P == null) ? ' ' : kendo.toString(END_DATE_P,'dd.MM.yyyy')#</div>", width: "130px" },
                { title: "Дата визнання проблемним", field: "OVD_90_DAYS", template: "<div style='text-align:center;'>#=(OVD_90_DAYS == null) ? ' ' : kendo.toString(OVD_90_DAYS,'dd.MM.yyyy')#</div>", width: "150px" }
			]
	},
	paymentsOptions: {
		columns:
			[
                { title: "№ п/п порції", field: "SEQ_NUMBER", width: "90px" },
                { title: "Статус", field: "ST_NAME", width: "200px"},
                { title: "Дата виставлення до погашення", field: "EFF_DATE", template: "<div style='text-align:center;'>#=(EFF_DATE == null) ? ' ' : kendo.toString(EFF_DATE,'dd.MM.yyyy')#</div>", width: "165px" },
                { title: "Дата погашення", field: "REP_DATE", template: "<div style='text-align:center;'>#=(REP_DATE == null) ? ' ' : kendo.toString(REP_DATE,'dd.MM.yyyy')#</div>", width: "120px" },
                { title: "Cума порції", field: "TOTAL_AMOUNT", width: "130px" },
                { title: "Погаш осн.боргу", field: "SUM_PRINC", width: "120px" },
                { title: "Cума прострочки", field: "OVERDUE_AMOUNT", width: "120px" },
                { title: "Погаш нарах. %%", field: "SUM_INT", width: "120px" },
                { title: "Погаш комісії", field: "SUM_FEE", width: "120px" },
                { title: "Погаш разом", field: "PAID", width: "120px" }
			]
	},
	accountsOptions: {
		columns:
			[
                {
                    title: "Номер рахунку",
                    field: "NLS",
                    template: '<a title="Перехід до параметрів рахунку #=NLS#" onclick="openAccInfo(#=ACC#)">#=NLS#</a>'
                },
				{ title: "Валюта", field: "KV" },
                { title: "Тип рахунку", field: "TIP" },
                { title: "Дата відкриття", field: "DAOS", template: "<div style='text-align:center;'>#=(DAOS == null) ? ' ' : kendo.toString(DAOS,'dd.MM.yyyy')#</div>" },
                { title: "Дата закриття", field: "DAZS", template: "<div style='text-align:center;'>#=(DAZS == null) ? ' ' : kendo.toString(DAZS,'dd.MM.yyyy')#</div>" },
                { title: "Вхідний залишок", field: "OSTF" },
                { title: "Обороти Дебет", field: "DOS" },
                { title: "Обороти Кредит", field: "KOS" },
                { title: "Факт. залишок", field: "OSTC" }
			]
	},

	contractsDataSource: {
		transport: {
			read: {
				url: bars.config.urlContent("/api/Way/InstallmentApi/GetSubContracts"),
                data: function () {
                    return { states: formConfig.contractsFilters, nd: formConfig.nd };
                }
			}			
		},
		schema: {
			model: {
				fields: {
					CHAIN_IDT: { type: "number" },
					ND: { type: "number" },
					ST_ID: { type: "number" },
					ST_NAME: { type: "string" },
					TOTAL_AMOUNT: { type: "number" },
					AMOUNT_TO_PAY: { type: "number" },
					TENOR: { type: "number" },
					PAID_PARTS: { type: "number" },
					WAITING_PARTS: { type: "number" },
					OVD_PARTS: { type: "number" },
					OVD_PARTS_SUM: { type: "number" },
                    SUB_INT_RATE: { type: "number" },
					EFF_RATE: { type: "number" },
                    SUB_FEE_RATE: { type: "number" },
                    POSTING_DATE: { type: "date" },
                    END_DATE_P: { type: "date" },
                    OVD_90_DAYS: { type: "date" }
				}
			}
		}
	},
	paymentsDataSource: {
		transport: {
			read: {
				url: function () {
					var url = isEmpty(formConfig.chain_idt) ? "" : bars.config.urlContent("/api/Way/InstallmentApi/GetPayments");
					return url;
				},
				data: function () {
                    return {
                        chainIdt: formConfig.chain_idt,
                        states: formConfig.paymentsFilters
                    };
				}
			}
		},
		schema: {
			model: {
				fields: {
					CHAIN_IDT: { type: "number" },
					SEQ_NUMBER: { type: "number" },
					ST_ID: { type: "number" },
					ST_NAME: { type: "string" },
					EFF_DATE: { type: "date" },
					REP_DATE: { type: "date" },
					TOTAL_AMOUNT: { type: "number" },
					PAID: { type: "number" },
					OVERDUE_AMOUNT: { type: "number" },
					SUM_INT: { type: "number" },
					SUM_FEE: { type: "number" },
					SUM_PRINC: { type: "number" }
				}
			}
		}
	},
	accountsDataSource: {
		transport: {
			read: {
				url: function () {
					var url = isEmpty(formConfig.chain_idt) ? "" : bars.config.urlContent("/api/Way/InstallmentApi/GetAccounts");
					return url;
				},
				data: function () {
                    return {
                        chainIdt: formConfig.chain_idt
                    };
				}
			}
		},
		schema: {
			model: {
                fields: {                    
                    CHAIN_IDT: { type: "number" },
                    ACC: { type: "number" },
					NLS: { type: "string" },
					KV: { type: "number" },
					TIP: { type: "string" },
					NMS: { type: "string" },
					DAOS: { type: "date" },
					OSTF: { type: "number" },
					DOS: { type: "number" },
					KOS: { type: "number" },
					OSTC: { type: "number" },
					DAZS: { type: "date" }
				}
			}
		}
	},

	setCurrentGrid: function (val) {
		this.currentGridSelector = "#" + val + "Grid";
		this.currentGridName = val;
    },

    setCurrentFilter: function (val) {
        this.currentFilterSelector = "#" + val + "Filter";
    },

	updateGrid: function () {
		var grid = $(this.currentGridSelector).data("kendoGrid");
        if (grid) {
			grid.dataSource.read();
		}
	},

	getCurrentGridOptions: function () {
		switch (this.currentGridName) {
			case "contracts": return this.contractsOptions;
			case "payments": return this.paymentsOptions;
			case "accounts": return this.accountsOptions;
			default: return {};
		}
	},

	getCurrentGridDSOptions: function () {
		switch (this.currentGridName) {
			case "contracts": return this.contractsDataSource;
			case "payments": return this.paymentsDataSource;
			case "accounts": return this.accountsDataSource;
			default: return {};
		}
	},

	getExcelName: function () {
		switch (this.currentGridName) {
			case "contracts": return "Інстолмент Субдоговорів.xlsx";
			case "payments": return "Графік платежів.xlsx";
			case "accounts": return "Рахунки.xlsx";
			default: return {};
		}
	},

	refreshGrid: function () {
		var grid = $(this.currentGridSelector).data("kendoGrid");
		grid.refresh();
    },

    clearMultiSelect: function () {
        var filterBox = $(formConfig.currentFilterSelector).data("kendoMultiSelect");
        if (filterBox) {
            filterBox.value([]);
        }
        this.clearCurrentFilters();
    },

    clearCurrentFilters: function ()
    {
        if (this.currentGridName === "contracts")
            formConfig.contractsFilters = [];
        else
            formConfig.paymentsFilters = [];
    },

    pushCurrentFilters: function (value) {
        if (this.currentGridName === "contracts")
            this.contractsFilters.push(+value);        
        else
            this.paymentsFilters.push(+value);
    }
};

function openAccInfo(acc) {
    var url = "/viewaccounts/accountform.aspx?type=2&acc=" + acc + "&rnk=&accessmode=1";
    var installmentWindow = $("<div />").kendoWindow({
        actions: ["Maximize", "Close"],
        title: "Картка рахунку",
        width: "90%",
        height: "90%",
        content: bars.config.urlContent(url),
        iframe: true
    });
    installmentWindow.data("kendoWindow").center().open();
};

function registerButtonsEvents() {
    $(".clear-filters").click(function () {
        if (formConfig.currentGridName === "contracts") {
            formConfig.chain_idt = "";
            formConfig.contractId = "";
        }        

        formConfig.clearMultiSelect();
                
        var grid = $(formConfig.currentGridSelector).data("kendoGrid");
        var dataSource = grid.dataSource;
        dataSource.filter({});
    });

    $(".update-grid").click(function () {
        if (formConfig.currentGridName === "contracts") {
            formConfig.chain_idt = "";
            formConfig.contractId = "";
        }
            
        formConfig.updateGrid();
    });

    $(".color-button").click(function (event) {
        var id = event.currentTarget.id;
        var grid = $(formConfig.currentGridSelector).data("kendoGrid");
        var dataSource = grid.dataSource;
        var status = {
            "typeGreen" : 3,
            "typeYellow" : 4,
            "typeRed" : 5
        };
        formConfig.clearMultiSelect();
        dataSource.filter({ field: "ST_ID", operator: "eq", value: status[id] });
    });
};

function initCurrentGrid() {
	$(formConfig.currentGridSelector).empty();

	var dataSource = formConfig.getCurrentGridDSOptions();
	dataSource.requestEnd = function (e) {
		$(".k-loading-mask").remove();
	};
	dataSource = DataSourceSettings(dataSource);

	var gridOptions = formConfig.getCurrentGridOptions();

	gridOptions.dataSource = dataSource;

    gridOptions.toolbar = kendo.template($("#toolbarTemplate").html());

	gridOptions.excel = {
		allPages: true,
		fileName: formConfig.getExcelName(),
		proxyURL: bars.config.urlContent('/Way/Installment/ConvertBase64ToFile/')
	};

	gridOptions.excelExport = function (e) {
		return excelSettings(e);
	};

	gridOptions.change = function () {
		return changeEventHandler();
	};

	if (formConfig.currentGridName !== "accounts") {
		gridOptions.dataBound = function (e) {
			return dataBoundEventHandler(e);
        };
        var column = formConfig.currentGridName === "contracts" ? 2 : 1;
        gridOptions.columns[column].filterable = {
            ui: function (element) {
                element.kendoDropDownList(DropDownListSettings({
                    dataSource: formConfig.states,
                    dataValueField: "text",
                    optionLabel: "--Оберіть значення--"
                }));
            }
        };
	}

	gridOptions = GridSettings(gridOptions);

    $(formConfig.currentGridSelector).kendoGrid(gridOptions);

    registerButtonsEvents();    
};

function changeEventHandler() {

	var grid = $(formConfig.currentGridSelector).data("kendoGrid");
	var selectedItem = grid.select();

    if (selectedItem.length === 1 && formConfig.currentGridName === "contracts") {
        formConfig.chain_idt = grid.dataItem(selectedItem).CHAIN_IDT;
        formConfig.contractId = grid.dataItem(selectedItem).ND;
    }		
	else
		formConfig.chain_idt = "";
};

function excelSettings(e) {
	var sheet = e.workbook.sheets[0];
	var headers = sheet.rows[0];
	for (var i = 0; i < headers.cells.length; i++) {
		var cell = headers.cells[i];
		if (cell.value && cell.value.toString().indexOf("<br />") >= 0) {
			cell.value = cell.value.replace("<br />", "");
		}
	}
};

function dataBoundEventHandler(e) {
	var grid = $(formConfig.currentGridSelector).data("kendoGrid");
	var items = e.sender.items();
	var classType = {
		3: " typeGreen",
		4: " typeYellow",
		5: " typeRed"
	};
	items.each(function (index) {
		var dataItem = grid.dataItem(this);
		if (dataItem.ST_ID === 3 || dataItem.ST_ID === 4 || dataItem.ST_ID === 5) {
			this.className += classType[dataItem.ST_ID];
		}
	});
};

function disableButtons() {
    if (formConfig.currentGridName == "accounts") {
        $(".color-button").prop('disabled', true);
    } else {
        $(".color-button").prop('disabled', false);
    }
};

function setLabelText() {
    if (formConfig.currentGridName !== "contracts") {
        $(".contract-label").text(" " + formConfig.contractId);
        $(".sub-label").text(" " + formConfig.chain_idt);
    } else {
        return;
    }
};

function initFilterBox() {
    var filterBox = $(formConfig.currentFilterSelector).data("kendoMultiSelect");    

    if (filterBox)
        return;
    $(formConfig.currentFilterSelector).kendoMultiSelect({
        dataTextField: "text",
        dataValueField: "value",
        dataSource: formConfig.states,
        placeholder: "Натисніть для фільтрування за статусом\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0\xa0",
        autoClose: false,
        autoWidth: true,
        height: "auto",
        tagMode: "single",
        highlightFirst: false,
        tagTemplate: '<span id="selectedFilters"> Вибрано  #:values.length#  з  #:maxTotal# </span>',
        change: function () {
            formConfig.clearCurrentFilters();

            var values = this.value();

            $.each(values, function (i, value) {
                formConfig.pushCurrentFilters(+value);
            });

            var currentDS = $(formConfig.currentGridSelector).data("kendoGrid").dataSource;
            currentDS._filter = null;
            currentDS.read();
        }
    });
};

function initTabStrip() {
	$("#tabstrip").kendoTabStrip({
        activate: function () {
            if (formConfig.currentGridName === "contracts" && !formConfig.firstLoad)
                return;           
			formConfig.refreshGrid();
		},
		animation: {
			open: {
				effects: "fade:in",
				duration: 1
			},
			close: {
				effects: "fade:in",
				reverse: true,
				duration: 100
			}
        },
		scrollable: false,
		select: function (e) {
			var dataType = $(e.contentElement).attr("data-type");
            formConfig.setCurrentGrid(dataType);
            formConfig.setCurrentFilter(dataType);
            bars.ui.loader("#tabstrip", true);

            setLabelText();                

            disableButtons();

            if (dataType === "contracts" && !formConfig.firstLoad) {
                bars.ui.loader("#tabstrip", false);
                return;
            }
                
            formConfig.firstLoad = false;
            
            //formConfig.clearMultiSelect();

            initFilterBox();            

            if (dataType !== "accounts") {
                $(formConfig.currentFilterSelector)
                    .data("kendoMultiSelect")
                    .enable(!(dataType === "payments" && !formConfig.chain_idt));
            }            

            initCurrentGrid();

            changeGridMaxHeight();          
		}
	}).data("kendoTabStrip").select(0);
};

function getStatuses() {
	$.ajax({
		type: "GET",
		async: false,
		contentType: "application/json",
		url: bars.config.urlContent("/api/Way/InstallmentApi/GetStatuses"),
		beforeSend: function () {
			bars.ui.loader("#tabstrip", true);
		},
		success: function (data) {
			formConfig.states = data;
		},
		complete: function () {
			bars.ui.loader("#tabstrip", false);
		}
	});
}

$(document).ready(function () {
	var nd = $("#nd").val();
    formConfig.setNd(nd);    
    $("#title").html("Портфель договорів Інстолмент");
    getStatuses();    
    initTabStrip();    
});