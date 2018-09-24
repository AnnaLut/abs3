var globalID;
var staticData = [];
var Summ = [];
var dialogOpenRef;
var _href = "";
$(document).ready(function () {
        
    globalID = bars.extension.getParamFromUrl('id', location.href);

    var toolbar = [];
    toolbar.push({ name: "brEPS", type: "button", text: "<span class='pf-icon pf-16 pf-percentage'></span> Розрах ЕПС" });
    toolbar.push({ name: "btProvide", type: "button", text: "<span class='pf-icon pf-16 pf-key'></span> Забезпечення", className: "k-custom-edit" });
    toolbar.push({ name: "btSG", type: "button", text: "<span class='pf-icon pf-16 pf-money'></span> Авто розбір надх. на рах SG" });
    toolbar.push({ name: "btBalance", type: "button", text: "<span class='pf-icon pf-16 pf-tree'></span> Інд. ручний розбір кред. залиш." });
    toolbar.push({ name: "btGLK", type: "button", text: "<span class='pf-icon pf-16 pf-business_report'></span> ГЛК" });
    toolbar.push({ name: "btToCreditCard", type: "button", text: "<span class='pf-icon pf-16 pf-report_open-import'></span>Картка договору" });
    toolbar.push({ name: "btLink", type: "button", text: "<span class='pf-icon pf-16 pf-link-info'></span>Уст. зв'язок довільного рах з КД" });
    toolbar.push({ name: "btClose", type: "button", text: "<span class='pf-icon pf-16 pf-delete_button_error'></span> Закрити КД" });
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btf8", type: "button", id: "btf8", text: "<strong> F8 </strong>" });
    toolbar.push({ name: "btf9", type: "button", id: "btf9",  text: "<strong> F9 </strong> " });
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btDel", type: "button", text: "<span class='pf-icon pf-16 pf-table_row-delete2'></span> Вивести без закриття" });
    toolbar.push({ name: "btToExcel", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span> Експорт в MS Excel" });
    toolbar.push({ name: "btFinDebit", type: "button", text: "<span class='pf-icon pf-16 pf-add_button'></span> Створення пари ФінДебіторки", attr: { style: "visibility: hidden;" } });


    var grid = $("#gridAccounts").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        selectable: true,
        sortable: true,
        editable: {
            mode: "popup",
            template: kendo.template($("#popup-editor").html()),
            update: true
        },
        edit: function (e) {
            kv_ds.read();
            kv_ds.filter({});
            $("#KV").kendoDropDownList({ dataSource: kv_ds, dataTextField: "NAME", dataValueField: "KV", filter: "startswith" });
            var editWindow = this.editable.element.data("kendoWindow");
            $('.k-window-title').text("");
            editWindow.wrapper.css({ width: 400 });
            var update = $(e.container).parent().find(".k-grid-update");
            $(update).html('<span class="k-icon k-update"></span>Відкрити');
            if (e.model.ACC != null) {
                $("#NLS").attr("readonly", true);
                $("#KV").data("kendoDropDownList").readonly();
                $("#popup_header").text("Редагувати рахунок:");
            }
            else
                $("#popup_header").text("Відкрити рахунок:");
        },
        save: function (e) {
            var newAccount = {
                ND: globalID,
                NLS: e.model.NLS,
                TIP: e.model.TIP,
                KV: $("#KV").data("kendoDropDownList").value(),
                OB22: $("#ob22").val(),
                ACC: e.model.ACC != null? e.model.ACC : null
            };
            var output = "Рахунок <strong>" + newAccount.NLS + "</strong> успішно " + (e.model.ACC != null ? "змінено" : "створено");
            TemplateQuery('/CreditUI/Accounts/UpdateAccount', { accountString: JSON.stringify(newAccount) }, output)
        },
        cancel: function () {
            $('#gridAccounts').data('kendoGrid').dataSource.read();
        },
        scrollable: true,
        selectable: "multiple,row",
        pageable: {
            refresh: true,
            pageSize: 100,
            pageSizes: [100,200,500,1000]
        },
        columns: [
            { 
                template: '<input class="checkboxExist" type="checkbox"/>',
                width: 29
            },
        {
            title: "Тип\nРах",
            width: 59,
            nullable: true,
            field: "TIP"
        },
         {
             title: "Назва рах.",
             width: 272,
             nullable: true,
             field: "NMS"
         },
         {
             title: "Рахунок\nКартка",
             width: 119,
             nullable: true,
             field: "NLS",
             template: "<a href='/barsroot/viewaccounts/accountform.aspx?type=2&acc=${ACC}&rnk=${RNK}&accessmode=1' onclick='window.open(this.href); return false;'>${NLS}</a>"
         },
         {
             title: "Базова опер.",
             width: 100,
             nullable: true,
             field: "TT_NAME",
             template: "<a onclick='ChooseType(${TT_HREF}); return false;'>${TT_NAME}</a>"
         },
         {
             title: "OB\n22",
             width: 59,
             nullable: true,
             field: "OB22"
         },
          {
              title: "Вал",
              width: 61,
              nullable: true,
              field: "KV"
          },
          {
              title: "Ok",
              field: "OPN",
              width: 33,
              template: '<input type="checkbox" #= OPN ? "checked=checked" : "" # disabled="disabled" ></input>',
              filterable: false
          },
          {
              title: "% ст",
              width: 52,
              nullable: true,
              field: "IR"
          },
          {
              title: "Дата ост.\nрух. рах.",
              width: 94,
              field: "DAPP",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
           {
               title: "Обороти\nДебет",
               width: 136,
               nullable: true,
               field: "DOS",
               template: "#=moneyFormat(DOS)#",
               footerTemplate: " <span id='SumDOS'> </span> "
           },
           {
               title: "Обороти\nКредит",
               width: 136,
               nullable: true,
               field: "KOS",
               template: "#=moneyFormat(KOS)#",
               footerTemplate: " <span id='SumKOS'> </span> "
           },
            {
                title: "План\nзал рах",
                width: 136,
                nullable: true,
                field: "OSTB",
                template: "#=moneyFormat(OSTB)#",
                footerTemplate: " <span id='SumOSTB'> </span> "
            },
           {
               title: "Фактич\nзал рах",
               width: 136,
               field: "OSTC",
               nullable: true,
               template: '#if (OSTC != null) {# #=CheckColor(OSTC)# #}#',
               footerTemplate: " <span id='SumOSTC'> </span> "
           },
            {
                title: "Майб\nзал рах",
                width: 136,
                nullable: true,
                field: "OSTF",
                template: "#=moneyFormat(OSTF)#",
                footerTemplate: " <span id='SumOSTF'> </span> "
            },
          {
              title: "План.дата\nпогаш",
              width: 100,
              field: "MDATE",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
          {
              title: "Факт-дата\nвідкриття",
              width: 100,
              field: "DAOS",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },
          {
              title: "Факт-дата\nзакриття",
              width: 100,
              field: "DAZS",
              nullable: true,
              format: "{0:dd.MM.yyyy}"
          },

          {
              title: "РНК",
              width: 94,
              nullable: true,
              field: "RNK"
          },
           {
               title: "% база",
               width: 66,
               nullable: true,
               field: "BASEY"
           },
          {
              title: "Відп\nВик",
              width: 64,
              nullable: true,
              field: "ISP"
          },
           {
               title: "ACC рах",
               width: 86,
               nullable: true,
               field: "ACC"
           }
        ],
        dataBound: function (e) {
            var data = $("#gridAccounts").data("kendoGrid").dataSource.data();
            $.each(data, function (i, row) {
                var color = (row.ACC == null) ? "greenRow" : (row.DAZS != null) ? "grayRow" : (row.RNK != staticData.RNK) ? "aquaRow" : null;
                (color != null) ? $('tr[data-uid="' + row.uid + '"] ').addClass(color) : null;
            });

            
            $(".checkboxExist").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                DisabledButtons();
                SetSummVal();
            });

            disabledButtons(false, ".k-grid-btDel");
            disabledButtons(false, ".k-grid-btFinDebit");
            disabledButtons(staticData.Avalible_provide, ".k-grid-btProvide");
            disabledButtons(staticData.Avalible_provide, ".k-grid-btGLK");
        },
        change: function (e) {
            var grid = $("#gridAccounts").data("kendoGrid");
            var row = $(".k-state-selected[role=row]");
            var selectedItem = grid.dataItem(row);
            DisabledButtons();

            $('tr').find('[class=checkboxExist]').prop('checked', false);
            $('tr.k-state-selected').find('[class=checkboxExist]').prop('checked', true);
            SetSummVal();
        },
        excel: {
            fileName: "Рахунки кредитної угоди № " + globalID + ".xlsx",
            allPages: true
        },
        excelExport: function(e) {
            var sheet = e.workbook.sheets[0];
            sheet.rows.splice(-1,1);
            for (var i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                var color = (row.cells[20].value == null) ? "#90ee90" : (row.cells[16].value != null) ? "#C3C3C3" : (row.cells[17].value != staticData.RNK) ? "#99FFFF" : undefined;
                if (color) {
                    for (var colIndex = 0; colIndex < (sheet.columns.length) ; colIndex++) {
                        row.cells[colIndex].background = color;
                    }
                }
            
                if (row.type != "footer"){
                row.cells[9].format = row.cells[10].format = row.cells[11].format = row.cells[12].format = row.cells[13].format = "#,##0.00";
                row.cells[3].value = null;
            }
            }       
        }
    }).data("kendoGrid");

    $("#gridAccounts").kendoTooltip({
        filter: ".k-grid-toolbar .k-grid-btf8",
        position: "top",
        content: "F8) Встановити залишок на рах консолідації 8999*"
    });

    $("#gridAccounts").kendoTooltip({
        filter: ".k-grid-toolbar .k-grid-btf9",
        position: "top",
        content: "F9) Актуалізація ліміту КД на вимогу(9129)"
    });

    var dialog = $("#dialogLink").kendoWindow({
        title: "Уст. зв'язок довільного рах з КД",
        modal: true,
        draggable: false,
        visible: false,
        width: 270 
    }).data("kendoWindow");

    dialogOpenRef = $("#dialogOpenRef").kendoWindow({
        modal: true,
        draggable: false,
        visible: false,
        width: 270
    }).data("kendoWindow");

    var kv_ds = new kendo.data.DataSource({
        cache: false,
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: 'json',
                url: bars.config.urlContent('/CreditUI/Accounts/GetKV')
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors"
            }
        }
    });

    ///start
    bars.ui.loader('body', true);
    GetStaticData("/CreditUI/Accounts/GetStaticData/");
    bars.ui.loader('body', false);

    $(document).on("dblclick", "#gridAccounts", function (e) {
        var grid = $("#gridAccounts").data().kendoGrid;
        grid.editRow(grid.select());
    });

    /////////////////////////
    //buttons
    /////////////////////////



    $(".k-grid-btSG").click(function () {
        bars.ui.confirm({
            text: "Виконати  авто-розробку рахунку  погашення ?", func: function () {
                AutoSG();
            }
        });
    });

    $(".k-grid-btClose").click(function () {
        bars.ui.confirm({
            text: "Ви дійсно бажаєте закрити КД ?", func: function () {
                CloseKD();
            }
        });
    });

    $(".k-grid-btLink").click(function () {
        kv_ds.read();
        kv_ds.filter({});
        $("#link_kv").kendoDropDownList({ dataSource: kv_ds , dataTextField: "NAME", dataValueField: "KV", filter: "startswith", value: 980});
        dialog.open().center();
    });

    $("#bt_link_ok").click(function () {
        bars.ui.confirm({
            text: "Установити зв`язок указаного рах." + $('#link_nd').val() + " / " +  $('#link_kv').val() + " з КД " + globalID + " ?", func: function () {
                ConnectAcc($('#link_nd').val(), $('#link_kv').val());
            }
        });
    });

    $(".k-grid-btToExcel").click(function () {
        $("#gridAccounts").data("kendoGrid").saveAsExcel();
    });

    $(".k-grid-brEPS").click(function () {
        window.open(bars.config.urlContent('/ndi/referencebook/GetRefBookData/?nsiTableId=1011620&nsiFuncId=12&ACCESSCODE=1'), '_blank');
    });

    $(".k-grid-btGLK").click(function () {
        window.open(bars.config.urlContent('/CreditUI/glk/Index/?id=' + globalID), '_blank');
    });

    $(".k-grid-btToCreditCard").click(function () {
        window.open(bars.config.urlContent('/CreditUi/NewCredit/?custtype=' + staticData.CUSTYPE + '&nd=' + globalID + '&sos=' + staticData.SOS), '_blank');
    });

    $(".k-grid-btProvide").click(function () {
        window.open(bars.config.urlContent('/CreditUI/Provide/Index/?id=' + globalID), '_blank');
    });

    $(".k-grid-btBalance").click(function () {
        window.open(bars.config.urlContent('/CreditUI/analysisbalance/?nd=' + globalID), '_blank');
    });

    $(".k-grid-btf8").click(function () {
        bars.ui.confirm({
            text: "Ви дійсно бажаєте виконати  Старт.переформування ?", func: function () {
                Remain8999();
            }
        });
    });

    $(".k-grid-btf9").click(function () {
        if (staticData.NDR == null || staticData.NDR == globalID) { //subs 
            bars.ui.confirm({
                text: "Ви дійсно бажаєте виконати  переформування  9129 ?", func: function () {
                    Limit9129();
                }
            });
        }
    });

    $(".k-grid-btDel").click(function () {
        var grid = $("#gridAccounts").data().kendoGrid;
        var selectedDataItem = grid.dataItem(grid.select());
        bars.ui.confirm({
            text: "Ви дійсно бажаєте Вивести рах "+ selectedDataItem.NLS+" / "+ selectedDataItem.KV +'  з-під КД '+ globalID+" ?", func: function () {
                DelAccountWithoutClose(selectedDataItem.ACC, selectedDataItem.TIP);
            }
        });
    });

    $("#bt_open_kk1").click(function () {
        OpenRef(1);
    });

    $("#bt_open_kk2").click(function () {
        OpenRef(2);
    });

    $(".k-grid-btToSubs").click(function () {
        bars.ui.loader('body', true);
        $.ajax({
            async: true,
            type: 'POST',
            url: bars.config.urlContent('/CreditUI/Accounts/GetTabId/'),
            success: function (data) {
                if (CatchErrors(data)) {
                    window.open(bars.config.urlContent('/ndi/referencebook/GetRefBookData/?nsiTableId=' + data.TabId + '&nsiFuncId=7&jsonSqlParams=[{"Name":"ND","Type":"N","SEMANTIC":"\u0420\u0435\u0444 \u041a\u0414~\u0432 \u0410\u0411\u0421~","Value":' + globalID + '}]'), '_blank');
                }
            },
            complete: function () {
                bars.ui.loader('body', false);
            }
        });
    });

    $(".k-grid-btFinDebit").click(function () {
        var grid = $("#gridAccounts").data().kendoGrid;
        TemplateQuery("/CreditUI/Accounts/FinDebit/", { acc: (grid.dataItem(grid.select())).ACC }, "Пару успішно створено");
    });

})

$(window).keydown(function (e) {
    var button_id =(e.key == 'F8') ? ".k-grid-btf8" : (e.key == 'F9') ? ".k-grid-btf9" : null;
    if(button_id) { $(button_id).click(); return false; }
});

function createListAccounts() {
    var grid = $("#gridAccounts").data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent('/CreditUI/Accounts/GetAccountsList/'),
                data: { id: globalID }
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                id: 'ACC',
                fields: {
                    ORD: { type: "number" },
                    ND: { type: "number" },
                    RNK: { type: "number" },
                    OPN: { type: "number" },
                    ACC: { type: "number" },
                    TIP: { type: "string" },
                    OB22: { type: "string" },
                    NMS: { type: "string" },
                    KV: { type: "number" },
                    OSTC: { type: "number" },
                    OSTB: { type: "number" },
                    OSTF: { type: "number" },
                    DOS: { type: "number" },
                    KOS: { type: "number" },
                    DAPP: { type: "date" },
                    DAOS: { type: "date" },
                    DAZS: { type: "date" },
                    ISP: { type: "number" },
                    IR: { type: "string" },
                    BASEY: { type: "number" },
                    TT_NAME: { type: "string" },
                    TT_HREF: { type: "string" },
                    NLS: { type: "string" },
                }
            }
        },
        sort: [
           { field: "OPN", dir: "desc" },
           { field: "ORD", dir: "asc" }
        ],
        pageSize: 50
    });
    grid.setDataSource(dataSource);
}

function SetPul() {
    $.ajax({
        async: true,
        url: bars.config.urlContent("/CreditUI/Accounts/SetPul/"),
        data: { nd: globalID },
        success: function () {
            createListAccounts();
        }
    });
}

function CalcSum() {
    Summ.DOS = Summ.KOS = Summ.OSTC = Summ.OSTB = Summ.OSTF = 0;
    var grid = $("#gridAccounts").data("kendoGrid");
    grid.select().each(function () {
        var selectRow = grid.dataItem($(this));
        Summ.DOS += selectRow.DOS;
        Summ.KOS += selectRow.KOS;
        Summ.OSTC += selectRow.OSTC;
        Summ.OSTB += selectRow.OSTB;
        Summ.OSTF += selectRow.OSTF;
    });
}

function SetStatic(data) {
    staticData = data;
    $("#number_kd").val(data.CC_ID);
    $("#ref_kd").val(globalID);
    $("#type_kredit").val(data.VNAME); ;
    $("#date_start").val(data.SDATE);
    $("#date_end").val(data.WDATE);
    $("#rnk_name").val(data.NAMK);
    $("#full_limit").val(moneyFormat(data.S));
    $("#use_limit").val(moneyFormat(data.SDOG));
    var color = (data.DIFF < 0) ? "#FF8383" : "aqua";
    $("#remaim_limit").css({ "backgroundColor": color });
    $("#remaim_limit").val(moneyFormat(data.DIFF));

    var diff_limit = data.DIFF - Math.abs(data.OSTB_9129);
    $("#diff_9129").val(moneyFormat(diff_limit));
    $("#date_first_pay").val(data.Date_issuance);

    if (data.NDR != null) {
        $(".ref_gen").show();
        $("#ref_gen").val(data.NDR);
        var color, info_text, text;
        if (data.NDR == globalID) {
            color = "main_contract";
            info_text = "Генеральний договір";
            text = "Рахунки та операції ГУ " + globalID;
            $("#sub_button").css({ "visibility": "visible" });
            $(".k-grid-btFinDebit").css({ "visibility": "visible" });
        }
        else {
            color = "sub_contact";
            info_text = "Субдоговір";
            text = "Рахунки та операції СД по ГУ " + data.NDR;
            disabledButtons(false, ".k-grid-btf9");
        }
        $("#info").addClass(color);
        $("#info").val(info_text);
        $("#header_text").text(text);
        $("#info").css({ "visibility": "visible" });
    }

    //setstaticData();
    SetPul();
}

function SetSummVal() {
    CalcSum();
    ClearZero(Summ.DOS, "#SumDOS");
    ClearZero(Summ.KOS, "#SumKOS");
    ClearZero(Summ.OSTB, "#SumOSTB");
    ClearZero(Summ.OSTC, "#SumOSTC");
    ClearZero(Summ.OSTF, "#SumOSTF");
}

function ClearZero(value, id)
{
    (value != 0) ? $(id).html(moneyFormat(value)) : $(id).html("");
}

function AutoSG() {
    TemplateQuery("/CreditUI/Accounts/AutoSG/", { nd: globalID }, "Розбір успішно проведений")
}

function ConnectAcc(nls, kv) {
    TemplateQuery("/CreditUI/Accounts/ConnectionAccWithKD/", { nd: globalID, nls: nls, kv: kv }, "Договір успішно приєднаний")
}

function CloseKD() {
    TemplateQuery("/CreditUI/Accounts/CloseKD/", { nd: globalID }, "КД успішно закритий")
}
function Remain8999() {
    TemplateQuery("/CreditUI/Accounts/Remain8999/", { nd: globalID }, "Залишок успішно встановлений на рахунок 8999*")
}

function Limit9129() {
    TemplateQuery("/CreditUI/Accounts/Limit9129/", { nd: globalID }, "Актуалізація ліміту КД успішно здійснена")
}

function DelAccountWithoutClose(acc, tip) {
    TemplateQuery("/CreditUI/Accounts/DelWithoutClose/", { nd: globalID, acc: acc, tip: tip }, "Рахунок успішно виведено без закриття")
}

function showOB22(tabName, showFields, whereClause) {
    bars.ui.handBook(tabName, function (data) {
        $("#ob22").val(data[0].OB22);
    },
    {
        columns: [{ field: "R020", width: 50 }, { field: "OB22", width: 50 }, { field: "TXT", width: 400 }],
        multiSelect: false,
        clause: "where r020 = substr(" + $("#NLS").val() + ", 1, 4) and d_close is null",
        ResizedColumns: true
    });
}

function DisabledButtons() {
    var grid = $("#gridAccounts").data("kendoGrid");
    var selected_items = grid.select();
    disabledButtons(((selected_items.length == 1) && (grid.dataItem(selected_items).ACC != null) && (!(grid.dataItem(selected_items).NLS.match(/8999.*/)))), ".k-grid-btDel");
    disabledButtons(((selected_items.length == 1) && (grid.dataItem(selected_items).ACC != null) && (grid.dataItem(selected_items).TIP === "ODB")), ".k-grid-btFinDebit");
}

function TemplateQuery(url, data_input, text) {
    bars.ui.loader('body', true);
    $.ajax({
        async: true,
        type: 'POST',
        url: bars.config.urlContent(url),
        data: data_input,
        success: function (data) {
            if (CatchErrors(data)) {
                bars.ui.alert({
                    text: text
                });
                createListAccounts();
            }
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
}

function ChooseType(href) {
    _href = href;
    if (href.indexOf("Flag_se") !== -1) {       //if Flag_se --> "Видати"
        dialogOpenRef.open().center();
    }
    else
        window.open(href);
}
function OpenRef(kk_num) {
    dialogOpenRef.close();
    _href = _href.substr(0, 38) + kk_num + _href.substr(39);
    window.open(_href);
}

