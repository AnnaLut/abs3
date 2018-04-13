function resizeGrid() {
    $("#gridEnergo").height(getSizeGrid);
    $("#gridEnergo").data("kendoGrid").resize();
}

function getSizeGrid() {
    var heigwindow = $(window).height();
    var heighH1 = $("h1").height();
    var heighFilter = $("#filter").height();
    return heigwindow - heighH1 - heighFilter - 50;
}

function isScrolledIntoView(elem) {
    var $elem = $(elem);
    var $window = $(window);
    var docViewTop = $window.scrollTop();
    var docViewBottom = docViewTop + $window.height();
    var elemTop = $elem.offset().top;
    var elemBottom = elemTop + $elem.height();
    return (elemBottom <= docViewBottom) && (elemTop >= docViewTop); 
}

function onChangeGrid() {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridEnergo").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    if (selectedItem.STATE_FOR_UI == "ERROR") {
        $(".k-button.k-button-icontext.k-grid-btChange").removeAttr("disabled");
    }
    else {
        $(".k-button.k-button-icontext.k-grid-btChange").attr("disabled", "disabled");
    }
}

function create() {
    var grid = $("#gridEnergo").data("kendoGrid");
    var dateF = $("#dtFrom").data("kendoDatePicker").value();
    var dateT = $("#dtTo").data("kendoDatePicker").value();
    var dateFrom = dateF ? (dateF.getDate() < 10 ? "0" + dateF.getDate() : dateF.getDate()) + "." + ((dateF.getMonth() + 1) < 10 ? "0" + (dateF.getMonth() + 1) : (dateF.getMonth() + 1)) + "." + dateF.getFullYear() : "";
    var dateTo = dateT ? (dateT.getDate() < 10 ? "0" + dateT.getDate() : dateT.getDate()) + "." + ((dateT.getMonth() + 1) < 10 ? "0" + (dateT.getMonth() + 1) : (dateT.getMonth() + 1)) + "." + dateT.getFullYear() : "";
    var type = $("#ddlType").data("kendoDropDownList").value();
    var kind = $("#ddlView").data("kendoDropDownList").value();
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
            cache: false,
                url: bars.config.urlContent('/escr/portfoliodata/GetRegisterMain/?dateFrom=' + dateFrom + '&dateTo=' + dateTo + '&type=' + type + '&kind=' + kind)
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                fields: {
                    NUM: { type: "number" },
                    CUSTOMER_ID: { type: "number" },
                    CUSTOMER_NAME: { type: "string" },
                    CUSTOMER_OKPO: { type: "string" },
                    CUSTOMER_REGION: { type: "string" },
                    CUSTOMER_FULL_ADDRESS: { type: "string" },
                    CUSTOMER_TYPE: { type: "number" },
                    SUBS_NUMB: { type: "string" },
                    SUBS_DATE: { type: "date" },
                    SUBS_DOC_TYPE: { type: "string" },
                    DEAL_ID: { type: "number" },
                    DEAL_NUMBER: { type: "string" },
                    DEAL_DATE_FROM: { type: "date" },
                    DEAL_DATE_TO: { type: "date" },
                    DEAL_TERM: { type: "number" },
                    DEAL_PRODUCT: { type: "string" },
                    DEAL_STATE: { type: "string" },
                    DEAL_TYPE_CODE: { type: "number" },
                    DEAL_TYPE_NAME: { type: "string" },
                    DEAL_SUM: { type: "number" },
                    CREDIT_STATUS_ID: { type: "number" },
                    CREDIT_STATUS_NAME: { type: "string" },
                    CREDIT_STATUS_CODE: { type: "string" },
                    CREDIT_COMMENT: { type: "string" },
                    STATE_FOR_UI: { type: "string" },
                    GOOD_COST: { type: "number" },
                    NLS: { type: "string" },
                    ACC: { type: "number" },
                    DOC_DATE: { type: "date" },
                    MONEY_DATE: { type: "string" },
                    COMP_SUM: { type: "number" },
                    VALID_STATUS: { type: "string" },
                    BRANCH_CODE: { type: "string" },
                    BRANCH_NAME: { type: "string" },
                    MFO: { type: "string" },
                    USER_ID: { type: "number" },
                    USER_NAME: { type: "string" },
                    REG_KIND_CODE: { type: "string" },
                    REG_KIND_NAME: { type: "string" },
                    REG_TYPE_CODE: { type: "string" },
                    REG_TYPE_NAME: { type: "string" }
                }
            }
        },
        pageSize: 50,
        serverPaging: true,
        serverFiltering: true
    }); 

    grid.setDataSource(dataSource);
}

function save() {
    var dateF = $("#dtFrom").data("kendoDatePicker").value();
    var dateT = $("#dtTo").data("kendoDatePicker").value();
    var type = $("#ddlType").data("kendoDropDownList").value();
    var kind = $("#ddlView").data("kendoDropDownList").value();
    if (!dateF && !dateT) {
        bars.ui.alert({
            text: "Для збереження записів в реєстр обов`язково необхідно вказати період формування"
        });
        return false;
    }
    var dateFrom = (dateF.getDate() < 10 ? "0" + dateF.getDate() : dateF.getDate()) + "." + ((dateF.getMonth() + 1) < 10 ? "0" + (dateF.getMonth() + 1) : (dateF.getMonth() + 1)) + "." + dateF.getFullYear();
    var dateTo = (dateT.getDate() < 10 ? "0" + dateT.getDate() : dateT.getDate()) + "." + ((dateT.getMonth() + 1) < 10 ? "0" + (dateT.getMonth() + 1) : (dateT.getMonth() + 1)) + "." + dateT.getFullYear();
    var jsonItems = { dateFrom: dateFrom, dateTo: dateTo, type: type, kind: kind, deals: [] };
    var grid = $("#gridEnergo").data("kendoGrid");
    var checkedRows = $("#gridEnergo").find('input[type="checkbox"][name="checkRow"]');
    for (var i = 0; i < checkedRows.length; i++) {
        if ($(checkedRows[i]).is(":checked")) {
            var tr = $(checkedRows[i]).parent().parent();
            var selectedItem = grid.dataItem(tr);
            if (type != grid.dataItem(tr).REG_TYPE_CODE) {
                bars.ui.alert({
                    text: "Для збереження записів в реєстр обов`язково необхідно обрати тип реєстру, або в список для збереження потрапили кредити з іншим типом"
                });
                return false;
            }
            if (kind != grid.dataItem(tr).REG_KIND_CODE) {
                bars.ui.alert({
                    text: "Для збереження записів в реєстр обов`язково необхідно обрати вид реєстру, або в список для збереження потрапили кредити з іншим видом"
                });
                return false;
            }
            jsonItems.deals.push(selectedItem.DEAL_ID);
        }
    }
    $.ajax({
        async: true,
        type: "POST",
        contentType: "application/json",
        url: bars.config.urlContent("/escr/PortfolioData/SaveRegister/"),
        data: JSON.stringify(jsonItems),
        success: function (result) {
            var grid = $("#gridEnergo").data("kendoGrid");
            grid.dataSource.read();
            bars.ui.alert({
                text: "Реєстр №" + result + " сформовано"
            });
        }
    });
}

function detailInit(e) {
    var detailRow = e.detailRow;
    var data = e.data;
    detailRow.find("#gridEvents").kendoGrid({
        dataSource: {
            transport: {
                cache: false,
                read: {
                    url: bars.config.urlContent('/escr/portfoliodata/GetEvents/?customerId=' + data.CUSTOMER_ID + '&dealId=' + data.DEAL_ID)
                }
            },
            schema: {
                model: {
                    fields: {
                        NUM: { type: "number" },
                        DEAL_ID: { type: "number" },
                        DEAL_KF: { type: "string" },
                        DEAL_ADR_ID: { type: "number" },
                        DEAL_REGION: { type: "string" },
                        DEAL_FULL_ADDRESS: { type: "string" },
                        DEAL_BUILD_TYPE: { type: "string" },
                        DEAL_EVENT_ID: { type: "number" },
                        DEAL_EVENT: { type: "string" },
                        ID : { type: "number" }
                    }
                }
            },
            pageSize: 5
        },
        pageable: {
            refresh: true,
            pageSizes: [5, 10, 20],

            buttonCount: 5
        },
        change: onChangeEvents,
        columns: [{
            title: "№ п/п",
            field: "NUM",
            width: 30
        },
        {
            title: "Адреса будинку, в якому впроваджується захід",
            columns: [{
                title: "область",
                field: "DEAL_REGION",
                width: 200
            },
            {
                title: "р-н, нас.п., вул., буд.(кв.)",
                field: "DEAL_FULL_ADDRESS",
                width: 250
            },
            {
                title: "тип будинку",
                field: "DEAL_BUILD_TYPE",
                width: 100
            }]
        },
        {
            title: "Цілі кредитування",
            field: "DEAL_EVENT",
            width: 300
        }]
    });
}

function setDate() {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridEnergo").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    var dateD = $("#dtDocDate").data("kendoDatePicker").value();
    var dateDoc = (dateD.getDate() < 10 ? "0" + dateD.getDate() : dateD.getDate()) + "." + ((dateD.getMonth() + 1) < 10 ? "0" + (dateD.getMonth() + 1) : (dateD.getMonth() + 1)) + "." + dateD.getFullYear();
    $.ajax({
        async: true,
        url: bars.config.urlContent("/escr/PortfolioData/SetDocDate/"),
        data: { deal_id: selectedItem.DEAL_ID, doc_date: dateDoc },
        success: function () {
            var grid = $("#gridEnergo").data("kendoGrid");
            grid.dataSource.read();
            $("#dialogSetDate").data("kendoWindow").close();
        }
    });
}

function changeCheckRowIndx(elem) {
    var $this = $(elem);
    var $thisTable = $('#gridEnergo');
    if (!$thisTable.data('selected-row')) {
        $thisTable.data('selected-row', []);
    }
    var num = -1;
    for (var i = 0; i < $thisTable.data('selected-row').length; i++) {
        if ($thisTable.data('selected-row')[i].PrimaryKeyColumn == $this.val()) {
            num = i;
        }
    }
    if ($this.is(':checked')) {
        if (num == -1) {
            var gridData = $('#gridEnergo').data('kendoGrid');
            var tr = $this.parentsUntil('tr').parent();
            $thisTable.data('selected-row').push(gridData.dataItem(tr));
        }
    } else {
        if (num != -1) {
            $thisTable.data('selected-row').splice(num, 1);
        }
    }
}

function cangeErrors() {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridEnergo").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    var stateCode = "IMPROVED";
    if (selectedItem.STATE_FOR_UI == "ERROR") {
        $.ajax({
            async: true,
            url: bars.config.urlContent("/escr/PortfolioData/SetCreditState/"),
            data: { deal_id: selectedItem.DEAL_ID, state_code: stateCode },
            success: function () {
                var grid = $("#gridEnergo").data("kendoGrid");
                grid.dataSource.read();
            }
        });
    }
}

function checkState() {
    bars.ui.loader($('#gridEnergo'), true);
    $.ajax({
        async: true,
        url: bars.config.urlContent("/escr/PortfolioData/CheckState/"),
        success: function () {
            var grid = $("#gridEnergo").data("kendoGrid");
            grid.dataSource.read();
            bars.ui.loader($('#gridEnergo'), false);
        }
    });
}

function onChangeEvents() {
    debugger;
    $(".k-grid-btDelEvents").removeAttr("disabled");
}
