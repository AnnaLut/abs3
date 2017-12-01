var globalID; //num
var readonly;
var staticData = [];
var dialogGlkArchive; //window
var dialogGlkArchive_Body; //window
var archive_id; //num
var archive_date = "";

$(document).ready(function () {

    globalID = bars.extension.getParamFromUrl('id', location.href);
    readonly = bars.extension.getParamFromUrl('readonly', location.href);

    var toolbar = [];
    toolbar.push({ name: "btAdd", type: "button", text: "<span class='pf-icon pf-16 pf-add'></span> Додати запис" });
    toolbar.push({ name: "btEdit", type: "button", text: "<span class='pf-icon pf-16 pf-gears'></span> Редагувати запис" });
    toolbar.push({ name: "btDel", type: "button", text: "<span class='pf-icon pf-16 pf-table_row-delete2'></span> Видалення записів" });
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btGLK", type: "button", text: "<span class='pf-icon pf-16 pf-document_header_footer-ok2'></span> Створити проект ГЛК" });
  //  toolbar.push({ name: "btGroup", type: "button", text: "<span class='pf-icon pf-16 pf-list-arrow_right'></span> Масовий розбір" });
  //  toolbar.push({ name: "btPercents", type: "button", text: "<span class='pf-icon pf-16 pf-percentage'></span> Балансування ГЛК та перерахунок %%" });
    toolbar.push({ name: "btGPK", type: "button", text: "<span class='pf-icon pf-16 pf-business_report'></span> ГПК для КД" });
    toolbar.push({ name: "btf9", type: "button", id: "btf9", text: "<strong> F9 </strong> " });
    toolbar.push({ name: "btArchive", type: "button", text: "<span class='pf-icon pf-16 pf-database-arrow_right'></span> Відновити ГЛК з архіву" });
    toolbar.push({ template: " | " });
    toolbar.push({ name: "btToExcel", type: "button", text: "<span class='pf-icon pf-16 pf-exel'></span> Експорт в MS Excel" });


    var grid = $("#gridGLK").kendoGrid({
        toolbar: toolbar,
        filterable: true,
        resizable: true,
        selectable: true,
        sortable: true,
        scrollable: true,
        selectable: "multiple,row",
        pageable: {
            refresh: true,
            pageSize: 100,
            pageSizes: [100, 200, 500, 1000]
        },
        columns: [
            {
                //headerTemplate: '<input class="checkbox" type="checkbox" id="AllExsist">',
                template: '<input class="checkboxExist" type="checkbox"/>',
                width: 29
            },
        {
            headerTemplate: "Дата ліміту<br /><strong>01</strong>",
            title: "Дата ліміту",
            width: 100,
            nullable: true,
            field: "FDAT",
            format: "{0:dd.MM.yyyy}"
        },
         {
             headerTemplate: "Плановий вхідний ліміт<br /><strong>02</strong>",
             title: "Вх.Ліміт план",
             width: 120,
             nullable: true,
             field: "LIM1",
             template: "#=moneyFormat(LIM1)#"
         },
         {
             headerTemplate: "Плановий вихідний ліміт<br /><strong>03</strong>",
             title: "Вих.Ліміт план",
             width: 120,
             nullable: true,
             field: "LIM2",
             template: "#=moneyFormat(LIM2)#"
         },
         {
             headerTemplate: "Фактичний залишок<br /><strong>04</strong>",
             title: "Залишок факт",
             width: 120,
             nullable: true,
             field: "OST",
             template: "#=moneyFormat(OST)#"
         },
         {
             headerTemplate: "Відхилення план-факт<br /><strong>05=03-04</strong>",
             title: "Відхилення план-факт",
             width: 120,
             nullable: true,
             field: "DEL2",
             template: "#=moneyFormat(DEL2)#"
         },
         {
             title: "Тільки тіло",
             width: 50,
             nullable: true,
             field: "DAYSN",
             template: '<input type="checkbox" #= (DAYSN == 1) ? "checked=checked" : "" # disabled="disabled" ></input>',
             filterable: false
         },
         {
             title: "Поточна Дельта для 9129",
             width: 100,
             nullable: true,
             field: "D9129"
         },
         {
             title: "<br />Не 9129",
             width: 100,
             nullable: true,
             field: "NOT_9129"
         }
        ],
        editable: {
            mode: "popup",
            template: kendo.template($("#popup-editor").html()),
            update: true
        },
        edit: function (e) {
            $("#LIM2").kendoNumericTextBox({ spinners: false, format: "#" });

            var editWindow = this.editable.element.data("kendoWindow");
            editWindow.wrapper.css({ width: 535 });
            var datepicker = $("#FDAT").kendoDatePicker({ format: "dd.MM.yyyy", culture: "en-GB", min: staticData.BANKDATE }).data("kendoDatePicker");
            if (e.model.isNew()) {
                $("#btn_adding").toggle(true);
                $('.k-window-title').text("Додавання нового запису");
                $(e.container).parent().find(".k-grid-update").html('<span class="k-icon k-update"></span>Додати і закрити');
                $(e.container).parent().find(".k-grid-cancel").html('<span class="k-icon k-cancel"></span>Закрити');
                $("#LIM2").val("");
                $("#D9129").val("");
                $("#NOT_9129").val("");
                $("#NOT_9129").prop('disabled', true);
                e.model = null;
            } else {
                $("#btn_adding").toggle(false); 
                $('.k-window-title').text("Редагування ГЛК");
                $(e.container).parent().find(".k-grid-update").html('<span class="k-icon k-update"></span>Редагувати');
                datepicker.value(e.model.FDAT)
                if (e.model.DAYSN == 1) { $("#DAYSN").prop('checked', true); }
            }
        },
        save: function (e) {
            var glk = {
                ND: globalID,
                FDAT: kendo.toString($("#FDAT").data("kendoDatePicker").value(), 'dd/MM/yyyy'),
                LIM2: e.model.LIM2,
                D9129: e.model.D9129 == null ? 0 : e.model.D9129,
                DAYSN: ($("#DAYSN").is(':checked')) ? 1 : 0,
                UPD_FLAG: ($("#UPD_FLAG").is(':checked')) ? 1 : 0,
                NOT_9129: e.model.NOT_9129
            };

            if (e.model.isNew()) {
                AddGlk(glk);
             
            }
            else {
                EditGlk(glk);
            }
        },
        cancel: function () {
            $('#gridGLK').data('kendoGrid').dataSource.read();
        },
        dataBound: function (e) {
            PaintRows("#gridGLK");

            $(".checkboxExist").bind("change", function (e) {
                $(e.target).closest("tr").toggleClass("k-state-selected");
                CheckButtons();
            });
            disabledButtons(false, ".k-grid-btDel");
            disabledButtons(false, ".k-grid-btEdit");
            if (readonly) {
                disabledButtons(false, ".k-grid-btAdd");
                disabledButtons(false, ".k-grid-btGLK");
                disabledButtons(false, ".k-grid-btGPK");
                disabledButtons(false, ".k-grid-btf9");
                disabledButtons(false, ".k-grid-btArchive");
                disabledButtons(false, ".k-grid-btToExcel");
            }
        },
        change: function (e) {
            $('tr').find('[class=checkboxExist]').prop('checked', false);
            $('tr.k-state-selected').find('[class=checkboxExist]').prop('checked', true);
            CheckButtons();
        },
        excel: {
            fileName: "Графік лімітів кредитування угоди № " + globalID + ".xlsx",
            allPages: true
        },
        excelExport: function (e) {
            var sheet = e.workbook.sheets[0];
            sheet.columns.autoWidth = true;
            for (var i = 1; i < sheet.rows.length; i++) {
                var row = sheet.rows[i];
                var color = (kendo.toString(row.cells[0].value, "dd.MM.yyyy") == staticData.BANKDATE) ? "#99FFFF" : 
                    (row.cells[0].value < kendo.parseDate(staticData.BANKDATE, "dd.MM.yyyy")) ? "#C3C3C3" : undefined;
                if (color) {
                    for (var colIndex = 0; colIndex < (sheet.columns.length) ; colIndex++) {
                        row.cells[colIndex].background = color;
                    }
                }
                row.cells[1].format = row.cells[2].format = row.cells[3].format = row.cells[4].format = "#,##0.00";
            }
        }
    }).data("kendoGrid");


    var grid1 = $("#gridGlkArchive").kendoGrid({
        filterable: true,
        selectable: true,
        sortable: true,
        scrollable: true,
        selectable: "row",
        pageable: {
            refresh: true,
            pageSize: 10,
        },
        columns: [
        {
            title: "ID",
            width: 50,
            field: "ID",
        },
         {
             title: "Референс",
             width: 100,
             field: "ND"
         },
         {
             title: "Дата зміни",
             width: 150,
             field: "OPER_DATE",
             format: "{0:dd.MM.yyyy HH:mm:ss}"
         },
         {
             title: "Автор зміни",
             width: 250,
             field: "FIO",
         }
        ]
    }).data("kendoGrid");


    var grid2 = $("#gridGlkArchive_Body").kendoGrid({
        filterable: true,
        resizable: true,
        sortable: true,
        scrollable: true,
        pageable: {
            refresh: true,
            pageSize: 20,
        },
        columns: [
        {
            headerTemplate: "Дата ліміту<br /><strong>01</strong>",
            title: "Дата ліміту",
            width: 100,
            nullable: true,
            field: "FDAT",
            format: "{0:dd.MM.yyyy}"
        },
         {
             headerTemplate: "Плановий вхідний ліміт<br /><strong>02</strong>",
             title: "Вх.Ліміт план",
             width: 130,
             nullable: true,
             field: "LIM2",
             template: "#=moneyFormat(LIM2)#"
         },
         {
             headerTemplate: "Плановий вихідний ліміт<br /><strong>03</strong>",
             title: "Вих.Ліміт план",
             width: 130,
             nullable: true,
             field: "SUMG",
             template: "#=moneyFormat(SUMG)#"
         },
         {
             headerTemplate: "Фактичний залишок<br /><strong>04</strong>",
             title: "Залишок факт",
             width: 130,
             nullable: true,
             field: "SUMO",
             template: "#=moneyFormat(SUMO)#"
         },
         {
             headerTemplate: "Відхилення план-факт<br /><strong>05=03-04</strong>",
             title: "Відхилення план-факт",
             width: 130,
             nullable: true,
             field: "SUMK",
             template: "#=moneyFormat(SUMK)#"
         },
         {
             title: "Тільки тіло",
             width: 50,
             nullable: true,
             field: "NOT_SN",
             template: '<input type="checkbox" #= (NOT_SN == 1) ? "checked=checked" : "" # disabled="disabled" ></input>',
             filterable: false
         },
         {
             title: "Поточна Дельта для 9129",
             width: 100,
             nullable: true,
             field: "OTM"
         },
         {
             title: "NOT_9129",
             width: 100,
             nullable: true,
             field: "NOT_9129"
         }
        ],
        dataBound: function (e) {
            PaintRows("#gridGlkArchive_Body");
        }
    }).data("kendoGrid");

    ///start
    GetStaticData("/CreditUI/glk/GetStaticData/");
   
    $(document).on("dblclick", "#gridGLK tr:not(.grayRow)", function (e) {
        var grid = $("#gridGLK").data().kendoGrid;
        grid.editRow(grid.select());
    });

    $(document).on("dblclick", "#gridGlkArchive", function (e) {
        selectArchiveBody();
    });
    

    /////////////////////////
    //buttons
    /////////////////////////
    $(".k-grid-btAdd").click(function () {
        $("#gridGLK").data().kendoGrid.addRow();
    });

    $(".k-grid-btEdit").click(function () {
        var grid = $("#gridGLK").data().kendoGrid;
        grid.editRow(grid.select());
    });

    $(".k-grid-btGPK").click(function () {
        var url = bars.config.urlContent('/ndi/referencebook/GetRefBookData/?nsiTableId=1011293&nsiFuncId=3');
        bars.ui.loader('body', true);
        $.ajax({
            async: true,
            url: bars.config.urlContent("/CreditUI/glk/BeforeGPK/"),
            data: { nd: globalID },
            success: function () {
                window.open(url, '_blank');
            },
            complete: function () {
                bars.ui.loader('body', false);
            }
        });
    });

    $(".k-grid-btGLK").click(function () {

        var grid = $("#gridGLK").data("kendoGrid");
        grid.select("tr:eq(1)");
        var selected = grid.select();
        var row = selected.first();
        bars.ui.confirm({
            text: "Виконати побудову проекту ГЛК згідно умов ?", func: function () {
                TemplateQuery("/CreditUI/glk/CreateGLKProject/", { nd: globalID, acc: grid.dataItem(row).ACC}, "ГЛК успішно побудовано!");
            }
        });
    });

    $(".k-grid-btPercents").click(function () {
        bars.ui.confirm({
            text: "Виконати балансування ГПК (тіло) в останню дату ?", func: function () {
                TemplateQuery("/CreditUI/glk/BalanceGLK/", { nd: globalID }, "Балансування успішно виконано!");
            }
        });
    });

    $(".k-grid-btDel").click(function () {
        bars.ui.confirm({
            text: "Видалити обрані записи?", func: function () {
                var grid = $("#gridGLK").data("kendoGrid");
                var selected_glk = [];
                grid.select().each(function () {
                    var glk = {
                        ND: globalID,
                        FDAT: grid.dataItem($(this)).FDAT,
                        LIM2: grid.dataItem($(this)).LIM2,
                        D9129: grid.dataItem($(this)).D9129,
                        DAYSN: grid.dataItem($(this)).DAYSN == null ? 0 : 1,
                        UPD_FLAG: 0,
                        NOT_9129: grid.dataItem($(this)).NOT_9129
                    };
                    selected_glk.push(glk);
                });
                DeleteGlk(selected_glk);
              }
        });
     });


    $(".k-grid-btToExcel").click(function () {
        $("#gridGLK").data("kendoGrid").saveAsExcel();
    });

    $(".k-grid-btArchive").click(function () {
        createArchive();
    });
    $("#klient_card").click(function () {
        window.open(bars.config.urlContent('/clientregister/registration.aspx?readonly=1&rnk=' + staticData.RNK), '_blank');
    });

    $("#kredit_card").click(function () {
        window.open(bars.config.urlContent('/CreditUi/NewCredit/?custtype=' + staticData.CUSTYPE + '&nd=' + globalID), '_blank');
    });

    $("#accounts_card").click(function () {
        window.open(bars.config.urlContent('/CreditUI/accounts/?id=' + globalID), '_blank');
    });

    $("#gridGLK").kendoTooltip({
        filter: ".k-grid-toolbar .k-grid-btf9",
        position: "top",
        content: "F9) Актуалізація ліміту КД на вимогу(9129)"
    });

    $(".k-grid-btf9").click(function () {
        bars.ui.confirm({
            text: "Ви дійсно бажаєте виконати  переформування  9129 ?", func: function () {
                TemplateQuery("/CreditUI/Accounts/Limit9129/", { nd: globalID }, "Актуалізація ліміту КД успішно здійснена");
            }
        });
    });

    dialogGlkArchive = $("#dialogGlkArchive").kendoWindow({
        title: "Архів ГЛК",
        modal: true,
        draggable: false,
        visible: false
    }).data("kendoWindow");

    dialogGlkArchive_Body = $("#dialogGlkArchive_Body").kendoWindow({
        modal: true,
        draggable: false,
        visible: false
    }).data("kendoWindow");

    $("#btn_arch_Ok").click(function () {
        var grid = $("#gridGlkArchive").data("kendoGrid");
        var selected_item = grid.dataItem(grid.select());
        if (selected_item != null) {
            selectArchiveBody();
        } else {
            bars.ui.alert({
                text: "Оберіть запис з архіву!"
            });
        }
        
    });

    $("#btn_arch_exit").click(function () {
        dialogGlkArchive.close();
    });

    $("#btn_arch_body_false").click(function () {
        dialogGlkArchive_Body.close();
    });

    $("#btn_arch_body_ok").click(function () {
        $.ajax({
            async: true,
            type: 'POST',
            url: bars.config.urlContent('/CreditUI/glk/RestoreGLK'),
            dataType: 'json',
            data: {
                id: archive_id
            },
            success: function(data) {
                if (CatchErrors(data)) {
                    bars.ui.alert({ text: "Відновлення успешно зроблено!" });
                    dialogGlkArchive_Body.close();
                    dialogGlkArchive.close();
                    createGLK();
                }
            }
        });
    });

    $(document).kendoTooltip({
        filter: "#klient_card",
        position: "top",
        content: "Відкрити карту клієнта"
    });

    $(document).kendoTooltip({
        filter: "#kredit_card",
        position: "top",
        content: "Відкрити кредитний договір"
    });

    $(document).kendoTooltip({
        filter: "#accounts_card",
        position: "top",
        content: "Відкрити рахунки кредитного договору"
    });
})
////////////////////////////////////////////
function createGLK() {
    TemplateDataSource("#gridGLK", '//CreditUI/glk/GetGLK/', { id: globalID }, 'FDAT', 100,
        {
            ND: { type: "number", editable: false },
            FDAT: { type: "date" },
            LIM1: { type: "number", editable: false },
            LIM2: { type: "number" },
            OST: { type: "number" },
            DEL2: { type: "number"},
            D9129: { type: "number" },
            DAYSN: { type: "string" },
            NOT_9129: { type: "number" },
            ACC: { type: "number" }
        });
}

function Adding() {
    var glk = {
        ND: globalID,
        FDAT: kendo.toString($("#FDAT").data("kendoDatePicker").value(), 'dd/MM/yyyy'),
        LIM2: $('#LIM2').val(),
        D9129: $('#D9129').val() == null ? 0 : $('#D9129').val(),
        DAYSN: ($("#DAYSN").is(':checked')) ? 1 : 0,
        UPD_FLAG: ($("#UPD_FLAG").is(':checked')) ? 1 : 0,
        NOT_9129: $('#NOT_9129').val()
    };
    if ((glk.LIM2 != "") && (glk.FDAT != null))
        AddGlk(glk, "Запис з датою <strong>" + glk.FDAT + "</strong> успішно додано<br>Оберіть іншу дату", "add");
    else
        if ((glk.LIM2 == ""))
            bars.ui.alert({ text: "Ліміт не може бути пустим!" });
        if ((glk.FDAT == null))
            bars.ui.alert({ text: "Дата не може бути пустою!" });
    
};

function createArchive() {
    TemplateDataSource("#gridGlkArchive", '/CreditUI/glk/GetArchive/', { id: globalID }, 'ID', 10,
        {
            ID: { type: "number" },
            ND: { type: "number" },
            OPER_DATE: { type: "date" },
            FIO: { type: "string" }
        });
    dialogGlkArchive.open().center();
}

function createArchive_Body() {
    TemplateDataSource("#gridGlkArchive_Body",'/CreditUI/glk/GetArchiveBody/', { id: archive_id },'FDAT',10,
        {   FDAT: { type: "date" },
            LIM2: { type: "number" },
            SUMG: { type: "number" },
            SUMO: { type: "number" },
            SUMK: { type: "number" },
            OTM: { type: "number" },
            NOT_SN: { type: "number" }
        });
     
    dialogGlkArchive_Body.open().center();
}

function AddGlk(glk,mess,mode) {
    TemplateQuery('/CreditUI/glk/AddGLK', { glkString: JSON.stringify(glk) }, (mess==null)? "Запис успішно додано" : mess, mode);
}

function EditGlk(glk) {
    TemplateQuery('/CreditUI/glk/UpdateGLK', { glkString: JSON.stringify(glk) }, "Запис успішно змінено");
}

function DeleteGlk(glk) {
    TemplateQuery('/CreditUI/glk/GroupDelete', { glkString: JSON.stringify(glk) }, "Записів видалено: " + glk.length);
}


function SetStatic(data) {
    staticData = data;
    $("#number_kd").val(data.CC_ID);
    $("#ref_kd").val(globalID);
    $("#date_start").val(data.SDATE);
    $("#rnk_name").val(data.NMK);
    $("#summ_kd").val(moneyFormat(data.SDOG));
    $("#limit").val(moneyFormat(data.LIMIT));

    createGLK();
}

function PaintRows(id) {
    var data =  $(id).data("kendoGrid").dataSource.data();
    $.each(data, function (i, row) {
        var color = (kendo.toString(row.FDAT, "dd.MM.yyyy") == staticData.BANKDATE) ? "aquaRow" : (row.FDAT < kendo.parseDate(staticData.BANKDATE)) ? "grayRow" : null; //((row.LIM1 != row.LIM2) && row.LIM2 != 0) ? "ColorRow" :
        (color != null) ? $('tr[data-uid="' + row.uid + '"] ').addClass(color) : null;
    });
}
function CheckButtons()
{
    var grid = $("#gridGLK").data("kendoGrid");
    var selected_items = grid.select();
    var selected_first = selected_items.first();
    var enable = grid.dataItem(selected_first).FDAT >= kendo.parseDate(staticData.BANKDATE);
    disabledButtons(readonly && ((selected_items.length > 0) && enable), ".k-grid-btDel");
    disabledButtons(readonly && ((selected_items.length == 1) && enable), ".k-grid-btEdit");
}

function selectArchiveBody()
{
    var grid = $("#gridGlkArchive").data("kendoGrid");
    var selected_item = grid.dataItem(grid.select());
    archive_id = selected_item.ID;
    var window = $("#dialogGlkArchive_Body").data("kendoWindow");
    window.title("Архів ГЛК за <strong>" + kendo.toString(selected_item.OPER_DATE, "dd.MM.yyyy HH:mm:ss") + "</strong>");
    createArchive_Body();
}

function TemplateQuery(url, data_input, text, mode) {
    bars.ui.loader('body', true);
    $.ajax({
        async: true,
        type: 'POST',
        url: bars.config.urlContent(url),
        dataType: 'json',
        data: data_input,
        success: function (data) {
            if (CatchErrors(data)) { bars.ui.alert({ text: text }); if(mode == null) {createGLK(); } }
        }
    });
    bars.ui.loader('body', false);
}

function TemplateDataSource(id_grid, url, data_input, model_id, pageSize,fields) {
    var grid = $(id_grid).data("kendoGrid");
    var dataSource = new kendo.data.DataSource({
        type: "aspnetmvc-ajax",
        transport: {
            read: {
                dataType: "json",
                cache: false,
                url: bars.config.urlContent(url),
                data:  data_input 
            }
        },
        schema: {
            data: "Data",
            total: "Total",
            errors: "Errors",
            model: {
                id: model_id,
                fields: fields
            }
        },
        pageSize: pageSize
    });
    grid.setDataSource(dataSource);
}