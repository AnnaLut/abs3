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

function onSelectImport(e) {
    var files = e.files
    var acceptedFiles = [".xls", ".xlsx"]
    var isAcceptedImageFormat = ($.inArray(files[0].extension, acceptedFiles)) != -1

    if (!isAcceptedImageFormat) {
        e.preventDefault();
        bars.ui.alert({
            text: "Завантажувати необхідно файли з розширенням xls та xlsx"
        });
    }
}

function onChange() {
    try {
        var row = $(".k-state-selected[role=row]");
        var grid = $("#gridRegister").data("kendoGrid");
        var selectedItem = grid.dataItem(row);
        var tabStrip = $("#tabstrip").data("kendoTabStrip");
        tabStrip.enable(tabStrip.tabGroup.children().eq(1), true);
        $(".k-grid-btExcel").removeAttr("disabled");
    }
    catch (e) {
        return false;
    }
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
                        CREDIT_STATUS_ID: {type: "number" },
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
                        REG_TYPE_ID: { type: "number" },
                        REG_KIND_ID: { type: "number" },
                        REG_ID: { type: "number" }
                    }
                }
            },
            pageSize: 20,
            serverPaging: true,
            serverSorting: true,
            serverFiltering: true
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
        selectable: true,
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

//btnOkdialogNewGoodCost
//btnOkDialogOutNumber

//dialogNewGoodCost
//dialogOutNumber

function clickBtnOk() {
    var cmt = $("#message");
    cmt.val("");
}

function clickbtnOkdialogNewGoodCost() {
    var cmt = $("#dialogNewGoodCost");
    cmt.val("");
}

function clickbtnOkDialogOutNumber() {
    var cmt = $("#dialogOutNumber");
    cmt.val("");
}

function windowClose(dialog) {
    var gridEnergo = $("#gridEnergo").data("kendoGrid");
    var gridRegister = $("#gridRegister").data("kendoGrid");
    var rowEnergo = $("#gridEnergo").find(".k-state-selected[role=row]");
    var selectedItemEnrg = gridEnergo.dataItem(rowEnergo);
    var state_code = $("#select-type").data("kendoMobileButtonGroup").selectedIndex == 1 ? "REJECTED_CA" : "SENT_TO_REVISION";
    $.ajax({
        async: false,
        type: "POST",
        url: bars.config.urlContent("/escr/PortfolioData/SetComment/"),
        data: { deal_id: selectedItemEnrg.DEAL_ID, comment: $("#message").val(), state_code: state_code, object_type: 0, obj_check: 0 },
        success: function () {
            dialog.close();
            gridEnergo.dataSource.read();
            gridRegister.dataSource.read();
            onChange();
        }
    });
}
function onChangeEvents() {
    //debugger;
    $(".k-grid-btDelEvents").removeAttr("disabled");
}


function onChangeEnergo() {
    //debugger;
    $(".k-grid-btComment").removeAttr("disabled");
    $(".k-grid-btNewGoodCost").removeAttr("disabled");
}


function sendRegister() {
    var rows = $("input:checked[name='checkRow']").parent().parent();
    var grid = $("#gridRegister").data("kendoGrid");
    var registers = [];
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        registers.push(selectedItem.ID);
    });
    $.ajax({
        async: true,
        type: "POST",
        contentType: "application/json",
        url: bars.config.urlContent("/escr/PortfolioData/SendRegister/"),
        data: JSON.stringify(registers),
        success: function (result) {
            var grid = $("#gridRegister").data("kendoGrid");
            grid.dataSource.read();
            alert(result);
        }
    });
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
    try {
        var tabStrip = $("#tabstrip").data("kendoTabStrip");
        tabStrip.enable(tabStrip.tabGroup.children().eq(1), false);
    }
    catch (e) {
        return false;
    }
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
    //$(".k-grid-btSendRefinement").attr("disabled", "disabled");
    $(".k-grid-btSendRefinement").hide();
    $(".k-grid-btAddGroup").attr("disabled", "disabled");
    $(".k-grid-btDelGroup").attr("disabled", "disabled");
    $(".k-grid-btPay").attr("disabled", "disabled");
    $(".k-grid-btExcel").attr("disabled", "disabled");
    $(e.sender.wrapper).find('input[name="checkRow"]').on("change", function () {
        var key = false;
        $(e.sender.wrapper).find('input[name="checkRow"]').each(function (index, e) {
            if ($(e).is(":checked")) {
                key = true;
                return false;
            }
        });
        if (key) {
            $(".k-grid-btSendRefinement").removeAttr("disabled");
            $(".k-grid-btAddGroup").removeAttr("disabled");
            $(".k-grid-btDelGroup").removeAttr("disabled");
            $(".k-grid-btPay").removeAttr("disabled");
        }
        else {
            $(".k-grid-btSendRefinement").attr("disabled", "disabled");
            $(".k-grid-btAddGroup").attr("disabled", "disabled");
            $(".k-grid-btDelGroup").attr("disabled", "disabled");
            $(".k-grid-btPay").attr("disabled", "disabled");
        }
    });
}

function groupByRegister(level) {
    var rows = $("input:checked[name='checkRow']").parent().parent();
    var grid = $("#gridRegister").data("kendoGrid");
    var dateFrom = grid.dataItem(rows[0]).DATE_FROM;
    var dateTo = grid.dataItem(rows[0]).DATE_TO;
    var type = grid.dataItem(rows[0]).REG_TYPE_CODE;
    var kind = grid.dataItem(rows[0]).REG_KIND_CODE;
    var level_id = level == 'CA' ? 1 : 0;
    var registerList = { dateFrom: dateFrom, dateTo: dateTo, type: type, kind: kind, reg_level: level_id, registers: [] };
    var key = true;
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        //if (selectedItem.REG_UNION_FLAG) {
        //    bars.ui.alert({
        //        text: "Не можна згруповувати вже згруповані реєстри. Необхідно спочатку розгрупувати всі необхідні реєстри та згрупувати знову!"
        //    });
        //    key = false;
        //    return false;
        //}
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
    var rows = $("input:checked[name='checkRow']").parent().parent();
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
    $.ajax({
        async: true,
        type: "POST",
        contentType: "application/json",
        url: bars.config.urlContent("/escr/PortfolioData/DelDealRegister/"),
        data: JSON.stringify(deals),
        success: function (result) {
            var grid = $("#gridEnergo").data("kendoGrid");
            grid.dataSource.read();
        }
    });
}
function SetOutNumber(outNumber) {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridRegister").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    //var in_out_number = 555;
    // var reg_id = 1661022;
    $.ajax({
        async: true,
        url: bars.config.urlContent("/escr/PortfolioData/SetOutNumber/"),
        data: { reg_id: selectedItem.ID, out_number: outNumber },
        success: function () {
            var grid = $("#gridRegister").data("kendoGrid");
            grid.dataSource.read();
            $("#dialogOutNumber").data("kendoWindow").close();
        }
    });
}


function ChangeCompSum(NewGoodCost) {
    var row = $(".k-state-selected[role=row]");
    var grid = $("#gridEnergo").data("kendoGrid");
    var selectedItem = grid.dataItem(row);
    // var in_out_number = 555;
    // var reg_id = 1661022;
    // alert(123);
    $.ajax({
        async: true,
        url: bars.config.urlContent("/escr/PortfolioData/СhangeCompSum/"),
        data: { deal_id: selectedItem.DEAL_ID, new_good_cost: NewGoodCost },
        success: function () {
            var grid = $("#gridEnergo").data("kendoGrid");
            grid.dataSource.read();
            $("#dialogNewGoodCost").data("kendoWindow").close();
           
        }
    });
}
function DelRegEvent() {
    //var rows = $("input:checked").parent().parent();
    var row = $("#gridEvents .k-state-selected[role=row]");
    var grid = $("#gridEvents").data("kendoGrid");
    //debugger;
    var selectedItem = grid.dataItem(row);
    // var in_out_number = 555;
    // var reg_id = 1661022;
    //alert(12355);
    $.ajax({
        async: true,
        url: bars.config.urlContent("/escr/PortfolioData/DelRegEvent/"),
        data: { deal_id: selectedItem.DEAL_ID, event_id: selectedItem.ID },
        //data: { deal_id:  , event_id: 66666 },
        //data: { deal_id: 9808621, event_id: selectedItem.ID },
        success: function () {
            var grid = $(gridEvents).data("kendoGrid");
            grid.dataSource.read();
        }
    });
}
function payReg() {
    var rows = $("input:checked[name='checkRow']").parent().parent();
    var grid = $("#gridRegister").data("kendoGrid");
    var registers = [];
    var key = true;
    rows.each(function (index, row) {
        var selectedItem = grid.dataItem(row);
        if (selectedItem.REG_STATUS_CODE != "CONFIRMED_GVI") {
            bars.ui.alert({
                text: "Не можна сформувати платіжні документи по реєстрам які не підтверджені державним органом"
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
            url: bars.config.urlContent("/escr/PortfolioData/GenRegPl/"),
            data: JSON.stringify(registers),
            success: function (result) {
                var grid = $("#gridRegister").data("kendoGrid");
                grid.dataSource.read();
            }
        });
    }
}

function getInformation(id) {
    var res;
    $.ajax({
        async: false,
        type: "GET",
        contentType: "application/json",
        url: bars.config.urlContent("/escr/PortfolioData/Validate/"),
        data: { reg_id: id },
        success: function (result) {
            res = result;
        }
    });
    return "<table style='padding: 2px 2px 2px 2px'><tr><td><span style='color: red; font-style: inherit'>Відділення яких не вистачає:</span></td></tr>" + 
           "<tr><td><span style='color: red;word-wrap:break-word'>" + res + "</span></td></tr><tr><td><br /></td></tr><tr><td><br /></td></tr>" +
           "<tr><td colspan='2'>Сформувати реєстр?</td></tr></table>";
}

function create() {
    debugger;
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
            data: "Data",
            total: "Total",
            errors: "Errors",
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
        pageSize: 10,
        serverPaging: true,
        serverSorting: true,
        serverFiltering: true
    });

    grid.setDataSource(dataSource);
}