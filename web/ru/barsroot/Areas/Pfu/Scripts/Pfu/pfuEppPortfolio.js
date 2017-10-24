$(document).ready(function () {
    //kendo.ui.progress($("#gridPortfolio"), true);
    $('#RepOrSet').prop("disabled", true);
    $("#RepOrSet").html('Повторна обробка');
    //$("#RepOrSet").html('Присвоїти РНК');
    $("#datepicker").kendoDatePicker({
        format: "dd/MM/yyyy"
    });
     
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

    $("#KFselect").change(function () {
        ClearCheckBoxes()

        $("#gridPortfolio").data("kendoGrid").dataSource.filter([])
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
         
    });
    $("#datepicker").change(function () {
        ClearCheckBoxes()

        $("#gridPortfolio").data("kendoGrid").dataSource.filter([])
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
         
    });

     
    data = []
    FillKFDropDown();
    initPortfolioGrid();
    initRNKGrid();
    initEppNumGrid();
    initAccNumGrid();
    var news = GetStatusRows(1)
    var passval = GetStatusRows(2)
    var sendru = GetStatusRows(20)
    var accopen = GetStatusRows(8)
    var cardsact = GetStatusRows(12)
    var passact = GetStatusRows(13)
    var kv2send = GetStatusRows(14)
    var failedval = GetStatusRows(3)
    var erropenaclient = GetStatusRows(27)
    var erropenacc = GetStatusRows(28)
    var errpercard = GetStatusRows(29)
    var blockepp = GetStatusRows(19)
    var kminwork = GetStatusRows(24)
    var prockm = GetStatusRows(25)
    var errkm = GetStatusRows(26)
    ChangeCheckBoxes();

})



var id_epp_num = null, id_rnk_num = null,  id_row= null, id_acc_num = null, totalrows =0, glob_kf = '', glob_date = '';
function FillKFDropDown() {
    fillDropDownList("#KFselect", {
        transport: { read: { url: bars.config.urlContent("/api/pfu/EppPortfolio/GetBranchСode") } },
        schema: { model: { fields: { KF: { type: "string" } } } }
    }, {
        dataTextField: "KF", dataValueField: "KF",
        optionLabel: "Оберіть код"
    });
}

function ShowValue(value) {
    if (value === null)
        return "";
    else
        return value;
}
function ClearCheckBoxes() {
    $('#total').html(totalrows);
    $('#fun_passval').prop('checked', false);
    $('#fun_new').prop('checked', false);
    $('#fun_passval').prop('checked', false);
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
}


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

function GetRowsByStatus(status) {
     
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
}

var s_status = ""

function ChangeCheckBoxes() {
     
    $("#fun_new").change(function () {
         
        if ($("#fun_new")[0].checked == true) {
            status = 1
            s_status = s_status.concat(" OR STATE_ID = 1 ");

        }
        else
            s_status = s_status.replace(" OR STATE_ID = 1 ", "");
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_passval").change(function () {
         
        if ($("#fun_passval")[0].checked == true) {
            status = 2
            s_status = s_status.concat(" OR STATE_ID = 2 ");
        }
        else
            s_status = s_status.replace(" OR STATE_ID = 2 ", "");
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_sendru").change(function () {
         
        if ($("#fun_sendru")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 20 ");
             
        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 20 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_accopen").change(function () {
         
        if ($("#fun_accopen")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 8 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 8 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_cardsact").change(function () {
         
        if ($("#fun_cardsact")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 12 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 12 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_passact").change(function () {
         
        if ($("#fun_passact")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 13 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 13 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_kv2send").change(function () {
         
        if ($("#fun_kv2send")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 14 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 14 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_failedval").change(function () {
        if ($("#fun_failedval")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 3 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 3 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_erropenaclient").change(function () {
         
        if ($("#fun_erropenaclient")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 27 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 27 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_erropenacc").change(function () {
         
        if ($("#fun_erropenacc")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 28 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 28 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_errpercard").change(function () {
         
        if ($("#fun_errpercard")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 29 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 29 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_blockepp").change(function () {
         
        if ($("#fun_blockepp")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 19 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 19", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_kminwork").change(function () {
         
        if ($("#fun_kminwork")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 24 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 24 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_prockm").change(function () {
         
        if ($("#fun_prockm")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 25 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 25 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_errkm").change(function () {
         
        if ($("#fun_errkm")[0].checked == true) {
            status = 20
            s_status = s_status.concat(" OR STATE_ID = 26 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 26 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_perprocc").change(function () {

        if ($("#fun_perprocc")[0].checked == true) {
            status = 30
            s_status = s_status.concat(" OR STATE_ID = 30 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 30 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
    $("#fun_inprocc").change(function () {

        if ($("#fun_inprocc")[0].checked == true) {
            status = 31
            s_status = s_status.concat(" OR STATE_ID = 31 ");

        }
        else {
            s_status = s_status.replace(" OR STATE_ID = 31 ", "");
        }
        $("#gridPortfolio").data("kendoGrid").dataSource.read();
    });
}

function RNKisEmpty() {
     
    var grid = $("#FunctionGrid").data("kendoGrid")._data
    for(var i = 0; i< grid.length; i++ ){
        if (grid[i].RNK) {
           // $('#SetRNK').prop("disabled", false);
        }
        else {
           // $('#SetRNK').prop("disabled", true);
            return false;
        }
    }
    return true;
}

function onCloseModalWinFunc() {
    $("#gridPortfolio").data("kendoGrid").dataSource.read();
}

function CheckRowRNK(item) {
     
    var checked = false
    if (item.RNK === null && item.STATE_ID === 27)
        checked = true;
    else
        checked = false

    return checked

}
function CheckRowState(item) {

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
        RNKisEmpty()
        //$("#FunctionGrid").data("kendoGrid").setDataSource(rows_for_rnk);
        //$("#FunctionGrid").data("kendoGrid").dataSource.read();
        // initFunctionGrid(rows_for_rnk);
        //AssignRNK(rows)
    }
}
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

function GetStatusRows(status) {
    var value = 0
    kf = $('#KFselect').data("kendoDropDownList").value();
    date = $("#datepicker").data("kendoDatePicker").value();
    date = kendo.toString(date, "dd.MM.yyyy")
    $.ajax({
        method: "GET",
        contentType: "application/json",
        async: true,
        dataType: "json",
        url: bars.config.urlContent("/api/pfu/EppPortfolio/GetStatusRows") + "?status=" + status + "&kf=" + kf + "&date=" + date,
        complete: function (data) {
            value = data.responseJSON
            if (status === 1)
                $("#new").html(value)
            if (status === 2)
                $("#passval").html(value)
            if (status === 20)
                $('#sendru').html(value)
            if (status === 3)
                $('#failedval').html(value)
            if (status === 8)
                $("#accopen").html(value)
            if (status === 12)
                $("#cardsact").html(value)
            if (status === 13)
                $("#passact").html(value)
            if (status === 14)
                $("#kv2send").html(value)
            if (status === 27)
                $("#erropenaclient").html(value)
            if (status === 28)
                $("#erropenacc").html(value)
            if (status === 29)
                $("#errpercard").html(value)
            if (status === 19)
                $("#blockepp").html(value)
            if (status === 24)
                $("#kminwork").html(value)
            if (status === 25)
                $("#prockm").html(value)
            if (status === 26)
                $("#errkm").html(value)
            if (status === 30)
                $("#perprocc").html(value)
            if (status === 31)
                $("#inprocc").html(value)
        }
    });
}

function AssignRNK() {
     
    var win = $("#modalWinFunc").data("kendoWindow");
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
                         
                        //$("#gridPortfolio").data("kendoGrid").dataSource.filter([]);
                        kf = $('#KFselect').data("kendoDropDownList").value();
                        date = $("#datepicker").data("kendoDatePicker").value();
                        date = kendo.toString(date, "dd.MM.yyyy")
                        glob_date = date
                        glob_kf = kf
                        //totalrows = 0
                        if (s_status === "") {
                            totalrows = 0
                        }
                        if (kf != '')
                            return { kf: kf, date: date, status: s_status }
                        else {
                            kf = ''
                            return { kf: kf, date: date, status: s_status }
                        }

                    }
                }
            },
            schema: {
                data: "Data",
                total: "Total",
                model: {
                    fields: {
                        ID: { editable: false, type: "number" },
                        BATCH_REQUEST_ID: { editable: false, type: "number"},
                        BATCH_DATE: { type: "date", editable: false  },
                        LINE_ID: { editable: false, type: "number"  },
                        EPP_NUMBER: { editable: false, type: "string"},
                        EPP_EXPIRY_DATE: { editable: false, type: "string"  },
                        PERSON_RECORD_NUMBER: { editable: false, type: "string" },
                        LAST_NAME: { editable: false, type: "string"  },
                        FIRST_NAME: { editable: false, type: "string"  },
                        MIDDLE_NAME: { type: "string", editable: false  },
                        GENDER: { editable: false, type: "string"  },
                        DATE_OF_BIRTH: { editable: false, type: "string"  },
                        PHONE_NUMBERS: { editable: false, type: "string"  },
                        EMBOSSING_NAME: { editable: false, type: "string"  },
                        TAX_REGISTRATION_NUMBER: { editable: false, type: "string"  },
                        DOCUMENT_TYPE: { editable: false, type: "string"  },
                        DOCUMENT_ID: { type: "string", editable: false  },
                        DOCUMENT_ISSUE_DATE: { editable: false, type: "string"  },
                        DOCUMENT_ISSUER: { editable: false, type: "string"  },
                        DISPLACED_PERSON_FLAG: { editable: false, type: "string"  },
                        LEGAL_COUNTRY: { editable: false, type: "string"  },
                        LEGAL_ZIP_CODE: { editable: false, type: "string"  },
                        LEGAL_REGION: { editable: false, type: "string"  },
                        LEGAL_DISTRICT: { type: "string", editable: false  },
                        LEGAL_SETTLEMENT: { editable: false, type: "string"  },
                        LEGAL_STREET: { editable: false, type: "string"  },
                        LEGAL_HOUSE: { editable: false, type: "string"  },
                        LEGAL_HOUSE_PART: { editable: false, type: "string"  },
                        LEGAL_APARTMENT: { editable: false, type: "string"  },
                        ACTUAL_COUNTRY: { editable: false, type: "string"  },
                        ACTUAL_ZIP_CODE: { type: "string", editable: false  },
                        ACTUAL_REGION: { editable: false, type: "string"  },
                        ACTUAL_DISTRICT: { editable: false, type: "string"  },
                        ACTUAL_SETTLEMENT: { editable: false, type: "string"  },
                        ACTUAL_STREET: { editable: false, type: "string"  },
                        ACTUAL_HOUSE: { editable: false, type: "string"  },
                        ACTUAL_HOUSE_PART: { editable: false, type: "string"  },
                        ACTUAL_APARTMENT: { type: "string", editable: false  },
                        BANK_MFO: { editable: false, type: "string"  },
                        BANK_NUM: { editable: false, type: "string"  },
                        BANK_NAME: { editable: false, type: "string"  },
                        STATE_ID: { editable: false, type: "number"  },
                        LINE_SIGN: { editable: false, type: "string"  },
                        ACTIVATION_DATE: { editable: false, type: "date"  },
                        DESTRUCTION_DATE: { editable: false, type: "date"  },
                        BLOCK_DATE: { type: "date", editable: false  },
                        UNBLOCK_DATE: { editable: false, type: "date"  },
                        ACCOUNT_NUMBER: { editable: false, type: "string"  },
                        SIGN_PASS_CHANGE_FLAG: { editable: false, type: "date"  },
                        BRANCH: { editable: false, type: "string"  },
                        PENS_TYPE: { editable: false, type: "string"  },
                        TYPE_CARD: { editable: false, type: "string"  },
                        TERM_CARD: { type: "number", editable: false  },
                        RNK: { editable: true, type: "number"  },
                        STATE_NAME: { editable: false, type: "string"  }
                    }
                }
            }
        },
        selectable: "multiple, row",
        pageable: true,
        scrollable: true,
        filterable: true,
        dataBound: function () {
            
            grid = this
             
            var news = GetStatusRows(1)
            var passval = GetStatusRows(2)
            var sendru = GetStatusRows(20)
            var accopen = GetStatusRows(8)
            var cardsact = GetStatusRows(12)
            var passact = GetStatusRows(13)
            var kv2send = GetStatusRows(14)
            var failedval = GetStatusRows(3)
            var erropenaclient = GetStatusRows(27)
            var erropenacc = GetStatusRows(28)
            var errpercard = GetStatusRows(29)
            var blockepp = GetStatusRows(19)
            var kminwork = GetStatusRows(24)
            var prockm = GetStatusRows(25)
            var errkm = GetStatusRows(26)
            var perprocc = GetStatusRows(30)
            var inprocc = GetStatusRows(31)
            var total = grid.dataSource.total();
            kf = $('#KFselect').data("kendoDropDownList").value();
            date = $("#datepicker").data("kendoDatePicker").value();
            date = kendo.toString(date, "dd.MM.yyyy")
            if (totalrows === 0)
                totalrows = total
            //if (glob_date != date)
            //    totalrows = total
            //if (glob_kf != kf)
            //    totalrows = total
            // 
            //if (total === 0)
            //    totalrows = 0
            $('#total').html(totalrows)
            $("#new").html(news)
            $("#passval").html(passval)
            $('#sendru').html(sendru)
            $("#accopen").html(accopen)
            $("#cardsact").html(cardsact)
            $("#passact").html(passact)
            $("#kv2send").html(kv2send)
            $("#failedval").html(failedval)
            $("#erropenaclient").html(erropenaclient)
            $("#erropenacc").html(erropenacc)
            $("#errpercard").html(errpercard)
            $("#blockepp").html(blockepp)
            $("#kminwork").html(kminwork)
            $("#prockm").html(prockm)
            $("#errkm").html(errkm)
            $("#perprocc").html(perprocc)
            $("#inprocc").html(inprocc)

            //$('#test1').html(12);
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

            //var grid = $("#gridPortfolio").data("kendoGrid");
            //var selected = this.select();
            //var item = grid.dataItem(selected);
            //var row = this.select().closest("tr");
            //var idx = selected.index();
            //var col = $("th", this.thead).eq(idx).data("field");
            // 
            //if (col !== "RNK" && col !== "EPP_NUMBER" && col !== "ACCOUNT_NUMBER")
            //    this.select().addClass("k-state-selected");
            //else if (col == "RNK") {
            //    var win = $("#modalWinRNK").data("kendoWindow");
            //    win.open().center().toFront();
            //    $("#gridRNK").data("kendoGrid").dataSource.read();
            //}
            //else if (col == "EPP_NUMBER") {
            //    var win = $("#modalWinEppNum").data("kendoWindow");
            //    win.open().center().toFront();
            //    $("#gridEppNum").data("kendoGrid").dataSource.read();
            //}
            //else if (col == "ACCOUNT_NUMBER") {
            //    var win = $("#modalWinAccNum").data("kendoWindow");
            //    win.open().center().toFront();
            //    $("#gridAccNum").data("kendoGrid").dataSource.read();
            //}
        },
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
                field: "SYS_TIME",
                title: "Дата<br/>отримання <br/>конверту",
                width: '100px'
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
                title: "Індетифікаційний<br/>код клієнта",
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
                        DATE_OF_BIRTH: { type: "date" },
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
                            EPP_NUMBER: { editable: false,type: "string",  nullable: true },
                            TAX_REGISTRATION_NUMBER: { type: "number", editable: false  },
                            LAST_NAME: { editable: false,type: "string",  nullable: true },
                            FIRST_NAME: { editable: false,type: "string",  nullable: true },
                            MIDDLE_NAME: { editable: false,type: "string",  nullable: true },
                            RNK: { editable: false, type: "number"  }
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
                title: "Індетифікаційний код клієнта"
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
            $("#gridCmEpp").data("kendoGrid").dataSource.read();
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
                title: "Дата активації ЕПП"
            },
            {
                field: "DESTRUCTION_DATE",
                title: "Дата знищення ЕПП"
            },
            {
                field: "BLOCK_DATE",
                title: "Дата блокування"
            },
            {
                field: "UNBLOCK_DATE",
                title: "Дата розблокування"
            }
        ]
    });
}

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
            $("#gridCmEpp").data("kendoGrid").dataSource.read();
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