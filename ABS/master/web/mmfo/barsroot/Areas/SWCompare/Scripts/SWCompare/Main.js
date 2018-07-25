var formConfig = {
    pageSize: 20,
    mainGrid: "#gridMain",
    ticketsGrid: "#ticketsGrid",
    mainToolBar: "#mainToolBar",
    currentTypeArr: [1, 2, 3],
    updateTicketsGrid: function () {
        var grid = $(this.ticketsGrid).data("kendoGrid");
        if (grid) {
            grid.dataSource.read();
        }
    },
    getFilter: function () {
        return {
            DateFrom: $('#date_from').val(),
            DateTo: $('#date_to').val(),
            Type: this.currentTypeArr.join(',')
        }
    }
};

function gridStart() {
    $.ajax({
        type: "GET",
        url: bars.config.urlContent("/api/SWCompare/SWCompare/GetUser"),
        success: function (res) {
            initMainGrid(res);
            registerButtonsEvents();
        },
        error: function () {
            bars.ui.alert({ text: 'Помилка запиту до БД!' });
        }
    });
};

function updateMainGrid(setPageOne) {
    var grid = $(formConfig.mainGrid).data("kendoGrid");

    if (grid) {
        if (setPageOne)
            grid.dataSource.page(1);
        else
            grid.dataSource.read();
        //grid.refresh();
        $(ticketsGrid).hide();
        $("#ticketsHeader").addClass("invisible");
    }
}

function initDatePicker() {
    var today = new Date();

    $("#date_from, #date_to").kendoDatePicker({
        format: "dd.MM.yyyy",
        value: today,
        dateInput: true,
        change: function () {
            var value = this.value();
            if (isEmpty(value))
                this.value(today);
            $(".custom-btn-payroll-filter").focus();
        }
    });

    $('#date_from').data('kendoDatePicker').value(today);
    $('#date_to').data('kendoDatePicker').value(today);

    $("#date_from, #date_to").on('keyup', function (e) {
        if (e.keyCode == 13) {
            $('#errorTypes').click();
        }
    });
};

function getWeekFromNow() {
    var date = new Date;
    date.setHours(0, 0, 0, 0);
    date.setDate(date.getDate() - 7);
    return date;
};
function getMonthFromNow() {
    var date = new Date;
    date.setHours(0, 0, 0, 0);
    date.setMonth(date.getMonth() - 1);
    return date;
}
function getYearFromNow() {
    var date = new Date();
    var year = date.getFullYear();
    date.setDate(1);
    date.setMonth(0);
    date.setFullYear(year);
    date.setHours(0, 0, 0, 0);
    return date;
}
function getNow() {
    var date = new Date;
    date.setHours(0, 0, 0, 0);
    return date;
};

function initMainGrid(user) {

    var dataSourceObj = {
        serverSorting: true,
        serverPaging: true,
        serverFiltering: true,
        type: "webapi",
        transport: {
            read: {
                type: "GET",
                url: bars.config.urlContent("/api/SWCompare/SWCompare/SearchMain"),
                dataType: "json",
                data: function () {
                    return formConfig.getFilter();
                }
            }
        },
        sort: [
            { field: "DDATE", dir: "desc" },
            { field: "TYPE", dir: "acs" },
            { field: "SYSTEM", dir: "acs" },
            { field: "OPERATION", dir: "acs" }
        ],
        pageSize: formConfig.pageSize,
        schema: {
            data: "Data",
            total: "Total",
            model: {
                fields: {
                    TYPE: { type: 'number' },
                    SYSTEM: { type: 'string' },
                    DDATE: { type: 'date' },
                    TRANSACTIONID_BARS: { type: 'string' },
                    TRANSACTIONID_EW: { type: 'string' },
                    OPERATION: { type: 'number' },
                    OPERATION_NAME: { type: 'string' },
                    DATE_BARS: { type: 'date' },
                    DATE_EW: { type: 'date' },
                    REF: { type: 'number' },
                    CAUSE_ERR: { type: 'string' },
                    KF: { type: 'string' },
                    BRANCH_BARS: { type: 'string' },
                    BRANCH_EW: { type: 'string' },
                    NLS: { type: 'string' },
                    KV: { type: 'string' },
                    SUM_BARS: { type: 'number' },
                    KOM_BARS: { type: 'string' },
                    SUM_EW: { type: 'number' },
                    KOM_EWT: { type: 'number' },
                    KOM_EWB: { type: 'number' },
                    NAZN: { type: 'string' },
                    ID_C: { type: 'number' },
                    TRN: { type: 'string' },
                    TT: { type: 'string' },
                    PRN_FILE: { type: 'number' },
                    KOD_NBU: { type: 'string' }
                }
            }
        },
        requestEnd: function () {
            var $btn = $('#clearFilter');
            var grid = $(formConfig.mainGrid).data("kendoGrid");
            var filter = grid.dataSource.filter();

            if (filter) {
                $btn.prop('disabled', false);
                $btn.addClass('clear-filter-btn-active');
            } else {
                $btn.prop('disabled', true);
                $btn.removeClass('clear-filter-btn-active');
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        excel: {
            allPages: true,
            fileName: "Протокол розбіжностей електронних переказів.xlsx",
            proxyURL: bars.config.urlContent('/SWCompare/SWCompare/ConvertBase64ToFile/')
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];

            for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
                var row = sheet.rows[rowIndex];
                for (var cellIndex = 12; cellIndex <= 15; cellIndex++) {
                    row.cells[cellIndex].format = "0.00";
                }
            }
        },
        toolbar: kendo.template($("#mainToolBarTemplate").html()),
        pageable: {
            refresh: false,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
            pageSizes: [formConfig.pageSize, 50, 100, "All"],
            buttonCount: 5
        },
        reorderable: false,
        sortable: {
            mode: "single",
            allowUnsort: true
        },
        filterable: true,
        resizable: true,
        height: "62%",
        columns: [
            { field: "DDATE", title: "Загальна дата", width: "137px", template: "<div style='text-align:center;'>#=(DDATE == null) ? ' ' : kendo.toString(DDATE,'dd.MM.yyyy')#</div>" },
            { field: "SYSTEM", title: "Назва системи", width: "140px" },
            { field: "DATE_BARS", title: "Дата операції АБС", width: "160px", template: "<div style='text-align:center;'>#=(DATE_BARS == null) ? ' ' : kendo.toString(DATE_BARS,'dd.MM.yyyy')#</div>" },
            { field: "DATE_EW", title: "Дата операції ЄВ", width: "155px", template: "<div style='text-align:center;'>#=(DATE_EW == null) ? ' ' : kendo.toString(DATE_EW,'dd.MM.yyyy')#</div>" },
            {
                field: "REF", title: "Референс", width: "110px", filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "#"
                        });
                    }
                }
            },
            { field: "OPERATION_NAME", title: "Тип операції", width: "130px" },
            { field: "CAUSE_ERR", title: "Причина розбіжності", width: "250px" },
            { field: "KF", title: "МФО", width: "80px" },
            { field: "BRANCH_BARS", title: "БРАНЧ (АБС)", width: "165px" },
            { field: "BRANCH_EW", title: "БРАНЧ (ЄВ)", width: "165px" },
            { field: "NLS", title: "Рахунок АБС (сума)", width: "170px" },
            { field: "KV", title: "Код валюти", width: "125px" },
            { field: "SUM_BARS", title: "Сума (АБС)", width: "120px", format: "{0:n2}", attributes: { style: "text-align:right;" } },
            { field: "KOM_BARS", title: "Комісія (АБС)", width: "130px", format: "{0:n2}", attributes: { style: "text-align:right;" } },
            { field: "SUM_EW", title: "Сума (ЄВ)", width: "110px", format: "{0:n2}", attributes: { style: "text-align:right;" } },
            { field: "KOM_EWT", title: "Комісія всього (ЄВ)", width: "170px", format: "{0:n2}", attributes: { style: "text-align:right;" } },
            { field: "KOM_EWB", title: "Комісія банку (ЄВ)", width: "160px", format: "{0:n2}", attributes: { style: "text-align:right;" } },
            { field: "TRANSACTIONID_BARS", title: "Транзакція (АБС)", width: "155px" },
            { field: "TRANSACTIONID_EW", title: "Транзакція (ЄВ)", width: "150px" },
            { field: "NAZN", title: "Призначення", width: "650px" },
            { field: "TRN", title: "Контрольний номер переказу", width: "227px" },
            { field: "TT", title: "TT", width: "100px", hidden: true },
            { field: "PRN_FILE", title: "PRN_FILE", width: "100px", hidden: true },
            { field: "KOD_NBU", title: "KOD_NBU", width: "100px", hidden: true },
        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>Нажаль нічого не знайдено.</b><hr class="modal-hr"/>'
        },
        change: function (e) {

            var grid = $(formConfig.mainGrid).data("kendoGrid");
            var selectedItem = this.select();
            var id_c = grid.dataItem(selectedItem).ID_C;
            var type = grid.dataItem(selectedItem).TYPE;

            if (id_c) {
                var operation = grid.dataItem(selectedItem).OPERATION;
                initTicketsGrid(id_c);
                $("#ticketsHeader").removeClass("invisible");

                $("#solveBtn").css('display', 'none');
                $("#handBtn").css("display", "none");
                $("#deleteBtn").css("display", "none");


                if (type == 1 && user != "/")
                    $("#solveBtn").css("display", "block");

                if ((type == 2 || type == 3) && user != "/")
                    $("#handBtn").css("display", "block");

                if ((type == 4 || type == 5) && user != "/")
                    $("#deleteBtn").css("display", "block");

                $(formConfig.ticketsGrid).show();
            } else {
                $(formConfig.ticketsGrid).hide();
                $("#ticketsHeader").addClass("invisible");
            }

        },
        dataBound: function (e) {
            var grid = $(formConfig.mainGrid).data("kendoGrid");
            var items = e.sender.items();
            var classType = {
                0: " typeGreen",
                1: " typeYellow",
                2: " typeRed",
                3: " typePink",
                4: " typeBlue",
                5: " typeBlue",
            };
            items.each(function (index) {
                var dataItem = grid.dataItem(this);
                this.className += classType[dataItem.TYPE];
            });

        }
    };

    $(formConfig.mainGrid).kendoGrid(gridOptions);

    if (user != "/") {
        $("#zsRequest").hide();
        $("#ruRequest").hide();
    }
};
//фильтры периода - перечитка грида
function filterByButtons(period) {
    var date_from;
    var today = new Date;
    var date = {
        today: new Date,
        week: getWeekFromNow(),
        month: getMonthFromNow()
    }

    today.setHours(0, 0, 0, 0);
    date_from = date[period];
    date_from.setHours(0, 0, 0, 0);

    $("#date_from").data("kendoDatePicker").value(date_from);
    $("#date_to").data("kendoDatePicker").value(today);

    $('#errorTypes').click();
};

function getComments(comments) {
    var grid = $("#gridMain").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select()); 

    var postObj = {
        p_kod_nbu: selectedItem.KOD_NBU,
        p_ref: selectedItem.REF,
        p_tt: selectedItem.TT,
        p_transactionid: selectedItem.TRANSACTIONID_EW,
        p_operation: selectedItem.OPERATION,
        p_ddate_oper: selectedItem.DDATE,
        p_prn_file: selectedItem.PRN_FILE,
        p_kf: selectedItem.KF,
        p_comments: comments
    };

    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: bars.config.urlContent("/api/SWCompare/SWCompare/HandFixing"),
        beforeSend: function () {
            bars.ui.loader('body', true);
        },
        data: JSON.stringify(postObj),
        success: function (data) {
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                updateMainGrid();
            }
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
};

function ResovleDifference(_comment) {
    var grid = $("#gridMain").data("kendoGrid");
    var selectedItem = grid.dataItem(grid.select());
    var postObj = { p_id: selectedItem.ID_C, comment: _comment };
    $.ajax({
        type: "POST",
        contentType: "application/json",
        url: bars.config.urlContent("/api/SWCompare/SWCompare/ResolveDifference"),
        beforeSend: function () {
            bars.ui.loader('body', true);
        },
        data: JSON.stringify(postObj),
        success: function (data) {
            if (data.Result != "OK") {
                bars.ui.error({ text: data.ErrorMsg });
            } else {
                updateMainGrid();
            }
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
}

function initTicketsGrid(param) {

    var dataSourceObj = {
        type: "webapi",
        transport: {
            read: {
                data: { id_c: param },
                url: bars.config.urlContent("/api/SWCompare/SWCompare/SearchTickets"),
                dataType: "json"
            }
        },
        pageSize: 1,
        schema: {
            data: "Data",
            model: {
                fields: {
                    ID: { type: 'number' },
                    KOD_NBU: { type: 'string' },
                    DDATE: { type: 'date' },
                    USERID: { type: 'number' },
                    FIO: { type: 'string' },
                    REF: { type: 'number' },
                    FIO_REF: { type: 'string' },
                    PRN_FILE_OWN: { type: 'number' },
                    PRN_FILE_IMPORT: { type: 'number' },
                    SOS_NAME: { type: 'string' },
                    COMMENTS: { type: 'string' }
                }
            }
        }
    };

    var gridDataSource = new kendo.data.DataSource(dataSourceObj);

    var gridOptions = {
        dataSource: gridDataSource,
        pageable: {
            refresh: false,
            info: false,
            pageSize: false,
            previousNext: false,
            numeric: false,
            messages: {
                empty: "Дані відсутні",
                allPages: "Всі"
            },
        },
        toolbar: kendo.template($("#ticketsToolBarTemplate").html()),
        reorderable: false,
        sortable: false,
        filterable: false,
        resizable: true,
        height: "6,1%",
        scrollable: false,
        columns: [
            { field: "DDATE", title: "Дата", width: "100px", template: "<div style='text-align:center;'>#=(DDATE == null) ? ' ' : kendo.toString(DDATE,'dd.MM.yyyy')#</div>" },
            { field: "FIO", title: "Користувач" },
            { field: "REF", title: "Референс" },
            { field: "SOS_NAME", title: "Статус" },
            { field: "FIO_REF", title: "Користувач операції" },
            { field: "COMMENTS", title: "Коментарій" },
            { field: "ID", title: "Номер квитовки", width: "120px" },
            { field: "PRN_FILE_OWN", title: "Файл РУ", width: "100px" },
            { field: "PRN_FILE_IMPORT", title: "Файл ЗС", width: "100px" }

        ],
        selectable: "row",
        editable: false,
        scrollable: true,
        noRecords: {
            template: '<hr class="modal-hr"/><b>Нажаль нічого не знайдено.</b><hr class="modal-hr"/>'
        }
    };

    $(formConfig.ticketsGrid).kendoGrid(gridOptions);
    $("#solveBtn").off();
    $("#solveBtn").on("click", function () {
        var windowText = "<div class=\"k-container\" style=\"width:100%; font-size: 18px;\"><div style=\"width:100%; margin-top: 20px;\">Коментар: <input type=\"text\"  id=\"resolve_comments\" maxlength=\"100\" class='k-textbox' style=\"width:82%;\" " +
            "onchange='if(this.value == \"\") { $(\"#okBtn\").prop(\"disabled\", true);} else{  $(\"#okBtn\").prop(\"disabled\", false); }' " +
            "onkeyup = \"this.onchange();\" onpaste= \"this.onchange();\" oninput= \"this.onchange();\" oncut=\"this.onchange();\"></div>" +
            "<div style=\"width:100%; margin-top: 20px;\"><button id='okBtn' type='button' class='k-button k-primary' onclick='ResovleDifference($(\"#resolve_comments\").val()); $(this).closest(\".k-window-content\").data(\"kendoWindow\").close();' autofocus disabled style=\"width:48%;\">" +
            "Зберегти</button><button id='cancelBtn' type='button' class='k-button close-button' onclick='$(this).closest(\".k-window-content\").data(\"kendoWindow\").close();' style=\"width:48%; margin-left: 10px;\">Відміна</button></div></div>";

        $('#resolveWindow').html(windowText);
        $('#resolveWindow').kendoWindow({
            resizable: false,
            modal: true,
            title: "Введіть коментар",
            width: "590px",
            height: "150px",
            visible: false,
        }).data("kendoWindow").center().open();

        var winObject = $("#resolveWindow").data("kendoWindow");
        winObject.wrapper.addClass("k-widget k-window");
    });

    $("#deleteBtn").off();
    $("#deleteBtn").on("click", function () {
        var postObj = { p_id: param };
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: bars.config.urlContent("/api/SWCompare/SWCompare/DeleteСompare"),
            beforeSend: function () {
                bars.ui.loader('body', true);
            },
            data: JSON.stringify(postObj),
            success: function (data) {
                if (data.Result != "OK") {
                    bars.ui.error({ text: data.ErrorMsg });
                } else {
                    updateMainGrid();
                }
            },
            complete: function () {
                bars.ui.loader('body', false);
            }
        });
    });



    $("#handBtn").off();
    $("#handBtn").on("click", function () {
        var windowText = "<div class=\"k-container\" style=\"width:100%; font-size: 18px;\"><div style=\"width:100%; margin-top: 20px;\">Коментар: <input type=\"text\"  id=\"comments\" class='k-textbox' style=\"width:82%;\" " +
            "onchange='if(this.value == \"\") { $(\"#okBtn\").prop(\"disabled\", true);} else{  $(\"#okBtn\").prop(\"disabled\", false); }' " +
            "onkeyup = \"this.onchange();\" onpaste= \"this.onchange();\" oninput= \"this.onchange();\" oncut=\"this.onchange();\"></div>" +
            "<div style=\"width:100%; margin-top: 20px;\"><button id='okBtn' type='button' class='k-button k-primary' onclick='getComments($(\"#comments\").val()); $(this).closest(\".k-window-content\").data(\"kendoWindow\").close();' autofocus disabled style=\"width:48%;\">" +
            "Зберегти</button><button id='cancelBtn' type='button' class='k-button close-button' onclick='$(this).closest(\".k-window-content\").data(\"kendoWindow\").close();' style=\"width:48%; margin-left: 10px;\">Відміна</button></div></div>";

        $('#reportWindow').html(windowText);
        $('#reportWindow').kendoWindow({
            resizable: false,
            modal: true,
            title: "Введіть коментар",
            width: "590px",
            height: "150px",
            visible: false,
        }).data("kendoWindow").center().open();

        var winObject = $("#reportWindow").data("kendoWindow");
        winObject.wrapper.addClass("k-widget k-window");

    });


};

function setModalButton(id) {
    requestsForm(function () {
        updateMainGrid();
    }, id);
}

function registerButtonsEvents() {
    var period = ["today", "week", "month"];
    function _setPeriodFunc(id) { return function () { filterByButtons(id); } }
    for (var i = 0; i < period.length; i++) {
        var p = period[i];
        $("#" + p).on("click", _setPeriodFunc(p));
    }

    var gridId = [formConfig.mainGrid, formConfig.ticketsGrid];
    function _setGridFunc(id) { return function () { showDialogWindow(id); } }
    for (var i = 0; i < gridId.length; i++) {
        var id = gridId[i];
        $(id).on('dblclick', 'tr:not(:first)', _setGridFunc(id));
    }

    $('.fBtn').on('click', function () {
        $('.fBtn').removeClass('custom-btn-active');
        $('.fBtn').html('');
        $('#allTypes').html('Всі');

        var $self = $(this);
        $self.addClass('custom-btn-active').html($self.attr('data-selected'));

        formConfig.currentTypeArr = JSON.parse($self.attr('data-value'));
        updateMainGrid(true);
    });

    $('.custom-btn-payroll-filter').on('click', function () {
        $('#errorTypes').click();
    });

    var requests = ["ruRequest", "zsRequest", "ticketing"];
    function _setRequests(id) { return function () { setModalButton(id); } }
    for (var i = 0; i < requests.length; i++) {
        var request = requests[i];
        $("#" + request).on("click", _setRequests(request));
    }

    $('#clearFilter').on('click', function () {
        var grid = $(formConfig.mainGrid).data("kendoGrid");
        grid.dataSource.filter({});
    });
};

function showDialogWindow(gridSelector) {
    var grid = $(gridSelector).data("kendoGrid");
    var record = grid.dataItem(grid.select());
    if (record.REF) {
        //var docUrl = bars.config.urlContent("/documents/item/" + record.REF + "/");
        //window.showModalDialog(docUrl, null, 'dialogWidth:790px;dialogHeight:550px');
        openDoc(record.REF);
    } else {
        bars.ui.alert({ text: 'Референс відсутній!' });
    }
};

function openDoc(ref) {
    if (ref === undefined || ref == null || ref == '') return;

    if (window.showModalDialog)
        window.showModalDialog('/barsroot/documents/item/?id=' + ref, null, 'dialogWidth:720px;dialogHeight:550px');
    else {
        var w = 720;
        var h = 550;

        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);

        var targetWin = window.open('/barsroot/documents/item/?id=' + ref, '', 'modal=yes, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }
};
