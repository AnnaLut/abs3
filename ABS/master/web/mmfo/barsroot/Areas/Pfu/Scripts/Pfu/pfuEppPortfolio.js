function Search() {
    ClearCheckBoxes();
    var grid = $("#gridPortfolio").data("kendoGrid");
    if (grid) { grid.dataSource.fetch(); }
}

$(document).ready(function () {

    $('#SearchBtn').click(Search);

    $('#RepOrSet').prop("disabled", true);
    $("#RepOrSet").html('Повторна обробка');

    var _datePickers = ["#datepicker", "#datepicker1"];
    for (var j = 0; j < _datePickers.length; j++) {
        $(_datePickers[j]).kendoDatePicker({
            format: "dd/MM/yyyy"
        });
    }

    var todayDate = kendo.toString(kendo.parseDate(new Date()), 'dd/MM/yyyy');
    var modalWinRNK = $("#modalWinRNK").kendoWindow({
        width: "90%",
        modal: true,
        title: "РНК",
        visible: false,
        actions: [
            "Close"
        ]
    }).data("kendoWindow");

    var modalWinEppNum = $("#modalWinEppNum").kendoWindow({
        width: "90%",
        modal: true,
        title: "ЕПП",
        visible: false,
        actions: [
            "Close"
        ]
    }).data("kendoWindow");

    var modalWinAccNum = $("#modalWinAccNum").kendoWindow({
        width: "90%",
        modal: true,
        title: "Розрахунковий рахунок",
        visible: false,
        actions: [
            "Close"
        ]
    }).data("kendoWindow");

    $('body').on('click', '#RepOrSet', GetButtonFunc);
    $('body').on('click', '#SetRNK', AssignRNK);

    var modalWinFunc = $("#modalWinFunc").kendoWindow({
        width: "90%",
        modal: true,
        title: "Присвоїти РНК",
        visible: false,
        actions: [
            "Close"
        ],
        close: onCloseModalWinFunc,
    }).data("kendoWindow");

    data = []
    FillKFDropDown();
    initPortfolioGrid();
    initRNKGrid();
    initEppNumGrid();
    initAccNumGrid();
    ChangeCheckBoxes();

})



var id_epp_num = null, id_rnk_num = null, id_row = null, id_acc_num = null, totalrows = 0, glob_kf = '', glob_date = '';

function FillKFDropDown() {
    fillDropDownList("#KFselect", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/EppPortfolio/GetBranchСode") } },
        schema: { model: { fields: { KF: { type: "string" } } } }
    }, {
        filter: "startswith",
        dataTextField: "KF", dataValueField: "KF",
        optionLabel: "Оберіть код"
    });
}
//выводит в ссылках запись в ячейке()вызов с темплейта
function ShowValue(value) {
    if (value === null)
        return "";
    else
        return value;
}

//прри перечитке очищает чекбоксы
function ClearCheckBoxes() {
    $('#total').html(totalrows);
    $('#fun_passval').prop('checked', false);
    $('#fun_new').prop('checked', false);
    $('#fun_sendru').prop('checked', false);
    $('#fun_accopen').prop('checked', false);
    $('#fun_cardsact').prop('checked', false);
    $('#fun_passact').prop('checked', false);
    $('#fun_kv2send').prop('checked', false);
    $('#fun_erropenaclient').prop('checked', false);
    $('#fun_failedval').prop('checked', false);
    $('#fun_erropenacc').prop('checked', false);
    $('#fun_errpercard').prop('checked', false);
    $('#fun_blockepp').prop('checked', false);
    $('#fun_kminwork').prop('checked', false);
    $('#fun_prockm').prop('checked', false);
    $('#fun_errkm').prop('checked', false);
    $('#fun_perprocc').prop('checked', false);
    $('#fun_inprocc').prop('checked', false);
    $('#fun_erropen').prop('checked', false);

    $("#new").html(0)
    $("#passval").html(0)
    $('#sendru').html(0)
    $("#accopen").html(0)
    $("#cardsact").html(0)
    $("#passact").html(0)
    $("#kv2send").html(0)
    $("#failedval").html(0)
    $("#erropenaclient").html(0)
    $("#erropenacc").html(0)
    $("#errpercard").html(0)
    $("#blockepp").html()
    $("#kminwork").html(0)
    $("#prockm").html(0)
    $("#errkm").html(0)
    $("#perprocc").html(0)
    $("#inprocc").html(0)
    $("#erropen").html(0)
}

// взвисимости на какаю ячейку нажато выводит модальное окно с нужным гридом
function ShowGrids(value, field, id) {
    id_row = id
    if (field === "Код ЕПП") {
        id_epp_num = value;
        var win = $("#modalWinEppNum").data("kendoWindow");
        win.open().center().toFront();
        $("#gridEppNum").data("kendoGrid").dataSource.read();
    }
    else if (field === "Відкритий розрахунковий рахунок особи") {
        id_acc_num = value;
        var win = $("#modalWinAccNum").data("kendoWindow");
        win.open().center().toFront();
        $("#gridAccNum").data("kendoGrid").dataSource.read();
    }
    else if (field === "РНК") {
        id_rnk_num = value;
        var win = $("#modalWinRNK").data("kendoWindow");
        win.open().center().toFront();
        $("#gridRNK").data("kendoGrid").dataSource.read();
    }
}

/*function GetRowsByStatus(status) {

    var value = 0

    kf = $('#KFselect').data("kendoDropDownList").value();
    date = $("#datepicker").data("kendoDatePicker").value();
    date = kendo.toString(date, "dd.MM.yyyy")
    $.ajax({
        method: "GET",
        contentType: "application/json",
        async: true,
        dataType: "json",
        url: bars.config.urlContent("/api/pfu/EppPortfolio/GetRowsByStatus") + "?status=" + s_status + "&kf=" + kf + "&date=" + date,
        complete: function (data) {
            //$("#gridPortfolio").data("kendoGrid").dataSource = { data: data }
            //$("#gridPortfolio").data("kendoGrid").refresh();
        }
    });
}*/

var s_status = ""
//конкатенирует статусы если те активны
function FormatFilterValue(checkid, idvalue) {
    debugger;
    $("#" + checkid).change(function () {

        if ($("#" + checkid)[0].checked == true) {
            s_status = s_status.concat(" OR STATE_ID = " + idvalue + " ");

        }
        else
            s_status = s_status.replace(" OR STATE_ID = " + idvalue + " ", "");
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    return s_status;
}
//если чекбокс активній то идет проверка какой
function ChangeCheckBoxes() {
    FormatFilterValue("fun_new", 1);
    FormatFilterValue("fun_passval", 2);
    FormatFilterValue("fun_sendru", 20);
    FormatFilterValue("fun_accopen", 8);
    FormatFilterValue("fun_cardsact", 12);
    FormatFilterValue("fun_passact", 13);
    FormatFilterValue("fun_kv2send", 14);
    FormatFilterValue("fun_failedval", 3);
    FormatFilterValue("fun_erropenaclient", 27);
    FormatFilterValue("fun_erropenacc", 28);
    FormatFilterValue("fun_errpercard", 29);
    FormatFilterValue("fun_blockepp", 19);
    FormatFilterValue("fun_kminwork", 24);
    FormatFilterValue("fun_prockm", 25);
    FormatFilterValue("fun_errkm", 26);
    FormatFilterValue("fun_erropen", 7);
    FormatFilterValue("fun_perprocc", 30);
    FormatFilterValue("fun_inprocc", 31);
}

// форматирует коректно дату для вывода
PrintDate = function (value) {
    if (value === null)
        return "";
    else
        return kendo.toString(kendo.parseDate(value, 'yyyy-MM-dd'), 'dd/MM/yyyy')

};

function RNKisEmpty() {

    var grid = $("#FunctionGrid").data("kendoGrid")._data
    for (var i = 0; i < grid.length; i++) {
        if (!grid[i].RNK) {

            return false;
        }
    }
    return true;
}
//при закривании модального окна перечитка главного грида
function onCloseModalWinFunc() {
    $("#gridPortfolio").data("kendoGrid").dataSource.read();
}

function CheckRowRNK(item) {
    debugger;
    if (item) {
        var checked = false
        if (item.RNK === null && item.STATE_ID === 27)
            checked = true;
        else
            checked = false

        return checked
    }

}

function CheckRowState(item) {
    debugger;
    if (item) {
        var checked = false
        var states = [3, 26, 27, 28, 29]
        for (var i = 0; i < states.length; i++) {
            if (item.STATE_ID === states[i] && item.RNK != null) {
                checked = true;
                return checked
            }
            else
                checked = false
        }
        return checked
    }
}
//Узнает какая кнопка или "Повторна обробка" или 
function GetButtonFunc() {
    var gridElement = $("#gridPortfolio").data("kendoGrid");
    var selectedItems = gridElement.select();
    var rows = [];
    $.each(selectedItems, function (index, row) {
        var selectedItem = gridElement.dataItem(row);
        rows.push(selectedItem);
    })
    if ($('#RepOrSet').text() === 'Повторна обробка') {
        RepeatProcessing(rows)
    }
    else {

        var win = $("#modalWinFunc").data("kendoWindow");

        initFunctionGrid(rows);
        $("#FunctionGrid").data("kendoGrid").dataSource.read();
        win.open().center().toFront();
        debugger;
        RNKisEmpty()
        //$("#FunctionGrid").data("kendoGrid").setDataSource(rows_for_rnk);
        //$("#FunctionGrid").data("kendoGrid").dataSource.read();
        // initFunctionGrid(rows_for_rnk);
        //AssignRNK(rows)
    }
}
//"Повторна обробка"
function RepeatProcessing(rows) {
    $.ajax({
        method: "POST",//or type
        contentType: "application/json",
        async: true,
        dataType: "json",
        url: bars.config.urlContent("/api/pfu/EppPortfolio/RepeatProcessing"),
        data: JSON.stringify(rows),
        complete: function () {
            $("#gridPortfolio").data("kendoGrid").dataSource.read();
        }
    });
}

//отображаетт по каждому статусу количество записей
function GetStatusRows() {
    debugger;
    var value = 0;
    var cod_epp = $('#KEPPselect').val();
    var inden_cod = $('#KINNselect').val();
    var account = $('#KACCselect').val();
    var kf = $('#KFselect').data("kendoDropDownList").value();
    var date = kendo.toString($("#datepicker").data("kendoDatePicker").value(), "dd.MM.yyyy");
    var date1 = kendo.toString($("#datepicker1").data("kendoDatePicker").value(), "dd.MM.yyyy");

    $.ajax({
        method: "GET",
        contentType: "application/json",
        async: true,
        dataType: "json",
        url: bars.config.urlContent("/api/pfu/EppPortfolio/GetStatusRows") + "?&kf=" + kf + "&date=" + date + "&date1=" + date1 + "&cod_epp=" + cod_epp + "&inden_cod=" + inden_cod + "&account=" + account,
        complete: function (data) {
            debugger;
            value = data.responseJSON
            $("#new").html(value.news)
            $("#passval").html(value.passval)
            $('#sendru').html(value.sendru)
            $("#accopen").html(value.accopen)
            $("#cardsact").html(value.cardsact)
            $("#passact").html(value.passact)
            $("#kv2send").html(value.kv2send)
            $("#failedval").html(value.failedval)
            $("#erropenaclient").html(value.erropenaclient)
            $("#erropenacc").html(value.erropenacc)
            $("#errpercard").html(value.errpercard)
            $("#blockepp").html(value.blockepp)
            $("#kminwork").html(value.kminwork)
            $("#prockm").html(value.prockm)
            $("#errkm").html(value.errkm)
            $("#perprocc").html(value.perprocc)
            $("#inprocc").html(value.inprocc)
            $("#erropen").html(value.erropen)
        }
    });
}

//отправляет запрос на присваивания нового РНК
function AssignRNK() {

    var win = $("#modalWinFunc").data("kendoWindow");
    debugger;
    if (!RNKisEmpty()) {
        AlertNotifyError()
    }
    else {
        var rows = $("#FunctionGrid").data("kendoGrid")._data;
        $.ajax({
            method: "POST",//or type
            contentType: "application/json",
            async: true,
            dataType: "json",
            url: bars.config.urlContent("/api/pfu/EppPortfolio/AssignRNK"),
            data: JSON.stringify(rows),
            complete: function () {
                $("#gridPortfolio").data("kendoGrid").dataSource.read();
                win.close();
            }
        });
    }
}

//инициализирует главный грид
function initPortfolioGrid() {
    $("#gridPortfolio").kendoGrid({
        autoBind: false,
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 12,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/EppPortfolio/GetEppLine"),
                    data: function () {
                        var epp = NullOrValue($("#KEPPselect").val());
                        var inn = NullOrValue($("#KINNselect").val());
                        var acc = NullOrValue($("#KACCselect").val());
                        var kf = $('#KFselect').data("kendoDropDownList").value();
                        var date = kendo.toString($("#datepicker").data("kendoDatePicker").value(), "dd.MM.yyyy");
                        var date1 = kendo.toString($("#datepicker1").data("kendoDatePicker").value(), "dd.MM.yyyy");

                        glob_date = date;
                        glob_kf = kf;
                        //totalrows = 0
                        if (s_status === "") {
                            totalrows = 0
                        }
                        return { kf: kf, date1: date1, date: date, status: s_status, epp: epp, inn: inn, acc: acc };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { editable: false, type: "number" },
                        BATCH_REQUEST_ID: { editable: false, type: "number" },
                        BATCH_DATE: { type: "date", editable: false },
                        LINE_ID: { editable: false, type: "number" },
                        EPP_NUMBER: { editable: false, type: "string" },
                        EPP_EXPIRY_DATE: { editable: false, type: "string" },
                        PERSON_RECORD_NUMBER: { editable: false, type: "string" },
                        LAST_NAME: { editable: false, type: "string" },
                        FIRST_NAME: { editable: false, type: "string" },
                        MIDDLE_NAME: { type: "string", editable: false },
                        GENDER: { editable: false, type: "string" },
                        DATE_OF_BIRTH: { editable: false, type: "string" },
                        PHONE_NUMBERS: { editable: false, type: "string" },
                        EMBOSSING_NAME: { editable: false, type: "string" },
                        TAX_REGISTRATION_NUMBER: { editable: false, type: "string" },
                        DOCUMENT_TYPE: { editable: false, type: "string" },
                        DOCUMENT_ID: { type: "string", editable: false },
                        DOCUMENT_ISSUE_DATE: { editable: false, type: "string" },
                        DOCUMENT_ISSUER: { editable: false, type: "string" },
                        DISPLACED_PERSON_FLAG: { editable: false, type: "string" },
                        LEGAL_COUNTRY: { editable: false, type: "string" },
                        LEGAL_ZIP_CODE: { editable: false, type: "string" },
                        LEGAL_REGION: { editable: false, type: "string" },
                        LEGAL_DISTRICT: { type: "string", editable: false },
                        LEGAL_SETTLEMENT: { editable: false, type: "string" },
                        LEGAL_STREET: { editable: false, type: "string" },
                        LEGAL_HOUSE: { editable: false, type: "string" },
                        LEGAL_HOUSE_PART: { editable: false, type: "string" },
                        LEGAL_APARTMENT: { editable: false, type: "string" },
                        ACTUAL_COUNTRY: { editable: false, type: "string" },
                        ACTUAL_ZIP_CODE: { type: "string", editable: false },
                        ACTUAL_REGION: { editable: false, type: "string" },
                        ACTUAL_DISTRICT: { editable: false, type: "string" },
                        ACTUAL_SETTLEMENT: { editable: false, type: "string" },
                        ACTUAL_STREET: { editable: false, type: "string" },
                        ACTUAL_HOUSE: { editable: false, type: "string" },
                        ACTUAL_HOUSE_PART: { editable: false, type: "string" },
                        ACTUAL_APARTMENT: { type: "string", editable: false },
                        BANK_MFO: { editable: false, type: "string" },
                        BANK_NUM: { editable: false, type: "string" },
                        BANK_NAME: { editable: false, type: "string" },
                        STATE_ID: { editable: false, type: "number" },
                        LINE_SIGN: { editable: false, type: "string" },
                        ACTIVATION_DATE: { editable: false, type: "date" },
                        DESTRUCTION_DATE: { editable: false, type: "date" },
                        BLOCK_DATE: { type: "date", editable: false },
                        UNBLOCK_DATE: { editable: false, type: "date" },
                        ACCOUNT_NUMBER: { editable: false, type: "string" },
                        SIGN_PASS_CHANGE_FLAG: { editable: false, type: "date" },
                        BRANCH: { editable: false, type: "string" },
                        PENS_TYPE: { editable: false, type: "string" },
                        TYPE_CARD: { editable: false, type: "string" },
                        TERM_CARD: { type: "number", editable: false },
                        RNK: { editable: true, type: "number" },
                        STATE_NAME: { editable: false, type: "string" }
                    }
                }
            }
        },
        selectable: "multiple, row",//multiple, row
        pageable: true,
        scrollable: true,
        filterable: true,
        dataBound: function () {
            debugger;
            grid = this

            GetStatusRows();
            debugger;
            var total = grid.dataSource.total();
            if (totalrows === 0)
                totalrows = total
            $('#total').html(totalrows)
        },
        change: function () {

            var cheked_state = true
            var cheked_rnk = true
            var grid = this;
            var selectedItem = grid.dataItem(grid.select());
            var a = grid.select()

            for (var i = 0; i < a.length; i++) {
                cheked_state = CheckRowState(grid.dataItem(a[i]))

                if (cheked_state) {
                    $("#RepOrSet").html('Повторна обробка');
                    $('#RepOrSet').prop("disabled", false);
                }
                else {
                    $('#RepOrSet').prop("disabled", true);
                    break;
                }
            }

            for (var i = 0; i < a.length; i++) {
                cheked_rnk = CheckRowRNK(grid.dataItem(a[i]))

                if (cheked_rnk) {
                    $("#RepOrSet").html('Присвоїти РНК');
                    $('#RepOrSet').prop("disabled", false);
                }
                else if (!cheked_state && !cheked_rnk) {
                    $('#RepOrSet').prop("disabled", true);
                    break;
                }
            }
        },
        allowCopy: true,
        columns: [
            {
                field: "ID",
                title: "ID запису",
                width: '100px'
            },
            {
                field: "BATCH_REQUEST_ID",
                title: "ID конверту",
                width: '100px',
                filterable: {
                    ui: function (element) {
                        element.kendoNumericTextBox({
                            format: "n0"
                        });
                    }
                }
            },
            {
                field: "BATCH_DATE",
                title: "Дата<br/>отримання <br/>конверту",
                width: '100px'
                , template: "<div style='text-align:center;'>#=(BATCH_DATE == null) ? ' ' : kendo.toString(BATCH_DATE,'dd.MM.yyyy')#</div>"
            },
            {
                field: "LINE_ID",
                title: "Порядковий<br/>запис в<br/>конверті",
                width: '120px'
            },
            {
                field: "EPP_NUMBER",
                title: "Код ЕПП",
                width: '150px',
                template: "<a style='color:blue' onclick='ShowGrids(\"${EPP_NUMBER}\", \"Код ЕПП\", \"${ID}\")'  >#: ShowValue(EPP_NUMBER)#</a>"//"<p click='return ShowGrids(${EPP_NUMBER});' style='color:blue'>#: ShowValue(EPP_NUMBER)#</p>"
            },
            {
                field: "EPP_EXPIRY_DATE",
                title: "Строк дії ЕПП",
                hidden: true,
                width: '100px'
            },
            {
                field: "RNK",
                title: "РНК",
                width: '100px',
                template: "<a style='color:blue' onclick='ShowGrids(\"${RNK}\", \"РНК\", \"${ID}\")'  >#: ShowValue(RNK)#</a>"//"<p style='color:blue'>#: ShowValue(RNK)#</p>"
            },
            {
                field: "LAST_NAME",
                title: "Прізвище",
                width: '150px'
            },
            {
                field: "FIRST_NAME",
                title: "Ім’я",
                width: '120px'
            },
            {
                field: "MIDDLE_NAME",
                title: "По-батькові",
                width: '150px'
            },
            {
                field: "TAX_REGISTRATION_NUMBER",
                title: "Ідентифікаційний<br/>код клієнта",
                template: "<a> #: ShowValue(TAX_REGISTRATION_NUMBER)#</a>",
                width: '130px'
            },
            {
                field: "BANK_MFO",
                title: "Код банку<br/>(МФО)",
                width: '120px'
            },
            {
                field: "BRANCH",
                title: "Код філії відділення<br/>банку, де особа<br/>отримуватиме картку",
                width: '180px'
            },
            {
                field: "ACCOUNT_NUMBER",
                title: "Відкритий <br/>розрахунковий <br/>рахунок особи",
                width: '150px',
                template: "<a style='color:blue' onclick='ShowGrids(\"${ACCOUNT_NUMBER}\", \"Відкритий розрахунковий рахунок особи\", \"${ID}\")'  >#: ShowValue(ACCOUNT_NUMBER)#</a>"//"<p style='color:blue'>#: ShowValue(ACCOUNT_NUMBER)#</p>"
            },
            {
                field: "STATE_NAME",
                title: "Статус",
                width: '160px'
            },
            {
                field: "SYS_TIME",
                title: "Дата<br/>народження",
                hidden: true,
                width: '100px'
            },
            {
                field: "ID",
                title: "Контактний<br/>номер<br/>телефону",
                hidden: true,
                width: '100px'
            },
            {
                field: "KF",
                title: "ІПН",
                hidden: true,
                width: '100px'
            },
            {
                field: "NAME",
                title: "Тип документу",
                hidden: true,
                width: '100px'
            },
            {
                field: "SYS_TIME",
                title: "Серія та <br/>номер<br/> документу",
                hidden: true,
                width: '100px'
            },
            {
                field: "ID",
                title: "Дата видачі<br/> документу",
                hidden: true,
                width: '100px'
            },
            {
                field: "KF",
                title: "Ким видано<br/> документ",
                hidden: true,
                width: '100px'
            },
            {
                field: "NAME",
                title: "Код банку<br/> (МФО)",
                hidden: true,
                width: '100px'
            },
            {
                field: "BRANCH",
                title: "Код філії/ відділення<br/> банку, де особа<br/> отримуватиме картку",
                hidden: true,
                width: '100px'
            },

            {
                field: "STATE_ID",
                title: "ID статусу",
                width: '100px'
            },
            {
                field: "NAME",
                title: "Дата активації ЕПП",
                hidden: true,
                width: '100px'
            },
            {
                field: "SYS_TIME",
                title: "Дата знищення ЕПП",
                hidden: true,
                width: '100px'
            },
            {
                field: "ID",
                title: "BLOCK_DATE",
                hidden: true,
                width: '100px'
            },
            {
                field: "KF",
                title: "UNBLOCK_DATE",
                hidden: true,
                width: '100px'
            },
            {
                field: "NAME",
                title: "Ознака пенсійних виплат",
                hidden: true,
                width: '100px'
            },
            {
                field: "SYS_TIME",
                title: "Тип картки",
                hidden: true,
                width: '100px'
            },
            {
                field: "ACCOUNT_NUMBER",
                title: "Відкритий розрахунковий рахунок особи",
                hidden: true,
                width: '100px'
            }
        ]
    });
}

function initRNKGrid() {
    $("#gridRNK").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/EppPortfolio/GetTableByRNK"),
                    data: function () {
                        return { id: id_rnk_num, id_row: id_row };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        RNK: { type: "number" },
                        LAST_NAME: { type: "string" },
                        FIRST_NAME: { type: "string" },
                        MIDDLE_NAME: { type: "string" },
                        GENDER: { type: "string" },
                        DATE_OF_BIRTH: { type: "string" },
                        PHONE_NUMBERS: { type: "string" },
                        DOCUMENT_TYPE: { type: "string" },
                        DOCUMENT_ID: { type: "string" },
                        DOCUMENT_ISSUE_DATE: { type: "string" },
                        DOCUMENT_ISSUER: { type: "string" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function () {
        },
        change: function () {
            $("#gridCmEpp").data("kendoGrid").dataSource.read();
        },

        columns: [
            {
                field: "RNK",
                title: "РНК"
            },
             {
                 field: "LAST_NAME",
                 title: "Прізвище"
             },
            {
                field: "FIRST_NAME",
                title: "Ім’я"
            },
            {
                field: "MIDDLE_NAME",
                title: "По-батькові"
            },
            {
                field: "GENDER",
                title: "Стать"
            },
            {
                field: "DATE_OF_BIRTH",
                title: "Дата народження"
            },
            {
                field: "PHONE_NUMBERS",
                title: "Контактний номер телефону"
            },
            {
                field: "DOCUMENT_TYPE",
                title: "Тип документу"
            },
            {
                field: "DOCUMENT_ID",
                title: "Серія та номер документу"
            },
            {
                field: "DOCUMENT_ISSUE_DATE",
                title: "Дата видачі документу"
            },
            {
                field: "DOCUMENT_ISSUER",
                title: "Ким видано документ"
            }
        ]
    });
}
//отображает ошибку если не все поля заполненны
AlertNotifyError = function () {
    var popupNotification = $("#popupNotification").kendoNotification({
        height: 45,
        position: {
            top: 10,
            right: 20,
        }
    }).data("kendoNotification");
    popupNotification.show((kendo.toString("Заповніть усі поля")), "error");
}

//инициализирует грид для просмотра инф. ????
function initFunctionGrid(data) {
    $("#FunctionGrid").kendoGrid({
        autoBind: true,
        type: "webapi",
        serverPaging: true,
        serverFiltering: true,
        serverSorting: true,
        pageSize: 12,
        dataSource:
            {
                data: data,
                autoSync: false,
                schema: {
                    model: {
                        fields: {
                            EPP_NUMBER: { editable: false, type: "string", nullable: true },
                            TAX_REGISTRATION_NUMBER: { type: "number", editable: false },
                            LAST_NAME: { editable: false, type: "string", nullable: true },
                            FIRST_NAME: { editable: false, type: "string", nullable: true },
                            MIDDLE_NAME: { editable: false, type: "string", nullable: true },
                            RNK: { editable: false, type: "number" }
                        }
                    }
                }
            },
        //autobind: false,
        dataBound: function () {

        },
        edit: function () {
        },
        change: function () {
        },
        editable: { createAt: "bottom" },
        columns: [
            {
                field: "EPP_NUMBER",
                title: "Код ЕПП"
            },
            {
                field: "TAX_REGISTRATION_NUMBER",
                title: "Ідентифікаційний код клієнта"
            },
            {
                field: "LAST_NAME",
                title: "Прізвище"
            },
            {
                field: "FIRST_NAME",
                title: "Ім’я"
            },
            {
                field: "MIDDLE_NAME",
                title: "По-батькові"
            },
            {
                field: "RNK",
                title: "РНК"
            }
        ]
    });
}

//инициализирует грид для просмотра инф. по коду ЕПП
function initEppNumGrid() {
    $("#gridEppNum").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/EppPortfolio/GetTableByEppNum"),
                    data: function () {
                        return { id: id_epp_num };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        EPP_NUMBER: { type: "string" },
                        EPP_EXPIRY_DATE: { type: "string" },
                        ACTIVATION_DATE: { type: "number" },
                        DESTRUCTION_DATE: { type: "date" },
                        BLOCK_DATE: { type: "string" },
                        UNBLOCK_DATE: { type: "string" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function () {
        },
        change: function () {
            //$("#gridCmEpp").data("kendoGrid").dataSource.read();
        },

        columns: [
           {
               field: "EPP_NUMBER",
               title: "Код ЕПП"
           },
            {
                field: "EPP_EXPIRY_DATE",
                title: "Строк дії ЕПП"
            },
            {
                field: "ACTIVATION_DATE",
                title: "Дата активації ЕПП",
                template: "#: PrintDate(ACTIVATION_DATE) #",
            },
            {
                field: "DESTRUCTION_DATE",
                title: "Дата знищення ЕПП",
                template: "#: PrintDate(DESTRUCTION_DATE) #",
            },
            {
                field: "BLOCK_DATE",
                title: "Дата блокування",
                template: "#: PrintDate(BLOCK_DATE) #",
            },
            {
                field: "UNBLOCK_DATE",
                title: "Дата розблокування",
                template: "#: PrintDate(UNBLOCK_DATE) #",
            }
        ]
    });
}

//инициализирует грид для просмотра инф. по счету
function initAccNumGrid() {
    $("#gridAccNum").kendoGrid({
        dataSource: {
            type: "webapi",
            serverPaging: true,
            serverFiltering: true,
            serverSorting: true,
            pageSize: 6,
            transport: {
                read: {
                    url: bars.config.urlContent("/api/pfu/EppPortfolio/GetTableByAccNum"),
                    data: function () {
                        return { id: id_acc_num };
                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ACCOUNT_NUMBER: { type: "string" },
                        PENS_TYPE: { type: "string" },
                        TYPE_CARD: { type: "number" },
                        TERM_CARD: { type: "date" }
                    }
                }
            }
        },
        selectable: true,
        pageable: true,
        filterable: true,
        dataBound: function () {
        },
        change: function () {
            //$("#gridCmEpp").data("kendoGrid").dataSource.read();
        },

        columns: [
           {
               field: "ACCOUNT_NUMBER",
               title: "Відкритий розрахунковий рахунок особи"
           },
            {
                field: "PENS_TYPE",
                title: "Ознака пенсійних виплат"
            },
            {
                field: "TYPE_CARD",
                title: "Тип картки"
            },
            {
                field: "TERM_CARD",
                title: "Строк дії картки"
            }
        ]
    });
}