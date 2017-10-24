var uids = [];
function resizeGrid() {
    try {
        $("#gridRegister").height(getSizeGrid);
        $("#gridRegister").data("kendoGrid").resize();
        $("#gridEnergo").height(getSizeGrid);
        $("#gridEnergo").data("kendoGrid").resize();
    }
    catch (e) {
        return false;
    }
}

function getSizeGrid() {
    var heigwindow = $(window).height();
    var heighH1 = $("h1").height();
    var heightFilter = $("#filter").height();
    var heightSeparator = $("#separator").height();
    var heighTabstrip = $(".k-tabstrip-items.k-reset").height();
    return heigwindow - heighH1 - heighTabstrip - heightFilter - heightSeparator - 40;
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

function onChange() {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridRegister").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    var tabStrip = $("#tabstrip").data("kendoTabStrip");
    tabStrip.enable(tabStrip.tabGroup.children().eq(1), true);
}

function onClickTab() {
    if (!$(this).is(".k-state-disabled") && !$(this).is(".k-state-active")) {
        var row = $(".k-state-selected[role=row]");
        var grid = $("#gridRegister").data("kendoGrid");
        var selectedItem = grid.dataItem(row);
        var dataSource = new kendo.data.DataSource({
            transport: {
                read: {
                    cache: false,
                    url: bars.config.urlContent('/escr/portfoliodata/GetRegisterDeals/?registerId=' + selectedItem.ID)
                }
            },
            schema: {
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
                        CREDIT_STATUS_ID: {type: "number" },
                        CREDIT_STATUS_NAME: { type: "string" },
                        CREDIT_STATUS_CODE: { type: "string" },
                        CREDIT_COMMENT: { type: "string" },
                        STATE_FOR_UI: { type: "string" },
                        GOOD_COST: { type: "number" },
                        NLS: { type: "string" },
                        ACC: { type: "number" },
                        DOC_DATE: { type: "date" },
                        AVR_DATE: { type: "date" },
                        MONEY_DATE: { type: "string" },
                        COMP_SUM: { type: "number" },
                        VALID_STATUS: { type: "string" },
                        BRANCH_CODE: { type: "string" },
                        BRANCH_NAME: { type: "string" },
                        MFO: { type: "string" },
                        USER_ID: { type: "number" },
                        USER_NAME: { type: "string" },
                        REG_TYPE_ID: { type: "number" },
                        REG_KIND_ID: { type: "number" },
                        REG_ID: { type: "number" }
                    }
                }
            },
            pageSize: 20
        });
        $("#gridEnergo").data("kendoGrid").setDataSource(dataSource);
    }
}

function detailInit(e) {
    var detailRow = e.detailRow;
    var data = e.data;
    detailRow.find("#gridEvents").kendoGrid({
        dataSource: {
            transport: {
                read: {
                    cache: false,
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
                        DEAL_EVENT: { type: "string" }
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

function onChangeEnergo() {
    $(".k-grid-btDelDeal").removeAttr("disabled");
}

function sendRegister() {
    bars.ui.loader($('#gridRegister'), true);
    var grid = $("#gridRegister").data("kendoGrid");
    var rows = grid.tbody.find("input:checked").closest("tr");

    var registers = [];
    var isSend = false;
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        registers.push(selectedItem.ID);
        if (selectedItem.REG_STATUS_CODE == "SENT_TO_CA") {
            isSend = true;
        }
    });
    if (!isSend) {
        $.ajax({
            async: true,
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/escr/PortfolioData/SendRegister/"),
            data: JSON.stringify(registers),
            success: function (result) {
                var grid = $("#gridRegister").data("kendoGrid");
                grid.dataSource.read();
                bars.ui.alert({
                    text: result == '"Ok"' ? 'Відправлено' : result
                });
                bars.ui.loader($('#gridRegister'), false);
            }
        });
    }
    else {
        bars.ui.loader($('#gridRegister'), false);
        bars.ui.alert({
            text: "Не можна відправити реєстр зі статусом <span style='color:red'><b>Відправлено в ЦА</b></span>"
        });
    }
}

function scroll() {
    var tooldiv = $("#gridEnergo .k-header.k-grid-toolbar");
    var gridCell = $("#gridEnergo .k-hierarchy-cell.k-header");
    if (!isScrolledIntoView(gridCell)) {
        tooldiv.addClass("toolbar-top-transporant");
    }
    else {
        tooldiv.removeClass("toolbar-top-transporant");
    }
}

function changeCheckRowPrtfl(elem) {
    var $this = $(elem);
    var $thisTable = $('#gridRegister');
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
            var gridData = $('#gridRegister').data('kendoGrid');
            var tr = $this.parentsUntil('tr').parent();
            $thisTable.data('selected-row').push(gridData.dataItem(tr));
        }
    } else {
        if (num != -1) {
            $thisTable.data('selected-row').splice(num, 1);
        }
    }
}

function gridDataBound(e) {
    var grid = e.sender;
    var data = grid.dataSource.data();
    if (data.length === 0) {
        var colCount = grid.columns.length;
        var message = 'немає записів';
        $(e.sender.wrapper).find('tbody').append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + message + ' :(</td></tr>');
    }
    var tabStrip = $("#tabstrip").data("kendoTabStrip");
    tabStrip.enable(tabStrip.tabGroup.children().eq(1), false);
    $(e.sender.tbody).find("tr").each(function (index, e) {
        if (e.cells.length != 1) {
            var rowId = e.cells[1].innerText;
            $(e).attr("data-row-id", rowId);
        }
    });
    for (i = 0; i < data.length; i++) {
        if (data[i].VALID_STATUS == 0) {
            $(e.sender.tbody).find("tr[data-row-id='" + data[i].ID + "']").addClass("k-error-colored");
        }
    }
    if (uids.length != 0) {
        for (var i = 0; i < uids.length; i++) {
            var curr_uid = uids[i];
            var row = $(e.sender.tbody).find("tr[data-row-id='" + curr_uid + "']");
            grid.select(row);
        }
    }
    $(".k-grid-btAddGroup").attr("disabled", "disabled");
    $(".k-grid-btDelGroup").attr("disabled", "disabled");
    $(".k-grid-btSend").attr("disabled", "disabled");
    $(e.sender.wrapper).find('input[name="checkRow"]').on("change", function () {
        var key = false;
        $(e.sender.wrapper).find('input[name="checkRow"]').each(function (index, e) {
            if ($(e).is(":checked")) {
                key = true;
                return false;
            }
        });
        if (key) {
            $(".k-grid-btAddGroup").removeAttr("disabled");
            $(".k-grid-btDelGroup").removeAttr("disabled");
            $(".k-grid-btSend").removeAttr("disabled");
        }
        else {
            $(".k-grid-btAddGroup").attr("disabled", "disabled");
            $(".k-grid-btDelGroup").attr("disabled", "disabled");
            $(".k-grid-btSend").attr("disabled", "disabled");
        }
    });
}

function groupByRegister(level) {
    var rows = $("input:checked[name='checkRow']").parent().parent();
    var grid = $("#gridRegister").data("kendoGrid");
    var dateF = $("#dtFromMsg").data("kendoDatePicker").value();
    var dateT = $("#dtToMsg").data("kendoDatePicker").value();
    var dateFrom = dateF ? (dateF.getDate() < 10 ? "0" + dateF.getDate() : dateF.getDate()) + "." + ((dateF.getMonth() + 1) < 10 ? "0" + (dateF.getMonth() + 1) : (dateF.getMonth() + 1)) + "." + dateF.getFullYear() : "";
    var dateTo = dateT ? (dateT.getDate() < 10 ? "0" + dateT.getDate() : dateT.getDate()) + "." + ((dateT.getMonth() + 1) < 10 ? "0" + (dateT.getMonth() + 1) : (dateT.getMonth() + 1)) + "." + dateT.getFullYear() : "";
    var type = grid.dataItem(rows[0]).REG_TYPE_CODE;
    var kind = grid.dataItem(rows[0]).REG_KIND_CODE;
    var level_id = level == 'CA' ? 1 : 0;
    var registerList = { dateFrom: dateFrom, dateTo: dateTo, type: type, kind: kind, reg_level: level_id, registers: [] };
    var key = true;
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        /*if (selectedItem.REG_UNION_FLAG) {
            bars.ui.alert({
                text: "Не можна згруповувати вже згруповані реєстри. Необхідно спочатку розгрупувати всі необхідні реєстри та згрупувати знову!"
            });
            key = false;
            return false;
        }*/
        if (type != selectedItem.REG_TYPE_CODE) {
            bars.ui.alert({
                text: "Не можна згруповувати реєстри з різними типами"
            });
            key = false;
            return false;
        }
        if (kind != selectedItem.REG_KIND_CODE) {
            bars.ui.alert({
                text: "Не можна згруповувати реєстри з різними видами"
            });
            key = false;
            return false;
        }
        if (selectedItem.REG_STATUS_CODE == "SENT_TO_CA" ||
            selectedItem.REG_STATUS_CODE == "CONFIRMATION_CA" ||
            selectedItem.REG_STATUS_CODE == "RECEIVED" ||
            selectedItem.REG_STATUS_CODE == "CONFIRMED_CA" ||
            selectedItem.REG_STATUS_CODE == "CONFIRMATION_GVI" ||
            selectedItem.REG_STATUS_CODE == "CONFIRMED_GVI" ||
            selectedItem.REG_STATUS_CODE == "SETTLE_ACCOUNT") {
            bars.ui.alert({
                text: "Не можна згруповувати реєстри які відправлені або вже були відправлені на ЦА"
            });
            key = false;
            return false;
        }
        registerList.registers.push(selectedItem.ID);
    });
    if (key) {
        $.ajax({
            async: true,
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/escr/PortfolioData/GroupByRegister/"),
            data: JSON.stringify(registerList),
            success: function (result) {
                var grid = $("#gridRegister").data("kendoGrid");
                grid.dataSource.read();
                bars.ui.alert({
                    text: "Реєстри згруповано успішно в новий №" + result
                });
            }
        });
    }
}

function delGroupRegister() {
    var rows = $("input:checked").parent().parent();
    var grid = $("#gridRegister").data("kendoGrid");
    var registers = [];
    var key = true;
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        if (!selectedItem.REG_UNION_FLAG) {
            bars.ui.alert({
                text: "Не можна розгруповувати не згруповані реєстри"
            });
            key = false;
            return false;
        }
        registers.push(selectedItem.ID);
    });
    if (key) {
        $.ajax({
            async: true,
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/escr/PortfolioData/DelGroupRegister/"),
            data: JSON.stringify(registers),
            success: function (result) {
                var grid = $("#gridRegister").data("kendoGrid");
                grid.dataSource.read();
            }
        });
    }
}

function delDealRegister() {
    //var rows = $("input:checked").parent().parent();
    var row = $("#gridEnergo .k-state-selected[role=row]");
    var grid = $("#gridEnergo").data("kendoGrid");
    var deals = [];
    /*rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        deals.push(selectedItem.DEAL_ID);
    });*/
    deals.push(grid.dataItem(row).DEAL_ID);
    if (grid.dataItem(row).CREDIT_STATUS_CODE == "ADD_TO_REGISTER" || grid.dataItem(row).CREDIT_STATUS_CODE == "IMPROVED") {
        $.ajax({
            async: true,
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/escr/PortfolioData/DelDealRegister/"),
            data: JSON.stringify(deals),
            success: function (result) {
                var grid = $("#gridEnergo").data("kendoGrid");
                var gridR = $("#gridRegister").data("kendoGrid");
                grid.dataSource.read();
                gridR.dataSource.read();
            }
        });
    }
    else {
        bars.ui.alert({
            text: "Не можна видаляти кредити які відправлені на розгляд."
        });
    }
}

function clickBtnPeriodOk() {

}

function create() {
    var grid = $("#gridRegister").data("kendoGrid");
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
                url: bars.config.urlContent('/escr/portfoliodata/GetRegister/?dateFrom=' + dateFrom + '&dateTo=' + dateTo + '&type=' + type + '&kind=' + kind)
            }
        },
        schema: {
            id: "ID",
            model: {
                fields: {
                    ID: { type: "number" },
                    INNER_NUMBER: { type: "string" },
                    OUTER_NUMBER: { type: "string" },
                    CREATE_DATE: { type: "date" },
                    DATE_FROM: { type: "date" },
                    DATE_TO: { type: "date" },
                    REG_TYPE_ID: { type: "number" },
                    REG_TYPE_CODE: { type: "string" },
                    REG_TYPE_NAME: { type: "string" },
                    REG_KIND_ID: { type: "number" },
                    REG_KIND_CODE: { type: "string" },
                    REG_KIND_NAME: { type: "string" },
                    BRANCH: { type: "strring" },
                    REG_LEVEL: { type: "number" },
                    REG_LEVEL_CODE: { type: "string" },
                    USER_ID: { type: "number" },
                    USER_NAME: { type: "string" },
                    REG_STATUS_ID: { type: "number" },
                    REG_STATUS_CODE: { type: "string" },
                    REG_STATUS_NAME: { type: "string" },
                    REG_UNION_FLAG: { type: "boolean" },
                    CREDIT_COUNT: { type: "number" },
                    ERR_COUNT: { type: "number" },
                    VALID_STATUS: { type: "number" }
                }
            }
        },
        pageSize: 10
    });

    grid.setDataSource(dataSource);
}